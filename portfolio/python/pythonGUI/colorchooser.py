# -*- coding: utf-8 -*-
"""
Created on Tue Apr 19 13:40:50 2016

@author: Jan-Philipp Kolb
"""

# source: http://www.python-kurs.eu/tkinter_dialoge.php

from Tkinter import *
from tkColorChooser import askcolor                  

def callback():
    result = askcolor(color="#6A9662", 
                      title = "Bernd's Colour Chooser") 
    print result
    
root = Tk()
Button(root, 
       text='Choose Color', 
       fg="darkgreen", 
       command=callback).pack(side=LEFT, padx=10)
Button(text='Quit', 
       command=root.quit,
       fg="red").pack(side=LEFT, padx=10)
mainloop()