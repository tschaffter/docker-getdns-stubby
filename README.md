# Stubby Docker image

[![GitHub Release](https://img.shields.io/github/release/tschaffter/docker-getdns-stubby.svg?include_prereleases&color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&logo=github)](https://github.com/tschaffter/docker-getdns-stubby/releases)
[![GitHub CI](https://img.shields.io/github/workflow/status/tschaffter/docker-getdns-stubby/CI.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&logo=github)](https://github.com/tschaffter/docker-getdns-stubby/actions)
[![GitHub License](https://img.shields.io/github/license/tschaffter/docker-getdns-stubby.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&logo=github)](https://github.com/tschaffter/docker-getdns-stubby/blob/develop/LICENSE)
[![Docker Pulls](https://img.shields.io/docker/pulls/tschaffter/getdns-stubby.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=pulls&logo=docker)](https://hub.docker.com/r/tschaffter/getdns-stubby)

## Introduction

[Stubby] is an application that acts as a local DNS Privacy stub resolver (using
DNS-over-TLS). Stubby encrypts DNS queries sent from a client machine (desktop
or laptop) to a DNS Privacy resolver increasing end user privacy.

Stubby is developed by the getdns team. This project builds Stubby from its
source using the instruction available in the GitHub repository
[getdnsapi/stubby].

<img alt="getdns" src="https://raw.githubusercontent.com/tschaffter/docker-getdns-stubby/main/images/getdns.svg" height="100px">

Stubby provides DNS Privacy by:

- Using a default configuration which provides Strict Privacy and uses a subset
  of the available [DNS Privacy servers] that support DNS-over-TLS. These
  servers can be replaced by the servers of a paid alternative, for example
  those provided by [NextDNS].
- Distributing queries across all the servers specified so that the full picture
  of your queries is not captured by a single DNS provider
  (`round_robin_upstreams: 1`).
- Enabling Domain Name System Security Extension (DNSSEC) validation. Cloudflare
  provides an [intuitive description of how DNSSEC works].


## Contents

TBA


## Specification

- Project version: 1.1.4
- Getdns version: 1.6.0
- Docker image: [tschaffter/getdns-stubby]


## Requirements

- [Docker Engine] >=19.03.0


## Usage

### Quickstart

1. Start Stubby using Docker: `docker compose up -d`
2. Resolve the IP address of `github.com` using [dig] and Stubby:

    ```console
    dig @localhost +noall +answer +stats github.com
    github.com.             17      IN      A       140.82.121.4
    ;; Query time: 156 msec
    ;; SERVER: 127.0.0.1#53(127.0.0.1)
    ;; WHEN: Mon Mar 29 07:55:58 PDT 2021
    ;; MSG SIZE  rcvd: 413
    ```

3. Stop Stubby: `docker stop stubby`

### Configuration

The default configuration file of Stubby is
[stubby.yml.example](stubby.yml.example).

By default, Stubby listen to the loopback interface of the host it is running
on, which can not be reached when running Stubby in a container. When starting
Stubby using Docker as described below, the configuration file
[stubby.yml](stubby.yml) is used where the value of the option
`listen_addresses` has been updated to enable Stubby to be reached from your
host or from another container as done in [tschaffter/dnsmasq-stubby].

```yaml
# Listen to all IPv4 and IPv6 addresses (within the container).
listen_addresses:
  - 0.0.0.0
  - 0:0:0:0:0:0:0:0
```

### Deploying using Docker

Start the Stubby server. Add the option `-d` or `--detach` to run in the
background.

    docker-compose up --build

To stop the server, enter `Ctrl+C` followed by `docker-compose down`. If running
in detached mode, you will only need to enter `docker-compose down`.


## Resolving domain names

[Dig] is a command line utility that performs DNS lookup by querying name
servers and displaying the result to you. After starting Stubby, run the
command below to resolve the IP address of github.com.

```console
dig @localhost +noall +answer +stats github.com
github.com.             17      IN      A       140.82.121.4
;; Query time: 156 msec
;; SERVER: 127.0.0.1#53(127.0.0.1)
;; WHEN: Mon Mar 29 07:55:58 PDT 2021
;; MSG SIZE  rcvd: 413
```

The response includes the following information:

- The IP address of github.com is 140.82.121.4 (may change over time).
- The response is returned by the server is 127.0.0.1#53 (Stubby).


## Versioning

### GitHub tags

This repository uses [semantic versioning] to track the releases of this
project. This repository uses "non-moving" GitHub tags, that is, a tag will
always point to the same git commit identifier once it has been created.

### Docker tags

The artifact published by this repository is a Docker image. The versions of the
image are aligned with the versions of getdns, not the versions of Stubby or the
GitHub tags of this repository.

The table below describes the image tags available.

| Tag name   | Moving   | Description  |
|---|---|---|
| `latest`  | Yes   | Latest stable release   |
| `edge`  | Yes   | Lastest commit made to the default branch  |
| `<major>` | Yes   | Latest stable release for the getdns major version `<major>` |
| `<major>.<minor>` | Yes | Latest stable release for the getdns version `<major>.<minor>` |
| `<major>.<minor>.<patch>` | Yes | Latest stable release for the getdns version `<major>.<minor>.<patch>` |
| `<major>.<minor>.<patch>-<sha>` | No | Same as above but with the reference to the git commit |

You should avoid using a moving tag like `latest` when deploying containers in
production, because this makes it hard to track which version of the image is
running and hard to roll back. If you prefer to use the latest version available
without manually updating your configuration and reproducibility is secondary,
then it makes sense to use a moving tag.

## Acknowledgments

The Dockerfile is adapted from the one available in the repository
[yegle/stubby-docker].

## License

[Apache License 2.0]

<!-- Links -->

[Stubby]: https://github.com/getdnsapi/stubby
[getdnsapi/stubby]: https://github.com/getdnsapi/stubby
[yegle/stubby-docker]: https://github.com/yegle/stubby-docker
[Apache License 2.0]: https://github.com/tschaffter/getdns-stubby/blob/main/LICENSE
[getdnsapi/getdns]: https://github.com/getdnsapi/getdns
[DNS Privacy servers]: https://dnsprivacy.org/wiki/x/E4AT
[NextDNS]: https://nextdns.io/
[intuitive description of how DNSSEC works]: https://www.cloudflare.com/dns/dnssec/how-dnssec-works/
[Dig]: https://en.wikipedia.org/wiki/Dig_(command)
[semantic versioning]: https://semver.org/
[tschaffter/dnsmasq-stubby]: https://github.com/tschaffter/dnsmasq-stubby
[tschaffter/getdns-stubby]: https://hub.docker.com/r/tschaffter/getdns-stubby
