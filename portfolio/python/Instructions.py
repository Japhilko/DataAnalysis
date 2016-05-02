# -*- coding: utf-8 -*-
"""
Created on Mon May  2 21:40:11 2016

@author: Jan-Philipp Kolb
"""

import turtle

def draw_square(some_turtle):
    for i in range(1,5):
        some_turtle.forward(100)
        some_turtle.right(90)


def draw_art():
    window = turtle.Screen()
    window.bgcolor("blue")
    brad = turtle.Turtle()
    brad.shape("turtle")
    brad.color("red")
    brad.speed(1)
    for i in range (1,100):
        draw_square(brad)
        brad.right(10)
            
#    angie = turtle.Turtle()
#    angie.shape("arrow")
#    angie.color("green")
#    angie.circle(100)
#    window.exitonclick()
    
draw_art()