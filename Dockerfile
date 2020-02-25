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
    && curl -L https://github.com/MoarVM/MoarVM/releases/download/2020.01.1/MoarVM-2020.01.1.tar.gz | tar xvfz - \
    && cd MoarVM-2020.01.1/ \
    && CFLAGS="-fPIC -DDL_USE_GLIBC_ITER_PHDR" perl Configure.pl && make

# Runtime
WORKDIR /home/raku
ENTRYPOINT ["raku"]
