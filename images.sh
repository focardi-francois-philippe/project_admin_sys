#!/bin/bash
RED_COLOR="\033[1;31m";
BLUE_COLOR="\033[1;34m";
GREEN_COLOR="\033[1;32m";
NO_COLOR="\033[0m";
ACCEPT_EXTENSION=("png" "jpg" "jpeg")
help () {
    echo -e "${GREEN_COLOR}gensite images:${NO_COLOR}";
    echo;
    echo "Options:";
    echo -e "\t-a, --add    {image}     Add an image (jpg, jpeg or png) to the project. If several images use space to separate images.";
    echo -e "\t-f, --folder {path}      Add all images (jpg, jpeg or png) in a folder to the project.";
    echo -e "\t-d, --default            Add default images.";
    echo;
}

add () {
    for image in "${@:3}" # Iterate on images but not command args
    do
        if test -f $image;then
            filename=$(basename -- "$image")
            extension="${filename##*.}"
            if [[ " ${ACCEPT_EXTENSION[*]} " =~ " ${extension} " ]]; then
                cp $image ./images
            else
                echo "Le fichier ${image} doit etre de type png ou jpg"
            fi
            
        else
            echo "Le fichier ${image} n'existe pas"
        fi
    done
}
add_folder () {
    for folder in "${@:3}" # Iterate on images but not command args
    do
        if test -d $folder;then
            for file in $folder*; do
                filename=$(basename -- "$file")
                extension="${filename##*.}"
                if [[ " ${ACCEPT_EXTENSION[*]} " =~ " ${extension} " ]]; then
                    cp $file ./images
                else
                    echo "Le fichier ${file} n'est pas telecharge, il doit etre de type png ou jpg"
                fi
            done
        else
            echo "${folder} n'est pas un dossier ou n'existe pas"
        fi
    done
}

add_default () {
    url="https://raw.githubusercontent.com/malo2b/project_admin_sys_template/develop/images.zip"
    curl -LO -f $url && rm -rf images && unzip images.zip && rm images.zip || echo -e "${RED_COLOR}Error to get default images, check your internet connection:${NO_COLOR}"
}

if [ $# -le 1 ]; # Not enouth params
    then
        help;
else
    case $2 in
        
        "-h" | "--help")
            help;
            ;;

        "-a" | "--add")
            add $*;
            ;;
        "-f" | "--folder")
            add_folder $*;
            ;;
        "-d" | "--default")
            add_default;
            ;;

        *)
            help;
            ;;

    esac
fi
