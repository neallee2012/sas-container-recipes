#
# Copyright 2018 SAS Institute Inc.
#
# This work is licensed under a Creative Commons Attribution 4.0 International License.
# You may obtain a copy of the License at https://creativecommons.org/licenses/by/4.0/ 
#


FROM centos:7
MAINTAINER Neal Lee "neal.lee@sas.com"

#
# see https://hub.docker.com/_/centos/
# these entries from "Dockerfile for a systemd base image" Section
#
ENV container docker
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;\
yum -y install yum-plugin-ovl 

VOLUME [ "/sys/fs/cgroup" ]
CMD ["/usr/sbin/init"]

RUN rpmdb --rebuilddb; \
    yum -y install epel-release; \
    yum -y install \
       bzip2 \
       deltarpm \
       git \
       initscripts \
       iproute \
       java-1.8.0-openjdk \
       libpng12 \
       libXp \
       libXmu \
       lsof \
       mod_ssl \
       net-tools \
       numactl \
       openssh-clients \
       openssh-server \
       openssl \
       sudo \
       zip unzip \
       which \
       wget \
       ; \
    yum clean all

# install anaconda/python
ENV anaREPO="https://repo.continuum.io/archive" \
    anaVERSION="3-5.2.0" \
    swatRELEASE="https://github.com/sassoftware/python-swat/releases" \
    swatVERSION="1.5.0"

RUN wget -q -O /tmp/anaconda.shar ${anaREPO}/Anaconda${anaVERSION}-Linux-x86_64.sh; \
   bash /tmp/anaconda.shar -p /opt/anaconda3 -b; \
   /opt/anaconda3/bin/conda update conda; \
   /opt/anaconda3/bin/pip install sas_kernel; \
   /opt/anaconda3/bin/pip install ${swatRELEASE}/download/v${swatVERSION}/python-swat-${swatVERSION}-linux64.tar.gz; \
   /opt/anaconda3/bin/pip install msgpack; \
   /opt/anaconda3/bin/pip install sas-dlpy
   
Run /opt/anaconda3/bin/pip install inflection; \
   /opt/anaconda3/bin/pip install pandas==0.23.0; \
   /opt/anaconda3/bin/pip install numpy==1.14.3; \
   /opt/anaconda3/bin/pip install scikit-learn==0.20.3; \
   /opt/anaconda3/bin/pip install xgboost==0.82; \
   /opt/anaconda3/bin/pip install git+https://twnnel:oymjG8nykWqP1nycsAZS@gitlab.sas.com/SAS-AP/viya-py-api.git@7566eb1290bce84d459cc0e40e909e92a423ab3a; \
   rm /tmp/anaconda.shar

RUN groupadd -g 1001 sas; \
    useradd -u 1003 -g sas sasdemo;


COPY files/start.sh /start.sh

COPY files/vault-deployTarget-ca.crt /opt/sas/viya/config/etc/SASSecurityCertificateFramework/cacerts/trustedcerts.pem
ENTRYPOINT ["/start.sh"]
