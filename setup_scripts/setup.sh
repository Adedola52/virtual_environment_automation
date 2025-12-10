#! /bin/bash
set -e

source helpers.sh

install_python3 () {

if ! dpkg -s python3.10-venv &> /dev/null
    then
        echo "$(info "python3 venv not found, installing python3.10-venv...")" > "$log_file"
        sudo apt update
        sudo apt install python3.10-venv
else
    echo "$(success "python3.10-venv already installed")" > "$log_file"

fi

}

create_venv () {

if [ "$venv_name" == "notification_venv" ]
    then
        if [ -f "$activate_file" ]
            then
                echo "$(success "$venv_name environment found, activating...")" >> "$log_file"
                source "$activate_file" >> "$log_file" 2>&1
                echo "$(success "$venv_name activated...")" >> "$log_file"

        else
            echo "$(info "$venv_name environment not found, creating $venv_name...")" >> "$log_file"
            python3 -m  venv "$venv_name">> "$log_file" 2>&1
            echo "$(success "$venv_name environment created, now activating...")" >> "$log_file"
            source "$activate_file" >> "$log_file" 2>&1
            echo "$(success "$venv_name activated...")" >> "$log_file"
        fi
elif [ "$venv_name" == "payments_venv" ]
    then
        if [ -f "$activate_file" ]
            then
                echo "$(success "$venv_name environment found, activating...")" >> "$log_file"
                source "$activate_file" >> "$log_file" 2>&1
                echo "$(success "$venv_name activated...")" >> "$log_file"
        else
            echo "$(info "$venv_name environment not found, creating $venv_name....")" >> "$log_file"
            python3 -m venv "$venv_name" >> "$log_file" 2>&1
            echo "$(success "$venv_name environment created, now activating $venv_name....")" >> "$log_file"
            source "$activate_file" >> "$log_file" 2>&1
            echo "$(success "$venv_name activated...")" >> "$log_file"
        fi
else
echo "$(error "$venv_name not recognized, reconfirm you have spelt your environment name correctly...")" > "$log_file"
exit 1

fi
}

pip_upgrade () {
echo "$(info "Upgrading pip -  $venv_name environment...")" >> "$log_file"
python3 -m pip install --upgrade pip >> "$log_file" 2>&1
echo "$(success "Pip upgraded within  $venv_name environment...")" >> "$log_file"

if [ "$venv_name" == "notification_venv" ]
    then
        echo "$(info "Installing $venv_name dependencies...")" >> "$log_file"
        pip install -r "$notification_requirements" >> "$log_file" 2>&1
        echo "$(success "$venv_name Dependencies successfully installed...")" >> "$log_file"
elif [ "$venv_name" == "payments_venv" ]
    then
        echo "$(info "Installing $venv_name dependencies...")" >> "$log_file"
        pip install -r "$payments_requirements" >> "$log_file" 2>&1
        echo "$(success "$venv_name Dependencies successfully  installed...")" >> "$log_file"
else
echo "$(error "$venv_name not recognized, reconfirm you have spelt your environment name correctly...")" >> "$log_file"
fi

}


ignore () {

if [ ! -f "$gitignore" ]
    then
        echo "$(info ".gitignore file does not exist, creating a .gitignore...")" >> "$log_file"
        touch "$gitignore" >> "$log_file" 2>&1
    else
        echo "$(warning ".gitignore exist, exiting...")" >> "$log_file"
fi

}


main () {

install_python3
create_venv
pip_upgrade
ignore
echo "$(success "$venv_name environment ready for use ...")" >> "$log_file"

}

main
