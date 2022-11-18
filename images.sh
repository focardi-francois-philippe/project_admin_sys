#!/bin/bash
RED_COLOR="\033[1;31m";
BLUE_COLOR="\033[1;34m";
GREEN_COLOR="\033[1;32m";
NO_COLOR="\033[0m";
help () {
    echo -e "${GREEN_COLOR}gensite images:${NO_COLOR}";
    echo;
    echo "Options:";
    echo -e "\t-a, --add    {image}     Add an image (jpg or png) to the project. If several images use space to separate images.";
    echo -e "\t-f, --folder {path}      Add all images in a folder to the project.";
    echo;
}

add () {
    extensionsAcceptees=("png" "jpg" "jpeg")
    for image in "${@:3}" # Iterate on images but not command args
    do
        if test -f $image;then
            filename=$(basename -- "$image")
            extension="${filename##*.}"
            if [[ " ${extensionsAcceptees[*]} " =~ " ${extension} " ]]; then
                cp $image ./images
            else
                echo "Le fichier ${image} doit etre de type png ou jpg"
            fi
            
        else
            echo "Le fichier ${image} n'existe pas"
        fi
    done
}


if [ $# -le 1 ]; # Not enouth params
    then
        help;
else

    case $1 in
        
        "-h" | "--help")
            help;
            ;;

        "-a" | "--add")
            add $*;
            ;;
            

        *)
            help;
            ;;

    esac
fi