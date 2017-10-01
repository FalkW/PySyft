FROM alpine:edge

EXPOSE 8888

#Adding additional packages
RUN apk add --no-cache \ 
    python3 \
    python3-dev \
    musl-dev \
    linux-headers \
    g++ \
    gmp-dev \
    mpfr-dev \
    mpc1-dev \
    ca-certificates \
    openblas-dev \
    gfortran

#Creating working directory and install packages defined in requirements.txt 
RUN ["mkdir", "/PySyft"]
COPY requirements.txt /PySyft
WORKDIR /PySyft
RUN ["pip3", "install", "-r", "requirements.txt"]
COPY . /PySyft
RUN ["python3", "setup.py", "install"]
RUN ["pip3", "install", "jupyter"]


#Special handling during installation based on INST_JUPYTER variable
#ONBUILD ADD docker-install.sh /usr/local/bin/docker-install.sh
#ONBUILD RUN /usr/local/bin/docker-install.sh

#Defining Entrypoint
COPY docker-entrypoint.sh /sbin/docker-entrypoint.sh
CMD ["/sbin/docker-entrypoint.sh"]
