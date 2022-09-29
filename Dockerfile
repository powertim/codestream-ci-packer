FROM v12nio/codestream-ci:latest as baseimage
LABEL maintainer="blog.v12n.io"

ENV PACKER_VERSION=1.7.10

# Update packages and install new ones
RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install --no-install-recommends xorriso -y
RUN apt-get clean

FROM baseimage as packerimage

ADD https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip ./

RUN unzip packer_${PACKER_VERSION}_linux_amd64.zip -d /bin
RUN rm -f packer_${PACKER_VERSION}_linux_amd64.zip

FROM packerimage as finalimage
RUN apt-get clean