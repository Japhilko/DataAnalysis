# -*- coding: utf-8 -*-
"""
Created on Wed Jul 29 20:38:44 2015

@author: Kolb
"""

import plotly.plotly as py
from plotly.graph_objs import *

import numpy as np
x = np.random.randn(500)

data = Data([
    Histogram(
        x=x
    )
])
plot_url = py.plot(data, filename='basic-histogram')