# -*- coding: utf-8 -*-
"""
Created on Tue Jul 28 21:00:01 2015

@author: Kolb
"""

# https://github.com/geopy/geopy

import geopy

from geopy.geocoders import Nominatim

geolocator = Nominatim()

 location = geolocator.geocode("Mannheim B2,1")
 
print(location.address) 
 