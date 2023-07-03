#!/bin/bash -e

podman run --name gerrit \
           -p 29418:29418 \
           -p 8080:8080 \
           -v /home/gerrit/site/db:/site/db \
           -v /home/gerrit/site/etc:/site/etc \
           -v /home/gerrit/site/git:/site/git \
           -v /home/gerrit/site/index:/site/index \
           -v /home/gerrit/site/cache:/site/cache \
           -e CANONICAL_WEB_URL=http://192.168.1.1:8080/
           --detach gerrit:3.2.12
