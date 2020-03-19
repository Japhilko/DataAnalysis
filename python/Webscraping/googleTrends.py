# -*- coding: utf-8 -*-
"""
Created on Wed Dec 02 22:55:53 2015

@author: Kolb
"""

import datetime
import gtrends

username = "myGoogleUsername"
password = "myGooglePassword"

terms = ["foo", "bar", "baz"]
startDt = datetime.datetime(year=2015, month=1, day=1)
endDt = datetime.datetime(year=2015, month=2, day=1)

trends = gtrends.collectTrends(username, password, terms, startDt, endDt)