#!/bin/bash

# This script is meant to be sourced.


OS="$(. /etc/os-release; echo "$ID:$VERSION_ID")"


case "$OS" in
    'centos:7')
        # openssl 1.0

        yum install -y openssl-libs softhsm

        export PKCS11_LIB_PATH='/usr/lib64/libsofthsm2.so'

        mkdir -p /var/lib/softhsm/tokens
        ;;

    'debian:9'|'debian:10'|'ubuntu:18.04'|'ubuntu:20.04')
        # openssl 1.1.0 for Debian 9, 1.1.1 for the others

        apt-get update -y
        DEBIAN_FRONTEND=noninteractive TZ=UTC apt-get install -y libssl1.1 softhsm

        export PKCS11_LIB_PATH='/usr/lib/softhsm/libsofthsm2.so'

        mkdir -p /var/lib/softhsm/tokens
        ;;

    *)
        echo "Unsupported OS $OS" >&2
        exit 1
esac
