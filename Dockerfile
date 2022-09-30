FROM v12nio/codestream-ci:latest as baseimage
ARG VERSION
LABEL maintainer="blog.v12n.io"
LABEL version="$VERSION"

# Update packages and install new ones
RUN tdnf install -y xorriso && \
    tdnf clean all

# Install Packer
FROM baseimage as packerimage

ADD https://releases.hashicorp.com/packer/${VERSION}/packer_${VERSION}_linux_amd64.zip ./
ADD VERSION .

RUN unzip packer_${VERSION}_linux_amd64.zip -d /bin
RUN rm -f packer_${VERSION}_linux_amd64.zip

# Final tidying
FROM packerimage as finalimage
RUN tdnf autoremove -y && \
    tdnf clean all