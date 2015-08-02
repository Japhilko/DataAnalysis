# -*- coding: utf-8 -*-
"""
Created on Sun Aug 02 13:15:37 2015

@author: Kolb
"""

# http://matplotlib.org/basemap/users/examples.html
from mpl_toolkits.basemap import Basemap
import matplotlib.pyplot as plt
import numpy as np

map = Basemap(projection='ortho',lat_0=45,lon_0=-100,resolution='l')

#############################################################

# import pyproj



# Links

# http://de.slideshare.net/mishok13/making-use-of-openstreetmap-data-with-python