FROM v12nio/codestream-ci:latest
LABEL maintainer="blog.v12n.io"

# Set working directory
WORKDIR /packer

# Install Packer
ENV PACKER_BIN_DIR=/usr/local/bin
ENV PACKER_ZIP=https://releases.hashicorp.com/packer/1.6.1/packer_1.6.1_linux_amd64.zip
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
    chmod 755 $PACKER_BIN_DIR/packer-provisioner-windows-update && \
    rm /tmp/packer-wu.tar.gz