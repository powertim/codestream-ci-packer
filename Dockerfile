FROM alpine
LABEL maintainer="blog.v12n.io"
LABEL version="0.0.1"

EXPOSE 8601-8610/tcp

# Install wget and unzip
RUN apk -U upgrade \
  && apk add curl unzip

# Install Packer
ENV PACKER_BIN_DIR /usr/local/packer/bin
RUN mkdir --parents $PACKER_BIN_DIR 
ENV PACKER_ZIP=https://releases.hashicorp.com/packer/1.6.0/packer_1.6.0_linux_amd64.zip
RUN curl -sSLo /tmp/packer.zip $PACKER_ZIP && \
  unzip /tmp/packer.zip -d $PACKER_BIN_DIR && \
  rm /tmp/packer.zip
ENV PATH $PATH:$PACKER_BIN_DIR

# Check that packer is correctly installed
RUN type packer

# Install Packer Windows Update Provisioner
ENV PACKER_WU_TAR=https://github.com/rgl/packer-provisioner-windows-update/releases/download/v0.9.0/packer-provisioner-windows-update-linux.tgz

RUN curl -sSLo /tmp/packer-wu.tar.gz $PACKER_WU_TAR && \
  tar -zxvf /tmp/packer-wu.tar.gz --directory $PACKER_BIN_DIR && \
  rm /tmp/packer-wu.tar.gz