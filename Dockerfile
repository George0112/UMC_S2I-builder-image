# UMC_S2I
FROM ubuntu:16.04
MAINTAINER rocky_wang

LABEL io.openshift.s2i.scripts-url="image:///s2i/bin"

RUN apt-get update \
    && apt-get install sudo \
    && apt-get install -y wget \
    && wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && /bin/bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/conda \
    && apt-get install -y r-base r-base-dev \
    && apt-get install -y python-rpy2

ENV PATH=/opt/conda/bin:$PATH
RUN pip install rpy2==3.0.5 
RUN pip install cffi==1.12.3
RUN pip install tzlocal 
RUN pip install pandas
RUN pip install tensorflow==1.14.0

RUN apt-get clean \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/

RUN mkdir microservice
WORKDIR /microcervice

# TODO (optional): Copy the builder files into /opt/app-root
# COPY ./<builder_folder>/ /opt/app-root/

# Copy the S2I scripts to /usr/libexec/s2i
COPY ./s2i/bin/ /s2i/bin/

# Drop the root user and make the content of /opt/app-root owned by user 1001
# RUN chown -R 1001:1001 /opt/app-root

# This default user is created in the openshift/base-centos7 image
# USER 1001

# Set the default CMD for the image
CMD ["/s2i/bin/usage"]
