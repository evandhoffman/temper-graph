#!/usr/bin/env python
# -*- coding: utf-8 -*-
 
import tweepy, time, sys, datetime, json, os


# Tokens are generated at https://apps.twitter.com/
with open('/root/temp-rrd/config.json') as cf:
    config = json.load(cf)
 
filename = sys.argv[1]
 
#enter the corresponding information from your Twitter application:
auth = tweepy.OAuthHandler(config['consumer_key'], config['consumer_secret'])
auth.set_access_token(config['access_key'], config['access_secret'])
api = tweepy.API(auth)

message = "%s @ %s" % (os.path.basename(filename), '{:%Y-%m-%d %H:%M:%S}'.format(datetime.datetime.now()))
 
api.update_with_media(filename,  message)
