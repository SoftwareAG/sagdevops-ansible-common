ARG BASE_ANSIBLE_IMAGE

FROM $BASE_ANSIBLE_IMAGE

LABEL org.opencontainers.image.authors="fabien.sanglier@softwareaggov.com" \
      org.opencontainers.image.vendor="Softwareag Government Solutions"

# add the base ansible scripts
COPY ./roles ${ANSIBLE_ROLES_BASEPATH}/sagdevops-ansible-common-utils

# add the base ansible scripts
COPY ./playbooks ${ANSIBLE_PLAYBOOKS_BASEPATH}/

## Add the ansible roles to the ansible role path list
### Colon separated paths in which Ansible will search for Roles.
ENV ANSIBLE_ROLES_PATH="${ANSIBLE_ROLES_PATH}:${ANSIBLE_ROLES_BASEPATH}/sagdevops-ansible-common-utils"