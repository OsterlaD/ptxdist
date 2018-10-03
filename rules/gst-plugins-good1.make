# -*-makefile-*-
#
# Copyright (C) 2008 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GST_PLUGINS_GOOD1) += gst-plugins-good1

#
# Paths and names
#
GST_PLUGINS_GOOD1_VERSION	:= 1.14.4
GST_PLUGINS_GOOD1_MD5		:= 6e3b247097366cf2639f22abfece7113
GST_PLUGINS_GOOD1		:= gst-plugins-good-$(GST_PLUGINS_GOOD1_VERSION)
GST_PLUGINS_GOOD1_SUFFIX	:= tar.xz
GST_PLUGINS_GOOD1_URL		:= http://gstreamer.freedesktop.org/src/gst-plugins-good/$(GST_PLUGINS_GOOD1).$(GST_PLUGINS_GOOD1_SUFFIX)
GST_PLUGINS_GOOD1_SOURCE	:= $(SRCDIR)/$(GST_PLUGINS_GOOD1).$(GST_PLUGINS_GOOD1_SUFFIX)
GST_PLUGINS_GOOD1_DIR		:= $(BUILDDIR)/$(GST_PLUGINS_GOOD1)
GST_PLUGINS_GOOD1_LICENSE	:= LGPL-2.1-or-later

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GST_PLUGINS_GOOD1_ENABLEC-$(PTXCONF_GST_PLUGINS_GOOD1_ALPHA)		+= alpha
GST_PLUGINS_GOOD1_ENABLEP-$(PTXCONF_GST_PLUGINS_GOOD1_ALPHA)		+= alpha alphacolor
GST_PLUGINS_GOOD1_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD1_APETAG)		+= apetag
GST_PLUGINS_GOOD1_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD1_AUDIOFX)		+= audiofx
GST_PLUGINS_GOOD1_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD1_AUDIOPARSERS)	+= audioparsers
GST_PLUGINS_GOOD1_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD1_AUPARSE)		+= auparse
GST_PLUGINS_GOOD1_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD1_AUTODETECT)	+= autodetect
GST_PLUGINS_GOOD1_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD1_AVI)		+= avi
GST_PLUGINS_GOOD1_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD1_CUTTER)		+= cutter
GST_PLUGINS_GOOD1_ENABLEC-$(PTXCONF_GST_PLUGINS_GOOD1_DEBUGUTILS)	+= debugutils
GST_PLUGINS_GOOD1_ENABLEP-$(PTXCONF_GST_PLUGINS_GOOD1_DEBUGUTILS)	+= debug navigationtest
GST_PLUGINS_GOOD1_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD1_DEINTERLACE)	+= deinterlace
GST_PLUGINS_GOOD1_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD1_DTMF)		+= dtmf
GST_PLUGINS_GOOD1_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD1_EFFECTV)		+= effectv
GST_PLUGINS_GOOD1_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD1_EQUALIZER)		+= equalizer
GST_PLUGINS_GOOD1_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD1_FLV)		+= flv
GST_PLUGINS_GOOD1_ENABLEC-$(PTXCONF_GST_PLUGINS_GOOD1_FLX)		+= flx
GST_PLUGINS_GOOD1_ENABLEP-$(PTXCONF_GST_PLUGINS_GOOD1_FLX)		+= flxdec
GST_PLUGINS_GOOD1_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD1_GOOM)		+= goom
GST_PLUGINS_GOOD1_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD1_GOOM2K1)		+= goom2k1
GST_PLUGINS_GOOD1_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD1_ICYDEMUX)		+= icydemux
GST_PLUGINS_GOOD1_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD1_ID3DEMUX)		+= id3demux
GST_PLUGINS_GOOD1_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD1_IMAGEFREEZE)	+= imagefreeze
GST_PLUGINS_GOOD1_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD1_INTERLEAVE)	+= interleave
GST_PLUGINS_GOOD1_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD1_QTDEMUX)		+= isomp4
GST_PLUGINS_GOOD1_ENABLEC-$(PTXCONF_GST_PLUGINS_GOOD1_LAW)		+= law
GST_PLUGINS_GOOD1_ENABLEP-$(PTXCONF_GST_PLUGINS_GOOD1_LAW)		+= alaw mulaw
GST_PLUGINS_GOOD1_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD1_LEVEL)		+= level
GST_PLUGINS_GOOD1_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD1_MATROSKA)		+= matroska
GST_PLUGINS_GOOD1_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD1_MONOSCOPE)		+= monoscope
GST_PLUGINS_GOOD1_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD1_MULTIFILE)		+= multifile
GST_PLUGINS_GOOD1_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD1_MULTIPART)		+= multipart
GST_PLUGINS_GOOD1_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD1_REPLAYGAIN)	+= replaygain
GST_PLUGINS_GOOD1_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD1_RTP)		+= rtp
GST_PLUGINS_GOOD1_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD1_RTPMANAGER)	+= rtpmanager
GST_PLUGINS_GOOD1_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD1_RTSP)		+= rtsp
GST_PLUGINS_GOOD1_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD1_SHAPEWIPE)		+= shapewipe
GST_PLUGINS_GOOD1_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD1_SMPTE)		+= smpte
GST_PLUGINS_GOOD1_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD1_SPECTRUM)		+= spectrum
GST_PLUGINS_GOOD1_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD1_UDP)		+= udp
GST_PLUGINS_GOOD1_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD1_VIDEOBOX)		+= videobox
GST_PLUGINS_GOOD1_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD1_VIDEOCROP)		+= videocrop
GST_PLUGINS_GOOD1_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD1_VIDEOFILTER)	+= videofilter
GST_PLUGINS_GOOD1_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD1_VIDEOMIXER)	+= videomixer
GST_PLUGINS_GOOD1_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD1_WAVENC)		+= wavenc
GST_PLUGINS_GOOD1_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD1_WAVPARSE)		+= wavparse
GST_PLUGINS_GOOD1_ENABLEC-$(PTXCONF_GST_PLUGINS_GOOD1_Y4M)		+= y4m
GST_PLUGINS_GOOD1_ENABLEP-$(PTXCONF_GST_PLUGINS_GOOD1_Y4M)		+= y4menc
GST_PLUGINS_GOOD1_ENABLEC-$(PTXCONF_GST_PLUGINS_GOOD1_OSS)		+= oss
GST_PLUGINS_GOOD1_ENABLEP-$(PTXCONF_GST_PLUGINS_GOOD1_OSS)		+= ossaudio
GST_PLUGINS_GOOD1_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD1_OSS4)		+= oss4
GST_PLUGINS_GOOD1_ENABLEC-$(PTXCONF_GST_PLUGINS_GOOD1_GST_V4L2)		+= gst_v4l2 v4l2-probe
GST_PLUGINS_GOOD1_ENABLEP-$(PTXCONF_GST_PLUGINS_GOOD1_GST_V4L2)		+= video4linux2
GST_PLUGINS_GOOD1_ENABLEC-$(PTXCONF_GST_PLUGINS_GOOD1_X)		+= x
GST_PLUGINS_GOOD1_ENABLEP-$(PTXCONF_GST_PLUGINS_GOOD1_X)		+= ximagesrc
GST_PLUGINS_GOOD1_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD1_AALIB)		+= aalib
GST_PLUGINS_GOOD1_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD1_CAIRO)		+= cairo
GST_PLUGINS_GOOD1_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD1_FLAC)		+= flac
GST_PLUGINS_GOOD1_ENABLEC-$(PTXCONF_GST_PLUGINS_GOOD1_GDK_PIXBUF)	+= gdk_pixbuf
GST_PLUGINS_GOOD1_ENABLEP-$(PTXCONF_GST_PLUGINS_GOOD1_GDK_PIXBUF)	+= gdkpixbuf
GST_PLUGINS_GOOD1_ENABLEC-$(PTXCONF_GST_PLUGINS_GOOD1_GTK3)		+= gtk3
GST_PLUGINS_GOOD1_ENABLEP-$(PTXCONF_GST_PLUGINS_GOOD1_GTK3)		+= gtk
GST_PLUGINS_GOOD1_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD1_JACK)		+= jack
GST_PLUGINS_GOOD1_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD1_JPEG)		+= jpeg
GST_PLUGINS_GOOD1_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD1_LAME)		+= lame
GST_PLUGINS_GOOD1_ENABLEC-$(PTXCONF_GST_PLUGINS_GOOD1_LIBCACA)		+= libcaca
GST_PLUGINS_GOOD1_ENABLEP-$(PTXCONF_GST_PLUGINS_GOOD1_LIBCACA)		+= cacasink
GST_PLUGINS_GOOD1_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD1_LIBDV)		+= libdv
GST_PLUGINS_GOOD1_ENABLEC-$(PTXCONF_GST_PLUGINS_GOOD1_LIBPNG)		+= libpng
GST_PLUGINS_GOOD1_ENABLEP-$(PTXCONF_GST_PLUGINS_GOOD1_LIBPNG)		+= png
GST_PLUGINS_GOOD1_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD1_MPG123)		+= mpg123
GST_PLUGINS_GOOD1_ENABLEC-$(PTXCONF_GST_PLUGINS_GOOD1_PULSE)		+= pulse
GST_PLUGINS_GOOD1_ENABLEP-$(PTXCONF_GST_PLUGINS_GOOD1_PULSE)		+= pulseaudio
GST_PLUGINS_GOOD1_ENABLEC-$(PTXCONF_GST_PLUGINS_GOOD1_QT)		+= qt
GST_PLUGINS_GOOD1_ENABLEP-$(PTXCONF_GST_PLUGINS_GOOD1_QT)		+= qmlgl
GST_PLUGINS_GOOD1_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD1_DV1394)		+= dv1394
GST_PLUGINS_GOOD1_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD1_SHOUT2)		+= shout2
GST_PLUGINS_GOOD1_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD1_SOUP)		+= soup
GST_PLUGINS_GOOD1_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD1_SPEEX)		+= speex
GST_PLUGINS_GOOD1_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD1_TAGLIB)		+= taglib
GST_PLUGINS_GOOD1_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD1_TWOLAME)		+= twolame
GST_PLUGINS_GOOD1_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD1_VPX)		+= vpx
GST_PLUGINS_GOOD1_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD1_WAVPACK)		+= wavpack

GST_PLUGINS_GOOD1_ENABLEC-y	+= $(GST_PLUGINS_GOOD1_ENABLE-y)
GST_PLUGINS_GOOD1_ENABLEC-	+= $(GST_PLUGINS_GOOD1_ENABLE-)
GST_PLUGINS_GOOD1_ENABLEP-y	+= $(GST_PLUGINS_GOOD1_ENABLE-y)

ifdef PTXCONF_KERNEL_HEADER
# for new linux/videodev2.h from kernel headers
GST_PLUGINS_GOOD1_CONF_ENV := \
	$(CROSS_ENV) \
	CPPFLAGS="$(CROSS_CPPFLAGS) -isystem $(KERNEL_HEADERS_INCLUDE_DIR)"
endif

#
# autoconf
#
GST_PLUGINS_GOOD1_CONF_TOOL	:= autoconf
GST_PLUGINS_GOOD1_CONF_OPT	= \
	$(CROSS_AUTOCONF_USR) \
	$(GSTREAMER1_GENERIC_CONF_OPT) \
	--enable-external \
	--enable-experimental \
	\
	--enable-orc \
	--disable-directsound \
	--disable-waveform \
	\
	--disable-osx_audio \
	--disable-osx_video \
	--disable-aalibtest \
	--$(call ptx/endis,PTXCONF_GST_PLUGINS_GOOD1_ZLIB)-zlib \
	--$(call ptx/endis,PTXCONF_GST_PLUGINS_GOOD1_BZ2)-bz2 \
	--$(call ptx/wwo,PTXCONF_GST_PLUGINS_GOOD1_GST_V4L2)-gudev \
	--without-jpeg-mmx \
	--$(call ptx/wwo,PTXCONF_GST_PLUGINS_GOOD1_GST_V4L2_LIBV4L2)-libv4l2

#
# the --with-plugins sadly only applies to depencyless plugings
# and when no plugins are sellected it builds them all. So
# --with-plugins is useless, so we generate a --enable-*
# and --disable-* below
#
ifneq ($(call remove_quotes,$(GST_PLUGINS_GOOD1_ENABLEC-y)),)
GST_PLUGINS_GOOD1_CONF_OPT +=  --enable-$(subst $(space),$(space)--enable-,$(strip $(GST_PLUGINS_GOOD1_ENABLEC-y)))
endif

ifneq ($(call remove_quotes,$(GST_PLUGINS_GOOD1_ENABLEC-)),)
GST_PLUGINS_GOOD1_CONF_OPT +=  --disable-$(subst $(space),$(space)--disable-,$(strip $(GST_PLUGINS_GOOD1_ENABLEC-)))
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gst-plugins-good1.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gst-plugins-good1)
	@$(call install_fixup, gst-plugins-good1,PRIORITY,optional)
	@$(call install_fixup, gst-plugins-good1,SECTION,base)
	@$(call install_fixup, gst-plugins-good1,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, gst-plugins-good1,DESCRIPTION,missing)

	@for plugin in $(GST_PLUGINS_GOOD1_ENABLEP-y); do \
		$(call install_copy, gst-plugins-good1, 0, 0, 0644, -, \
			/usr/lib/gstreamer-1.0/libgst$${plugin}.so); \
	done

	@$(call install_finish, gst-plugins-good1)

	@$(call touch)

# vim: syntax=make
