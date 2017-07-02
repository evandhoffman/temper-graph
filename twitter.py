#!/usr/bin/env python
# -*- coding: utf-8 -*-
 
import tweepy, time, sys, datetime, json, os

RRD_PATH="/opt/temper-graph/"
IMG_PATH="/var/www/html/temperature/"

# Tokens are generated at https://apps.twitter.com/
with open('%s/config.json' % RRD_PATH) as cf:
    config = json.load(cf)
 
filename = sys.argv[1]
 
#enter the corresponding information from your Twitter application:
auth = tweepy.OAuthHandler(config['consumer_key'], config['consumer_secret'])
auth.set_access_token(config['access_key'], config['access_secret'])
api = tweepy.API(auth)

message = "%s @ %s" % (os.path.basename(filename), '{:%Y-%m-%d %H:%M:%S}'.format(datetime.datetime.now()))


if (filename.endswith('png')): 
	api.update_with_media(filename,  message)

if(filename.endswith('mp4')):
	media = api.upload_chunked(filename)
	api.update_status(status=message, media_ids=[media.media_id])
