# AI Docker Image

Create docker image for development AI/
The docker image is based on ubuntu:24.04 docker image  

## Docker build (in git bash)
~~~
docker build --progress plain -t zeevb053/ai-dev:1.8 . 2>&1 |  tee res.txt
docker push zeevb053/ai-dev:1.8
~~~


To run the docker  
~~~
cd docker-compose
./compose_up.sh
~~~

