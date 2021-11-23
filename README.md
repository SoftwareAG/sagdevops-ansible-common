# sagdevops-ansible-common-utils
A group of ansible common utils leveraged by the other product-specific ansible roles

## Using Containers

### Building the containers

To build containers for the configurators...

First set some environment variables to specify the build arguments:

```
export REG=
export TAG=0.0.1
export SAGDEVOPS_ANSIBLE_RELEASE=v2.11.6
export SAGDEVOPS_BASE_IMAGE=redhat/ubi8-minimal
```

Then, build the base ansible image:

```
docker build --rm -f Dockerfile.ansible -t ${REG}sagdevops-ansible-base:${SAGDEVOPS_ANSIBLE_RELEASE} --build-arg BASE_IMAGE=${SAGDEVOPS_BASE_IMAGE} --build-arg ANSIBLE_RELEASE=${SAGDEVOPS_ANSIBLE_RELEASE}  .
```

Then, build the common utils image:

```
docker build --rm -f Dockerfile -t ${REG}sagdevops-ansible-common-utils:${TAG} --build-arg BASE_ANSIBLE_IMAGE=${REG}sagdevops-ansible-base:${SAGDEVOPS_ANSIBLE_RELEASE}  .
```

This will create 2 containers:
 - ${REG}sagdevops-ansible-base:${SAGDEVOPS_ANSIBLE_RELEASE}
 - ${REG}sagdevops-ansible-common-utils:${TAG}

### Testing validity of the containers

Test apigateway-rest-configurator:

```
docker run ${REG}sagdevops-ansible-common-utils:${TAG} ping.yml
```

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
