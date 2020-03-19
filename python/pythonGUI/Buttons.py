# -*- coding: utf-8 -*-
"""
Created on Tue Apr 19 13:09:57 2016

@author: Jan-Philipp Kolb
"""

# Source: http://www.python-kurs.eu/tkinter_buttons.php

from tkinter import *
class App:
  def __init__(self, master):
    frame = Frame(master)
    frame.pack()
    self.button = Button(frame, 
                         text="QUIT", fg="red",
                         command=frame.quit)
    self.button.pack(side=LEFT)
    self.slogan = Button(frame,
                         text="Hello",
                         command=self.write_slogan)
    self.slogan.pack(side=LEFT)
  def write_slogan(self):
    print ("Tkinter is easy to use!")

root = Tk()
app = App(root)
root.mainloop()