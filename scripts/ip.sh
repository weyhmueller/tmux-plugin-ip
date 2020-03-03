#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/helpers.sh"

# please note: this plugin is adjusted for my laptop only right now (thinkpad t470s, Ubuntu 17.10)
# it may be improved in the future

function get_os() {
  OS=$(uname -s)
}

function get_ip_wlan_Linux() {
  ip="$(ifconfig | grep wlp3s0 -A1 | awk '{print $2}' | tail -n1)"
  if [[ $ip != *"."* ]]; then
    ip=""
  fi
}

function get_ip_eth_Linux() {
  ip="$(ifconfig | grep enp -A1 | awk '{print $2}' | tail -n1)"
  if [[ $ip != *"."* ]]; then
    ip=""
  fi
}


function get_ip_wlan_Darwin() {
  ip="$(ifconfig en0 | grep "inet " | awk '{print $2}' | tail -n1)"
  if [[ $ip != *"."* ]]; then
    ip=""
  fi
}

function get_ip_eth_Darwin() {
  ip="$(ifconfig | grep "inet " | awk '{print $2}' | tail -n1)"
  if [[ $ip != *"."* ]]; then
    ip=""
  fi
}

function print_ip() {
  get_os
  get_ip_wlan_${OS}
  if [ ! -z "$ip" ]; then
    echo "$ip"
  else
    get_ip_eth_${OS}
    if [ ! -z "$ip" ]; then
      echo $ip
    else
      echo "not connected"
    fi
  fi
}

main() {
  print_ip
}

main
