###############################################################################
#        Copyright (C) 2020        Sebastian Francisco Colomar Bauza          #
#        Copyright (C) 2020        Alejandro Colomar Andrés                   #
#        SPDX-License-Identifier:  GPL-2.0-only                               #
###############################################################################

##	alpine/git:latest
FROM	alpine/git@sha256:8d2aedf3898243892d170f033603b40a55e0b0a8ab68ba9762f9c0dae40b5c8d \
			AS git

RUN									\
	git clone							\
	    --single-branch						\
	    --branch bind						\
	    https://github.com/secobau/dns.alejandro-colomar.git \
	    /repo

###############################################################################

##	alpine:latest
FROM	alpine@sha256:39eda93d15866957feaee28f8fc5adb545276a64147445c64992ef69804dbf01 \
			AS dns

RUN	apk add	--no-cache --upgrade bind

## configure dns server
COPY	--from=git	/repo/etc/bind/named.conf			\
			/etc/bind/named.conf
COPY	--from=git	/repo/var/bind/pri/				\
			/var/bind/pri

CMD	["named", "-g"]

###############################################################################
