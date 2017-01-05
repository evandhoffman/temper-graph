#!/usr/bin/env python
# -*- coding: utf-8 -*-
 
import tweepy, time, sys, datetime, json

RRD_PATH="/root/temper-graph/"
IMG_PATH="/var/www/html/temperature/"

# Tokens are generated at https://apps.twitter.com/
with open('%s/config.json' % RRD_PATH) as cf:
    config = json.load(cf)
 
#enter the corresponding information from your Twitter application:
auth = tweepy.OAuthHandler(config['consumer_key'], config['consumer_secret'])
auth.set_access_token(config['access_key'], config['access_secret'])
api = tweepy.API(auth)

message = "Temperature as of %s" % '{:%Y-%m-%d %H:%M:%S}'.format(datetime.datetime.now())
 
api.update_with_media("%s/temperature_3h.png" % IMG_PATH, message)

