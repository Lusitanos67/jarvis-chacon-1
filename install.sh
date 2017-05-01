#!/usr/bin/env bash

# Used tutorials:
#  - Wiring Pi install: http://wiringpi.com/download-and-install/
#  - Chacon sender program: https://arno0x0x.wordpress.com/2015/04/02/rf433-outlet/

# Get plugin directory
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Check if Wiring Pi already installed
result_wiring_pi_installed=`gpio -v`
if [[ ! $result_wiring_pi_installed =~ "gpio version:" ]]; then
  # Delete potential previous version of Wiring Pi (this should never happens)
  sudo apt-get purge wiringpi
  hash -r

  # Install last version of Wiring Pi
  rm -rf /tmp/wiringPi
  git clone git://git.drogon.net/wiringPi /tmp/wiringPi
  /tmp/wiringPi/build
  rm -rf /tmp/wiringPi
fi

# Install G++ (compiler)
[[ -z $(which g++) ]] && sudo apt-get --yes --force-yes install g++

# Compile "chacon_send" program
g++ -o $dir/chacon_send $dir/chacon_send.cpp -lwiringPi
