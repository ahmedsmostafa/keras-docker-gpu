#!/bin/bash

DATA="${HOME}/Data"
#GPU?=0
DOCKER_FILE="Dockerfile"
#DOCKER=GPU=$(GPU) nvidia-docker
BACKEND="tensorflow"
PYTHON_VERSION="3.6"
CUDA_VERSION="9.0"
CUDNN_VERSION="7"
SRC="~/"

#POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"
 case $key in
    -d|--d|--data)
    DATA="$2"
    echo "data is $DATA"
    shift # past argument
    shift # past value
    ;;
    -s|--s|--src|--source)
    SRC="$2"
    echo "src is $SRC"
    shift # past argument
    shift # past value
    ;;
    #--default)
    #DEFAULT=YES
    #shift # past argument
    #;;
    #*)    # unknown option
    #POSITIONAL+=("$1") # save it in an array for later
    #shift # past argument
    #;;
 esac
done
#set -- "${POSITIONAL[@]}" # restore positional parameters


docker build -t keras --build-arg python_version=$PYTHON_VERSION --build-arg cuda_version=$CUDA_VERSION --build-arg cudnn_version=$CUDNN_VERSION -f $DOCKER_FILE .

docker run -it --runtime=nvidia -v $SRC:/src/workspace -v $DATA:/data --net=host --env KERAS_BACKEND=$BACKEND keras

# docker run -ti --runtime=nvidia -v /home/ahmedmos/Projects/machine-learning/projects/:/src/workspace -v /media/ahmedmos/Samsung_T5/COCO/datasets/:/src/workspace/datasets --net=host --env KERAS_BACKEND=tensorflow keras_nopass
