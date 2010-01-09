# -*-makefile-*-
#
# Copyright (C) 2006 by Erwin Rol
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_FONT_MICRO_MISC) += xorg-font-micro-misc

#
# Paths and names
#
XORG_FONT_MICRO_MISC_VERSION	:= 1.0.1
XORG_FONT_MICRO_MISC		:= font-micro-misc-$(XORG_FONT_MICRO_MISC_VERSION)
XORG_FONT_MICRO_MISC_SUFFIX	:= tar.bz2
XORG_FONT_MICRO_MISC_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/font//$(XORG_FONT_MICRO_MISC).$(XORG_FONT_MICRO_MISC_SUFFIX)
XORG_FONT_MICRO_MISC_SOURCE	:= $(SRCDIR)/$(XORG_FONT_MICRO_MISC).$(XORG_FONT_MICRO_MISC_SUFFIX)
XORG_FONT_MICRO_MISC_DIR	:= $(BUILDDIR)/$(XORG_FONT_MICRO_MISC)

ifdef PTXCONF_XORG_FONT_MICRO_MISC
$(STATEDIR)/xorg-fonts.targetinstall.post: $(STATEDIR)/xorg-font-micro-misc.targetinstall
endif

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_FONT_MICRO_MISC_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_FONT_MICRO_MISC)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_FONT_MICRO_MISC_PATH	:= PATH=$(CROSS_PATH)
XORG_FONT_MICRO_MISC_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_FONT_MICRO_MISC_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-fontdir=$(XORG_FONTDIR)/misc

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-micro-misc.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-micro-misc.targetinstall:
	@$(call targetinfo)

	@find $(XORG_FONT_MICRO_MISC_DIR) \
		-name "*.pcf.gz" \
		| \
		while read file; do \
		install -m 644 $${file} $(XORG_FONTS_DIR_INSTALL)/misc; \
	done

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-font-micro-misc_clean:
	rm -rf $(STATEDIR)/xorg-font-micro-misc.*
	rm -rf $(PKGDIR)/xorg-font-micro-misc_*
	rm -rf $(XORG_FONT_MICRO_MISC_DIR)

# vim: syntax=make
