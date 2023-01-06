# base image Red Hat UBI8 Init
FROM registry.access.redhat.com/ubi8/ubi-init:8.7-9

# variable declaration for build usage only
ARG varRootPass
ARG varPdbuserPass

# set root password
RUN varRootPass=trustno1 varPdbuserPass=pdbuser; \
		echo "root:{$varRootPass}" | chpasswd

# add pdbuser and set password
RUN useradd -g users -d /home/pdbuser -m -p pdbuser -s /bin/bash pdbuser; \
		echo "pdbuser:{$varPdbuserPass}" | chpasswd ; \ 
yum -y install less ksh bzip2 hostname openssh openssh-server openssh-clients openssl-libs sudo zip unzip java-1.8.0-openjdk-devel ; \
usermod -aG sudo pdbuser

# switch from root to pdbuser
USER pdbuser