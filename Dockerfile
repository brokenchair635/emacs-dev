FROM alpine:latest

RUN apk add \
    build-base \
    git \
    autoconf \
    texinfo \
    gnutls-dev \
    pkgconfig \
    libgccjit-dev \
    ncurses-dev \
    acl-dev \
    attr-dev && \
    rm -rf /var/lib/apk/lists/* && \
    git clone https://github.com/emacs-mirror/emacs.git && \
    cd emacs && \
    ./autogen.sh && \
    ./configure --with-x-toolkit=no --without-pop --without-xft --without-jpeg --without-xpm --without-gif --without-tiff --without-xaw3d --without-gsettings --without-xdbe --without-xinput2 --without-dbus && \
    make && \
    make install && \
    cd / && \
    rm -rf emacs && \
    rm -rf /root/.emacs.d/* && \
    git clone https://github.com/brokenchair635/emacsd.git /root/.emacs.d/ && \
    apk del \
    autoconf \
    texinfo

WORKDIR /root/

CMD ["emacs"]
