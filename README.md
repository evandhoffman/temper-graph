# temper-graph
Scripts to record and graph the ambient temperature as read from a TempER USB monitor - http://amzn.to/2iob1ca

# Usage

**Note**: to use Twitter or Slack you'll need to get authentication tokens/API keys.  I store them in `config.json` to keep them out of the scripts themselves.

* Build `temperv14.c` from [home-automation](https://github.com/silverfisk/home-automation/tree/master/temperv14).  On Ubuntu this will likely require `apt-get install libusb-dev`.  Once built, copy temperv14 to `/usr/bin`.
* `apt-get install rrdtool` to install rrdtool.
* Run `create-rrd.sh` to generate the RRD file.
* `update-temperature.sh` gets the temperature (in Fahrenheit) and adds it to the RRD.  Recommended cron: `* * * * *`. **Requires `root`**
* `update-graph.sh` builds graphs based on the data in the RRD. Recommended cron: `* * * * *`
* `twitter.py` posts your chart to Twitter using [tweepy](http://www.tweepy.org/).  Recommended cron: `0 */3 * * *`
* `twitter-txt.py` posts the temperature to twitter, as text (pulled from the RRD).  Recommended cron: `*/10 * * * *`
* `slack.py` posts your chart to Slack using [Slacker](https://github.com/os/slacker).  Recommended cron: `0 * * * *`

