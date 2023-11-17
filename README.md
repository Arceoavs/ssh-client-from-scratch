# SSH Client Docker Image

This Docker image provides a minimal setup for an SSH client, allowing you to execute commands on a remote server securely. It includes the OpenSSH client and can be easily customized with your private key and known hosts file.

## Build the Image

To build the Docker image, use the following command:

```bash
docker build -t ssh-client .
```

This command builds the image using the Dockerfile in the current directory and tags it as "ssh-client".

## Run the Container

To run the SSH client container, execute the following command:

```bash
docker run --rm -v ~/.ssh/id_rsa:/home/user/.ssh/id_rsa -v ~/.ssh/known_hosts:/home/user/.ssh/known_hosts ssh-client user@host "ls"
```

This command runs the container removes it after execution (`--rm`), and mounts your local `id_rsa` private key and `known_hosts` file into the container. Replace `user@host` with your actual SSH username and host. The last part of the command, `"ls"`, is an example command you can replace with your own.

**Note:**
- Ensure that your private key (`id_rsa`) and known hosts file are located in the specified paths on your local machine.
- Adjust the SSH command (`user@host "ls"`) to execute the desired command on the remote server.
