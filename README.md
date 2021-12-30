# sagdevops-ansible-common
A group of ansible common utils leveraged by the other product-specific ansible roles

## Using Containers

### Pre-requisite - Base Ansible runner

If you haven't done dso already, make sure to have the "sagdevops-ansible-runner" built and ready.
See instructions [README-base-ansible.md](./README-base-ansible.md) for details.
### Building the container

First set some environment variables to specify the build arguments:

```
export REG=
export TAG=0.0.1
```

Then, build the common utils image:

```
docker build --rm -f Dockerfile -t ${REG}sagdevops-ansible-common:latest -t ${REG}sagdevops-ansible-common:${TAG} --build-arg BASE_ANSIBLE_IMAGE=${REG}sagdevops-ansible-runner  .
```

This will create 1 container image with 2 tags (1 tagged with the build version, 1 tagged as "latest"): 
 - ${REG}sagdevops-ansible-common:latest
 - ${REG}sagdevops-ansible-common:${TAG}

Test to make sure it's there:

```
docker images ${REG}sagdevops-ansible-common:${TAG}
docker images ${REG}sagdevops-ansible-common:latest
```
### Testing validity of the containers

We'll be running the simplest [ping.yml](./playbooks/ping.yml) playbook added to this project for testing:

```
docker run -v $PWD/playbooks:/ansible/playbooks ${REG}sagdevops-ansible-common:${TAG} -v ping.yml
```

You should see the following output if all is well (notice the Task "ping" which should execute succesfully)

```
PLAY [all] *********************************************************************

TASK [Gathering Facts] *********************************************************
ok: [localhost]

TASK [ping] ********************************************************************
ok: [localhost] => {"changed": false, "ping": "pong"}

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```

At this point, the image should be ready to be used.

# Authors
Fabien Sanglier
- Emails: [@Software AG](mailto:fabien.sanglier@softwareag.com) [@Software AG Government Solutions](mailto:fabien.sanglier@softwareaggov.com)
- Github: 
  - [Fabien Sanglier @ SoftwareAG Government Solutions](https://github.com/fabien-sanglier-saggs)
  - [Fabien Sanglier](https://github.com/lanimall)

______________________
These tools are provided as-is and without warranty or support. They do not constitute part of the Software AG product suite. Users are free to use, fork and modify them, subject to the license agreement. While Software AG welcomes contributions, we cannot guarantee to include every contribution in the master project.
_____________
For more information you can Ask a Question in the [TECHcommunity Forums](http://tech.forums.softwareag.com/techjforum/forums/list.page?product=webmethods).

You can find additional information in the [Software AG TECHcommunity](http://techcommunity.softwareag.com/home/-/product/name/webmethods).
_____________
Contact us at [TECHcommunity](mailto:technologycommunity@softwareag.com?subject=Github/SoftwareAG) if you have any questions.
