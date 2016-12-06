# -*- coding: utf-8 -*-
"""
Created on Sat Aug 29 13:37:16 2015

@author: Kolb
"""

# http://www.pysal.org/users/tutorials/intro.html

import pysal
help(pysal)

w=pysal.lat2W()

shp = pysal.open('C:\Users\Kolb\Dropbox\RForschung\SpatialMannheim\data\LUX_adm1.shp')

shp.next()

len(shp)

shp.get(len(shp)-1).id

