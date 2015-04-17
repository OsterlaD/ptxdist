# -*-makefile-*-
#
# Copyright (C) 2006-2009 by Robert Schwebel <r.schwebel@pengutronix.de>
#                            Pengutronix <info@pengutronix.de>, Germany
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GLIB) += glib

#
# Paths and names
#
#ifdef PTXCONF_GLIB_EXPERIMENTAL
#GLIB_VERSION	:= 2.27.93
#GLIB_MD5	:=
#else
GLIB_VERSION	:= 2.44.0
GLIB_MD5	:= 74cf7b4ea200b76e42a4c22c8daf0f93
#endif

GLIB		:= glib-$(GLIB_VERSION)
GLIB_SUFFIX	:= tar.xz
GLIB_SOURCE	:= $(SRCDIR)/$(GLIB).$(GLIB_SUFFIX)
GLIB_DIR	:= $(BUILDDIR)/$(GLIB)

GLIB_URL	:= http://ftp.gnome.org/pub/GNOME/sources/glib/$(basename $(GLIB_VERSION))/glib-$(GLIB_VERSION).$(GLIB_SUFFIX)

GLIB_LICENSE	:= LGPLv2+

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GLIB_CONF_ENV	:= \
	$(CROSS_ENV) \
	glib_cv_uscore=no \
	glib_cv_stack_grows=no \
	glib_cv_have_qsort_r=yes \
	ac_cv_func_statfs=yes \
	ac_cv_path_MSGFMT=: \
	ac_cv_path_XGETTEXT=no

#
# autoconf
#
# --with-libiconv=no does also find the libc iconv implementation! So it
# is the right choice for no locales and locales-via-libc
#

GLIB_CONF_TOOL	:= autoconf
GLIB_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--enable-silent-rules \
	--enable-debug=minimum \
	--disable-gc-friendly \
	--enable-mem-pools \
	--disable-rebuilds \
	--disable-installed-tests \
	--disable-always-build-tests \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-static \
	--enable-shared \
	--disable-included-printf \
	--disable-selinux \
	--disable-fam \
	--disable-xattr \
	--disable-libelf \
	--disable-gtk-doc \
	--disable-man \
	--disable-dtrace \
	--disable-systemtap \
	--disable-coverage \
	--with-libiconv=no \
	--with-threads=posix \
	--with-pcre=internal

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/glib.targetinstall:
	@$(call targetinfo)

	@$(call install_init, glib)
	@$(call install_fixup, glib,PRIORITY,optional)
	@$(call install_fixup, glib,SECTION,base)
	@$(call install_fixup, glib,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, glib,DESCRIPTION,missing)

#	# /usr/bin/gtester-report
#	# /usr/bin/glib-genmarshal
#	# /usr/bin/glib-gettextize
#	# /usr/bin/gobject-query
#	# /usr/bin/glib-mkenums
#	# /usr/bin/gtester

	@$(call install_copy, glib, 0, 0, 0755, /usr/lib/gio/modules)

	@for i in libgio-2.0 libglib-2.0 libgmodule-2.0 libgobject-2.0 libgthread-2.0; do \
		$(call install_lib, glib, 0, 0, 0644, $$i); \
	done

ifdef PTXCONF_GLIB_GDBUS
	@$(call install_copy, glib, 0, 0, 0755, -, /usr/bin/gdbus)
endif
	@$(call install_finish, glib)

	@$(call touch)

# vim: syntax=make
