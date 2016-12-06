# -*- coding: utf-8 -*-
"""
Created on Sun Sep 13 21:20:03 2015

@author: Kolb
"""

# http://python-overpy.readthedocs.org/en/latest/example.html


import overpy

api = overpy.Overpass()

result = api.query("node(50.745,7.17,50.75,7.18);out;")

len(result.nodes)


result2 = api.query("node[\"name\"=\"Gielgen\"];out skel;")

len(result2.nodes)


result3 = api.query("node(50.745,7.17,50.75,7.18);out ;")


#----------------------------------------------#
# Change the working directory
#----------------------------------------------#


# http://stackoverflow.com/questions/1810743/how-to-set-the-current-working-directory-in-python
import os
path = "C:/Forschung/GeoInformation/data/"
os.chdir(path)

#----------------------------------------------#
# Write xml to file
#----------------------------------------------#

# http://mussol.org/2013/07/26/parsing-and-building-xml-files-with-python/

from xml.etree import ElementTree
from xml.etree.ElementTree import Element
from xml.etree.ElementTree import SubElement


# https://docs.python.org/2/library/xml.etree.elementtree.html
help(tree.write)


  
result.write("Gielgen.xml","w")

output_file = open( 'result2.xml', 'w' )
output_file.write( result2 ) 
output_file.close()


# http://stackoverflow.com/questions/9912578/how-to-save-an-xml-file-to-disk-with-python
file_handle = open("Gielgen.xml","wb")
result2.writexml(file_handle)
file_handle.close()

#http://logix4u.net/component/content/article/27-tutorials/44-how-to-create-windows-executable-exe-from-python-script