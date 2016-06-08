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

##### Git

# Some aliases
alias gs="git status"
alias glm="git log --pretty=format:'%h : %s'"
alias glc="git log -1 --pretty=%B"
alias gbc="git branch --contains"
alias gcmsg="git commit -m"
alias gcmssg="git commit -S -m"

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
