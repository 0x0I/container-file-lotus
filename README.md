<p><img src="https://avatars1.githubusercontent.com/u/12563465?s=200&v=4" alt="OCI logo" title="oci" align="left" height="70" /></p>
<p><img src="https://docs.lotu.sh/static/logo-512.png" alt="lotus logo" title="lotus" align="right" height="90" /></p>

Container File :cherry_blossom: :link: Lotus
=========
![GitHub release (latest by date)](https://img.shields.io/github/v/release/0x0I/container-file-lotus?color=yellow)
[![Build Status](https://travis-ci.org/0x0I/container-file-lotus.svg?branch=master)](https://travis-ci.org/0x0I/container-file-lotus)
[![Docker Pulls](https://img.shields.io/docker/pulls/0labs/0x01.lotus?style=flat)](https://hub.docker.com/repository/docker/0labs/0x01.lotus)
[![License: MIT](https://img.shields.io/badge/License-MIT-blueviolet.svg)](https://opensource.org/licenses/MIT)

**Table of Contents**
  - [Supported Platforms](#supported-platforms)
  - [Requirements](#requirements)
  - [Environment Variables](#environment-variables)
      - [Install](#install)
      - [Config](#config)
      - [Launch](#launch)
  - [Dependencies](#dependencies)
  - [Example Run](#example-run)
  - [License](#license)
  - [Author Information](#author-information)

Container file that installs, configures and launches Lotus: an implementation of the Filecoin distributed storage network protocol written in Go.

##### Supported Platforms:
```
* Redhat(CentOS/Fedora)
* Debian
```

Requirements
------------

None 

Environment Variables
--------------
Variables are available and organized according to the following software & machine provisioning stages:
* _install_
* _config_
* _launch_

#### Install

...*description of installation related vars*...

#### Config

...*description of configuration related vars*...

#### Launch

...*description of launch related vars*...

Dependencies
------------

None

Example Run
----------------
default example:
```
podman run \
  --env NAME=value \
  0labs/0x01.<service>:<tag> \
```

License
-------

MIT

Author Information
------------------

This Containerfile was created in 2020 by O1.IO.
