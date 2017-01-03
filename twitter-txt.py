#!/usr/bin/env python
# -*- coding: utf-8 -*-
 
import tweepy, time, sys, datetime, json, commands


# Tokens are generated at https://apps.twitter.com/
with open('/root/temp-rrd/config.json') as cf:
    config = json.load(cf)
 
#enter the corresponding information from your Twitter application:
auth = tweepy.OAuthHandler(config['consumer_key'], config['consumer_secret'])
auth.set_access_token(config['access_key'], config['access_secret'])
api = tweepy.API(auth)

cmd = 'rrdtool lastupdate /home/evan/temp.rrd | tail -1'
rrdtemp = commands.getstatusoutput(cmd)

t = rrdtemp[1].split(': ')
temp = "Temp at %s: %s degrees F" % (time.strftime("%Y-%m-%d %H:%M:%S", time.localtime(int(t[0]))), t[1])

api.update_status(status=temp)
#api.update_with_media("/home/evan/temperature_3h.png", message)

