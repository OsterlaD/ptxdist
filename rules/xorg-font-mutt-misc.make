# -*-makefile-*-
# $Id: template 4565 2006-02-10 14:23:10Z mkl $
#
# Copyright (C) 2006 by Erwin Rol
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_FONT_MUTT_MISC) += xorg-font-mutt-misc

#
# Paths and names
#
XORG_FONT_MUTT_MISC_VERSION	:= 1.0.0
XORG_FONT_MUTT_MISC		:= font-mutt-misc-X11R7.0-$(XORG_FONT_MUTT_MISC_VERSION)
XORG_FONT_MUTT_MISC_SUFFIX	:= tar.bz2
XORG_FONT_MUTT_MISC_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/X11R7.0/src/font/$(XORG_FONT_MUTT_MISC).$(XORG_FONT_MUTT_MISC_SUFFIX)
XORG_FONT_MUTT_MISC_SOURCE	:= $(SRCDIR)/$(XORG_FONT_MUTT_MISC).$(XORG_FONT_MUTT_MISC_SUFFIX)
XORG_FONT_MUTT_MISC_DIR		:= $(BUILDDIR)/$(XORG_FONT_MUTT_MISC)

ifdef PTXCONF_XORG_FONT_MUTT_MISC
$(STATEDIR)/xorg-fonts.targetinstall.post: $(STATEDIR)/xorg-font-mutt-misc.targetinstall
endif

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-font-mutt-misc_get: $(STATEDIR)/xorg-font-mutt-misc.get

$(STATEDIR)/xorg-font-mutt-misc.get: $(xorg-font-mutt-misc_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_FONT_MUTT_MISC_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_FONT_MUTT_MISC)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-font-mutt-misc_extract: $(STATEDIR)/xorg-font-mutt-misc.extract

$(STATEDIR)/xorg-font-mutt-misc.extract: $(xorg-font-mutt-misc_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_FONT_MUTT_MISC_DIR))
	@$(call extract, XORG_FONT_MUTT_MISC)
	@$(call patchin, XORG_FONT_MUTT_MISC)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-font-mutt-misc_prepare: $(STATEDIR)/xorg-font-mutt-misc.prepare

XORG_FONT_MUTT_MISC_PATH	:=  PATH=$(CROSS_PATH)
XORG_FONT_MUTT_MISC_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_FONT_MUTT_MISC_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-fontdir=$(XORG_FONTDIR)/misc

$(STATEDIR)/xorg-font-mutt-misc.prepare: $(xorg-font-mutt-misc_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_FONT_MUTT_MISC_DIR)/config.cache)
	cd $(XORG_FONT_MUTT_MISC_DIR) && \
		$(XORG_FONT_MUTT_MISC_PATH) $(XORG_FONT_MUTT_MISC_ENV) \
		./configure $(XORG_FONT_MUTT_MISC_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-font-mutt-misc_compile: $(STATEDIR)/xorg-font-mutt-misc.compile

$(STATEDIR)/xorg-font-mutt-misc.compile: $(xorg-font-mutt-misc_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_FONT_MUTT_MISC_DIR) && $(XORG_FONT_MUTT_MISC_PATH) $(MAKE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-font-mutt-misc_install: $(STATEDIR)/xorg-font-mutt-misc.install

$(STATEDIR)/xorg-font-mutt-misc.install: $(xorg-font-mutt-misc_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-font-mutt-misc_targetinstall: $(STATEDIR)/xorg-font-mutt-misc.targetinstall

$(STATEDIR)/xorg-font-mutt-misc.targetinstall: $(xorg-font-mutt-misc_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@mkdir -p $(XORG_FONTS_DIR_INSTALL)/misc

	@find $(XORG_FONT_MUTT_MISC_DIR) \
		-name "*.pcf.gz" \
		| \
		while read file; do \
		install -m 644 $${file} $(XORG_FONTS_DIR_INSTALL)/misc; \
	done

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-font-mutt-misc_clean:
	rm -rf $(STATEDIR)/xorg-font-mutt-misc.*
	rm -rf $(IMAGEDIR)/xorg-font-mutt-misc_*
	rm -rf $(XORG_FONT_MUTT_MISC_DIR)

# vim: syntax=make
