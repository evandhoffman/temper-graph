#!/usr/bin/env python
# -*- coding: utf-8 -*-
 
import slacker, time, sys, datetime, json, ntpath


# Tokens are generated at https://apps.twitter.com/
with open('/root/temp-rrd/config.json') as cf:
    config = json.load(cf)

slack = slacker.Slacker(config['slack_api_key'])

filename = sys.argv[1]
 
message = "Temperature as of %s \n %s" % ('{:%Y-%m-%d %H:%M:%S}'.format(datetime.datetime.now()), ntpath.basename(filename))
 
response = slack.files.upload(filename, title=message, channels='#eh_tempbot')

print response

