# base image Red Hat UBI8 Init
FROM registry.access.redhat.com/ubi8/ubi-init:8.7-9

# subscription needed
# FROM registry.access.redhat.com/rhel7:7.9-887

# define variables to store user passwords, visible in build only
ARG varRootPass
ARG varPdbuserPass

RUN << EOF
	varRootPass=trustno1
	echo "root:${varRootPass}" | chpasswd
	echo ${varRootPass} >> /tmp/build.log
	useradd -g users -d /home/pdbuser -m -p pdbuser -s /bin/bash pdbuser
	
	varPdbuserPass=pdbuser
	echo "pdbuser:${varPdbuserPass}" | chpasswd
	echo ${varPdbuserPass} >> /tmp/build.log
	
	yum -y install less bzip2 hostname openssh openssh-server openssh-clients openssl-libs sudo zip unzip java-1.8.0-openjdk-devel
	usermod -aG wheel pdbuser
EOF


# set password for root
# varRootPass=trustno1 echo "root:${varRootPass}" | chpasswd; \
# echo ${varRootPass} >> /tmp/build.log

# add user pdbuser
# useradd -g users -d /home/pdbuser -m -p pdbuser -s /bin/bash pdbuser

# set password for pdbuser
# varPdbuserPass=pdbuser 
# echo "pdbuser:${varPdbuserPass}" | chpasswd; echo ${varPdbuserPass} >> /tmp/build.log
	
# ksh removed, only available in official RHEL repository
# yum -y install less bzip2 hostname openssh openssh-server openssh-clients openssl-libs sudo zip unzip java-1.8.0-openjdk-devel 

# add user to wheel group (equals sudo group)
# usermod -aG wheel pdbuser

# switch from root to pdbuser
# USER pdbuser