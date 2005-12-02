Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Dec 2005 18:55:59 +0000 (GMT)
Received: from amdext3.amd.com ([139.95.251.6]:49116 "EHLO amdext3.amd.com")
	by ftp.linux-mips.org with ESMTP id S8133871AbVLBSzc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 2 Dec 2005 18:55:32 +0000
Received: from SSVLGW02.amd.com (ssvlgw02.amd.com [139.95.250.170])
	by amdext3.amd.com (8.12.11/8.12.11/AMD) with ESMTP id jB2Iwl12009988;
	Fri, 2 Dec 2005 10:59:07 -0800
Received: from 139.95.250.1 by SSVLGW02.amd.com with ESMTP (AMD SMTP
 Relay (Email Firewall v6.1.0)); Fri, 02 Dec 2005 10:58:50 -0800
X-Server-Uuid: 519AC16A-9632-469E-B354-112C592D09E8
Received: from ldcmail.amd.com (ldcmail.amd.com [147.5.200.40]) by
 amdint.amd.com (8.12.8/8.12.8/AMD) with ESMTP id jB2IwnQe022259; Fri, 2
 Dec 2005 10:58:49 -0800 (PST)
Received: from cosmic.amd.com (cosmic.amd.com [147.5.201.206]) by
 ldcmail.amd.com (Postfix) with ESMTP id DAF6B2026; Fri, 2 Dec 2005
 11:58:48 -0700 (MST)
Received: from cosmic.amd.com (localhost [127.0.0.1]) by cosmic.amd.com
 (8.13.4/8.13.4) with ESMTP id jB2J6aZW031451; Fri, 2 Dec 2005 12:06:36
 -0700
Received: (from jcrouse@localhost) by cosmic.amd.com (
 8.13.4/8.13.4/Submit) id jB2J6Zl5031450; Fri, 2 Dec 2005 12:06:35 -0700
Date:	Fri, 2 Dec 2005 12:06:35 -0700
From:	"Jordan Crouse" <jordan.crouse@amd.com>
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
Subject: [PATCH] ALCHEMY:  Alchemy Camera Interface (CIM) driver
Message-ID: <20051202190635.GI28227@cosmic.amd.com>
MIME-Version: 1.0
User-Agent: Mutt/1.5.11
X-WSS-ID: 6F8E46E01IW1436034-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <jcrouse@cosmic.amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9580
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jordan.crouse@amd.com
Precedence: bulk
X-list: linux-mips

A driver for the AU1200 Camera Interface (CIM).  Definately 
should be postponed post 2.6.15.  This is the most complex one
I'm sending up right now, so comments and flames are definately
welcome.

Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
---

 drivers/Makefile                          |    2 
 drivers/char/Kconfig                      |    4 
 drivers/char/Makefile                     |    1 
 drivers/char/au1xxx_cameras.h             |  572 ++++++++++++++++++++++++++
 drivers/char/au1xxx_cim.c                 |  647 +++++++++++++++++++++++++++++
 include/asm-mips/mach-au1x00/au1xxx_cim.h |  190 +++++++++
 6 files changed, 1415 insertions(+), 1 deletions(-)

diff --git a/drivers/Makefile b/drivers/Makefile
index fac1e16..7ab1608 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_PNP)		+= pnp/
 
 # char/ comes before serial/ etc so that the VT console is the boot-time
 # default.
+obj-$(CONFIG_I2C)               += i2c/
 obj-y				+= char/
 
 obj-$(CONFIG_CONNECTOR)		+= connector/
@@ -53,7 +54,6 @@ obj-$(CONFIG_USB_GADGET)	+= usb/gadget/
 obj-$(CONFIG_GAMEPORT)		+= input/gameport/
 obj-$(CONFIG_INPUT)		+= input/
 obj-$(CONFIG_I2O)		+= message/
-obj-$(CONFIG_I2C)		+= i2c/
 obj-$(CONFIG_W1)		+= w1/
 obj-$(CONFIG_HWMON)		+= hwmon/
 obj-$(CONFIG_PHONE)		+= telephony/
diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 9424f62..2b0cf62 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -347,6 +347,10 @@ config AU1X00_USB_RAW
 	tristate "Au1000 USB Raw Device support"
 	depends on MIPS && MIPS_AU1000 && AU1000_USB_DEVICE=y && AU1000_USB_TTY!=y && AU1X00_USB_DEVICE
 
+config AU1XXX_CIM
+       tristate "Au1200 Camera Interface Module (CIM)"
+       depends on MIPS && SOC_AU1X00 && I2C_AU1550
+
 config SIBYTE_SB1250_DUART
 	bool "Support for BCM1xxx onchip DUART"
 	depends on MIPS && SIBYTE_SB1xxx_SOC=y
diff --git a/drivers/char/Makefile b/drivers/char/Makefile
index ecc5670..6629394 100644
--- a/drivers/char/Makefile
+++ b/drivers/char/Makefile
@@ -82,6 +82,7 @@ obj-$(CONFIG_ITE_GPIO) += ite_gpio.o
 obj-$(CONFIG_AU1000_GPIO) += au1000_gpio.o
 obj-$(CONFIG_AU1000_USB_TTY) += au1000_usbtty.o
 obj-$(CONFIG_AU1000_USB_RAW) += au1000_usbraw.o
+obj-$(CONFIG_AU1XXX_CIM) += au1xxx_cim.o
 obj-$(CONFIG_PPDEV) += ppdev.o
 obj-$(CONFIG_NWBUTTON) += nwbutton.o
 obj-$(CONFIG_NWFLASH) += nwflash.o
diff --git a/drivers/char/au1xxx_cameras.h b/drivers/char/au1xxx_cameras.h
new file mode 100644
index 0000000..3ecfa30
--- /dev/null
+++ b/drivers/char/au1xxx_cameras.h
@@ -0,0 +1,572 @@
+#ifndef AU1XXX_CAMERAS_H_
+#define AU1XXX_CAMERAS_H_
+
+/* List of cameras to be used with the AU1XXX Camera interface
+   Copyright 2005, Advanced Micro Devices, Inc.
+
+   This software may be used and distributed according to the terms
+   of the GNU General Public License, incorporated herein by reference.
+*/
+
+
+typedef struct cim_cmos_camera_config {
+	uint32_t frame_width;	       /* Frame Width (Pixel per Line) */
+	uint32_t frame_height;	       /* Frame Height */
+	unsigned char camera_name[32]; /* Camera Name (Display/Debug) */
+	unsigned char camera_mode[32]; /* Camera Mode(Display/Debug) */
+	uint32_t cmos_output_format;   /* CMOS Camera output */
+	uint32_t camera_resformat;     /* Camera Mode(Display/Debug) */
+	uint32_t au1200_dpsmode;       /* Data Pattern Select */
+	uint32_t au1200_baymode;       /* Mode within BAYER mode */
+	uint32_t dbdma_channel;	       /* Number of channels to be used */
+	u8 device_addr;		       /* Camera Device address */
+	uint32_t cmd_size;	       /* Number of device sub register */
+	u8 config_cmd[MAX_DEVICE_CMD][2]; /* Sub device address and values */
+} CAMERA;
+
+
+
+static CAMERA au1xxx_cameras[] = {
+	/* Omnivision OV9640 Camera 1280x960 Mode (SXGA) in "Pass Thru Mode"
+	   1.3 MP at 15 Fps
+	*/
+
+	{  1280, 960, "omnivision", "raw_SXGA", CMOS_RAW,
+	   RAW_SXGA, CIM_CONFIG_RAW, CIM_CONFIG_BGGR,
+	   1, 0x30, 50,
+	   {
+		   {0x12, 0x80}, {0x12, 0x05}, {0x11, 0x80},
+		   {0x3b, 0x00}, {0x33, 0x02},
+		   {0x37, 0x02}, {0x38, 0x13}, {0x39, 0xf0},
+		   {0x6c, 0x40}, {0x6d, 0x30},
+		   {0x6e, 0x4b}, {0x6f, 0x60}, {0x70, 0x70},
+		   {0x71, 0x70}, {0x74, 0x60},
+		   {0x75, 0x60}, {0x76, 0x50}, {0x77, 0x48},
+		   {0x78, 0x3a}, {0x79, 0x2e},
+		   {0x7a, 0x2a}, {0x7b, 0x22}, {0x7c, 0x04},
+		   {0x7d, 0x07}, {0x7e, 0x10},
+		   {0x7f, 0x28}, {0x80, 0x36}, {0x81, 0x44},
+		   {0x82, 0x52}, {0x83, 0x60},
+		   {0x84, 0x6c}, {0x85, 0x78}, {0x86, 0x8c},
+		   {0x87, 0x9e}, {0x88, 0xbb},
+		   {0x89, 0xd2}, {0x8a, 0xe6}, {0x0f, 0x4f},
+		   {0x3c, 0x40}, {0x14, 0xca},
+		   {0x42, 0x89}, {0x24, 0x78}, {0x25, 0x68},
+		   {0x26, 0xd4}, {0x27, 0x90},
+		   {0x2a, 0x00}, {0x2b, 0x00}, {0x3d, 0x80},
+		   {0x41, 0x00}, {0x60, 0x8d},
+	   }
+	},
+
+	/* Omnivision OV9640 Camera 640x480 Mode (VGA) in "Pass Through Mode" */
+	{  640, 480, "omnivision", "raw_VGA", CMOS_RAW,
+	   RAW_VGA,CIM_CONFIG_RAW,CIM_CONFIG_BGGR,
+	   1, 0x30, 54,
+	   {
+		   {0x12, 0x80}, {0x12, 0x45}, {0x11, 0x81},
+		   {0x0c, 0x04}, {0x0d, 0x40}, {0x3b, 0x00},
+		   {0x33, 0x02},
+		   {0x37, 0x02}, {0x38, 0x13}, {0x39, 0xf0},
+		   {0x6c, 0x40}, {0x6d, 0x30},
+		   {0x6e, 0x4b}, {0x6f, 0x60}, {0x70, 0x70},
+		   {0x71, 0x70}, {0x72, 0x70}, {0x73, 0x70},
+		   {0x74, 0x60},
+		   {0x75, 0x60}, {0x76, 0x50}, {0x77, 0x48},
+		   {0x78, 0x3a}, {0x79, 0x2e},
+		   {0x7a, 0x28}, {0x7b, 0x22}, {0x7c, 0x04},
+		   {0x7d, 0x07}, {0x7e, 0x2e},
+		   {0x7f, 0x28}, {0x80, 0x36}, {0x81, 0x44},
+		   {0x82, 0x52}, {0x83, 0x60},
+		   {0x84, 0x6c}, {0x85, 0x78}, {0x86, 0x8c},
+		   {0x87, 0x9e}, {0x88, 0xbb},
+		   {0x89, 0xd2}, {0x8a, 0xe6}, {0x0f, 0x4f},
+		   {0x3c, 0x40}, {0x14, 0xca},
+		   {0x42, 0x89}, {0x24, 0x78}, {0x25, 0x68},
+		   {0x26, 0xd4}, {0x27, 0x90},
+		   {0x2a, 0x00}, {0x2b, 0x00}, {0x3d, 0x80},
+		   {0x41, 0x00}, {0x60, 0x8d},
+	   }
+	},
+
+	/* Omnivision OV9640 Camera 352x288 Mode CIF "Pass Through Mode" */
+	{  352, 288, "omnivision", "raw_CIF", CMOS_RAW,
+	   RAW_CIF, CIM_CONFIG_RAW, CIM_CONFIG_BGGR,
+	   1, 0x30, 54,
+	   {
+		   {0x12, 0x80}, {0x12, 0x25}, {0x11, 0x80},
+		   {0x0c, 0x04}, {0x0d, 0x40}, {0x3b, 0x00},
+		   {0x33, 0x02},
+		   {0x37, 0x02}, {0x38, 0x13}, {0x39, 0xf0},
+		   {0x6c, 0x40}, {0x6d, 0x30},
+		   {0x6e, 0x4b}, {0x6f, 0x60}, {0x70, 0x70},
+		   {0x71, 0x70}, {0x72, 0x70}, {0x73, 0x70},
+		   {0x74, 0x60},
+		   {0x75, 0x60}, {0x76, 0x50}, {0x77, 0x48},
+		   {0x78, 0x3a}, {0x79, 0x2e},
+		   {0x7a, 0x28}, {0x7b, 0x22}, {0x7c, 0x04},
+		   {0x7d, 0x07}, {0x7e, 0x10},
+		   {0x7f, 0x28}, {0x80, 0x36}, {0x81, 0x44},
+		   {0x82, 0x52}, {0x83, 0x60},
+		   {0x84, 0x6c}, {0x85, 0x78}, {0x86, 0x8c},
+		   {0x87, 0x9e}, {0x88, 0xbb},
+		   {0x89, 0xd2}, {0x8a, 0xe6}, {0x0f, 0x4f},
+		   {0x3c, 0x40}, {0x14, 0xca},
+		   {0x42, 0x89}, {0x24, 0x78}, {0x25, 0x68},
+		   {0x26, 0xd4}, {0x27, 0x90},
+		   {0x2a, 0x00}, {0x2b, 0x00}, {0x3d, 0x80},
+		   {0x41, 0x00}, {0x60, 0x8d},
+		}
+
+	},
+
+	/* Omnivision OV9640 Camera 320x240 Mode (QVGA) in "Pass Through Mode" */
+	{ 320, 240, "omnivision", "raw_QVGA", CMOS_RAW,
+	  RAW_QVGA, CIM_CONFIG_RAW, CIM_CONFIG_BGGR,
+	  1, 0x30, 54,
+	  {
+		  {0x12, 0x80}, {0x12, 0x15}, {0x11, 0x83},
+		  {0x0c, 0x04}, {0x0d, 0xc0}, {0x3b, 0x00},
+		  {0x33, 0x02},
+		  {0x37, 0x02}, {0x38, 0x13}, {0x39, 0xf0},
+		  {0x6c, 0x40}, {0x6d, 0x30},
+		  {0x6e, 0x4b}, {0x6f, 0x60}, {0x70, 0x70},
+		  {0x71, 0x70}, {0x72, 0x70}, {0x73, 0x70},
+		  {0x74, 0x60},
+		  {0x75, 0x60}, {0x76, 0x50}, {0x77, 0x48},
+		  {0x78, 0x3a}, {0x79, 0x2e},
+		  {0x7a, 0x28}, {0x7b, 0x22}, {0x7c, 0x04},
+		  {0x7d, 0x07}, {0x7e, 0x10},
+		  {0x7f, 0x28}, {0x80, 0x36}, {0x81, 0x44},
+		  {0x82, 0x52}, {0x83, 0x60},
+		  {0x84, 0x6c}, {0x85, 0x78}, {0x86, 0x8c},
+		  {0x87, 0x9e}, {0x88, 0xbb},
+		  {0x89, 0xd2}, {0x8a, 0xe6}, {0x0f, 0x4f},
+		  {0x3c, 0x40}, {0x14, 0xca},
+		  {0x42, 0x89}, {0x24, 0x78}, {0x25, 0x68},
+		  {0x26, 0xd4}, {0x27, 0x90},
+		  {0x2a, 0x00}, {0x2b, 0x00}, {0x3d, 0x80},
+		  {0x41, 0x00}, {0x60, 0x8d},
+	  }
+	},
+
+	/* Omnivision OV9640 Camera 176x144 QCIF Mode "Pass Through Mode" */
+	{ 176, 144, "omnivision", "raw_QCIF", CMOS_RAW,
+	  RAW_QCIF, CIM_CONFIG_RAW, CIM_CONFIG_BGGR,
+	  1, 0x30, 54,
+	  {
+		  {0x12, 0x80}, {0x12, 0x0D}, {0x11, 0x80},
+		  {0x0c, 0x04}, {0x0d, 0xc0}, {0x3b, 0x00},
+		  {0x33, 0x02},
+		  {0x37, 0x02}, {0x38, 0x13}, {0x39, 0xf0},
+		  {0x6c, 0x40}, {0x6d, 0x30},
+		  {0x6e, 0x4b}, {0x6f, 0x60}, {0x70, 0x70},
+		  {0x71, 0x70}, {0x72, 0x70}, {0x73, 0x70},
+		  {0x74, 0x60},
+		  {0x75, 0x60}, {0x76, 0x50}, {0x77, 0x48},
+		  {0x78, 0x3a}, {0x79, 0x2e},
+		  {0x7a, 0x28}, {0x7b, 0x22}, {0x7c, 0x04},
+		  {0x7d, 0x07}, {0x7e, 0x10},
+		  {0x7f, 0x28}, {0x80, 0x36}, {0x81, 0x44},
+		  {0x82, 0x52}, {0x83, 0x60},
+		  {0x84, 0x6c}, {0x85, 0x78}, {0x86, 0x8c},
+		  {0x87, 0x9e}, {0x88, 0xbb},
+		  {0x89, 0xd2}, {0x8a, 0xe6}, {0x0f, 0x6f},
+		  {0x3c, 0x60}, {0x14, 0xca},
+		  {0x42, 0x89}, {0x24, 0x78}, {0x25, 0x68},
+		  {0x26, 0xd4}, {0x27, 0x90},
+		  {0x2a, 0x00}, {0x2b, 0x00}, {0x3d, 0x80},
+		  {0x41, 0x00}, {0x60, 0x8d},
+	  }
+	},
+
+
+	/* Omnivision OV9640 Camera 1280x960 Mode (SXGA) in BAYER Mode (Planar) */
+	{  1280, 960, "omnivision", "bayer_SXGA", CMOS_RAW,
+	   BAYER_SXGA, CIM_CONFIG_BAYER, CIM_CONFIG_BGGR,
+	   3, 0x30, 50,
+	   {
+		   {0x12, 0x80}, {0x12, 0x05}, {0x11, 0x80},
+		   {0x3b, 0x00}, {0x33, 0x02},
+		   {0x37, 0x02}, {0x38, 0x13}, {0x39, 0xf0},
+		   {0x6c, 0x40}, {0x6d, 0x30},
+		   {0x6e, 0x4b}, {0x6f, 0x60}, {0x70, 0x70},
+		   {0x71, 0x70}, {0x74, 0x60},
+		   {0x75, 0x60}, {0x76, 0x50}, {0x77, 0x48},
+		   {0x78, 0x3a}, {0x79, 0x2e},
+		   {0x7a, 0x2a}, {0x7b, 0x22}, {0x7c, 0x04},
+		   {0x7d, 0x07}, {0x7e, 0x10},
+		   {0x7f, 0x28}, {0x80, 0x36}, {0x81, 0x44},
+		   {0x82, 0x52}, {0x83, 0x60},
+		   {0x84, 0x6c}, {0x85, 0x78}, {0x86, 0x8c},
+		   {0x87, 0x9e}, {0x88, 0xbb},
+		   {0x89, 0xd2}, {0x8a, 0xe6}, {0x0f, 0x4f},
+		   {0x3c, 0x40}, {0x14, 0xca},
+		   {0x42, 0x89}, {0x24, 0x78}, {0x25, 0x68},
+		   {0x26, 0xd4}, {0x27, 0x90},
+		   {0x2a, 0x00}, {0x2b, 0x00}, {0x3d, 0x80},
+		   {0x41, 0x00}, {0x60, 0x8d},
+		}
+	},
+
+	/* Omnivision OV9640 Camera 640x480 Mode (VGA) in BAYER Mode (Planar) */
+	{  640, 480, "omnivision", "bayer_VGA", CMOS_RAW,
+	   BAYER_VGA, CIM_CONFIG_BAYER, CIM_CONFIG_BGGR,
+	   3, 0x30, 54,
+	   {
+		   {0x12, 0x80}, {0x12, 0x45}, {0x11, 0x81},
+		   {0x0c, 0x04}, {0x0d, 0x40}, {0x3b, 0x00},
+		   {0x33, 0x02},
+		   {0x37, 0x02}, {0x38, 0x13}, {0x39, 0xf0},
+		   {0x6c, 0x40}, {0x6d, 0x30},
+		   {0x6e, 0x4b}, {0x6f, 0x60}, {0x70, 0x70},
+		   {0x71, 0x70}, {0x72, 0x70}, {0x73, 0x70},
+		   {0x74, 0x60},
+		   {0x75, 0x60}, {0x76, 0x50}, {0x77, 0x48},
+		   {0x78, 0x3a}, {0x79, 0x2e},
+		   {0x7a, 0x28}, {0x7b, 0x22}, {0x7c, 0x04},
+		   {0x7d, 0x07}, {0x7e, 0x2e},
+		   {0x7f, 0x28}, {0x80, 0x36}, {0x81, 0x44},
+		   {0x82, 0x52}, {0x83, 0x60},
+		   {0x84, 0x6c}, {0x85, 0x78}, {0x86, 0x8c},
+		   {0x87, 0x9e}, {0x88, 0xbb},
+		   {0x89, 0xd2}, {0x8a, 0xe6}, {0x0f, 0x4f},
+		   {0x3c, 0x40}, {0x14, 0xca},
+		   {0x42, 0x89}, {0x24, 0x78}, {0x25, 0x68},
+		   {0x26, 0xd4}, {0x27, 0x90},
+		   {0x2a, 0x00}, {0x2b, 0x00}, {0x3d, 0x80},
+		   {0x41, 0x00}, {0x60, 0x8d},
+		}
+	},
+
+	/* Omnivision OV9640 Camera 352x288 CIF Mode in BAYER Mode (Planar) */
+	{  352, 288, "omnivision", "bayer_CIF", CMOS_RAW,
+	   BAYER_CIF, CIM_CONFIG_BAYER, CIM_CONFIG_BGGR,
+	   3, 0x30, 54,
+	   {
+		   {0x12, 0x80}, {0x12, 0x25}, {0x11, 0x80},
+		   {0x0c, 0x04}, {0x0d, 0x40}, {0x3b, 0x00},
+		   {0x33, 0x02},
+		   {0x37, 0x02}, {0x38, 0x13}, {0x39, 0xf0},
+		   {0x6c, 0x40}, {0x6d, 0x30},
+		   {0x6e, 0x4b}, {0x6f, 0x60}, {0x70, 0x70},
+		   {0x71, 0x70}, {0x72, 0x70}, {0x73, 0x70},
+		   {0x74, 0x60},
+		   {0x75, 0x60}, {0x76, 0x50}, {0x77, 0x48},
+		   {0x78, 0x3a}, {0x79, 0x2e},
+		   {0x7a, 0x28}, {0x7b, 0x22}, {0x7c, 0x04},
+		   {0x7d, 0x07}, {0x7e, 0x10},
+		   {0x7f, 0x28}, {0x80, 0x36}, {0x81, 0x44},
+		   {0x82, 0x52}, {0x83, 0x60},
+		   {0x84, 0x6c}, {0x85, 0x78}, {0x86, 0x8c},
+		   {0x87, 0x9e}, {0x88, 0xbb},
+		   {0x89, 0xd2}, {0x8a, 0xe6}, {0x0f, 0x4f},
+		   {0x3c, 0x40}, {0x14, 0xca},
+		   {0x42, 0x89}, {0x24, 0x78}, {0x25, 0x68},
+		   {0x26, 0xd4}, {0x27, 0x90},
+		   {0x2a, 0x00}, {0x2b, 0x00}, {0x3d, 0x80},
+		   {0x41, 0x00}, {0x60, 0x8d},
+		}
+	},
+
+	/* Omnivision OV9640 Camera 320x240 Mode (QVGA) in BAYER Mode (Planar) */
+	{  320, 240, "omnivision", "bayer_QVGA", CMOS_RAW,
+	   BAYER_QVGA, CIM_CONFIG_BAYER, CIM_CONFIG_BGGR,
+	   3, 0x30, 54,
+	   {
+		   {0x12, 0x80}, {0x12, 0x15}, {0x11, 0x83},
+		   {0x0c, 0x04}, {0x0d, 0xc0}, {0x3b, 0x00},
+		   {0x33, 0x02},
+		   {0x37, 0x02}, {0x38, 0x13}, {0x39, 0xf0},
+		   {0x6c, 0x40}, {0x6d, 0x30},
+		   {0x6e, 0x4b}, {0x6f, 0x60}, {0x70, 0x70},
+		   {0x71, 0x70}, {0x72, 0x70}, {0x73, 0x70},
+		   {0x74, 0x60},
+		   {0x75, 0x60}, {0x76, 0x50}, {0x77, 0x48},
+		   {0x78, 0x3a}, {0x79, 0x2e},
+		   {0x7a, 0x28}, {0x7b, 0x22}, {0x7c, 0x04},
+		   {0x7d, 0x07}, {0x7e, 0x10},
+		   {0x7f, 0x28}, {0x80, 0x36}, {0x81, 0x44},
+		   {0x82, 0x52}, {0x83, 0x60},
+		   {0x84, 0x6c}, {0x85, 0x78}, {0x86, 0x8c},
+		   {0x87, 0x9e}, {0x88, 0xbb},
+		   {0x89, 0xd2}, {0x8a, 0xe6}, {0x0f, 0x4f},
+		   {0x3c, 0x40}, {0x14, 0xca},
+		   {0x42, 0x89}, {0x24, 0x78}, {0x25, 0x68},
+		   {0x26, 0xd4}, {0x27, 0x90},
+		   {0x2a, 0x00}, {0x2b, 0x00}, {0x3d, 0x80},
+		   {0x41, 0x00}, {0x60, 0x8d},
+		}
+	},
+
+	/* Omnivision OV9640 Camera 640x480 Mode (QCIF) in BAYER Mode (Planar) */
+	{  176, 144, "omnivision", "bayer_QCIF", CMOS_RAW,
+	   BAYER_QCIF, CIM_CONFIG_BAYER, CIM_CONFIG_BGGR,
+	   3, 0x30, 54,
+	   {
+		   {0x12, 0x80}, {0x12, 0x0D}, {0x11, 0x80},
+		   {0x0c, 0x04}, {0x0d, 0xc0}, {0x3b, 0x00},
+		   {0x33, 0x02},
+		   {0x37, 0x02}, {0x38, 0x13}, {0x39, 0xf0},
+		   {0x6c, 0x40}, {0x6d, 0x30},
+		   {0x6e, 0x4b}, {0x6f, 0x60}, {0x70, 0x70},
+		   {0x71, 0x70}, {0x72, 0x70}, {0x73, 0x70},
+		   {0x74, 0x60},
+		   {0x75, 0x60}, {0x76, 0x50}, {0x77, 0x48},
+		   {0x78, 0x3a}, {0x79, 0x2e},
+		   {0x7a, 0x28}, {0x7b, 0x22}, {0x7c, 0x04},
+		   {0x7d, 0x07}, {0x7e, 0x10},
+		   {0x7f, 0x28}, {0x80, 0x36}, {0x81, 0x44},
+		   {0x82, 0x52}, {0x83, 0x60},
+		   {0x84, 0x6c}, {0x85, 0x78}, {0x86, 0x8c},
+		   {0x87, 0x9e}, {0x88, 0xbb},
+		   {0x89, 0xd2}, {0x8a, 0xe6}, {0x0f, 0x6f},
+		   {0x3c, 0x60}, {0x14, 0xca},
+		   {0x42, 0x89}, {0x24, 0x78}, {0x25, 0x68},
+		   {0x26, 0xd4}, {0x27, 0x90},
+		   {0x2a, 0x00}, {0x2b, 0x00}, {0x3d, 0x80},
+		   {0x41, 0x00}, {0x60, 0x8d},
+	   }
+	},
+
+	/* Omnivision OV9640 Camera 1280x960 Mode (SXGA) in YCbCr Camera pass Thru Mode */
+	{  1280, 960, "omnivision", "YCbCr_SXGA", CMOS_CCIR656,
+	   YCbCr_SXGA_RAW, CIM_CONFIG_RAW, CIM_CONFIG_BGGR,
+	   1, 0x30, 115,
+	   {
+		   {0x12, 0x80}, {0x11, 0x80}, {0x12, 0x00},
+		   {0x13, 0xA8}, {0x01, 0x80},
+		   {0x02, 0x80}, {0x04, 0x40}, {0x0C, 0x04},
+		   {0x0D, 0xC0}, {0x0E, 0x81},
+		   {0x0f, 0x4F}, {0x14, 0x4A}, {0x16, 0x02},
+		   {0x1B, 0x01}, {0x24, 0x70},
+		   {0x25, 0x68}, {0x26, 0xD3}, {0x27, 0x90},
+		   {0x2A, 0x00}, {0x2B, 0x00},
+		   {0x33, 0x28}, {0x37, 0x02}, {0x38, 0x13},
+		   {0x39, 0xF0}, {0x3A, 0x00},
+		   {0x3B, 0x01}, {0x3C, 0x46}, {0x3D, 0x90},
+		   {0x3E, 0x02}, {0x3F, 0xF2},
+		   {0x41, 0x02}, {0x42, 0xC9}, {0x43, 0xF0},
+		   {0x44, 0x10}, {0x45, 0x6C},
+		   {0x46, 0x6C}, {0x47, 0x44}, {0x48, 0x44},
+		   {0x49, 0x03}, {0x4F, 0x50},
+		   {0x50, 0x43}, {0x51, 0x0D}, {0x52, 0x19},
+		   {0x53, 0x4C}, {0x54, 0x65},
+		   {0x59, 0x49}, {0x5A, 0x94}, {0x5B, 0x46},
+		   {0x5C, 0x84}, {0x5D, 0x5C},
+		   {0x5E, 0x08}, {0x5F, 0x00}, {0x60, 0x14},
+		   {0x61, 0xCE}, {0x62, 0x70},
+		   {0x63, 0x00}, {0x64, 0x04}, {0x65, 0x00},
+		   {0x66, 0x00}, {0x69, 0x00},
+		   {0x6A, 0x3E}, {0x6B, 0x3F}, {0x6C, 0x40},
+		   {0x6D, 0x30}, {0x6E, 0x4B},
+		   {0x6F, 0x60}, {0x70, 0x70}, {0x71, 0x70},
+		   {0x72, 0x70}, {0x73, 0x70},
+		   {0x74, 0x70}, {0x75, 0x60}, {0x76, 0x50},
+		   {0x77, 0x48}, {0x78, 0x3A},
+		   {0x79, 0x2E}, {0x7A, 0x28}, {0x7B, 0x22},
+		   {0x7C, 0x04}, {0x7D, 0x07},
+		   {0x7E, 0x10}, {0x7F, 0x28}, {0x80, 0x36},
+		   {0x81, 0x44}, {0x82, 0x52},
+		   {0x83, 0x60}, {0x84, 0x6C}, {0x85, 0x78},
+		   {0x86, 0x8C}, {0x87, 0x9E},
+		   {0x88, 0xBB}, {0x89, 0xD2}, {0x8A, 0xE6},
+		   {0x13, 0xAF}, {0x13, 0x8D},
+		   {0x01, 0x80}, {0x02, 0x80}, {0x42, 0xC9},
+		   {0x16, 0x02}, {0x43, 0xF0},
+		   {0x44, 0x10}, {0x45, 0x20}, {0x46, 0x20},
+		   {0x47, 0x20}, {0x48, 0x20},
+		   {0x59, 0x17}, {0x5A, 0x71}, {0x5B, 0x56},
+		   {0x5C, 0x74}, {0x5D, 0x68},
+		   {0x5e, 0x10}, {0x5f, 0x00}, {0x60, 0x14},
+		   {0x61, 0xCE}, {0x13, 0x8F},
+	   }
+	},
+
+	/* Omnivision OV9640 Camera 640x480 Mode (SXGA) in YCbCr Camera pass Thru Mode */
+	{  640, 480, "omnivision", "YCbCr_VGA_raw", CMOS_CCIR656,
+	   YCbCr_VGA_RAW, CIM_CONFIG_RAW, CIM_CONFIG_BGGR,
+	   1, 0x30, 94,
+	   {
+		   {0x12, 0x80}, {0x11, 0x81}, {0x12, 0x40},
+		   {0x13, 0xA8}, {0x01, 0x80},
+		   {0x02, 0x80}, {0x04, 0x40}, {0x0C, 0x04},
+		   {0x0D, 0xC0}, {0x0E, 0x81},
+		   {0x0f, 0x4F}, {0x14, 0x4A}, {0x16, 0x02},
+		   {0x1B, 0x01}, {0x24, 0x70},
+		   {0x25, 0x68}, {0x26, 0xD3}, {0x27, 0x90},
+		   {0x2A, 0x00}, {0x2B, 0x00},
+		   {0x33, 0x02}, {0x37, 0x02}, {0x38, 0x13},
+		   {0x39, 0xF0}, {0x3A, 0x00},
+		   {0x3B, 0x01}, {0x3C, 0x46}, {0x3D, 0x90},
+		   {0x3E, 0x02}, {0x3F, 0xF2},
+		   {0x41, 0x02}, {0x42, 0xC9}, {0x43, 0xF0},
+		   {0x44, 0x10}, {0x45, 0x6C},
+		   {0x46, 0x6C}, {0x47, 0x44}, {0x48, 0x44},
+		   {0x49, 0x03}, {0x4F, 0x50},
+		   {0x50, 0x43}, {0x51, 0x0D}, {0x52, 0x19},
+		   {0x53, 0x4C}, {0x54, 0x65},
+		   {0x59, 0x49}, {0x5A, 0x94}, {0x5B, 0x46},
+		   {0x5C, 0x84}, {0x5D, 0x5C},
+		   {0x5E, 0x08}, {0x5F, 0x00}, {0x60, 0x14},
+		   {0x61, 0xCE}, {0x62, 0x70},
+		   {0x63, 0x00}, {0x64, 0x04}, {0x65, 0x00},
+		   {0x66, 0x00}, {0x69, 0x00},
+		   {0x6A, 0x3E}, {0x6B, 0x3F}, {0x6C, 0x40},
+		   {0x6D, 0x30}, {0x6E, 0x4B},
+		   {0x6F, 0x60}, {0x70, 0x70}, {0x71, 0x70},
+		   {0x72, 0x70}, {0x73, 0x70},
+		   {0x74, 0x60}, {0x75, 0x60}, {0x76, 0x50},
+		   {0x77, 0x48}, {0x78, 0x3A},
+		   {0x79, 0x2E}, {0x7A, 0x28}, {0x7B, 0x22},
+		   {0x7C, 0x04}, {0x7D, 0x07},
+		   {0x7E, 0x10}, {0x7F, 0x28}, {0x80, 0x36},
+		   {0x81, 0x44}, {0x82, 0x52},
+		   {0x83, 0x60}, {0x84, 0x6C}, {0x85, 0x78},
+		   {0x86, 0x8C}, {0x87, 0x9E},
+		   {0x88, 0xBB}, {0x89, 0xD2}, {0x8A, 0xE6},
+		   {0x13, 0xAF},
+	   }
+	},
+
+	/* Omnivision OV9640 Camera 352x288 Mode (CIF) in YCbCr Camera pass Thru Mode */
+	{  352, 288, "omnivision", "YCbCr_CIF_raw", CMOS_CCIR656,
+	   YCbCr_CIF_RAW, CIM_CONFIG_RAW, CIM_CONFIG_BGGR,
+	   1, 0x30, 94,
+	   {
+		   {0x12, 0x80}, {0x11, 0x81}, {0x12, 0x20},
+		   {0x13, 0xA8}, {0x01, 0x80},
+		   {0x02, 0x80}, {0x04, 0x40}, {0x0C, 0x04},
+		   {0x0D, 0xC0}, {0x0E, 0x81},
+		   {0x0f, 0x4F}, {0x14, 0x4A}, {0x16, 0x02},
+		   {0x1B, 0x01}, {0x24, 0x70},
+		   {0x25, 0x68}, {0x26, 0xD3}, {0x27, 0x90},
+		   {0x2A, 0x00}, {0x2B, 0x00},
+		   {0x33, 0x02}, {0x37, 0x02}, {0x38, 0x13},
+		   {0x39, 0xF0}, {0x3A, 0x00},
+		   {0x3B, 0x01}, {0x3C, 0x46}, {0x3D, 0x90},
+		   {0x3E, 0x02}, {0x3F, 0xF2},
+		   {0x41, 0x02}, {0x42, 0xC9}, {0x43, 0xF0},
+		   {0x44, 0x10}, {0x45, 0x6C},
+		   {0x46, 0x6C}, {0x47, 0x44}, {0x48, 0x44},
+		   {0x49, 0x03}, {0x4F, 0x50},
+		   {0x50, 0x43}, {0x51, 0x0D}, {0x52, 0x19},
+		   {0x53, 0x4C}, {0x54, 0x65},
+		   {0x59, 0x49}, {0x5A, 0x94}, {0x5B, 0x46},
+		   {0x5C, 0x84}, {0x5D, 0x5C},
+		   {0x5E, 0x08}, {0x5F, 0x00}, {0x60, 0x14},
+		   {0x61, 0xCE}, {0x62, 0x70},
+		   {0x63, 0x00}, {0x64, 0x04}, {0x65, 0x00},
+		   {0x66, 0x00}, {0x69, 0x00},
+		   {0x6A, 0x3E}, {0x6B, 0x3F}, {0x6C, 0x40},
+		   {0x6D, 0x30}, {0x6E, 0x4B},
+		   {0x6F, 0x60}, {0x70, 0x70}, {0x71, 0x70},
+		   {0x72, 0x70}, {0x73, 0x70},
+		   {0x74, 0x60}, {0x75, 0x60}, {0x76, 0x50},
+		   {0x77, 0x48}, {0x78, 0x3A},
+		   {0x79, 0x2E}, {0x7A, 0x28}, {0x7B, 0x22},
+		   {0x7C, 0x04}, {0x7D, 0x07},
+		   {0x7E, 0x10}, {0x7F, 0x28}, {0x80, 0x36},
+		   {0x81, 0x44}, {0x82, 0x52},
+		   {0x83, 0x60}, {0x84, 0x6C}, {0x85, 0x78},
+		   {0x86, 0x8C}, {0x87, 0x9E},
+		   {0x88, 0xBB}, {0x89, 0xD2}, {0x8A, 0xE6},
+		   {0x13, 0xAF},
+	   }
+	},
+
+	/* Omnivision OV9640 Camera 320x240 Mode QVGA in YCbCr Camera pass Thru Mode */
+	{ 320, 240, "omnivision", "YCbCr_QVGA_raw", CMOS_CCIR656,
+	  YCbCr_QVGA_RAW, CIM_CONFIG_RAW, CIM_CONFIG_BGGR,
+	  1, 0x30, 94,
+	  {
+		  {0x12, 0x80}, {0x11, 0x81}, {0x12, 0x10},
+		  {0x13, 0xA8}, {0x01, 0x80},
+		  {0x02, 0x80}, {0x04, 0x40}, {0x0C, 0x04},
+		  {0x0D, 0xC0}, {0x0E, 0x81},
+		  {0x0f, 0x4F}, {0x14, 0x4A}, {0x16, 0x02},
+		  {0x1B, 0x01}, {0x24, 0x70},
+		  {0x25, 0x68}, {0x26, 0xD3}, {0x27, 0x90},
+		  {0x2A, 0x00}, {0x2B, 0x00},
+		  {0x33, 0x02}, {0x37, 0x02}, {0x38, 0x13},
+		  {0x39, 0xF0}, {0x3A, 0x00},
+		  {0x3B, 0x01}, {0x3C, 0x46}, {0x3D, 0x90},
+		  {0x3E, 0x02}, {0x3F, 0xF2},
+		  {0x41, 0x02}, {0x42, 0xC9}, {0x43, 0xF0},
+		  {0x44, 0x10}, {0x45, 0x6C},
+		  {0x46, 0x6C}, {0x47, 0x44}, {0x48, 0x44},
+		  {0x49, 0x03}, {0x4F, 0x50},
+		  {0x50, 0x43}, {0x51, 0x0D}, {0x52, 0x19},
+		  {0x53, 0x4C}, {0x54, 0x65},
+		  {0x59, 0x49}, {0x5A, 0x94}, {0x5B, 0x46},
+		  {0x5C, 0x84}, {0x5D, 0x5C},
+		  {0x5E, 0x08}, {0x5F, 0x00}, {0x60, 0x14},
+		  {0x61, 0xCE}, {0x62, 0x70},
+		  {0x63, 0x00}, {0x64, 0x04}, {0x65, 0x00},
+		  {0x66, 0x00}, {0x69, 0x00},
+		  {0x6A, 0x3E}, {0x6B, 0x3F}, {0x6C, 0x40},
+		  {0x6D, 0x30}, {0x6E, 0x4B},
+		  {0x6F, 0x60}, {0x70, 0x70}, {0x71, 0x70},
+		  {0x72, 0x70}, {0x73, 0x70},
+		  {0x74, 0x60}, {0x75, 0x60}, {0x76, 0x50},
+		  {0x77, 0x48}, {0x78, 0x3A},
+		  {0x79, 0x2E}, {0x7A, 0x28}, {0x7B, 0x22},
+		  {0x7C, 0x04}, {0x7D, 0x07},
+		  {0x7E, 0x10}, {0x7F, 0x28}, {0x80, 0x36},
+		  {0x81, 0x44}, {0x82, 0x52},
+		  {0x83, 0x60}, {0x84, 0x6C}, {0x85, 0x78},
+		  {0x86, 0x8C}, {0x87, 0x9E},
+		  {0x88, 0xBB}, {0x89, 0xD2}, {0x8A, 0xE6},
+		  {0x13, 0xAF},
+	  }
+	},
+
+	/* Omnivision OV9640 Camera 176x144 Mode (QCIF) in YCbCr Camera pass Thru Mode */
+	{  176, 144, "omnivision", "YCbCr_QCIF_raw", CMOS_CCIR656,
+	   YCbCr_QCIF_RAW, CIM_CONFIG_RAW, CIM_CONFIG_BGGR,
+	   1, 0x30, 94,
+	   {
+		   {0x12, 0x80}, {0x11, 0x81}, {0x12, 0x08},
+		   {0x13, 0xA8}, {0x01, 0x80},
+		   {0x02, 0x80}, {0x04, 0x40}, {0x0C, 0x04},
+		   {0x0D, 0xC0}, {0x0E, 0x81},
+		   {0x0f, 0x4F}, {0x14, 0x4A}, {0x16, 0x02},
+		   {0x1B, 0x01}, {0x24, 0x70},
+		   {0x25, 0x68}, {0x26, 0xD3}, {0x27, 0x90},
+		   {0x2A, 0x00}, {0x2B, 0x00},
+		   {0x33, 0x02}, {0x37, 0x02}, {0x38, 0x13},
+		   {0x39, 0xF0}, {0x3A, 0x00},
+		   {0x3B, 0x01}, {0x3C, 0x46}, {0x3D, 0x90},
+		   {0x3E, 0x02}, {0x3F, 0xF2},
+		   {0x41, 0x02}, {0x42, 0xC9}, {0x43, 0xF0},
+		   {0x44, 0x10}, {0x45, 0x6C},
+		   {0x46, 0x6C}, {0x47, 0x44}, {0x48, 0x44},
+		   {0x49, 0x03}, {0x4F, 0x50},
+		   {0x50, 0x43}, {0x51, 0x0D}, {0x52, 0x19},
+		   {0x53, 0x4C}, {0x54, 0x65},
+		   {0x59, 0x49}, {0x5A, 0x94}, {0x5B, 0x46},
+		   {0x5C, 0x84}, {0x5D, 0x5C},
+		   {0x5E, 0x08}, {0x5F, 0x00}, {0x60, 0x14},
+		   {0x61, 0xCE}, {0x62, 0x70},
+		   {0x63, 0x00}, {0x64, 0x04}, {0x65, 0x00},
+		   {0x66, 0x00}, {0x69, 0x00},
+		   {0x6A, 0x3E}, {0x6B, 0x3F}, {0x6C, 0x40},
+		   {0x6D, 0x30}, {0x6E, 0x4B},
+		   {0x6F, 0x60}, {0x70, 0x70}, {0x71, 0x70},
+		   {0x72, 0x70}, {0x73, 0x70},
+		   {0x74, 0x60}, {0x75, 0x60}, {0x76, 0x50},
+		   {0x77, 0x48}, {0x78, 0x3A},
+		   {0x79, 0x2E}, {0x7A, 0x28}, {0x7B, 0x22},
+		   {0x7C, 0x04}, {0x7D, 0x07},
+		   {0x7E, 0x10}, {0x7F, 0x28}, {0x80, 0x36},
+		   {0x81, 0x44}, {0x82, 0x52},
+		   {0x83, 0x60}, {0x84, 0x6C}, {0x85, 0x78},
+		   {0x86, 0x8C}, {0x87, 0x9E},
+		   {0x88, 0xBB}, {0x89, 0xD2}, {0x8A, 0xE6},
+		   {0x13, 0xAF},
+	   }
+	}
+};
+
+#define CAMERA_COUNT (sizeof(au1xxx_cameras) / sizeof(au1xxx_cameras[0]))
+
+#endif
diff --git a/drivers/char/au1xxx_cim.c b/drivers/char/au1xxx_cim.c
new file mode 100644
index 0000000..0890986
--- /dev/null
+++ b/drivers/char/au1xxx_cim.c
@@ -0,0 +1,647 @@
+/*
+ *  Alchemy Camera Interface (CIM) driver
+ *
+ * Copyright 2004 Advanced Micro Devices, Inc
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ *  NO  EVENT  SHALL   THE AUTHOR  BE        LIABLE FOR ANY   DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/module.h>
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/miscdevice.h>
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/highmem.h>
+#include <linux/pagemap.h>
+#include <asm/uaccess.h>
+#include <asm/io.h>
+#include <asm/mach-au1x00/au1000.h>
+#include <asm/mach-au1x00/au1xxx_dbdma.h>
+#include <asm/irq.h>
+#include <asm/mach-au1x00/au1xxx_cim.h>
+#include <asm/mach-au1x00/au1xxx_psc.h>
+#include <asm/mman.h>
+
+#ifdef CONFIG_MIPS_PB1200
+#include <asm/mach-pb1x00/pb1200.h>
+#endif
+
+#ifdef CONFIG_MIPS_DB1200
+#include <asm/mach-db1x00/db1200.h>
+#endif
+
+/*
+  Camera Interface Driver will always work in DBDMA Mode.
+  PIO Mode will result in OverFlow Error
+*/
+
+/*
+ * Global Variables
+ */
+
+#define CIM_NAME               "au1xxx_cim"
+#define CIM_MAJOR              238
+#define VERSION                "1.2"
+
+/* Number of DMA channel used by CIM interface */
+#define MAX_DBDMA_CHANNEL       3
+
+/*Max Command Send over SMbus to configure external camera */
+#define MAX_DEVICE_CMD         115
+
+/* Number of descriptor used */
+#define NUM_DBDMA_DESCRIPTORS   1
+#define MAX_FRAME_SIZE          (1280*960)
+
+#undef DEBUG
+
+#ifdef DEBUG
+#define DPRINTK(fmt,args...) \
+printk(KERN_DEBUG "%s: " fmt,__FUNCTION__, ## args)
+#else
+#define DPRINTK(fmt, args...)
+#endif
+
+static uint32_t nInterruptDoneNumber;
+static uint32_t ciminterruptcheck;
+static uint32_t prev_mode;
+static uint32_t DBDMA_SourceID[] =
+    { DSCR_CMD0_CIM_RXA, DSCR_CMD0_CIM_RXB, DSCR_CMD0_CIM_RXC };
+static void *mem_buf;
+
+extern int pb1550_wm_codec_write(u8, u8, u8);
+
+static volatile AU1200_CIM *au1200_cim = (AU1200_CIM *) CIM_BASE_ADDRESS;
+
+/* Get the array of camera modes */
+#include "au1xxx_cameras.h"
+
+typedef struct cim_camera_runtime {
+	chan_tab_t **ChannelArray[MAX_DBDMA_CHANNEL];
+	void *memory[MAX_DBDMA_CHANNEL]	;
+	uint32_t nTransferSize[MAX_DBDMA_CHANNEL];
+	CAMERA *cmos_camera;
+} CAMERA_RUNTIME;
+
+static CAMERA_RUNTIME cam_base;
+static CAMERA *OrigCimArryPtr = au1xxx_cameras;
+
+static int
+find_mode_index(uint32_t res_format)
+{
+	int i;
+	CAMERA_RUNTIME *findex;
+
+	findex = &cam_base;
+	findex->cmos_camera = OrigCimArryPtr;
+
+	for (i = 0; i < CAMERA_COUNT; i++) {
+		if (res_format == (findex->cmos_camera->camera_resformat)) {
+
+			return i;
+		}
+		(findex->cmos_camera)++;
+	}
+	printk(KERN_ERR " Au1xxx_CIM: ERROR: Camera Index Failed \n");
+	return -1;
+}
+
+static void
+Cim_DDMA_Done_Interrupt(int irq, void *param, struct pt_regs *regs)
+{
+	nInterruptDoneNumber++;
+}
+
+static int
+Capture_Image(void)
+{
+	au1200_cim->capture = 0;
+	au1200_cim->capture = CIM_CAPTURE_CLR;
+	au1200_cim->capture = CIM_CAPTURE_SCE;
+	return 1;
+}
+
+static void
+Camera_pwr_down(void)
+{
+	/* Power shut to Camera */
+	bcsr->board |= BCSR_BOARD_CAMPWR;
+}
+
+static void
+Camera_pwr_up(void)
+{
+	bcsr->board &= ~BCSR_BOARD_CAMPWR;
+}
+
+static void
+CIM_Cleanup(CAMERA_RUNTIME * cim_cleanup)
+{
+	CAMERA *cim_ptr;
+	uint32_t frame_size;
+	int i;
+	cim_ptr = cim_cleanup->cmos_camera;
+	frame_size = (cim_ptr->frame_width) * (cim_ptr->frame_height);
+
+	for (i = 0; i < cim_ptr->dbdma_channel; i++) {
+		if (cim_cleanup->ChannelArray[i]) {
+
+			au1xxx_dbdma_stop((u32) (cim_cleanup->ChannelArray[i]));
+			au1xxx_dbdma_reset((u32)
+					   (cim_cleanup->ChannelArray[i]));
+			au1xxx_dbdma_chan_free((u32)
+					       (cim_cleanup->ChannelArray[i]));
+		}
+
+		if ((cim_cleanup->memory[i]) != NULL) {
+			free_pages((unsigned long)cim_cleanup->memory[i],
+				   get_order(frame_size));
+		}
+	}
+
+}
+
+static int
+Camera_Config(CAMERA_RUNTIME * cim_config)
+{
+	uint32_t nAckCount = 0;
+	int i, ErrorCheck;
+	ErrorCheck = 0;
+	uint32_t nCameraModeConfig = 0;
+	uint32_t nClearSetInterrupt = 0;
+	CAMERA *cim_config_ptr;
+
+	cim_config_ptr = cim_config->cmos_camera;
+
+	/* To get rid of hard coded number from Transfer Size */
+	/* Now transfer size will be calulated on the on the fly */
+	/*******************************************************************
+		    In YCbCr 4:2:2 data size is twice the frame size
+		     Y=Frame Size
+		     Cb=Frame Size/2
+		     Cr=Frame Size/2
+		     Total size of Frame: Y+Cb+Cr effectively 2*FrameSize
+	*********************************************************************/
+
+	if ((cim_config_ptr->au1200_dpsmode) == CIM_CONFIG_RAW) {
+		if (cim_config_ptr->cmos_output_format == CMOS_CCIR656) {
+
+			cim_config->nTransferSize[0] =
+			    2 * (cim_config_ptr->frame_width) *
+			    (cim_config_ptr->frame_height);
+			DPRINTK("FIFO-A YCbCR Transfer Size in Raw mode %d \n",
+				cim_config->nTransferSize[0]);
+		} else {
+			cim_config->nTransferSize[0] =
+			    (cim_config_ptr->frame_width) *
+			    (cim_config_ptr->frame_height);
+			DPRINTK("FIFO-A Transfer Size in Raw mode %d \n",
+				cim_config->nTransferSize[0]);
+		}
+		cim_config->memory[0] = mem_buf;
+	} else if ((cim_config_ptr->au1200_dpsmode) == CIM_CONFIG_BAYER) {
+		/* FIFO A Hold Red Pixels which is Total Pixels/4 */
+		cim_config->nTransferSize[0] =
+			((cim_config_ptr->frame_width) *
+			 (cim_config_ptr->frame_height)) / 4;
+		cim_config->nTransferSize[1] =
+			((cim_config_ptr->frame_width) *
+			 (cim_config_ptr->frame_height)) / 2;
+		cim_config->nTransferSize[2] =
+			((cim_config_ptr->frame_width) *
+			 (cim_config_ptr->frame_height)) / 4;
+
+		cim_config->memory[0] = mem_buf;
+		cim_config->memory[1] = mem_buf + cim_config->nTransferSize[0];
+		cim_config->memory[2] = mem_buf + cim_config->nTransferSize[0]
+			+ cim_config->nTransferSize[1];
+	} else {
+		cim_config->nTransferSize[0] =
+		    ((cim_config_ptr->frame_width) *
+		     (cim_config_ptr->frame_height));
+		cim_config->nTransferSize[1] =
+			((cim_config_ptr->frame_width) *
+			 (cim_config_ptr->frame_height)) / 2;
+		cim_config->nTransferSize[2] =
+			((cim_config_ptr->frame_width) *
+			 (cim_config_ptr->frame_height)) / 2;
+
+		cim_config->memory[0] = mem_buf;
+		cim_config->memory[1] = mem_buf + cim_config->nTransferSize[0];
+		cim_config->memory[2] = mem_buf + cim_config->nTransferSize[0]
+			+ cim_config->nTransferSize[1];
+
+	}
+
+	for (i = 0; i < cim_config->cmos_camera->dbdma_channel; i++) {
+		/* Allocate Channel */
+		cim_config->ChannelArray[i] =
+			(chan_tab_t **) au1xxx_dbdma_chan_alloc(DBDMA_SourceID[i],
+							    DSCR_CMD0_ALWAYS,
+							    Cim_DDMA_Done_Interrupt,
+							    (void *)NULL);
+
+		if (cim_config->ChannelArray[i] != NULL) {
+			au1xxx_dbdma_set_devwidth((u32)
+						  (cim_config->ChannelArray[i]),
+						  32);
+			if (au1xxx_dbdma_ring_alloc
+			    ((u32) (cim_config->ChannelArray[i]), 16) == 0) {
+				printk(KERN_ERR \
+				       "Failed to allocate a DDMA channel\n");
+
+				ErrorCheck++;
+				goto error_ch_alloc;
+			}
+			au1xxx_dbdma_start((u32) (cim_config->ChannelArray[i]));
+			int j = 0;
+			for (j = 0; j < NUM_DBDMA_DESCRIPTORS; j++) {
+
+				if (!au1xxx_dbdma_put_dest
+				    ((u32) (cim_config->ChannelArray[i]),
+				     cim_config->memory[i],
+				     cim_config->nTransferSize[i])) {
+					printk(KERN_ERR \
+					       "Error while putting descriptor on DBDMA channnel.\n");
+				}
+			}
+
+		} else {
+			ErrorCheck++;
+			goto error_ch_alloc;
+		}
+
+	}
+
+	for (i = 0; i < cim_config_ptr->cmd_size; i++) {
+		while ((pb1550_wm_codec_write(cim_config_ptr->device_addr,
+					      cim_config_ptr->config_cmd[i][0],
+					      cim_config_ptr->
+					      config_cmd[i][1]) != 1)
+		       && (nAckCount < 50)) {
+			nAckCount++;
+		}
+		if (i == 0) {
+			mdelay(1);
+		}
+
+	}
+	if (nAckCount == 50) {
+		printk(KERN_ERR "External CMOS Camera Not Present or not properly connected !!!! !\n");
+		goto error_ch_alloc;
+	}
+
+	au1200_cim->enable = CIM_ENABLE_EN;
+	au1200_cim->capture = CIM_CAPTURE_CLR;
+
+	if (cim_config_ptr->au1200_dpsmode == 1) {
+		nCameraModeConfig =
+			CIM_CONFIG_DPS_N(cim_config_ptr->
+					 au1200_dpsmode) | CIM_CONFIG_FS |
+			CIM_CONFIG_BAY_N(cim_config_ptr->
+					 au1200_baymode) | CIM_CONFIG_BYT |
+			CIM_CONFIG_LEN(CIM_CONFIG_LEN_10BIT);
+	} else if (cim_config_ptr->au1200_dpsmode == 0) {
+		nCameraModeConfig =
+			CIM_CONFIG_DPS_N(cim_config_ptr->
+					 au1200_dpsmode) | CIM_CONFIG_FS |
+			CIM_CONFIG_BYT | CIM_CONFIG_LEN(CIM_CONFIG_LEN_10BIT) |
+			CIM_CONFIG_BAY_N(cim_config_ptr->
+					 au1200_baymode) | CIM_CONFIG_PM;
+	} else {
+		/* Need to re check........ */
+		nCameraModeConfig =
+			CIM_CONFIG_DPS_N(cim_config_ptr->
+					 au1200_dpsmode) | CIM_CONFIG_FS |
+			CIM_CONFIG_BYT | CIM_CONFIG_LEN(CIM_CONFIG_LEN_10BIT) |
+			CIM_CONFIG_FSEL_N(CIM_CONFIG_FIELD12);
+	}
+
+	au1200_cim->config = nCameraModeConfig;
+	nClearSetInterrupt = CIM_INSTAT_CD | CIM_INSTAT_FD |
+		CIM_INSTAT_UFA | CIM_INSTAT_OFA |
+		CIM_INSTAT_UFB | CIM_INSTAT_OFB | CIM_INSTAT_UFB | CIM_INSTAT_OFC;
+
+	au1200_cim->instat = nClearSetInterrupt;
+	au1200_cim->inten = nClearSetInterrupt;
+
+	for (i = 0; i < 6; i++) {
+		mdelay(1);
+	}
+
+      error_ch_alloc:
+	if (ErrorCheck) {
+		CIM_Cleanup(cim_config);
+		return -1;
+	}
+	return 0;
+}
+
+#define MAX_GFP 0x00200000
+
+/* To get contigious Memroy location using GetFree pages*/
+
+static unsigned long
+Camera_mem_alloc(unsigned long size)
+{
+	/* __get_free_pages() fulfills a max request of 2MB */
+	/* do multiple requests to obtain large contigous mem */
+
+	unsigned long mem, amem, alloced = 0, allocsize;
+
+	size += 0x1000;
+	allocsize = (size < MAX_GFP) ? size : MAX_GFP;
+
+	/* Get first chunk */
+	mem = (unsigned long)
+	    __get_free_pages(GFP_ATOMIC | GFP_DMA, get_order(allocsize));
+	if (mem != 0)
+		alloced = allocsize;
+
+	/* Get remaining, contiguous chunks */
+	while (alloced < size) {
+		amem = (unsigned long)
+		    __get_free_pages(GFP_ATOMIC | GFP_DMA,
+				     get_order(allocsize));
+		if (amem != 0)
+			alloced += allocsize;
+
+		/* check for contiguous mem alloced */
+		if ((amem == 0) || (amem + allocsize) != mem)
+			break;
+		else
+			mem = amem;
+	}
+	return mem;
+}
+
+static irqreturn_t 
+Cim_Interrupt_Handler(int irq, void *dev_id,struct pt_regs *regs)
+{
+
+	uint32_t nStatus;
+
+	disable_irq(AU1200_CAMERA_INT);
+	nStatus = au1200_cim->instat;
+
+	if (nStatus & CIM_INSTAT_CD) {
+		au1200_cim->instat = CIM_INSTAT_CD;
+	} else if (nStatus & CIM_INSTAT_FD) {
+		au1200_cim->instat = CIM_INSTAT_FD;
+	} else if (nStatus & CIM_INSTAT_UFA) {
+		au1200_cim->instat = CIM_INSTAT_UFA;
+		ciminterruptcheck = 1;
+	} else if (nStatus & CIM_INSTAT_OFA) {
+		au1200_cim->instat = CIM_INSTAT_OFA;
+		ciminterruptcheck = 1;
+	} else if (nStatus & CIM_INSTAT_UFB) {
+		au1200_cim->instat = CIM_INSTAT_UFB;
+		ciminterruptcheck = 1;
+	} else if (nStatus & CIM_INSTAT_OFB) {
+		au1200_cim->instat = CIM_INSTAT_OFB;
+		ciminterruptcheck = 1;
+	} else if (nStatus & CIM_INSTAT_UFC) {
+		au1200_cim->instat = CIM_INSTAT_UFC;
+		ciminterruptcheck = 1;
+	} else if (nStatus & CIM_INSTAT_OFC) {
+		au1200_cim->instat = CIM_INSTAT_OFC;
+		ciminterruptcheck = 1;
+	} else if (nStatus & CIM_INSTAT_ERR) {
+		au1200_cim->instat = CIM_INSTAT_ERR;
+	}
+
+	enable_irq(AU1200_CAMERA_INT);
+	return IRQ_HANDLED;
+}
+
+static int
+au1xxxcim_ioctl(struct inode *inode, struct file *file,
+		unsigned int cmd, unsigned long arg)
+{
+	nInterruptDoneNumber = 0;
+	uint32_t mode_index, i;
+	CAMERA_RUNTIME *capture;
+	CAMERA *capture_ptr;
+
+	capture = &cam_base;
+
+	switch (cmd) {
+
+	case AU1XXXCIM_QUERY:{
+			/*returing previous mode */
+			DPRINTK
+			    ("QUERY Mode- Return Camera Index to Application is %d \n",
+			     prev_mode);
+			return prev_mode;
+		}
+	case AU1XXXCIM_CONFIGURE:{
+			DPRINTK(" CONFIGURE Mode\n");
+			mode_index = find_mode_index(arg);
+			capture->cmos_camera = OrigCimArryPtr + prev_mode;
+			capture_ptr = capture->cmos_camera;
+			DPRINTK
+			    ("CONFIGURE Mode: Calling CleanUP as Camera needs to be re-configured \n");
+			CIM_Cleanup(capture);
+			DPRINTK("CONFIGURE:Camera Array Index value is %d \n",
+				mode_index);
+			capture->cmos_camera = OrigCimArryPtr + mode_index;
+			capture_ptr = capture->cmos_camera;
+			DPRINTK
+			    (" CONFIGURE: Camera configured in  ** %s ** Mode \n",
+			     capture_ptr->camera_mode);
+			au1200_cim->enable &= ~CIM_ENABLE_EN;
+			Camera_Config(capture);
+			Camera_pwr_down();
+			mdelay(1);
+			Camera_pwr_up();
+			mdelay(6);
+			prev_mode = mode_index;
+			return mode_index;
+		}
+	case AU1XXXCIM_CAPTURE:{
+			capture->cmos_camera = OrigCimArryPtr + prev_mode;
+			capture_ptr = capture->cmos_camera;
+			DPRINTK("CAPTURE: Camera Array Index # %d \n",
+				prev_mode);
+			DPRINTK("CAPTURE:Picture taken in **%s** Mode \n",
+				capture_ptr->camera_mode);
+			Capture_Image();
+			DPRINTK("CAPTURE:Status Reg %x Capture Reg %x \n",
+				au1200_cim->stat, au1200_cim->capture);
+			DPRINTK("Waiting for %d DMA Interrupt \n",
+				capture_ptr->dbdma_channel);
+			while ((nInterruptDoneNumber !=
+				(capture_ptr->dbdma_channel))
+			       && (!ciminterruptcheck)) ;
+
+			if (ciminterruptcheck) {
+				printk(" !! ERROR: DMA Transfer Error \n");
+				ciminterruptcheck = 0;
+				return 0;
+			}
+
+			DPRINTK
+			    ("CAPTURE:Putting back descriptor back to ring\n");
+			for (i = 0; i < capture_ptr->dbdma_channel; i++) {
+				if (!au1xxx_dbdma_put_dest
+				    ((u32) (capture->ChannelArray[i]),
+				     capture->memory[i],
+				     capture->nTransferSize[i])) {
+					printk
+					    ("DBDMA Error..Putting Descriptor on Buffer Ring Channel A in Single Channel \n");
+				}
+			}
+			DPRINTK(" CAPTURE: Exiting Capture \n");
+
+			return 1;
+			break;
+		}
+
+	}
+
+	return -EINVAL;
+}
+
+static int
+au1xxxcim_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	unsigned int len;
+	unsigned long start = 0, off;
+
+	if (vma->vm_pgoff > (~0UL >> PAGE_SHIFT)) {
+		printk(" Error vma->vm_pgoff > !OUL PAGE_SHIFT \n");
+		return -EINVAL;
+	}
+
+	start = virt_to_phys(mem_buf) & PAGE_MASK;
+	len = PAGE_ALIGN((start & ~PAGE_MASK) + 2 * MAX_FRAME_SIZE);
+	off = vma->vm_pgoff << PAGE_SHIFT;
+
+	if ((vma->vm_end - vma->vm_start + off) > len) {
+		printk(" Error vma->vm_end-vma->vm_start\n");
+		return -EINVAL;
+	}
+
+	off += start;
+	vma->vm_pgoff = off >> PAGE_SHIFT;
+	pgprot_val(vma->vm_page_prot) &= ~_CACHE_MASK;
+	pgprot_val(vma->vm_page_prot) |= PAGE_CACHABLE_DEFAULT;
+
+	/* This is an IO map - tell maydump to skip this VMA */
+	vma->vm_flags |= VM_IO;
+
+	return io_remap_pfn_range(vma, vma->vm_start, off,
+				  vma->vm_end - vma->vm_start,
+				  vma->vm_page_prot);
+}
+
+static struct file_operations au1xxxcim_fops = {
+      owner:THIS_MODULE,
+      ioctl:au1xxxcim_ioctl,
+      mmap:au1xxxcim_mmap
+};
+
+int __init
+au1xxxcim_init(void)
+{
+	int retval, error;
+	unsigned long page;
+	CAMERA_RUNTIME *cam_init;
+	CAMERA *cim_ptr;
+
+	cam_init = &cam_base;
+	cam_init->cmos_camera = OrigCimArryPtr + prev_mode;
+	cim_ptr = cam_init->cmos_camera;
+
+	/*Allocating memory for MMAP */
+	mem_buf = (unsigned long *)Camera_mem_alloc(2 * MAX_FRAME_SIZE);
+	if (mem_buf == NULL) {
+		printk(KERN_ERR "MMAP unable to allocate memory \n");
+	}
+
+	for (page = (unsigned long)mem_buf;
+	     page < PAGE_ALIGN((unsigned long)mem_buf + MAX_FRAME_SIZE);
+	     page += PAGE_SIZE) {
+		SetPageReserved(virt_to_page(page));
+	}
+	Camera_pwr_up();
+	error = Camera_Config(cam_init);
+	if (error == -1) {
+		DPRINTK
+		    ("Camera Config Un-Sucessful: Calling Clean Up function \n");
+		CIM_Cleanup(cam_init);
+	}
+
+	Camera_pwr_down();
+	mdelay(1);
+	Camera_pwr_up();
+
+	/* Register Device */
+	retval = register_chrdev(CIM_MAJOR, CIM_NAME, &au1xxxcim_fops);
+	if (retval < 0) {
+		printk(KERN_ERR "Could not register CIM device\n");
+		return 0;
+	}
+	printk(KERN_INFO "Au1XXX CIM driver registered Sucessfully v%s\n",
+	       VERSION);
+	if ((retval =
+	     request_irq(AU1200_CAMERA_INT, Cim_Interrupt_Handler,
+			 SA_SHIRQ | SA_INTERRUPT, CIM_NAME,
+			 (void *)au1200_cim))) {
+		printk(KERN_ERR "CIM: Could not get IRQ %d.\n",
+		       AU1200_CAMERA_INT);
+		CIM_Cleanup(cam_init);
+		return retval;
+	}
+
+	return 0;
+
+}
+
+void __exit
+au1xxxcim_exit(void)
+{
+	int retval;
+	CAMERA_RUNTIME *cam_exit;
+	CAMERA *cam_exit_ptr;
+
+	cam_exit = &cam_base;
+	cam_exit->cmos_camera = OrigCimArryPtr + prev_mode;
+	cam_exit_ptr = cam_exit->cmos_camera;
+
+	/* Cleanup funtion will clean allocated memory, free DMA channels */
+	CIM_Cleanup(cam_exit);
+
+	/*Unregister Device */
+	retval = unregister_chrdev(CIM_MAJOR, CIM_NAME);
+	if (retval != -EINVAL) {
+		printk(KERN_INFO "CIM driver unregistered Sucessfully \n");
+	}
+}
+
+module_init(au1xxxcim_init);
+module_exit(au1xxxcim_exit);
+
+MODULE_AUTHOR("AMD");
+MODULE_DESCRIPTION("AMD CIM Interface Driver");
+MODULE_LICENSE("GPL");
diff --git a/include/asm-mips/mach-au1x00/au1xxx_cim.h b/include/asm-mips/mach-au1x00/au1xxx_cim.h
new file mode 100644
index 0000000..50fe557
--- /dev/null
+++ b/include/asm-mips/mach-au1x00/au1xxx_cim.h
@@ -0,0 +1,190 @@
+ /*	Defines for using the Camera Interfaces on the
+  *      Alchemy Au1100 mips processor.
+  *
+  *  This program is free software; you can redistribute  it and/or modify it
+  *  under  the terms of  the GNU General  Public License as published by the
+  *  Free Software Foundation;  either version 2 of the  License, or (at your
+  *  option) any later version.
+  *
+  *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
+  *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
+  *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+  *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
+  *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+  *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
+  *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+  *   ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
+  *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+  *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+  *  You should have received a copy of the  GNU General Public License along
+  *  with this program; if not, write  to the Free Software Foundation, Inc.,
+  *  675 Mass Ave, Cambridge, MA 02139, USA.
+  *
+  */
+#ifndef AUXXX_CIM_H
+#define AUXXX_CIM_H
+
+#include <linux/ioctl.h>
+
+#define AU1XXXCIM_IOC_MAGIC 'C'
+
+#define RAW_SXGA              _IOW(AU1XXXCIM_IOC_MAGIC,1, int *)
+#define RAW_VGA               _IOW(AU1XXXCIM_IOC_MAGIC,2, int *)
+#define RAW_CIF               _IOW(AU1XXXCIM_IOC_MAGIC,3, int *)
+#define RAW_QVGA              _IOW(AU1XXXCIM_IOC_MAGIC,4, int *)
+#define RAW_QCIF              _IOW(AU1XXXCIM_IOC_MAGIC,5, int *)
+#define RAW_QQVGA             _IOW(AU1XXXCIM_IOC_MAGIC,6, int *)
+#define RAW_QQCIF             _IOW(AU1XXXCIM_IOC_MAGIC,7, int *)
+#define BAYER_SXGA            _IOW(AU1XXXCIM_IOC_MAGIC,8, int *)
+#define BAYER_VGA             _IOW(AU1XXXCIM_IOC_MAGIC,9, int *)
+#define BAYER_CIF             _IOW(AU1XXXCIM_IOC_MAGIC,10, int *)
+#define BAYER_QVGA            _IOW(AU1XXXCIM_IOC_MAGIC,11, int *)
+#define BAYER_QCIF            _IOW(AU1XXXCIM_IOC_MAGIC,12, int *)
+#define BAYER_QQVG            _IOW(AU1XXXCIM_IOC_MAGIC,13, int *)
+#define BAYER_QQCI            _IOW(AU1XXXCIM_IOC_MAGIC,14, int *)
+#define YCbCr_SXGA_RAW        _IOW(AU1XXXCIM_IOC_MAGIC,18, int *)
+#define YCbCr_VGA_RAW         _IOW(AU1XXXCIM_IOC_MAGIC,19, int *)
+#define YCbCr_CIF_RAW         _IOW(AU1XXXCIM_IOC_MAGIC,20, int *)
+#define YCbCr_QVGA_RAW        _IOW(AU1XXXCIM_IOC_MAGIC,21, int *)
+#define YCbCr_QCIF_RAW        _IOW(AU1XXXCIM_IOC_MAGIC,22, int *)
+#define YCbCr_SXGA            _IOW(AU1XXXCIM_IOC_MAGIC,23, int *)
+#define YCbCr_VGA             _IOW(AU1XXXCIM_IOC_MAGIC,24, int *)
+#define YCbCr_CIF             _IOW(AU1XXXCIM_IOC_MAGIC,25, int *)
+#define YCbCr_QVGA            _IOW(AU1XXXCIM_IOC_MAGIC,26, int *)
+#define YCbCr_QCIF            _IOW(AU1XXXCIM_IOC_MAGIC,27, int *)
+#define AU1XXXCIM_CAPTURE     _IOW(AU1XXXCIM_IOC_MAGIC, 100, int *)
+#define AU1XXXCIM_QUERY       _IOW(AU1XXXCIM_IOC_MAGIC, 50, int *)
+#define AU1XXXCIM_CONFIGURE   _IOW(AU1XXXCIM_IOC_MAGIC, 75, int *)
+
+#define  CMOS_RAW               0
+#define  CMOS_CCIR656           1
+
+#define CIM_BASE_ADDRESS        0xB4004000
+
+#define CIM_FIFOA		0xB4004020
+#define CIM_FIFOB		0xB4004040
+#define CIM_FIFOC		0xB4004060
+
+typedef struct
+{
+        unsigned long         enable;                /* 00 */
+        unsigned long         config;                /* 04 */
+        unsigned long         reserve0;              /* 08 */
+	unsigned long         reserve1;              /* 0C */
+	unsigned long         capture;               /* 10 */
+	unsigned long         stat;                  /* 14 */
+        unsigned long         inten;                 /* 18 */
+	unsigned long         instat;                /* 1C */
+	unsigned long         fifoa;                 /* 20 */
+	unsigned long         reserve2;              /* 24 */
+        unsigned long         reserve3;              /* 28 */
+        unsigned long         reserve4;              /* 2C */
+        unsigned long         reserve5;              /* 30 */
+        unsigned long         reserve6;              /* 34 */
+        unsigned long         reserve7;              /* 38 */
+        unsigned long         reserve8;              /* 3C */
+        unsigned long         fifob;                 /* 40 */
+	unsigned long         reserve9;              /* 44 */
+        unsigned long         reserve10;              /* 48 */
+        unsigned long         reserve11;              /* 4C */
+        unsigned long         reserve12;              /* 50 */
+        unsigned long         reserve13;              /* 54 */
+        unsigned long         reserve14;              /* 58 */
+        unsigned long         reserve15;              /* 5C */
+	unsigned long         fifoc;                  /* 60 */
+}AU1200_CIM;
+
+
+#define CIM_ENABLE              0x00000000
+#define CIM_CONFIG		0x00000004
+#define CIM_CAPTURE	        0x00000010
+#define CIM_STAT                0x00000014
+#define CIM_INTEN		0x00000018
+#define CIM_INSTAT		0x0000001C
+
+#define   CIM_ENABLE_EN		        (1<<0)       /* enable/disable/reset the block*/
+
+/* CIM Configuration Register */
+
+#define   CIM_CONFIG_PM			(1<<0)
+#define   CIM_CONFIG_CLK	        (1<<1)   /* Rising Edge of the Clock */
+#define   CIM_CONFIG_LS			(1<<2)	 /* Line Sync Active Low */
+#define   CIM_CONFIG_FS			(1<<3)	 /* Frame Sync is Active Low */
+
+#define   CIM_CONFIG_RAW                 0  /* RAW MODE */
+#define   CIM_CONFIG_BAYER               1  /*Bayer Mode*/
+#define   CIM_CONFIG_656                 2  /* 656 YCbCr Mode*/
+
+#define   CIM_CONFIG_DPS_N(n)           (((n) & 0x03)<<6)
+
+
+#define   CIM_CONFIG_RGGB                 0
+#define   CIM_CONFIG_GRBG                 1
+#define   CIM_CONFIG_BGGR                 2
+#define   CIM_CONFIG_GBRG                 3
+
+#define   CIM_CONFIG_BAY_N(n)           (((n) & 0x03)<<8)
+
+#define   CIM_CONFIG_LEN_8BIT              0
+#define   CIM_CONFIG_LEN_9BIT              1
+#define   CIM_CONFIG_LEN_10BIT             2
+
+
+#define   CIM_CONFIG_LEN(n)		(((n) & 0x0f)<<10)
+#define   CIM_CONFIG_BYT		(1<<14)
+#define   CIM_CONFIG_SF			(1<<15)
+
+#define   CIM_CONFIG_FIELD1              0  /* Capture from Field 1*/
+#define   CIM_CONFIG_FIELD2              1  /*Capture from Field 2*/
+#define   CIM_CONFIG_FIELD12             2  /*Capture from Either Field*/
+
+#define   CIM_CONFIG_FSEL_N(n)	        (((n) & 0x03)<<16)
+
+#define   CIM_CONFIG_SI			(1<<18)
+
+/* CIM Capture Control Register */
+
+#define CIM_CAPTURE_VCE			(1<<0)
+#define CIM_CAPTURE_SCE			(1<<1)
+#define CIM_CAPTURE_CLR			(1<<2)
+
+/* CIM Status Register */
+
+#define CIM_STATUS_VC			(1<<0)
+#define CIM_STATUS_SC			(1<<1)
+#define CIM_STATUS_AF			(1<<2)
+#define CIM_STATUS_AE			(1<<3)
+#define CIM_STATUS_AR			(1<<4)
+#define CIM_STATUS_BF			(1<<5)
+#define CIM_STATUS_BE			(1<<6)
+#define CIM_STATUS_BR			(1<<7)
+#define CIM_STATUS_CF			(1<<8)
+#define CIM_STATUS_CE			(1<<9)
+#define CIM_STATUS_CR			(1<<10)
+
+
+/* Interrupt  Rgister */
+#define CIM_INTEN_CD			(1<<0)
+#define CIM_INTEN_FD			(1<<1)
+#define CIM_INTEN_UFA			(1<<2)
+#define CIM_INTEN_OFA			(1<<3)
+#define CIM_INTEN_UFB			(1<<4)
+#define CIM_INTEN_OFB			(1<<5)
+#define CIM_INTEN_UFC			(1<<6)
+#define CIM_INTEN_OFC			(1<<7)
+#define CIM_INTEN_ERR			(1<<8)
+
+
+/* Interrupt Status Rgister */
+
+#define CIM_INSTAT_CD			(1<<0)
+#define CIM_INSTAT_FD			(1<<1)
+#define CIM_INSTAT_UFA			(1<<2)
+#define CIM_INSTAT_OFA			(1<<3)
+#define CIM_INSTAT_UFB			(1<<4)
+#define CIM_INSTAT_OFB			(1<<5)
+#define CIM_INSTAT_UFC			(1<<6)
+#define CIM_INSTAT_OFC			(1<<7)
+#define CIM_INSTAT_ERR			(1<<8)
+
+#endif
