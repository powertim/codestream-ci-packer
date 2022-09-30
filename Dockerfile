FROM v12nio/codestream-ci:latest as baseimage
LABEL maintainer="blog.v12n.io"

ENV PACKER_VERSION=1.7.10

# Update packages and install new ones
RUN tdnf install -y xorriso && \
    tdnf clean all

# Install Packer
FROM baseimage as packerimage

ADD https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip ./

RUN unzip packer_${PACKER_VERSION}_linux_amd64.zip -d /bin
RUN rm -f packer_${PACKER_VERSION}_linux_amd64.zip

# Final tidy
FROM packerimage as finalimage
RUN tdnf autoremove -y && \
    tdnf clean all