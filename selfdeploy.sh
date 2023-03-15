#!/bin/sh
set -e
sudo docker build -t hippylib/hub .
sudo docker run -td -p 80:8000 --name=hippyhub hippylib/hub
sudo docker logs hippyhub > hippyhub.out
