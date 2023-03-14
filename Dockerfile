FROM quay.io/fenicsproject/stable:2019.1.0.r3
LABEL authors="U. Villa"

USER root

RUN   apt-get update
RUN   apt-get install -yy npm
RUN   npm install -g configurable-http-proxy@4.2.3
RUN   sudo pip3 install pip --upgrade
RUN   pip3 install jupyterhub jupyterlab

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*



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

RUN python make-users.py

WORKDIR /home/fenics/
ENTRYPOINT ["/sbin/my_init","--"]
CMD ["jupyterhub"]
