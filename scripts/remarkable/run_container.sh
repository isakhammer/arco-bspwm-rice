#!/usr/bin/env bash

function run_container()  {
  image_name="remarkable:latest"
  xhost +local:root
  XSOCK=/tmp/.X11-unix
  docker run -it --rm \
     -e DISPLAY=$DISPLAY \
      -v $HOME/work:/root/work \
      -v $XSOCK:$XSOCK \
      -v $HOME/.ssh:/root/.ssh \
       -v $HOME/.Xauthority:/root/.Xauthority \
       --name remarkable\
        --privileged \
        $image_name "$@"
}

run_container

