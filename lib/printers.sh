#!/bin/bash

# Colors
BLINK="\e[5m"
COL_RESET="\e[0m"
COL_RED="\e[31m"
COL_GREEN="\e[32m"
COL_YELLOW="\e[33m"
COL_BLUE="\e[34m"
COL_MAGENTA="\e[35m"
COL_CYAN="\e[36m"
COL_LIGHT_GREY="\e[37m"
COL_DARK_GREY="\e[90m"
COL_LIGHT_RED="\e[91m"
COL_LIGHT_GREEN="\e[92m"
COL_LIGHT_YELLOW="\e[93m"
COL_LIGHT_BLUE="\e[94m"
COL_LIGHT_MAGENTA="\e[95m"
COL_LIGHT_CYAN="\e[96m"

# Printer helpers
function action() {
  echo -e "$COL_BLUE[action]:$COL_RESET "$1
}

function error() {
  echo -e "$COL_RED[error]:$COL_RESET "$1
}

function ok() {
  echo -e "$COL_GREEN[ok]:$COL_RESET "$1
}

function warn() {
  echo -e "$COL_YELLOW[error]:$COL_RESET "$1
}
