#!/bin/sh


tail -f --retry -n 12 /tmp/log &
echo somefin
echo eqrwelkjhwe >> /tmp/log
echo somefin2

echo 22eqrwelkjhwe >> /tmp/log
apt-get update >> /tmp/log
echo somefin3
