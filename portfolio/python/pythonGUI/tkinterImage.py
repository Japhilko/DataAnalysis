# -*- coding: utf-8 -*-
"""
Created on Tue Apr 19 12:42:59 2016

@author: Jan-Philipp Kolb
"""

# source: http://www.python-kurs.eu/tkinter_labels.php

from tkinter import *

root = Tk()

v = IntVar()

logo = PhotoImage(file="images/256px-Openstreetmap_logo.svg.png")
w1 = Label(root, image=logo).pack(side="right")
explanation = """
OpenStreetMap GUI
"""
w2 = Label(root, 
           justify=LEFT,
           padx = 10, 
           text=explanation).pack(side="left")
           
Radiobutton(root, 
            text="Overpass API",
            padx = 20, 
            variable=v, 
            value=1).pack(anchor=W)
Radiobutton(root, 
            text="Osmosis API",
            padx = 20, 
            variable=v, 
            value=2).pack(anchor=W)           
           

root.mainloop()