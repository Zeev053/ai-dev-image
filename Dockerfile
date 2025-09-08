#Build:
#run: docker build -t em .
FROM ubuntu:24.04

# COPY internal.pem /usr/local/share/ca-certificates.crt
COPY startSSH.sh /usr/bin/startSSH.sh
# ADD https://netfree.link/dl/unix-ca.sh /home/netfree-unix-ca.sh
# RUN cat /home/netfree-unix-ca.sh | sh
# ENV NODE_EXTRA_CA_CERTS=/etc/ca-bundle.crt
# ENV REQUESTS_CA_BUNDLE=/etc/ca-bundle.crt
# ENV SSL_CERT_FILE=/etc/ca-bundle.crt

ENV TZ=TZ=Asia/Jerusalem
ARG DEBIAN_FRONTEND=noninteractive
#for running godot inside docker
#RUN apt-get install -y libxcursor1 libxinerama1 libxi6 libgl1-mesa-glx  libxrandr2
RUN mkdir -p /root/.ssh ; \ 
	apt-get update ; apt upgrade -y ; \ 
	# update-ca-certificates export SSL_CERT_FILE=/usr/local/share/ca-certificates.crt 
	apt-get install -y ca-certificates redis-server net-tools git curl vim sudo  python3 python3-venv openssh-server openssh-client rsync \ 
	tcpdump gedit x11-apps wget gdb gdbserver iputils-ping nano apt-transport-https gnupg  ; \ 
	apt-get update ; apt upgrade -y 
RUN echo which python3: ; \ 
	which python3 ; \ 
	echo python3 --version ; \ 
	python3 --version ; \ 
	pip -V ; \ 
	echo create virtual enviroment  ; \ 
	mkdir /workspace  ; \ 
	python3 -m venv /workspace/venv  ; \ 
	cd /workspace ; \ 
	chmod +x venv/bin/activate  ; \ 
	source venv/bin/activate  ; \ 
	/workspace/venv/bin/pip install --upgrade pip ; \ 
	/workspace/venv/bin/pip -V ; \ 
	# python3 -m pip install -U pip ; \ 
	/workspace/venv/bin/pip install  wheel setuptools pytest pytest-cov pytest-spec rich yq trimesh==3.23.5 tqdm==4.66.1 embreex==2.17.7.post5 uvicorn==0.30.6 fastapi==0.115.6 opencv-python gradio gradio_client \ 
    GPUtil==1.4.0 pillow cryptography dash dash-bootstrap-components dash-leaflet python-dateutil==2.8.2 flask==3.0.3 geopandas==0.13.2 \ 
    jinja2 markupsafe==2.1.3 matplotlib==3.10.3 numpy==2.3.1 ortools==9.9.3963 pandas==2.3.1 plotly==5.15.0 prettytable==3.9.0 psutil==5.9.5 pymap3d==3.0.1 \  
    pyproj==3.7.1 pytz==2023.3 rasterio==1.3.9 redis==5.0.4 requests scipy==1.16.0  \ 
	shapely==2.1.1 scikit-image==0.25.2 scikit-learn==1.7.0  utm==0.8.1 \ 
    rticonnextdds-connector==1.2.0 rti.connext==7.3.0 triangle==20250106 --trusted-host pypi.org --trusted-host files.pythonhosted.org  ;  \
	/workspace/venv/bin/pip install --upgrade wheel setuptools  ;  \
	apt autoremove --purge python3-setuptools-whl python3-cryptography -y

# Custom packages install (GCSFuse + GCloud utils)
RUN echo 'Custom packages install (GCSFuse + GCloud utils)'  && \
	apt-get update && \
    apt-get install -y lsb-release && \
    curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg && \
    curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | gpg --dearmor -o /usr/share/keyrings/gcsfuse.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" > /etc/apt/sources.list.d/google-cloud-sdk.list && \
    export GCSFUSE_REPO=gcsfuse-$(lsb_release -c -s) && \
    echo "deb [signed-by=/usr/share/keyrings/gcsfuse.gpg] http://packages.cloud.google.com/apt $GCSFUSE_REPO main" > /etc/apt/sources.list.d/gcsfuse.list && \
    apt-get update && \
	echo '/usr/share/keyrings/cloud.google.gpg:'  && \
	cat /usr/share/keyrings/cloud.google.gpg  && \
	echo '/usr/share/keyrings/gcsfuse.gpg:' && \
	cat /usr/share/keyrings/gcsfuse.gpg && \
	echo '/etc/apt/sources.list.d/google-cloud-sdk.list:' && \
	cat /etc/apt/sources.list.d/google-cloud-sdk.list && \
	echo "GCSFUSE_REPO: $GCSFUSE_REPO" && \
	echo '/etc/apt/sources.list.d/gcsfuse.list:' && \
	cat /etc/apt/sources.list.d/gcsfuse.list && \
	apt-get install -y google-cloud-cli gcsfuse && \
    rm -rf /var/lib/apt/lists/*

RUN chmod +x /usr/bin/startSSH.sh &&  mkdir -p /run/sshd

# ENV DISPLAY=host.docker.internal:0.0

# EXPOSE 8000

CMD ["/usr/bin/startSSH.sh"]



