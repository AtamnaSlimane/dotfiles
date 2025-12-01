#!/bin/sh

state=$(rmpc status | sed -n 's/.*"state":"\([^"]*\)".*/\1/p')

if [ "$state" = "Play" ]; then
    rmpc pause
else
    rmpc play
fi
