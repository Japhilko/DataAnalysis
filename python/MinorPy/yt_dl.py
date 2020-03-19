# Jan-Philipp kolb
# "Thu Mar 19 07:08:02 2020"
# https://spapas.github.io/2018/03/06/easy-youtube-mp3-downloading/
# https://stackoverflow.com/questions/27473526/download-only-audio-from-youtube-video-using-youtube-dl-in-python-script

from __future__ import unicode_literals
import youtube_dl


ydl_opts = {
    'format': 'bestaudio/best',
    'postprocessors': [{
        'key': 'FFmpegExtractAudio',
        'preferredcodec': 'mp3',
        'preferredquality': '192',
    }],
}

with youtube_dl.YoutubeDL(ydl_opts) as ydl:
    ydl.download(['https://www.youtube.com/watch?v=q1oy_dPD-7g'])


with youtube_dl.YoutubeDL(ydl_opts) as ydl:
    ydl.download(['https://www.youtube.com/watch?v=j0bQIEkp8qo&list=PL2ZbJGyumyCpgP76kN1Lx5WYJc950nlL8'])
