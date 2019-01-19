#!/bin/bash

DATA=""
SRC=""

#POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"
 case $key in
    -d|--d|--data)
      $DATA="$2"
      echo "data is $DATA"
      shift # past argument
      shift # past value
    ;;
    -s|--s|--src|--source)
      $SRC="$2"
      echo "src is $SRC"
      shift # past argument
      shift # past value
    ;;
    -build|--build)
      if [ "$SRC" != "" ] && [ "$DATA" != "" ]; then
        echo "docker build -t keras --build-arg python_version=$PYTHON_VERSION --build-arg cuda_version=$CUDA_VERSION --build-arg cudnn_version=$CUDNN_VERSION -f $DOCKER_FILE ."
        DOCKER_FILE="Dockerfile"
        BACKEND="tensorflow"
        PYTHON_VERSION="3.6"
        CUDA_VERSION="9.0"
        CUDNN_VERSION="7"
        #docker build -t keras --build-arg python_version=$PYTHON_VERSION --build-arg cuda_version=$CUDA_VERSION --build-arg cudnn_version=$CUDNN_VERSION -f $DOCKER_FILE .
      else
        echo "Please make sure you add --src and --data first"
      fi
 esac
done

container_id=`docker ps -a | grep "keras" | awk '{ print $1 }'`
if [[ $container_id != "" ]]; then
  echo "docker start $container_id"
#  docker start $container_id
elif [[ "$(docker images -q keras:latest 2> /dev/null)" != "" ]]; then
  echo "  docker run -it --runtime=nvidia -v $SRC:/src/workspace -v $DATA:/data --net=host --env KERAS_BACKEND=$BACKEND keras"
#  docker run -it --runtime=nvidia -v $SRC:/src/workspace -v $DATA:/data --net=host --env KERAS_BACKEND=$BACKEND keras
fi

# docker run -ti --runtime=nvidia -v /home/ahmedmos/Projects/machine-learning/projects/:/src/workspace -v /media/ahmedmos/Samsung_T5/COCO/datasets/:/src/workspace/datasets --net=host --env KERAS_BACKEND=tensorflow keras_nopass
