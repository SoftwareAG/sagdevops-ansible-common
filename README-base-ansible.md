# sagdevops-ansible-runner

A base ansible runner to execute ansible playbooks in containers (useful for testing, or for "configurator" types of playbooks)

Note: We will be building the ansible-runner on top of latest image "redhat/ubi8-minimal".

## Building the containers

First set some environment variables to specify the ansible version to use:

```
export REG=
export SAGDEVOPS_ANSIBLE_RELEASE=v2.11.6
```

Then, build the base ansible image:

```
docker build --rm -f Dockerfile.ansible -t ${REG}sagdevops-ansible-runner:latest -t ${REG}sagdevops-ansible-runner:${SAGDEVOPS_ANSIBLE_RELEASE} --build-arg BASE_IMAGE=${SAGDEVOPS_BASE_IMAGE} --build-arg ANSIBLE_RELEASE=${SAGDEVOPS_ANSIBLE_RELEASE}  .
```

This will create 1 container image with 2 tags (1 tagged with the ansible version, 1 tagged as "latest"): 
 - ${REG}sagdevops-ansible-runner:latest
 - ${REG}sagdevops-ansible-runner:${SAGDEVOPS_ANSIBLE_RELEASE}

Test to make sure it's there with the same image id:

```
docker images ${REG}sagdevops-ansible-runner:${SAGDEVOPS_ANSIBLE_RELEASE}
docker images ${REG}sagdevops-ansible-runner:latest
```

### Testing the runner

We'll be running the simplest [ping.yml](./playbooks/ping.yml) playbook added to this project for testing:

```
docker run -v $PWD/playbooks:/ansible/playbooks ${REG}sagdevops-ansible-runner:${SAGDEVOPS_ANSIBLE_RELEASE} -v ping.yml
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

At this point, the ansible runner should be ready to be used by other playbooks/roles.

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
