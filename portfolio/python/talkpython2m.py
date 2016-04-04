# -*- coding: utf-8 -*-
"""
Created on Wed Mar 23 13:45:14 2016

@author: ntuser
"""

# https://talkpython.fm/episodes/all

#https://talkpython.fm/episodes/show/19/automate-the-boring-stuff-with-python

import PyPDF2

pdfFileObj = open('useR2015-BookOfAbstracts.pdf', 'rb')

pdfReader = PyPDF2.PdfFileReader(pdfFileObj)

pdfReader.numPages

pageObj = pdfReader.getPage(0)
pageObj.extractText()
#---------------------------------------------#

# http://neckbeardrepublic.com/screencasts/pandas-vincent