# -*-makefile-*-
# $Id$
#
# Copyright (C) 2006 by Roland Hostettler
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_DBUS) += dbus

#
# Paths and names
#
DBUS_VERSION	:= 1.0.0
DBUS		:= dbus-$(DBUS_VERSION)
DBUS_SUFFIX	:= tar.gz
DBUS_URL	:= http://dbus.freedesktop.org/releases/dbus/$(DBUS).$(DBUS_SUFFIX)
DBUS_SOURCE	:= $(SRCDIR)/$(DBUS).$(DBUS_SUFFIX)
DBUS_DIR	:= $(BUILDDIR)/$(DBUS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

dbus_get: $(STATEDIR)/dbus.get

$(STATEDIR)/dbus.get: $(dbus_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(DBUS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, DBUS)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

dbus_extract: $(STATEDIR)/dbus.extract

$(STATEDIR)/dbus.extract: $(dbus_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(DBUS_DIR))
	@$(call extract, DBUS)
	@$(call patchin, DBUS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

dbus_prepare: $(STATEDIR)/dbus.prepare

DBUS_PATH := PATH=$(CROSS_PATH)
DBUS_ENV := \
	$(CROSS_ENV) \
	ac_cv_have_abstract_sockets=yes

ifdef PTXCONF_DBUS_X
DBUS_ENV += ac_cv_have_x="have_x=yes ac_x_includes=$(SYSROOT)/usr/include ac_x_libraries=$(SYSROOT)/usr/lib"
endif

#
# autoconf
#
DBUS_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--enable-abstract-sockets=yes \
	--localstatedir=/var \
	--with-dbus-user=$(PTXCONF_DBUS_USER)

ifdef PTXCONF_DBUS_X
DBUS_AUTOCONF += --with-x=$(SYSROOT)/usr
else
DBUS_AUTOCONF += --without-x
endif

$(STATEDIR)/dbus.prepare: $(dbus_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(DBUS_DIR)/config.cache)
	cd $(DBUS_DIR) && \
		$(DBUS_PATH) $(DBUS_ENV) \
		./configure $(DBUS_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

dbus_compile: $(STATEDIR)/dbus.compile

$(STATEDIR)/dbus.compile: $(dbus_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(DBUS_DIR) && $(DBUS_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

dbus_install: $(STATEDIR)/dbus.install

$(STATEDIR)/dbus.install: $(dbus_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, DBUS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

dbus_targetinstall: $(STATEDIR)/dbus.targetinstall

$(STATEDIR)/dbus.targetinstall: $(dbus_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, dbus)
	@$(call install_fixup,dbus,PACKAGE,dbus)
	@$(call install_fixup,dbus,PRIORITY,optional)
	@$(call install_fixup,dbus,VERSION,$(DBUS_VERSION))
	@$(call install_fixup,dbus,SECTION,base)
	@$(call install_fixup,dbus,AUTHOR,"Roland Hostettler <r.hostettler\@gmx.ch>")
	@$(call install_fixup,dbus,DEPENDS,)
	@$(call install_fixup,dbus,DESCRIPTION,missing)

	@$(call install_copy, dbus, 0, 0, 0755, $(DBUS_DIR)/bus/dbus-daemon, \
		/usr/bin/dbus-daemon)
	@$(call install_copy, dbus, 0, 0, 0755, \
		$(DBUS_DIR)/tools/dbus-cleanup-sockets, \
		/usr/bin/dbus-cleanup-sockets)
	@$(call install_copy, dbus, 0, 0, 0755, \
		$(DBUS_DIR)/tools/dbus-launch, /usr/bin/dbus-launch)
	@$(call install_copy, dbus, 0, 0, 0755, \
		$(DBUS_DIR)/tools/.libs/dbus-monitor, /usr/bin/dbus-monitor)
	@$(call install_copy, dbus, 0, 0, 0755, \
		$(DBUS_DIR)/tools/.libs/dbus-send, /usr/bin/dbus-send)
	@$(call install_copy, dbus, 0, 0, 0755, \
		$(DBUS_DIR)/tools/.libs/dbus-uuidgen, /usr/bin/dbus-uuidgen)

	@$(call install_copy, dbus, 0, 0, 0644, \
		$(DBUS_DIR)/dbus/.libs/libdbus-1.so.3.2.0, \
		/usr/lib/libdbus-1.so.3.2.0)
	@$(call install_link, dbus, libdbus-1.so.3.2.0, /usr/lib/libdbus-1.so.3)
	@$(call install_link, dbus, libdbus-1.so.3.2.0, /usr/lib/libdbus-1.so)

	#
	# create system.d and event.d directories, which are used by the configuration and startup files
	#
	@$(call install_copy, dbus, 0, 0, 0755, /etc/dbus-1/system.d/)
	@$(call install_copy, dbus, 0, 0, 0755, /etc/dbus-1/event.d/)

	#
	# use the default /etc/dbus-1/system.conf config file
	#
ifdef PTXCONF_ROOTFS_GENERIC_DBUS_SYSTEM_CONF
	@$(call install_copy, dbus, 0, 0, 0644, $(DBUS_DIR)/bus/system.conf, \
		/etc/dbus-1/system.conf,n)
endif

	#
	# use the users /etc/dbus-1/system.conf config file from projectroot/etc/dbus-1/system.conf
	#
ifdef PTXCONF_ROOTFS_USER_DBUS_SYSTEM_CONF
	@echo "installing user system config file..."
	@$(call install_copy, dbus, 0, 0, 0644, \
		$(PTXDIST_WORKSPACE)/projectroot/etc/dbus-1/system.conf, \
		/etc/dbus-1/system.conf,n)
endif

	#
	# use the default /etc/dbus-1/session.conf config file
	#
ifdef PTXCONF_ROOTFS_GENERIC_DBUS_SESSION_CONF
	@$(call install_copy, dbus, 0, 0, 0644, $(DBUS_DIR)/bus/session.conf, \
		/etc/dbus-1/session.conf,n)
endif

	#
	# use the user's /etc/dbus-1/session.conf config file from projectroot/etc/dbus-1/session.conf
	#
ifdef PTXCONF_ROOTFS_USER_DBUS_SESSION_CONF
	@echo "installing user session config file..."
	@$(call install_copy, dbus, 0, 0, 0644, \
		$(PTXDIST_WORKSPACE)/projectroot/etc/dbus-1/session.conf, \
		/etc/dbus-1/session.conf,n)
endif

ifdef PTXCONF_DBUS_INSTALL_STARTUP_SCRIPT
	#
	# use the generic startup script in /etc/init.d/dbus
	#
ifdef PTXCONF_ROOTFS_ETC_INITD_DBUS_GENERIC
	@$(call install_copy, dbus, 0, 0, 0755, \
		$(PTXDIST_TOPDIR)/generic/etc/init.d/dbus, \
		/etc/init.d/dbus, n)
endif
	#
	# use the user's startup script in /etc/init.d/dbus from projectroot/etc/init.d/dbus
	#
ifdef PTXCONF_ROOTFS_ETC_INITD_DBUS_USER
	@$(call install_copy, dbus, 0, 0, 0755, \
		$(PTXDIST_WORKSPACE)/projectroot/etc/init.d/dbus, \
		/etc/init.d/dbus,n)
endif

	#
	# create a link in /etc/rc.d/ to /etc/init.d/dbus
	#
ifdef PTXCONF_ROOTFS_ETC_INITD_DBUS_LINK
ifneq ($(PTXCONF_ROOTFS_ETC_INITD_DBUS_LINK),"")
	@$(call install_copy, dbus, 0, 0, 0755, /etc/rc.d)
	@$(call install_link, dbus, ../init.d/dbus, \
		/etc/rc.d/$(PTXCONF_ROOTFS_ETC_INITD_DBUS_LINK))
endif
endif
endif

	@$(call install_finish,dbus)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

dbus_clean:
	rm -rf $(STATEDIR)/dbus.*
	rm -rf $(IMAGEDIR)/dbus_*
	rm -rf $(DBUS_DIR)

# vim: syntax=make
