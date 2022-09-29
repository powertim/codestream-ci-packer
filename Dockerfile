FROM photon:latest
LABEL maintainer="blog.v12n.io"

ENV PACKER_VERSION=1.7.10

# Update packages and install new ones
RUN tdnf -y install curl unzip git wget tar gzip gawk bindutils jq coreutils openssl xorriso

ADD https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip ./

RUN unzip packer_${PACKER_VERSION}_linux_amd64.zip -d /bin
RUN rm -f packer_${PACKER_VERSION}_linux_amd64.zip