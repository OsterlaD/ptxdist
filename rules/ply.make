# -*-makefile-*-
#
# Copyright (C) 2019 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifeq ($(PTXCONF_ARCH_X86),$(PTXCONF_ARCH_X86_64))
PACKAGES-$(PTXCONF_PLY) += ply
endif

#
# Paths and names
#
PLY_VERSION	:= 2.1.0
PLY_MD5		:= cd7b5258d636db5d330f45ec858f9a5c
PLY		:= ply-$(PLY_VERSION)
PLY_SUFFIX	:= tar.gz
PLY_URL		:= https://github.com/wkz/ply/releases/download/$(PLY_VERSION)/$(PLY).$(PLY_SUFFIX)
PLY_SOURCE	:= $(SRCDIR)/$(PLY).$(PLY_SUFFIX)
PLY_DIR		:= $(BUILDDIR)/$(PLY)
PLY_LICENSE	:= GPL-2.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

# The files generated by lex and yacc are part of the tarball
PLY_CONF_ENV := \
	$(CROSS_ENV) \
	ac_cv_prog_LEX=: \
	ac_cv_prog_YACC=:

#
# autoconf
#
PLY_CONF_TOOL	:= autoconf

ifdef PTXCONF_PLY
ifdef PTXCONF_KERNEL
ifneq ($(call remove_quotes,$(PTXCONF_KERNEL_HEADER_VERSION)),$(call remove_quotes,$(PTXCONF_KERNEL_VERSION)))
$(error ply only works if the kernel header version matches the kernel version)
endif
endif
endif

PLY_CPPFLAGS := -isystem $(KERNEL_HEADERS_INCLUDE_DIR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ply.targetinstall:
	@$(call targetinfo)

	@$(call install_init, ply)
	@$(call install_fixup, ply,PRIORITY,optional)
	@$(call install_fixup, ply,SECTION,base)
	@$(call install_fixup, ply,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, ply,DESCRIPTION,missing)

	@$(call install_lib, ply, 0, 0, 0644, libply)
	@$(call install_copy, ply, 0, 0, 0755, -, /usr/sbin/ply)

	@$(call install_finish, ply)

	@$(call touch)

# vim: syntax=make
