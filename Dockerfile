#Build:
#run: docker build -t em .
FROM ubuntu:22.04
ENV TZ=TZ=Asia/Jerusalem
ARG DEBIAN_FRONTEND=noninteractive
#for running godot inside docker
#RUN apt-get install -y libxcursor1 libxinerama1 libxi6 libgl1-mesa-glx  libxrandr2
RUN apt-get update && apt-get install -y redis-server net-tools git curl vim sudo python3 pip python3-tk python3-opencv openssh-server openssh-clients rsync
RUN pip install trimesh==3.23.5 tqdm==4.66.1  embreex==2.17.7.post5 uvicorn==0.30.6 fastapi==0.115.0 opencv-python gradio==4.44.1 gradio_client==1.3.0 \ 
    GPUtil==1.4.0 pillow==10.1.0 cryptography==41.0.6 dash==2.17.0 dash_bootstrap_components==1.4.1 python-dateutil==2.8.2 flask==3.0.3 geopandas==0.13.2 \ 
    jinja2==3.1.2 markupsafe==2.1.3 matplotlib==3.7.1 numpy==1.24.3 ortools==9.9.3963 pandas==2.0.2 plotly==5.15.0 prettytable==3.9.0 psutil==5.9.5 pymap3d==3.0.1 \  
    pyproj==3.5.0 pytz==2023.3 rasterio==1.3.9 redis==5.0.4 requests==2.31.0 scipy==1.10 shapely==2.0.1 scikit-image==0.21.0 scikit-learn==1.3.2  utm==0.7.0 \ 
    rticonnextdds-connector==1.2.0 rti.connext==7.3.0
ENV DISPLAY=host.docker.internal:0.0

EXPOSE 8000




