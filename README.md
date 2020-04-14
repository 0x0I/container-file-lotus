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
* Ubuntu
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

_The following variables can be customized to control aspects of the installation process for both the Lotus client and storage miner involving where operational artifacts are stored._

`$LOTUS_PATH:` (**default**: <string> `/root/.lotus/`)
- path within container the `lotus` service should establish as its runtime configuration and data directory
  
`$LOTUS_STORAGE_PATH:` (**default**: <string> `/root/.lotusstorage/`)
- path within container the `lotus-storage-miner` service should establish as its runtime and data storage directory.

#### Config

Configuration of the `lotus` client can be expressed in a config file written in [TOML](https://github.com/toml-lang/toml), a minimal markup language. **Note:** This file can be found under the directory specified by the `LOTUS_PATH` (for the lotus client/service) or `LOTUS_STORAGE_PATH` (for the lotus miner) environment variables. For an idea of the available configuration options, reference this [example](https://gist.github.com/0x0I/dd3e7e4fbb1b9feaf147c216ebfacff0) (installed by default).

_The following variables can be customized to manage the content of this TOML configuration:_
 
`$CONFIG_<section-keyword>_<section-property> = <property-value (string)>` **default**: *None*

* Any configuration setting/value key-pair supported by `lotus` should be expressible within each `CONFIG_*` environment variable and properly rendered within the associated TOML config. **Note:** `<section-keyword>` along with the other property specifications should be written as expected to be rendered within the associated `TOML` config (**e.g.** *Libp2p*).

Furthermore, configuration is not constrained by hardcoded author defined defaults or limited by pre-baked templating. If the config section, setting and value are recognized by the `lotus` tool, :thumbsup: to define within an environnment variable according to the following syntax.

  `<section-keyword>` -- represents TOML config sections:
  ```bash
  # [TOML Section 'Metrics']
  CONFIG_Metrics_<section-property>=<property-value>
  ```
  
  `<section-property>` -- represents a specific TOML config section property to configure:
  
  ```bash
  # [TOML Section 'Metrics']
  # Property: PubsubTracing
  CONFIG_Metrics_PubsubTracing=<property-value>
  ```

  `<property-value>` -- represents property value to configure:
  ```bash
  # [TOML Section 'Metrics']
  # Property: PubsubTracing
  # Value: true
  CONFIG_Metrics_PubsubTracing=true # enable publish-subscription tracing for performance monitoring/troubleshooting 
  ```
  
#### Launch

Running of the `lotus` client and API server as well as the `lotus-storage-miner` service is accomplished utilizing official **Lotus** binaries, obtained from *Filecoin's Lotus* github [site](https://github.com/filecoin-project/lotus/releases). Launched subject to the configuration and execution potential provided by the underlying application, the aforementioned `lotus` executables can be set to adhere to system administrative policies right for your environment and organization.

_The following variables can be customized to manage the Lotus client and Lotus Storage miner execution profiles/policies:_

`$MANAGED_SERVICES = <lotus|lotus-storage-miner>` (**default**: )
- list of Lotus services to manage and launch

`$EXTRA_ARGS: <lotus-cli-options>` (**default**: *NONE*)
- list of `lotus daemon` commandline arguments to pass to the binary at runtime for customizing launch

See [here](https://gist.github.com/0x0I/53533099efcee8c87a49301e79358a0a) for an example of the `lotus daemon`'s cli.
  
`$EXTRA_MINER_ARGS: <lotus-storage-miner-cli-options>` (**default**: *NONE*)
- list of `lotus-storage-miner run` commandline arguments to pass to the binary at runtime for customizing launch.

See [here](https://gist.github.com/0x0I/71b7a7c25a7f558d4fd9f0ff39a896d6) for an example of the `lotus-storage-miner run`'s cli.

Dependencies
------------

None

Example Run
----------------
default example:
```bash
podman run 0labs/0x01.lotus:0.2.10_ubuntu-19.04
```

only manage launch of the `lotus` client and API server:
```bash
podman run --env MANAGED_SERVICES=lotus 0labs/0x01.lotus:0.2.10_ubuntu-19.04
```

expose `lotus` API/JSON-RPC server on non-loopback (wildcard/*) address
```bash
podman run --env CONFIG_API_ListenAddress= /ip4/0.0.0.0/tcp/1234/http \
           --env CONFIG_Libp2p_ListenAddress=/ip4/0.0.0.0/tcp/1234/http \
           0labs/0x01.lotus:0.2.10_fedora-31
```

launch `lotus` service and `lotus-storage-miner` agents with custom runtime/storage paths and launch options:
```bash
podman run --env MANAGED_SERVICES="lotus lotus-storage-miner" \
           --env LOTUS_PATH=/mnt/lotus \
           --env LOTUS_STORAGE_PATH=/mnt/lotus/miner \
           --env CONFIG_Metrics_Nickname=example_miner \
           --env EXTRA_ARGS=--bootstrap \
           --env EXTRA_MINER_ARGS=--nosync \
           0labs/0x01.lotus:0.2.10_debian-10
```

License
-------

MIT

Author Information
------------------

This Containerfile was created in 2020 by O1.IO.
