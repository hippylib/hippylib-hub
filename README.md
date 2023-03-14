# Jupyterhub and hIPPYlib Educational Environment
## Umberto Villa

This will launch a full multi-user FEniCS Project environment for classrooms,
courses and general fun using Jupyterhub, iPython Notebook and FEniCS. Each
user has his own home directory.

This scripts are an adaptation of Jake Hale's project available from [fenics-jupyter](https://bitbucket.org/jackhale/fenics-jupyter).

Here a list of instructions:

1. (One time only) Install [docker](https://www.docker.com/). On Ubuntu one can simply enter the command

    ```
    apt-get install docker.io
    ```
    
2. (One time only) Clone the hippylib-hub repository

    ```
    git clone git@github.com:hippylib/hippylib-hub.git
    ```
    
3. (One time only) Go inside the `hippylib-hub` folder, and clone `hippylib`:

    ```
     cd hippylib-hub & git clone https://github.com/hippylib/hippylib.git
    ```
    
4. Build the docker image (This step needs to be repeated each time `hippylib` is updated)

    ```
    sudo docker build -t hippylib/hub .
    ```
   
5. Check that the image was created correctly with the command

    ```
    sudo docker images
    ```
   
6. Start the server

    ```
    sudo docker run -td -p 80:8000 --name=hippyhub hippylib/hub
    ```
   
7. Check that the server is up

    ```
    sudo docker ps
    ```
   
8. Check messages from the server

    ```
    sudo docker logs hippyhub
    ```
   
9. Stop ad delete the server (always stop the server before rebuilding the docker image)

    ```
    sudo docker stop hippyhub & sudo docker rm hippyhub
    ```
