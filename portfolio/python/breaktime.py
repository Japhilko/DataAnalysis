# -*- coding: utf-8 -*-
"""
Created on Sun May  1 09:46:11 2016

@author: Jan-Philipp Kolb
"""

import webbrowser
import time

time.ctime()

count=0
while count <2:
    time.sleep(10)
    webbrowser.open("https://www.youtube.com/watch?v=PpLNcFW7-eY")
    count = count+1