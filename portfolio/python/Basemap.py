# -*- coding: utf-8 -*-
"""
Created on Sat Aug 29 14:05:43 2015

@author: Kolb
"""

# http://stackoverflow.com/questions/11487797/python-matplotlib-basemap-overlay-small-image-on-map-plot

from matplotlib import pyplot as plt
from mpl_toolkits.basemap import Basemap
import Image
from numpy import arange

lats = arange(26,29,0.5)
lons = arange(-90,-87,0.5)

m = Basemap(projection='cyl',llcrnrlon=min(lons)-2,llcrnrlat=min(lats)-2,
            urcrnrlon=max(lons)+2,urcrnrlat=max(lats)+2,resolution='i')

x,y = m(lons,lats)
u,v, = arange(0,51,10),arange(0,51,10)
barbs = m.barbs(x,y,u,v)
m.drawcoastlines(); m.drawcountries(); m.drawstates()
