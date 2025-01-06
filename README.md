# AI Docker Image

Create docker image for development AI/
The docker image is based on fedora:40 docker image  

## Docker build (in git bash)
~~~
docker build --progress plain -t zeevb053/ai-dev:1.0 . 2>&1 |  tee res.txt
docker push zeevb053/ai-dev:1.0
~~~


To run the docker  
~~~
docker run --name dev-image -v c:\temp\.ssh:/temp -p 2025:22 zeevb053/fedora-dev:14.06
~~~

