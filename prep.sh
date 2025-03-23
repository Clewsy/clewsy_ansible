#!/bin/bash
# Install some software required by ansible for first run.

sudo apt update
sudo apt install	openssh-server \
			sshpass \
			ansible
