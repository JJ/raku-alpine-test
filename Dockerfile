FROM alpine:latest

ARG VER="2020.02"
LABEL version="2.3.2" maintainer="JJMerelo@GMail.com" rakuversion=$VER

# Environment
ENV PATH="/root/raku-install/bin:/root/raku-install/share/perl6/site/bin:/root/.rakudobrew/bin:${PATH}" \
    PKGS="curl git" \
    PKGS_TMP="perl curl-dev linux-headers make gcc musl-dev wget" \
    ENV="/root/.profile"

# Basic setup, programs and init
RUN mkdir /home/raku \
    && apk update && apk upgrade \
    && apk add --no-cache $PKGS $PKGS_TMP \

# Add download of tar.gz here

# Runtime
WORKDIR /home/raku
ENTRYPOINT ["raku"]
