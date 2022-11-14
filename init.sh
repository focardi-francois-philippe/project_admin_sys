#!/bin/bash

RED_COLOR="\033[1;31m";
BLUE_COLOR="\033[1;34m";
GREEN_COLOR="\033[1;32m";
NO_COLOR="\033[0m";


help () {
    echo -e "${GREEN_COLOR}gensite init:${NO_COLOR}";
    echo;
    echo -e "\tgensite init {project_name} {path}";
    echo -e "\t\t{path} : Optional (default path is current folder)";
    echo
}

init_project () {
    project_name=$2
    [[ -n $3 ]] && path="$3" || path="$(PWD)" # Affect default value to path if not specified

    project_path="${path}/${project_name}"

    echo "Initialising project here : $project_path"
    mkdir $project_path
    touch "$project_path/.gensite"
    echo "Project Name : ${project_name}" >> $project_path/.gensite
    echo "Project Path : ${project_path}" >> $project_path/.gensite

    # Pull template
    curl https://raw.githubusercontent.com/malo2b/project_admin_sys_template/master/index.html >> $project_path/index.html
    curl https://raw.githubusercontent.com/malo2b/project_admin_sys_template/master/style.css >> $project_path/style.css
    curl https://raw.githubusercontent.com/malo2b/project_admin_sys_template/master/script.js >> $project_path/script.js
}

if [ $# -le 1 ]; # Not enouth params
    then
        help;
elif
    [ $# -ge 4 ]; # Too many params
        then
            echo -e "${RED_COLOR}[ERROR] Too many params !${NO_COLOR}\n";
            help;
else
    case $2 in

        "-h" | "--help")
            help;
            ;;

        *)
            init_project $*;
            ;;

    esac
fi
