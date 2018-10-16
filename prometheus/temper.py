from prometheus_client import start_http_server, Gauge
import random
import time
from subprocess import Popen, PIPE

room_temp_gauge = Gauge('room_temperature', 'Room Temperature (F)', ['location'])

temper_command = "/usr/bin/temperv14 -f"

def process_request():

    child = Popen(temper_command, shell=True, stdout=PIPE)
    output = child.communicate()[0]

    room_temp_gauge.labels(['shack']).set(output)    


if __name__ == '__main__':
    # Start up the server to expose the metrics.
    start_http_server(8000)
    # Generate some requests.
    while True:
        process_request()
        time.sleep(10)

