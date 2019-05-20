# LibrePCB CLI Docker Image

[![Docker Stars](https://img.shields.io/docker/stars/librepcb/librepcb-cli.svg)](https://hub.docker.com/r/librepcb/librepcb-cli/)
[![Docker Pulls](https://img.shields.io/docker/pulls/librepcb/librepcb-cli.svg)](https://hub.docker.com/r/librepcb/librepcb-cli/)

This repository contains the official [LibrePCB CLI](http://librepcb.org)
Docker image which is used for easily using the LibrePCB CLI, e.g. for
continuous integration of LibrePCB libraries and projects.

The Dockerfiles are available at
[GitHub](https://github.com/LibrePCB/docker-librepcb-cli) and the built image
is hosted at [Docker Hub](https://hub.docker.com/r/librepcb/librepcb-cli/).


## Details

The image is based on [Alpine Linux](https://alpinelinux.org/) and has the
`librepcb-cli` executable set as entrypoint. The working directory is set to
`/work` (which is empty).


## Tags

The tags of the image corresponds to the official release tags of LibrePCB
itself.


## Usage

Mount your LibrePCB project or library to `/work` and pass the LibrePCB CLI
arguments to `docker run`:

```bash
docker run -it --rm -v `pwd`:/work librepcb/librepcb-cli open-project --help
```


## License

The content in this repository is published under the
[GNU GPLv3](http://www.gnu.org/licenses/gpl-3.0.html) license.
