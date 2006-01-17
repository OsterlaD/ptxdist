# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Robert Schwebel <r.schwebel@pengutronix.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PENGUZILLA) += penguzilla

#
# Paths and names
#
PENGUZILLA_VERSION	= 0.4.0
PENGUZILLA		= penguzilla-$(PENGUZILLA_VERSION)
PENGUZILLA_SUFFIX	= tar.gz
PENGUZILLA_URL		= http://metis.pengutronix.de/$(PENGUZILLA).$(PENGUZILLA_SUFFIX)
PENGUZILLA_SOURCE	= $(SRCDIR)/$(PENGUZILLA).$(PENGUZILLA_SUFFIX)
PENGUZILLA_DIR		= $(BUILDDIR)/$(PENGUZILLA)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

penguzilla_get: $(STATEDIR)/penguzilla.get

$(STATEDIR)/penguzilla.get: $(penguzilla_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(PENGUZILLA_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(PENGUZILLA_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

penguzilla_extract: $(STATEDIR)/penguzilla.extract

$(STATEDIR)/penguzilla.extract: $(penguzilla_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(PENGUZILLA_DIR))
	@$(call extract, $(PENGUZILLA_SOURCE))
	@$(call patchin, $(PENGUZILLA))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

penguzilla_prepare: $(STATEDIR)/penguzilla.prepare

PENGUZILLA_PATH	=  PATH=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/bin:$(CROSS_PATH)
PENGUZILLA_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
PENGUZILLA_AUTOCONF	=  $(CROSS_AUTOCONF_USR)
PENGUZILLA_AUTOCONF	+= --with-mozilla=$(MFIREBIRD_DIR)
PENGUZILLA_AUTOCONF	+= --with-gtk-prefix=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)

$(STATEDIR)/penguzilla.prepare: $(penguzilla_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(PENGUZILLA_BUILDDIR))
	cd $(PENGUZILLA_DIR) && \
		$(PENGUZILLA_PATH) $(PENGUZILLA_ENV) \
		./configure $(PENGUZILLA_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

penguzilla_compile: $(STATEDIR)/penguzilla.compile

$(STATEDIR)/penguzilla.compile: $(penguzilla_compile_deps_default)
	@$(call targetinfo, $@)
	$(PENGUZILLA_PATH) $(PENGUZILLA_ENV) make -C $(PENGUZILLA_DIR)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

penguzilla_install: $(STATEDIR)/penguzilla.install

$(STATEDIR)/penguzilla.install: $(penguzilla_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

penguzilla_targetinstall: $(STATEDIR)/penguzilla.targetinstall

$(STATEDIR)/penguzilla.targetinstall: $(penguzilla_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,penguzilla)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(PENGUZILLA_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

# 	# pixmap directory
	for file in $(PENGUZILLA_DIR)/pixmaps/*; do 						\
		$(call install_copy, 0, 0, 0644, $$file, /usr/share/penguzilla/pixmaps/)	\
	done

	@$(call install_copy, 0, 0, 0755, $(PENGUZILLA_DIR)/src/penguzilla, /usr/bin/penguzilla)

# 	# Style
	@$(call install_copy, 0, 0, 0644, $(PENGUZILLA_DIR)/penguzilla.rc, /usr/share/penguzilla/penguzillarc, n)

	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

penguzilla_clean:
	rm -rf $(STATEDIR)/penguzilla.*
	rm -rf $(IMAGEDIR)/penguzilla_*
	rm -rf $(PENGUZILLA_DIR)

# vim: syntax=make
