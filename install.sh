#!/usr/bin/env bash

_display_name() {
  echo -e "\n##### $1 #####"
}

# Check if the command exist and display a message
_here_we_go_with() {
  _display_name "$1"
  if hash $1 2>/dev/null; then
    echo "$1 is installed. Skipping..."
    return 1
  else
    echo "Installing $1..."
    return 0
  fi
}

# Check if the brew app exist and display a message
_brew_here_we_go_with() {
  _display_name "$1"
  if brew list -1 | grep -q "$1"; then
    echo "$1 is installed. Skipping..."
    return 1
  else
    echo "Installing $1..."
    return 0
  fi
}

# Check if a file exist and display a message
_directory_here_we_go_with() {
  _display_name "$1"
  if [ -d "$2" ]; then
    echo "$1 is installed. Skipping..."
    return 1
  else
    echo "Installing $1..."
    return 0
  fi
}

# Check if a file exist and display a message
_file_here_we_go_with() {
  _display_name "$1"
  if [ -f "$2" ]; then
    echo "$1 is installed. Skipping..."
    return 1
  else
    echo "Installing $1..."
    return 0
  fi
}

# Install homebrew
if _here_we_go_with "brew"; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Install zsh
if _brew_here_we_go_with "zsh"; then
  brew install zsh zsh-completions
fi

# Install oh-my-zsh!
if _directory_here_we_go_with "Oh my Zsh" "$HOME/.oh-my-zsh"; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

# Install docker!
if _brew_here_we_go_with "docker"; then
  brew install docker docker-machine docker-compose
fi

# Install xhyve
if _brew_here_we_go_with "docker-machine-driver-xhyve"; then
  brew install docker-machine-driver-xhyve
  echo "We need sudo permission to instal Xhyve (https://github.com/zchee/docker-machine-driver-xhyve#install)"
  sudo chown root:wheel $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve
  sudo chmod u+s $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve
fi

# Install dinghy
if _brew_here_we_go_with "dinghy"; then
  brew tap codekitchen/dinghy
  brew install dinghy
  echo "Creating dinghy machine"
  dinghy create --provider xhyve
  # Add data to .zshrc
  echo "Adding dinghy env to zshrc"
  echo -e "\n# Dinghy env" >> ~/.zshrc
  dinghy env >> ~/.zshrc
  source ~/.zshrc
fi

# Install chest
if _file_here_we_go_with "chest" "$HOME/.chest.zsh"; then
  cp ./dotfiles/.chest.zsh $HOME
  echo -e "\n# Chest" >> $HOME/.zshrc
  echo "source $HOME/.chest.zsh" >> $HOME/.zshrc
fi

# Install gemrc
if _file_here_we_go_with "gemrc" "$HOME/.gemrc"; then
  cp ./dotfiles/.gemrc $HOME
fi

# Install vimrc
if _file_here_we_go_with "vimrc" "$HOME/.vimrc"; then
  cp ./dotfiles/.vimrc $HOME
fi

echo -e "\nFinished! :D"
