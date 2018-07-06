# These are some useful functions to have sources in whatever shell you use.
# I use zsh, so no promises that they work on bash or fish

# used to invoke sudo on previous command
# Found here: https://unix.stackexchange.com/a/138368/253793
# Stands for "FUCK, I forgot to sudo."
fk() {
    sudo zsh -c "$(fc -ln -1)"
}

clean_images() {
    # Thanks to: http://jimhoskins.com/2013/07/27/remove-untagged-docker-images.html
    docker rmi $(docker images | grep none | awk '{print $3}')
}
