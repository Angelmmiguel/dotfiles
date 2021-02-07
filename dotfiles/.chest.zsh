##### Exports

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

# Work with folders
alias count="find . ! -name . -prune -print | grep -c /"

# Display information from package.json. It requires jq!
alias ns="cat package.json | jq .scripts"
alias ne="cat package.json | jq -r '.scripts | keys[]' | fzf | xargs yarn"
alias nd="cat package.json | jq .dependencies"
alias ndd="cat package.json | jq .devDependencies"

# List and celan node_modules folders
# https://dev.to/trilon/how-to-delete-all-nodemodules-folders-on-your-machine-43dh
alias node-modules-space="find . -name "node_modules" -type d -prune -print | xargs du -chs"
alias node-modules-clean="find . -name 'node_modules' -type d -prune -print -exec rm -rf '{}' \;"

# Grep files in the folder
lsg() {
  ls -la | grep $@
}

# Estimate the compressed size of a file (GZIP)
gzip_estimation() {
  gzip -9 -c $1 | wc -c | awk '{$1=$1/1024; print "\033[32mEstimated size:\033[0m",$1,"KB";}'
}

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
alias dkcd="docker-compose down --remove-orphans"
alias dkcdv="docker-compose down -v --remove-orphans"
alias dkce="docker-compose exec"
alias dkcl="docker-compose logs -f --tail=100"

docker-clean() {
  docker rm -v $(docker ps -a -q -f status=exited)
  docker rmi $(docker images -f "dangling=true" -q)
  docker images | awk '{ print $1,$2,$3 }' | grep "none" | awk '{print $3}' | xargs -I {} docker rmi {}
}

# Restart and log
dkcrl() {
  dkcrr $1 && dkcl $1
}

# Start and log
dkcsl() {
  dkcs $1 && dkcl $1
}

# Dinghy HTTP proxy
alias dinghy-proxy="\
  docker run -d --restart=always \
    -v /var/run/docker.sock:/tmp/docker.sock:ro \
    -v ~/.dinghy/certs:/etc/nginx/certs \
    -p 80:80 -p 443:443 -p 19322:19322/udp \
    -e DNS_IP=127.0.0.1 -e CONTAINER_NAME=http-proxy \
    --name http-proxy \
    codekitchen/dinghy-http-proxy"

##### Kubernetes

# Kubectl
alias kb="kubectl"
alias kbg="kubectl get"

# Kubectx
alias kbx="kubectx"
alias kbs="kubens"

# Configure a new kubectl context
#
# $1: name
# $2: token
# $3: cluster
# $4: namespace
kb_config_context() {
  kubectl config set-credentials "$1" --token "$2"
  kubectl config set-context $1 --user "$1" --cluster "$3" --namespace "$4"
}

# Minikube
alias mk="minikube"

# Ksonnet
# It requires to run the following command first:
# git clone git@github.com:ksonnet/ksonnet-lib.git ~/.ksonnet-lib
alias ksonnet="jsonnet -J ~/.ksonnet-lib"

##### OpenSSL

# Get certificate expiration date
cert_expiration() {
  echo | openssl s_client -servername $1 -connect $1:$2 2>/dev/null | openssl x509 -noout -issuer -subject -dates
}

##### Git

# Some aliases
alias gs="git status"
alias ga="git add"
alias glc="git log -1 --pretty=%B"
alias gb="git --no-pager branch"
alias gbc="git branch --contains"
alias gcmsg="git commit -m"
alias gcmssg="git commit -S -m"
alias gff="git diff"
alias gsu="git submodule update"
alias gsui="git submodule update --init"

# Useful selectors
alias gbd="git branch | fzf | xargs git branch -D"
alias gcob="git branch | fzf | xargs git checkout"
alias gcof="git ls-files -m | fzf | xargs git checkout"

# Sync a fork. Upstream must be present
alias gsyncf="git fetch upstream && git checkout master && git merge upstream/master"

# Log formatting
alias glg="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(bold red)- %an%C(reset)' --all"

# (WORK) Create a commit ready for lint
alias gclint="git add -A && git commit -m 'Lint' && arc diff"

# Set the upstream of the current branch (GitHub new branches)\
gpsu() {
  branch=$(git rev-parse --abbrev-ref HEAD);
  git push --set-upstream origin $branch
}

##### Others. Just to simplify the commands

alias v="vim"
alias e="exit"
alias cl="clear"

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

##### Random

# Get the gif from a tweet!
# From: https://gist.github.com/brianloveswords/7534169715b5750a892cddcf54c2aa0e
_video-url-from-tweet() {
  if [ "$1" ]; then
    url=$1
  else
    echo "Must provide a url"
    return 1
  fi

  curl --silent $url |\
    # should find the <meta> tag with content="<thumbnail url>"
    (grep -m1 "tweet_video_thumb" ||\
      echo "Could not find video" && return 1) |\

    # from: <meta property="og:image" content="https://pbs.twimg.com/tweet_video_thumb/xxxxxxxxxx.jpg">
    # to: https://pbs.twimg.com/tweet_video_thumb/xxxxxxxxxx.jpg
    cut -d '"' -f 4 |\

    # from: https://pbs.twimg.com/tweet_video_thumb/xxxxxxxxxx.jpg
    # to: https://video.twimg.com/tweet_video/xxxxxxxxxx.mp4
    sed 's/.jpg/.mp4/g' |\
    sed 's/pbs.twimg.com\/tweet_video_thumb/video.twimg.com\/tweet_video/g'
}
_video-from-tweet() {
  if [ "$1" ]; then
    url=$1
  else
    echo "Must provide a url"
    return 1
  fi
  curl $(_video-url-from-tweet $url)
}
_video-to-gif() {
  # derived from https://engineering.giphy.com/how-to-make-gifs-with-ffmpeg/
  if [ "$2" ]; then
    input=$1
    output=$2
  else
    echo "Must provide an input file and output file"
    return 1
  fi

  ffmpeg -i $input \
          -filter_complex "[0:v] split [a][b];[a] palettegen [p];[b][p] paletteuse" \
          -f gif \
          $output
}
gif-from-tweet() {
  if [ "$2" ]; then
    url=$1
    output=$2
  else
    echo "Must provide a url and an output filename"
    return 1
  fi
  _video-from-tweet $url | _video-to-gif - $output
}
