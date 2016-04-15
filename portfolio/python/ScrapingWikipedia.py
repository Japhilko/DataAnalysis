# -*- coding: utf-8 -*-
"""
Created on Fri Apr 15 09:37:19 2016

@author: ntuser
"""

# http://stackoverflow.com/questions/10729116/adding-a-module-specifically-pymorph-to-spyder-python-ide
# !pip install wikipedia
import wikipedia
import os


zik = wikipedia.search("Zika")

zik = wikipedia.page("Zika virus")

zik.content

#----------------------------------------------------#

# http://bandgap.cs.rice.edu/classes/comp140/resources/Python%20HowTos/How%20do%20I%20set%20the%20working%20directory%20in%20Python.aspx
os.getcwd()

os.chdir("D:\GESIS\projects\Infections")
file = open("Zika.txt", "w")

file.write(zik.content)
