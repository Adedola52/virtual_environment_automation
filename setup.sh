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

if [ "$venv_name" == "dev_venv" ]
    then
        if [ -f "$dev_venvv" ]
            then
                echo "$(success "$venv_name environment found, activating...")" >> "$log_file"
                source "$dev_venvv"
                echo "$(success "$venv_name activated...")" >> "$log_file"

        else
            echo "$(info "$venv_name environment not found, creating $venv_name...")" >> "$log_file"
            python3 -m venv "$venv_name"
            echo "$(success "$venv_name environment created, now activating...")" >> "$log_file"
            source "$dev_venvv"
            echo "$(success "$venv_name activated...")" >> "$log_file"
        fi
elif [ "$venv_name" == "prod_venv" ]
    then
        if [ -f "$prod_venvv" ]
            then
                echo "$(success "$venv_name environment found, activating...")" >> "$log_file"
                source "$prod_venvv"
                echo "$(success "$venv_name activated...")" >> "$log_file"
        else
            echo "$(info "$venv_name environment not found, creating $venv_name....")" >> "$log_file"
            python3 -m venv "$venv_name"
            echo "$(success "$venv_name environment created, now activating $venv_name....")" >> "$log_file"
            source "$prod_venvv"
            echo "$(success "$venv_name activated...")" >> "$log_file"
        fi
else
echo "$(error "$venv_name not recognized, reconfirm you have spelt your environment name correctly...")" > "$log_file"
exit 1

fi
}

pip_upgrade () {
echo "$(info "Upgrading pip -  $venv_name environment...")" >> "$log_file"
python -m pip install --upgrade pip
echo "$(success "Pip upgraded within  $venv_name environment...")" >> "$log_file"

if [ "$venv_name" == "dev_venv" ]
    then
        echo "$(info "Installing $venv_name dependencies...")" >> "$log_file"
        pip install -r "$dev_requirements"
        echo "$(success "$venv_name Dependencies successfully installed...")" >> "$log_file"
elif [ "$venv_name" == "prod_venv" ]
    then
        echo "$(info "Installing $venv_name dependencies...")" >> "$log_file"
        pip install -r "$prod_requirements"
        echo "$(success "$venv_name Dependencies successfully  installed...")" >> "$log_file"
else
echo "$(error "$venv_name not recognized, reconfirm you have spelt your environment name correctly...")" >> "$log_file"
fi

}


ignore () {

if [ "$venv_name" == "dev_venv" ]
    then
        if [ ! -f "$dev_gitignore" ]
            then
                echo "$(info ".gitignore file does not exist within $venv_name environment, creating a .gitignore...")" >> "$log_file"
                touch "$dev_gitignore"
        else
            echo "$(warning ".gitignore exist, exiting...")" >> "$log_file"
        fi
elif [ "$venv_name" == "prod_venv" ]
    then
        if [ ! -f "$prod_gitignore" ]
            then
                echo "$(info ".gitignore file does not exist within $venv_name environment, creating a .gitignore...")" >> "$log_file"
                touch "$prod_gitignore"
        else
            echo "$(warning ".gitignore exist, exiting...")" >> "$log_file"
        fi
else
    echo "$(error "$venv_name not recognized, reconfirm you have spelt your environment name correctly...")" >> "$log_file"

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
