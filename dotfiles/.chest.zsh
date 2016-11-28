##### Exports

# Update the theme of ZSH
ZSH_THEME="fino"

##### Utils

# Clear spaces from a given string
_clear_spaces() {
  escape=$@;
  escape=${escape// /\+};
  echo $escape;
}

##### Apps

# Transfer (https://transfer.sh)
transfer() { if [ $# -eq 0 ]; then echo "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"; return 1; fi
  tmpfile=$( mktemp -t transferXXX ); if tty -s; then basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g'); curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile; else curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile ; fi; cat $tmpfile; rm -f $tmpfile; }

##### Productivity

# Return the weather of the given city
w() {
  escape=$(_clear_spaces $@);
  curl -4 "wttr.in/$escape";
}

# Open a finder in the current directory
alias f="open ./";

# Tmux
alias tmux="tmux -u"

# Reload the current shell
alias rr="source ~/.zshrc"
alias vh="sudo vim /private/etc/hosts"
alias vc="vim ~/.zshrc"

##### Sketch

alias sk="sketchtool"
alias sks="sketchtool export slices"
alias ska="sketchtool export artboards"
alias skp="sketchtool export pages"
alias skls="sketchtool list slices"
alias skla="sketchtool list artboards"
alias sklp="sketchtool list pages"

##### Docker

alias dk="docker"
alias dkps="docker ps"
alias dkr="docker run"
alias dka="docker attach --sig-proxy=false"
alias dks="docker stop"
alias dkk="docker kill"
alias dke="docker exec"
# Compose
alias dkc="docker-compose"
alias dkcp="docker-compose ps"
alias dkcu="docker-compose up"
alias dkcs="docker-compose start"
alias dkcst="docker-compose stop"
alias dkcr="docker-compose run"
alias dkcrr="docker-compose restart"
alias dkcd="docker-compose down -v --remove-orphans"
alias dkce="docker-compose exec"
alias dkcl="docker-compose logs -f --tail=100"

docker-clean() {
  docker rm -v $(docker ps -a -q -f status=exited)
  docker rmi $(docker images -f "dangling=true" -q)
  docker images | awk '{ print $1,$2,$3 }' | grep "none" | awk '{print $3}' | xargs -I {} docker rmi {}
}

##### Git

# Some aliases
alias gs="git status"
alias glc="git log -1 --pretty=%B"
alias gbc="git branch --contains"
alias gcmsg="git commit -m"
alias gcmssg="git commit -S -m"
alias gff="git diff"
alias gsu="git submodule update"
alias gsui="git submodule update --init"

# Sync a fork
alias gsyncf="git fetch upstream && git checkout master && git merge upstream/master"

# Log formatting
alias glg="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(bold red)- %an%C(reset)' --all"

##### Search

# Search in google
s() {
 query=$(_clear_spaces $@);
 # Query to google
 open "https://www.google.es/search?q=$query&oq=$query&ie=UTF-8"
}

# Search in stack overflow
st() {
 query=$(_clear_spaces $@);
 # Query to stackoverflow
 open "https://stackoverflow.com/search?q=$query"
}
