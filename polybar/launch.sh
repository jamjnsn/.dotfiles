#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

launch_bar() {
	# Terminate already running bar instances
	killall -q polybar

	# Wait until the processes have been shut down
	while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

	# Launch the bar
	polybar -c $SCRIPT_DIR/config.ini top & \
	polybar -c $SCRIPT_DIR/config.ini bottom
}

launch_bar
