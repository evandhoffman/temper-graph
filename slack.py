#!/usr/bin/env python/
# -*- coding: utf-8 -*-
 
import slacker, time, sys, datetime, json, ntpath, os.path, commands


# Tokens are generated at https://apps.twitter.com/
with open('/root/temp-rrd/config.json') as cf:
    config = json.load(cf)

slack = slacker.Slacker(config['slack_api_key'])

filename = sys.argv[1]
 
if (os.path.isfile(filename)):
	message = "Temperature as of %s \n %s" % ('{:%Y-%m-%d %H:%M:%S}'.format(datetime.datetime.now()), ntpath.basename(filename))
 
	response = slack.files.upload(filename, title=message, channels='#eh_tempbot')

	print response
else:
	RRD_PATH="/home/evan/"

	cmd = "rrdtool lastupdate %s/temp.rrd | tail -1" % RRD_PATH
	rrdtemp = commands.getstatusoutput(cmd)

	t = rrdtemp[1].split(': ')
	temp = "%s °F" % (t[1])

	degrees = float(t[1])
	degrees_c = (degrees - 32 ) * (5.0 / 9.0)

	if (degrees < 69):
		color = "warning"
		emoji = ":snowman:"

	elif (degrees < 74):
		color = "good"
		emoji = ":thumbsup:"
	elif (degrees < 78):
		color = "warning"
		emoji = ":beach_with_umbrella:"
	else: 
		color = "danger"
		emoji = ":skull_and_crossbones:"

	a = { "fallback":temp, "color": color, "text":temp+ " /  " + "%.2f °C" % degrees_c + " "  + emoji }
	

	slack.chat.post_message(channel='#eh_tempbot', username='TempBot', attachments=[a], text="")



