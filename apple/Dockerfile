## TODO: This is broken because of the approx proxy change.

FROM debian:latest

ENV DEBIAN_FRONTEND=noninteractive
ENV DOCKER=true
ENV GRUB_INSTALL=yes

RUN apt-get update

RUN apt-get install --yes \
    sudo \
    git \
    vim \
    curl \
    build-essential \
    lsb-release \
    approx \
    procps \
    lsof \
    cpio \
    grub-efi-arm64 \
    grub-efi-arm64-bin \
    netcat-openbsd

RUN rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash builder && \
    echo 'builder ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/builder && \
    chmod 440 /etc/sudoers.d/builder

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh

USER builder

RUN git clone https://github.com/derivative-maker/derivative-maker.git /home/builder/derivative-maker

WORKDIR /home/builder/derivative-maker

RUN git checkout containerized-arm-builds

CMD ["/bin/bash", "-c", "/usr/local/bin/entrypoint.sh"]
