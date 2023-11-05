FROM ubuntu:22.04

ENV DEBIAN_FRONTEND noninteractive

# install R and python3
RUN apt-get update -y \
&& apt-get install r-base r-base-dev python3 python3-pip -y

# upgrade pip and install tensorflow and keras deps
RUN pip install pip --upgrade \
&& pip install tensorflow tensorflow-hub tensorflow-datasets scipy requests Pillow h5py pandas pydot

ENV RETICULATE_PYTHON /usr/bin/python3

# install R libs tensorflow and keras
RUN Rscript -e 'install.packages(c("tensorflow", "keras"))'

COPY ./network.R /opt/network.R