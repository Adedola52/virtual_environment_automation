#! /bin/bash

venv_name="$1"
activate_file="/home/taibat/environment_bootstrapper/$venv_name/bin/activate"
log_file="/home/taibat/environment_bootstrapper/setup.log"
notification_requirements="/home/taibat/environment_bootstrapper/notification_directory/requirement.txt"
payments_requirements="/home/taibat/environment_bootstrapper/payments_directory/requirement.txt"
gitignore="/home/taibat/environment_bootstrapper/.gitignore"
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
RESET="\033[0m"

timestamp() {
    date '+%Y-%m-%d %H:%M:%S'
}

info() {
    echo -e "[${BLUE}INFO${RESET}] $(timestamp): $1"
}

warning() {
    echo -e  "[${YELLOW}WARNING${RESET}] $(timestamp): $1 "
}

error() {
    echo -e "[${RED}ERROR${RESET}] $(timestamp): $1 "
}

success() {
    echo -e  "[${GREEN}SUCCESS${RESET}] $(timestamp): $1 "
}
