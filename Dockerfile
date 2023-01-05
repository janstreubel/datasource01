# base image Red Hat UBI8 Init
FROM registry.access.redhat.com/ubi8/ubi-init:8.7-9

# variable declaration for build usage only
ARG varRootPass
ARG varPdbuserPass

# set root password
RUN varRootPass=trustno1 varPdbuserPass=pdbuser; \ 
		echo "root:{$varRootPass}" | chpasswd ; \
		useradd -g users -d /home/pdbuser -m -p pdbuser -s /bin/bash pdbuser; \
		echo "pdbuser:{$varPdbuserPass}" | chpasswd ; \
		echo "echo from build" > /tmp/echo.log

USER pdbuser