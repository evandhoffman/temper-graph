from prometheus_client import start_http_server, Gauge
import random
import time
from subprocess import Popen, PIPE


temper_command = "/usr/bin/temperv14 -f"

def get_room_temp_gauge():
    return Gauge('room_temperature', 'Room Temperature (F)', ['location'])

def process_request():

    try:
        child = Popen(temper_command, shell=True, stdout=PIPE)
        output = child.communicate()[0]

        if (float(output) > 0 and float(output) < 120):
            room_temp_gauge.labels('shack').set(output)

    except Exception as e:
        print("Exception getting/setting temperature: %s" % e)

room_temp_gauge = get_room_temp_gauge()

if __name__ == '__main__':
    # Start up the server to expose the metrics.
    start_http_server(80)
    # Generate some requests.
    while True:
        process_request()
        time.sleep(120)

