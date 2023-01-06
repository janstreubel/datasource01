# base image Red Hat UBI8 Init
FROM registry.access.redhat.com/ubi8/ubi-init:8.7-9

# subscription needed
# FROM registry.access.redhat.com/rhel7:7.9-887

ARG varRootPass
ARG varPdbuserPass

RUN echo ${varRootPass} > /tmp/build.log
RUN varRootPass=trustno1 varPdbuserPass=pdbuser; \
		echo "root:{$varRootPass}" | chpasswd

RUN useradd -g users -d /home/pdbuser -m -p pdbuser -s /bin/bash pdbuser; \ 
	echo "pdbuser:{$varPdbuserPass}" | chpasswd 
	
# ksh removed
# RUN yum -y install less bzip2 hostname openssh openssh-server openssh-clients openssl-libs sudo zip unzip java-1.8.0-openjdk-devel 

# usermod -aG sudo pdbuser

# switch from root to pdbuser
# USER pdbuser