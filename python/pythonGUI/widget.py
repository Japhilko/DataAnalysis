# -*- coding: utf-8 -*-
"""
Created on Tue Apr 19 13:06:19 2016

@author: Jan-Philipp Kolb
"""

# Source: http://www.python-kurs.eu/tkinter_message_widget.php

from tkinter import *
master = Tk()
whatever_you_do = "Whatever you do will be insignificant, but it is very important that you do it.\n(Mahatma Gandhi)"
msg = Message(master, text = whatever_you_do)
msg.config(bg='lightgreen', font=('times', 24, 'italic'))
msg.pack( )
mainloop( )