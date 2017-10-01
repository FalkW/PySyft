#!/bin/bash

#Install and start jupyter based on INST_JUPYTER
if [ "${INST_JUPYTER}" = "TRUE" ]; then
    echo "Environment will be set up including Jupyter"
    pip3 install jupyter
else
    echo "Environment will be set up without Jupyter. To include it run: docker-compose build --build-arg INST_JUPYTER=true"
fi;
