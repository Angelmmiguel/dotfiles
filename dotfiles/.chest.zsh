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

# Reload the current shell
alias rr="source ~/.zshrc"

##### Docker

alias dd="docker"
alias ddps="docker ps"
alias ddr="docker run"
alias dds="docker stop"
alias ddk="docker kill"
alias dde="docker exec"
# Compose
alias ddc="docker-compose"
alias ddcp="docker-compose ps"
alias ddcu="docker-compose up"
alias ddcs="docker-compose start"
alias ddcst="docker-compose stop"
alias ddcr="docker-compose run"
alias ddcrr="docker-compose restart"
alias ddcd="docker-compose down"
alias ddce="docker-compose exec"
alias ddcl="docker-compose logs -f"

##### Git

# Some aliases
alias gs="git status"
alias glm="git log --pretty=format:'%h : %s'"
alias glc="git log -1 --pretty=%B"
alias gbc="git branch --contains"
alias gcmsg="git commit -m"
alias gcmssg="git commit -S -m"
alias gff="git diff"

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
