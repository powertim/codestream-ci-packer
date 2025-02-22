FROM photon:latest
ARG VERSION
LABEL maintainer="github.com/powertim"
LABEL version="$VERSION"
ENV LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8

# Update packages and install new ones
RUN tdnf install -y curl unzip git wget tar bindutils coreutils xorriso jq mkpasswd ansible python3-pip && \
    pip3 install pip --upgrade
    
# Copy pip requirements file
ADD requirements.txt .

# Install pip requirements & cleanup
RUN pip3 install -r requirements.txt && \
    tdnf remove -y python3-pip && \
    tdnf autoremove -y && \
    tdnf clean all

# Install Packer
ADD https://releases.hashicorp.com/packer/${VERSION}/packer_${VERSION}_linux_amd64.zip ./
RUN unzip packer_${VERSION}_linux_amd64.zip -d /bin && \
    rm -f packer_${VERSION}_linux_amd64.zip

# Complete
ADD VERSION .
