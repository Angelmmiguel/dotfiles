#!/usr/bin/env bash

while true; do
    read -p "This will be update .chest.zsh. Do you want to continue? [yn] - " yn
    case $yn in
        [Yy]* ) cp ./dotfiles/.chest.zsh $HOME/; echo "Updated, run rr to reload"; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
