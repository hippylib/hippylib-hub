FROM ghcr.io/scientificcomputing/fenics:2024-05-28 
LABEL authors="U. Villa"

USER root

RUN   ln -s /usr/lib/python3/dist-packages/ufl_legacy/ /usr/lib/python3/dist-packages/ufl
RUN   apt-get update
RUN   apt-get install sudo
RUN   apt-get install -yy npm
RUN   npm cache clean -f
RUN   npm install -g n
RUN   n 14.0.0 
RUN   npm install -g configurable-http-proxy@4.2.3
RUN   sudo pip3 install pip --upgrade
RUN   pip3 install jupyterhub jupyterlab notebook

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


RUN useradd fenics -m -s /bin/bash
RUN sudo usermod -a -G sudo fenics
RUN echo "fenics:docker" | chpasswd fenics
USER fenics

# Install hIPPYlib
RUN cd /home/fenics/ && \
    git clone https://github.com/hippylib/hippylib.git && \
    chmod -R o+rX hippylib && \
    cd hippylib && git checkout -b tags/3.1.0

# Copy the notebooks
RUN cd /home/fenics/ && \
    git clone https://github.com/hippylib/cvips_labs.git && \
    chmod -R o+rX cvips_labs

COPY jupyterhub_config.py /home/fenics/jupyterhub_config.py
COPY make-users.py /home/fenics/make-users.py
COPY update_lab.py /home/fenics/update_lab.py
COPY users.csv /home/fenics/users.csv
ENV PYTHONPATH /home/fenics/hippylib
ENV HIPPYLIB_BASE_DIR /home/fenics/hippylib

USER root

RUN cd /home/fenics && python3 make-users.py

WORKDIR /home/fenics/
CMD ["jupyterhub"]
