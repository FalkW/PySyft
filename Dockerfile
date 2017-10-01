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
ONBUILD RUN ["mkdir", "/PySyft"]
ONBUILD COPY requirements.txt /PySyft
ONBUILD WORKDIR /PySyft
ONBUILD RUN ["pip3", "install", "-r", "requirements.txt"]
ONBUILD COPY . /PySyft
ONBUILD RUN ["python3", "setup.py", "install"]

#Special handling during installation based on INST_JUPYTER variable
ONBUILD ADD docker-install.sh /usr/local/bin/docker-install.sh
ONBUILD RUN /usr/local/bin/docker-install.sh

#Defining Entrypoint
#ADD docker-entrypoint.sh  /usr/local/bin/docker-entrypoint.sh
#ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
