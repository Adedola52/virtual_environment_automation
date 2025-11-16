#! /bin/bash


venv_name="$1"
dev_venvv="/home/taibat/environment_bootstrapper/dev_venv/bin/activate"
prod_venvv="/home/taibat/environment_bootstrapper/prod_venv/bin/activate"
log_file="/home/taibat/environment_bootstrapper/setup.log"
dev_requirements="/home/taibat/environment_bootstrapper/dev_directory/dev_requirement.txt"
prod_requirements="/home/taibat/environment_bootstrapper/prod_directory/prod_requirement.txt"
dev_gitignore="/home/taibat/environment_bootstrapper/dev_directory/.gitignore"
prod_gitignore="/home/taibat/environment_bootstrapper/prod_directory/.gitignore"
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



