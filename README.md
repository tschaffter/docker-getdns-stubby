# Stubby

[![GitHub Release](https://img.shields.io/github/release/tschaffter/getdns-stubby.svg?include_prereleases&color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&logo=github)](https://github.com/tschaffter/getdns-stubby/releases)
[![GitHub CI](https://img.shields.io/github/workflow/status/tschaffter/getdns-stubby/CI.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&logo=github)](https://github.com/tschaffter/getdns-stubby/actions)
[![GitHub License](https://img.shields.io/github/license/tschaffter/getdns-stubby.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&logo=github)](https://github.com/tschaffter/getdns-stubby/blob/develop/LICENSE)
[![Docker Pulls](https://img.shields.io/docker/pulls/tschaffter/getdns-stubby.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=pulls&logo=docker)](https://hub.docker.com/r/tschaffter/getdns-stubby)

Docker image for Stubby

## Overview

## Acknowledgments

The Dockerfile is adapted from the one available in the repository
[yegle/stubby-docker].

## Versioning

### GitHub tags

This repository uses [semantic versioning] to track the releases of this
project. This repository uses "non-moving" GitHub tags, that is, a tag will
always point to the same git commit identifier once it has been created.

### Docker tags

The artifact published by this repository is a Docker image. The version of the
image is aligned with the version of getdns, not the release versions of this
GitHub repository. The motivation behind this strategy is that the tag directly
informs the user on the version of getdns that is being deployed.

The table below describes the image tags available.

| Tag name   | Moving   | Description  |
|---|---|---|
| `latest`  | Yes   | Latest stable release   |
| `edge`  | Yes   | Lastest commit made to the default branch  |
| `<major>` | Yes   | Latest stable release for the getdns major version `<major>` |
| `<major>.<minor>` | Yes | Latest stable release for the getdns version `<major>.<minor>` |
| `<major>.<minor>-<sha>` | No | Same as above but with the reference to the git commit |

You should avoid using a moving tag like `latest` when deploying containers in
production, because this makes it hard to track which version of the image is
running and hard to roll back. If you prefer to use the latest version available
without manually updating your configuration and reproducibility is secondary,
then it makes sense to use a moving tag.

## License

[Apache License 2.0]

<!-- Links -->

[yegle/stubby-docker]: https://github.com/yegle/stubby-docker
[Apache License 2.0]: https://github.com/tschaffter/stubby/blob/main/LICENSE
[getdnsapi/getdns]: https://github.com/getdnsapi/getdns
