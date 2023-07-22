# -*- coding: utf-8 -*-
"""
Author:      Shutter Zor
Affiliation: School of Management, Xiamen University
Email:       Shutter_Z@outlook.com
"""



""" Python Code for Text Analysis """
# Reading .txt text
with open("TestFile.txt", "r") as file:
    Text = file.read()

# Converting all letters to lower case
Text = Text.lower()

# Replacing punctuation marks with spaces
Text = Text.replace("'", " ")
for punctuation in '!"#$%&()*+,-./:;<=>?@[\\]^_`{|}~':
    Text = Text.replace(punctuation, " ")
Text = Text.replace("\n", " ")
Text = Text.replace("\t", " ")

# Splitting words and counting word frequency
Words  = Text.split()
Counts =  {}
for word in Words:
    Counts[word] = Counts.get(word, 0) + 1

Items = list(Counts.items())
Items.sort(key = lambda x:x[0])

