#!/bin/bash
PARSER=../parser3

cd "$(dirname "${BASH_SOURCE[0]}")"

killall parser3 2>/dev/null
sleep 1

"$PARSER" prepare.html
rm -f logs/*.log logs/metrics.json

"$PARSER" dispatcher.html instance1 > /dev/null 2>&1 &
"$PARSER" monitor.html instance1 > /dev/null 2>&1 &
"$PARSER" monitor.html instance2 > /dev/null 2>&1 &
"$PARSER" alerter.html > /dev/null 2>&1 &
disown -a
