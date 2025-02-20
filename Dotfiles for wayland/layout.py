#!/usr/bin/env -S python3 -u

import time
import i3ipc

KBD_NAME = "2522:37008:A4TECH_USB_Device_System_Control"

sway = i3ipc.Connection()

while True:
	inputs = sway.get_inputs()
	for k in inputs:
		print(k)
		print(k['type'])
	cc = [i for i in inputs if i['type'] == 'keyboard'][0]
	keyboard = [i for i in inputs if i['identifier'] == KBD_NAME][0]
	layout = keyboard['xkb_active_layout_name']
	print(layout[:2].lower())
	time.sleep(1)
