#!/bin/bash

set -e

ANSIBLE_VAULT_PASSWORD=$1
export ANSIBLE_HOST_KEY_CHECKING=False

main() {
  decrypt_vault
  run_builder
  cleanup_configs
}

decrypt_vault() {
  echo $ANSIBLE_VAULT_PASSWORD > ansible_vault_password
  ansible-vault decrypt --vault-password-file ansible_vault_password automated_builder/vars/main.yml
}

run_builder() {
  ansible-playbook -i automated_builder/inventory automated_builder/tasks/configure_local_environment.yml
  ansible-playbook -i automated_builder/inventory automated_builder/tasks/build_commit_vms.yml
}

cleanup_configs() {
  ansible-vault encrypt --vault-password-file ansible_vault_password automated_builder/vars/main.yml
  rm ansible_vault_password
}

main
