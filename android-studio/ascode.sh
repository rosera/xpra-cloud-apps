#! /usr/bin/env bash
 
# Android application
/usr/local/android-studio/bin/studio.sh
 
# https://stackoverflow.com/questions/30209776/docker-container-will-automatically-stop-after-docker-run-d
tail -f /dev/null
