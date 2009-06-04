Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2009 14:10:03 +0100 (WEST)
Received: from mail-px0-f186.google.com ([209.85.216.186]:49141 "EHLO
	mail-px0-f186.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20022624AbZFDNJX (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 4 Jun 2009 14:09:23 +0100
Received: by pxi16 with SMTP id 16so751019pxi.22
        for <multiple recipients>; Thu, 04 Jun 2009 06:09:15 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=v6L8p9O8xpxtqfA11XvS5Ds6bcEHRH9+5aLxErCi5Rw=;
        b=RWEmatMFaixKrueeR0yMHk/hTjL6Mol68gQPExEHH5cOnfdiUv0TfeJiEeZzBWKvnt
         s+wRu+wkDJ2nh3O4RosW3vWSNcOehkP3eXcW8RcnxCDxulIpn4KhNKBSHSpdW1I/Kc03
         7CY03ymTRAVxanQN+tMZ0nWglxcvubClhGDD0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=EMjNfl6N7JdTwtxXHBTrm/VZ++0euqawRXJvQjpE8bI5uUkfj1AtOuFAOjkvvMC8aO
         tvumWkZkvqoJSjHc/ckgbTZw/IDzsdbU/3Sm59sS/TJ2k581YkDYqgFsE27qsYOwCpQ3
         oq6baXilk6ADtlO+7rOQeaz21c+2cm7JO8n9k=
Received: by 10.114.60.11 with SMTP id i11mr3391552waa.199.1244120954742;
        Thu, 04 Jun 2009 06:09:14 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id m25sm11139629waf.9.2009.06.04.06.09.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Jun 2009 06:09:12 -0700 (PDT)
From:	wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	Simon Braunschmidt <sbraun@emlix.com>
Cc:	Wu Zhangjin <wuzj@lemote.com>, Yan Hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	loongson-dev <loongson-dev@googlegroups.com>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>,
	Arnaud Patard <apatard@mandriva.com>,
	Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [loongson-PATCH-v3 18/25] Add Siliconmotion 712 framebuffer driver
Date:	Thu,  4 Jun 2009 21:08:58 +0800
Message-Id: <ddb3e7e90c07600bb8ee578c47d84470eb27d4c2.1244120575.git.wuzj@lemote.com>
X-Mailer: git-send-email 1.6.3.1
In-Reply-To: <cover.1244120575.git.wuzj@lemote.com>
References: <cover.1244120575.git.wuzj@lemote.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23261
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzj@lemote.com>

yeeloong(2f) laptop has a SMI video card, need this driver.

this source code is originally from
http://dev.lemote.com/code/linux_loongson

tons of warnings have been fixed, the main warning is:

      warning: left shift count >= width of type

have been fixed via the following modification:

      drivers/video/smi/smtc2d.h:

      #define _F_MASK(f) ((((1 << _F_SIZE(f)) - 1) << _F_START(f))
      #define _F_MASK(f) (((1ULL << _F_SIZE(f)) - 1) << _F_START(f))

besides, the coding style is changed to follow the kernel style, and two
non-used header files are removed: sm501hw.h, sm7xxhw.h.

and there is no need to define a screen_info again so remove it, because
it is defined in arch/mips/kernel/setup.c and not relative to big endian
or little endian, and here I think its better use something like
1024x600x24 than 0x318, so replace all of the magic numbers to an
understandable one.

with the support of this patch, we can use the same kernel for 7inch and
8.9inch yeeloong laptop, but need pass a commandline argument for 7inch
baord:

vga=800x480x24

Tested-by: Simon Braunschmidt <sbraun@emlix.com>
Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
Signed-off-by: Yan Hua <yanh@lemote.com>
---
 drivers/video/Kconfig      |   23 +
 drivers/video/Makefile     |    1 +
 drivers/video/smi/Makefile |    8 +
 drivers/video/smi/smtc2d.c |  979 +++++++++++++++++++++++++++++++++++++
 drivers/video/smi/smtc2d.h |  530 +++++++++++++++++++++
 drivers/video/smi/smtcfb.c | 1138 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/video/smi/smtcfb.h |  793 ++++++++++++++++++++++++++++++
 7 files changed, 3472 insertions(+), 0 deletions(-)
 create mode 100644 drivers/video/smi/Makefile
 create mode 100644 drivers/video/smi/smtc2d.c
 create mode 100644 drivers/video/smi/smtc2d.h
 create mode 100644 drivers/video/smi/smtcfb.c
 create mode 100644 drivers/video/smi/smtcfb.h

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 0048f11..b6ba27f 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1930,6 +1930,29 @@ config FB_S3C2410_DEBUG
 	  Turn on debugging messages. Note that you can set/unset at run time
 	  through sysfs
 
+config FB_SILICONMOTION
+	bool "Silicon Motion Display Support"
+	depends on FB
+	help
+	  Frame Buffer driver for the Silicon Motion serial graphic card.
+
+config FB_SM7XX
+	bool "Silicon Motion SM7XX Frame Buffer Support"
+	depends on FB_SILICONMOTION
+	depends on FB
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	help
+	  Frame Buffer driver for the Silicon Motion SM7XX serial graphic card.
+
+config FB_SM7XX_ACCEL
+	bool "Siliconmotion Acceleration functions (EXPERIMENTAL)"
+	depends on FB_SM7XX && EXPERIMENTAL
+	help
+	This will compile the Trident frame buffer device with
+	acceleration functions.
+
 config FB_SM501
 	tristate "Silicon Motion SM501 framebuffer support"
 	depends on FB && MFD_SM501
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index d8d0be5..caf6d8c 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -70,6 +70,7 @@ obj-$(CONFIG_FB_P9100)            += p9100.o sbuslib.o
 obj-$(CONFIG_FB_TCX)              += tcx.o sbuslib.o
 obj-$(CONFIG_FB_LEO)              += leo.o sbuslib.o
 obj-$(CONFIG_FB_SGIVW)            += sgivwfb.o
+obj-$(CONFIG_FB_SILICONMOTION)    += smi/
 obj-$(CONFIG_FB_ACORN)            += acornfb.o
 obj-$(CONFIG_FB_ATARI)            += atafb.o c2p_iplan2.o atafb_mfb.o \
                                      atafb_iplan2p2.o atafb_iplan2p4.o atafb_iplan2p8.o
diff --git a/drivers/video/smi/Makefile b/drivers/video/smi/Makefile
new file mode 100644
index 0000000..0058148
--- /dev/null
+++ b/drivers/video/smi/Makefile
@@ -0,0 +1,8 @@
+obj-y += smi.o
+
+smi-y := $(DRIVER_OBJS)
+
+smi-y += smtcfb.o
+
+EXTRA_CFLAGS += -Werror
+
diff --git a/drivers/video/smi/smtc2d.c b/drivers/video/smi/smtc2d.c
new file mode 100644
index 0000000..2a9c3bd
--- /dev/null
+++ b/drivers/video/smi/smtc2d.c
@@ -0,0 +1,979 @@
+/*
+ * smtc2d.c -- Silicon Motion SM501 and SM7xx 2D drawing engine functions.
+ *
+ * Copyright (C) 2006 Silicon Motion Technology Corp.
+ * Author: Boyod boyod.yang@siliconmotion.com.cn
+ *
+ * Copyright (C) 2009 Lemote, Inc. & Institute of Computing Technology
+ * Author: Wu Zhangjin, wuzj@lemote.com
+ *
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License. See the file COPYING in the main directory of this archive for
+ *  more details.
+ *
+ * Version 0.10.26192.21.01
+ * 	- Add PowerPC support
+ * 	- Add 2D support for Lynx -
+ * Verified on 2.6.19.2
+ * 	Boyod.yang  <boyod.yang@siliconmotion.com.cn>
+ */
+
+unsigned char smtc_de_busy;
+
+void SMTC_write2Dreg(unsigned long nOffset, unsigned long nData)
+{
+	writel(nData, smtc_2DBaseAddress + nOffset);
+}
+
+unsigned long SMTC_read2Dreg(unsigned long nOffset)
+{
+	return readl(smtc_2DBaseAddress + nOffset);
+}
+
+void SMTC_write2Ddataport(unsigned long nOffset, unsigned long nData)
+{
+	writel(nData, smtc_2Ddataport + nOffset);
+}
+
+/**********************************************************************
+ *
+ * deInit
+ *
+ * Purpose
+ *    Drawing engine initialization.
+ *
+ **********************************************************************/
+
+void deInit(unsigned int nModeWidth, unsigned int nModeHeight,
+		unsigned int bpp)
+{
+	/* Get current power configuration. */
+	unsigned char clock;
+	clock = smtc_seqr(0x21);
+
+	/* initialize global 'mutex lock' variable */
+	smtc_de_busy = 0;
+
+	/* Enable 2D Drawing Engine */
+	smtc_seqw(0x21, clock & 0xF8);
+
+	SMTC_write2Dreg(DE_CLIP_TL,
+			FIELD_VALUE(0, DE_CLIP_TL, TOP, 0) |
+			FIELD_SET(0, DE_CLIP_TL, STATUS, DISABLE) |
+			FIELD_SET(0, DE_CLIP_TL, INHIBIT, OUTSIDE) |
+			FIELD_VALUE(0, DE_CLIP_TL, LEFT, 0));
+
+	if (bpp >= 24) {
+		SMTC_write2Dreg(DE_PITCH,
+				FIELD_VALUE(0, DE_PITCH, DESTINATION,
+					    nModeWidth * 3) | FIELD_VALUE(0,
+								  DE_PITCH,
+								  SOURCE,
+								  nModeWidth
+								  * 3));
+	} else {
+		SMTC_write2Dreg(DE_PITCH,
+				FIELD_VALUE(0, DE_PITCH, DESTINATION,
+					    nModeWidth) | FIELD_VALUE(0,
+							      DE_PITCH,
+							      SOURCE,
+							      nModeWidth));
+	}
+
+	SMTC_write2Dreg(DE_WINDOW_WIDTH,
+			FIELD_VALUE(0, DE_WINDOW_WIDTH, DESTINATION,
+				    nModeWidth) | FIELD_VALUE(0,
+							      DE_WINDOW_WIDTH,
+							      SOURCE,
+							      nModeWidth));
+
+	switch (bpp) {
+	case 8:
+		SMTC_write2Dreg(DE_STRETCH_FORMAT,
+				FIELD_SET(0, DE_STRETCH_FORMAT, PATTERN_XY,
+					  NORMAL) | FIELD_VALUE(0,
+							DE_STRETCH_FORMAT,
+							PATTERN_Y,
+							0) |
+				FIELD_VALUE(0, DE_STRETCH_FORMAT, PATTERN_X,
+				    0) | FIELD_SET(0, DE_STRETCH_FORMAT,
+						   PIXEL_FORMAT,
+						   8) | FIELD_SET(0,
+							  DE_STRETCH_FORMAT,
+							  ADDRESSING,
+							  XY) |
+				FIELD_VALUE(0, DE_STRETCH_FORMAT,
+					SOURCE_HEIGHT, 3));
+		break;
+	case 24:
+		SMTC_write2Dreg(DE_STRETCH_FORMAT,
+				FIELD_SET(0, DE_STRETCH_FORMAT, PATTERN_XY,
+					  NORMAL) | FIELD_VALUE(0,
+							DE_STRETCH_FORMAT,
+							PATTERN_Y,
+							0) |
+				FIELD_VALUE(0, DE_STRETCH_FORMAT, PATTERN_X,
+				    0) | FIELD_SET(0, DE_STRETCH_FORMAT,
+							   PIXEL_FORMAT,
+							   24) | FIELD_SET(0,
+							   DE_STRETCH_FORMAT,
+							   ADDRESSING,
+							   XY) |
+				FIELD_VALUE(0, DE_STRETCH_FORMAT,
+					SOURCE_HEIGHT, 3));
+		break;
+	case 16:
+	default:
+		SMTC_write2Dreg(DE_STRETCH_FORMAT,
+				FIELD_SET(0, DE_STRETCH_FORMAT, PATTERN_XY,
+					  NORMAL) | FIELD_VALUE(0,
+							DE_STRETCH_FORMAT,
+							PATTERN_Y,
+							0) |
+				FIELD_VALUE(0, DE_STRETCH_FORMAT, PATTERN_X,
+				    0) | FIELD_SET(0, DE_STRETCH_FORMAT,
+							   PIXEL_FORMAT,
+							   16) | FIELD_SET(0,
+							   DE_STRETCH_FORMAT,
+							   ADDRESSING,
+							   XY) |
+				FIELD_VALUE(0, DE_STRETCH_FORMAT,
+					SOURCE_HEIGHT, 3));
+		break;
+	}
+
+	SMTC_write2Dreg(DE_MASKS,
+			FIELD_VALUE(0, DE_MASKS, BYTE_MASK, 0xFFFF) |
+			FIELD_VALUE(0, DE_MASKS, BIT_MASK, 0xFFFF));
+	SMTC_write2Dreg(DE_COLOR_COMPARE_MASK,
+			FIELD_VALUE(0, DE_COLOR_COMPARE_MASK, MASKS, \
+				0xFFFFFF));
+	SMTC_write2Dreg(DE_COLOR_COMPARE,
+			FIELD_VALUE(0, DE_COLOR_COMPARE, COLOR, 0xFFFFFF));
+}
+
+void deVerticalLine(unsigned long dst_base,
+		    unsigned long dst_pitch,
+		    unsigned long nX,
+		    unsigned long nY,
+		    unsigned long dst_height, unsigned long nColor)
+{
+	deWaitForNotBusy();
+
+	SMTC_write2Dreg(DE_WINDOW_DESTINATION_BASE,
+			FIELD_VALUE(0, DE_WINDOW_DESTINATION_BASE, ADDRESS,
+				    dst_base));
+
+	SMTC_write2Dreg(DE_PITCH,
+			FIELD_VALUE(0, DE_PITCH, DESTINATION, dst_pitch) |
+			FIELD_VALUE(0, DE_PITCH, SOURCE, dst_pitch));
+
+	SMTC_write2Dreg(DE_WINDOW_WIDTH,
+			FIELD_VALUE(0, DE_WINDOW_WIDTH, DESTINATION,
+			    dst_pitch) | FIELD_VALUE(0, DE_WINDOW_WIDTH,
+						     SOURCE,
+						     dst_pitch));
+
+	SMTC_write2Dreg(DE_FOREGROUND,
+			FIELD_VALUE(0, DE_FOREGROUND, COLOR, nColor));
+
+	SMTC_write2Dreg(DE_DESTINATION,
+			FIELD_SET(0, DE_DESTINATION, WRAP, DISABLE) |
+			FIELD_VALUE(0, DE_DESTINATION, X, nX) |
+			FIELD_VALUE(0, DE_DESTINATION, Y, nY));
+
+	SMTC_write2Dreg(DE_DIMENSION,
+			FIELD_VALUE(0, DE_DIMENSION, X, 1) |
+			FIELD_VALUE(0, DE_DIMENSION, Y_ET, dst_height));
+
+	SMTC_write2Dreg(DE_CONTROL,
+			FIELD_SET(0, DE_CONTROL, STATUS, START) |
+			FIELD_SET(0, DE_CONTROL, DIRECTION, LEFT_TO_RIGHT) |
+			FIELD_SET(0, DE_CONTROL, MAJOR, Y) |
+			FIELD_SET(0, DE_CONTROL, STEP_X, NEGATIVE) |
+			FIELD_SET(0, DE_CONTROL, STEP_Y, POSITIVE) |
+			FIELD_SET(0, DE_CONTROL, LAST_PIXEL, OFF) |
+			FIELD_SET(0, DE_CONTROL, COMMAND, SHORT_STROKE) |
+			FIELD_SET(0, DE_CONTROL, ROP_SELECT, ROP2) |
+			FIELD_VALUE(0, DE_CONTROL, ROP, 0x0C));
+
+	smtc_de_busy = 1;
+}
+
+void deHorizontalLine(unsigned long dst_base,
+		      unsigned long dst_pitch,
+		      unsigned long nX,
+		      unsigned long nY,
+		      unsigned long dst_width, unsigned long nColor)
+{
+	deWaitForNotBusy();
+
+	SMTC_write2Dreg(DE_WINDOW_DESTINATION_BASE,
+			FIELD_VALUE(0, DE_WINDOW_DESTINATION_BASE, ADDRESS,
+				    dst_base));
+
+	SMTC_write2Dreg(DE_PITCH,
+			FIELD_VALUE(0, DE_PITCH, DESTINATION, dst_pitch) |
+			FIELD_VALUE(0, DE_PITCH, SOURCE, dst_pitch));
+
+	SMTC_write2Dreg(DE_WINDOW_WIDTH,
+			FIELD_VALUE(0, DE_WINDOW_WIDTH, DESTINATION,
+			    dst_pitch) | FIELD_VALUE(0, DE_WINDOW_WIDTH,
+						     SOURCE,
+						     dst_pitch));
+	SMTC_write2Dreg(DE_FOREGROUND,
+			FIELD_VALUE(0, DE_FOREGROUND, COLOR, nColor));
+	SMTC_write2Dreg(DE_DESTINATION,
+			FIELD_SET(0, DE_DESTINATION, WRAP,
+			  DISABLE) | FIELD_VALUE(0, DE_DESTINATION, X,
+						 nX) | FIELD_VALUE(0,
+							   DE_DESTINATION,
+							   Y,
+							   nY));
+	SMTC_write2Dreg(DE_DIMENSION,
+			FIELD_VALUE(0, DE_DIMENSION, X,
+			    dst_width) | FIELD_VALUE(0, DE_DIMENSION,
+						     Y_ET, 1));
+	SMTC_write2Dreg(DE_CONTROL,
+		FIELD_SET(0, DE_CONTROL, STATUS, START) | FIELD_SET(0,
+							    DE_CONTROL,
+							    DIRECTION,
+							    RIGHT_TO_LEFT)
+		| FIELD_SET(0, DE_CONTROL, MAJOR, X) | FIELD_SET(0,
+							 DE_CONTROL,
+							 STEP_X,
+							 POSITIVE)
+		| FIELD_SET(0, DE_CONTROL, STEP_Y,
+			    NEGATIVE) | FIELD_SET(0, DE_CONTROL,
+						  LAST_PIXEL,
+						  OFF) | FIELD_SET(0,
+							   DE_CONTROL,
+							   COMMAND,
+							   SHORT_STROKE)
+		| FIELD_SET(0, DE_CONTROL, ROP_SELECT,
+			    ROP2) | FIELD_VALUE(0, DE_CONTROL, ROP,
+						0x0C));
+
+	smtc_de_busy = 1;
+}
+
+void deLine(unsigned long dst_base,
+	    unsigned long dst_pitch,
+	    unsigned long nX1,
+	    unsigned long nY1,
+	    unsigned long nX2, unsigned long nY2, unsigned long nColor)
+{
+	unsigned long nCommand =
+	    FIELD_SET(0, DE_CONTROL, STATUS, START) |
+	    FIELD_SET(0, DE_CONTROL, DIRECTION, LEFT_TO_RIGHT) |
+	    FIELD_SET(0, DE_CONTROL, MAJOR, X) |
+	    FIELD_SET(0, DE_CONTROL, STEP_X, POSITIVE) |
+	    FIELD_SET(0, DE_CONTROL, STEP_Y, POSITIVE) |
+	    FIELD_SET(0, DE_CONTROL, LAST_PIXEL, OFF) |
+	    FIELD_SET(0, DE_CONTROL, ROP_SELECT, ROP2) |
+	    FIELD_VALUE(0, DE_CONTROL, ROP, 0x0C);
+	unsigned long DeltaX;
+	unsigned long DeltaY;
+
+	/* Calculate delta X */
+	if (nX1 <= nX2)
+		DeltaX = nX2 - nX1;
+	else {
+		DeltaX = nX1 - nX2;
+		nCommand = FIELD_SET(nCommand, DE_CONTROL, STEP_X, NEGATIVE);
+	}
+
+	/* Calculate delta Y */
+	if (nY1 <= nY2)
+		DeltaY = nY2 - nY1;
+	else {
+		DeltaY = nY1 - nY2;
+		nCommand = FIELD_SET(nCommand, DE_CONTROL, STEP_Y, NEGATIVE);
+	}
+
+	/* Determine the major axis */
+	if (DeltaX < DeltaY)
+		nCommand = FIELD_SET(nCommand, DE_CONTROL, MAJOR, Y);
+
+	/* Vertical line? */
+	if (nX1 == nX2)
+		deVerticalLine(dst_base, dst_pitch, nX1, nY1, DeltaY, nColor);
+
+	/* Horizontal line? */
+	else if (nY1 == nY2)
+		deHorizontalLine(dst_base, dst_pitch, nX1, nY1, \
+				DeltaX, nColor);
+
+	/* Diagonal line? */
+	else if (DeltaX == DeltaY) {
+		deWaitForNotBusy();
+
+		SMTC_write2Dreg(DE_WINDOW_DESTINATION_BASE,
+				FIELD_VALUE(0, DE_WINDOW_DESTINATION_BASE,
+					    ADDRESS, dst_base));
+
+		SMTC_write2Dreg(DE_PITCH,
+				FIELD_VALUE(0, DE_PITCH, DESTINATION,
+					    dst_pitch) | FIELD_VALUE(0,
+							     DE_PITCH,
+							     SOURCE,
+							     dst_pitch));
+
+		SMTC_write2Dreg(DE_WINDOW_WIDTH,
+				FIELD_VALUE(0, DE_WINDOW_WIDTH, DESTINATION,
+					    dst_pitch) | FIELD_VALUE(0,
+							     DE_WINDOW_WIDTH,
+							     SOURCE,
+							     dst_pitch));
+
+		SMTC_write2Dreg(DE_FOREGROUND,
+				FIELD_VALUE(0, DE_FOREGROUND, COLOR, nColor));
+
+		SMTC_write2Dreg(DE_DESTINATION,
+				FIELD_SET(0, DE_DESTINATION, WRAP, DISABLE) |
+				FIELD_VALUE(0, DE_DESTINATION, X, 1) |
+				FIELD_VALUE(0, DE_DESTINATION, Y, nY1));
+
+		SMTC_write2Dreg(DE_DIMENSION,
+				FIELD_VALUE(0, DE_DIMENSION, X, 1) |
+				FIELD_VALUE(0, DE_DIMENSION, Y_ET, DeltaX));
+
+		SMTC_write2Dreg(DE_CONTROL,
+				FIELD_SET(nCommand, DE_CONTROL, COMMAND,
+					  SHORT_STROKE));
+	}
+
+	/* Generic line */
+	else {
+		unsigned int k1, k2, et, w;
+		if (DeltaX < DeltaY) {
+			k1 = 2 * DeltaX;
+			et = k1 - DeltaY;
+			k2 = et - DeltaY;
+			w = DeltaY + 1;
+		} else {
+			k1 = 2 * DeltaY;
+			et = k1 - DeltaX;
+			k2 = et - DeltaX;
+			w = DeltaX + 1;
+		}
+
+		deWaitForNotBusy();
+
+		SMTC_write2Dreg(DE_WINDOW_DESTINATION_BASE,
+				FIELD_VALUE(0, DE_WINDOW_DESTINATION_BASE,
+					    ADDRESS, dst_base));
+
+		SMTC_write2Dreg(DE_PITCH,
+				FIELD_VALUE(0, DE_PITCH, DESTINATION,
+					    dst_pitch) | FIELD_VALUE(0,
+							     DE_PITCH,
+							     SOURCE,
+							     dst_pitch));
+
+		SMTC_write2Dreg(DE_WINDOW_WIDTH,
+				FIELD_VALUE(0, DE_WINDOW_WIDTH, DESTINATION,
+					    dst_pitch) | FIELD_VALUE(0,
+							     DE_WINDOW_WIDTH,
+							     SOURCE,
+							     dst_pitch));
+
+		SMTC_write2Dreg(DE_FOREGROUND,
+				FIELD_VALUE(0, DE_FOREGROUND, COLOR, nColor));
+
+		SMTC_write2Dreg(DE_SOURCE,
+				FIELD_SET(0, DE_SOURCE, WRAP, DISABLE) |
+				FIELD_VALUE(0, DE_SOURCE, X_K1, k1) |
+				FIELD_VALUE(0, DE_SOURCE, Y_K2, k2));
+
+		SMTC_write2Dreg(DE_DESTINATION,
+				FIELD_SET(0, DE_DESTINATION, WRAP, DISABLE) |
+				FIELD_VALUE(0, DE_DESTINATION, X, nX1) |
+				FIELD_VALUE(0, DE_DESTINATION, Y, nY1));
+
+		SMTC_write2Dreg(DE_DIMENSION,
+				FIELD_VALUE(0, DE_DIMENSION, X, w) |
+				FIELD_VALUE(0, DE_DIMENSION, Y_ET, et));
+
+		SMTC_write2Dreg(DE_CONTROL,
+				FIELD_SET(nCommand, DE_CONTROL, COMMAND,
+					  LINE_DRAW));
+	}
+
+	smtc_de_busy = 1;
+}
+
+void deFillRect(unsigned long dst_base,
+		unsigned long dst_pitch,
+		unsigned long dst_X,
+		unsigned long dst_Y,
+		unsigned long dst_width,
+		unsigned long dst_height, unsigned long nColor)
+{
+	deWaitForNotBusy();
+
+	SMTC_write2Dreg(DE_WINDOW_DESTINATION_BASE,
+			FIELD_VALUE(0, DE_WINDOW_DESTINATION_BASE, ADDRESS,
+				    dst_base));
+
+	if (dst_pitch) {
+		SMTC_write2Dreg(DE_PITCH,
+				FIELD_VALUE(0, DE_PITCH, DESTINATION,
+					    dst_pitch) | FIELD_VALUE(0,
+							     DE_PITCH,
+							     SOURCE,
+							     dst_pitch));
+
+		SMTC_write2Dreg(DE_WINDOW_WIDTH,
+				FIELD_VALUE(0, DE_WINDOW_WIDTH, DESTINATION,
+					    dst_pitch) | FIELD_VALUE(0,
+							     DE_WINDOW_WIDTH,
+							     SOURCE,
+							     dst_pitch));
+	}
+
+	SMTC_write2Dreg(DE_FOREGROUND,
+			FIELD_VALUE(0, DE_FOREGROUND, COLOR, nColor));
+
+	SMTC_write2Dreg(DE_DESTINATION,
+			FIELD_SET(0, DE_DESTINATION, WRAP, DISABLE) |
+			FIELD_VALUE(0, DE_DESTINATION, X, dst_X) |
+			FIELD_VALUE(0, DE_DESTINATION, Y, dst_Y));
+
+	SMTC_write2Dreg(DE_DIMENSION,
+			FIELD_VALUE(0, DE_DIMENSION, X, dst_width) |
+			FIELD_VALUE(0, DE_DIMENSION, Y_ET, dst_height));
+
+	SMTC_write2Dreg(DE_CONTROL,
+			FIELD_SET(0, DE_CONTROL, STATUS, START) |
+			FIELD_SET(0, DE_CONTROL, DIRECTION, LEFT_TO_RIGHT) |
+			FIELD_SET(0, DE_CONTROL, LAST_PIXEL, OFF) |
+			FIELD_SET(0, DE_CONTROL, COMMAND, RECTANGLE_FILL) |
+			FIELD_SET(0, DE_CONTROL, ROP_SELECT, ROP2) |
+			FIELD_VALUE(0, DE_CONTROL, ROP, 0x0C));
+
+	smtc_de_busy = 1;
+}
+
+/**********************************************************************
+ *
+ * deRotatePattern
+ *
+ * Purpose
+ *    Rotate the given pattern if necessary
+ *
+ * Parameters
+ *    [in]
+ *	   pPattern  - Pointer to DE_SURFACE structure containing
+ *		       pattern attributes
+ *	   patternX  - X position (0-7) of pattern origin
+ *	   patternY  - Y position (0-7) of pattern origin
+ *
+ *    [out]
+ *	   pattern_dstaddr - Pointer to pre-allocated buffer containing
+ *	   rotated pattern
+ *
+ **********************************************************************/
+void deRotatePattern(unsigned char *pattern_dstaddr,
+		     unsigned long pattern_src_addr,
+		     unsigned long pattern_BPP,
+		     unsigned long pattern_stride, int patternX, int patternY)
+{
+	unsigned int i;
+	unsigned long pattern[PATTERN_WIDTH * PATTERN_HEIGHT];
+	unsigned int x, y;
+	unsigned char *pjPatByte;
+
+	if (pattern_dstaddr != NULL) {
+		deWaitForNotBusy();
+
+		if (patternX || patternY) {
+			/* Rotate pattern */
+			pjPatByte = (unsigned char *)pattern;
+
+			switch (pattern_BPP) {
+			case 8:
+				{
+					for (y = 0; y < 8; y++) {
+						unsigned char *pjBuffer =
+						    pattern_dstaddr +
+						    ((patternY + y) & 7) * 8;
+						for (x = 0; x < 8; x++) {
+							pjBuffer[(patternX +
+								  x) & 7] =
+							    pjPatByte[x];
+						}
+						pjPatByte += pattern_stride;
+					}
+					break;
+				}
+
+			case 16:
+				{
+					for (y = 0; y < 8; y++) {
+						unsigned short *pjBuffer =
+						    (unsigned short *)
+						    pattern_dstaddr +
+						    ((patternY + y) & 7) * 8;
+						for (x = 0; x < 8; x++) {
+							pjBuffer[(patternX +
+								  x) & 7] =
+							    ((unsigned short *)
+							     pjPatByte)[x];
+						}
+						pjPatByte += pattern_stride;
+					}
+					break;
+				}
+
+			case 32:
+				{
+					for (y = 0; y < 8; y++) {
+						unsigned long *pjBuffer =
+						    (unsigned long *)
+						    pattern_dstaddr +
+						    ((patternY + y) & 7) * 8;
+						for (x = 0; x < 8; x++) {
+							pjBuffer[(patternX +
+								  x) & 7] =
+							    ((unsigned long *)
+							     pjPatByte)[x];
+						}
+						pjPatByte += pattern_stride;
+					}
+					break;
+				}
+			}
+		} else {
+			/*Don't rotate,just copy pattern into pattern_dstaddr*/
+			for (i = 0; i < (pattern_BPP * 2); i++) {
+				((unsigned long *)pattern_dstaddr)[i] =
+				    pattern[i];
+			}
+		}
+
+	}
+}
+
+/**********************************************************************
+ *
+ * deCopy
+ *
+ * Purpose
+ *    Copy a rectangular area of the source surface to a destination surface
+ *
+ * Remarks
+ *    Source bitmap must have the same color depth (BPP) as the destination
+ *    bitmap.
+ *
+**********************************************************************/
+void deCopy(unsigned long dst_base,
+	    unsigned long dst_pitch,
+	    unsigned long dst_BPP,
+	    unsigned long dst_X,
+	    unsigned long dst_Y,
+	    unsigned long dst_width,
+	    unsigned long dst_height,
+	    unsigned long src_base,
+	    unsigned long src_pitch,
+	    unsigned long src_X,
+	    unsigned long src_Y, pTransparent pTransp, unsigned char nROP2)
+{
+	unsigned long nDirection = 0;
+	unsigned long nTransparent = 0;
+	/* Direction of ROP2 operation:
+	 * 1 = Left to Right,
+	 * (-1) = Right to Left
+	 */
+	unsigned long opSign = 1;
+	/* xWidth is in pixels */
+	unsigned long xWidth = 192 / (dst_BPP / 8);
+	unsigned long de_ctrl = 0;
+
+	deWaitForNotBusy();
+
+	SMTC_write2Dreg(DE_WINDOW_DESTINATION_BASE,
+			FIELD_VALUE(0, DE_WINDOW_DESTINATION_BASE, ADDRESS,
+				    dst_base));
+
+	SMTC_write2Dreg(DE_WINDOW_SOURCE_BASE,
+			FIELD_VALUE(0, DE_WINDOW_SOURCE_BASE, ADDRESS,
+				    src_base));
+
+	if (dst_pitch && src_pitch) {
+		SMTC_write2Dreg(DE_PITCH,
+			FIELD_VALUE(0, DE_PITCH, DESTINATION,
+				    dst_pitch) | FIELD_VALUE(0,
+						     DE_PITCH,
+						     SOURCE,
+						     src_pitch));
+
+		SMTC_write2Dreg(DE_WINDOW_WIDTH,
+			FIELD_VALUE(0, DE_WINDOW_WIDTH, DESTINATION,
+				    dst_pitch) | FIELD_VALUE(0,
+						     DE_WINDOW_WIDTH,
+						     SOURCE,
+						     src_pitch));
+	}
+
+	/* Set transparent bits if necessary */
+	if (pTransp != NULL) {
+		nTransparent =
+		    pTransp->match | pTransp->select | pTransp->control;
+
+		/* Set color compare register */
+		SMTC_write2Dreg(DE_COLOR_COMPARE,
+				FIELD_VALUE(0, DE_COLOR_COMPARE, COLOR,
+					    pTransp->color));
+	}
+
+	/* Determine direction of operation */
+	if (src_Y < dst_Y) {
+		/* +----------+
+		   |S         |
+		   |          +----------+
+		   |          |      |   |
+		   |          |      |   |
+		   +---|------+      |
+		   |               D |
+		   +----------+ */
+
+		nDirection = BOTTOM_TO_TOP;
+	} else if (src_Y > dst_Y) {
+		/* +----------+
+		   |D         |
+		   |          +----------+
+		   |          |      |   |
+		   |          |      |   |
+		   +---|------+      |
+		   |               S |
+		   +----------+ */
+
+		nDirection = TOP_TO_BOTTOM;
+	} else {
+		/* src_Y == dst_Y */
+
+		if (src_X <= dst_X) {
+			/* +------+---+------+
+			   |S     |   |     D|
+			   |      |   |      |
+			   |      |   |      |
+			   |      |   |      |
+			   +------+---+------+ */
+
+			nDirection = RIGHT_TO_LEFT;
+		} else {
+			/* src_X > dst_X */
+
+			/* +------+---+------+
+			   |D     |   |     S|
+			   |      |   |      |
+			   |      |   |      |
+			   |      |   |      |
+			   +------+---+------+ */
+
+			nDirection = LEFT_TO_RIGHT;
+		}
+	}
+
+	if ((nDirection == BOTTOM_TO_TOP) || (nDirection == RIGHT_TO_LEFT)) {
+		src_X += dst_width - 1;
+		src_Y += dst_height - 1;
+		dst_X += dst_width - 1;
+		dst_Y += dst_height - 1;
+		opSign = (-1);
+	}
+
+	if (dst_BPP >= 24) {
+		src_X *= 3;
+		src_Y *= 3;
+		dst_X *= 3;
+		dst_Y *= 3;
+		dst_width *= 3;
+		if ((nDirection == BOTTOM_TO_TOP)
+		    || (nDirection == RIGHT_TO_LEFT)) {
+			src_X += 2;
+			dst_X += 2;
+		}
+	}
+
+	/* Workaround for 192 byte hw bug */
+	if ((nROP2 != 0x0C) && ((dst_width * (dst_BPP / 8)) >= 192)) {
+		/*
+		 * Perform the ROP2 operation in chunks of (xWidth *
+		 * dst_height)
+		 */
+		while (1) {
+			deWaitForNotBusy();
+
+			SMTC_write2Dreg(DE_SOURCE,
+				FIELD_SET(0, DE_SOURCE, WRAP, DISABLE) |
+				FIELD_VALUE(0, DE_SOURCE, X_K1, src_X) |
+				FIELD_VALUE(0, DE_SOURCE, Y_K2, src_Y));
+
+			SMTC_write2Dreg(DE_DESTINATION,
+				FIELD_SET(0, DE_DESTINATION, WRAP,
+				  DISABLE) | FIELD_VALUE(0,
+							 DE_DESTINATION,
+							 X,
+							 dst_X)
+			| FIELD_VALUE(0, DE_DESTINATION, Y,
+						      dst_Y));
+
+			SMTC_write2Dreg(DE_DIMENSION,
+				FIELD_VALUE(0, DE_DIMENSION, X,
+				    xWidth) | FIELD_VALUE(0,
+							  DE_DIMENSION,
+							  Y_ET,
+							  dst_height));
+
+			de_ctrl =
+			    FIELD_VALUE(0, DE_CONTROL, ROP,
+				nROP2) | nTransparent | FIELD_SET(0,
+							  DE_CONTROL,
+							  ROP_SELECT,
+							  ROP2)
+			    | FIELD_SET(0, DE_CONTROL, COMMAND,
+				BITBLT) | ((nDirection ==
+					    1) ? FIELD_SET(0,
+						   DE_CONTROL,
+						   DIRECTION,
+						   RIGHT_TO_LEFT)
+					   : FIELD_SET(0, DE_CONTROL,
+					       DIRECTION,
+					       LEFT_TO_RIGHT)) |
+			    FIELD_SET(0, DE_CONTROL, STATUS, START);
+
+			SMTC_write2Dreg(DE_CONTROL, de_ctrl);
+
+			src_X += (opSign * xWidth);
+			dst_X += (opSign * xWidth);
+			dst_width -= xWidth;
+
+			if (dst_width <= 0) {
+				/* ROP2 operation is complete */
+				break;
+			}
+
+			if (xWidth > dst_width)
+				xWidth = dst_width;
+		}
+	} else {
+		deWaitForNotBusy();
+		SMTC_write2Dreg(DE_SOURCE,
+			FIELD_SET(0, DE_SOURCE, WRAP, DISABLE) |
+			FIELD_VALUE(0, DE_SOURCE, X_K1, src_X) |
+			FIELD_VALUE(0, DE_SOURCE, Y_K2, src_Y));
+
+		SMTC_write2Dreg(DE_DESTINATION,
+			FIELD_SET(0, DE_DESTINATION, WRAP, DISABLE) |
+			FIELD_VALUE(0, DE_DESTINATION, X, dst_X) |
+			FIELD_VALUE(0, DE_DESTINATION, Y, dst_Y));
+
+		SMTC_write2Dreg(DE_DIMENSION,
+			FIELD_VALUE(0, DE_DIMENSION, X, dst_width) |
+			FIELD_VALUE(0, DE_DIMENSION, Y_ET, dst_height));
+
+		de_ctrl = FIELD_VALUE(0, DE_CONTROL, ROP, nROP2) |
+		    nTransparent |
+		    FIELD_SET(0, DE_CONTROL, ROP_SELECT, ROP2) |
+		    FIELD_SET(0, DE_CONTROL, COMMAND, BITBLT) |
+		    ((nDirection == 1) ? FIELD_SET(0, DE_CONTROL, DIRECTION,
+						   RIGHT_TO_LEFT)
+		     : FIELD_SET(0, DE_CONTROL, DIRECTION,
+				 LEFT_TO_RIGHT)) | FIELD_SET(0, DE_CONTROL,
+							     STATUS, START);
+		SMTC_write2Dreg(DE_CONTROL, de_ctrl);
+	}
+
+	smtc_de_busy = 1;
+}
+
+/*
+ * This function sets the pixel format that will apply to the 2D Engine.
+ */
+void deSetPixelFormat(unsigned long bpp)
+{
+	unsigned long de_format;
+
+	de_format = SMTC_read2Dreg(DE_STRETCH_FORMAT);
+
+	switch (bpp) {
+	case 8:
+		de_format =
+		    FIELD_SET(de_format, DE_STRETCH_FORMAT, PIXEL_FORMAT, 8);
+		break;
+	default:
+	case 16:
+		de_format =
+		    FIELD_SET(de_format, DE_STRETCH_FORMAT, PIXEL_FORMAT, 16);
+		break;
+	case 32:
+		de_format =
+		    FIELD_SET(de_format, DE_STRETCH_FORMAT, PIXEL_FORMAT, 32);
+		break;
+	}
+
+	SMTC_write2Dreg(DE_STRETCH_FORMAT, de_format);
+}
+
+/*
+ * System memory to Video memory monochrome expansion.
+ *
+ * Source is monochrome image in system memory.  This function expands the
+ * monochrome data to color image in video memory.
+ */
+
+long deSystemMem2VideoMemMonoBlt(const char *pSrcbuf,
+				 long srcDelta,
+				 unsigned long startBit,
+				 unsigned long dBase,
+				 unsigned long dPitch,
+				 unsigned long bpp,
+				 unsigned long dx, unsigned long dy,
+				 unsigned long width, unsigned long height,
+				 unsigned long fColor,
+				 unsigned long bColor,
+				 unsigned long rop2) {
+	unsigned long bytePerPixel;
+	unsigned long ulBytesPerScan;
+	unsigned long ul4BytesPerScan;
+	unsigned long ulBytesRemain;
+	unsigned long de_ctrl = 0;
+	unsigned char ajRemain[4];
+	long i, j;
+
+	bytePerPixel = bpp / 8;
+
+	/* Just make sure the start bit is within legal range */
+	startBit &= 7;
+
+	ulBytesPerScan = (width + startBit + 7) / 8;
+	ul4BytesPerScan = ulBytesPerScan & ~3;
+	ulBytesRemain = ulBytesPerScan & 3;
+
+	if (smtc_de_busy)
+		deWaitForNotBusy();
+
+	/*
+	 * 2D Source Base.  Use 0 for HOST Blt.
+	 */
+
+	SMTC_write2Dreg(DE_WINDOW_SOURCE_BASE, 0);
+
+	/*
+	 * 2D Destination Base.
+	 *
+	 * It is an address offset (128 bit aligned) from the beginning of
+	 * frame buffer.
+	 */
+
+	SMTC_write2Dreg(DE_WINDOW_DESTINATION_BASE, dBase);
+
+	if (dPitch) {
+
+		/*
+		 * Program pitch (distance between the 1st points of two
+		 * adjacent lines).
+		 *
+		 * Note that input pitch is BYTE value, but the 2D Pitch
+		 * register uses pixel values. Need Byte to pixel convertion.
+		 */
+
+		SMTC_write2Dreg(DE_PITCH,
+			FIELD_VALUE(0, DE_PITCH, DESTINATION,
+			    dPitch /
+			    bytePerPixel) | FIELD_VALUE(0,
+							DE_PITCH,
+							SOURCE,
+							dPitch /
+							bytePerPixel));
+
+		/* Screen Window width in Pixels.
+		 *
+		 * 2D engine uses this value to calculate the linear address in
+		 * frame buffer for a given point.
+		 */
+
+		SMTC_write2Dreg(DE_WINDOW_WIDTH,
+			FIELD_VALUE(0, DE_WINDOW_WIDTH, DESTINATION,
+			    (dPitch /
+			     bytePerPixel)) | FIELD_VALUE(0,
+							  DE_WINDOW_WIDTH,
+							  SOURCE,
+							  (dPitch
+							   /
+							   bytePerPixel)));
+	}
+	/* Note: For 2D Source in Host Write, only X_K1 field is needed, and
+	 * Y_K2 field is not used. For mono bitmap, use startBit for X_K1.
+	 */
+
+	SMTC_write2Dreg(DE_SOURCE,
+			FIELD_SET(0, DE_SOURCE, WRAP, DISABLE) |
+			FIELD_VALUE(0, DE_SOURCE, X_K1, startBit) |
+			FIELD_VALUE(0, DE_SOURCE, Y_K2, 0));
+
+	SMTC_write2Dreg(DE_DESTINATION,
+			FIELD_SET(0, DE_DESTINATION, WRAP, DISABLE) |
+			FIELD_VALUE(0, DE_DESTINATION, X, dx) |
+			FIELD_VALUE(0, DE_DESTINATION, Y, dy));
+
+	SMTC_write2Dreg(DE_DIMENSION,
+			FIELD_VALUE(0, DE_DIMENSION, X, width) |
+			FIELD_VALUE(0, DE_DIMENSION, Y_ET, height));
+
+	SMTC_write2Dreg(DE_FOREGROUND, fColor);
+	SMTC_write2Dreg(DE_BACKGROUND, bColor);
+
+	if (bpp)
+		deSetPixelFormat(bpp);
+	/* Set the pixel format of the destination */
+
+	de_ctrl = FIELD_VALUE(0, DE_CONTROL, ROP, rop2) |
+	    FIELD_SET(0, DE_CONTROL, ROP_SELECT, ROP2) |
+	    FIELD_SET(0, DE_CONTROL, COMMAND, HOST_WRITE) |
+	    FIELD_SET(0, DE_CONTROL, HOST, MONO) |
+	    FIELD_SET(0, DE_CONTROL, STATUS, START);
+
+	SMTC_write2Dreg(DE_CONTROL, de_ctrl | deGetTransparency());
+
+	/* Write MONO data (line by line) to 2D Engine data port */
+	for (i = 0; i < height; i++) {
+		/* For each line, send the data in chunks of 4 bytes */
+		for (j = 0; j < (ul4BytesPerScan / 4); j++)
+			SMTC_write2Ddataport(0,
+					     *(unsigned long *)(pSrcbuf +
+								(j * 4)));
+
+		if (ulBytesRemain) {
+			memcpy(ajRemain, pSrcbuf + ul4BytesPerScan,
+			       ulBytesRemain);
+			SMTC_write2Ddataport(0, *(unsigned long *)ajRemain);
+		}
+
+		pSrcbuf += srcDelta;
+	}
+	smtc_de_busy = 1;
+
+	return 0;
+}
+
+/*
+ * This function gets the transparency status from DE_CONTROL register.
+ * It returns a double word with the transparent fields properly set,
+ * while other fields are 0.
+ */
+unsigned long deGetTransparency(void)
+{
+	unsigned long de_ctrl;
+
+	de_ctrl = SMTC_read2Dreg(DE_CONTROL);
+
+	de_ctrl &=
+	    FIELD_MASK(DE_CONTROL_TRANSPARENCY_MATCH) |
+	    FIELD_MASK(DE_CONTROL_TRANSPARENCY_SELECT) |
+	    FIELD_MASK(DE_CONTROL_TRANSPARENCY);
+
+	return de_ctrl;
+}
diff --git a/drivers/video/smi/smtc2d.h b/drivers/video/smi/smtc2d.h
new file mode 100644
index 0000000..3cd640c
--- /dev/null
+++ b/drivers/video/smi/smtc2d.h
@@ -0,0 +1,530 @@
+/*
+ * smtc2d.h -- Silicon Motion SM501 and SM7xx 2D drawing engine functions.
+ *
+ * Copyright (C) 2006 Silicon Motion Technology Corp.
+ * Author: Ge Wang, gewang@siliconmotion.com
+ *
+ * Copyright (C) 2009 Lemote, Inc. & Institute of Computing Technology
+ * Author: Wu Zhangjin, wuzj@lemote.com
+ *
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License. See the file COPYING in the main directory of this archive for
+ *  more details.
+ */
+
+#ifndef NULL
+#define NULL	 0
+#endif
+
+/* Internal macros */
+
+#define _F_START(f)		(0 ? f)
+#define _F_END(f)		(1 ? f)
+#define _F_SIZE(f)		(1 + _F_END(f) - _F_START(f))
+#define _F_MASK(f)		(((1ULL << _F_SIZE(f)) - 1) << _F_START(f))
+#define _F_NORMALIZE(v, f)	(((v) & _F_MASK(f)) >> _F_START(f))
+#define _F_DENORMALIZE(v, f)	(((v) << _F_START(f)) & _F_MASK(f))
+
+/* Global macros */
+
+#define FIELD_GET(x, reg, field) \
+( \
+    _F_NORMALIZE((x), reg ## _ ## field) \
+)
+
+#define FIELD_SET(x, reg, field, value) \
+( \
+    (x & ~_F_MASK(reg ## _ ## field)) \
+    | _F_DENORMALIZE(reg ## _ ## field ## _ ## value, reg ## _ ## field) \
+)
+
+#define FIELD_VALUE(x, reg, field, value) \
+( \
+    (x & ~_F_MASK(reg ## _ ## field)) \
+    | _F_DENORMALIZE(value, reg ## _ ## field) \
+)
+
+#define FIELD_CLEAR(reg, field) \
+( \
+    ~_F_MASK(reg ## _ ## field) \
+)
+
+/* Field Macros                        */
+
+#define FIELD_START(field)	(0 ? field)
+#define FIELD_END(field)	(1 ? field)
+#define FIELD_SIZE(field) \
+	(1 + FIELD_END(field) - FIELD_START(field))
+
+#define FIELD_MASK(field) \
+	(((1 << (FIELD_SIZE(field)-1)) \
+	| ((1 << (FIELD_SIZE(field)-1)) - 1)) \
+	<< FIELD_START(field))
+
+#define FIELD_NORMALIZE(reg, field) \
+	(((reg) & FIELD_MASK(field)) >> FIELD_START(field))
+
+#define FIELD_DENORMALIZE(field, value) \
+	(((value) << FIELD_START(field)) & FIELD_MASK(field))
+
+#define FIELD_INIT(reg, field, value) \
+	FIELD_DENORMALIZE(reg ## _ ## field, \
+		reg ## _ ## field ## _ ## value)
+
+#define FIELD_INIT_VAL(reg, field, value) \
+	(FIELD_DENORMALIZE(reg ## _ ## field, value))
+
+#define FIELD_VAL_SET(x, r, f, v) ({ \
+	x = (x & ~FIELD_MASK(r ## _ ## f)) \
+	| FIELD_DENORMALIZE(r ## _ ## f, r ## _ ## f ## _ ## v) \
+})
+
+#define RGB(r, g, b)	((unsigned long)(((r) << 16) | ((g) << 8) | (b)))
+
+/* Transparent info definition */
+typedef struct {
+	unsigned long match;	/* Matching pixel is OPAQUE/TRANSPARENT */
+	unsigned long select;	/* Transparency controlled by SRC/DST */
+	unsigned long control;	/* ENABLE/DISABLE transparency */
+	unsigned long color;	/* Transparent color */
+} Transparent, *pTransparent;
+
+#define PIXEL_DEPTH_1_BP	0	/* 1 bit per pixel */
+#define PIXEL_DEPTH_8_BPP	1	/* 8 bits per pixel */
+#define PIXEL_DEPTH_16_BPP	2	/* 16 bits per pixel */
+#define PIXEL_DEPTH_32_BPP	3	/* 32 bits per pixel */
+#define PIXEL_DEPTH_YUV422	8	/* 16 bits per pixel YUV422 */
+#define PIXEL_DEPTH_YUV420	9	/* 16 bits per pixel YUV420 */
+
+#define PATTERN_WIDTH		8
+#define PATTERN_HEIGHT		8
+
+#define	TOP_TO_BOTTOM		0
+#define	BOTTOM_TO_TOP		1
+#define RIGHT_TO_LEFT		BOTTOM_TO_TOP
+#define LEFT_TO_RIGHT		TOP_TO_BOTTOM
+
+/* Constants used in Transparent structure */
+#define MATCH_OPAQUE		0x00000000
+#define MATCH_TRANSPARENT	0x00000400
+#define SOURCE			0x00000000
+#define DESTINATION		0x00000200
+
+/* 2D registers. */
+
+#define	DE_SOURCE			0x000000
+#define	DE_SOURCE_WRAP			31 : 31
+#define	DE_SOURCE_WRAP_DISABLE		0
+#define	DE_SOURCE_WRAP_ENABLE		1
+#define	DE_SOURCE_X_K1			29 : 16
+#define	DE_SOURCE_Y_K2			15 : 0
+
+#define	DE_DESTINATION			0x000004
+#define	DE_DESTINATION_WRAP		31 : 31
+#define	DE_DESTINATION_WRAP_DISABLE	0
+#define	DE_DESTINATION_WRAP_ENABLE	1
+#define	DE_DESTINATION_X		28 : 16
+#define	DE_DESTINATION_Y		15 : 0
+
+#define	DE_DIMENSION			0x000008
+#define	DE_DIMENSION_X			28 : 16
+#define	DE_DIMENSION_Y_ET		15 : 0
+
+#define	DE_CONTROL			0x00000C
+#define	DE_CONTROL_STATUS		31 : 31
+#define	DE_CONTROL_STATUS_STOP		0
+#define	DE_CONTROL_STATUS_START		1
+#define	DE_CONTROL_PATTERN		30 : 30
+#define	DE_CONTROL_PATTERN_MONO		0
+#define	DE_CONTROL_PATTERN_COLOR	1
+#define	DE_CONTROL_UPDATE_DESTINATION_X		29 : 29
+#define	DE_CONTROL_UPDATE_DESTINATION_X_DISABLE	0
+#define	DE_CONTROL_UPDATE_DESTINATION_X_ENABLE	1
+#define	DE_CONTROL_QUICK_START			28 : 28
+#define	DE_CONTROL_QUICK_START_DISABLE		0
+#define	DE_CONTROL_QUICK_START_ENABLE		1
+#define	DE_CONTROL_DIRECTION			27 : 27
+#define	DE_CONTROL_DIRECTION_LEFT_TO_RIGHT	0
+#define	DE_CONTROL_DIRECTION_RIGHT_TO_LEFT	1
+#define	DE_CONTROL_MAJOR			26 : 26
+#define	DE_CONTROL_MAJOR_X			0
+#define	DE_CONTROL_MAJOR_Y			1
+#define	DE_CONTROL_STEP_X			25 : 25
+#define	DE_CONTROL_STEP_X_POSITIVE		1
+#define	DE_CONTROL_STEP_X_NEGATIVE		0
+#define	DE_CONTROL_STEP_Y			24 : 24
+#define	DE_CONTROL_STEP_Y_POSITIVE		1
+#define	DE_CONTROL_STEP_Y_NEGATIVE		0
+#define	DE_CONTROL_STRETCH			23 : 23
+#define	DE_CONTROL_STRETCH_DISABLE		0
+#define	DE_CONTROL_STRETCH_ENABLE		1
+#define	DE_CONTROL_HOST				22 : 22
+#define	DE_CONTROL_HOST_COLOR			0
+#define	DE_CONTROL_HOST_MONO			1
+#define	DE_CONTROL_LAST_PIXEL			21 : 21
+#define	DE_CONTROL_LAST_PIXEL_OFF		0
+#define	DE_CONTROL_LAST_PIXEL_ON		1
+#define	DE_CONTROL_COMMAND			20 : 16
+#define	DE_CONTROL_COMMAND_BITBLT		0
+#define	DE_CONTROL_COMMAND_RECTANGLE_FILL	1
+#define	DE_CONTROL_COMMAND_DE_TILE		2
+#define	DE_CONTROL_COMMAND_TRAPEZOID_FILL	3
+#define	DE_CONTROL_COMMAND_ALPHA_BLEND		4
+#define	DE_CONTROL_COMMAND_RLE_STRIP		5
+#define	DE_CONTROL_COMMAND_SHORT_STROKE		6
+#define	DE_CONTROL_COMMAND_LINE_DRAW		7
+#define	DE_CONTROL_COMMAND_HOST_WRITE		8
+#define	DE_CONTROL_COMMAND_HOST_READ		9
+#define	DE_CONTROL_COMMAND_HOST_WRITE_BOTTOM_UP	10
+#define	DE_CONTROL_COMMAND_ROTATE		11
+#define	DE_CONTROL_COMMAND_FONT			12
+#define	DE_CONTROL_COMMAND_TEXTURE_LOAD		15
+#define	DE_CONTROL_ROP_SELECT			15 : 15
+#define	DE_CONTROL_ROP_SELECT_ROP3		0
+#define	DE_CONTROL_ROP_SELECT_ROP2		1
+#define	DE_CONTROL_ROP2_SOURCE			14 : 14
+#define	DE_CONTROL_ROP2_SOURCE_BITMAP		0
+#define	DE_CONTROL_ROP2_SOURCE_PATTERN		1
+#define	DE_CONTROL_MONO_DATA			13 : 12
+#define	DE_CONTROL_MONO_DATA_NOT_PACKED		0
+#define	DE_CONTROL_MONO_DATA_8_PACKED		1
+#define	DE_CONTROL_MONO_DATA_16_PACKED		2
+#define	DE_CONTROL_MONO_DATA_32_PACKED		3
+#define	DE_CONTROL_REPEAT_ROTATE		11 : 11
+#define	DE_CONTROL_REPEAT_ROTATE_DISABLE	0
+#define	DE_CONTROL_REPEAT_ROTATE_ENABLE		1
+#define	DE_CONTROL_TRANSPARENCY_MATCH		10 : 10
+#define	DE_CONTROL_TRANSPARENCY_MATCH_OPAQUE		0
+#define	DE_CONTROL_TRANSPARENCY_MATCH_TRANSPARENT	1
+#define	DE_CONTROL_TRANSPARENCY_SELECT			9 : 9
+#define	DE_CONTROL_TRANSPARENCY_SELECT_SOURCE		0
+#define	DE_CONTROL_TRANSPARENCY_SELECT_DESTINATION	1
+#define	DE_CONTROL_TRANSPARENCY				8 : 8
+#define	DE_CONTROL_TRANSPARENCY_DISABLE			0
+#define	DE_CONTROL_TRANSPARENCY_ENABLE			1
+#define	DE_CONTROL_ROP					7 : 0
+
+/* Pseudo fields. */
+
+#define	DE_CONTROL_SHORT_STROKE_DIR			27 : 24
+#define	DE_CONTROL_SHORT_STROKE_DIR_225			0
+#define	DE_CONTROL_SHORT_STROKE_DIR_135			1
+#define	DE_CONTROL_SHORT_STROKE_DIR_315			2
+#define	DE_CONTROL_SHORT_STROKE_DIR_45			3
+#define	DE_CONTROL_SHORT_STROKE_DIR_270			4
+#define	DE_CONTROL_SHORT_STROKE_DIR_90			5
+#define	DE_CONTROL_SHORT_STROKE_DIR_180			8
+#define	DE_CONTROL_SHORT_STROKE_DIR_0			10
+#define	DE_CONTROL_ROTATION				25 : 24
+#define	DE_CONTROL_ROTATION_0				0
+#define	DE_CONTROL_ROTATION_270				1
+#define	DE_CONTROL_ROTATION_90				2
+#define	DE_CONTROL_ROTATION_180				3
+
+#define	DE_PITCH					0x000010
+#define	DE_PITCH_DESTINATION				28 : 16
+#define	DE_PITCH_SOURCE					12 : 0
+
+#define	DE_FOREGROUND					0x000014
+#define	DE_FOREGROUND_COLOR				31 : 0
+
+#define	DE_BACKGROUND					0x000018
+#define	DE_BACKGROUND_COLOR				31 : 0
+
+#define	DE_STRETCH_FORMAT				0x00001C
+#define	DE_STRETCH_FORMAT_PATTERN_XY			30 : 30
+#define	DE_STRETCH_FORMAT_PATTERN_XY_NORMAL		0
+#define	DE_STRETCH_FORMAT_PATTERN_XY_OVERWRITE		1
+#define	DE_STRETCH_FORMAT_PATTERN_Y			29 : 27
+#define	DE_STRETCH_FORMAT_PATTERN_X			25 : 23
+#define	DE_STRETCH_FORMAT_PIXEL_FORMAT			21 : 20
+#define	DE_STRETCH_FORMAT_PIXEL_FORMAT_8		0
+#define	DE_STRETCH_FORMAT_PIXEL_FORMAT_16		1
+#define	DE_STRETCH_FORMAT_PIXEL_FORMAT_24		3
+#define	DE_STRETCH_FORMAT_PIXEL_FORMAT_32		2
+#define	DE_STRETCH_FORMAT_ADDRESSING			19 : 16
+#define	DE_STRETCH_FORMAT_ADDRESSING_XY			0
+#define	DE_STRETCH_FORMAT_ADDRESSING_LINEAR		15
+#define	DE_STRETCH_FORMAT_SOURCE_HEIGHT			11 : 0
+
+#define	DE_COLOR_COMPARE				0x000020
+#define	DE_COLOR_COMPARE_COLOR				23 : 0
+
+#define	DE_COLOR_COMPARE_MASK				0x000024
+#define	DE_COLOR_COMPARE_MASK_MASKS			23 : 0
+
+#define	DE_MASKS					0x000028
+#define	DE_MASKS_BYTE_MASK				31 : 16
+#define	DE_MASKS_BIT_MASK				15 : 0
+
+#define	DE_CLIP_TL					0x00002C
+#define	DE_CLIP_TL_TOP					31 : 16
+#define	DE_CLIP_TL_STATUS				13 : 13
+#define	DE_CLIP_TL_STATUS_DISABLE			0
+#define	DE_CLIP_TL_STATUS_ENABLE			1
+#define	DE_CLIP_TL_INHIBIT				12 : 12
+#define	DE_CLIP_TL_INHIBIT_OUTSIDE			0
+#define	DE_CLIP_TL_INHIBIT_INSIDE			1
+#define	DE_CLIP_TL_LEFT					11 : 0
+
+#define	DE_CLIP_BR					0x000030
+#define	DE_CLIP_BR_BOTTOM				31 : 16
+#define	DE_CLIP_BR_RIGHT				12 : 0
+
+#define	DE_MONO_PATTERN_LOW				0x000034
+#define	DE_MONO_PATTERN_LOW_PATTERN			31 : 0
+
+#define	DE_MONO_PATTERN_HIGH				0x000038
+#define	DE_MONO_PATTERN_HIGH_PATTERN			31 : 0
+
+#define	DE_WINDOW_WIDTH					0x00003C
+#define	DE_WINDOW_WIDTH_DESTINATION			28 : 16
+#define	DE_WINDOW_WIDTH_SOURCE				12 : 0
+
+#define	DE_WINDOW_SOURCE_BASE				0x000040
+#define	DE_WINDOW_SOURCE_BASE_EXT			27 : 27
+#define	DE_WINDOW_SOURCE_BASE_EXT_LOCAL			0
+#define	DE_WINDOW_SOURCE_BASE_EXT_EXTERNAL		1
+#define	DE_WINDOW_SOURCE_BASE_CS			26 : 26
+#define	DE_WINDOW_SOURCE_BASE_CS_0			0
+#define	DE_WINDOW_SOURCE_BASE_CS_1			1
+#define	DE_WINDOW_SOURCE_BASE_ADDRESS			25 : 0
+
+#define	DE_WINDOW_DESTINATION_BASE			0x000044
+#define	DE_WINDOW_DESTINATION_BASE_EXT			27 : 27
+#define	DE_WINDOW_DESTINATION_BASE_EXT_LOCAL		0
+#define	DE_WINDOW_DESTINATION_BASE_EXT_EXTERNAL		1
+#define	DE_WINDOW_DESTINATION_BASE_CS			26 : 26
+#define	DE_WINDOW_DESTINATION_BASE_CS_0			0
+#define	DE_WINDOW_DESTINATION_BASE_CS_1			1
+#define	DE_WINDOW_DESTINATION_BASE_ADDRESS		25 : 0
+
+#define	DE_ALPHA					0x000048
+#define	DE_ALPHA_VALUE					7 : 0
+
+#define	DE_WRAP						0x00004C
+#define	DE_WRAP_X					31 : 16
+#define	DE_WRAP_Y					15 : 0
+
+#define	DE_STATUS					0x000050
+#define	DE_STATUS_CSC					1 : 1
+#define	DE_STATUS_CSC_CLEAR				0
+#define	DE_STATUS_CSC_NOT_ACTIVE			0
+#define	DE_STATUS_CSC_ACTIVE				1
+#define	DE_STATUS_2D					0 : 0
+#define	DE_STATUS_2D_CLEAR				0
+#define	DE_STATUS_2D_NOT_ACTIVE				0
+#define	DE_STATUS_2D_ACTIVE				1
+
+/* Color Space Conversion registers. */
+
+#define	CSC_Y_SOURCE_BASE				0x0000C8
+#define	CSC_Y_SOURCE_BASE_EXT				27 : 27
+#define	CSC_Y_SOURCE_BASE_EXT_LOCAL			0
+#define	CSC_Y_SOURCE_BASE_EXT_EXTERNAL			1
+#define	CSC_Y_SOURCE_BASE_CS				26 : 26
+#define	CSC_Y_SOURCE_BASE_CS_0				0
+#define	CSC_Y_SOURCE_BASE_CS_1				1
+#define	CSC_Y_SOURCE_BASE_ADDRESS			25 : 0
+
+#define	CSC_CONSTANTS					0x0000CC
+#define	CSC_CONSTANTS_Y					31 : 24
+#define	CSC_CONSTANTS_R					23 : 16
+#define	CSC_CONSTANTS_G					15 : 8
+#define	CSC_CONSTANTS_B					7 : 0
+
+#define	CSC_Y_SOURCE_X					0x0000D0
+#define	CSC_Y_SOURCE_X_INTEGER				26 : 16
+#define	CSC_Y_SOURCE_X_FRACTION				15 : 3
+
+#define	CSC_Y_SOURCE_Y					0x0000D4
+#define	CSC_Y_SOURCE_Y_INTEGER				27 : 16
+#define	CSC_Y_SOURCE_Y_FRACTION				15 : 3
+
+#define	CSC_U_SOURCE_BASE				0x0000D8
+#define	CSC_U_SOURCE_BASE_EXT				27 : 27
+#define	CSC_U_SOURCE_BASE_EXT_LOCAL			0
+#define	CSC_U_SOURCE_BASE_EXT_EXTERNAL			1
+#define	CSC_U_SOURCE_BASE_CS				26 : 26
+#define	CSC_U_SOURCE_BASE_CS_0				0
+#define	CSC_U_SOURCE_BASE_CS_1				1
+#define	CSC_U_SOURCE_BASE_ADDRESS			25 : 0
+
+#define	CSC_V_SOURCE_BASE				0x0000DC
+#define	CSC_V_SOURCE_BASE_EXT				27 : 27
+#define	CSC_V_SOURCE_BASE_EXT_LOCAL			0
+#define	CSC_V_SOURCE_BASE_EXT_EXTERNAL			1
+#define	CSC_V_SOURCE_BASE_CS				26 : 26
+#define	CSC_V_SOURCE_BASE_CS_0				0
+#define	CSC_V_SOURCE_BASE_CS_1				1
+#define	CSC_V_SOURCE_BASE_ADDRESS			25 : 0
+
+#define	CSC_SOURCE_DIMENSION				0x0000E0
+#define	CSC_SOURCE_DIMENSION_X				31 : 16
+#define	CSC_SOURCE_DIMENSION_Y				15 : 0
+
+#define	CSC_SOURCE_PITCH				0x0000E4
+#define	CSC_SOURCE_PITCH_Y				31 : 16
+#define	CSC_SOURCE_PITCH_UV				15 : 0
+
+#define	CSC_DESTINATION					0x0000E8
+#define	CSC_DESTINATION_WRAP				31 : 31
+#define	CSC_DESTINATION_WRAP_DISABLE			0
+#define	CSC_DESTINATION_WRAP_ENABLE			1
+#define	CSC_DESTINATION_X				27 : 16
+#define	CSC_DESTINATION_Y				11 : 0
+
+#define	CSC_DESTINATION_DIMENSION			0x0000EC
+#define	CSC_DESTINATION_DIMENSION_X			31 : 16
+#define	CSC_DESTINATION_DIMENSION_Y			15 : 0
+
+#define	CSC_DESTINATION_PITCH				0x0000F0
+#define	CSC_DESTINATION_PITCH_X				31 : 16
+#define	CSC_DESTINATION_PITCH_Y				15 : 0
+
+#define	CSC_SCALE_FACTOR				0x0000F4
+#define	CSC_SCALE_FACTOR_HORIZONTAL			31 : 16
+#define	CSC_SCALE_FACTOR_VERTICAL			15 : 0
+
+#define	CSC_DESTINATION_BASE				0x0000F8
+#define	CSC_DESTINATION_BASE_EXT			27 : 27
+#define	CSC_DESTINATION_BASE_EXT_LOCAL			0
+#define	CSC_DESTINATION_BASE_EXT_EXTERNAL		1
+#define	CSC_DESTINATION_BASE_CS				26 : 26
+#define	CSC_DESTINATION_BASE_CS_0			0
+#define	CSC_DESTINATION_BASE_CS_1			1
+#define	CSC_DESTINATION_BASE_ADDRESS			25 : 0
+
+#define	CSC_CONTROL					0x0000FC
+#define	CSC_CONTROL_STATUS				31 : 31
+#define	CSC_CONTROL_STATUS_STOP				0
+#define	CSC_CONTROL_STATUS_START			1
+#define	CSC_CONTROL_SOURCE_FORMAT			30 : 28
+#define	CSC_CONTROL_SOURCE_FORMAT_YUV422		0
+#define	CSC_CONTROL_SOURCE_FORMAT_YUV420I		1
+#define	CSC_CONTROL_SOURCE_FORMAT_YUV420		2
+#define	CSC_CONTROL_SOURCE_FORMAT_YVU9			3
+#define	CSC_CONTROL_SOURCE_FORMAT_IYU1			4
+#define	CSC_CONTROL_SOURCE_FORMAT_IYU2			5
+#define	CSC_CONTROL_SOURCE_FORMAT_RGB565		6
+#define	CSC_CONTROL_SOURCE_FORMAT_RGB8888		7
+#define	CSC_CONTROL_DESTINATION_FORMAT			27 : 26
+#define	CSC_CONTROL_DESTINATION_FORMAT_RGB565		0
+#define	CSC_CONTROL_DESTINATION_FORMAT_RGB8888		1
+#define	CSC_CONTROL_HORIZONTAL_FILTER			25 : 25
+#define	CSC_CONTROL_HORIZONTAL_FILTER_DISABLE		0
+#define	CSC_CONTROL_HORIZONTAL_FILTER_ENABLE		1
+#define	CSC_CONTROL_VERTICAL_FILTER			24 : 24
+#define	CSC_CONTROL_VERTICAL_FILTER_DISABLE		0
+#define	CSC_CONTROL_VERTICAL_FILTER_ENABLE		1
+#define	CSC_CONTROL_BYTE_ORDER				23 : 23
+#define	CSC_CONTROL_BYTE_ORDER_YUYV			0
+#define	CSC_CONTROL_BYTE_ORDER_UYVY			1
+
+#define	DE_DATA_PORT_501				0x110000
+#define	DE_DATA_PORT_712				0x400000
+#define	DE_DATA_PORT_722				0x6000
+
+/* point to virtual Memory Map IO starting address */
+extern char *smtc_RegBaseAddress;
+/* point to virtual video memory starting address */
+extern char *smtc_VRAMBaseAddress;
+extern unsigned char smtc_de_busy;
+
+extern unsigned long memRead32(unsigned long nOffset);
+extern void memWrite32(unsigned long nOffset, unsigned long nData);
+extern unsigned long SMTC_read2Dreg(unsigned long nOffset);
+
+/* 2D functions */
+extern void deInit(unsigned int nModeWidth, unsigned int nModeHeight,
+		   unsigned int bpp);
+
+extern void deWaitForNotBusy(void);
+
+extern void deVerticalLine(unsigned long dst_base,
+	unsigned long dst_pitch,
+	unsigned long nX,
+	unsigned long nY,
+	unsigned long dst_height,
+	unsigned long nColor);
+
+extern void deHorizontalLine(unsigned long dst_base,
+	unsigned long dst_pitch,
+	unsigned long nX,
+	unsigned long nY,
+	unsigned long dst_width,
+	unsigned long nColor);
+
+extern void deLine(unsigned long dst_base,
+	unsigned long dst_pitch,
+	unsigned long nX1,
+	unsigned long nY1,
+	unsigned long nX2,
+	unsigned long nY2,
+	unsigned long nColor);
+
+extern void deFillRect(unsigned long dst_base,
+	unsigned long dst_pitch,
+	unsigned long dst_X,
+	unsigned long dst_Y,
+	unsigned long dst_width,
+	unsigned long dst_height,
+	unsigned long nColor);
+
+extern void deRotatePattern(unsigned char *pattern_dstaddr,
+	unsigned long pattern_src_addr,
+	unsigned long pattern_BPP,
+	unsigned long pattern_stride,
+	int	patternX,
+	int	patternY);
+
+extern void deCopy(unsigned long dst_base,
+	unsigned long dst_pitch,
+	unsigned long dst_BPP,
+	unsigned long dst_X,
+	unsigned long dst_Y,
+	unsigned long dst_width,
+	unsigned long dst_height,
+	unsigned long src_base,
+	unsigned long src_pitch,
+	unsigned long src_X,
+	unsigned long src_Y,
+	pTransparent	pTransp,
+	unsigned char nROP2);
+
+/*
+ * System memory to Video memory monochrome expansion.
+ *
+ * Source is monochrome image in system memory.  This function expands the
+ * monochrome data to color image in video memory.
+ *
+ * @pSrcbuf: pointer to start of source buffer in system memory
+ * @srcDelta: Pitch value (in bytes) of the source buffer, +ive means top
+ * 		down and -ive mean button up
+ * @startBit: Mono data can start at any bit in a byte, this value should
+ * 		be 0 to 7
+ * @dBase: Address of destination :  offset in frame buffer
+ * @dPitch: Pitch value of destination surface in BYTE
+ * @bpp: Color depth of destination surface
+ * @dx, dy: Starting coordinate of destination surface
+ * @width, height: width and height of rectange in pixel value
+ * @fColor,bColor: Foreground, Background color (corresponding to a 1, 0 in
+ * 	the monochrome data)
+ * @rop2: ROP value
+ */
+
+extern long deSystemMem2VideoMemMonoBlt(
+	const char *pSrcbuf,
+	long srcDelta,
+	unsigned long startBit,
+	unsigned long dBase,
+	unsigned long dPitch,
+	unsigned long bpp,
+	unsigned long dx, unsigned long dy,
+	unsigned long width, unsigned long height,
+	unsigned long fColor,
+	unsigned long bColor,
+	unsigned long rop2);
+
+extern unsigned long deGetTransparency(void);
+extern void deSetPixelFormat(unsigned long bpp);
diff --git a/drivers/video/smi/smtcfb.c b/drivers/video/smi/smtcfb.c
new file mode 100644
index 0000000..cfc44bb
--- /dev/null
+++ b/drivers/video/smi/smtcfb.c
@@ -0,0 +1,1138 @@
+/*
+ * smtcfb.c -- Silicon Motion SM501 and SM7xx frame buffer device
+ *
+ * Copyright (C) 2006 Silicon Motion Technology Corp.
+ * Authors: Ge Wang, gewang@siliconmotion.com
+ * 	    Boyod boyod.yang@siliconmotion.com.cn
+ *
+ * Copyright (C) 2009 Lemote, Inc. & Institute of Computing Technology
+ * Author: Wu Zhangjin, wuzj@lemote.com
+ *
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License. See the file COPYING in the main directory of this archive for
+ *  more details.
+ *
+ * Version 0.10.26192.21.01
+ * 	- Add PowerPC/Big endian support
+ * 	- Add 2D support for Lynx
+ * 	- Verified on2.6.19.2  Boyod.yang <boyod.yang@siliconmotion.com.cn>
+ *
+ * Version 0.09.2621.00.01
+ * 	- Only support Linux Kernel's version 2.6.21.
+ *	Boyod.yang  <boyod.yang@siliconmotion.com.cn>
+ *
+ * Version 0.09
+ * 	- Only support Linux Kernel's version 2.6.12.
+ * 	Boyod.yang <boyod.yang@siliconmotion.com.cn>
+ */
+
+#ifndef __KERNEL__
+#define __KERNEL__
+#endif
+
+#include <linux/io.h>
+#include <linux/fb.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/uaccess.h>
+#include <linux/screen_info.h>
+
+#ifdef CONFIG_PM
+#include <linux/pm.h>
+#endif
+
+#include "smtcfb.h"
+#include "smtc2d.h"
+
+#ifdef DEBUG
+#define smdbg(format, arg...)	printk(KERN_DEBUG format , ## arg)
+#else
+#define smdbg(format, arg...)
+#endif
+
+/*
+* Private structure
+*/
+struct smtcfb_info {
+	/*
+	 * The following is a pointer to be passed into the
+	 * functions below.  The modules outside the main
+	 * voyager.c driver have no knowledge as to what
+	 * is within this structure.
+	 */
+	struct fb_info fb;
+	struct display_switch *dispsw;
+	struct pci_dev *dev;
+	signed int currcon;
+
+	struct {
+		u8 red, green, blue;
+	} palette[NR_RGB];
+
+	u_int palette_size;
+};
+
+struct par_info {
+	/*
+	 * Hardware
+	 */
+	u16 chipID;
+	unsigned char __iomem *m_pMMIO;
+	char __iomem *m_pLFB;
+	char *m_pDPR;
+	char *m_pVPR;
+	char *m_pCPR;
+
+	u_int width;
+	u_int height;
+	u_int hz;
+	u_long BaseAddressInVRAM;
+	u8 chipRevID;
+};
+
+struct vesa_mode_table {
+	char mode_index[15];
+	u16 lfb_width;
+	u16 lfb_height;
+	u16 lfb_depth;
+};
+
+static struct vesa_mode_table vesa_mode[] = {
+	{"640x480x8", 640, 480, 8},
+	{"800x480x8", 800, 480, 8},
+	{"800x600x8", 800, 600, 8},
+	{"1024x768x8", 1024, 768, 8},
+	{"1280x1024x8", 1280, 1024, 8},
+
+	{"640x480x16", 640, 480, 16},
+	{"800x480x16", 800, 480, 16},
+	{"800x600x16", 800, 600, 16},
+	{"1024x768x16", 1024, 768, 16},
+	{"1280x1024x16", 1280, 1024, 16},
+
+	{"640x480x24", 640, 480, 24},
+	{"800x480x24", 800, 480, 24},
+	{"800x600x24", 800, 600, 24},
+	{"1024x768x24", 1024, 768, 24},
+	{"1280x1024x24", 1280, 1024, 24},
+};
+
+char __iomem *smtc_RegBaseAddress;	/* Memory Map IO starting address */
+char __iomem *smtc_VRAMBaseAddress;	/* video memory starting address */
+
+char *smtc_2DBaseAddress;	/* 2D engine starting address */
+char *smtc_2Ddataport;		/* 2D data port offset */
+short smtc_2Dacceleration;
+
+static u32 colreg[17];
+static struct par_info hw;	/* hardware information */
+
+#if defined(CONFIG_FB_SM7XX_DUALHEAD)
+
+static u32 colreg2[17];
+/* hardware information for second display (CRT) */
+static struct par_info hw2;
+/* fb_info for second display (CRT) */
+struct smtcfb_info smtcfb_info2;
+
+#endif	/* CONFIG_FB_SM501_DUALHEAD */
+
+u16 smtc_ChipIDs[] = {
+	0x710,
+	0x712,
+	0x720
+};
+
+int sm712be_flag;
+
+#define numSMTCchipIDs (sizeof(smtc_ChipIDs) / sizeof(u16))
+
+void deWaitForNotBusy(void)
+{
+	unsigned long i = 0x1000000;
+	while (i--) {
+		if ((smtc_seqr(0x16) & 0x18) == 0x10)
+			break;
+	}
+	smtc_de_busy = 0;
+}
+
+static void sm712_set_timing(struct smtcfb_info *sfb,
+			     struct par_info *ppar_info)
+{
+	int i = 0, j = 0;
+	u32 m_nScreenStride;
+
+	smdbg("\nppar_info->width = %d ppar_info->height = %d"
+			"sfb->fb.var.bits_per_pixel = %d ppar_info->hz = %d\n",
+			ppar_info->width, ppar_info->height,
+			sfb->fb.var.bits_per_pixel, ppar_info->hz);
+
+	for (j = 0; j < numVGAModes; j++) {
+		if (VGAMode[j].mmSizeX == ppar_info->width &&
+		    VGAMode[j].mmSizeY == ppar_info->height &&
+		    VGAMode[j].bpp == sfb->fb.var.bits_per_pixel &&
+		    VGAMode[j].hz == ppar_info->hz) {
+
+			smdbg("\nVGAMode[j].mmSizeX  = %d VGAMode[j].mmSizeY ="
+					"%d VGAMode[j].bpp = %d"
+					"VGAMode[j].hz=%d\n",
+					VGAMode[j].mmSizeX, VGAMode[j].mmSizeY,
+					VGAMode[j].bpp, VGAMode[j].hz);
+
+			smdbg("VGAMode index=%d\n", j);
+
+			smtc_mmiowb(0x0, 0x3c6);
+
+			smtc_seqw(0, 0x1);
+
+			smtc_mmiowb(VGAMode[j].Init_MISC, 0x3c2);
+
+			/* init SEQ register SR00 - SR04 */
+			for (i = 0; i < SIZE_SR00_SR04; i++)
+				smtc_seqw(i, VGAMode[j].Init_SR00_SR04[i]);
+
+			/* init SEQ register SR10 - SR24 */
+			for (i = 0; i < SIZE_SR10_SR24; i++)
+				smtc_seqw(i + 0x10,
+					  VGAMode[j].Init_SR10_SR24[i]);
+
+			/* init SEQ register SR30 - SR75 */
+			for (i = 0; i < SIZE_SR30_SR75; i++)
+				if (((i + 0x30) != 0x62) \
+					&& ((i + 0x30) != 0x6a) \
+					&& ((i + 0x30) != 0x6b))
+					smtc_seqw(i + 0x30,
+						VGAMode[j].Init_SR30_SR75[i]);
+
+			/* init SEQ register SR80 - SR93 */
+			for (i = 0; i < SIZE_SR80_SR93; i++)
+				smtc_seqw(i + 0x80,
+					  VGAMode[j].Init_SR80_SR93[i]);
+
+			/* init SEQ register SRA0 - SRAF */
+			for (i = 0; i < SIZE_SRA0_SRAF; i++)
+				smtc_seqw(i + 0xa0,
+					  VGAMode[j].Init_SRA0_SRAF[i]);
+
+			/* init Graphic register GR00 - GR08 */
+			for (i = 0; i < SIZE_GR00_GR08; i++)
+				smtc_grphw(i, VGAMode[j].Init_GR00_GR08[i]);
+
+			/* init Attribute register AR00 - AR14 */
+			for (i = 0; i < SIZE_AR00_AR14; i++)
+				smtc_attrw(i, VGAMode[j].Init_AR00_AR14[i]);
+
+			/* init CRTC register CR00 - CR18 */
+			for (i = 0; i < SIZE_CR00_CR18; i++)
+				smtc_crtcw(i, VGAMode[j].Init_CR00_CR18[i]);
+
+			/* init CRTC register CR30 - CR4D */
+			for (i = 0; i < SIZE_CR30_CR4D; i++)
+				smtc_crtcw(i + 0x30,
+					   VGAMode[j].Init_CR30_CR4D[i]);
+
+			/* init CRTC register CR90 - CRA7 */
+			for (i = 0; i < SIZE_CR90_CRA7; i++)
+				smtc_crtcw(i + 0x90,
+					   VGAMode[j].Init_CR90_CRA7[i]);
+		}
+	}
+	smtc_mmiowb(0x67, 0x3c2);
+
+	/* set VPR registers */
+	writel(0x0, ppar_info->m_pVPR + 0x0C);
+	writel(0x0, ppar_info->m_pVPR + 0x40);
+
+	/* set data width */
+	m_nScreenStride =
+		(ppar_info->width * sfb->fb.var.bits_per_pixel) / 64;
+	switch (sfb->fb.var.bits_per_pixel) {
+	case 8:
+		writel(0x0, ppar_info->m_pVPR + 0x0);
+		break;
+	case 16:
+		writel(0x00020000, ppar_info->m_pVPR + 0x0);
+		break;
+	case 24:
+		writel(0x00040000, ppar_info->m_pVPR + 0x0);
+		break;
+	case 32:
+		writel(0x00030000, ppar_info->m_pVPR + 0x0);
+		break;
+	}
+	writel((u32) (((m_nScreenStride + 2) << 16) | m_nScreenStride),
+	       ppar_info->m_pVPR + 0x10);
+
+}
+
+static void sm712_setpalette(int regno, unsigned red, unsigned green,
+			     unsigned blue, struct fb_info *info)
+{
+	struct par_info *cur_par = (struct par_info *)info->par;
+
+	if (cur_par->BaseAddressInVRAM)
+		/*
+		 * second display palette for dual head. Enable CRT RAM, 6-bit
+		 * RAM
+		 */
+		smtc_seqw(0x66, (smtc_seqr(0x66) & 0xC3) | 0x20);
+	else
+		/* primary display palette. Enable LCD RAM only, 6-bit RAM */
+		smtc_seqw(0x66, (smtc_seqr(0x66) & 0xC3) | 0x10);
+	smtc_mmiowb(regno, dac_reg);
+	smtc_mmiowb(red >> 10, dac_val);
+	smtc_mmiowb(green >> 10, dac_val);
+	smtc_mmiowb(blue >> 10, dac_val);
+}
+
+static void smtc_set_timing(struct smtcfb_info *sfb, struct par_info
+		*ppar_info)
+{
+	switch (ppar_info->chipID) {
+	case 0x710:
+	case 0x712:
+	case 0x720:
+		sm712_set_timing(sfb, ppar_info);
+		break;
+	}
+}
+
+static struct fb_var_screeninfo smtcfb_var = {
+	.xres = 1024,
+	.yres = 600,
+	.xres_virtual = 1024,
+	.yres_virtual = 600,
+	.bits_per_pixel = 16,
+	.red = {16, 8, 0},
+	.green = {8, 8, 0},
+	.blue = {0, 8, 0},
+	.activate = FB_ACTIVATE_NOW,
+	.height = -1,
+	.width = -1,
+	.vmode = FB_VMODE_NONINTERLACED,
+};
+
+static struct fb_fix_screeninfo smtcfb_fix = {
+	.id = "sm712fb",
+	.type = FB_TYPE_PACKED_PIXELS,
+	.visual = FB_VISUAL_TRUECOLOR,
+	.line_length = 800 * 3,
+	.accel = FB_ACCEL_SMI_LYNX,
+};
+
+/* chan_to_field
+ *
+ * convert a colour value into a field position
+ *
+ * from pxafb.c
+ */
+
+static inline unsigned int chan_to_field(unsigned int chan,
+					 struct fb_bitfield *bf)
+{
+	chan &= 0xffff;
+	chan >>= 16 - bf->length;
+	return chan << bf->offset;
+}
+
+static int smtc_setcolreg(unsigned regno, unsigned red, unsigned green,
+			  unsigned blue, unsigned trans, struct fb_info *info)
+{
+	struct smtcfb_info *sfb = (struct smtcfb_info *)info;
+	u32 val;
+
+	if (regno > 255)
+		return 1;
+
+	switch (sfb->fb.fix.visual) {
+	case FB_VISUAL_DIRECTCOLOR:
+	case FB_VISUAL_TRUECOLOR:
+		/*
+		 * 16/32 bit true-colour, use pseuo-palette for 16 base color
+		 */
+		if (regno < 16) {
+			if (sfb->fb.var.bits_per_pixel == 16) {
+				u32 *pal = sfb->fb.pseudo_palette;
+				val = chan_to_field(red, &sfb->fb.var.red);
+				val |= chan_to_field(green, \
+						&sfb->fb.var.green);
+				val |= chan_to_field(blue, &sfb->fb.var.blue);
+#ifdef __BIG_ENDIAN
+				pal[regno] =
+				    ((red & 0xf800) >> 8) |
+				    ((green & 0xe000) >> 13) |
+				    ((green & 0x1c00) << 3) |
+				    ((blue & 0xf800) >> 3);
+#else
+				pal[regno] = val;
+#endif
+			} else {
+				u32 *pal = sfb->fb.pseudo_palette;
+				val = chan_to_field(red, &sfb->fb.var.red);
+				val |= chan_to_field(green, \
+						&sfb->fb.var.green);
+				val |= chan_to_field(blue, &sfb->fb.var.blue);
+#ifdef __BIG_ENDIAN
+				val =
+				    (val & 0xff00ff00 >> 8) |
+				    (val & 0x00ff00ff << 8);
+#endif
+				pal[regno] = val;
+			}
+		}
+		break;
+
+	case FB_VISUAL_PSEUDOCOLOR:
+		/* color depth 8 bit */
+		sm712_setpalette(regno, red, green, blue, info);
+		break;
+
+	default:
+		return 1;	/* unknown type */
+	}
+
+	return 0;
+
+}
+
+#ifdef __BIG_ENDIAN
+static ssize_t
+smtcfb_read(struct file *file, char __user * buf, size_t count, loff_t * ppos)
+{
+	unsigned long p = *ppos;
+
+	struct inode *inode = file->f_dentry->d_inode;
+	int fbidx = iminor(inode);
+	struct fb_info *info = registered_fb[fbidx];
+
+	u32 *buffer, *dst;
+	u32 __iomem *src;
+	int c, i, cnt = 0, err = 0;
+	unsigned long total_size;
+
+	if (!info || !info->screen_base)
+		return -ENODEV;
+
+	if (info->state != FBINFO_STATE_RUNNING)
+		return -EPERM;
+
+	total_size = info->screen_size;
+
+	if (total_size == 0)
+		total_size = info->fix.smem_len;
+
+	if (p >= total_size)
+		return 0;
+
+	if (count >= total_size)
+		count = total_size;
+
+	if (count + p > total_size)
+		count = total_size - p;
+
+	buffer = kmalloc((count > PAGE_SIZE) ? PAGE_SIZE : count, GFP_KERNEL);
+	if (!buffer)
+		return -ENOMEM;
+
+	src = (u32 __iomem *) (info->screen_base + p);
+
+	if (info->fbops->fb_sync)
+		info->fbops->fb_sync(info);
+
+	while (count) {
+		c = (count > PAGE_SIZE) ? PAGE_SIZE : count;
+		dst = buffer;
+		for (i = c >> 2; i--;) {
+			*dst = fb_readl(src++);
+			*dst =
+			    (*dst & 0xff00ff00 >> 8) |
+			    (*dst & 0x00ff00ff << 8);
+			dst++;
+		}
+		if (c & 3) {
+			u8 *dst8 = (u8 *) dst;
+			u8 __iomem *src8 = (u8 __iomem *) src;
+
+			for (i = c & 3; i--;) {
+				if (i & 1) {
+					*dst8++ = fb_readb(++src8);
+				} else {
+					*dst8++ = fb_readb(--src8);
+					src8 += 2;
+				}
+			}
+			src = (u32 __iomem *) src8;
+		}
+
+		if (copy_to_user(buf, buffer, c)) {
+			err = -EFAULT;
+			break;
+		}
+		*ppos += c;
+		buf += c;
+		cnt += c;
+		count -= c;
+	}
+
+	kfree(buffer);
+
+	return (err) ? err : cnt;
+}
+
+static ssize_t
+smtcfb_write(struct file *file, const char __user *buf, size_t count,
+	     loff_t *ppos)
+{
+	unsigned long p = *ppos;
+	struct inode *inode = file->f_dentry->d_inode;
+	int fbidx = iminor(inode);
+	struct fb_info *info = registered_fb[fbidx];
+	u32 *buffer, *src;
+	u32 __iomem *dst;
+	int c, i, cnt = 0, err = 0;
+	unsigned long total_size;
+
+	if (!info || !info->screen_base)
+		return -ENODEV;
+
+	if (info->state != FBINFO_STATE_RUNNING)
+		return -EPERM;
+
+	total_size = info->screen_size;
+
+	if (total_size == 0)
+		total_size = info->fix.smem_len;
+
+	if (p > total_size)
+		return -EFBIG;
+
+	if (count > total_size) {
+		err = -EFBIG;
+		count = total_size;
+	}
+
+	if (count + p > total_size) {
+		if (!err)
+			err = -ENOSPC;
+
+		count = total_size - p;
+	}
+
+	buffer = kmalloc((count > PAGE_SIZE) ? PAGE_SIZE : count, GFP_KERNEL);
+	if (!buffer)
+		return -ENOMEM;
+
+	dst = (u32 __iomem *) (info->screen_base + p);
+
+	if (info->fbops->fb_sync)
+		info->fbops->fb_sync(info);
+
+	while (count) {
+		c = (count > PAGE_SIZE) ? PAGE_SIZE : count;
+		src = buffer;
+
+		if (copy_from_user(src, buf, c)) {
+			err = -EFAULT;
+			break;
+		}
+
+		for (i = c >> 2; i--;) {
+			fb_writel((*src & 0xff00ff00 >> 8) |
+				  (*src & 0x00ff00ff << 8), dst++);
+			src++;
+		}
+		if (c & 3) {
+			u8 *src8 = (u8 *) src;
+			u8 __iomem *dst8 = (u8 __iomem *) dst;
+
+			for (i = c & 3; i--;) {
+				if (i & 1) {
+					fb_writeb(*src8++, ++dst8);
+				} else {
+					fb_writeb(*src8++, --dst8);
+					dst8 += 2;
+				}
+			}
+			dst = (u32 __iomem *) dst8;
+		}
+
+		*ppos += c;
+		buf += c;
+		cnt += c;
+		count -= c;
+	}
+
+	kfree(buffer);
+
+	return (cnt) ? cnt : err;
+}
+#endif	/* ! __BIG_ENDIAN */
+
+#include "smtc2d.c"
+
+void smtcfb_copyarea(struct fb_info *info, const struct fb_copyarea *area)
+{
+	struct par_info *p = (struct par_info *)info->par;
+
+	if (smtc_2Dacceleration) {
+		if (!area->width || !area->height)
+			return;
+
+		deCopy(p->BaseAddressInVRAM, 0, info->var.bits_per_pixel,
+		       area->dx, area->dy, area->width, area->height,
+		       p->BaseAddressInVRAM, 0, area->sx, area->sy, 0, 0xC);
+
+	} else
+		cfb_copyarea(info, area);
+}
+
+void smtcfb_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
+{
+	struct par_info *p = (struct par_info *)info->par;
+
+	if (smtc_2Dacceleration) {
+		if (!rect->width || !rect->height)
+			return;
+		if (info->var.bits_per_pixel >= 24)
+			deFillRect(p->BaseAddressInVRAM, 0, rect->dx * 3,
+				   rect->dy * 3, rect->width * 3, rect->height,
+				   rect->color);
+		else
+			deFillRect(p->BaseAddressInVRAM, 0, rect->dx, rect->dy,
+				   rect->width, rect->height, rect->color);
+	} else
+		cfb_fillrect(info, rect);
+}
+
+void smtcfb_imageblit(struct fb_info *info, const struct fb_image *image)
+{
+	struct par_info *p = (struct par_info *)info->par;
+	u32 bg_col = 0, fg_col = 0;
+
+	if ((smtc_2Dacceleration) && (image->depth == 1)) {
+		if (smtc_de_busy)
+			deWaitForNotBusy();
+
+		switch (info->var.bits_per_pixel) {
+		case 8:
+			bg_col = image->bg_color;
+			fg_col = image->fg_color;
+			break;
+		case 16:
+			bg_col =
+			    ((u32 *) (info->pseudo_palette))[image->bg_color];
+			fg_col =
+			    ((u32 *) (info->pseudo_palette))[image->fg_color];
+			break;
+		case 32:
+			bg_col =
+			    ((u32 *) (info->pseudo_palette))[image->bg_color];
+			fg_col =
+			    ((u32 *) (info->pseudo_palette))[image->fg_color];
+			break;
+		}
+
+		deSystemMem2VideoMemMonoBlt(
+			image->data,
+			image->width / 8,
+			0,
+			p->BaseAddressInVRAM,
+			0,
+			0,
+			image->dx, image->dy,
+			image->width, image->height,
+			fg_col, bg_col,
+			0x0C);
+
+	} else
+		cfb_imageblit(info, image);
+}
+
+static struct fb_ops smtcfb_ops = {
+	.owner = THIS_MODULE,
+	.fb_setcolreg = smtc_setcolreg,
+	.fb_fillrect = smtcfb_fillrect,
+	.fb_imageblit = smtcfb_imageblit,
+	.fb_copyarea = smtcfb_copyarea,
+#ifdef __BIG_ENDIAN
+	.fb_read = smtcfb_read,
+	.fb_write = smtcfb_write,
+#endif
+
+};
+
+void smtcfb_setmode(struct smtcfb_info *sfb)
+{
+	switch (sfb->fb.var.bits_per_pixel) {
+	case 32:
+		sfb->fb.fix.visual = FB_VISUAL_TRUECOLOR;
+		sfb->fb.fix.line_length = sfb->fb.var.xres * 4;
+		sfb->fb.var.red.length = 8;
+		sfb->fb.var.green.length = 8;
+		sfb->fb.var.blue.length = 8;
+		sfb->fb.var.red.offset = 16;
+		sfb->fb.var.green.offset = 8;
+		sfb->fb.var.blue.offset = 0;
+
+		break;
+	case 8:
+		sfb->fb.fix.visual = FB_VISUAL_PSEUDOCOLOR;
+		sfb->fb.fix.line_length = sfb->fb.var.xres;
+		sfb->fb.var.red.offset = 5;
+		sfb->fb.var.red.length = 3;
+		sfb->fb.var.green.offset = 2;
+		sfb->fb.var.green.length = 3;
+		sfb->fb.var.blue.offset = 0;
+		sfb->fb.var.blue.length = 2;
+		break;
+	case 24:
+		sfb->fb.fix.visual = FB_VISUAL_TRUECOLOR;
+		sfb->fb.fix.line_length = sfb->fb.var.xres * 3;
+		sfb->fb.var.red.length = 8;
+		sfb->fb.var.green.length = 8;
+		sfb->fb.var.blue.length = 8;
+
+		sfb->fb.var.red.offset = 16;
+		sfb->fb.var.green.offset = 8;
+		sfb->fb.var.blue.offset = 0;
+
+		break;
+	case 16:
+	default:
+		sfb->fb.fix.visual = FB_VISUAL_TRUECOLOR;
+		sfb->fb.fix.line_length = sfb->fb.var.xres * 2;
+
+		sfb->fb.var.red.length = 5;
+		sfb->fb.var.green.length = 6;
+		sfb->fb.var.blue.length = 5;
+
+		sfb->fb.var.red.offset = 11;
+		sfb->fb.var.green.offset = 5;
+		sfb->fb.var.blue.offset = 0;
+
+		break;
+	}
+
+	hw.width = sfb->fb.var.xres;
+	hw.height = sfb->fb.var.yres;
+	hw.hz = 60;
+	smtc_set_timing(sfb, &hw);
+	if (smtc_2Dacceleration) {
+		printk("2D acceleration enabled!\n");
+		/* Init smtc drawing engine */
+		deInit(sfb->fb.var.xres, sfb->fb.var.yres,
+				sfb->fb.var.bits_per_pixel);
+	}
+}
+
+#if defined(CONFIG_FB_SM7XX_DUALHEAD)
+void smtc_head2_init(struct smtcfb_info *sfb)
+{
+	smtcfb_info2 = *sfb;
+	smtcfb_info2.fb.pseudo_palette = &colreg2;
+	smtcfb_info2.fb.par = &hw2;
+	sprintf(smtcfb_info2.fb.fix.id, "sm%Xfb2", hw.chipID);
+	hw2.chipID = hw.chipID;
+	hw2.chipRevID = hw.chipRevID;
+	hw2.width = smtcfb_info2.fb.var.xres;
+	hw2.height = smtcfb_info2.fb.var.yres;
+	hw2.hz = 60;
+	hw2.m_pMMIO = smtc_RegBaseAddress;
+
+	/*hard code 2nd head starting from half VRAM size postion */
+	hw2.BaseAddressInVRAM = smtcfb_info2.fb.fix.smem_len / 2;
+
+	hw2.m_pLFB = smtc_VRAMBaseAddress + hw2.BaseAddressInVRAM;
+	smtcfb_info2.fb.screen_base = hw2.m_pLFB;
+
+	writel(hw2.BaseAddressInVRAM >> 3, hw2.m_pVPR + 0x10);
+}
+#endif
+
+/*
+ * Alloc struct smtcfb_info and assign the default value
+ */
+static struct smtcfb_info *__devinit smtc_alloc_fb_info(struct pci_dev *dev,
+							char *name)
+{
+	struct smtcfb_info *sfb;
+
+	sfb = kmalloc(sizeof(struct smtcfb_info), GFP_KERNEL);
+
+	if (!sfb)
+		return NULL;
+
+	memset(sfb, 0, sizeof(struct smtcfb_info));
+
+	sfb->currcon = -1;
+	sfb->dev = dev;
+
+	/*** Init sfb->fb with default value ***/
+	sfb->fb.flags = FBINFO_FLAG_DEFAULT;
+	sfb->fb.fbops = &smtcfb_ops;
+	sfb->fb.var = smtcfb_var;
+	sfb->fb.fix = smtcfb_fix;
+
+	strcpy(sfb->fb.fix.id, name);
+
+	sfb->fb.fix.type = FB_TYPE_PACKED_PIXELS;
+	sfb->fb.fix.type_aux = 0;
+	sfb->fb.fix.xpanstep = 0;
+	sfb->fb.fix.ypanstep = 0;
+	sfb->fb.fix.ywrapstep = 0;
+	sfb->fb.fix.accel = FB_ACCEL_SMI_LYNX;
+
+	sfb->fb.var.nonstd = 0;
+	sfb->fb.var.activate = FB_ACTIVATE_NOW;
+	sfb->fb.var.height = -1;
+	sfb->fb.var.width = -1;
+	/* text mode acceleration */
+	sfb->fb.var.accel_flags = FB_ACCELF_TEXT;
+	sfb->fb.var.vmode = FB_VMODE_NONINTERLACED;
+	sfb->fb.par = &hw;
+	sfb->fb.pseudo_palette = colreg;
+
+	return sfb;
+}
+
+/*
+ * Unmap in the memory mapped IO registers
+ */
+
+static void __devinit smtc_unmap_mmio(struct smtcfb_info *sfb)
+{
+	if (sfb && smtc_RegBaseAddress)
+		smtc_RegBaseAddress = NULL;
+}
+
+/*
+ * Map in the screen memory
+ */
+
+static int __devinit smtc_map_smem(struct smtcfb_info *sfb,
+		struct pci_dev *dev, u_long smem_len)
+{
+	if (sfb->fb.var.bits_per_pixel == 32) {
+#ifdef __BIG_ENDIAN
+		sfb->fb.fix.smem_start = pci_resource_start(dev, 0)
+			+ 0x800000;
+#else
+		sfb->fb.fix.smem_start = pci_resource_start(dev, 0);
+#endif
+	} else {
+		sfb->fb.fix.smem_start = pci_resource_start(dev, 0);
+	}
+
+	sfb->fb.fix.smem_len = smem_len;
+
+	sfb->fb.screen_base = smtc_VRAMBaseAddress;
+
+	if (!sfb->fb.screen_base) {
+		printk(KERN_INFO "%s: unable to map screen memory\n",
+				sfb->fb.fix.id);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+/*
+ * Unmap in the screen memory
+ *
+ */
+static void __devinit smtc_unmap_smem(struct smtcfb_info *sfb)
+{
+	if (sfb && sfb->fb.screen_base) {
+		iounmap(sfb->fb.screen_base);
+		sfb->fb.screen_base = NULL;
+	}
+}
+
+/*
+ * We need to wake up the LynxEM+, and make sure its in linear memory mode.
+ */
+static inline void __devinit sm7xx_init_hw(void)
+{
+	outb_p(0x18, 0x3c4);
+	outb_p(0x11, 0x3c5);
+}
+
+static void __devinit smtc_free_fb_info(struct smtcfb_info *sfb)
+{
+	if (sfb) {
+		fb_alloc_cmap(&sfb->fb.cmap, 0, 0);
+		kfree(sfb);
+	}
+}
+
+static int __init smtcfb_init(void)
+{
+	struct smtcfb_info *sfb;
+	u_long smem_size = 0x00800000;	/* default 8MB */
+	char name[16];
+	int err, i = 0;
+	unsigned long pFramebufferPhysical;
+	struct pci_dev *pdev = NULL;
+
+	printk(KERN_INFO
+		"Silicon Motion display driver " SMTC_LINUX_FB_VERSION "\n");
+
+	/* init the global variable */
+	smtc_2Dacceleration = 0;	/* default no 2D acceleration */
+
+	do {
+		pdev = pci_get_device(0x126f, smtc_ChipIDs[i], pdev);
+		if (pdev == NULL) {
+			i++;
+		} else {
+			hw.chipID = smtc_ChipIDs[i];
+			break;
+		}
+	} while (i < numSMTCchipIDs);
+
+	err = pci_enable_device(pdev);	/* enable SMTC chip */
+
+	if (err)
+		return err;
+
+	err = -ENOMEM;
+
+	sprintf(name, "sm%Xfb", hw.chipID);
+
+	sfb = smtc_alloc_fb_info(pdev, name);
+
+	if (!sfb)
+		goto failed;
+
+	sm7xx_init_hw();
+
+	/*get mode parameter from screen_info */
+	if (screen_info.lfb_width != 0) {
+		sfb->fb.var.xres = screen_info.lfb_width;
+		sfb->fb.var.yres = screen_info.lfb_height;
+		sfb->fb.var.bits_per_pixel = screen_info.lfb_depth;
+	} else {
+		/* default resolution 1024x600 16bit mode */
+		sfb->fb.var.xres = SCREEN_X_RES;
+		sfb->fb.var.yres = SCREEN_Y_RES;
+		sfb->fb.var.bits_per_pixel = SCREEN_BPP;
+	}
+
+	smdbg("\nsfb->fb.var.bits_per_pixel = %d sm712be_flag = %d\n",
+	      sfb->fb.var.bits_per_pixel, sm712be_flag);
+#ifdef __BIG_ENDIAN
+	if (sm712be_flag == 1 && sfb->fb.var.bits_per_pixel == 24)
+		sfb->fb.var.bits_per_pixel = (screen_info.lfb_depth = 32);
+#endif
+	/* Map address and memory detection */
+	pFramebufferPhysical = pci_resource_start(pdev, 0);
+	pci_read_config_byte(pdev, PCI_REVISION_ID, &hw.chipRevID);
+
+	switch (hw.chipID) {
+	case 0x710:
+	case 0x712:
+		sfb->fb.fix.mmio_start = pFramebufferPhysical + 0x00400000;
+		sfb->fb.fix.mmio_len = 0x00400000;
+		smem_size = SM712_VIDEOMEMORYSIZE;
+#ifdef __BIG_ENDIAN
+		hw.m_pLFB = (smtc_VRAMBaseAddress =
+		    ioremap(pFramebufferPhysical, 0x00c00000));
+#else
+		hw.m_pLFB = (smtc_VRAMBaseAddress =
+		    ioremap(pFramebufferPhysical, 0x00800000));
+#endif
+		hw.m_pMMIO = (smtc_RegBaseAddress =
+		    smtc_VRAMBaseAddress + 0x00700000);
+		smtc_2DBaseAddress = (hw.m_pDPR =
+		    smtc_VRAMBaseAddress + 0x00408000);
+		smtc_2Ddataport = smtc_VRAMBaseAddress + DE_DATA_PORT_712;
+		hw.m_pVPR = hw.m_pLFB + 0x0040c000;
+		if (sfb->fb.var.bits_per_pixel == 32) {
+#ifdef __BIG_ENDIAN
+			smtc_VRAMBaseAddress += 0x800000;
+			hw.m_pLFB += 0x800000;
+			printk(KERN_INFO
+				"\nsmtc_VRAMBaseAddress=0x%X hw.m_pLFB=0x%X\n",
+					smtc_VRAMBaseAddress, hw.m_pLFB);
+#endif
+		}
+		if (!smtc_RegBaseAddress) {
+
+			printk(KERN_INFO
+				"%s: unable to map memory mapped IO\n",
+				sfb->fb.fix.id);
+
+			return -ENOMEM;
+		}
+
+		/* set MCLK = 14.31818 * (0x16 / 0x2) */
+		smtc_seqw(0x6a, 0x16);
+		smtc_seqw(0x6b, 0x02);
+		smtc_seqw(0x62, 0x3e);
+		/* enable PCI burst */
+		smtc_seqw(0x17, 0x20);
+		/* enabel word swap */
+		if (sfb->fb.var.bits_per_pixel == 32) {
+#ifdef __BIG_ENDIAN
+			smtc_seqw(0x17, 0x30);
+#endif
+		}
+#ifdef CONFIG_FB_SM7XX_ACCEL
+		smtc_2Dacceleration = 1;
+#endif
+
+		break;
+
+	case 0x720:
+		sfb->fb.fix.mmio_start = pFramebufferPhysical;
+		sfb->fb.fix.mmio_len = 0x00200000;
+		smem_size = SM722_VIDEOMEMORYSIZE;
+		smtc_2DBaseAddress = (hw.m_pDPR =
+		    ioremap(pFramebufferPhysical, 0x00a00000));
+		hw.m_pLFB = (smtc_VRAMBaseAddress =
+		    smtc_2DBaseAddress + 0x00200000);
+		hw.m_pMMIO = (smtc_RegBaseAddress =
+		    smtc_2DBaseAddress + 0x000c0000);
+		smtc_2Ddataport = smtc_2DBaseAddress + DE_DATA_PORT_722;
+		hw.m_pVPR = smtc_2DBaseAddress + 0x800;
+
+		smtc_seqw(0x62, 0xff);
+		smtc_seqw(0x6a, 0x0d);
+		smtc_seqw(0x6b, 0x02);
+		smtc_2Dacceleration = 0;
+		break;
+	default:
+		printk(KERN_INFO
+		"No valid Silicon Motion display chip was detected!\n");
+
+		smtc_free_fb_info(sfb);
+		return err;
+	}
+
+	/* can support 32 bpp */
+	if (15 == sfb->fb.var.bits_per_pixel)
+		sfb->fb.var.bits_per_pixel = 16;
+
+	sfb->fb.var.xres_virtual = sfb->fb.var.xres;
+
+	sfb->fb.var.yres_virtual = sfb->fb.var.yres;
+	err = smtc_map_smem(sfb, pdev, smem_size);
+	if (err)
+		goto failed;
+
+	smtcfb_setmode(sfb);
+	/* Primary display starting from 0 postion */
+	hw.BaseAddressInVRAM = 0;
+	sfb->fb.par = &hw;
+
+	err = register_framebuffer(&sfb->fb);
+	if (err < 0)
+		goto failed;
+
+	printk(KERN_INFO "Silicon Motion SM%X Rev%X primary display mode"
+			"%dx%d-%d Init Complete.\n", hw.chipID, hw.chipRevID,
+			sfb->fb.var.xres, sfb->fb.var.yres,
+			sfb->fb.var.bits_per_pixel);
+
+#if defined(CONFIG_FB_SM7XX_DUALHEAD)
+	smtc_head2_init(sfb);
+	err = register_framebuffer(&smtcfb_info2.fb);
+
+	/* if second head display fails, also fails the primary display */
+	if (err < 0) {
+		printk(KERN_INFO
+			"Silicon Motion, Inc.  second head init fail\n");
+		goto failed;
+	}
+
+	printk(KERN_INFO "Silicon Motion SM%X Rev%X secondary display mode"
+			"%dx%d-%d Init Complete.\n", hw.chipID, hw.chipRevID,
+			hw2.width, hw2.height,
+			smtcfb_info2.fb.var.bits_per_pixel);
+#endif
+
+	return 0;
+
+ failed:
+	printk(KERN_INFO "Silicon Motion, Inc.  primary display init fail\n");
+
+	smtc_unmap_smem(sfb);
+	smtc_unmap_mmio(sfb);
+	smtc_free_fb_info(sfb);
+
+	return err;
+}
+
+static void __exit smtcfb_exit(void)
+{
+}
+
+module_init(smtcfb_init);
+module_exit(smtcfb_exit);
+
+/*
+ *	sm712be_setup - process command line options
+ *	@options: string of options
+ *	Returns zero.
+ *
+ */
+static int __init sm712be_setup(char *options)
+{
+	sm712be_flag = 0;
+	if (!options || !*options) {
+		smdbg("\n No sm712be parameter\n");
+		return -EINVAL;
+	}
+	if (strstr(options, "enable") != NULL)
+		sm712be_flag = 1;
+
+	smdbg("\nsm712be_setup = %s sm712be_flag = %d\n", options,
+	      sm712be_flag);
+
+	return 0;
+}
+
+__setup("sm712be=", sm712be_setup);
+
+/*
+ *	sm712vga_setup - process command line options, get vga parameter
+ *	@options: string of options
+ *	Returns zero.
+ *
+ */
+static int __init sm712vga_setup(char *options)
+{
+	int index;
+	sm712be_flag = 0;
+
+	if (!options || !*options) {
+		smdbg("\n No vga parameter\n");
+		return -EINVAL;
+	}
+
+	screen_info.lfb_width = 0;
+	screen_info.lfb_height = 0;
+	screen_info.lfb_depth = 0;
+
+	smdbg("\nsm712vga_setup = %s\n", options);
+
+	for (index = 0;
+	     index < (sizeof(vesa_mode) / sizeof(struct vesa_mode_table));
+	     index++) {
+		if (strstr(options, vesa_mode[index].mode_index)) {
+			screen_info.lfb_width = vesa_mode[index].lfb_width;
+			screen_info.lfb_height = vesa_mode[index].lfb_height;
+			screen_info.lfb_depth = vesa_mode[index].lfb_depth;
+			return 0;
+		}
+	}
+
+	return -1;
+}
+
+__setup("vga=", sm712vga_setup);
+
+MODULE_AUTHOR("Siliconmotion ");
+MODULE_DESCRIPTION("Framebuffer driver for SMI Graphic Cards");
+MODULE_LICENSE("GPL");
diff --git a/drivers/video/smi/smtcfb.h b/drivers/video/smi/smtcfb.h
new file mode 100644
index 0000000..6b8ed8a
--- /dev/null
+++ b/drivers/video/smi/smtcfb.h
@@ -0,0 +1,793 @@
+/*
+ * smtcfb.h -- Silicon Motion SM501 and SM7xx frame buffer device
+ *
+ * Copyright (C) 2006 Silicon Motion Technology Corp.
+ * Authors:	Ge Wang, gewang@siliconmotion.com
+ *	 	Boyod boyod.yang@siliconmotion.com.cn
+ *
+ * Copyright (C) 2009 Lemote, Inc. & Institute of Computing Technology
+ * Author: Wu Zhangjin, wuzj@lemote.com
+ *
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License. See the file COPYING in the main directory of this archive for
+ *  more details.
+ */
+
+#define SMTC_LINUX_FB_VERSION	"version 0.11.2619.21.01 July 27, 2008"
+
+#define NR_PALETTE        256
+#define NR_RGB            2
+
+#define FB_ACCEL_SMI_LYNX 88
+
+#ifdef __BIG_ENDIAN
+#define PC_VGA            0
+#else
+#define PC_VGA            1
+#endif
+
+#define SCREEN_X_RES      1024
+#define SCREEN_Y_RES      600
+#define SCREEN_BPP        16
+
+#ifndef FIELD_OFFSET
+#define FIELD_OFSFET(type, field) \
+	((unsigned long) (PUCHAR) & (((type *)0)->field))
+#endif
+
+/*Assume SM712 graphics chip has 4MB VRAM */
+#define SM712_VIDEOMEMORYSIZE	  0x00400000
+/*Assume SM722 graphics chip has 8MB VRAM */
+#define SM722_VIDEOMEMORYSIZE	  0x00800000
+
+#define dac_reg	(0x3c8)
+#define dac_val	(0x3c9)
+
+extern char *smtc_RegBaseAddress;
+#define smtc_mmiowb(dat, reg)	writeb(dat, smtc_RegBaseAddress + reg)
+#define smtc_mmioww(dat, reg)	writew(dat, smtc_RegBaseAddress + reg)
+#define smtc_mmiowl(dat, reg)	writel(dat, smtc_RegBaseAddress + reg)
+
+#define smtc_mmiorb(reg)	readb(smtc_RegBaseAddress + reg)
+#define smtc_mmiorw(reg)	readw(smtc_RegBaseAddress + reg)
+#define smtc_mmiorl(reg)	readl(smtc_RegBaseAddress + reg)
+
+#define SIZE_SR00_SR04      (0x04 - 0x00 + 1)
+#define SIZE_SR10_SR24      (0x24 - 0x10 + 1)
+#define SIZE_SR30_SR75      (0x75 - 0x30 + 1)
+#define SIZE_SR80_SR93      (0x93 - 0x80 + 1)
+#define SIZE_SRA0_SRAF      (0xAF - 0xA0 + 1)
+#define SIZE_GR00_GR08      (0x08 - 0x00 + 1)
+#define SIZE_AR00_AR14      (0x14 - 0x00 + 1)
+#define SIZE_CR00_CR18      (0x18 - 0x00 + 1)
+#define SIZE_CR30_CR4D      (0x4D - 0x30 + 1)
+#define SIZE_CR90_CRA7      (0xA7 - 0x90 + 1)
+#define SIZE_VPR		(0x6C + 1)
+#define SIZE_DPR		(0x44 + 1)
+
+static inline void smtc_crtcw(int reg, int val)
+{
+	smtc_mmiowb(reg, 0x3d4);
+	smtc_mmiowb(val, 0x3d5);
+}
+
+static inline unsigned int smtc_crtcr(int reg)
+{
+	smtc_mmiowb(reg, 0x3d4);
+	return smtc_mmiorb(0x3d5);
+}
+
+static inline void smtc_grphw(int reg, int val)
+{
+	smtc_mmiowb(reg, 0x3ce);
+	smtc_mmiowb(val, 0x3cf);
+}
+
+static inline unsigned int smtc_grphr(int reg)
+{
+	smtc_mmiowb(reg, 0x3ce);
+	return smtc_mmiorb(0x3cf);
+}
+
+static inline void smtc_attrw(int reg, int val)
+{
+	smtc_mmiorb(0x3da);
+	smtc_mmiowb(reg, 0x3c0);
+	smtc_mmiorb(0x3c1);
+	smtc_mmiowb(val, 0x3c0);
+}
+
+static inline void smtc_seqw(int reg, int val)
+{
+	smtc_mmiowb(reg, 0x3c4);
+	smtc_mmiowb(val, 0x3c5);
+}
+
+static inline unsigned int smtc_seqr(int reg)
+{
+	smtc_mmiowb(reg, 0x3c4);
+	return smtc_mmiorb(0x3c5);
+}
+
+/* The next structure holds all information relevant for a specific video mode.
+ */
+
+struct ModeInit {
+	int mmSizeX;
+	int mmSizeY;
+	int bpp;
+	int hz;
+	unsigned char Init_MISC;
+	unsigned char Init_SR00_SR04[SIZE_SR00_SR04];
+	unsigned char Init_SR10_SR24[SIZE_SR10_SR24];
+	unsigned char Init_SR30_SR75[SIZE_SR30_SR75];
+	unsigned char Init_SR80_SR93[SIZE_SR80_SR93];
+	unsigned char Init_SRA0_SRAF[SIZE_SRA0_SRAF];
+	unsigned char Init_GR00_GR08[SIZE_GR00_GR08];
+	unsigned char Init_AR00_AR14[SIZE_AR00_AR14];
+	unsigned char Init_CR00_CR18[SIZE_CR00_CR18];
+	unsigned char Init_CR30_CR4D[SIZE_CR30_CR4D];
+	unsigned char Init_CR90_CRA7[SIZE_CR90_CRA7];
+};
+
+/**********************************************************************
+			 SM712 Mode table.
+ **********************************************************************/
+struct ModeInit VGAMode[] = {
+	{
+	 /*  mode#0: 640 x 480  16Bpp  60Hz */
+	 640, 480, 16, 60,
+	 /*  Init_MISC */
+	 0xE3,
+	 {			/*  Init_SR0_SR4 */
+	  0x03, 0x01, 0x0F, 0x00, 0x0E,
+	  },
+	 {			/*  Init_SR10_SR24 */
+	  0xFF, 0xBE, 0xEF, 0xFF, 0x00, 0x0E, 0x17, 0x2C,
+	  0x99, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	  0xC4, 0x30, 0x02, 0x01, 0x01,
+	  },
+	 {			/*  Init_SR30_SR75 */
+	  0x32, 0x03, 0xA0, 0x09, 0xC0, 0x32, 0x32, 0x32,
+	  0x32, 0x32, 0x32, 0x32, 0x00, 0x00, 0x03, 0xFF,
+	  0x00, 0xFC, 0x00, 0x00, 0x20, 0x18, 0x00, 0xFC,
+	  0x20, 0x0C, 0x44, 0x20, 0x00, 0x32, 0x32, 0x32,
+	  0x04, 0x24, 0x63, 0x4F, 0x52, 0x0B, 0xDF, 0xEA,
+	  0x04, 0x50, 0x19, 0x32, 0x32, 0x00, 0x00, 0x32,
+	  0x01, 0x80, 0x7E, 0x1A, 0x1A, 0x00, 0x00, 0x00,
+	  0x50, 0x03, 0x74, 0x14, 0x07, 0x82, 0x07, 0x04,
+	  0x00, 0x45, 0x30, 0x30, 0x40, 0x30,
+	  },
+	 {			/*  Init_SR80_SR93 */
+	  0xFF, 0x07, 0x00, 0x6F, 0x7F, 0x7F, 0xFF, 0x32,
+	  0xF7, 0x00, 0x00, 0x00, 0xEF, 0xFF, 0x32, 0x32,
+	  0x00, 0x00, 0x00, 0x00,
+	  },
+	 {			/*  Init_SRA0_SRAF */
+	  0x00, 0xFF, 0xBF, 0xFF, 0xFF, 0xED, 0xED, 0xED,
+	  0x7B, 0xFF, 0xFF, 0xFF, 0xBF, 0xEF, 0xFF, 0xDF,
+	  },
+	 {			/*  Init_GR00_GR08 */
+	  0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x05, 0x0F,
+	  0xFF,
+	  },
+	 {			/*  Init_AR00_AR14 */
+	  0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
+	  0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
+	  0x41, 0x00, 0x0F, 0x00, 0x00,
+	  },
+	 {			/*  Init_CR00_CR18 */
+	  0x5F, 0x4F, 0x4F, 0x00, 0x53, 0x1F, 0x0B, 0x3E,
+	  0x00, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	  0xEA, 0x0C, 0xDF, 0x50, 0x40, 0xDF, 0x00, 0xE3,
+	  0xFF,
+	  },
+	 {			/*  Init_CR30_CR4D */
+	  0x00, 0x00, 0x00, 0x00, 0x00, 0x55, 0x03, 0x20,
+	  0x00, 0x00, 0x00, 0x40, 0x00, 0xE7, 0xFF, 0xFD,
+	  0x5F, 0x4F, 0x00, 0x54, 0x00, 0x0B, 0xDF, 0x00,
+	  0xEA, 0x0C, 0x2E, 0x00, 0x4F, 0xDF,
+	  },
+	 {			/*  Init_CR90_CRA7 */
+	  0x56, 0xDD, 0x5E, 0xEA, 0x87, 0x44, 0x8F, 0x55,
+	  0x0A, 0x8F, 0x55, 0x0A, 0x00, 0x00, 0x18, 0x00,
+	  0x11, 0x10, 0x0B, 0x0A, 0x0A, 0x0A, 0x0A, 0x00,
+	  },
+	 },
+	{
+	 /*  mode#1: 640 x 480  24Bpp  60Hz */
+	 640, 480, 24, 60,
+	 /*  Init_MISC */
+	 0xE3,
+	 {			/*  Init_SR0_SR4 */
+	  0x03, 0x01, 0x0F, 0x00, 0x0E,
+	  },
+	 {			/*  Init_SR10_SR24 */
+	  0xFF, 0xBE, 0xEF, 0xFF, 0x00, 0x0E, 0x17, 0x2C,
+	  0x99, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	  0xC4, 0x30, 0x02, 0x01, 0x01,
+	  },
+	 {			/*  Init_SR30_SR75 */
+	  0x32, 0x03, 0xA0, 0x09, 0xC0, 0x32, 0x32, 0x32,
+	  0x32, 0x32, 0x32, 0x32, 0x00, 0x00, 0x03, 0xFF,
+	  0x00, 0xFC, 0x00, 0x00, 0x20, 0x18, 0x00, 0xFC,
+	  0x20, 0x0C, 0x44, 0x20, 0x00, 0x32, 0x32, 0x32,
+	  0x04, 0x24, 0x63, 0x4F, 0x52, 0x0B, 0xDF, 0xEA,
+	  0x04, 0x50, 0x19, 0x32, 0x32, 0x00, 0x00, 0x32,
+	  0x01, 0x80, 0x7E, 0x1A, 0x1A, 0x00, 0x00, 0x00,
+	  0x50, 0x03, 0x74, 0x14, 0x07, 0x82, 0x07, 0x04,
+	  0x00, 0x45, 0x30, 0x30, 0x40, 0x30,
+	  },
+	 {			/*  Init_SR80_SR93 */
+	  0xFF, 0x07, 0x00, 0x6F, 0x7F, 0x7F, 0xFF, 0x32,
+	  0xF7, 0x00, 0x00, 0x00, 0xEF, 0xFF, 0x32, 0x32,
+	  0x00, 0x00, 0x00, 0x00,
+	  },
+	 {			/*  Init_SRA0_SRAF */
+	  0x00, 0xFF, 0xBF, 0xFF, 0xFF, 0xED, 0xED, 0xED,
+	  0x7B, 0xFF, 0xFF, 0xFF, 0xBF, 0xEF, 0xFF, 0xDF,
+	  },
+	 {			/*  Init_GR00_GR08 */
+	  0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x05, 0x0F,
+	  0xFF,
+	  },
+	 {			/*  Init_AR00_AR14 */
+	  0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
+	  0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
+	  0x41, 0x00, 0x0F, 0x00, 0x00,
+	  },
+	 {			/*  Init_CR00_CR18 */
+	  0x5F, 0x4F, 0x4F, 0x00, 0x53, 0x1F, 0x0B, 0x3E,
+	  0x00, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	  0xEA, 0x0C, 0xDF, 0x50, 0x40, 0xDF, 0x00, 0xE3,
+	  0xFF,
+	  },
+	 {			/*  Init_CR30_CR4D */
+	  0x00, 0x00, 0x00, 0x00, 0x00, 0x55, 0x03, 0x20,
+	  0x00, 0x00, 0x00, 0x40, 0x00, 0xE7, 0xFF, 0xFD,
+	  0x5F, 0x4F, 0x00, 0x54, 0x00, 0x0B, 0xDF, 0x00,
+	  0xEA, 0x0C, 0x2E, 0x00, 0x4F, 0xDF,
+	  },
+	 {			/*  Init_CR90_CRA7 */
+	  0x56, 0xDD, 0x5E, 0xEA, 0x87, 0x44, 0x8F, 0x55,
+	  0x0A, 0x8F, 0x55, 0x0A, 0x00, 0x00, 0x18, 0x00,
+	  0x11, 0x10, 0x0B, 0x0A, 0x0A, 0x0A, 0x0A, 0x00,
+	  },
+	 },
+	{
+	 /*  mode#0: 640 x 480  32Bpp  60Hz */
+	 640, 480, 32, 60,
+	 /*  Init_MISC */
+	 0xE3,
+	 {			/*  Init_SR0_SR4 */
+	  0x03, 0x01, 0x0F, 0x00, 0x0E,
+	  },
+	 {			/*  Init_SR10_SR24 */
+	  0xFF, 0xBE, 0xEF, 0xFF, 0x00, 0x0E, 0x17, 0x2C,
+	  0x99, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	  0xC4, 0x30, 0x02, 0x01, 0x01,
+	  },
+	 {			/*  Init_SR30_SR75 */
+	  0x32, 0x03, 0xA0, 0x09, 0xC0, 0x32, 0x32, 0x32,
+	  0x32, 0x32, 0x32, 0x32, 0x00, 0x00, 0x03, 0xFF,
+	  0x00, 0xFC, 0x00, 0x00, 0x20, 0x18, 0x00, 0xFC,
+	  0x20, 0x0C, 0x44, 0x20, 0x00, 0x32, 0x32, 0x32,
+	  0x04, 0x24, 0x63, 0x4F, 0x52, 0x0B, 0xDF, 0xEA,
+	  0x04, 0x50, 0x19, 0x32, 0x32, 0x00, 0x00, 0x32,
+	  0x01, 0x80, 0x7E, 0x1A, 0x1A, 0x00, 0x00, 0x00,
+	  0x50, 0x03, 0x74, 0x14, 0x07, 0x82, 0x07, 0x04,
+	  0x00, 0x45, 0x30, 0x30, 0x40, 0x30,
+	  },
+	 {			/*  Init_SR80_SR93 */
+	  0xFF, 0x07, 0x00, 0x6F, 0x7F, 0x7F, 0xFF, 0x32,
+	  0xF7, 0x00, 0x00, 0x00, 0xEF, 0xFF, 0x32, 0x32,
+	  0x00, 0x00, 0x00, 0x00,
+	  },
+	 {			/*  Init_SRA0_SRAF */
+	  0x00, 0xFF, 0xBF, 0xFF, 0xFF, 0xED, 0xED, 0xED,
+	  0x7B, 0xFF, 0xFF, 0xFF, 0xBF, 0xEF, 0xFF, 0xDF,
+	  },
+	 {			/*  Init_GR00_GR08 */
+	  0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x05, 0x0F,
+	  0xFF,
+	  },
+	 {			/*  Init_AR00_AR14 */
+	  0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
+	  0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
+	  0x41, 0x00, 0x0F, 0x00, 0x00,
+	  },
+	 {			/*  Init_CR00_CR18 */
+	  0x5F, 0x4F, 0x4F, 0x00, 0x53, 0x1F, 0x0B, 0x3E,
+	  0x00, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	  0xEA, 0x0C, 0xDF, 0x50, 0x40, 0xDF, 0x00, 0xE3,
+	  0xFF,
+	  },
+	 {			/*  Init_CR30_CR4D */
+	  0x00, 0x00, 0x00, 0x00, 0x00, 0x55, 0x03, 0x20,
+	  0x00, 0x00, 0x00, 0x40, 0x00, 0xE7, 0xFF, 0xFD,
+	  0x5F, 0x4F, 0x00, 0x54, 0x00, 0x0B, 0xDF, 0x00,
+	  0xEA, 0x0C, 0x2E, 0x00, 0x4F, 0xDF,
+	  },
+	 {			/*  Init_CR90_CRA7 */
+	  0x56, 0xDD, 0x5E, 0xEA, 0x87, 0x44, 0x8F, 0x55,
+	  0x0A, 0x8F, 0x55, 0x0A, 0x00, 0x00, 0x18, 0x00,
+	  0x11, 0x10, 0x0B, 0x0A, 0x0A, 0x0A, 0x0A, 0x00,
+	  },
+	 },
+
+	{			/*  mode#2: 800 x 600  16Bpp  60Hz */
+	 800, 600, 16, 60,
+	 /*  Init_MISC */
+	 0x2B,
+	 {			/*  Init_SR0_SR4 */
+	  0x03, 0x01, 0x0F, 0x03, 0x0E,
+	  },
+	 {			/*  Init_SR10_SR24 */
+	  0xFF, 0xBE, 0xEE, 0xFF, 0x00, 0x0E, 0x17, 0x2C,
+	  0x99, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00,
+	  0xC4, 0x30, 0x02, 0x01, 0x01,
+	  },
+	 {			/*  Init_SR30_SR75 */
+	  0x34, 0x03, 0x20, 0x09, 0xC0, 0x24, 0x24, 0x24,
+	  0x24, 0x24, 0x24, 0x24, 0x00, 0x00, 0x03, 0xFF,
+	  0x00, 0xFC, 0x00, 0x00, 0x20, 0x38, 0x00, 0xFC,
+	  0x20, 0x0C, 0x44, 0x20, 0x00, 0x24, 0x24, 0x24,
+	  0x04, 0x48, 0x83, 0x63, 0x68, 0x72, 0x57, 0x58,
+	  0x04, 0x55, 0x59, 0x24, 0x24, 0x00, 0x00, 0x24,
+	  0x01, 0x80, 0x7A, 0x1A, 0x1A, 0x00, 0x00, 0x00,
+	  0x50, 0x03, 0x74, 0x14, 0x1C, 0x85, 0x35, 0x13,
+	  0x02, 0x45, 0x30, 0x35, 0x40, 0x20,
+	  },
+	 {			/*  Init_SR80_SR93 */
+	  0x00, 0x00, 0x00, 0x6F, 0x7F, 0x7F, 0xFF, 0x24,
+	  0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0x24, 0x24,
+	  0x00, 0x00, 0x00, 0x00,
+	  },
+	 {			/*  Init_SRA0_SRAF */
+	  0x00, 0xFF, 0xBF, 0xFF, 0xFF, 0xED, 0xED, 0xED,
+	  0x7B, 0xFF, 0xFF, 0xFF, 0xBF, 0xEF, 0xBF, 0xDF,
+	  },
+	 {			/*  Init_GR00_GR08 */
+	  0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x05, 0x0F,
+	  0xFF,
+	  },
+	 {			/*  Init_AR00_AR14 */
+	  0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
+	  0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
+	  0x41, 0x00, 0x0F, 0x00, 0x00,
+	  },
+	 {			/*  Init_CR00_CR18 */
+	  0x7F, 0x63, 0x63, 0x00, 0x68, 0x18, 0x72, 0xF0,
+	  0x00, 0x60, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	  0x58, 0x0C, 0x57, 0x64, 0x40, 0x57, 0x00, 0xE3,
+	  0xFF,
+	  },
+	 {			/*  Init_CR30_CR4D */
+	  0x00, 0x00, 0x00, 0x00, 0x00, 0x33, 0x03, 0x20,
+	  0x00, 0x00, 0x00, 0x40, 0x00, 0xE7, 0xBF, 0xFD,
+	  0x7F, 0x63, 0x00, 0x69, 0x18, 0x72, 0x57, 0x00,
+	  0x58, 0x0C, 0xE0, 0x20, 0x63, 0x57,
+	  },
+	 {			/*  Init_CR90_CRA7 */
+	  0x56, 0x4B, 0x5E, 0x55, 0x86, 0x9D, 0x8E, 0xAA,
+	  0xDB, 0x2A, 0xDF, 0x33, 0x00, 0x00, 0x18, 0x00,
+	  0x20, 0x1F, 0x1A, 0x19, 0x0F, 0x0F, 0x0F, 0x00,
+	  },
+	 },
+	{			/*  mode#3: 800 x 600  24Bpp  60Hz */
+	 800, 600, 24, 60,
+	 0x2B,
+	 {			/*  Init_SR0_SR4 */
+	  0x03, 0x01, 0x0F, 0x03, 0x0E,
+	  },
+	 {			/*  Init_SR10_SR24 */
+	  0xFF, 0xBE, 0xEE, 0xFF, 0x00, 0x0E, 0x17, 0x2C,
+	  0x99, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	  0xC4, 0x30, 0x02, 0x01, 0x01,
+	  },
+	 {			/*  Init_SR30_SR75 */
+	  0x36, 0x03, 0x20, 0x09, 0xC0, 0x36, 0x36, 0x36,
+	  0x36, 0x36, 0x36, 0x36, 0x00, 0x00, 0x03, 0xFF,
+	  0x00, 0xFC, 0x00, 0x00, 0x20, 0x18, 0x00, 0xFC,
+	  0x20, 0x0C, 0x44, 0x20, 0x00, 0x36, 0x36, 0x36,
+	  0x04, 0x48, 0x83, 0x63, 0x68, 0x72, 0x57, 0x58,
+	  0x04, 0x55, 0x59, 0x36, 0x36, 0x00, 0x00, 0x36,
+	  0x01, 0x80, 0x7E, 0x1A, 0x1A, 0x00, 0x00, 0x00,
+	  0x50, 0x03, 0x74, 0x14, 0x1C, 0x85, 0x35, 0x13,
+	  0x02, 0x45, 0x30, 0x30, 0x40, 0x20,
+	  },
+	 {			/*  Init_SR80_SR93 */
+	  0xFF, 0x07, 0x00, 0x6F, 0x7F, 0x7F, 0xFF, 0x36,
+	  0xF7, 0x00, 0x00, 0x00, 0xEF, 0xFF, 0x36, 0x36,
+	  0x00, 0x00, 0x00, 0x00,
+	  },
+	 {			/*  Init_SRA0_SRAF */
+	  0x00, 0xFF, 0xBF, 0xFF, 0xFF, 0xED, 0xED, 0xED,
+	  0x7B, 0xFF, 0xFF, 0xFF, 0xBF, 0xEF, 0xBF, 0xDF,
+	  },
+	 {			/*  Init_GR00_GR08 */
+	  0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x05, 0x0F,
+	  0xFF,
+	  },
+	 {			/*  Init_AR00_AR14 */
+	  0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
+	  0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
+	  0x41, 0x00, 0x0F, 0x00, 0x00,
+	  },
+	 {			/*  Init_CR00_CR18 */
+	  0x7F, 0x63, 0x63, 0x00, 0x68, 0x18, 0x72, 0xF0,
+	  0x00, 0x60, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	  0x58, 0x0C, 0x57, 0x64, 0x40, 0x57, 0x00, 0xE3,
+	  0xFF,
+	  },
+	 {			/*  Init_CR30_CR4D */
+	  0x00, 0x00, 0x00, 0x00, 0x00, 0x33, 0x03, 0x20,
+	  0x00, 0x00, 0x00, 0x40, 0x00, 0xE7, 0xBF, 0xFD,
+	  0x7F, 0x63, 0x00, 0x69, 0x18, 0x72, 0x57, 0x00,
+	  0x58, 0x0C, 0xE0, 0x20, 0x63, 0x57,
+	  },
+	 {			/*  Init_CR90_CRA7 */
+	  0x56, 0x4B, 0x5E, 0x55, 0x86, 0x9D, 0x8E, 0xAA,
+	  0xDB, 0x2A, 0xDF, 0x33, 0x00, 0x00, 0x18, 0x00,
+	  0x20, 0x1F, 0x1A, 0x19, 0x0F, 0x0F, 0x0F, 0x00,
+	  },
+	 },
+	{			/*  mode#7: 800 x 600  32Bpp  60Hz */
+	 800, 600, 32, 60,
+	 /*  Init_MISC */
+	 0x2B,
+	 {			/*  Init_SR0_SR4 */
+	  0x03, 0x01, 0x0F, 0x03, 0x0E,
+	  },
+	 {			/*  Init_SR10_SR24 */
+	  0xFF, 0xBE, 0xEE, 0xFF, 0x00, 0x0E, 0x17, 0x2C,
+	  0x99, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00,
+	  0xC4, 0x30, 0x02, 0x01, 0x01,
+	  },
+	 {			/*  Init_SR30_SR75 */
+	  0x34, 0x03, 0x20, 0x09, 0xC0, 0x24, 0x24, 0x24,
+	  0x24, 0x24, 0x24, 0x24, 0x00, 0x00, 0x03, 0xFF,
+	  0x00, 0xFC, 0x00, 0x00, 0x20, 0x38, 0x00, 0xFC,
+	  0x20, 0x0C, 0x44, 0x20, 0x00, 0x24, 0x24, 0x24,
+	  0x04, 0x48, 0x83, 0x63, 0x68, 0x72, 0x57, 0x58,
+	  0x04, 0x55, 0x59, 0x24, 0x24, 0x00, 0x00, 0x24,
+	  0x01, 0x80, 0x7A, 0x1A, 0x1A, 0x00, 0x00, 0x00,
+	  0x50, 0x03, 0x74, 0x14, 0x1C, 0x85, 0x35, 0x13,
+	  0x02, 0x45, 0x30, 0x35, 0x40, 0x20,
+	  },
+	 {			/*  Init_SR80_SR93 */
+	  0x00, 0x00, 0x00, 0x6F, 0x7F, 0x7F, 0xFF, 0x24,
+	  0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0x24, 0x24,
+	  0x00, 0x00, 0x00, 0x00,
+	  },
+	 {			/*  Init_SRA0_SRAF */
+	  0x00, 0xFF, 0xBF, 0xFF, 0xFF, 0xED, 0xED, 0xED,
+	  0x7B, 0xFF, 0xFF, 0xFF, 0xBF, 0xEF, 0xBF, 0xDF,
+	  },
+	 {			/*  Init_GR00_GR08 */
+	  0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x05, 0x0F,
+	  0xFF,
+	  },
+	 {			/*  Init_AR00_AR14 */
+	  0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
+	  0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
+	  0x41, 0x00, 0x0F, 0x00, 0x00,
+	  },
+	 {			/*  Init_CR00_CR18 */
+	  0x7F, 0x63, 0x63, 0x00, 0x68, 0x18, 0x72, 0xF0,
+	  0x00, 0x60, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	  0x58, 0x0C, 0x57, 0x64, 0x40, 0x57, 0x00, 0xE3,
+	  0xFF,
+	  },
+	 {			/*  Init_CR30_CR4D */
+	  0x00, 0x00, 0x00, 0x00, 0x00, 0x33, 0x03, 0x20,
+	  0x00, 0x00, 0x00, 0x40, 0x00, 0xE7, 0xBF, 0xFD,
+	  0x7F, 0x63, 0x00, 0x69, 0x18, 0x72, 0x57, 0x00,
+	  0x58, 0x0C, 0xE0, 0x20, 0x63, 0x57,
+	  },
+	 {			/*  Init_CR90_CRA7 */
+	  0x56, 0x4B, 0x5E, 0x55, 0x86, 0x9D, 0x8E, 0xAA,
+	  0xDB, 0x2A, 0xDF, 0x33, 0x00, 0x00, 0x18, 0x00,
+	  0x20, 0x1F, 0x1A, 0x19, 0x0F, 0x0F, 0x0F, 0x00,
+	  },
+	 },
+	/* We use 1024x768 table to light 1024x600 panel for lemote */
+	{			/*  mode#4: 1024 x 600  16Bpp  60Hz  */
+	 1024, 600, 16, 60,
+	 /*  Init_MISC */
+	 0xEB,
+	 {			/*  Init_SR0_SR4 */
+	  0x03, 0x01, 0x0F, 0x00, 0x0E,
+	  },
+	 {			/*  Init_SR10_SR24 */
+	  0xC8, 0x40, 0x14, 0x60, 0x00, 0x0A, 0x17, 0x20,
+	  0x51, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00,
+	  0xC4, 0x30, 0x02, 0x00, 0x01,
+	  },
+	 {			/*  Init_SR30_SR75 */
+	  0x22, 0x03, 0x24, 0x09, 0xC0, 0x22, 0x22, 0x22,
+	  0x22, 0x22, 0x22, 0x22, 0x00, 0x00, 0x03, 0xFF,
+	  0x00, 0xFC, 0x00, 0x00, 0x20, 0x18, 0x00, 0xFC,
+	  0x20, 0x0C, 0x44, 0x20, 0x00, 0x22, 0x22, 0x22,
+	  0x06, 0x68, 0xA7, 0x7F, 0x83, 0x24, 0xFF, 0x03,
+	  0x00, 0x60, 0x59, 0x22, 0x22, 0x00, 0x00, 0x22,
+	  0x01, 0x80, 0x7A, 0x1A, 0x1A, 0x00, 0x00, 0x00,
+	  0x50, 0x03, 0x16, 0x02, 0x0D, 0x82, 0x09, 0x02,
+	  0x04, 0x45, 0x3F, 0x30, 0x40, 0x20,
+	  },
+	 {			/*  Init_SR80_SR93 */
+	  0xFF, 0x07, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0x3A,
+	  0xF7, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0x3A, 0x3A,
+	  0x00, 0x00, 0x00, 0x00,
+	  },
+	 {			/*  Init_SRA0_SRAF */
+	  0x00, 0xFB, 0x9F, 0x01, 0x00, 0xED, 0xED, 0xED,
+	  0x7B, 0xFB, 0xFF, 0xFF, 0x97, 0xEF, 0xBF, 0xDF,
+	  },
+	 {			/*  Init_GR00_GR08 */
+	  0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x05, 0x0F,
+	  0xFF,
+	  },
+	 {			/*  Init_AR00_AR14 */
+	  0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
+	  0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
+	  0x41, 0x00, 0x0F, 0x00, 0x00,
+	  },
+	 {			/*  Init_CR00_CR18 */
+	  0xA3, 0x7F, 0x7F, 0x00, 0x85, 0x16, 0x24, 0xF5,
+	  0x00, 0x60, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	  0x03, 0x09, 0xFF, 0x80, 0x40, 0xFF, 0x00, 0xE3,
+	  0xFF,
+	  },
+	 {			/*  Init_CR30_CR4D */
+	  0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x02, 0x20,
+	  0x00, 0x00, 0x00, 0x40, 0x00, 0xFF, 0xBF, 0xFF,
+	  0xA3, 0x7F, 0x00, 0x82, 0x0b, 0x6f, 0x57, 0x00,
+	  0x5c, 0x0f, 0xE0, 0xe0, 0x7F, 0x57,
+	  },
+	 {			/*  Init_CR90_CRA7 */
+	  0x55, 0xD9, 0x5D, 0xE1, 0x86, 0x1B, 0x8E, 0x26,
+	  0xDA, 0x8D, 0xDE, 0x94, 0x00, 0x00, 0x18, 0x00,
+	  0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x15, 0x03,
+	  },
+	 },
+	{			/*  mode#5: 1024 x 768  24Bpp  60Hz */
+	 1024, 768, 24, 60,
+	 /*  Init_MISC */
+	 0xEB,
+	 {			/*  Init_SR0_SR4 */
+	  0x03, 0x01, 0x0F, 0x03, 0x0E,
+	  },
+	 {			/*  Init_SR10_SR24 */
+	  0xF3, 0xB6, 0xC0, 0xDD, 0x00, 0x0E, 0x17, 0x2C,
+	  0x99, 0x02, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00,
+	  0xC4, 0x30, 0x02, 0x01, 0x01,
+	  },
+	 {			/*  Init_SR30_SR75 */
+	  0x38, 0x03, 0x20, 0x09, 0xC0, 0x3A, 0x3A, 0x3A,
+	  0x3A, 0x3A, 0x3A, 0x3A, 0x00, 0x00, 0x03, 0xFF,
+	  0x00, 0xFC, 0x00, 0x00, 0x20, 0x18, 0x00, 0xFC,
+	  0x20, 0x0C, 0x44, 0x20, 0x00, 0x00, 0x00, 0x3A,
+	  0x06, 0x68, 0xA7, 0x7F, 0x83, 0x24, 0xFF, 0x03,
+	  0x00, 0x60, 0x59, 0x3A, 0x3A, 0x00, 0x00, 0x3A,
+	  0x01, 0x80, 0x7E, 0x1A, 0x1A, 0x00, 0x00, 0x00,
+	  0x50, 0x03, 0x74, 0x14, 0x3B, 0x0D, 0x09, 0x02,
+	  0x04, 0x45, 0x30, 0x30, 0x40, 0x20,
+	  },
+	 {			/*  Init_SR80_SR93 */
+	  0xFF, 0x07, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0x3A,
+	  0xF7, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0x3A, 0x3A,
+	  0x00, 0x00, 0x00, 0x00,
+	  },
+	 {			/*  Init_SRA0_SRAF */
+	  0x00, 0xFB, 0x9F, 0x01, 0x00, 0xED, 0xED, 0xED,
+	  0x7B, 0xFB, 0xFF, 0xFF, 0x97, 0xEF, 0xBF, 0xDF,
+	  },
+	 {			/*  Init_GR00_GR08 */
+	  0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x05, 0x0F,
+	  0xFF,
+	  },
+	 {			/*  Init_AR00_AR14 */
+	  0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
+	  0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
+	  0x41, 0x00, 0x0F, 0x00, 0x00,
+	  },
+	 {			/*  Init_CR00_CR18 */
+	  0xA3, 0x7F, 0x7F, 0x00, 0x85, 0x16, 0x24, 0xF5,
+	  0x00, 0x60, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	  0x03, 0x09, 0xFF, 0x80, 0x40, 0xFF, 0x00, 0xE3,
+	  0xFF,
+	  },
+	 {			/*  Init_CR30_CR4D */
+	  0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x02, 0x20,
+	  0x00, 0x00, 0x00, 0x40, 0x00, 0xFF, 0xBF, 0xFF,
+	  0xA3, 0x7F, 0x00, 0x86, 0x15, 0x24, 0xFF, 0x00,
+	  0x01, 0x07, 0xE5, 0x20, 0x7F, 0xFF,
+	  },
+	 {			/*  Init_CR90_CRA7 */
+	  0x55, 0xD9, 0x5D, 0xE1, 0x86, 0x1B, 0x8E, 0x26,
+	  0xDA, 0x8D, 0xDE, 0x94, 0x00, 0x00, 0x18, 0x00,
+	  0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x15, 0x03,
+	  },
+	 },
+	{			/*  mode#4: 1024 x 768  32Bpp  60Hz */
+	 1024, 768, 32, 60,
+	 /*  Init_MISC */
+	 0xEB,
+	 {			/*  Init_SR0_SR4 */
+	  0x03, 0x01, 0x0F, 0x03, 0x0E,
+	  },
+	 {			/*  Init_SR10_SR24 */
+	  0xF3, 0xB6, 0xC0, 0xDD, 0x00, 0x0E, 0x17, 0x2C,
+	  0x99, 0x02, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00,
+	  0xC4, 0x32, 0x02, 0x01, 0x01,
+	  },
+	 {			/*  Init_SR30_SR75 */
+	  0x38, 0x03, 0x20, 0x09, 0xC0, 0x3A, 0x3A, 0x3A,
+	  0x3A, 0x3A, 0x3A, 0x3A, 0x00, 0x00, 0x03, 0xFF,
+	  0x00, 0xFC, 0x00, 0x00, 0x20, 0x18, 0x00, 0xFC,
+	  0x20, 0x0C, 0x44, 0x20, 0x00, 0x00, 0x00, 0x3A,
+	  0x06, 0x68, 0xA7, 0x7F, 0x83, 0x24, 0xFF, 0x03,
+	  0x00, 0x60, 0x59, 0x3A, 0x3A, 0x00, 0x00, 0x3A,
+	  0x01, 0x80, 0x7E, 0x1A, 0x1A, 0x00, 0x00, 0x00,
+	  0x50, 0x03, 0x74, 0x14, 0x3B, 0x0D, 0x09, 0x02,
+	  0x04, 0x45, 0x30, 0x30, 0x40, 0x20,
+	  },
+	 {			/*  Init_SR80_SR93 */
+	  0xFF, 0x07, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0x3A,
+	  0xF7, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0x3A, 0x3A,
+	  0x00, 0x00, 0x00, 0x00,
+	  },
+	 {			/*  Init_SRA0_SRAF */
+	  0x00, 0xFB, 0x9F, 0x01, 0x00, 0xED, 0xED, 0xED,
+	  0x7B, 0xFB, 0xFF, 0xFF, 0x97, 0xEF, 0xBF, 0xDF,
+	  },
+	 {			/*  Init_GR00_GR08 */
+	  0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x05, 0x0F,
+	  0xFF,
+	  },
+	 {			/*  Init_AR00_AR14 */
+	  0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
+	  0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
+	  0x41, 0x00, 0x0F, 0x00, 0x00,
+	  },
+	 {			/*  Init_CR00_CR18 */
+	  0xA3, 0x7F, 0x7F, 0x00, 0x85, 0x16, 0x24, 0xF5,
+	  0x00, 0x60, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	  0x03, 0x09, 0xFF, 0x80, 0x40, 0xFF, 0x00, 0xE3,
+	  0xFF,
+	  },
+	 {			/*  Init_CR30_CR4D */
+	  0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x02, 0x20,
+	  0x00, 0x00, 0x00, 0x40, 0x00, 0xFF, 0xBF, 0xFF,
+	  0xA3, 0x7F, 0x00, 0x86, 0x15, 0x24, 0xFF, 0x00,
+	  0x01, 0x07, 0xE5, 0x20, 0x7F, 0xFF,
+	  },
+	 {			/*  Init_CR90_CRA7 */
+	  0x55, 0xD9, 0x5D, 0xE1, 0x86, 0x1B, 0x8E, 0x26,
+	  0xDA, 0x8D, 0xDE, 0x94, 0x00, 0x00, 0x18, 0x00,
+	  0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x15, 0x03,
+	  },
+	 },
+	{			/*  mode#6: 320 x 240  16Bpp  60Hz */
+	 320, 240, 16, 60,
+	 /*  Init_MISC */
+	 0xEB,
+	 {			/*  Init_SR0_SR4 */
+	  0x03, 0x01, 0x0F, 0x03, 0x0E,
+	  },
+	 {			/*  Init_SR10_SR24 */
+	  0xF3, 0xB6, 0xC0, 0xDD, 0x00, 0x0E, 0x17, 0x2C,
+	  0x99, 0x02, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00,
+	  0xC4, 0x32, 0x02, 0x01, 0x01,
+	  },
+	 {			/*  Init_SR30_SR75 */
+	  0x38, 0x03, 0x20, 0x09, 0xC0, 0x3A, 0x3A, 0x3A,
+	  0x3A, 0x3A, 0x3A, 0x3A, 0x00, 0x00, 0x03, 0xFF,
+	  0x00, 0xFC, 0x00, 0x00, 0x20, 0x18, 0x00, 0xFC,
+	  0x20, 0x0C, 0x44, 0x20, 0x00, 0x00, 0x00, 0x3A,
+	  0x06, 0x68, 0xA7, 0x7F, 0x83, 0x24, 0xFF, 0x03,
+	  0x00, 0x60, 0x59, 0x3A, 0x3A, 0x00, 0x00, 0x3A,
+	  0x01, 0x80, 0x7E, 0x1A, 0x1A, 0x00, 0x00, 0x00,
+	  0x50, 0x03, 0x74, 0x14, 0x08, 0x43, 0x08, 0x43,
+	  0x04, 0x45, 0x30, 0x30, 0x40, 0x20,
+	  },
+	 {			/*  Init_SR80_SR93 */
+	  0xFF, 0x07, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0x3A,
+	  0xF7, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0x3A, 0x3A,
+	  0x00, 0x00, 0x00, 0x00,
+	  },
+	 {			/*  Init_SRA0_SRAF */
+	  0x00, 0xFB, 0x9F, 0x01, 0x00, 0xED, 0xED, 0xED,
+	  0x7B, 0xFB, 0xFF, 0xFF, 0x97, 0xEF, 0xBF, 0xDF,
+	  },
+	 {			/*  Init_GR00_GR08 */
+	  0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x05, 0x0F,
+	  0xFF,
+	  },
+	 {			/*  Init_AR00_AR14 */
+	  0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
+	  0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
+	  0x41, 0x00, 0x0F, 0x00, 0x00,
+	  },
+	 {			/*  Init_CR00_CR18 */
+	  0xA3, 0x7F, 0x7F, 0x00, 0x85, 0x16, 0x24, 0xF5,
+	  0x00, 0x60, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	  0x03, 0x09, 0xFF, 0x80, 0x40, 0xFF, 0x00, 0xE3,
+	  0xFF,
+	  },
+	 {			/*  Init_CR30_CR4D */
+	  0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x02, 0x20,
+	  0x00, 0x00, 0x30, 0x40, 0x00, 0xFF, 0xBF, 0xFF,
+	  0x2E, 0x27, 0x00, 0x2b, 0x0c, 0x0F, 0xEF, 0x00,
+	  0xFe, 0x0f, 0x01, 0xC0, 0x27, 0xEF,
+	  },
+	 {			/*  Init_CR90_CRA7 */
+	  0x55, 0xD9, 0x5D, 0xE1, 0x86, 0x1B, 0x8E, 0x26,
+	  0xDA, 0x8D, 0xDE, 0x94, 0x00, 0x00, 0x18, 0x00,
+	  0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x15, 0x03,
+	  },
+	 },
+
+	{			/*  mode#8: 320 x 240  32Bpp  60Hz */
+	 320, 240, 32, 60,
+	 /*  Init_MISC */
+	 0xEB,
+	 {			/*  Init_SR0_SR4 */
+	  0x03, 0x01, 0x0F, 0x03, 0x0E,
+	  },
+	 {			/*  Init_SR10_SR24 */
+	  0xF3, 0xB6, 0xC0, 0xDD, 0x00, 0x0E, 0x17, 0x2C,
+	  0x99, 0x02, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00,
+	  0xC4, 0x32, 0x02, 0x01, 0x01,
+	  },
+	 {			/*  Init_SR30_SR75 */
+	  0x38, 0x03, 0x20, 0x09, 0xC0, 0x3A, 0x3A, 0x3A,
+	  0x3A, 0x3A, 0x3A, 0x3A, 0x00, 0x00, 0x03, 0xFF,
+	  0x00, 0xFC, 0x00, 0x00, 0x20, 0x18, 0x00, 0xFC,
+	  0x20, 0x0C, 0x44, 0x20, 0x00, 0x00, 0x00, 0x3A,
+	  0x06, 0x68, 0xA7, 0x7F, 0x83, 0x24, 0xFF, 0x03,
+	  0x00, 0x60, 0x59, 0x3A, 0x3A, 0x00, 0x00, 0x3A,
+	  0x01, 0x80, 0x7E, 0x1A, 0x1A, 0x00, 0x00, 0x00,
+	  0x50, 0x03, 0x74, 0x14, 0x08, 0x43, 0x08, 0x43,
+	  0x04, 0x45, 0x30, 0x30, 0x40, 0x20,
+	  },
+	 {			/*  Init_SR80_SR93 */
+	  0xFF, 0x07, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0x3A,
+	  0xF7, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0x3A, 0x3A,
+	  0x00, 0x00, 0x00, 0x00,
+	  },
+	 {			/*  Init_SRA0_SRAF */
+	  0x00, 0xFB, 0x9F, 0x01, 0x00, 0xED, 0xED, 0xED,
+	  0x7B, 0xFB, 0xFF, 0xFF, 0x97, 0xEF, 0xBF, 0xDF,
+	  },
+	 {			/*  Init_GR00_GR08 */
+	  0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x05, 0x0F,
+	  0xFF,
+	  },
+	 {			/*  Init_AR00_AR14 */
+	  0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
+	  0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
+	  0x41, 0x00, 0x0F, 0x00, 0x00,
+	  },
+	 {			/*  Init_CR00_CR18 */
+	  0xA3, 0x7F, 0x7F, 0x00, 0x85, 0x16, 0x24, 0xF5,
+	  0x00, 0x60, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	  0x03, 0x09, 0xFF, 0x80, 0x40, 0xFF, 0x00, 0xE3,
+	  0xFF,
+	  },
+	 {			/*  Init_CR30_CR4D */
+	  0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x02, 0x20,
+	  0x00, 0x00, 0x30, 0x40, 0x00, 0xFF, 0xBF, 0xFF,
+	  0x2E, 0x27, 0x00, 0x2b, 0x0c, 0x0F, 0xEF, 0x00,
+	  0xFe, 0x0f, 0x01, 0xC0, 0x27, 0xEF,
+	  },
+	 {			/*  Init_CR90_CRA7 */
+	  0x55, 0xD9, 0x5D, 0xE1, 0x86, 0x1B, 0x8E, 0x26,
+	  0xDA, 0x8D, 0xDE, 0x94, 0x00, 0x00, 0x18, 0x00,
+	  0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x15, 0x03,
+	  },
+	 },
+};
+
+#define numVGAModes		(sizeof(VGAMode) / sizeof(struct ModeInit))
-- 
1.6.0.4
