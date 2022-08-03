# Automated Builder README

The `automated_builder` folder contains ansible plays in order to streamline Whonix build automation. Github actions triggers these builds which run on a remote Digital Ocean VPS.

## Setup
1. A Digital Ocean (or similar) Debian VPS must exist with the following configurations
  a) A user named `ansible_user` must exist
  b) VirtualBox must be installed on the machine
  c) SSH must be set up and ports open, with a key for `ansible_user` in `/home/users/ansible_user/.ssh/authorized_keys`
2. Github repository must have the following variables set
  a) secrets.VPS_IP with the respective IP address
  b) secrets.SSH_KEY with the respective public key 
