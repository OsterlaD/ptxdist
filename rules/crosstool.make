# -*-makefile-*-
# $Id: template,v 1.14 2004/07/01 16:08:08 rsc Exp $
#
# Copyright (C) 2004 by Robert Schwebel
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_CROSSTOOL
PACKAGES += crosstool
endif

#
# Paths and names
#
CROSSTOOL_VERSION	= 0.28-rc34
CROSSTOOL		= crosstool-$(CROSSTOOL_VERSION)
CROSSTOOL_SUFFIX	= tar.gz
CROSSTOOL_URL		= http://www.kegel.com/crosstool/$(CROSSTOOL).$(CROSSTOOL_SUFFIX)
CROSSTOOL_SOURCE	= $(SRCDIR)/$(CROSSTOOL).$(CROSSTOOL_SUFFIX)
CROSSTOOL_DIR		= $(BUILDDIR)/$(CROSSTOOL)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

crosstool_get: $(STATEDIR)/crosstool.get

crosstool_get_deps = $(CROSSTOOL_SOURCE)

$(STATEDIR)/crosstool.get: $(crosstool_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(CROSSTOOL))
	touch $@

$(CROSSTOOL_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(CROSSTOOL_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

crosstool_extract: $(STATEDIR)/crosstool.extract

crosstool_extract_deps = $(STATEDIR)/crosstool.get

$(STATEDIR)/crosstool.extract: $(crosstool_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(CROSSTOOL_DIR))
	@$(call extract, $(CROSSTOOL_SOURCE))
	@$(call patchin, $(CROSSTOOL))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

crosstool_prepare: $(STATEDIR)/crosstool.prepare

#
# dependencies
#
crosstool_prepare_deps = $(STATEDIR)/crosstool.extract

CROSSTOOL_PATH	=  PATH=$(CROSS_PATH)
CROSSTOOL_ENV 	=  $(CROSS_ENV)
#CROSSTOOL_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig
#CROSSTOOL_ENV	+=

#
# Configuration
#

ifdef PTXCONF_ARCH_ARM
CROSSTOOL_KERNELCONFIG = arm.dat
else
# AAAARRRRRGGGGHHHHH! FIXME!
endif

# FIXME: where do we get this from? 
CROSSTOOL_TARGET_CFLAGS		=  -O
CROSSTOOL_GCC_EXTRA_CONFIG	=  "--with-float=soft --with-cpu=strongarm"

CROSSTOOL_GCCLANG		=  c
ifdef PTXCONF_CROSSTOOL_GCCLANG_CC
CROSSTOOL_GCCLANG		+= ,c++
endif
CROSSTOOL_GCCLANG		:= $(subst $(quote),,$(CROSSTOOL_GCCLANG)) 
CROSSTOOL_GCCLANG		:= `echo $(CROSSTOOL_GCCLANG) | perl -p -e 's/\s//g'`

ifdef PTXCONF_SOFTFLOAT
CROSSTOOL_GLIBC_EXTRA_CONFIG 	+= --without-fp
endif

$(STATEDIR)/crosstool.prepare: $(crosstool_prepare_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

#
# Crosstool installs on 'compile', so we put everything into the install
# target. 
#

crosstool_compile: $(STATEDIR)/crosstool.compile

$(STATEDIR)/crosstool.compile: $(STATEDIR)/crosstool.prepare
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

crosstool_install: $(STATEDIR)/crosstool.install

crosstool_install_deps = $(STATEDIR)/crosstool.compile

$(STATEDIR)/crosstool.install: $(crosstool_install_deps)
	@$(call targetinfo, $@)
	#
	# We set all the stuff crosstool expects in it's environment
	#
	(	cd $(CROSSTOOL_DIR); \
		set -ex; \
		TARBALLS_DIR=$(TOPDIR)/src; \
		RESULT_TOP=$(subst $(quote),,$(PTXCONF_PREFIX)); \
		export TARBALLS_DIR RESULT_TOP;	\
		export GCC_LANGUAGES="$(CROSSTOOL_GCCLANG)"; \
		\
		mkdir -p $(subst $(quote),,$(PTXCONF_PREFIX)); \
		\
		export KERNELCONFIG=$(CROSSTOOL_DIR)/$(CROSSTOOL_KERNELCONFIG); \
		 \
		TARGET=$(subst $(quote),,$(PTXCONF_GNU_TARGET)) \
		TARGET_CFLAGS=$(CROSSTOOL_TARGET_CFLAGS) \
		GCC_EXTRA_CONFIG=$(CROSSTOOL_GCC_EXTRA_CONFIG) \
		GLIBC_EXTRA_CONFIG=$(CROSSTOOL_GLIBC_EXTRA_CONFIG) \
		BINUTILS_DIR=binutils-$(BINUTILS_VERSION) \
		GCC_DIR=gcc-$(GCC_VERSION) \
		GLIBC_DIR=glibc-$(GLIBC_VERSION) \
		LINUX_DIR=linux-$(KERNEL_VERSION) \
		GLIBCTHREADS_FILENAME=glibc-linuxthreads-$(GLIBC_VERSION) \
		sh $(CROSSTOOL_DIR)/all.sh --notest; \
		\
		echo "done" \
		exit 1;	\
	)
		
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

crosstool_targetinstall: $(STATEDIR)/crosstool.targetinstall

crosstool_targetinstall_deps = $(STATEDIR)/crosstool.install

$(STATEDIR)/crosstool.targetinstall: $(crosstool_targetinstall_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

crosstool_clean:
	rm -rf $(STATEDIR)/crosstool.*
	rm -rf $(CROSSTOOL_DIR)

# vim: syntax=make
