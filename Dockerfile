FROM debian:10.9-slim as stubby

ARG GETDNS_VERSION="1.6.0"
ENV GETDNS_VERSION=${GETDNS_VERSION}

SHELL ["/bin/bash", "-euxo", "pipefail", "-c"]

# hadolint ignore=DL3008
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential \
        ca-certificates \
        check \
        cmake \
        dirmngr \
        git \
        gpg \
        gpg-agent \
        libev-dev \
        libevent-dev \
        libssl-dev \
        libuv1-dev \
        libyaml-dev \
    && rm -rf \
        /tmp/* \
        /var/tmp/* \
        /var/lib/apt/lists/*

WORKDIR /tmp
COPY pgp/willem.nlnetlabs.nl /tmp/willem.nlnetlabs.nl

# PGP public key of Willem Toorop <willem@nlnetlabs.nl>:
# http://pgpkeys.uk/pks/lookup?search=willem%40nlnetlabs.nl&fingerprint=on&op=index
# hadolint ignore=DL3003
RUN gpg --import willem.nlnetlabs.nl \
    && git clone --recurse-submodules https://github.com/getdnsapi/getdns.git getdns \
    && cd getdns \
    && git checkout tags/v${GETDNS_VERSION} \
    && git verify-tag v${GETDNS_VERSION} \
    && cmake -DUSE_LIBIDN2=OFF -DENABLE_STUB_ONLY=ON -DBUILD_STUBBY=ON . \
    && make \
    && make install \
    && strip -s /usr/local/bin/getdns_server_mon \
    && strip -s /usr/local/bin/stubby \
    && strip -s /usr/local/lib/libgetdns.so.10

FROM debian:10.9-slim

SHELL ["/bin/bash", "-euxo", "pipefail", "-c"]

# hadolint ignore=DL3008
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        gosu \
        libssl-dev \
        libyaml-dev \
    && rm -rf \
        /tmp/* \
        /var/tmp/* \
        /var/lib/apt/lists/*

COPY --from=stubby /usr/local/lib/libgetdns.so.10 /lib/x86_64-linux-gnu/
COPY --from=stubby /usr/local/bin/stubby /bin/
COPY --from=stubby /usr/local/bin/getdns_server_mon /bin/
COPY --from=stubby /tmp/getdns/stubby/stubby.yml.example /usr/local/etc/stubby/stubby.yml
# COPY --from=stubby /usr/lib/x86_64-linux-gnu/libyaml-0.so.2 /lib/x86_64-linux-gnu/

RUN adduser --system --no-create-home stubby

WORKDIR /
COPY docker-entrypoint.sh .
RUN chmod +x docker-entrypoint.sh

EXPOSE 53/tcp
EXPOSE 53/udp

# HEALTHCHECK CMD ["/bin/getdns_server_mon", "-M", "-t", "@127.0.0.1", "lookup", "google.com"]

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["stubby"]