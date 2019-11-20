# -*-makefile-*-
#
# Copyright (C) 2006 by Randall Loomis <rloomis@solectek.com>
#               2010 Michael Olbrich <m.olbrich@pengutronix.de>
#               2013 Alexander Dahl <post@lespocky.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_NET_SNMP) += net-snmp

#
# Paths and names
#
NET_SNMP_VERSION	:= 5.8
NET_SNMP_MD5		:= 63bfc65fbb86cdb616598df1aff6458a
NET_SNMP		:= net-snmp-$(NET_SNMP_VERSION)
NET_SNMP_SUFFIX		:= tar.gz
NET_SNMP_URL		:= $(call ptx/mirror, SF, net-snmp/$(NET_SNMP).$(NET_SNMP_SUFFIX))
NET_SNMP_SOURCE		:= $(SRCDIR)/$(NET_SNMP).$(NET_SNMP_SUFFIX)
NET_SNMP_DIR		:= $(BUILDDIR)/$(NET_SNMP)
NET_SNMP_LICENSE	:= MIT-CMU AND BSD-3-Clause AND MIT
NET_SNMP_LICENSE_FILES	:= file://COPYING;md5=9d100a395a38584f2ec18a8275261687

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

NET_SNMP_WRAPPER_BLACKLIST := TARGET_DEBUG_FULL

NET_SNMP_MIB_MODULES-y	:= $(call remove_quotes,$(PTXCONF_NET_SNMP_MIB_MODULES))
NET_SNMP_MIB_MODULES-	:= $(call remove_quotes,$(PTXCONF_NET_SNMP_WITHOUT_MIB_MODULES))
NET_SNMP_MIB_MODULES-$(PTXCONF_NET_SNMP_MIB_MODULES_AGENTX) += agentx
NET_SNMP_MIB_MODULES-$(PTXCONF_NET_SNMP_MIB_MODULES_UCD_SNMP) += ucd_snmp
NET_SNMP_MIB_MODULES-$(PTXCONF_NET_SNMP_MIB_MODULES_LM_SENSORS) += ucd-snmp/lmsensorsMib

ifndef PTXCONF_NET_SNMP_PCI
NET_SNMP_ENV := $(CROSS_ENV) netsnmp_cv_func_pci_lookup_name_LMIBLIBS=no
endif

#
# autoconf
#
NET_SNMP_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_IPV6_OPTION) \
	--with-defaults \
	--disable-manuals \
	--$(call ptx/wwo, PTXCONF_NET_SNMP_SHA_AES)-openssl \
	--with-mib-modules="$(NET_SNMP_MIB_MODULES-y)" \
	--with-out-mib-modules="$(NET_SNMP_MIB_MODULES-)" \
	--with-mibs=$(PTXCONF_NET_SNMP_DEFAULT_MIBS) \
	--with-logfile=$(call remove_quotes,$(PTXCONF_NET_SNMP_LOGFILE)) \
	--with-persistent-directory=$(call remove_quotes,$(PTXCONF_NET_SNMP_PERSISTENT_DIR)) \
	--with-default-snmp-version=$(call remove_quotes,$(PTXCONF_NET_SNMP_DEFAULT_VERSION)) \
	--enable-shared \
	--disable-embedded-perl \
	--without-perl-modules \
	--disable-static \
	--$(call ptx/endis, PTXCONF_NET_SNMP_PRIVACY)-privacy \
	--disable-internal-md5 \
	--with-endianness=$(call ptx/ifdef, PTXCONF_ENDIAN_LITTLE, little, big) \
	--$(call ptx/endis, PTXCONF_NET_SNMP_DOM_SOCK_ONLY)-agentx-dom-sock-only \
	--$(call ptx/endis, PTXCONF_NET_SNMP_MINI_AGENT)-mini-agent \
	--$(call ptx/endis, PTXCONF_NET_SNMP_AGENT)-agent \
	--$(call ptx/endis, PTXCONF_NET_SNMP_APPLICATIONS)-applications \
	--$(call ptx/endis, PTXCONF_NET_SNMP_SCRIPTS)-scripts \
	--$(call ptx/endis, PTXCONF_NET_SNMP_MIBS)-mibs \
	--$(call ptx/endis, PTXCONF_NET_SNMP_MIB_LOADING)-mib-loading \
	--$(call ptx/endis, PTXCONF_NET_SNMP_SNMPV1)-snmpv1 \
	--$(call ptx/endis, PTXCONF_NET_SNMP_SNMPV2C)-snmpv2c \
	--$(call ptx/endis, PTXCONF_NET_SNMP_DES)-des \
	--$(call ptx/endis, PTXCONF_NET_SNMP_MD5)-md5 \
	--$(call ptx/endis, PTXCONF_NET_SNMP_SNMPTRAPD)-snmptrapd-subagent \
	--$(call ptx/endis, PTXCONF_NET_SNMP_LOCAL_SMUX)-local-smux \
	--$(call ptx/endis, PTXCONF_NET_SNMP_DEVELOPER)-developer \
	--enable-mib-config-checking \
	--enable-mfd-rewrites \
	--disable-testing-code \
	--disable-reentrant \
	--disable-ucd-snmp-compatibility

ifdef PTXCONF_NET_SNMP_FORCE_DEBUGGING
NET_SNMP_AUTOCONF += --enable-debugging
endif

ifdef PTXCONF_NET_SNMP_STRIP_DEBUGGING
NET_SNMP_AUTOCONF += --disable-debugging
endif

NET_SNMP_MAKE_PAR := NO

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

NET_SNMP_MIBS :=

ifdef PTXCONF_NET_SNMP_MIBS

ifdef PTXCONF_NET_SNMP_V1MIBS
NET_SNMP_MIBS += RFC1155-SMI.txt RFC1213-MIB.txt RFC-1215.txt
endif

ifdef PTXCONF_NET_SNMP_V2MIBS
NET_SNMP_MIBS += SNMPv2-CONF.txt SNMPv2-SMI.txt SNMPv2-TC.txt \
			SNMPv2-TM.txt SNMPv2-MIB.txt
endif

ifdef PTXCONF_NET_SNMP_V3MIBS
NET_SNMP_MIBS += SNMP-FRAMEWORK-MIB.txt SNMP-MPD-MIB.txt \
			SNMP-TARGET-MIB.txt SNMP-NOTIFICATION-MIB.txt \
			SNMP-PROXY-MIB.txt SNMP-USER-BASED-SM-MIB.txt \
			SNMP-VIEW-BASED-ACM-MIB.txt \
			SNMP-COMMUNITY-MIB.txt TRANSPORT-ADDRESS-MIB.txt
endif

ifdef PTXCONF_NET_SNMP_AGENTMIBS
NET_SNMP_MIBS += AGENTX-MIB.txt SMUX-MIB.txt
endif

ifdef PTXCONF_NET_SNMP_IANAMIBS
NET_SNMP_MIBS += IANAifType-MIB.txt IANA-LANGUAGE-MIB.txt \
			IANA-ADDRESS-FAMILY-NUMBERS-MIB.txt
endif

ifdef PTXCONF_NET_SNMP_RFCMIBS
NET_SNMP_MIBS += IF-MIB.txt IF-INVERTED-STACK-MIB.txt \
			EtherLike-MIB.txt IP-MIB.txt \
			IP-FORWARD-MIB.txt IANA-RTPROTO-MIB.txt \
			TCP-MIB.txt UDP-MIB.txt INET-ADDRESS-MIB.txt \
			HCNUM-TC.txt HOST-RESOURCES-MIB.txt \
			HOST-RESOURCES-TYPES.txt RMON-MIB.txt \
			IPV6-TC.txt IPV6-MIB.txt IPV6-ICMP-MIB.txt \
			IPV6-TCP-MIB.txt IPV6-UDP-MIB.txt \
			DISMAN-EVENT-MIB.txt DISMAN-SCRIPT-MIB.txt \
			DISMAN-SCHEDULE-MIB.txt \
			NOTIFICATION-LOG-MIB.txt SNMP-USM-AES-MIB.txt \
			SNMP-USM-DH-OBJECTS-MIB.txt
endif

ifdef PTXCONF_NET_SNMP_NETSNMPMIBS
NET_SNMP_MIBS += NET-SNMP-TC.txt NET-SNMP-MIB.txt \
			NET-SNMP-AGENT-MIB.txt \
			NET-SNMP-EXAMPLES-MIB.txt \
			NET-SNMP-EXTEND-MIB.txt NET-SNMP-PASS-MIB.txt
endif

ifdef PTXCONF_NET_SNMP_UCDMIBS
NET_SNMP_MIBS += UCD-SNMP-MIB.txt UCD-DEMO-MIB.txt UCD-IPFWACC-MIB.txt \
			UCD-DLMOD-MIB.txt UCD-DISKIO-MIB.txt
endif

ifdef PTXCONF_NET_SNMP_LMSENSORS_MIB
NET_SNMP_MIBS += LM-SENSORS-MIB.txt
endif

ifdef PTXCONF_NET_SNMP_OTHERMIBS
NET_SNMP_MIBS += BRIDGE-MIB.txt IPV6-FLOW-LABEL-MIB.txt SCTP-MIB.txt \
			TUNNEL-MIB.txt
endif

endif

$(STATEDIR)/net-snmp.targetinstall:
	@$(call targetinfo)

	@$(call install_init, net-snmp)
	@$(call install_fixup, net-snmp,PRIORITY,optional)
	@$(call install_fixup, net-snmp,SECTION,base)
	@$(call install_fixup, net-snmp,AUTHOR,"Randall Loomis <rloomis@solectek.com>")
	@$(call install_fixup, net-snmp,DESCRIPTION,missing)

ifdef PTXCONF_NET_SNMP_AGENT
	@$(call install_lib, net-snmp, 0, 0, 0644, libnetsnmpagent)

# agent mib libs
	@$(call install_lib, net-snmp, 0, 0, 0644, libnetsnmpmibs)

# agent binary
	@$(call install_copy, net-snmp, 0, 0, 0755, -, /usr/sbin/snmpd)

# agent helper libs
	@$(call install_lib, net-snmp, 0, 0, 0644, libnetsnmphelpers)

# agent configuration
	@$(call install_alternative, net-snmp, 0, 0, 0644, /etc/snmp/snmpd.conf)
endif

ifdef PTXCONF_NET_SNMP_APPLICATIONS
# apps libs
	@$(call install_lib, net-snmp, 0, 0, 0644, libnetsnmptrapd)

# apps binaries
##ifdef PTXCONF_NET_SNMP_MINI_AGENT
##	@$(call install_copy, net-snmp, 0, 0, 0755, $(NET_SNMP_DIR)/apps/.libs/lt-snmpget, /usr/bin/lt-snmpget)
##	@$(call install_copy, net-snmp, 0, 0, 0755, $(NET_SNMP_DIR)/apps/.libs/lt-snmpwalk, /usr/bin/lt-snmpwalk)
##endif
	@$(call install_copy, net-snmp, 0, 0, 0755, -, /usr/bin/snmpbulkget)
	@$(call install_copy, net-snmp, 0, 0, 0755, -, /usr/bin/snmpbulkwalk)
	@$(call install_copy, net-snmp, 0, 0, 0755, -, /usr/bin/snmpdelta)
	@$(call install_copy, net-snmp, 0, 0, 0755, -, /usr/bin/snmpdf)
	@$(call install_copy, net-snmp, 0, 0, 0755, -, /usr/bin/snmpget)
	@$(call install_copy, net-snmp, 0, 0, 0755, -, /usr/bin/snmpgetnext)
	@$(call install_copy, net-snmp, 0, 0, 0755, -, /usr/bin/snmpset)
	@$(call install_copy, net-snmp, 0, 0, 0755, -, /usr/bin/snmpstatus)
	@$(call install_copy, net-snmp, 0, 0, 0755, -, /usr/bin/snmptable)
	@$(call install_copy, net-snmp, 0, 0, 0755, -, /usr/bin/snmptest)
	@$(call install_copy, net-snmp, 0, 0, 0755, -, /usr/bin/snmptranslate)
	@$(call install_copy, net-snmp, 0, 0, 0755, -, /usr/bin/snmptrap)
	@$(call install_copy, net-snmp, 0, 0, 0755, -, /usr/sbin/snmptrapd)
	@$(call install_copy, net-snmp, 0, 0, 0755, -, /usr/bin/snmpusm)
	@$(call install_copy, net-snmp, 0, 0, 0755, -, /usr/bin/snmpvacm)
	@$(call install_copy, net-snmp, 0, 0, 0755, -, /usr/bin/snmpwalk)

# apps snmpstat
	@$(call install_copy, net-snmp, 0, 0, 0755, -, /usr/bin/snmpnetstat)

endif

# snmplib
	@$(call install_lib, net-snmp, 0, 0, 0644, libnetsnmp)

ifdef PTXCONF_NET_SNMP_MIBS
	@for i in $(NET_SNMP_MIBS); do \
		$(call install_copy, net-snmp, 0, 0, 0644, -, \
		$(call remove_quotes,$(PTXCONF_NET_SNMP_MIB_INSTALL_DIR))/$$i, n) ; \
	done
endif

	@$(call install_finish, net-snmp)
	@$(call touch)

# vim: ft=make noet
