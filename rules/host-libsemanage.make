# -*-makefile-*-
#
# Copyright (C) 2013 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_LIBSEMANAGE) += host-libsemanage

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_LIBSEMANAGE_CONF_TOOL := NO
HOST_LIBSEMANAGE_MAKE_ENV := $(HOST_ENV)
# no ':=' here
HOST_LIBSEMANAGE_INSTALL_OPT = \
	PREFIX=$(HOST_LIBSEMANAGE_PKGDIR) \
	install

define semanage/conf_helper
PTXDIST_SYSROOT_HOST=$(PTXDIST_SYSROOT_HOST) \
ptxd_replace_magic \
	$(call ptx/get_alternative, config/libsemanage, host-semanage.conf) > \
	$(strip $(1))/etc/selinux/semanage.conf
endef

# vim: syntax=make
