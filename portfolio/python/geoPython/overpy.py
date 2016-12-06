# -*- coding: utf-8 -*-
"""
Created on Sat Aug 29 13:52:58 2015

@author: Kolb
"""

# Using the overpass API

# http://python-overpy.readthedocs.org/en/latest/example.html

import overpy

api = overpy.Overpass()

# fetch all ways and nodes
result = api.query("""
    way(50.746,7.154,50.748,7.157) ["highway"];
    (._;>;);
    out body;
    """)

for way in result.ways:
    print("Name: %s" % way.tags.get("name", "n/a"))
    print("  Highway: %s" % way.tags.get("highway", "n/a"))
    print("  Nodes:")
    for node in way.nodes:
        print("    Lat: %f, Lon: %f" % (node.lat, node.lon))

node["name"="Gielgen"];
out body;