#! /usr/bin/env bash
 
# Chrome application
google-chrome --enable-kiosk-mode --start-maximized --disable-gpu --disable-accelerated-video --ash-force-desktop
 
# https://stackoverflow.com/questions/30209776/docker-container-will-automatically-stop-after-docker-run-d
tail -f /dev/null
