# Build DeepLearning on GPUs; without the hassle of installation & configuration

## Make your machine DeepLearning-ready in minutes with this docker image

This image is built on efforts made by very amazing people; I only tweaked it to match my needs (which I think is so many people's as well!).

# What do you get with this image:
- NVIDIA docker runtime configured with whatever cuda & cudnn version you like (I specified the most generic one that worked for me).
- Tensorflow
- Keras
- Jupyter (WITHOUT token or password), why? so you don't have to login to the container everytime you start your machine to know how to login to Jupyter.
- The ability to mount your source-code workspace as well as your data to the container; this ensures your code & modifications won't be gone in case the container is shutdown or deleted, and also to attach any datasets you want to the container.

# What is inside this folder:
- The Dockerfile which I modified from keras
- The Makefile which keras used to build & run the images (I honestly don't like make!)
- The docker-run.sh which is basically an easier & more practical way of building and running your container (at least for me!)

# How to run the docker-run.sh script 
- Just run the following: `./docker-run.sh --data <path_to_dataset_on_local_machine> --source <path_to_your_code>`. This command will do everything needed: 
  - Build the image & its dependencies, 
  - Create the container and run Jupyter
- Once finished; you can open your browser and navigate to http://localhost:8888/ and you enjoy your GPU-enabled tensorflow :-)

# Once your container is up:
- Your data will be under `/data`.
- Your source-code will be in the workspace folder when you login to Jupyter using http://localhost:8888/
