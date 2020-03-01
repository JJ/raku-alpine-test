FROM alpine:latest

ARG VER="2020.02.1"
LABEL version="1.0.0" maintainer="JJMerelo@GMail.com" rakuversion=$VER

# Environment
ENV PATH="/root/raku-install/bin:/root/raku-install/share/perl6/site/bin:/root/.rakudobrew/bin:${PATH}" \
    PKGS="curl git" \
    PKGS_TMP="perl curl-dev linux-headers make gcc musl-dev wget" \
    ENV="/root/.profile"

# Basic setup, programs and init
RUN mkdir /home/raku \
    && apk update && apk upgrade \
    && apk add --no-cache $PKGS $PKGS_TMP \
    && curl -L https://github.com/JJ/raku-alpine-test/files/4270965/MoarVM-2020.02.1.tar.gz | tar xvfz - \
    && cd MoarVM-2020.02.1/ \
    && perl Configure.pl && make

# Runtime
WORKDIR /home/raku
ENTRYPOINT ["raku"]
