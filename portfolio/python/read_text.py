# -*- coding: utf-8 -*-
"""
Created on Tue May 10 21:13:47 2016

@author: Jan-Philipp Kolb
"""

import urllib

def read_text():
    text = open("D:\github\DataAnalysis\portfolio\python\SomeText.txt")
    contents_of_file = text.read()
    print(contents_of_file)
    text.close()
    check_profanity(contents_of_file)

def check_profanity(text_to_check):
    text_to="shit"
    connection = urllib.request.urlopen("www.wdylike.appspot.com/?q=wtf")
    output =connection.read()
    print(output)
    connection.close()
    
    
check_profanity(read_text())