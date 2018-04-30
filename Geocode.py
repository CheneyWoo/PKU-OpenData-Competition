# -*- coding: utf-8 -*-
"""
Created on Wed Feb 21 20:53:30 2018

@author: lenovo
"""

import pandas
import requests
import time

def sleeptime(hour,min,sec):
    return hour*3600 + min*60 + sec


second = sleeptime(0,0,5)


def geocodeB(address):
    base = "http://api.map.baidu.com/geocoder/v2/?address=" + address + "&output=json&ak=OKWAWaari951BdpxcQNvz1p8KUZ9nGLE"
    response = requests.get(base)
    answer = response.json()
    return answer['result']['location']['lng'],answer['result']['location']['lat']


datab = pandas.read_excel('/Users/CheneyWu/Downloads/Trans_2012-2016.xlsx')
database = datab.ad

geocode = []
for i in range(19,25):
    time.sleep(second)
    for j in range(200*i,200*i+200):
        address = datab.ad[j]
        try:
            geocode.append(geocodeB(address))
        except:
            geocode.append('ConnectionError)')
print(geocode)