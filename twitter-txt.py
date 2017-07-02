#!/usr/bin/env python
# -*- coding: utf-8 -*-
 
import tweepy, time, sys, datetime, json, commands


RRD_PATH="/opt/temper-graph/"

# Tokens are generated at https://apps.twitter.com/
with open("%s/config.json" % RRD_PATH ) as cf:
    config = json.load(cf)
 
#enter the corresponding information from your Twitter application:
auth = tweepy.OAuthHandler(config['consumer_key'], config['consumer_secret'])
auth.set_access_token(config['access_key'], config['access_secret'])
api = tweepy.API(auth)

#RRD_PATH="/home/evan/"

cmd = "rrdtool lastupdate %s/temp.rrd | tail -1" % RRD_PATH
rrdtemp = commands.getstatusoutput(cmd)

t = rrdtemp[1].split(': ')
temp = "%s F" % (t[1])

try:
	result = api.update_status(status=temp)
	#print result
except tweepy.TweepError as e:
	print "%s - %s" % (temp, e.message[0])
#api.update_with_media("/home/evan/temperature_3h.png", message)

