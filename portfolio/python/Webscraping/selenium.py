# -*- coding: utf-8 -*-
"""
Created on Fri Apr 22 09:03:36 2016

@author: Jan-Philipp Kolb
"""

# https://www.youtube.com/watch?v=IJewV7o1bwU

# !pip install selenium
from selenium import webdriver
browser = webdriver.Firefox()
browser.get('https://automatetheboringstuff.com')

# elem = browser.find_element_by_css_selector('.entry-content > o1:nth-child(15) > li:nth-child(1) > a:nth-child(1)')

elem = browser.find_element_by_css_selector('')