# These are some useful functions to have sourced in whatever shell you use.
# I use zsh, so no promises that they work in bash or fish

# Used in my Prompt. Outputs the current branch name
curr_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# used to invoke sudo on previous command
# Found here: https://unix.stackexchange.com/a/138368/253793
# Stands for "FUCK, I forgot to sudo."
fk() {
    sudo zsh -c "$(fc -ln -1)"
}

# Windows specific way to pipe xterm through ssh
# Used this to get xwindows displays on windows from remote linux machine
ssv() {
    "startxwin" &
    sleep 4;
    ssh -Y "$1";
}

# Up command.
# Goes up the # of directories that you provide.
u() {
  local d=..
  local limit=$1
  for ((i = 1; i < limit; i++))
  do
    d=$d/..
  done
  cd $d || exit 1
}

# I'm probably never using this again, BUT it was useful while it lasted.
# I rolled a couple docker commands into one,
# prune -v removed unused volumes [DANGEROUS]
# prune -c removed stopped and killed containers
# prune -i removed untagged images
prune () {
    if [ $# -eq 0 ]
    then
        printf "You need to provide at least one argument to 'prune'. -c , -i , -v"
        exit 1
    # Containers
    # elif [ "$1" = "-c" ]
    # then
    #    docker container prune
    # Images
    # Thanks to: http://jimhoskins.com/2013/07/27/remove-untagged-docker-images.html
    elif [ "$1" = "-i" ]
    then
        docker rmi $(docker images | grep none | awk '{print $3}')
    # This ain't happening after the debacle with Nexus
    # Volumes
    #elif [ "$1" = "-v" ]
    #then
    #    docker volume prune
    else
        printf "Argument could not be recognized"
    fi
}

# Automatically update git repository refs when you cd to the root of it.
# DOESN'T MERGE, ONLY FETCHES
# I've added smart_cd as an alias to cd in my dotfiles
# This way I always know if there are changes
smart_cd () {
    cd "$@"
    if [[ -d .git ]];then
        git fetch
    fi
}

# Acronym: [G]o [I]nto [V]olume
# Would have been Go To Volume, but that all involves the left hand for typing (on qwerty at least)
# Might not even work as is, user needs read permissions for where docker volumes are stored.
giv () {
    if [[ ! $(docker volume ls --format="{{.Name}}") =~ $volume ]]; then
        echo "Provided volume doesn't exist."
        exit 1
    else
        dir=$(docker volume inspect $1 --format '{{.Mountpoint}}')
        cd "$dir"
    fi
}

