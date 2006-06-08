# -*-makefile-*-
# $Id: template 4453 2006-01-29 13:28:16Z rsc $
#
# Copyright (C) 2006 by Marc Kleine-Budde <mkl@pengutronix.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_UNIONFS) += unionfs

#
# Paths and names
#
ifdef PTXCONF_UNIONFS_SNAPSHOT
UNIONFS_VERSION := $(call remove_quotes, $(PTXCONF_UNIONFS_VERSION))
UNIONFS		:= unionfs-$(UNIONFS_VERSION)
UNIONFS_SUFFIX	:= tar.gz
UNIONFS_URL	:= ftp://ftp.fsl.cs.sunysb.edu/pub/unionfs/snapshots/$(UNIONFS).$(UNIONFS_SUFFIX)
else
UNIONFS_VERSION	:= 1.1.4
UNIONFS		:= unionfs-$(UNIONFS_VERSION)
UNIONFS_SUFFIX	:= tar.gz
UNIONFS_URL	:= ftp://ftp.fsl.cs.sunysb.edu/pub/unionfs/$(UNIONFS).$(UNIONFS_SUFFIX)
endif
UNIONFS_SOURCE	:= $(SRCDIR)/$(UNIONFS).$(UNIONFS_SUFFIX)
UNIONFS_DIR	:= $(BUILDDIR)/$(UNIONFS)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

unionfs_get: $(STATEDIR)/unionfs.get

$(STATEDIR)/unionfs.get: $(unionfs_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(UNIONFS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, UNIONFS)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

unionfs_extract: $(STATEDIR)/unionfs.extract

$(STATEDIR)/unionfs.extract: $(unionfs_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(UNIONFS_DIR))
	@$(call extract, UNIONFS)
	@$(call patchin, UNIONFS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

unionfs_prepare: $(STATEDIR)/unionfs.prepare

UNIONFS_PATH	 := PATH=$(CROSS_PATH)
UNIONFS_ENV 	 := $(CROSS_ENV)
UNIONFS_MAKEVARS = $(call remove_quotes, LINUXSRC=$(KERNEL_DIR) KVERS=$(KERNEL_VERSION) $(CROSS_ENV_CC) UNIONFS_DEBUG_CFLAG= UNIONFS_OPT_CFLAG='$(CROSS_CPPFLAGS) $(CROSS_LDFLAGS) -O2' PREFIX=$(SYSROOT)/usr MODPREFIX=$(SYSROOT) EXTRACFLAGS=-DUNIONFS_NDEBUG)

$(STATEDIR)/unionfs.prepare: $(unionfs_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

unionfs_compile: $(STATEDIR)/unionfs.compile

$(STATEDIR)/unionfs.compile: $(unionfs_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(UNIONFS_DIR) && $(UNIONFS_ENV) $(UNIONFS_PATH) make $(UNIONFS_MAKEVARS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

unionfs_install: $(STATEDIR)/unionfs.install

$(STATEDIR)/unionfs.install: $(unionfs_install_deps_default)
	@$(call targetinfo, $@)
	$(call install, UNIONFS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

unionfs_targetinstall: $(STATEDIR)/unionfs.targetinstall

$(STATEDIR)/unionfs.targetinstall: $(unionfs_targetinstall_deps_default)
	@$(call targetinfo, $@)

ifdef PTXCONF_UNIONFS_KERNELMODUL
	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,unionfs-unionfs-ko)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(UNIONFS_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)
	@$(call install_copy, 0, 0, 0755, $(UNIONFS_DIR)/unionfs.ko, /lib/modules/unionfs.ko, n)
	@$(call install_finish)
endif

ifdef PTXCONF_UNIONFS_UNIONCTL
	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,unionfs-unionctl)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(UNIONFS_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)
	@$(call install_copy, 0, 0, 0755, $(UNIONFS_DIR)/unionctl, /usr/sbin/unionctl)
	@$(call install_finish)
endif

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

unionfs_clean:
	rm -rf $(STATEDIR)/unionfs.*
	rm -rf $(IMAGEDIR)/unionfs_*
	rm -rf $(UNIONFS_DIR)

# vim: syntax=make
