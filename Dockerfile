FROM ubuntu:16.04

ENV PUPPET_AGENT_VERSION="5.5.1" UBUNTU_CODENAME="xenial"

RUN apt-get update && \
    apt-get install --no-install-recommends -y wget ca-certificates lsb-release && \
    wget https://apt.puppetlabs.com/puppet5-release-"$UBUNTU_CODENAME".deb && \
    dpkg -i puppet5-release-"$UBUNTU_CODENAME".deb && \
    rm puppet5-release-"$UBUNTU_CODENAME".deb && \
    apt-get update && \
    apt-get install --no-install-recommends -y puppet-agent="$PUPPET_AGENT_VERSION"-1"$UBUNTU_CODENAME" && \
    apt-get remove --purge -y wget && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -f /etc/puppetlabs/puppet/hiera.yaml

ENV PATH=/opt/puppetlabs/server/bin:/opt/puppetlabs/puppet/bin:/opt/puppetlabs/bin:$PATH

WORKDIR /etc/puppetlabs/code/environments/production
ENTRYPOINT ["/opt/puppetlabs/bin/puppet"]
CMD ["apply", "manifests/site.pp"]
