#!/usr/bin/env python
"""
Convert video file(webm, mp4, etc.) into audio file(mp3) by ffmpeg/libav.


This script requires ffmpeg or libav, install requirements on Ubuntu
    sudo apt-get install ffmpeg
or
    sudo apt-get install libav-tool

Install requirements on OS X

    brew install ffmpeg
    brew install libav

See also
- http://askubuntu.com/questions/432542/is-ffmpeg-missing-from-the-official-repositories-in-14-04
- https://github.com/rg3/youtube-dl
"""
import sys
import os
import platform
import distutils.spawn
import logging
import urllib2
import traceback

logger = logging.getLogger(name=__name__)
fmt = logging.Formatter('%(asctime)s %(levelname)s: %(pathname)s:%(lineno)d %(message)s')
handler = logging.StreamHandler()
handler.setFormatter(fmt=fmt)
logger.addHandler(handler)

PROCESS_VIDEO_EXTS = (
    '.mkv', '.webm', '.ogg', '.m4a', '.mp4'
)

DEFUALT_AUDIO_EXT = '.mp3'

def install_requirements():
    arch = platform.architecture()[0]
    expected_arches = ("32bit", "64bit")
    if arch not in expected_arches:
        logger.warn("got unexpectd architecture {arch}".format(arch=arch))
        return

    s = "https://ffmpeg.zeranoe.com/builds/win32/static/ffmpeg-20180211-8b154cb-win{arch}-static.zip"
    url = s.format(arch=arch.replace("bit", ""))

    file_dst = None
    system = platform.system().lower()
    if system == "windows":
        # path_pf = os.environ.get("ProgramFiles")
        path_pf = "d:/Program Files"
        if not path_pf:
            logger.error(msg="get environment ProgramFiles failed on platform {system}".format(
                system=system
            ))
            sys.exit(1)

        file_dst = os.path.join(path_pf, os.path.basename(url))
    elif system.startswith("cygwin"):
        path_pf = "/cygdrive/d/Program Files/"
        file_dst = os.path.join(path_pf, os.path.basename(url))
    else:
        logger.warn(msg="not support platform {system}".format(system=system))
        return

    fetch_file(url=url, file_dst=file_dst)



def download_from_url(url, dst):
    """
    @param: url to download file
    @param: dst place to put the file

    Original https://gist.github.com/wy193777/0e2a4932e81afc6aa4c8f7a2984f34e2
    """
    import requests
    from tqdm import tqdm
    # import urlopen

    req = requests.head(url)

    # file_size = int(urlopen(url).info().get('Content-Length', -1))
    file_size = int(req.headers.get('Content-Length', -1))
    if os.path.exists(dst):
        first_byte = os.path.getsize(dst)
    else:
        first_byte = 0
    if first_byte >= file_size:
        return file_size
    header = {"Range": "bytes=%s-%s" % (first_byte, file_size)}
    pbar = tqdm(
        total=file_size, initial=first_byte,
        unit='B', unit_scale=False, desc=url.split('/')[-1])
    req = requests.get(url, headers=header, stream=True)
    with(open(dst, 'ab')) as f:
        for chunk in req.iter_content(chunk_size=1024):
            if chunk:
                f.write(chunk)
                pbar.update(1024)
    pbar.close()
    return file_size


def fetch_file(url, file_dst):
    logger.info(msg='{url} => "{file_dst}"'.format(url=url, file_dst=file_dst))

    parent = os.path.dirname(file_dst)
    if not os.path.exists(parent):
        os.makedirs(parent)

    try:
        download_from_url(url=url, dst=file_dst)
    except:
        traceback.print_exc(file=sys.stderr)

        response = urllib2.urlopen(url)
        body = response.read()

        with open(file_dst, "wb") as writer:
            writer.write(body)


def get_conv_bin():
    conv_bin_fullpath = distutils.spawn.find_executable('ffmpeg') or distutils.spawn.find_executable('avconv')
    return conv_bin_fullpath

def main(args):
    if args.install:
        conv_bin_fullpath = get_conv_bin()
        if conv_bin_fullpath is None:
            install_requirements()
        else:
            logger.debug(msg="{conv_bin_fullpath} found".format(conv_bin_fullpath=conv_bin_fullpath))
    elif args.src:
        convert(src=args.src, dst=args.dst)


def convert(src, dst):
    src = os.path.realpath(src)

    if os.path.isfile(src):
        fn, ext = os.path.splitext(src)
        if ext not in PROCESS_VIDEO_EXTS:
            logger.warn(msg="expected media file ext in {exts}, got {ext}".format(
                exts=",".join(PROCESS_VIDEO_EXTS),
                ext=ext,
            ))
            return

        file_src = src

        if not dst:
            parent = os.path.realpath(src)
            dst_fullname = fn + DEFUALT_AUDIO_EXT
            file_dst = os.path.join(parent, dst_fullname)

        convert_file(file_src=file_src, file_dst=file_dst)

    elif os.path.isdir(src):
        for folder_src in args:
            folder_src = os.path.realpath(folder_src)
            for root, _, files in os.walk(folder_src):
                for file_name in files:

                    fn, ext = os.path.splitext(file_name)
                    if ext not in PROCESS_VIDEO_EXTS:
                        continue

                    file_src = os.path.join(root, file_name)
                    file_dst = fn + DEFUALT_AUDIO_EXT

                    convert_file(file_src=file_src, file_dst=file_dst)

def convert_file(file_src, file_dst):
    folder_dst_parent = os.path.dirname(file_dst)
    if os.path.exits(folder_dst_parent):
        os.makedirs(folder_dst_parent)

    if os.path.exists(file_dst):
        msg = "destination file already exists, skip"
        logger.info(msg)
        return

    conv_bin_fullpath = get_conv_bin()
    cmd = '%s -i "%s" -b:a 48K -vn "%s"' % (conv_bin_fullpath, file_src, file_dst)
    logger.info(cmd)
    os.system(cmd)

if __name__ == '__main__':
    import argparse
    parser = argparse.ArgumentParser(description="Convert video file(webm, mp4, etc.) into audio file(mp3) by ffmpeg/libav.")

    levels_int = [i for i in logging._levelNames.keys() if isinstance(i, int)]
    levels_int = sorted(levels_int)
    log_levels = ', '.join([logging.getLevelName(i).lower() for i in levels_int])
    parser.add_argument("--loglevel",
        default=logging.getLevelName(logging.INFO),
        help="default level is debug, available are {levels}".format(levels=log_levels),
    )
    parser.add_argument("--debug",
        action="store_true",
        default=False,
        help="set log level to debug, default is False",
    )

    parser.add_argument("--src",
        help="full path to a media file or folder",
        )

    parser.add_argument("--dst",
        help="full path to output file or folder, default is related to src",
        )

    parser.add_argument("--install",
        action="store_true",
        help="install requirements",
    )

    args = parser.parse_args()

    if args.loglevel:
        logger.setLevel(logging._levelNames[args.loglevel.upper()])
    if args.debug:
        logger.setLevel(logging.DEBUG)

    if args.install or args.src:
        main(args=args)
    else:
        parser.print_usage()
