Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 May 2009 23:18:02 +0100 (BST)
Received: from rv-out-0708.google.com ([209.85.198.247]:11719 "EHLO
	rv-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20023392AbZEOWRy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 15 May 2009 23:17:54 +0100
Received: by rv-out-0708.google.com with SMTP id b17so345338rvf.0
        for <multiple recipients>; Fri, 15 May 2009 15:17:51 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :content-type:organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=FAMEc1IRcw+b8WLBt0KfRwxZtaAPsIEQoWpgoVS3geM=;
        b=xsB6O77L09Cm4sSBB3Hli6ZjoQ/KWsc36U3PiQoNfCz3Fdbx+16/iHwh3owJO3HET/
         mbqTQEwJiP6Z34BcqQx42mOyk940YiU3IeSUKXo97kUSOtSbtnNO9cD15QDFn6w14UHt
         dvDq7gpt2ITxMK4XGzzA9ct7EnwJGLLf8btpg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:content-type:organization:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=ZIPyfBjhQzSv6wTOceGtq/rrY4LBSgJNBTcvKtYJIFAFKZIF1jgBDtXFtMH5S9Fdx1
         FsbM9iYbOEm0+qRasRkY9TjqcvWpLVnPygzvjMNtzXFuToV5cXYVobUDnSgH2MdlW/uy
         NVIqicL+DwLtmpXkQOSmNuTemwm0Mx55XZn8s=
Received: by 10.142.177.13 with SMTP id z13mr1327309wfe.184.1242425871486;
        Fri, 15 May 2009 15:17:51 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm3632616wfd.39.2009.05.15.15.17.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 May 2009 15:17:50 -0700 (PDT)
Subject: [PATCH 18/30] loongson: Add Siliconmotion 712 framebuffer driver
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	linux-media@vger.kernel.org
Cc:	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, zhangfx@lemote.com, yanh@lemote.com,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>, Erwan Lerale <erwan@thiscow.com>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Sat, 16 May 2009 06:17:42 +0800
Message-Id: <1242425862.10164.161.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22755
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

>From 1def5374c2d38a24524b30ed5c734c28987fceea Mon Sep 17 00:00:00 2001
From: Wu Zhangjin <wuzhangjin@gmail.com>
Date: Sat, 16 May 2009 04:27:50 +0800
Subject: [PATCH 18/30] loongson: Add Siliconmotion 712 framebuffer
driver

yeeloong(2f) laptop have a SMI video card, need this driver.

this source code is originally from
http://dev.lemote.com/code/linux_loongson
tons of warnings have been fixed, the main warning is:

      warning: left shift count >= width of type

have been fixed via the following modification:

      drivers/video/smi/smtc2d.h:

      #define _F_MASK(f) ((((1 << _F_SIZE(f)) - 1) << _F_START(f))
      #define _F_MASK(f) ((((unsigned long)1 << _F_SIZE(f)) - 1) <<
_F_START(f))

and also, the coding style is changed to follow the kernel style.
---
 drivers/video/Kconfig       |   23 +
 drivers/video/Makefile      |    1 +
 drivers/video/smi/Makefile  |    6 +
 drivers/video/smi/sm501hw.h | 2135
+++++++++++++++++++++++++++++++++++++++++++
 drivers/video/smi/sm7xxhw.h |  100 ++
 drivers/video/smi/smtc2d.c  | 1451 +++++++++++++++++++++++++++++
 drivers/video/smi/smtc2d.h  |  541 +++++++++++
 drivers/video/smi/smtcfb.c  | 1145 +++++++++++++++++++++++
 drivers/video/smi/smtcfb.h  |  786 ++++++++++++++++
 9 files changed, 6188 insertions(+), 0 deletions(-)
 create mode 100644 drivers/video/smi/Makefile
 create mode 100644 drivers/video/smi/sm501hw.h
 create mode 100644 drivers/video/smi/sm7xxhw.h
 create mode 100644 drivers/video/smi/smtc2d.c
 create mode 100644 drivers/video/smi/smtc2d.h
 create mode 100644 drivers/video/smi/smtcfb.c
 create mode 100644 drivers/video/smi/smtcfb.h

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index fb19803..ded6807 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1943,6 +1943,29 @@ config FB_S3C2410_DEBUG
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
+	  Frame Buffer driver for the Silicon Motion SM7XX serial graphic
card.
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
index 2a998ca..452479f 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -71,6 +71,7 @@ obj-$(CONFIG_FB_P9100)            += p9100.o sbuslib.o
 obj-$(CONFIG_FB_TCX)              += tcx.o sbuslib.o
 obj-$(CONFIG_FB_LEO)              += leo.o sbuslib.o
 obj-$(CONFIG_FB_SGIVW)            += sgivwfb.o
+obj-$(CONFIG_FB_SILICONMOTION)    += smi/
 obj-$(CONFIG_FB_ACORN)            += acornfb.o
 obj-$(CONFIG_FB_ATARI)            += atafb.o c2p_iplan2.o atafb_mfb.o \
                                      atafb_iplan2p2.o atafb_iplan2p4.o
atafb_iplan2p8.o
diff --git a/drivers/video/smi/Makefile b/drivers/video/smi/Makefile
new file mode 100644
index 0000000..5aeba94
--- /dev/null
+++ b/drivers/video/smi/Makefile
@@ -0,0 +1,6 @@
+obj-y +=  smi.o
+
+smi-y := $(DRIVER_OBJS)
+
+smi-y +=smtcfb.o
+
diff --git a/drivers/video/smi/sm501hw.h b/drivers/video/smi/sm501hw.h
new file mode 100644
index 0000000..d8da5a7
--- /dev/null
+++ b/drivers/video/smi/sm501hw.h
@@ -0,0 +1,2135 @@
+/*
+ *  linux/drivers/video/sm501hw.h -- Silicon Motion SM501 frame buffer
device
+ *
+ *	 Copyright (C) 2006 Silicon Motion, Inc.
+ *	 Ge Wang, gewang@siliconmotion.com
+ *
+ *  This file is subject to the terms and conditions of the GNU General
Public
+ *  License. See the file COPYING in the main directory of this archive
for
+ *  more details.
+ */
+
+#define SM501_VIDEOMEMORYSIZE	  0x00800000	/*Assume SMTC graphics chip
has 8MB VRAM */
+#define SM502_REV_ID		  0xC0
+
+/*
+ *
+ * Definitions for the System Configuration registers.
+ *
+ */
+
+#define SYSTEM_CTRL					 0x000000
+#define SYSTEM_CTRL_DPMS				 31:30
+#define SYSTEM_CTRL_DPMS_VPHP				 0
+#define SYSTEM_CTRL_DPMS_VPHN				 1
+#define SYSTEM_CTRL_DPMS_VNHP				 2
+#define SYSTEM_CTRL_DPMS_VNHN				 3
+#define SYSTEM_CTRL_PCI_BURST				 29:29
+#define SYSTEM_CTRL_PCI_BURST_DISABLE			 0
+#define SYSTEM_CTRL_PCI_BURST_ENABLE			 1
+#define SYSTEM_CTRL_CSC_STATUS 			 28:28
+#define SYSTEM_CTRL_CSC_STATUS_IDLE			 0
+#define SYSTEM_CTRL_CSC_STATUS_BUSY			 1
+#define SYSTEM_CTRL_PCI_MASTER 			 25:25
+#define SYSTEM_CTRL_PCI_MASTER_STOP			 0
+#define SYSTEM_CTRL_PCI_MASTER_START			 1
+#define SYSTEM_CTRL_LATENCY_TIMER			 24:24
+#define SYSTEM_CTRL_LATENCY_TIMER_ENABLE		 0
+#define SYSTEM_CTRL_LATENCY_TIMER_DISABLE		 1
+#define SYSTEM_CTRL_PANEL_STATUS			 23:23
+#define SYSTEM_CTRL_PANEL_STATUS_CURRENT		 0
+#define SYSTEM_CTRL_PANEL_STATUS_PENDING		 1
+#define SYSTEM_CTRL_VIDEO_STATUS			 22:22
+#define SYSTEM_CTRL_VIDEO_STATUS_CURRENT		 0
+#define SYSTEM_CTRL_VIDEO_STATUS_PENDING		 1
+#define SYSTEM_CTRL_DE_FIFO				 20:20
+#define SYSTEM_CTRL_DE_FIFO_NOT_EMPTY			 0
+#define SYSTEM_CTRL_DE_FIFO_EMPTY			 1
+#define SYSTEM_CTRL_DE_STATUS				 19:19
+#define SYSTEM_CTRL_DE_STATUS_IDLE			 0
+#define SYSTEM_CTRL_DE_STATUS_BUSY			 1
+#define SYSTEM_CTRL_CRT_STATUS 			 17:17
+#define SYSTEM_CTRL_CRT_STATUS_CURRENT 		 0
+#define SYSTEM_CTRL_CRT_STATUS_PENDING 		 1
+#define SYSTEM_CTRL_ZVPORT				 16:16
+#define SYSTEM_CTRL_ZVPORT_0				 0
+#define SYSTEM_CTRL_ZVPORT_1				 1
+#define SYSTEM_CTRL_PCI_BURST_READ			 15:15
+#define SYSTEM_CTRL_PCI_BURST_READ_DISABLE		 0
+#define SYSTEM_CTRL_PCI_BURST_READ_ENABLE		 1
+#define SYSTEM_CTRL_DE_ABORT				 13:12
+#define SYSTEM_CTRL_DE_ABORT_NORMAL			 0
+#define SYSTEM_CTRL_DE_ABORT_2D_ABORT			 3
+#define SYSTEM_CTRL_PCI_SUBSYS_LOCK			 11:11
+#define SYSTEM_CTRL_PCI_SUBSYS_LOCK_DISABLE		 0
+#define SYSTEM_CTRL_PCI_SUBSYS_LOCK_ENABLE		 1
+#define SYSTEM_CTRL_PCI_RETRY				 7:7
+#define SYSTEM_CTRL_PCI_RETRY_ENABLE			 0
+#define SYSTEM_CTRL_PCI_RETRY_DISABLE			 1
+#define SYSTEM_CTRL_PCI_CLOCK_RUN			 6:6
+#define SYSTEM_CTRL_PCI_CLOCK_RUN_DISABLE		 0
+#define SYSTEM_CTRL_PCI_CLOCK_RUN_ENABLE		 1
+#define SYSTEM_CTRL_PCI_SLAVE_BURST_READ_SIZE		 5:4
+#define SYSTEM_CTRL_PCI_SLAVE_BURST_READ_SIZE_1	 0
+#define SYSTEM_CTRL_PCI_SLAVE_BURST_READ_SIZE_2	 1
+#define SYSTEM_CTRL_PCI_SLAVE_BURST_READ_SIZE_4	 2
+#define SYSTEM_CTRL_PCI_SLAVE_BURST_READ_SIZE_8	 3
+#define SYSTEM_CTRL_CRT_TRISTATE			 2:2
+#define SYSTEM_CTRL_CRT_TRISTATE_DISABLE		 0
+#define SYSTEM_CTRL_CRT_TRISTATE_ENABLE		 1
+#define SYSTEM_CTRL_INTMEM_TRISTATE			 1:1
+#define SYSTEM_CTRL_INTMEM_TRISTATE_DISABLE		 0
+#define SYSTEM_CTRL_INTMEM_TRISTATE_ENABLE		 1
+#define SYSTEM_CTRL_PANEL_TRISTATE			 0:0
+#define SYSTEM_CTRL_PANEL_TRISTATE_DISABLE		 0
+#define SYSTEM_CTRL_PANEL_TRISTATE_ENABLE		 1
+
+#define MISC_CTRL					 0x000004
+#define MISC_CTRL_PCI_PAD				 31:30
+#define MISC_CTRL_PCI_PAD_24MA 			 0
+#define MISC_CTRL_PCI_PAD_12MA 			 1
+#define MISC_CTRL_PCI_PAD_8MA				 2
+#define MISC_CTRL_48_SELECT				 29:28
+#define MISC_CTRL_48_SELECT_CRYSTAL			 0
+#define MISC_CTRL_48_SELECT_CPU_96			 2
+#define MISC_CTRL_48_SELECT_CPU_48			 3
+#define MISC_CTRL_UART1_SELECT 			 27:27
+#define MISC_CTRL_UART1_SELECT_UART			 0
+#define MISC_CTRL_UART1_SELECT_SSP			 1
+#define MISC_CTRL_8051_LATCH				 26:26
+#define MISC_CTRL_8051_LATCH_DISABLE			 0
+#define MISC_CTRL_8051_LATCH_ENABLE			 1
+#define MISC_CTRL_FPDATA				 25:25
+#define MISC_CTRL_FPDATA_18				 0
+#define MISC_CTRL_FPDATA_24				 1
+#define MISC_CTRL_CRYSTAL				 24:24
+#define MISC_CTRL_CRYSTAL_24				 0
+#define MISC_CTRL_CRYSTAL_12				 1
+#define MISC_CTRL_DRAM_REFRESH 			 22:21
+#define MISC_CTRL_DRAM_REFRESH_8			 0
+#define MISC_CTRL_DRAM_REFRESH_16			 1
+#define MISC_CTRL_DRAM_REFRESH_32			 2
+#define MISC_CTRL_DRAM_REFRESH_64			 3
+#define MISC_CTRL_BUS_HOLD				 20:18
+#define MISC_CTRL_BUS_HOLD_FIFO_EMPTY			 0
+#define MISC_CTRL_BUS_HOLD_8				 1
+#define MISC_CTRL_BUS_HOLD_16				 2
+#define MISC_CTRL_BUS_HOLD_24				 3
+#define MISC_CTRL_BUS_HOLD_32				 4
+#define MISC_CTRL_HITACHI_READY			 17:17
+#define MISC_CTRL_HITACHI_READY_NEGATIVE		 0
+#define MISC_CTRL_HITACHI_READY_POSITIVE		 1
+#define MISC_CTRL_INTERRUPT				 16:16
+#define MISC_CTRL_INTERRUPT_NORMAL			 0
+#define MISC_CTRL_INTERRUPT_INVERT			 1
+#define MISC_CTRL_PLL_CLOCK_COUNT			 15:15
+#define MISC_CTRL_PLL_CLOCK_COUNT_DISABLE		 0
+#define MISC_CTRL_PLL_CLOCK_COUNT_ENABLE		 1
+#define MISC_CTRL_DAC_BAND_GAP 			 14:13
+#define MISC_CTRL_DAC_POWER				 12:12
+#define MISC_CTRL_DAC_POWER_ENABLE			 0
+#define MISC_CTRL_DAC_POWER_DISABLE			 1
+#define MISC_CTRL_USB_SLAVE_CONTROLLER 		 11:11
+#define MISC_CTRL_USB_SLAVE_CONTROLLER_CPU		 0
+#define MISC_CTRL_USB_SLAVE_CONTROLLER_8051		 1
+#define MISC_CTRL_BURST_LENGTH 			 10:10
+#define MISC_CTRL_BURST_LENGTH_8			 0
+#define MISC_CTRL_BURST_LENGTH_1			 1
+#define MISC_CTRL_USB_SELECT				 9:9
+#define MISC_CTRL_USB_SELECT_MASTER			 0
+#define MISC_CTRL_USB_SELECT_SLAVE			 1
+#define MISC_CTRL_LOOPBACK				 8:8
+#define MISC_CTRL_LOOPBACK_NORMAL			 0
+#define MISC_CTRL_LOOPBACK_USB_HOST			 1
+#define MISC_CTRL_CLOCK_DIVIDER_RESET			 7:7
+#define MISC_CTRL_CLOCK_DIVIDER_RESET_ENABLE		 0
+#define MISC_CTRL_CLOCK_DIVIDER_RESET_DISABLE		 1
+#define MISC_CTRL_TEST_MODE				 6:5
+#define MISC_CTRL_TEST_MODE_NORMAL			 0
+#define MISC_CTRL_TEST_MODE_DEBUGGING			 1
+#define MISC_CTRL_TEST_MODE_NAND			 2
+#define MISC_CTRL_TEST_MODE_MEMORY			 3
+#define MISC_CTRL_NEC_MMIO				 4:4
+#define MISC_CTRL_NEC_MMIO_30				 0
+#define MISC_CTRL_NEC_MMIO_62				 1
+#define MISC_CTRL_CLOCK				 3:3
+#define MISC_CTRL_CLOCK_PLL				 0
+#define MISC_CTRL_CLOCK_TEST				 1
+#define MISC_CTRL_HOST_BUS				 2:0
+#define MISC_CTRL_HOST_BUS_HITACHI			 0
+#define MISC_CTRL_HOST_BUS_PCI 			 1
+#define MISC_CTRL_HOST_BUS_XSCALE			 2
+#define MISC_CTRL_HOST_BUS_STRONGARM			 4
+#define MISC_CTRL_HOST_BUS_NEC 			 6
+
+#define GPIO_MUX_LOW					 0x000008
+#define GPIO_MUX_LOW_31				 31:31
+#define GPIO_MUX_LOW_31_GPIO				 0
+#define GPIO_MUX_LOW_31_PWM				 1
+#define GPIO_MUX_LOW_30				 30:30
+#define GPIO_MUX_LOW_30_GPIO				 0
+#define GPIO_MUX_LOW_30_PWM				 1
+#define GPIO_MUX_LOW_29				 29:29
+#define GPIO_MUX_LOW_29_GPIO				 0
+#define GPIO_MUX_LOW_29_PWM				 1
+#define GPIO_MUX_LOW_28				 28:28
+#define GPIO_MUX_LOW_28_GPIO				 0
+#define GPIO_MUX_LOW_28_AC97_I2S			 1
+#define GPIO_MUX_LOW_27				 27:27
+#define GPIO_MUX_LOW_27_GPIO				 0
+#define GPIO_MUX_LOW_27_AC97_I2S			 1
+#define GPIO_MUX_LOW_26				 26:26
+#define GPIO_MUX_LOW_26_GPIO				 0
+#define GPIO_MUX_LOW_26_AC97_I2S			 1
+#define GPIO_MUX_LOW_25				 25:25
+#define GPIO_MUX_LOW_25_GPIO				 0
+#define GPIO_MUX_LOW_25_AC97_I2S			 1
+#define GPIO_MUX_LOW_24				 24:24
+#define GPIO_MUX_LOW_24_GPIO				 0
+#define GPIO_MUX_LOW_24_AC97				 1
+#define GPIO_MUX_LOW_23				 23:23
+#define GPIO_MUX_LOW_23_GPIO				 0
+#define GPIO_MUX_LOW_23_ZVPORT 			 1
+#define GPIO_MUX_LOW_22				 22:22
+#define GPIO_MUX_LOW_22_GPIO				 0
+#define GPIO_MUX_LOW_22_ZVPORT 			 1
+#define GPIO_MUX_LOW_21				 21:21
+#define GPIO_MUX_LOW_21_GPIO				 0
+#define GPIO_MUX_LOW_21_ZVPORT 			 1
+#define GPIO_MUX_LOW_20				 20:20
+#define GPIO_MUX_LOW_20_GPIO				 0
+#define GPIO_MUX_LOW_20_ZVPORT 			 1
+#define GPIO_MUX_LOW_19				 19:19
+#define GPIO_MUX_LOW_19_GPIO				 0
+#define GPIO_MUX_LOW_19_ZVPORT 			 1
+#define GPIO_MUX_LOW_18				 18:18
+#define GPIO_MUX_LOW_18_GPIO				 0
+#define GPIO_MUX_LOW_18_ZVPORT 			 1
+#define GPIO_MUX_LOW_17				 17:17
+#define GPIO_MUX_LOW_17_GPIO				 0
+#define GPIO_MUX_LOW_17_ZVPORT 			 1
+#define GPIO_MUX_LOW_16				 16:16
+#define GPIO_MUX_LOW_16_GPIO				 0
+#define GPIO_MUX_LOW_16_ZVPORT 			 1
+#define GPIO_MUX_LOW_15				 15:15
+#define GPIO_MUX_LOW_15_GPIO				 0
+#define GPIO_MUX_LOW_15_8051				 1
+#define GPIO_MUX_LOW_14				 14:14
+#define GPIO_MUX_LOW_14_GPIO				 0
+#define GPIO_MUX_LOW_14_8051				 1
+#define GPIO_MUX_LOW_13				 13:13
+#define GPIO_MUX_LOW_13_GPIO				 0
+#define GPIO_MUX_LOW_13_8051				 1
+#define GPIO_MUX_LOW_12				 12:12
+#define GPIO_MUX_LOW_12_GPIO				 0
+#define GPIO_MUX_LOW_12_8051				 1
+#define GPIO_MUX_LOW_11				 11:11
+#define GPIO_MUX_LOW_11_GPIO				 0
+#define GPIO_MUX_LOW_11_8051				 1
+#define GPIO_MUX_LOW_10				 10:10
+#define GPIO_MUX_LOW_10_GPIO				 0
+#define GPIO_MUX_LOW_10_8051				 1
+#define GPIO_MUX_LOW_9 				 9:9
+#define GPIO_MUX_LOW_9_GPIO				 0
+#define GPIO_MUX_LOW_9_8051				 1
+#define GPIO_MUX_LOW_8 				 8:8
+#define GPIO_MUX_LOW_8_GPIO				 0
+#define GPIO_MUX_LOW_8_8051				 1
+#define GPIO_MUX_LOW_7 				 7:7
+#define GPIO_MUX_LOW_7_GPIO				 0
+#define GPIO_MUX_LOW_7_8051				 1
+#define GPIO_MUX_LOW_6 				 6:6
+#define GPIO_MUX_LOW_6_GPIO				 0
+#define GPIO_MUX_LOW_6_8051				 1
+#define GPIO_MUX_LOW_5 				 5:5
+#define GPIO_MUX_LOW_5_GPIO				 0
+#define GPIO_MUX_LOW_5_8051				 1
+#define GPIO_MUX_LOW_4 				 4:4
+#define GPIO_MUX_LOW_4_GPIO				 0
+#define GPIO_MUX_LOW_4_8051				 1
+#define GPIO_MUX_LOW_3 				 3:3
+#define GPIO_MUX_LOW_3_GPIO				 0
+#define GPIO_MUX_LOW_3_8051				 1
+#define GPIO_MUX_LOW_2 				 2:2
+#define GPIO_MUX_LOW_2_GPIO				 0
+#define GPIO_MUX_LOW_2_8051				 1
+#define GPIO_MUX_LOW_1 				 1:1
+#define GPIO_MUX_LOW_1_GPIO				 0
+#define GPIO_MUX_LOW_1_8051				 1
+#define GPIO_MUX_LOW_0 				 0:0
+#define GPIO_MUX_LOW_0_GPIO				 0
+#define GPIO_MUX_LOW_0_8051				 1
+
+#define GPIO_MUX_HIGH					 0x00000C
+#define GPIO_MUX_HIGH_63				 31:31
+#define GPIO_MUX_HIGH_63_GPIO				 0
+#define GPIO_MUX_HIGH_63_CRT_ZVPORT_FPDATA		 1
+#define GPIO_MUX_HIGH_62				 30:30
+#define GPIO_MUX_HIGH_62_GPIO				 0
+#define GPIO_MUX_HIGH_62_CRT_ZVPORT_FPDATA		 1
+#define GPIO_MUX_HIGH_61				 29:29
+#define GPIO_MUX_HIGH_61_GPIO				 0
+#define GPIO_MUX_HIGH_61_CRT_ZVPORT_FPDATA		 1
+#define GPIO_MUX_HIGH_60				 28:28
+#define GPIO_MUX_HIGH_60_GPIO				 0
+#define GPIO_MUX_HIGH_60_CRT_ZVPORT_FPDATA		 1
+#define GPIO_MUX_HIGH_59				 27:27
+#define GPIO_MUX_HIGH_59_GPIO				 0
+#define GPIO_MUX_HIGH_59_CRT_ZVPORT_FPDATA		 1
+#define GPIO_MUX_HIGH_58				 26:26
+#define GPIO_MUX_HIGH_58_GPIO				 0
+#define GPIO_MUX_HIGH_58_CRT_ZVPORT_FPDATA		 1
+#define GPIO_MUX_HIGH_57				 25:25
+#define GPIO_MUX_HIGH_57_GPIO				 0
+#define GPIO_MUX_HIGH_57_CRT_ZVPORT			 1
+#define GPIO_MUX_HIGH_56				 24:24
+#define GPIO_MUX_HIGH_56_GPIO				 0
+#define GPIO_MUX_HIGH_56_CRT_ZVPORT			 1
+#define GPIO_MUX_HIGH_55				 23:23
+#define GPIO_MUX_HIGH_55_GPIO				 0
+#define GPIO_MUX_HIGH_55_CRT				 1
+#define GPIO_MUX_HIGH_47				 15:15
+#define GPIO_MUX_HIGH_47_GPIO				 0
+#define GPIO_MUX_HIGH_47_I2C				 1
+#define GPIO_MUX_HIGH_46				 14:14
+#define GPIO_MUX_HIGH_46_GPIO				 0
+#define GPIO_MUX_HIGH_46_I2C				 1
+#define GPIO_MUX_HIGH_45				 13:13
+#define GPIO_MUX_HIGH_45_GPIO				 0
+#define GPIO_MUX_HIGH_45_SSP1				 1
+#define GPIO_MUX_HIGH_44				 12:12
+#define GPIO_MUX_HIGH_44_GPIO				 0
+#define GPIO_MUX_HIGH_44_UART1_SSP1			 1
+#define GPIO_MUX_HIGH_43				 11:11
+#define GPIO_MUX_HIGH_43_GPIO				 0
+#define GPIO_MUX_HIGH_43_UART1_SSP1			 1
+#define GPIO_MUX_HIGH_42				 10:10
+#define GPIO_MUX_HIGH_42_GPIO				 0
+#define GPIO_MUX_HIGH_42_UART1_SSP1			 1
+#define GPIO_MUX_HIGH_41				 9:9
+#define GPIO_MUX_HIGH_41_GPIO				 0
+#define GPIO_MUX_HIGH_41_UART1_SSP1			 1
+#define GPIO_MUX_HIGH_40				 8:8
+#define GPIO_MUX_HIGH_40_GPIO				 0
+#define GPIO_MUX_HIGH_40_UART0 			 1
+#define GPIO_MUX_HIGH_39				 7:7
+#define GPIO_MUX_HIGH_39_GPIO				 0
+#define GPIO_MUX_HIGH_39_UART0 			 1
+#define GPIO_MUX_HIGH_38				 6:6
+#define GPIO_MUX_HIGH_38_GPIO				 0
+#define GPIO_MUX_HIGH_38_UART0 			 1
+#define GPIO_MUX_HIGH_37				 5:5
+#define GPIO_MUX_HIGH_37_GPIO				 0
+#define GPIO_MUX_HIGH_37_UART0 			 1
+#define GPIO_MUX_HIGH_36				 4:4
+#define GPIO_MUX_HIGH_36_GPIO				 0
+#define GPIO_MUX_HIGH_36_SSP0				 1
+#define GPIO_MUX_HIGH_35				 3:3
+#define GPIO_MUX_HIGH_35_GPIO				 0
+#define GPIO_MUX_HIGH_35_SSP0				 1
+#define GPIO_MUX_HIGH_34				 2:2
+#define GPIO_MUX_HIGH_34_GPIO				 0
+#define GPIO_MUX_HIGH_34_SSP0				 1
+#define GPIO_MUX_HIGH_33				 1:1
+#define GPIO_MUX_HIGH_33_GPIO				 0
+#define GPIO_MUX_HIGH_33_SSP0				 1
+#define GPIO_MUX_HIGH_32				 0:0
+#define GPIO_MUX_HIGH_32_GPIO				 0
+#define GPIO_MUX_HIGH_32_SSP0				 1
+
+#define DRAM_CTRL					 0x000010
+#define DRAM_CTRL_EMBEDDED				 31:31
+#define DRAM_CTRL_EMBEDDED_ENABLE			 0
+#define DRAM_CTRL_EMBEDDED_DISABLE			 1
+#define DRAM_CTRL_CPU_BURST				 30:28
+#define DRAM_CTRL_CPU_BURST_1				 0
+#define DRAM_CTRL_CPU_BURST_2				 1
+#define DRAM_CTRL_CPU_BURST_4				 2
+#define DRAM_CTRL_CPU_BURST_8				 3
+#define DRAM_CTRL_CPU_CAS_LATENCY			 27:27
+#define DRAM_CTRL_CPU_CAS_LATENCY_2			 0
+#define DRAM_CTRL_CPU_CAS_LATENCY_3			 1
+#define DRAM_CTRL_CPU_SIZE				 26:24
+#define DRAM_CTRL_CPU_SIZE_2				 0
+#define DRAM_CTRL_CPU_SIZE_4				 1
+#define DRAM_CTRL_CPU_SIZE_64				 4
+#define DRAM_CTRL_CPU_SIZE_32				 5
+#define DRAM_CTRL_CPU_SIZE_16				 6
+#define DRAM_CTRL_CPU_SIZE_8				 7
+#define DRAM_CTRL_CPU_COLUMN_SIZE			 23:22
+#define DRAM_CTRL_CPU_COLUMN_SIZE_1024 		 0
+#define DRAM_CTRL_CPU_COLUMN_SIZE_512			 2
+#define DRAM_CTRL_CPU_COLUMN_SIZE_256			 3
+#define DRAM_CTRL_CPU_ACTIVE_PRECHARGE 		 21:21
+#define DRAM_CTRL_CPU_ACTIVE_PRECHARGE_6		 0
+#define DRAM_CTRL_CPU_ACTIVE_PRECHARGE_7		 1
+#define DRAM_CTRL_CPU_RESET				 20:20
+#define DRAM_CTRL_CPU_RESET_ENABLE			 0
+#define DRAM_CTRL_CPU_RESET_DISABLE			 1
+#define DRAM_CTRL_CPU_BANKS				 19:19
+#define DRAM_CTRL_CPU_BANKS_2				 0
+#define DRAM_CTRL_CPU_BANKS_4				 1
+#define DRAM_CTRL_CPU_WRITE_PRECHARGE			 18:18
+#define DRAM_CTRL_CPU_WRITE_PRECHARGE_2		 0
+#define DRAM_CTRL_CPU_WRITE_PRECHARGE_1		 1
+#define DRAM_CTRL_BLOCK_WRITE				 17:17
+#define DRAM_CTRL_BLOCK_WRITE_DISABLE			 0
+#define DRAM_CTRL_BLOCK_WRITE_ENABLE			 1
+#define DRAM_CTRL_REFRESH_COMMAND			 16:16
+#define DRAM_CTRL_REFRESH_COMMAND_10			 0
+#define DRAM_CTRL_REFRESH_COMMAND_12			 1
+#define DRAM_CTRL_SIZE 				 15:13
+#define DRAM_CTRL_SIZE_4				 0
+#define DRAM_CTRL_SIZE_8				 1
+#define DRAM_CTRL_SIZE_16				 2
+#define DRAM_CTRL_SIZE_32				 3
+#define DRAM_CTRL_SIZE_64				 4
+#define DRAM_CTRL_SIZE_2				 5
+#define DRAM_CTRL_COLUMN_SIZE				 12:11
+#define DRAM_CTRL_COLUMN_SIZE_256			 0
+#define DRAM_CTRL_COLUMN_SIZE_512			 2
+#define DRAM_CTRL_COLUMN_SIZE_1024			 3
+#define DRAM_CTRL_BLOCK_WRITE_TIME			 10:10
+#define DRAM_CTRL_BLOCK_WRITE_TIME_1			 0
+#define DRAM_CTRL_BLOCK_WRITE_TIME_2			 1
+#define DRAM_CTRL_BLOCK_WRITE_PRECHARGE		 9:9
+#define DRAM_CTRL_BLOCK_WRITE_PRECHARGE_4		 0
+#define DRAM_CTRL_BLOCK_WRITE_PRECHARGE_1		 1
+#define DRAM_CTRL_ACTIVE_PRECHARGE			 8:8
+#define DRAM_CTRL_ACTIVE_PRECHARGE_6			 0
+#define DRAM_CTRL_ACTIVE_PRECHARGE_7			 1
+#define DRAM_CTRL_RESET				 7:7
+#define DRAM_CTRL_RESET_ENABLE 			 0
+#define DRAM_CTRL_RESET_DISABLE			 1
+#define DRAM_CTRL_REMAIN_ACTIVE			 6:6
+#define DRAM_CTRL_REMAIN_ACTIVE_ENABLE 		 0
+#define DRAM_CTRL_REMAIN_ACTIVE_DISABLE		 1
+#define DRAM_CTRL_BANKS				 1:1
+#define DRAM_CTRL_BANKS_2				 0
+#define DRAM_CTRL_BANKS_4				 1
+#define DRAM_CTRL_WRITE_PRECHARGE			 0:0
+#define DRAM_CTRL_WRITE_PRECHARGE_2			 0
+#define DRAM_CTRL_WRITE_PRECHARGE_1			 1
+
+#define ARBITRATION_CTRL				 0x000014
+#define ARBITRATION_CTRL_CPUMEM			 29:29
+#define ARBITRATION_CTRL_CPUMEM_FIXED			 0
+#define ARBITRATION_CTRL_CPUMEM_ROTATE 		 1
+#define ARBITRATION_CTRL_INTMEM			 28:28
+#define ARBITRATION_CTRL_INTMEM_FIXED			 0
+#define ARBITRATION_CTRL_INTMEM_ROTATE 		 1
+#define ARBITRATION_CTRL_USB				 27:24
+#define ARBITRATION_CTRL_USB_OFF			 0
+#define ARBITRATION_CTRL_USB_PRIORITY_1		 1
+#define ARBITRATION_CTRL_USB_PRIORITY_2		 2
+#define ARBITRATION_CTRL_USB_PRIORITY_3		 3
+#define ARBITRATION_CTRL_USB_PRIORITY_4		 4
+#define ARBITRATION_CTRL_USB_PRIORITY_5		 5
+#define ARBITRATION_CTRL_USB_PRIORITY_6		 6
+#define ARBITRATION_CTRL_USB_PRIORITY_7		 7
+#define ARBITRATION_CTRL_PANEL 			 23:20
+#define ARBITRATION_CTRL_PANEL_OFF			 0
+#define ARBITRATION_CTRL_PANEL_PRIORITY_1		 1
+#define ARBITRATION_CTRL_PANEL_PRIORITY_2		 2
+#define ARBITRATION_CTRL_PANEL_PRIORITY_3		 3
+#define ARBITRATION_CTRL_PANEL_PRIORITY_4		 4
+#define ARBITRATION_CTRL_PANEL_PRIORITY_5		 5
+#define ARBITRATION_CTRL_PANEL_PRIORITY_6		 6
+#define ARBITRATION_CTRL_PANEL_PRIORITY_7		 7
+#define ARBITRATION_CTRL_ZVPORT			 19:16
+#define ARBITRATION_CTRL_ZVPORT_OFF			 0
+#define ARBITRATION_CTRL_ZVPORT_PRIORITY_1		 1
+#define ARBITRATION_CTRL_ZVPORT_PRIORITY_2		 2
+#define ARBITRATION_CTRL_ZVPORT_PRIORITY_3		 3
+#define ARBITRATION_CTRL_ZVPORT_PRIORITY_4		 4
+#define ARBITRATION_CTRL_ZVPORT_PRIORITY_5		 5
+#define ARBITRATION_CTRL_ZVPORT_PRIORITY_6		 6
+#define ARBITRATION_CTRL_ZVPORT_PRIORITY_7		 7
+#define ARBITRATION_CTRL_CMD_INTPR			 15:12
+#define ARBITRATION_CTRL_CMD_INTPR_OFF 		 0
+#define ARBITRATION_CTRL_CMD_INTPR_PRIORITY_1		 1
+#define ARBITRATION_CTRL_CMD_INTPR_PRIORITY_2		 2
+#define ARBITRATION_CTRL_CMD_INTPR_PRIORITY_3		 3
+#define ARBITRATION_CTRL_CMD_INTPR_PRIORITY_4		 4
+#define ARBITRATION_CTRL_CMD_INTPR_PRIORITY_5		 5
+#define ARBITRATION_CTRL_CMD_INTPR_PRIORITY_6		 6
+#define ARBITRATION_CTRL_CMD_INTPR_PRIORITY_7		 7
+#define ARBITRATION_CTRL_DMA				 11:8
+#define ARBITRATION_CTRL_DMA_OFF			 0
+#define ARBITRATION_CTRL_DMA_PRIORITY_1		 1
+#define ARBITRATION_CTRL_DMA_PRIORITY_2		 2
+#define ARBITRATION_CTRL_DMA_PRIORITY_3		 3
+#define ARBITRATION_CTRL_DMA_PRIORITY_4		 4
+#define ARBITRATION_CTRL_DMA_PRIORITY_5		 5
+#define ARBITRATION_CTRL_DMA_PRIORITY_6		 6
+#define ARBITRATION_CTRL_DMA_PRIORITY_7		 7
+#define ARBITRATION_CTRL_VIDEO 			 7:4
+#define ARBITRATION_CTRL_VIDEO_OFF			 0
+#define ARBITRATION_CTRL_VIDEO_PRIORITY_1		 1
+#define ARBITRATION_CTRL_VIDEO_PRIORITY_2		 2
+#define ARBITRATION_CTRL_VIDEO_PRIORITY_3		 3
+#define ARBITRATION_CTRL_VIDEO_PRIORITY_4		 4
+#define ARBITRATION_CTRL_VIDEO_PRIORITY_5		 5
+#define ARBITRATION_CTRL_VIDEO_PRIORITY_6		 6
+#define ARBITRATION_CTRL_VIDEO_PRIORITY_7		 7
+#define ARBITRATION_CTRL_CRT				 3:0
+#define ARBITRATION_CTRL_CRT_OFF			 0
+#define ARBITRATION_CTRL_CRT_PRIORITY_1		 1
+#define ARBITRATION_CTRL_CRT_PRIORITY_2		 2
+#define ARBITRATION_CTRL_CRT_PRIORITY_3		 3
+#define ARBITRATION_CTRL_CRT_PRIORITY_4		 4
+#define ARBITRATION_CTRL_CRT_PRIORITY_5		 5
+#define ARBITRATION_CTRL_CRT_PRIORITY_6		 6
+#define ARBITRATION_CTRL_CRT_PRIORITY_7		 7
+
+#define CMD_INTPR_CTRL 				 0x000018
+#define CMD_INTPR_CTRL_STATUS				 31:31
+#define CMD_INTPR_CTRL_STATUS_STOPPED			 0
+#define CMD_INTPR_CTRL_STATUS_RUNNING			 1
+#define CMD_INTPR_CTRL_EXT				 27:27
+#define CMD_INTPR_CTRL_EXT_LOCAL			 0
+#define CMD_INTPR_CTRL_EXT_EXTERNAL			 1
+#define CMD_INTPR_CTRL_CS				 26:26
+#define CMD_INTPR_CTRL_CS_0				 0
+#define CMD_INTPR_CTRL_CS_1				 1
+#define CMD_INTPR_CTRL_ADDRESS 			 25:0
+
+#define CMD_INTPR_CONDITIONS				 0x00001C
+
+#define CMD_INTPR_RETURN				 0x000020
+#define CMD_INTPR_RETURN_EXT				 27:27
+#define CMD_INTPR_RETURN_EXT_LOCAL			 0
+#define CMD_INTPR_RETURN_EXT_EXTERNAL			 1
+#define CMD_INTPR_RETURN_CS				 26:26
+#define CMD_INTPR_RETURN_CS_0				 0
+#define CMD_INTPR_RETURN_CS_1				 1
+#define CMD_INTPR_RETURN_ADDRESS			 25:0
+
+#define CMD_INTPR_STATUS				 0x000024
+#define CMD_INTPR_STATUS_2D_MEMORY_FIFO		 20:20
+#define CMD_INTPR_STATUS_2D_MEMORY_FIFO_NOT_EMPTY	 0
+#define CMD_INTPR_STATUS_2D_MEMORY_FIFO_EMPTY		 1
+#define CMD_INTPR_STATUS_COMMAND_FIFO			 19:19
+#define CMD_INTPR_STATUS_COMMAND_FIFO_NOT_EMPTY	 0
+#define CMD_INTPR_STATUS_COMMAND_FIFO_EMPTY		 1
+#define CMD_INTPR_STATUS_CSC_STATUS			 18:18
+#define CMD_INTPR_STATUS_CSC_STATUS_IDLE		 0
+#define CMD_INTPR_STATUS_CSC_STATUS_BUSY		 1
+#define CMD_INTPR_STATUS_MEMORY_DMA			 17:17
+#define CMD_INTPR_STATUS_MEMORY_DMA_IDLE		 0
+#define CMD_INTPR_STATUS_MEMORY_DMA_BUSY		 1
+#define CMD_INTPR_STATUS_CRT_STATUS			 16:16
+#define CMD_INTPR_STATUS_CRT_STATUS_CURRENT		 0
+#define CMD_INTPR_STATUS_CRT_STATUS_PENDING		 1
+#define CMD_INTPR_STATUS_CURRENT_FIELD 		 15:15
+#define CMD_INTPR_STATUS_CURRENT_FIELD_ODD		 0
+#define CMD_INTPR_STATUS_CURRENT_FIELD_EVEN		 1
+#define CMD_INTPR_STATUS_VIDEO_STATUS			 14:14
+#define CMD_INTPR_STATUS_VIDEO_STATUS_CURRENT		 0
+#define CMD_INTPR_STATUS_VIDEO_STATUS_PENDING		 1
+#define CMD_INTPR_STATUS_PANEL_STATUS			 13:13
+#define CMD_INTPR_STATUS_PANEL_STATUS_CURRENT		 0
+#define CMD_INTPR_STATUS_PANEL_STATUS_PENDING		 1
+#define CMD_INTPR_STATUS_CRT_SYNC			 12:12
+#define CMD_INTPR_STATUS_CRT_SYNC_INACTIVE		 0
+#define CMD_INTPR_STATUS_CRT_SYNC_ACTIVE		 1
+#define CMD_INTPR_STATUS_PANEL_SYNC			 11:11
+#define CMD_INTPR_STATUS_PANEL_SYNC_INACTIVE		 0
+#define CMD_INTPR_STATUS_PANEL_SYNC_ACTIVE		 1
+#define CMD_INTPR_STATUS_2D_SETUP			 2:2
+#define CMD_INTPR_STATUS_2D_SETUP_IDLE 		 0
+#define CMD_INTPR_STATUS_2D_SETUP_BUSY 		 1
+#define CMD_INTPR_STATUS_2D_FIFO			 1:1
+#define CMD_INTPR_STATUS_2D_FIFO_NOT_EMPTY		 0
+#define CMD_INTPR_STATUS_2D_FIFO_EMPTY 		 1
+#define CMD_INTPR_STATUS_2D_ENGINE			 0:0
+#define CMD_INTPR_STATUS_2D_ENGINE_IDLE		 0
+#define CMD_INTPR_STATUS_2D_ENGINE_BUSY		 1
+
+#define RAW_INT_STATUS 				 0x000028
+#define RAW_INT_STATUS_USB_SLAVE_PLUG_IN		 5:5
+#define RAW_INT_STATUS_USB_SLAVE_PLUG_IN_INACTIVE	 0
+#define RAW_INT_STATUS_USB_SLAVE_PLUG_IN_ACTIVE	 1
+#define RAW_INT_STATUS_USB_SLAVE_PLUG_IN_CLEAR 	 1
+#define RAW_INT_STATUS_ZVPORT				 4:4
+#define RAW_INT_STATUS_ZVPORT_INACTIVE 		 0
+#define RAW_INT_STATUS_ZVPORT_ACTIVE			 1
+#define RAW_INT_STATUS_ZVPORT_CLEAR			 1
+#define RAW_INT_STATUS_CRT_VSYNC			 3:3
+#define RAW_INT_STATUS_CRT_VSYNC_INACTIVE		 0
+#define RAW_INT_STATUS_CRT_VSYNC_ACTIVE		 1
+#define RAW_INT_STATUS_CRT_VSYNC_CLEAR 		 1
+#define RAW_INT_STATUS_USB_SLAVE			 2:2
+#define RAW_INT_STATUS_USB_SLAVE_INACTIVE		 0
+#define RAW_INT_STATUS_USB_SLAVE_ACTIVE		 1
+#define RAW_INT_STATUS_USB_SLAVE_CLEAR 		 1
+#define RAW_INT_STATUS_PANEL_VSYNC			 1:1
+#define RAW_INT_STATUS_PANEL_VSYNC_INACTIVE		 0
+#define RAW_INT_STATUS_PANEL_VSYNC_ACTIVE		 1
+#define RAW_INT_STATUS_PANEL_VSYNC_CLEAR		 1
+#define RAW_INT_STATUS_CMD_INTPR			 0:0
+#define RAW_INT_STATUS_CMD_INTPR_INACTIVE		 0
+#define RAW_INT_STATUS_CMD_INTPR_ACTIVE		 1
+#define RAW_INT_STATUS_CMD_INTPR_CLEAR 		 1
+
+#define INT_STATUS					 0x00002C
+#define INT_STATUS_USB_SLAVE_PLUG_IN			 31:31
+#define INT_STATUS_USB_SLAVE_PLUG_IN_INACTIVE		 0
+#define INT_STATUS_USB_SLAVE_PLUG_IN_ACTIVE		 1
+#define INT_STATUS_GPIO54				 30:30
+#define INT_STATUS_GPIO54_INACTIVE			 0
+#define INT_STATUS_GPIO54_ACTIVE			 1
+#define INT_STATUS_GPIO53				 29:29
+#define INT_STATUS_GPIO53_INACTIVE			 0
+#define INT_STATUS_GPIO53_ACTIVE			 1
+#define INT_STATUS_GPIO52				 28:28
+#define INT_STATUS_GPIO52_INACTIVE			 0
+#define INT_STATUS_GPIO52_ACTIVE			 1
+#define INT_STATUS_GPIO51				 27:27
+#define INT_STATUS_GPIO51_INACTIVE			 0
+#define INT_STATUS_GPIO51_ACTIVE			 1
+#define INT_STATUS_GPIO50				 26:26
+#define INT_STATUS_GPIO50_INACTIVE			 0
+#define INT_STATUS_GPIO50_ACTIVE			 1
+#define INT_STATUS_GPIO49				 25:25
+#define INT_STATUS_GPIO49_INACTIVE			 0
+#define INT_STATUS_GPIO49_ACTIVE			 1
+#define INT_STATUS_GPIO48				 24:24
+#define INT_STATUS_GPIO48_INACTIVE			 0
+#define INT_STATUS_GPIO48_ACTIVE			 1
+#define INT_STATUS_I2C 				 23:23
+#define INT_STATUS_I2C_INACTIVE			 0
+#define INT_STATUS_I2C_ACTIVE				 1
+#define INT_STATUS_PWM 				 22:22
+#define INT_STATUS_PWM_INACTIVE			 0
+#define INT_STATUS_PWM_ACTIVE				 1
+#define INT_STATUS_DMA 				 20:20
+#define INT_STATUS_DMA_INACTIVE			 0
+#define INT_STATUS_DMA_ACTIVE				 1
+#define INT_STATUS_PCI 				 19:19
+#define INT_STATUS_PCI_INACTIVE			 0
+#define INT_STATUS_PCI_ACTIVE				 1
+#define INT_STATUS_I2S 				 18:18
+#define INT_STATUS_I2S_INACTIVE			 0
+#define INT_STATUS_I2S_ACTIVE				 1
+#define INT_STATUS_AC97				 17:17
+#define INT_STATUS_AC97_INACTIVE			 0
+#define INT_STATUS_AC97_ACTIVE 			 1
+#define INT_STATUS_USB_SLAVE				 16:16
+#define INT_STATUS_USB_SLAVE_INACTIVE			 0
+#define INT_STATUS_USB_SLAVE_ACTIVE			 1
+#define INT_STATUS_UART1				 13:13
+#define INT_STATUS_UART1_INACTIVE			 0
+#define INT_STATUS_UART1_ACTIVE			 1
+#define INT_STATUS_UART0				 12:12
+#define INT_STATUS_UART0_INACTIVE			 0
+#define INT_STATUS_UART0_ACTIVE			 1
+#define INT_STATUS_CRT_VSYNC				 11:11
+#define INT_STATUS_CRT_VSYNC_INACTIVE			 0
+#define INT_STATUS_CRT_VSYNC_ACTIVE			 1
+#define INT_STATUS_8051				 10:10
+#define INT_STATUS_8051_INACTIVE			 0
+#define INT_STATUS_8051_ACTIVE 			 1
+#define INT_STATUS_SSP1				 9:9
+#define INT_STATUS_SSP1_INACTIVE			 0
+#define INT_STATUS_SSP1_ACTIVE 			 1
+#define INT_STATUS_SSP0				 8:8
+#define INT_STATUS_SSP0_INACTIVE			 0
+#define INT_STATUS_SSP0_ACTIVE 			 1
+#define INT_STATUS_USB_HOST				 6:6
+#define INT_STATUS_USB_HOST_INACTIVE			 0
+#define INT_STATUS_USB_HOST_ACTIVE			 1
+#define INT_STATUS_2D					 3:3
+#define INT_STATUS_2D_INACTIVE 			 0
+#define INT_STATUS_2D_ACTIVE				 1
+#define INT_STATUS_ZVPORT				 2:2
+#define INT_STATUS_ZVPORT_INACTIVE			 0
+#define INT_STATUS_ZVPORT_ACTIVE			 1
+#define INT_STATUS_PANEL_VSYNC 			 1:1
+#define INT_STATUS_PANEL_VSYNC_INACTIVE		 0
+#define INT_STATUS_PANEL_VSYNC_ACTIVE			 1
+#define INT_STATUS_CMD_INTPR				 0:0
+#define INT_STATUS_CMD_INTPR_INACTIVE			 0
+#define INT_STATUS_CMD_INTPR_ACTIVE			 1
+
+#define INT_MASK					 0x000030
+#define INT_MASK_USB_SLAVE_PLUG_IN			 31:31
+#define INT_MASK_USB_SLAVE_PLUG_IN_DISABLE		 0
+#define INT_MASK_USB_SLAVE_PLUG_IN_ENABLE		 1
+#define INT_MASK_GPIO54				 30:30
+#define INT_MASK_GPIO54_DISABLE			 0
+#define INT_MASK_GPIO54_ENABLE 			 1
+#define INT_MASK_GPIO53				 29:29
+#define INT_MASK_GPIO53_DISABLE			 0
+#define INT_MASK_GPIO53_ENABLE 			 1
+#define INT_MASK_GPIO52				 28:28
+#define INT_MASK_GPIO52_DISABLE			 0
+#define INT_MASK_GPIO52_ENABLE 			 1
+#define INT_MASK_GPIO51				 27:27
+#define INT_MASK_GPIO51_DISABLE			 0
+#define INT_MASK_GPIO51_ENABLE 			 1
+#define INT_MASK_GPIO50				 26:26
+#define INT_MASK_GPIO50_DISABLE			 0
+#define INT_MASK_GPIO50_ENABLE 			 1
+#define INT_MASK_GPIO49				 25:25
+#define INT_MASK_GPIO49_DISABLE			 0
+#define INT_MASK_GPIO49_ENABLE 			 1
+#define INT_MASK_GPIO48				 24:24
+#define INT_MASK_GPIO48_DISABLE			 0
+#define INT_MASK_GPIO48_ENABLE 			 1
+#define INT_MASK_I2C					 23:23
+#define INT_MASK_I2C_DISABLE				 0
+#define INT_MASK_I2C_ENABLE				 1
+#define INT_MASK_PWM					 22:22
+#define INT_MASK_PWM_DISABLE				 0
+#define INT_MASK_PWM_ENABLE				 1
+#define INT_MASK_DMA					 20:20
+#define INT_MASK_DMA_DISABLE				 0
+#define INT_MASK_DMA_ENABLE				 1
+#define INT_MASK_PCI					 19:19
+#define INT_MASK_PCI_DISABLE				 0
+#define INT_MASK_PCI_ENABLE				 1
+#define INT_MASK_I2S					 18:18
+#define INT_MASK_I2S_DISABLE				 0
+#define INT_MASK_I2S_ENABLE				 1
+#define INT_MASK_AC97					 17:17
+#define INT_MASK_AC97_DISABLE				 0
+#define INT_MASK_AC97_ENABLE				 1
+#define INT_MASK_USB_SLAVE				 16:16
+#define INT_MASK_USB_SLAVE_DISABLE			 0
+#define INT_MASK_USB_SLAVE_ENABLE			 1
+#define INT_MASK_UART1 				 13:13
+#define INT_MASK_UART1_DISABLE 			 0
+#define INT_MASK_UART1_ENABLE				 1
+#define INT_MASK_UART0 				 12:12
+#define INT_MASK_UART0_DISABLE 			 0
+#define INT_MASK_UART0_ENABLE				 1
+#define INT_MASK_CRT_VSYNC				 11:11
+#define INT_MASK_CRT_VSYNC_DISABLE			 0
+#define INT_MASK_CRT_VSYNC_ENABLE			 1
+#define INT_MASK_8051					 10:10
+#define INT_MASK_8051_DISABLE				 0
+#define INT_MASK_8051_ENABLE				 1
+#define INT_MASK_SSP1					 9:9
+#define INT_MASK_SSP1_DISABLE				 0
+#define INT_MASK_SSP1_ENABLE				 1
+#define INT_MASK_SSP0					 8:8
+#define INT_MASK_SSP0_DISABLE				 0
+#define INT_MASK_SSP0_ENABLE				 1
+#define INT_MASK_USB_HOST				 6:6
+#define INT_MASK_USB_HOST_DISABLE			 0
+#define INT_MASK_USB_HOST_ENABLE			 1
+#define INT_MASK_2D					 3:3
+#define INT_MASK_2D_DISABLE				 0
+#define INT_MASK_2D_ENABLE				 1
+#define INT_MASK_ZVPORT				 2:2
+#define INT_MASK_ZVPORT_DISABLE			 0
+#define INT_MASK_ZVPORT_ENABLE 			 1
+#define INT_MASK_PANEL_VSYNC				 1:1
+#define INT_MASK_PANEL_VSYNC_DISABLE			 0
+#define INT_MASK_PANEL_VSYNC_ENABLE			 1
+#define INT_MASK_CMD_INTPR				 0:0
+#define INT_MASK_CMD_INTPR_DISABLE			 0
+#define INT_MASK_CMD_INTPR_ENABLE			 1
+
+#define DEBUG_CTRL					 0x000034
+#define DEBUG_CTRL_MODULE				 7:5
+#define DEBUG_CTRL_PARTITION				 4:0
+#define DEBUG_CTRL_PARTITION_HIF			 0
+#define DEBUG_CTRL_PARTITION_CPUMEM			 1
+#define DEBUG_CTRL_PARTITION_PCI			 2
+#define DEBUG_CTRL_PARTITION_CMD_INTPR 		 3
+#define DEBUG_CTRL_PARTITION_DISPLAY			 4
+#define DEBUG_CTRL_PARTITION_ZVPORT			 5
+#define DEBUG_CTRL_PARTITION_2D			 6
+#define DEBUG_CTRL_PARTITION_MIF			 8
+#define DEBUG_CTRL_PARTITION_USB_HOST			 10
+#define DEBUG_CTRL_PARTITION_SSP0			 12
+#define DEBUG_CTRL_PARTITION_SSP1			 13
+#define DEBUG_CTRL_PARTITION_UART0			 19
+#define DEBUG_CTRL_PARTITION_UART1			 20
+#define DEBUG_CTRL_PARTITION_I2C			 21
+#define DEBUG_CTRL_PARTITION_8051			 23
+#define DEBUG_CTRL_PARTITION_AC97			 24
+#define DEBUG_CTRL_PARTITION_I2S			 25
+#define DEBUG_CTRL_PARTITION_INTMEM			 26
+#define DEBUG_CTRL_PARTITION_DMA			 27
+#define DEBUG_CTRL_PARTITION_SIMULATION		 28
+
+#define CURRENT_POWER_GATE				 0x000038
+#define CURRENT_POWER_GATE_AC97_I2S			 18:18
+#define CURRENT_POWER_GATE_AC97_I2S_DISABLE		 0
+#define CURRENT_POWER_GATE_AC97_I2S_ENABLE		 1
+#define CURRENT_POWER_GATE_8051			 17:17
+#define CURRENT_POWER_GATE_8051_DISABLE		 0
+#define CURRENT_POWER_GATE_8051_ENABLE 		 1
+#define CURRENT_POWER_GATE_PLL 			 16:16
+#define CURRENT_POWER_GATE_PLL_DISABLE 		 0
+#define CURRENT_POWER_GATE_PLL_ENABLE			 1
+#define CURRENT_POWER_GATE_OSCILLATOR			 15:15
+#define CURRENT_POWER_GATE_OSCILLATOR_DISABLE		 0
+#define CURRENT_POWER_GATE_OSCILLATOR_ENABLE		 1
+#define CURRENT_POWER_GATE_PLL_RECOVERY		 14:13
+#define CURRENT_POWER_GATE_PLL_RECOVERY_32		 0
+#define CURRENT_POWER_GATE_PLL_RECOVERY_64		 1
+#define CURRENT_POWER_GATE_PLL_RECOVERY_96		 2
+#define CURRENT_POWER_GATE_PLL_RECOVERY_128		 3
+#define CURRENT_POWER_GATE_USB_SLAVE			 12:12
+#define CURRENT_POWER_GATE_USB_SLAVE_DISABLE		 0
+#define CURRENT_POWER_GATE_USB_SLAVE_ENABLE		 1
+#define CURRENT_POWER_GATE_USB_HOST			 11:11
+#define CURRENT_POWER_GATE_USB_HOST_DISABLE		 0
+#define CURRENT_POWER_GATE_USB_HOST_ENABLE		 1
+#define CURRENT_POWER_GATE_SSP0_SSP1			 10:10
+#define CURRENT_POWER_GATE_SSP0_SSP1_DISABLE		 0
+#define CURRENT_POWER_GATE_SSP0_SSP1_ENABLE		 1
+#define CURRENT_POWER_GATE_UART1			 8:8
+#define CURRENT_POWER_GATE_UART1_DISABLE		 0
+#define CURRENT_POWER_GATE_UART1_ENABLE		 1
+#define CURRENT_POWER_GATE_UART0			 7:7
+#define CURRENT_POWER_GATE_UART0_DISABLE		 0
+#define CURRENT_POWER_GATE_UART0_ENABLE		 1
+#define CURRENT_POWER_GATE_GPIO_PWM_I2C		 6:6
+#define CURRENT_POWER_GATE_GPIO_PWM_I2C_DISABLE	 0
+#define CURRENT_POWER_GATE_GPIO_PWM_I2C_ENABLE 	 1
+#define CURRENT_POWER_GATE_ZVPORT			 5:5
+#define CURRENT_POWER_GATE_ZVPORT_DISABLE		 0
+#define CURRENT_POWER_GATE_ZVPORT_ENABLE		 1
+#define CURRENT_POWER_GATE_CSC 			 4:4
+#define CURRENT_POWER_GATE_CSC_DISABLE 		 0
+#define CURRENT_POWER_GATE_CSC_ENABLE			 1
+#define CURRENT_POWER_GATE_2D				 3:3
+#define CURRENT_POWER_GATE_2D_DISABLE			 0
+#define CURRENT_POWER_GATE_2D_ENABLE			 1
+#define CURRENT_POWER_GATE_DISPLAY			 2:2
+#define CURRENT_POWER_GATE_DISPLAY_DISABLE		 0
+#define CURRENT_POWER_GATE_DISPLAY_ENABLE		 1
+#define CURRENT_POWER_GATE_INTMEM			 1:1
+#define CURRENT_POWER_GATE_INTMEM_DISABLE		 0
+#define CURRENT_POWER_GATE_INTMEM_ENABLE		 1
+#define CURRENT_POWER_GATE_HOST			 0:0
+#define CURRENT_POWER_GATE_HOST_DISABLE		 0
+#define CURRENT_POWER_GATE_HOST_ENABLE 		 1
+
+#define CURRENT_POWER_CLOCK				 0x00003C
+#define CURRENT_POWER_CLOCK_P1XCLK		  31:31
+#define CURRENT_POWER_CLOCK_P1XCLK_ENABLE		 1
+#define CURRENT_POWER_CLOCK_P1XCLK_DISABLE		 0
+#define CURRENT_POWER_CLOCK_PLLCLK_SELECT		 30:30
+#define CURRENT_POWER_CLOCK_PLLCLK_SELECT_ENABLE		1
+#define CURRENT_POWER_CLOCK_PLLCLK_SELECT_DISABLE		0
+#define CURRENT_POWER_CLOCK_P2XCLK_SELECT		 29:29
+#define CURRENT_POWER_CLOCK_P2XCLK_SELECT_288		 0
+#define CURRENT_POWER_CLOCK_P2XCLK_SELECT_336		 1
+#define CURRENT_POWER_CLOCK_P2XCLK_DIVIDER		 28:27
+#define CURRENT_POWER_CLOCK_P2XCLK_DIVIDER_1		 0
+#define CURRENT_POWER_CLOCK_P2XCLK_DIVIDER_3		 1
+#define CURRENT_POWER_CLOCK_P2XCLK_DIVIDER_5		 2
+#define CURRENT_POWER_CLOCK_P2XCLK_SHIFT		 26:24
+#define CURRENT_POWER_CLOCK_P2XCLK_SHIFT_0		 0
+#define CURRENT_POWER_CLOCK_P2XCLK_SHIFT_1		 1
+#define CURRENT_POWER_CLOCK_P2XCLK_SHIFT_2		 2
+#define CURRENT_POWER_CLOCK_P2XCLK_SHIFT_3		 3
+#define CURRENT_POWER_CLOCK_P2XCLK_SHIFT_4		 4
+#define CURRENT_POWER_CLOCK_P2XCLK_SHIFT_5		 5
+#define CURRENT_POWER_CLOCK_P2XCLK_SHIFT_6		 6
+#define CURRENT_POWER_CLOCK_P2XCLK_SHIFT_7		 7
+#define CURRENT_POWER_CLOCK_V2XCLK_SELECT		 20:20
+#define CURRENT_POWER_CLOCK_V2XCLK_SELECT_288		 0
+#define CURRENT_POWER_CLOCK_V2XCLK_SELECT_336		 1
+#define CURRENT_POWER_CLOCK_V2XCLK_DIVIDER		 19:19
+#define CURRENT_POWER_CLOCK_V2XCLK_DIVIDER_1		 0
+#define CURRENT_POWER_CLOCK_V2XCLK_DIVIDER_3		 1
+#define CURRENT_POWER_CLOCK_V2XCLK_SHIFT		 18:16
+#define CURRENT_POWER_CLOCK_V2XCLK_SHIFT_0		 0
+#define CURRENT_POWER_CLOCK_V2XCLK_SHIFT_1		 1
+#define CURRENT_POWER_CLOCK_V2XCLK_SHIFT_2		 2
+#define CURRENT_POWER_CLOCK_V2XCLK_SHIFT_3		 3
+#define CURRENT_POWER_CLOCK_V2XCLK_SHIFT_4		 4
+#define CURRENT_POWER_CLOCK_V2XCLK_SHIFT_5		 5
+#define CURRENT_POWER_CLOCK_V2XCLK_SHIFT_6		 6
+#define CURRENT_POWER_CLOCK_V2XCLK_SHIFT_7		 7
+#define CURRENT_POWER_CLOCK_MCLK_SELECT		 12:12
+#define CURRENT_POWER_CLOCK_MCLK_SELECT_288		 0
+#define CURRENT_POWER_CLOCK_MCLK_SELECT_336		 1
+#define CURRENT_POWER_CLOCK_MCLK_DIVIDER		 11:11
+#define CURRENT_POWER_CLOCK_MCLK_DIVIDER_1		 0
+#define CURRENT_POWER_CLOCK_MCLK_DIVIDER_3		 1
+#define CURRENT_POWER_CLOCK_MCLK_SHIFT 		 10:8
+#define CURRENT_POWER_CLOCK_MCLK_SHIFT_0		 0
+#define CURRENT_POWER_CLOCK_MCLK_SHIFT_1		 1
+#define CURRENT_POWER_CLOCK_MCLK_SHIFT_2		 2
+#define CURRENT_POWER_CLOCK_MCLK_SHIFT_3		 3
+#define CURRENT_POWER_CLOCK_MCLK_SHIFT_4		 4
+#define CURRENT_POWER_CLOCK_MCLK_SHIFT_5		 5
+#define CURRENT_POWER_CLOCK_MCLK_SHIFT_6		 6
+#define CURRENT_POWER_CLOCK_MCLK_SHIFT_7		 7
+#define CURRENT_POWER_CLOCK_M2XCLK_SELECT		 4:4
+#define CURRENT_POWER_CLOCK_M2XCLK_SELECT_288		 0
+#define CURRENT_POWER_CLOCK_M2XCLK_SELECT_336		 1
+#define CURRENT_POWER_CLOCK_M2XCLK_DIVIDER		 3:3
+#define CURRENT_POWER_CLOCK_M2XCLK_DIVIDER_1		 0
+#define CURRENT_POWER_CLOCK_M2XCLK_DIVIDER_3		 1
+#define CURRENT_POWER_CLOCK_M2XCLK_SHIFT		 2:0
+#define CURRENT_POWER_CLOCK_M2XCLK_SHIFT_0		 0
+#define CURRENT_POWER_CLOCK_M2XCLK_SHIFT_1		 1
+#define CURRENT_POWER_CLOCK_M2XCLK_SHIFT_2		 2
+#define CURRENT_POWER_CLOCK_M2XCLK_SHIFT_3		 3
+#define CURRENT_POWER_CLOCK_M2XCLK_SHIFT_4		 4
+#define CURRENT_POWER_CLOCK_M2XCLK_SHIFT_5		 5
+#define CURRENT_POWER_CLOCK_M2XCLK_SHIFT_6		 6
+#define CURRENT_POWER_CLOCK_M2XCLK_SHIFT_7		 7
+
+#define POWER_MODE0_GATE				 0x000040
+#define POWER_MODE0_GATE_AC97_I2S			 18:18
+#define POWER_MODE0_GATE_AC97_I2S_DISABLE		 0
+#define POWER_MODE0_GATE_AC97_I2S_ENABLE		 1
+#define POWER_MODE0_GATE_8051				 17:17
+#define POWER_MODE0_GATE_8051_DISABLE			 0
+#define POWER_MODE0_GATE_8051_ENABLE			 1
+#define POWER_MODE0_GATE_USB_SLAVE			 12:12
+#define POWER_MODE0_GATE_USB_SLAVE_DISABLE		 0
+#define POWER_MODE0_GATE_USB_SLAVE_ENABLE		 1
+#define POWER_MODE0_GATE_USB_HOST			 11:11
+#define POWER_MODE0_GATE_USB_HOST_DISABLE		 0
+#define POWER_MODE0_GATE_USB_HOST_ENABLE		 1
+#define POWER_MODE0_GATE_SSP0_SSP1			 10:10
+#define POWER_MODE0_GATE_SSP0_SSP1_DISABLE		 0
+#define POWER_MODE0_GATE_SSP0_SSP1_ENABLE		 1
+#define POWER_MODE0_GATE_UART1 			 8:8
+#define POWER_MODE0_GATE_UART1_DISABLE 		 0
+#define POWER_MODE0_GATE_UART1_ENABLE			 1
+#define POWER_MODE0_GATE_UART0 			 7:7
+#define POWER_MODE0_GATE_UART0_DISABLE 		 0
+#define POWER_MODE0_GATE_UART0_ENABLE			 1
+#define POWER_MODE0_GATE_GPIO_PWM_I2C			 6:6
+#define POWER_MODE0_GATE_GPIO_PWM_I2C_DISABLE		 0
+#define POWER_MODE0_GATE_GPIO_PWM_I2C_ENABLE		 1
+#define POWER_MODE0_GATE_ZVPORT			 5:5
+#define POWER_MODE0_GATE_ZVPORT_DISABLE		 0
+#define POWER_MODE0_GATE_ZVPORT_ENABLE 		 1
+#define POWER_MODE0_GATE_CSC				 4:4
+#define POWER_MODE0_GATE_CSC_DISABLE			 0
+#define POWER_MODE0_GATE_CSC_ENABLE			 1
+#define POWER_MODE0_GATE_2D				 3:3
+#define POWER_MODE0_GATE_2D_DISABLE			 0
+#define POWER_MODE0_GATE_2D_ENABLE			 1
+#define POWER_MODE0_GATE_DISPLAY			 2:2
+#define POWER_MODE0_GATE_DISPLAY_DISABLE		 0
+#define POWER_MODE0_GATE_DISPLAY_ENABLE		 1
+#define POWER_MODE0_GATE_INTMEM			 1:1
+#define POWER_MODE0_GATE_INTMEM_DISABLE		 0
+#define POWER_MODE0_GATE_INTMEM_ENABLE 		 1
+#define POWER_MODE0_GATE_HOST				 0:0
+#define POWER_MODE0_GATE_HOST_DISABLE			 0
+#define POWER_MODE0_GATE_HOST_ENABLE			 1
+
+#define POWER_MODE0_CLOCK				 0x000044
+#define POWER_MODE0_CLOCK_PLL3_P1XCLK					31:31
+#define POWER_MODE0_CLOCK_PLL3_P1XCLK_ENABLE			1
+#define POWER_MODE0_CLOCK_PLL3_P1XCLK_DISABLE			0
+#define POWER_MODE0_CLOCK_PLL3 						30:30
+#define POWER_MODE0_CLOCK_PLL3_ENABLE					1
+#define POWER_MODE0_CLOCK_PLL3_DISABLE 				0
+#define POWER_MODE0_CLOCK_P2XCLK_SELECT		 29:29
+#define POWER_MODE0_CLOCK_P2XCLK_SELECT_288		 0
+#define POWER_MODE0_CLOCK_P2XCLK_SELECT_336		 1
+#define POWER_MODE0_CLOCK_P2XCLK_DIVIDER		 28:27
+#define POWER_MODE0_CLOCK_P2XCLK_DIVIDER_1		 0
+#define POWER_MODE0_CLOCK_P2XCLK_DIVIDER_3		 1
+#define POWER_MODE0_CLOCK_P2XCLK_DIVIDER_5		 2
+#define POWER_MODE0_CLOCK_P2XCLK_SHIFT 		 26:24
+#define POWER_MODE0_CLOCK_P2XCLK_SHIFT_0		 0
+#define POWER_MODE0_CLOCK_P2XCLK_SHIFT_1		 1
+#define POWER_MODE0_CLOCK_P2XCLK_SHIFT_2		 2
+#define POWER_MODE0_CLOCK_P2XCLK_SHIFT_3		 3
+#define POWER_MODE0_CLOCK_P2XCLK_SHIFT_4		 4
+#define POWER_MODE0_CLOCK_P2XCLK_SHIFT_5		 5
+#define POWER_MODE0_CLOCK_P2XCLK_SHIFT_6		 6
+#define POWER_MODE0_CLOCK_P2XCLK_SHIFT_7		 7
+#define POWER_MODE0_CLOCK_V2XCLK_SELECT		 20:20
+#define POWER_MODE0_CLOCK_V2XCLK_SELECT_288		 0
+#define POWER_MODE0_CLOCK_V2XCLK_SELECT_336		 1
+#define POWER_MODE0_CLOCK_V2XCLK_DIVIDER		 19:19
+#define POWER_MODE0_CLOCK_V2XCLK_DIVIDER_1		 0
+#define POWER_MODE0_CLOCK_V2XCLK_DIVIDER_3		 1
+#define POWER_MODE0_CLOCK_V2XCLK_SHIFT 		 18:16
+#define POWER_MODE0_CLOCK_V2XCLK_SHIFT_0		 0
+#define POWER_MODE0_CLOCK_V2XCLK_SHIFT_1		 1
+#define POWER_MODE0_CLOCK_V2XCLK_SHIFT_2		 2
+#define POWER_MODE0_CLOCK_V2XCLK_SHIFT_3		 3
+#define POWER_MODE0_CLOCK_V2XCLK_SHIFT_4		 4
+#define POWER_MODE0_CLOCK_V2XCLK_SHIFT_5		 5
+#define POWER_MODE0_CLOCK_V2XCLK_SHIFT_6		 6
+#define POWER_MODE0_CLOCK_V2XCLK_SHIFT_7		 7
+#define POWER_MODE0_CLOCK_MCLK_SELECT			 12:12
+#define POWER_MODE0_CLOCK_MCLK_SELECT_288		 0
+#define POWER_MODE0_CLOCK_MCLK_SELECT_336		 1
+#define POWER_MODE0_CLOCK_MCLK_DIVIDER 		 11:11
+#define POWER_MODE0_CLOCK_MCLK_DIVIDER_1		 0
+#define POWER_MODE0_CLOCK_MCLK_DIVIDER_3		 1
+#define POWER_MODE0_CLOCK_MCLK_SHIFT			 10:8
+#define POWER_MODE0_CLOCK_MCLK_SHIFT_0 		 0
+#define POWER_MODE0_CLOCK_MCLK_SHIFT_1 		 1
+#define POWER_MODE0_CLOCK_MCLK_SHIFT_2 		 2
+#define POWER_MODE0_CLOCK_MCLK_SHIFT_3 		 3
+#define POWER_MODE0_CLOCK_MCLK_SHIFT_4 		 4
+#define POWER_MODE0_CLOCK_MCLK_SHIFT_5 		 5
+#define POWER_MODE0_CLOCK_MCLK_SHIFT_6 		 6
+#define POWER_MODE0_CLOCK_MCLK_SHIFT_7 		 7
+#define POWER_MODE0_CLOCK_M2XCLK_SELECT		 4:4
+#define POWER_MODE0_CLOCK_M2XCLK_SELECT_288		 0
+#define POWER_MODE0_CLOCK_M2XCLK_SELECT_336		 1
+#define POWER_MODE0_CLOCK_M2XCLK_DIVIDER		 3:3
+#define POWER_MODE0_CLOCK_M2XCLK_DIVIDER_1		 0
+#define POWER_MODE0_CLOCK_M2XCLK_DIVIDER_3		 1
+#define POWER_MODE0_CLOCK_M2XCLK_SHIFT 		 2:0
+#define POWER_MODE0_CLOCK_M2XCLK_SHIFT_0		 0
+#define POWER_MODE0_CLOCK_M2XCLK_SHIFT_1		 1
+#define POWER_MODE0_CLOCK_M2XCLK_SHIFT_2		 2
+#define POWER_MODE0_CLOCK_M2XCLK_SHIFT_3		 3
+#define POWER_MODE0_CLOCK_M2XCLK_SHIFT_4		 4
+#define POWER_MODE0_CLOCK_M2XCLK_SHIFT_5		 5
+#define POWER_MODE0_CLOCK_M2XCLK_SHIFT_6		 6
+#define POWER_MODE0_CLOCK_M2XCLK_SHIFT_7		 7
+
+#define POWER_MODE1_GATE				 0x000048
+#define POWER_MODE1_GATE_AC97_I2S			 18:18
+#define POWER_MODE1_GATE_AC97_I2S_DISABLE		 0
+#define POWER_MODE1_GATE_AC97_I2S_ENABLE		 1
+#define POWER_MODE1_GATE_8051				 17:17
+#define POWER_MODE1_GATE_8051_DISABLE			 0
+#define POWER_MODE1_GATE_8051_ENABLE			 1
+#define POWER_MODE1_GATE_USB_SLAVE			 12:12
+#define POWER_MODE1_GATE_USB_SLAVE_DISABLE		 0
+#define POWER_MODE1_GATE_USB_SLAVE_ENABLE		 1
+#define POWER_MODE1_GATE_USB_HOST			 11:11
+#define POWER_MODE1_GATE_USB_HOST_DISABLE		 0
+#define POWER_MODE1_GATE_USB_HOST_ENABLE		 1
+#define POWER_MODE1_GATE_SSP0_SSP1			 10:10
+#define POWER_MODE1_GATE_SSP0_SSP1_DISABLE		 0
+#define POWER_MODE1_GATE_SSP0_SSP1_ENABLE		 1
+#define POWER_MODE1_GATE_UART1 			 8:8
+#define POWER_MODE1_GATE_UART1_DISABLE 		 0
+#define POWER_MODE1_GATE_UART1_ENABLE			 1
+#define POWER_MODE1_GATE_UART0 			 7:7
+#define POWER_MODE1_GATE_UART0_DISABLE 		 0
+#define POWER_MODE1_GATE_UART0_ENABLE			 1
+#define POWER_MODE1_GATE_GPIO_PWM_I2C			 6:6
+#define POWER_MODE1_GATE_GPIO_PWM_I2C_DISABLE		 0
+#define POWER_MODE1_GATE_GPIO_PWM_I2C_ENABLE		 1
+#define POWER_MODE1_GATE_ZVPORT			 5:5
+#define POWER_MODE1_GATE_ZVPORT_DISABLE		 0
+#define POWER_MODE1_GATE_ZVPORT_ENABLE 		 1
+#define POWER_MODE1_GATE_CSC				 4:4
+#define POWER_MODE1_GATE_CSC_DISABLE			 0
+#define POWER_MODE1_GATE_CSC_ENABLE			 1
+#define POWER_MODE1_GATE_2D				 3:3
+#define POWER_MODE1_GATE_2D_DISABLE			 0
+#define POWER_MODE1_GATE_2D_ENABLE			 1
+#define POWER_MODE1_GATE_DISPLAY			 2:2
+#define POWER_MODE1_GATE_DISPLAY_DISABLE		 0
+#define POWER_MODE1_GATE_DISPLAY_ENABLE		 1
+#define POWER_MODE1_GATE_INTMEM			 1:1
+#define POWER_MODE1_GATE_INTMEM_DISABLE		 0
+#define POWER_MODE1_GATE_INTMEM_ENABLE 		 1
+#define POWER_MODE1_GATE_HOST				 0:0
+#define POWER_MODE1_GATE_HOST_DISABLE			 0
+#define POWER_MODE1_GATE_HOST_ENABLE			 1
+
+#define POWER_MODE1_CLOCK				 0x00004C
+#define POWER_MODE1_CLOCK_PLL3_P1XCLK					31:31
+#define POWER_MODE1_CLOCK_PLL3_P1XCLK_ENABLE			1
+#define POWER_MODE1_CLOCK_PLL3_P1XCLK_DISABLE			0
+#define POWER_MODE1_CLOCK_PLL3 						30:30
+#define POWER_MODE1_CLOCK_PLL3_ENABLE					1
+#define POWER_MODE1_CLOCK_PLL3_DISABLE 				0
+#define POWER_MODE1_CLOCK_P2XCLK_SELECT		 29:29
+#define POWER_MODE1_CLOCK_P2XCLK_SELECT_288		 0
+#define POWER_MODE1_CLOCK_P2XCLK_SELECT_336		 1
+#define POWER_MODE1_CLOCK_P2XCLK_DIVIDER		 28:27
+#define POWER_MODE1_CLOCK_P2XCLK_DIVIDER_1		 0
+#define POWER_MODE1_CLOCK_P2XCLK_DIVIDER_3		 1
+#define POWER_MODE1_CLOCK_P2XCLK_DIVIDER_5		 2
+#define POWER_MODE1_CLOCK_P2XCLK_SHIFT 		 26:24
+#define POWER_MODE1_CLOCK_P2XCLK_SHIFT_0		 0
+#define POWER_MODE1_CLOCK_P2XCLK_SHIFT_1		 1
+#define POWER_MODE1_CLOCK_P2XCLK_SHIFT_2		 2
+#define POWER_MODE1_CLOCK_P2XCLK_SHIFT_3		 3
+#define POWER_MODE1_CLOCK_P2XCLK_SHIFT_4		 4
+#define POWER_MODE1_CLOCK_P2XCLK_SHIFT_5		 5
+#define POWER_MODE1_CLOCK_P2XCLK_SHIFT_6		 6
+#define POWER_MODE1_CLOCK_P2XCLK_SHIFT_7		 7
+#define POWER_MODE1_CLOCK_V2XCLK_SELECT		 20:20
+#define POWER_MODE1_CLOCK_V2XCLK_SELECT_288		 0
+#define POWER_MODE1_CLOCK_V2XCLK_SELECT_336		 1
+#define POWER_MODE1_CLOCK_V2XCLK_DIVIDER		 19:19
+#define POWER_MODE1_CLOCK_V2XCLK_DIVIDER_1		 0
+#define POWER_MODE1_CLOCK_V2XCLK_DIVIDER_3		 1
+#define POWER_MODE1_CLOCK_V2XCLK_SHIFT 		 18:16
+#define POWER_MODE1_CLOCK_V2XCLK_SHIFT_0		 0
+#define POWER_MODE1_CLOCK_V2XCLK_SHIFT_1		 1
+#define POWER_MODE1_CLOCK_V2XCLK_SHIFT_2		 2
+#define POWER_MODE1_CLOCK_V2XCLK_SHIFT_3		 3
+#define POWER_MODE1_CLOCK_V2XCLK_SHIFT_4		 4
+#define POWER_MODE1_CLOCK_V2XCLK_SHIFT_5		 5
+#define POWER_MODE1_CLOCK_V2XCLK_SHIFT_6		 6
+#define POWER_MODE1_CLOCK_V2XCLK_SHIFT_7		 7
+#define POWER_MODE1_CLOCK_MCLK_SELECT			 12:12
+#define POWER_MODE1_CLOCK_MCLK_SELECT_288		 0
+#define POWER_MODE1_CLOCK_MCLK_SELECT_336		 1
+#define POWER_MODE1_CLOCK_MCLK_DIVIDER 		 11:11
+#define POWER_MODE1_CLOCK_MCLK_DIVIDER_1		 0
+#define POWER_MODE1_CLOCK_MCLK_DIVIDER_3		 1
+#define POWER_MODE1_CLOCK_MCLK_SHIFT			 10:8
+#define POWER_MODE1_CLOCK_MCLK_SHIFT_0 		 0
+#define POWER_MODE1_CLOCK_MCLK_SHIFT_1 		 1
+#define POWER_MODE1_CLOCK_MCLK_SHIFT_2 		 2
+#define POWER_MODE1_CLOCK_MCLK_SHIFT_3 		 3
+#define POWER_MODE1_CLOCK_MCLK_SHIFT_4 		 4
+#define POWER_MODE1_CLOCK_MCLK_SHIFT_5 		 5
+#define POWER_MODE1_CLOCK_MCLK_SHIFT_6 		 6
+#define POWER_MODE1_CLOCK_MCLK_SHIFT_7 		 7
+#define POWER_MODE1_CLOCK_M2XCLK_SELECT		 4:4
+#define POWER_MODE1_CLOCK_M2XCLK_SELECT_288		 0
+#define POWER_MODE1_CLOCK_M2XCLK_SELECT_336		 1
+#define POWER_MODE1_CLOCK_M2XCLK_DIVIDER		 3:3
+#define POWER_MODE1_CLOCK_M2XCLK_DIVIDER_1		 0
+#define POWER_MODE1_CLOCK_M2XCLK_DIVIDER_3		 1
+#define POWER_MODE1_CLOCK_M2XCLK_SHIFT 		 2:0
+#define POWER_MODE1_CLOCK_M2XCLK_SHIFT_0		 0
+#define POWER_MODE1_CLOCK_M2XCLK_SHIFT_1		 1
+#define POWER_MODE1_CLOCK_M2XCLK_SHIFT_2		 2
+#define POWER_MODE1_CLOCK_M2XCLK_SHIFT_3		 3
+#define POWER_MODE1_CLOCK_M2XCLK_SHIFT_4		 4
+#define POWER_MODE1_CLOCK_M2XCLK_SHIFT_5		 5
+#define POWER_MODE1_CLOCK_M2XCLK_SHIFT_6		 6
+#define POWER_MODE1_CLOCK_M2XCLK_SHIFT_7		 7
+
+#define POWER_SLEEP_GATE				 0x000050
+#define POWER_SLEEP_GATE_PLL_RECOVERY_CLOCK		 22:19
+#define POWER_SLEEP_GATE_PLL_RECOVERY_CLOCK_4096	 0
+#define POWER_SLEEP_GATE_PLL_RECOVERY_CLOCK_2048	 1
+#define POWER_SLEEP_GATE_PLL_RECOVERY_CLOCK_1024	 2
+#define POWER_SLEEP_GATE_PLL_RECOVERY_CLOCK_512	 3
+#define POWER_SLEEP_GATE_PLL_RECOVERY_CLOCK_256	 4
+#define POWER_SLEEP_GATE_PLL_RECOVERY_CLOCK_128	 5
+#define POWER_SLEEP_GATE_PLL_RECOVERY_CLOCK_64 	 6
+#define POWER_SLEEP_GATE_PLL_RECOVERY_CLOCK_32 	 7
+#define POWER_SLEEP_GATE_PLL_RECOVERY_CLOCK_16 	 8
+#define POWER_SLEEP_GATE_PLL_RECOVERY_CLOCK_8		 9
+#define POWER_SLEEP_GATE_PLL_RECOVERY_CLOCK_4		 10
+#define POWER_SLEEP_GATE_PLL_RECOVERY_CLOCK_2		 11
+#define POWER_SLEEP_GATE_PLL_RECOVERY			 14:13
+#define POWER_SLEEP_GATE_PLL_RECOVERY_32		 0
+#define POWER_SLEEP_GATE_PLL_RECOVERY_64		 1
+#define POWER_SLEEP_GATE_PLL_RECOVERY_96		 2
+#define POWER_SLEEP_GATE_PLL_RECOVERY_128		 3
+
+#define POWER_MODE_CTRL				 0x000054
+#define POWER_MODE_CTRL_SLEEP_STATUS			 2:2
+#define POWER_MODE_CTRL_SLEEP_STATUS_INACTIVE		 0
+#define POWER_MODE_CTRL_SLEEP_STATUS_ACTIVE		 1
+#define POWER_MODE_CTRL_MODE				 1:0
+#define POWER_MODE_CTRL_MODE_MODE0			 0
+#define POWER_MODE_CTRL_MODE_MODE1			 1
+#define POWER_MODE_CTRL_MODE_SLEEP			 2
+
+#define PCI_MASTER_BASE				 0x000058
+#define PCI_MASTER_BASE_ADDRESS			 31:20
+
+#define ENDIAN_CTRL					 0x00005C
+#define ENDIAN_CTRL_ENDIAN				 0:0
+#define ENDIAN_CTRL_ENDIAN_LITTLE			 0
+#define ENDIAN_CTRL_ENDIAN_BIG 			 1
+
+#define DEVICE_ID					 0x000060
+#define DEVICE_ID_DEVICE_ID				 31:16
+#define DEVICE_ID_REVISION_ID				 7:0
+
+#define PLL_CLOCK_COUNT				 0x000064
+#define PLL_CLOCK_COUNT_COUNTER			 15:0
+
+#define SYSTEM_DRAM_CTRL				 0x000068
+#define SYSTEM_DRAM_CTRL_READ_DELAY			 2:0
+#define SYSTEM_DRAM_CTRL_READ_DELAY_OFF		 0
+#define SYSTEM_DRAM_CTRL_READ_DELAY_0_5NS		 1
+#define SYSTEM_DRAM_CTRL_READ_DELAY_1NS		 2
+#define SYSTEM_DRAM_CTRL_READ_DELAY_1_5NS		 3
+#define SYSTEM_DRAM_CTRL_READ_DELAY_2NS		 4
+#define SYSTEM_DRAM_CTRL_READ_DELAY_2_5NS		 5
+
+#define SYSTEM_PLL3_CLOCK								0x000074
+#define SYSTEM_PLL3_CLOCK_M								7:0
+#define SYSTEM_PLL3_CLOCK_N								14:8
+#define SYSTEM_PLL3_CLOCK_DIVIDE						15:15
+#define SYSTEM_PLL3_CLOCK_DIVIDE_1						0
+#define SYSTEM_PLL3_CLOCK_DIVIDE_2						1
+#define SYSTEM_PLL3_CLOCK_INPUT							16:16
+#define SYSTEM_PLL3_CLOCK_INPUT_CRYSTAL					0
+#define SYSTEM_PLL3_CLOCK_INPUT_TEST					1
+#define SYSTEM_PLL3_CLOCK_POWER							17:17
+#define SYSTEM_PLL3_CLOCK_POWER_OFF						0
+#define SYSTEM_PLL3_CLOCK_POWER_ON						1
+
+#define CURRENT_POWER_PLLCLOCK 		   0x000074
+#define CURRENT_POWER_PLLCLOCK_TEST_OUTPUT		20:20
+#define CURRENT_POWER_PLLCLOCK_TEST_OUTPUT_ENABLE		1
+#define CURRENT_POWER_PLLCLOCK_TEST_OUTPUT_DISABLE		0
+#define CURRENT_POWER_PLLCLOCK_TESTMODE		19:18
+#define CURRENT_POWER_PLLCLOCK_TESTMODE_ENABLE 		1
+#define CURRENT_POWER_PLLCLOCK_TESTMODE_DISABLE		0
+#define CURRENT_POWER_PLLCLOCK_POWER			17:17
+#define CURRENT_POWER_PLLCLOCK_POWER_DOWN			0
+#define CURRENT_POWER_PLLCLOCK_POWER_ON		1
+#define CURRENT_POWER_PLLCLOCK_INPUT_SELECT		  16:16
+#define CURRENT_POWER_PLLCLOCK_INPUT_SELECT_TEST	 1
+#define CURRENT_POWER_PLLCLOCK_INPUT_SELECT_CRYSTAL	0
+#define CURRENT_POWER_PLLCLOCK_DIVIDEBY2		     15:15
+#define CURRENT_POWER_PLLCLOCK_DIVIDE_N		     14:8
+#define CURRENT_POWER_PLLCLOCK_MULTIPLE_M		       7:0
+
+/* Panel Graphics Control */
+
+#define PANEL_DISPLAY_CTRL				 0x080000
+#define PANEL_DISPLAY_CTRL_FPEN			 27:27
+#define PANEL_DISPLAY_CTRL_FPEN_LOW			 0
+#define PANEL_DISPLAY_CTRL_FPEN_HIGH			 1
+#define PANEL_DISPLAY_CTRL_VBIASEN			 26:26
+#define PANEL_DISPLAY_CTRL_VBIASEN_LOW 		 0
+#define PANEL_DISPLAY_CTRL_VBIASEN_HIGH		 1
+#define PANEL_DISPLAY_CTRL_DATA			 25:25
+#define PANEL_DISPLAY_CTRL_DATA_DISABLE		 0
+#define PANEL_DISPLAY_CTRL_DATA_ENABLE 		 1
+#define PANEL_DISPLAY_CTRL_FPVDDEN			 24:24
+#define PANEL_DISPLAY_CTRL_FPVDDEN_LOW 		 0
+#define PANEL_DISPLAY_CTRL_FPVDDEN_HIGH		 1
+#define PANEL_DISPLAY_CTRL_PATTERN			 23:23
+#define PANEL_DISPLAY_CTRL_PATTERN_4			 0
+#define PANEL_DISPLAY_CTRL_PATTERN_8			 1
+#define PANEL_DISPLAY_CTRL_TFT 			 22:21
+#define PANEL_DISPLAY_CTRL_TFT_24			 0
+#define PANEL_DISPLAY_CTRL_TFT_9			 1
+#define PANEL_DISPLAY_CTRL_TFT_12			 2
+#define PANEL_DISPLAY_CTRL_DITHER			 20:20
+#define PANEL_DISPLAY_CTRL_DITHER_DISABLE		 0
+#define PANEL_DISPLAY_CTRL_DITHER_ENABLE		 1
+#define PANEL_DISPLAY_CTRL_LCD 			 19:18
+#define PANEL_DISPLAY_CTRL_LCD_TFT			 0
+#define PANEL_DISPLAY_CTRL_LCD_STN_8			 2
+#define PANEL_DISPLAY_CTRL_LCD_STN_12			 3
+#define PANEL_DISPLAY_CTRL_FIFO			 17:16
+#define PANEL_DISPLAY_CTRL_FIFO_1			 0
+#define PANEL_DISPLAY_CTRL_FIFO_3			 1
+#define PANEL_DISPLAY_CTRL_FIFO_7			 2
+#define PANEL_DISPLAY_CTRL_FIFO_11			 3
+#define PANEL_DISPLAY_CTRL_CLOCK_PHASE 		 14:14
+#define PANEL_DISPLAY_CTRL_CLOCK_PHASE_ACTIVE_HIGH	 0
+#define PANEL_DISPLAY_CTRL_CLOCK_PHASE_ACTIVE_LOW	 1
+#define PANEL_DISPLAY_CTRL_VSYNC_PHASE 		 13:13
+#define PANEL_DISPLAY_CTRL_VSYNC_PHASE_ACTIVE_HIGH	 0
+#define PANEL_DISPLAY_CTRL_VSYNC_PHASE_ACTIVE_LOW	 1
+#define PANEL_DISPLAY_CTRL_HSYNC_PHASE 		 12:12
+#define PANEL_DISPLAY_CTRL_HSYNC_PHASE_ACTIVE_HIGH	 0
+#define PANEL_DISPLAY_CTRL_HSYNC_PHASE_ACTIVE_LOW	 1
+#define PANEL_DISPLAY_CTRL_COLOR_KEY			 9:9
+#define PANEL_DISPLAY_CTRL_COLOR_KEY_DISABLE		 0
+#define PANEL_DISPLAY_CTRL_COLOR_KEY_ENABLE		 1
+#define PANEL_DISPLAY_CTRL_TIMING			 8:8
+#define PANEL_DISPLAY_CTRL_TIMING_DISABLE		 0
+#define PANEL_DISPLAY_CTRL_TIMING_ENABLE		 1
+#define PANEL_DISPLAY_CTRL_VERTICAL_PAN_DIR		 7:7
+#define PANEL_DISPLAY_CTRL_VERTICAL_PAN_DIR_DOWN	 0
+#define PANEL_DISPLAY_CTRL_VERTICAL_PAN_DIR_UP 	 1
+#define PANEL_DISPLAY_CTRL_VERTICAL_PAN		 6:6
+#define PANEL_DISPLAY_CTRL_VERTICAL_PAN_DISABLE	 0
+#define PANEL_DISPLAY_CTRL_VERTICAL_PAN_ENABLE 	 1
+#define PANEL_DISPLAY_CTRL_HORIZONTAL_PAN_DIR		 5:5
+#define PANEL_DISPLAY_CTRL_HORIZONTAL_PAN_DIR_RIGHT	 0
+#define PANEL_DISPLAY_CTRL_HORIZONTAL_PAN_DIR_LEFT	 1
+#define PANEL_DISPLAY_CTRL_HORIZONTAL_PAN		 4:4
+#define PANEL_DISPLAY_CTRL_HORIZONTAL_PAN_DISABLE	 0
+#define PANEL_DISPLAY_CTRL_HORIZONTAL_PAN_ENABLE	 1
+#define PANEL_DISPLAY_CTRL_GAMMA			 3:3
+#define PANEL_DISPLAY_CTRL_GAMMA_DISABLE		 0
+#define PANEL_DISPLAY_CTRL_GAMMA_ENABLE		 1
+#define PANEL_DISPLAY_CTRL_PLANE			 2:2
+#define PANEL_DISPLAY_CTRL_PLANE_DISABLE		 0
+#define PANEL_DISPLAY_CTRL_PLANE_ENABLE		 1
+#define PANEL_DISPLAY_CTRL_FORMAT			 1:0
+#define PANEL_DISPLAY_CTRL_FORMAT_8			 0
+#define PANEL_DISPLAY_CTRL_FORMAT_16			 1
+#define PANEL_DISPLAY_CTRL_FORMAT_32			 2
+
+#define PANEL_PAN_CTRL 				 0x080004
+#define PANEL_PAN_CTRL_VERTICAL_PAN			 31:24
+#define PANEL_PAN_CTRL_VERTICAL_VSYNC			 21:16
+#define PANEL_PAN_CTRL_HORIZONTAL_PAN			 15:8
+#define PANEL_PAN_CTRL_HORIZONTAL_VSYNC		 5:0
+
+#define PANEL_COLOR_KEY				 0x080008
+#define PANEL_COLOR_KEY_MASK				 31:16
+#define PANEL_COLOR_KEY_VALUE				 15:0
+
+#define PANEL_FB_ADDRESS				 0x08000C
+#define PANEL_FB_ADDRESS_STATUS			 31:31
+#define PANEL_FB_ADDRESS_STATUS_CURRENT		 0
+#define PANEL_FB_ADDRESS_STATUS_PENDING		 1
+#define PANEL_FB_ADDRESS_EXT				 27:27
+#define PANEL_FB_ADDRESS_EXT_LOCAL			 0
+#define PANEL_FB_ADDRESS_EXT_EXTERNAL			 1
+#define PANEL_FB_ADDRESS_CS				 26:26
+#define PANEL_FB_ADDRESS_CS_0				 0
+#define PANEL_FB_ADDRESS_CS_1				 1
+#define PANEL_FB_ADDRESS_ADDRESS			 25:0
+
+#define PANEL_FB_WIDTH 				 0x080010
+#define PANEL_FB_WIDTH_WIDTH				 29:16
+#define PANEL_FB_WIDTH_OFFSET				 13:0
+
+#define PANEL_WINDOW_WIDTH				 0x080014
+#define PANEL_WINDOW_WIDTH_WIDTH			 27:16
+#define PANEL_WINDOW_WIDTH_X				 11:0
+
+#define PANEL_WINDOW_HEIGHT				 0x080018
+#define PANEL_WINDOW_HEIGHT_HEIGHT			 27:16
+#define PANEL_WINDOW_HEIGHT_Y				 11:0
+
+#define PANEL_PLANE_TL 				 0x08001C
+#define PANEL_PLANE_TL_TOP				 26:16
+#define PANEL_PLANE_TL_LEFT				 10:0
+
+#define PANEL_PLANE_BR 				 0x080020
+#define PANEL_PLANE_BR_BOTTOM				 26:16
+#define PANEL_PLANE_BR_RIGHT				 10:0
+
+#define PANEL_HORIZONTAL_TOTAL 			 0x080024
+#define PANEL_HORIZONTAL_TOTAL_TOTAL			 27:16
+#define PANEL_HORIZONTAL_TOTAL_DISPLAY_END		 11:0
+
+#define PANEL_HORIZONTAL_SYNC				 0x080028
+#define PANEL_HORIZONTAL_SYNC_WIDTH			 23:16
+#define PANEL_HORIZONTAL_SYNC_START			 11:0
+
+#define PANEL_VERTICAL_TOTAL				 0x08002C
+#define PANEL_VERTICAL_TOTAL_TOTAL			 26:16
+#define PANEL_VERTICAL_TOTAL_DISPLAY_END		 10:0
+
+#define PANEL_VERTICAL_SYNC				 0x080030
+#define PANEL_VERTICAL_SYNC_HEIGHT			 21:16
+#define PANEL_VERTICAL_SYNC_START			 10:0
+
+#define PANEL_CURRENT_LINE				 0x080034
+#define PANEL_CURRENT_LINE_LINE			 10:0
+
+/* Video Control */
+
+#define VIDEO_DISPLAY_CTRL				 0x080040
+#define VIDEO_DISPLAY_CTRL_FIFO			 17:16
+#define VIDEO_DISPLAY_CTRL_FIFO_1			 0
+#define VIDEO_DISPLAY_CTRL_FIFO_3			 1
+#define VIDEO_DISPLAY_CTRL_FIFO_7			 2
+#define VIDEO_DISPLAY_CTRL_FIFO_11			 3
+#define VIDEO_DISPLAY_CTRL_BUFFER			 15:15
+#define VIDEO_DISPLAY_CTRL_BUFFER_0			 0
+#define VIDEO_DISPLAY_CTRL_BUFFER_1			 1
+#define VIDEO_DISPLAY_CTRL_CAPTURE			 14:14
+#define VIDEO_DISPLAY_CTRL_CAPTURE_DISABLE		 0
+#define VIDEO_DISPLAY_CTRL_CAPTURE_ENABLE		 1
+#define VIDEO_DISPLAY_CTRL_DOUBLE_BUFFER		 13:13
+#define VIDEO_DISPLAY_CTRL_DOUBLE_BUFFER_DISABLE	 0
+#define VIDEO_DISPLAY_CTRL_DOUBLE_BUFFER_ENABLE	 1
+#define VIDEO_DISPLAY_CTRL_BYTE_SWAP			 12:12
+#define VIDEO_DISPLAY_CTRL_BYTE_SWAP_DISABLE		 0
+#define VIDEO_DISPLAY_CTRL_BYTE_SWAP_ENABLE		 1
+#define VIDEO_DISPLAY_CTRL_VERTICAL_SCALE		 11:11
+#define VIDEO_DISPLAY_CTRL_VERTICAL_SCALE_NORMAL	 0
+#define VIDEO_DISPLAY_CTRL_VERTICAL_SCALE_HALF 	 1
+#define VIDEO_DISPLAY_CTRL_HORIZONTAL_SCALE		 10:10
+#define VIDEO_DISPLAY_CTRL_HORIZONTAL_SCALE_NORMAL	 0
+#define VIDEO_DISPLAY_CTRL_HORIZONTAL_SCALE_HALF	 1
+#define VIDEO_DISPLAY_CTRL_VERTICAL_MODE		 9:9
+#define VIDEO_DISPLAY_CTRL_VERTICAL_MODE_REPLICATE	 0
+#define VIDEO_DISPLAY_CTRL_VERTICAL_MODE_INTERPOLATE	 1
+#define VIDEO_DISPLAY_CTRL_HORIZONTAL_MODE		 8:8
+#define VIDEO_DISPLAY_CTRL_HORIZONTAL_MODE_REPLICATE	 0
+#define VIDEO_DISPLAY_CTRL_HORIZONTAL_MODE_INTERPOLATE  1
+#define VIDEO_DISPLAY_CTRL_PIXEL			 7:4
+#define VIDEO_DISPLAY_CTRL_GAMMA			 3:3
+#define VIDEO_DISPLAY_CTRL_GAMMA_DISABLE		 0
+#define VIDEO_DISPLAY_CTRL_GAMMA_ENABLE		 1
+#define VIDEO_DISPLAY_CTRL_PLANE			 2:2
+#define VIDEO_DISPLAY_CTRL_PLANE_DISABLE		 0
+#define VIDEO_DISPLAY_CTRL_PLANE_ENABLE		 1
+#define VIDEO_DISPLAY_CTRL_FORMAT			 1:0
+#define VIDEO_DISPLAY_CTRL_FORMAT_8			 0
+#define VIDEO_DISPLAY_CTRL_FORMAT_16			 1
+#define VIDEO_DISPLAY_CTRL_FORMAT_32			 2
+#define VIDEO_DISPLAY_CTRL_FORMAT_YUV			 3
+
+#define VIDEO_FB_0_ADDRESS				 0x080044
+#define VIDEO_FB_0_ADDRESS_STATUS			 31:31
+#define VIDEO_FB_0_ADDRESS_STATUS_CURRENT		 0
+#define VIDEO_FB_0_ADDRESS_STATUS_PENDING		 1
+#define VIDEO_FB_0_ADDRESS_EXT 			 27:27
+#define VIDEO_FB_0_ADDRESS_EXT_LOCAL			 0
+#define VIDEO_FB_0_ADDRESS_EXT_EXTERNAL		 1
+#define VIDEO_FB_0_ADDRESS_CS				 26:26
+#define VIDEO_FB_0_ADDRESS_CS_0			 0
+#define VIDEO_FB_0_ADDRESS_CS_1			 1
+#define VIDEO_FB_0_ADDRESS_ADDRESS			 25:0
+
+#define VIDEO_FB_WIDTH 				 0x080048
+#define VIDEO_FB_WIDTH_WIDTH				 29:16
+#define VIDEO_FB_WIDTH_OFFSET				 13:0
+
+#define VIDEO_FB_0_LAST_ADDRESS			 0x08004C
+#define VIDEO_FB_0_LAST_ADDRESS_EXT			 27:27
+#define VIDEO_FB_0_LAST_ADDRESS_EXT_LOCAL		 0
+#define VIDEO_FB_0_LAST_ADDRESS_EXT_EXTERNAL		 1
+#define VIDEO_FB_0_LAST_ADDRESS_CS			 26:26
+#define VIDEO_FB_0_LAST_ADDRESS_CS_0			 0
+#define VIDEO_FB_0_LAST_ADDRESS_CS_1			 1
+#define VIDEO_FB_0_LAST_ADDRESS_ADDRESS		 25:0
+
+#define VIDEO_PLANE_TL 				 0x080050
+#define VIDEO_PLANE_TL_TOP				 26:16
+#define VIDEO_PLANE_TL_LEFT				 13:0
+
+#define VIDEO_PLANE_BR 				 0x080054
+#define VIDEO_PLANE_BR_BOTTOM				 26:16
+#define VIDEO_PLANE_BR_RIGHT				 13:0
+
+#define VIDEO_SCALE					 0x080058
+#define VIDEO_SCALE_VERTICAL_MODE			 31:31
+#define VIDEO_SCALE_VERTICAL_MODE_EXPAND		 0
+#define VIDEO_SCALE_VERTICAL_MODE_SHRINK		 1
+#define VIDEO_SCALE_VERTICAL_SCALE			 27:16
+#define VIDEO_SCALE_HORIZONTAL_MODE			 15:15
+#define VIDEO_SCALE_HORIZONTAL_MODE_EXPAND		 0
+#define VIDEO_SCALE_HORIZONTAL_MODE_SHRINK		 1
+#define VIDEO_SCALE_HORIZONTAL_SCALE			 11:0
+
+#define VIDEO_INITIAL_SCALE				 0x08005C
+#define VIDEO_INITIAL_SCALE_FB_1			 27:16
+#define VIDEO_INITIAL_SCALE_FB_0			 11:0
+
+#define VIDEO_YUV_CONSTANTS				 0x080060
+#define VIDEO_YUV_CONSTANTS_Y				 31:24
+#define VIDEO_YUV_CONSTANTS_R				 23:16
+#define VIDEO_YUV_CONSTANTS_G				 15:8
+#define VIDEO_YUV_CONSTANTS_B				 7:0
+
+#define VIDEO_FB_1_ADDRESS				 0x080064
+#define VIDEO_FB_1_ADDRESS_STATUS			 31:31
+#define VIDEO_FB_1_ADDRESS_STATUS_CURRENT		 0
+#define VIDEO_FB_1_ADDRESS_STATUS_PENDING		 1
+#define VIDEO_FB_1_ADDRESS_EXT 			 27:27
+#define VIDEO_FB_1_ADDRESS_EXT_LOCAL			 0
+#define VIDEO_FB_1_ADDRESS_EXT_EXTERNAL		 1
+#define VIDEO_FB_1_ADDRESS_CS				 26:26
+#define VIDEO_FB_1_ADDRESS_CS_0			 0
+#define VIDEO_FB_1_ADDRESS_CS_1			 1
+#define VIDEO_FB_1_ADDRESS_ADDRESS			 25:0
+
+#define VIDEO_FB_1_LAST_ADDRESS			 0x080068
+#define VIDEO_FB_1_LAST_ADDRESS_EXT			 27:27
+#define VIDEO_FB_1_LAST_ADDRESS_EXT_LOCAL		 0
+#define VIDEO_FB_1_LAST_ADDRESS_EXT_EXTERNAL		 1
+#define VIDEO_FB_1_LAST_ADDRESS_CS			 26:26
+#define VIDEO_FB_1_LAST_ADDRESS_CS_0			 0
+#define VIDEO_FB_1_LAST_ADDRESS_CS_1			 1
+#define VIDEO_FB_1_LAST_ADDRESS_ADDRESS		 25:0
+
+/* Video Alpha Control */
+
+#define VIDEO_ALPHA_DISPLAY_CTRL			 0x080080
+#define VIDEO_ALPHA_DISPLAY_CTRL_SELECT		 28:28
+#define VIDEO_ALPHA_DISPLAY_CTRL_SELECT_PER_PIXEL	 0
+#define VIDEO_ALPHA_DISPLAY_CTRL_SELECT_ALPHA		 1
+#define VIDEO_ALPHA_DISPLAY_CTRL_ALPHA 		 27:24
+#define VIDEO_ALPHA_DISPLAY_CTRL_FIFO			 17:16
+#define VIDEO_ALPHA_DISPLAY_CTRL_FIFO_1		 0
+#define VIDEO_ALPHA_DISPLAY_CTRL_FIFO_3		 1
+#define VIDEO_ALPHA_DISPLAY_CTRL_FIFO_7		 2
+#define VIDEO_ALPHA_DISPLAY_CTRL_FIFO_11		 3
+#define VIDEO_ALPHA_DISPLAY_CTRL_VERT_SCALE		 11:11
+#define VIDEO_ALPHA_DISPLAY_CTRL_VERT_SCALE_NORMAL	 0
+#define VIDEO_ALPHA_DISPLAY_CTRL_VERT_SCALE_HALF	 1
+#define VIDEO_ALPHA_DISPLAY_CTRL_HORZ_SCALE		 10:10
+#define VIDEO_ALPHA_DISPLAY_CTRL_HORZ_SCALE_NORMAL	 0
+#define VIDEO_ALPHA_DISPLAY_CTRL_HORZ_SCALE_HALF	 1
+#define VIDEO_ALPHA_DISPLAY_CTRL_VERT_MODE		 9:9
+#define VIDEO_ALPHA_DISPLAY_CTRL_VERT_MODE_REPLICATE	 0
+#define VIDEO_ALPHA_DISPLAY_CTRL_VERT_MODE_INTERPOLATE  1
+#define VIDEO_ALPHA_DISPLAY_CTRL_HORZ_MODE		 8:8
+#define VIDEO_ALPHA_DISPLAY_CTRL_HORZ_MODE_REPLICATE	 0
+#define VIDEO_ALPHA_DISPLAY_CTRL_HORZ_MODE_INTERPOLATE  1
+#define VIDEO_ALPHA_DISPLAY_CTRL_PIXEL 		 7:4
+#define VIDEO_ALPHA_DISPLAY_CTRL_CHROMA_KEY		 3:3
+#define VIDEO_ALPHA_DISPLAY_CTRL_CHROMA_KEY_DISABLE	 0
+#define VIDEO_ALPHA_DISPLAY_CTRL_CHROMA_KEY_ENABLE	 1
+#define VIDEO_ALPHA_DISPLAY_CTRL_PLANE 		 2:2
+#define VIDEO_ALPHA_DISPLAY_CTRL_PLANE_DISABLE 	 0
+#define VIDEO_ALPHA_DISPLAY_CTRL_PLANE_ENABLE		 1
+#define VIDEO_ALPHA_DISPLAY_CTRL_FORMAT		 1:0
+#define VIDEO_ALPHA_DISPLAY_CTRL_FORMAT_8		 0
+#define VIDEO_ALPHA_DISPLAY_CTRL_FORMAT_16		 1
+#define VIDEO_ALPHA_DISPLAY_CTRL_FORMAT_ALPHA_4_4	 2
+#define VIDEO_ALPHA_DISPLAY_CTRL_FORMAT_ALPHA_4_4_4_4	 3
+
+#define VIDEO_ALPHA_FB_ADDRESS 			 0x080084
+#define VIDEO_ALPHA_FB_ADDRESS_STATUS			 31:31
+#define VIDEO_ALPHA_FB_ADDRESS_STATUS_CURRENT		 0
+#define VIDEO_ALPHA_FB_ADDRESS_STATUS_PENDING		 1
+#define VIDEO_ALPHA_FB_ADDRESS_EXT			 27:27
+#define VIDEO_ALPHA_FB_ADDRESS_EXT_LOCAL		 0
+#define VIDEO_ALPHA_FB_ADDRESS_EXT_EXTERNAL		 1
+#define VIDEO_ALPHA_FB_ADDRESS_CS			 26:26
+#define VIDEO_ALPHA_FB_ADDRESS_CS_0			 0
+#define VIDEO_ALPHA_FB_ADDRESS_CS_1			 1
+#define VIDEO_ALPHA_FB_ADDRESS_ADDRESS 		 25:0
+
+#define VIDEO_ALPHA_FB_WIDTH				 0x080088
+#define VIDEO_ALPHA_FB_WIDTH_WIDTH			 29:16
+#define VIDEO_ALPHA_FB_WIDTH_OFFSET			 13:0
+
+#define VIDEO_ALPHA_FB_LAST_ADDRESS			 0x08008C
+#define VIDEO_ALPHA_FB_LAST_ADDRESS_EXT		 27:27
+#define VIDEO_ALPHA_FB_LAST_ADDRESS_EXT_LOCAL		 0
+#define VIDEO_ALPHA_FB_LAST_ADDRESS_EXT_EXTERNAL	 1
+#define VIDEO_ALPHA_FB_LAST_ADDRESS_CS 		 26:26
+#define VIDEO_ALPHA_FB_LAST_ADDRESS_CS_0		 0
+#define VIDEO_ALPHA_FB_LAST_ADDRESS_CS_1		 1
+#define VIDEO_ALPHA_FB_LAST_ADDRESS_ADDRESS		 25:0
+
+#define VIDEO_ALPHA_PLANE_TL				 0x080090
+#define VIDEO_ALPHA_PLANE_TL_TOP			 26:16
+#define VIDEO_ALPHA_PLANE_TL_LEFT			 10:0
+
+#define VIDEO_ALPHA_PLANE_BR				 0x080094
+#define VIDEO_ALPHA_PLANE_BR_BOTTOM			 26:16
+#define VIDEO_ALPHA_PLANE_BR_RIGHT			 10:0
+
+#define VIDEO_ALPHA_SCALE				 0x080098
+#define VIDEO_ALPHA_SCALE_VERTICAL_MODE		 31:31
+#define VIDEO_ALPHA_SCALE_VERTICAL_MODE_EXPAND 	 0
+#define VIDEO_ALPHA_SCALE_VERTICAL_MODE_SHRINK 	 1
+#define VIDEO_ALPHA_SCALE_VERTICAL_SCALE		 27:16
+#define VIDEO_ALPHA_SCALE_HORIZONTAL_MODE		 15:15
+#define VIDEO_ALPHA_SCALE_HORIZONTAL_MODE_EXPAND	 0
+#define VIDEO_ALPHA_SCALE_HORIZONTAL_MODE_SHRINK	 1
+#define VIDEO_ALPHA_SCALE_HORIZONTAL_SCALE		 11:0
+
+#define VIDEO_ALPHA_INITIAL_SCALE			 0x08009C
+#define VIDEO_ALPHA_INITIAL_SCALE_FB			 11:0
+
+#define VIDEO_ALPHA_CHROMA_KEY 			 0x0800A0
+#define VIDEO_ALPHA_CHROMA_KEY_MASK			 31:16
+#define VIDEO_ALPHA_CHROMA_KEY_VALUE			 15:0
+
+#define VIDEO_ALPHA_COLOR_LOOKUP_01			 0x0800A4
+#define VIDEO_ALPHA_COLOR_LOOKUP_01_1_RED		 31:27
+#define VIDEO_ALPHA_COLOR_LOOKUP_01_1_GREEN		 26:21
+#define VIDEO_ALPHA_COLOR_LOOKUP_01_1_BLUE		 20:16
+#define VIDEO_ALPHA_COLOR_LOOKUP_01_0_RED		 15:11
+#define VIDEO_ALPHA_COLOR_LOOKUP_01_0_GREEN		 10:5
+#define VIDEO_ALPHA_COLOR_LOOKUP_01_0_BLUE		 4:0
+
+#define VIDEO_ALPHA_COLOR_LOOKUP_23			 0x0800A8
+#define VIDEO_ALPHA_COLOR_LOOKUP_23_3_RED		 31:27
+#define VIDEO_ALPHA_COLOR_LOOKUP_23_3_GREEN		 26:21
+#define VIDEO_ALPHA_COLOR_LOOKUP_23_3_BLUE		 20:16
+#define VIDEO_ALPHA_COLOR_LOOKUP_23_2_RED		 15:11
+#define VIDEO_ALPHA_COLOR_LOOKUP_23_2_GREEN		 10:5
+#define VIDEO_ALPHA_COLOR_LOOKUP_23_2_BLUE		 4:0
+
+#define VIDEO_ALPHA_COLOR_LOOKUP_45			 0x0800AC
+#define VIDEO_ALPHA_COLOR_LOOKUP_45_5_RED		 31:27
+#define VIDEO_ALPHA_COLOR_LOOKUP_45_5_GREEN		 26:21
+#define VIDEO_ALPHA_COLOR_LOOKUP_45_5_BLUE		 20:16
+#define VIDEO_ALPHA_COLOR_LOOKUP_45_4_RED		 15:11
+#define VIDEO_ALPHA_COLOR_LOOKUP_45_4_GREEN		 10:5
+#define VIDEO_ALPHA_COLOR_LOOKUP_45_4_BLUE		 4:0
+
+#define VIDEO_ALPHA_COLOR_LOOKUP_67			 0x0800B0
+#define VIDEO_ALPHA_COLOR_LOOKUP_67_7_RED		 31:27
+#define VIDEO_ALPHA_COLOR_LOOKUP_67_7_GREEN		 26:21
+#define VIDEO_ALPHA_COLOR_LOOKUP_67_7_BLUE		 20:16
+#define VIDEO_ALPHA_COLOR_LOOKUP_67_6_RED		 15:11
+#define VIDEO_ALPHA_COLOR_LOOKUP_67_6_GREEN		 10:5
+#define VIDEO_ALPHA_COLOR_LOOKUP_67_6_BLUE		 4:0
+
+#define VIDEO_ALPHA_COLOR_LOOKUP_89			 0x0800B4
+#define VIDEO_ALPHA_COLOR_LOOKUP_89_9_RED		 31:27
+#define VIDEO_ALPHA_COLOR_LOOKUP_89_9_GREEN		 26:21
+#define VIDEO_ALPHA_COLOR_LOOKUP_89_9_BLUE		 20:16
+#define VIDEO_ALPHA_COLOR_LOOKUP_89_8_RED		 15:11
+#define VIDEO_ALPHA_COLOR_LOOKUP_89_8_GREEN		 10:5
+#define VIDEO_ALPHA_COLOR_LOOKUP_89_8_BLUE		 4:0
+
+#define VIDEO_ALPHA_COLOR_LOOKUP_AB			 0x0800B8
+#define VIDEO_ALPHA_COLOR_LOOKUP_AB_B_RED		 31:27
+#define VIDEO_ALPHA_COLOR_LOOKUP_AB_B_GREEN		 26:21
+#define VIDEO_ALPHA_COLOR_LOOKUP_AB_B_BLUE		 20:16
+#define VIDEO_ALPHA_COLOR_LOOKUP_AB_A_RED		 15:11
+#define VIDEO_ALPHA_COLOR_LOOKUP_AB_A_GREEN		 10:5
+#define VIDEO_ALPHA_COLOR_LOOKUP_AB_A_BLUE		 4:0
+
+#define VIDEO_ALPHA_COLOR_LOOKUP_CD			 0x0800BC
+#define VIDEO_ALPHA_COLOR_LOOKUP_CD_D_RED		 31:27
+#define VIDEO_ALPHA_COLOR_LOOKUP_CD_D_GREEN		 26:21
+#define VIDEO_ALPHA_COLOR_LOOKUP_CD_D_BLUE		 20:16
+#define VIDEO_ALPHA_COLOR_LOOKUP_CD_C_RED		 15:11
+#define VIDEO_ALPHA_COLOR_LOOKUP_CD_C_GREEN		 10:5
+#define VIDEO_ALPHA_COLOR_LOOKUP_CD_C_BLUE		 4:0
+
+#define VIDEO_ALPHA_COLOR_LOOKUP_EF			 0x0800C0
+#define VIDEO_ALPHA_COLOR_LOOKUP_EF_F_RED		 31:27
+#define VIDEO_ALPHA_COLOR_LOOKUP_EF_F_GREEN		 26:21
+#define VIDEO_ALPHA_COLOR_LOOKUP_EF_F_BLUE		 20:16
+#define VIDEO_ALPHA_COLOR_LOOKUP_EF_E_RED		 15:11
+#define VIDEO_ALPHA_COLOR_LOOKUP_EF_E_GREEN		 10:5
+#define VIDEO_ALPHA_COLOR_LOOKUP_EF_E_BLUE		 4:0
+
+/* Panel Cursor Control */
+
+#define PANEL_HWC_ADDRESS				 0x0800F0
+#define PANEL_HWC_ADDRESS_ENABLE			 31:31
+#define PANEL_HWC_ADDRESS_ENABLE_DISABLE		 0
+#define PANEL_HWC_ADDRESS_ENABLE_ENABLE		 1
+#define PANEL_HWC_ADDRESS_EXT				 27:27
+#define PANEL_HWC_ADDRESS_EXT_LOCAL			 0
+#define PANEL_HWC_ADDRESS_EXT_EXTERNAL 		 1
+#define PANEL_HWC_ADDRESS_CS				 26:26
+#define PANEL_HWC_ADDRESS_CS_0 			 0
+#define PANEL_HWC_ADDRESS_CS_1 			 1
+#define PANEL_HWC_ADDRESS_ADDRESS			 25:0
+
+#define PANEL_HWC_LOCATION				 0x0800F4
+#define PANEL_HWC_LOCATION_TOP 			 27:27
+#define PANEL_HWC_LOCATION_TOP_INSIDE			 0
+#define PANEL_HWC_LOCATION_TOP_OUTSIDE 		 1
+#define PANEL_HWC_LOCATION_Y				 26:16
+#define PANEL_HWC_LOCATION_LEFT			 11:11
+#define PANEL_HWC_LOCATION_LEFT_INSIDE 		 0
+#define PANEL_HWC_LOCATION_LEFT_OUTSIDE		 1
+#define PANEL_HWC_LOCATION_X				 10:0
+
+#define PANEL_HWC_COLOR_12				 0x0800F8
+#define PANEL_HWC_COLOR_12_2_RGB565			 31:16
+#define PANEL_HWC_COLOR_12_1_RGB565			 15:0
+
+#define PANEL_HWC_COLOR_3				 0x0800FC
+#define PANEL_HWC_COLOR_3_RGB565			 15:0
+
+/* Old Definitions +++ */
+#define PANEL_HWC_COLOR_01				 0x0800F8
+#define PANEL_HWC_COLOR_01_1_RED			 31:27
+#define PANEL_HWC_COLOR_01_1_GREEN			 26:21
+#define PANEL_HWC_COLOR_01_1_BLUE			 20:16
+#define PANEL_HWC_COLOR_01_0_RED			 15:11
+#define PANEL_HWC_COLOR_01_0_GREEN			 10:5
+#define PANEL_HWC_COLOR_01_0_BLUE			 4:0
+
+#define PANEL_HWC_COLOR_2				 0x0800FC
+#define PANEL_HWC_COLOR_2_RED				 15:11
+#define PANEL_HWC_COLOR_2_GREEN			 10:5
+#define PANEL_HWC_COLOR_2_BLUE 			 4:0
+/* Old Definitions --- */
+
+/* Alpha Control */
+
+#define ALPHA_DISPLAY_CTRL				 0x080100
+#define ALPHA_DISPLAY_CTRL_SELECT			 28:28
+#define ALPHA_DISPLAY_CTRL_SELECT_PER_PIXEL		 0
+#define ALPHA_DISPLAY_CTRL_SELECT_ALPHA		 1
+#define ALPHA_DISPLAY_CTRL_ALPHA			 27:24
+#define ALPHA_DISPLAY_CTRL_FIFO			 17:16
+#define ALPHA_DISPLAY_CTRL_FIFO_1			 0
+#define ALPHA_DISPLAY_CTRL_FIFO_3			 1
+#define ALPHA_DISPLAY_CTRL_FIFO_7			 2
+#define ALPHA_DISPLAY_CTRL_FIFO_11			 3
+#define ALPHA_DISPLAY_CTRL_PIXEL			 7:4
+#define ALPHA_DISPLAY_CTRL_CHROMA_KEY			 3:3
+#define ALPHA_DISPLAY_CTRL_CHROMA_KEY_DISABLE		 0
+#define ALPHA_DISPLAY_CTRL_CHROMA_KEY_ENABLE		 1
+#define ALPHA_DISPLAY_CTRL_PLANE			 2:2
+#define ALPHA_DISPLAY_CTRL_PLANE_DISABLE		 0
+#define ALPHA_DISPLAY_CTRL_PLANE_ENABLE		 1
+#define ALPHA_DISPLAY_CTRL_FORMAT			 1:0
+#define ALPHA_DISPLAY_CTRL_FORMAT_16			 1
+#define ALPHA_DISPLAY_CTRL_FORMAT_ALPHA_4_4		 2
+#define ALPHA_DISPLAY_CTRL_FORMAT_ALPHA_4_4_4_4	 3
+
+#define ALPHA_FB_ADDRESS				 0x080104
+#define ALPHA_FB_ADDRESS_STATUS			 31:31
+#define ALPHA_FB_ADDRESS_STATUS_CURRENT		 0
+#define ALPHA_FB_ADDRESS_STATUS_PENDING		 1
+#define ALPHA_FB_ADDRESS_EXT				 27:27
+#define ALPHA_FB_ADDRESS_EXT_LOCAL			 0
+#define ALPHA_FB_ADDRESS_EXT_EXTERNAL			 1
+#define ALPHA_FB_ADDRESS_CS				 26:26
+#define ALPHA_FB_ADDRESS_CS_0				 0
+#define ALPHA_FB_ADDRESS_CS_1				 1
+#define ALPHA_FB_ADDRESS_ADDRESS			 25:0
+
+#define ALPHA_FB_WIDTH 				 0x080108
+#define ALPHA_FB_WIDTH_WIDTH				 29:16
+#define ALPHA_FB_WIDTH_OFFSET				 13:0
+
+#define ALPHA_PLANE_TL 				 0x08010C
+#define ALPHA_PLANE_TL_TOP				 26:16
+#define ALPHA_PLANE_TL_LEFT				 10:0
+
+#define ALPHA_PLANE_BR 				 0x080110
+#define ALPHA_PLANE_BR_BOTTOM				 26:16
+#define ALPHA_PLANE_BR_RIGHT				 10:0
+
+#define ALPHA_CHROMA_KEY				 0x080114
+#define ALPHA_CHROMA_KEY_MASK				 31:16
+#define ALPHA_CHROMA_KEY_VALUE 			 15:0
+
+#define ALPHA_COLOR_LOOKUP_01				 0x080118
+#define ALPHA_COLOR_LOOKUP_01_1_RED			 31:27
+#define ALPHA_COLOR_LOOKUP_01_1_GREEN			 26:21
+#define ALPHA_COLOR_LOOKUP_01_1_BLUE			 20:16
+#define ALPHA_COLOR_LOOKUP_01_0_RED			 15:11
+#define ALPHA_COLOR_LOOKUP_01_0_GREEN			 10:5
+#define ALPHA_COLOR_LOOKUP_01_0_BLUE			 4:0
+
+#define ALPHA_COLOR_LOOKUP_23				 0x08011C
+#define ALPHA_COLOR_LOOKUP_23_3_RED			 31:27
+#define ALPHA_COLOR_LOOKUP_23_3_GREEN			 26:21
+#define ALPHA_COLOR_LOOKUP_23_3_BLUE			 20:16
+#define ALPHA_COLOR_LOOKUP_23_2_RED			 15:11
+#define ALPHA_COLOR_LOOKUP_23_2_GREEN			 10:5
+#define ALPHA_COLOR_LOOKUP_23_2_BLUE			 4:0
+
+#define ALPHA_COLOR_LOOKUP_45				 0x080120
+#define ALPHA_COLOR_LOOKUP_45_5_RED			 31:27
+#define ALPHA_COLOR_LOOKUP_45_5_GREEN			 26:21
+#define ALPHA_COLOR_LOOKUP_45_5_BLUE			 20:16
+#define ALPHA_COLOR_LOOKUP_45_4_RED			 15:11
+#define ALPHA_COLOR_LOOKUP_45_4_GREEN			 10:5
+#define ALPHA_COLOR_LOOKUP_45_4_BLUE			 4:0
+
+#define ALPHA_COLOR_LOOKUP_67				 0x080124
+#define ALPHA_COLOR_LOOKUP_67_7_RED			 31:27
+#define ALPHA_COLOR_LOOKUP_67_7_GREEN			 26:21
+#define ALPHA_COLOR_LOOKUP_67_7_BLUE			 20:16
+#define ALPHA_COLOR_LOOKUP_67_6_RED			 15:11
+#define ALPHA_COLOR_LOOKUP_67_6_GREEN			 10:5
+#define ALPHA_COLOR_LOOKUP_67_6_BLUE			 4:0
+
+#define ALPHA_COLOR_LOOKUP_89				 0x080128
+#define ALPHA_COLOR_LOOKUP_89_9_RED			 31:27
+#define ALPHA_COLOR_LOOKUP_89_9_GREEN			 26:21
+#define ALPHA_COLOR_LOOKUP_89_9_BLUE			 20:16
+#define ALPHA_COLOR_LOOKUP_89_8_RED			 15:11
+#define ALPHA_COLOR_LOOKUP_89_8_GREEN			 10:5
+#define ALPHA_COLOR_LOOKUP_89_8_BLUE			 4:0
+
+#define ALPHA_COLOR_LOOKUP_AB				 0x08012C
+#define ALPHA_COLOR_LOOKUP_AB_B_RED			 31:27
+#define ALPHA_COLOR_LOOKUP_AB_B_GREEN			 26:21
+#define ALPHA_COLOR_LOOKUP_AB_B_BLUE			 20:16
+#define ALPHA_COLOR_LOOKUP_AB_A_RED			 15:11
+#define ALPHA_COLOR_LOOKUP_AB_A_GREEN			 10:5
+#define ALPHA_COLOR_LOOKUP_AB_A_BLUE			 4:0
+
+#define ALPHA_COLOR_LOOKUP_CD				 0x080130
+#define ALPHA_COLOR_LOOKUP_CD_D_RED			 31:27
+#define ALPHA_COLOR_LOOKUP_CD_D_GREEN			 26:21
+#define ALPHA_COLOR_LOOKUP_CD_D_BLUE			 20:16
+#define ALPHA_COLOR_LOOKUP_CD_C_RED			 15:11
+#define ALPHA_COLOR_LOOKUP_CD_C_GREEN			 10:5
+#define ALPHA_COLOR_LOOKUP_CD_C_BLUE			 4:0
+
+#define ALPHA_COLOR_LOOKUP_EF				 0x080134
+#define ALPHA_COLOR_LOOKUP_EF_F_RED			 31:27
+#define ALPHA_COLOR_LOOKUP_EF_F_GREEN			 26:21
+#define ALPHA_COLOR_LOOKUP_EF_F_BLUE			 20:16
+#define ALPHA_COLOR_LOOKUP_EF_E_RED			 15:11
+#define ALPHA_COLOR_LOOKUP_EF_E_GREEN			 10:5
+#define ALPHA_COLOR_LOOKUP_EF_E_BLUE			 4:0
+
+/* CRT Graphics Control */
+
+#define CRT_DISPLAY_CTRL				 0x080200
+#define CRT_DISPLAY_CTRL_FIFO				 17:16
+#define CRT_DISPLAY_CTRL_FIFO_1			 0
+#define CRT_DISPLAY_CTRL_FIFO_3			 1
+#define CRT_DISPLAY_CTRL_FIFO_7			 2
+#define CRT_DISPLAY_CTRL_FIFO_11			 3
+#define CRT_DISPLAY_CTRL_TV_PHASE			 15:15
+#define CRT_DISPLAY_CTRL_TV_PHASE_ACTIVE_HIGH		 0
+#define CRT_DISPLAY_CTRL_TV_PHASE_ACTIVE_LOW		 1
+#define CRT_DISPLAY_CTRL_CLOCK_PHASE			 14:14
+#define CRT_DISPLAY_CTRL_CLOCK_PHASE_ACTIVE_HIGH	 0
+#define CRT_DISPLAY_CTRL_CLOCK_PHASE_ACTIVE_LOW	 1
+#define CRT_DISPLAY_CTRL_VSYNC_PHASE			 13:13
+#define CRT_DISPLAY_CTRL_VSYNC_PHASE_ACTIVE_HIGH	 0
+#define CRT_DISPLAY_CTRL_VSYNC_PHASE_ACTIVE_LOW	 1
+#define CRT_DISPLAY_CTRL_HSYNC_PHASE			 12:12
+#define CRT_DISPLAY_CTRL_HSYNC_PHASE_ACTIVE_HIGH	 0
+#define CRT_DISPLAY_CTRL_HSYNC_PHASE_ACTIVE_LOW	 1
+#define CRT_DISPLAY_CTRL_BLANK 			 10:10
+#define CRT_DISPLAY_CTRL_BLANK_OFF			 0
+#define CRT_DISPLAY_CTRL_BLANK_ON			 1
+#define CRT_DISPLAY_CTRL_SELECT			 9:9
+#define CRT_DISPLAY_CTRL_SELECT_PANEL			 0
+#define CRT_DISPLAY_CTRL_SELECT_CRT			 1
+#define CRT_DISPLAY_CTRL_TIMING			 8:8
+#define CRT_DISPLAY_CTRL_TIMING_DISABLE		 0
+#define CRT_DISPLAY_CTRL_TIMING_ENABLE 		 1
+#define CRT_DISPLAY_CTRL_PIXEL 			 7:4
+#define CRT_DISPLAY_CTRL_GAMMA 			 3:3
+#define CRT_DISPLAY_CTRL_GAMMA_DISABLE 		 0
+#define CRT_DISPLAY_CTRL_GAMMA_ENABLE			 1
+#define CRT_DISPLAY_CTRL_PLANE 			 2:2
+#define CRT_DISPLAY_CTRL_PLANE_DISABLE 		 0
+#define CRT_DISPLAY_CTRL_PLANE_ENABLE			 1
+#define CRT_DISPLAY_CTRL_FORMAT			 1:0
+#define CRT_DISPLAY_CTRL_FORMAT_8			 0
+#define CRT_DISPLAY_CTRL_FORMAT_16			 1
+#define CRT_DISPLAY_CTRL_FORMAT_32			 2
+
+#define CRT_FB_ADDRESS 				 0x080204
+#define CRT_FB_ADDRESS_STATUS				 31:31
+#define CRT_FB_ADDRESS_STATUS_CURRENT			 0
+#define CRT_FB_ADDRESS_STATUS_PENDING			 1
+#define CRT_FB_ADDRESS_EXT				 27:27
+#define CRT_FB_ADDRESS_EXT_LOCAL			 0
+#define CRT_FB_ADDRESS_EXT_EXTERNAL			 1
+#define CRT_FB_ADDRESS_CS				 26:26
+#define CRT_FB_ADDRESS_CS_0				 0
+#define CRT_FB_ADDRESS_CS_1				 1
+#define CRT_FB_ADDRESS_ADDRESS 			 25:0
+
+#define CRT_FB_WIDTH					 0x080208
+#define CRT_FB_WIDTH_WIDTH				 29:16
+#define CRT_FB_WIDTH_OFFSET				 13:0
+
+#define CRT_HORIZONTAL_TOTAL				 0x08020C
+#define CRT_HORIZONTAL_TOTAL_TOTAL			 27:16
+#define CRT_HORIZONTAL_TOTAL_DISPLAY_END		 11:0
+
+#define CRT_HORIZONTAL_SYNC				 0x080210
+#define CRT_HORIZONTAL_SYNC_WIDTH			 23:16
+#define CRT_HORIZONTAL_SYNC_START			 11:0
+
+#define CRT_VERTICAL_TOTAL				 0x080214
+#define CRT_VERTICAL_TOTAL_TOTAL			 26:16
+#define CRT_VERTICAL_TOTAL_DISPLAY_END 		 10:0
+
+#define CRT_VERTICAL_SYNC				 0x080218
+#define CRT_VERTICAL_SYNC_HEIGHT			 21:16
+#define CRT_VERTICAL_SYNC_START			 10:0
+
+#define CRT_SIGNATURE_ANALYZER 			 0x08021C
+#define CRT_SIGNATURE_ANALYZER_STATUS			 31:16
+#define CRT_SIGNATURE_ANALYZER_ENABLE			 3:3
+#define CRT_SIGNATURE_ANALYZER_ENABLE_DISABLE		 0
+#define CRT_SIGNATURE_ANALYZER_ENABLE_ENABLE		 1
+#define CRT_SIGNATURE_ANALYZER_RESET			 2:2
+#define CRT_SIGNATURE_ANALYZER_RESET_NORMAL		 0
+#define CRT_SIGNATURE_ANALYZER_RESET_RESET		 1
+#define CRT_SIGNATURE_ANALYZER_SOURCE			 1:0
+#define CRT_SIGNATURE_ANALYZER_SOURCE_RED		 0
+#define CRT_SIGNATURE_ANALYZER_SOURCE_GREEN		 1
+#define CRT_SIGNATURE_ANALYZER_SOURCE_BLUE		 2
+
+#define CRT_CURRENT_LINE				 0x080220
+#define CRT_CURRENT_LINE_LINE				 10:0
+
+#define CRT_MONITOR_DETECT				 0x080224
+#define CRT_MONITOR_DETECT_ENABLE			 24:24
+#define CRT_MONITOR_DETECT_ENABLE_DISABLE		 0
+#define CRT_MONITOR_DETECT_ENABLE_ENABLE		 1
+#define CRT_MONITOR_DETECT_RED 			 23:16
+#define CRT_MONITOR_DETECT_GREEN			 15:8
+#define CRT_MONITOR_DETECT_BLUE			 7:0
+
+/* CRT Cursor Control */
+
+#define CRT_HWC_ADDRESS				 0x080230
+#define CRT_HWC_ADDRESS_ENABLE 			 31:31
+#define CRT_HWC_ADDRESS_ENABLE_DISABLE 		 0
+#define CRT_HWC_ADDRESS_ENABLE_ENABLE			 1
+#define CRT_HWC_ADDRESS_EXT				 27:27
+#define CRT_HWC_ADDRESS_EXT_LOCAL			 0
+#define CRT_HWC_ADDRESS_EXT_EXTERNAL			 1
+#define CRT_HWC_ADDRESS_CS				 26:26
+#define CRT_HWC_ADDRESS_CS_0				 0
+#define CRT_HWC_ADDRESS_CS_1				 1
+#define CRT_HWC_ADDRESS_ADDRESS			 25:0
+
+#define CRT_HWC_LOCATION				 0x080234
+#define CRT_HWC_LOCATION_TOP				 27:27
+#define CRT_HWC_LOCATION_TOP_INSIDE			 0
+#define CRT_HWC_LOCATION_TOP_OUTSIDE			 1
+#define CRT_HWC_LOCATION_Y				 26:16
+#define CRT_HWC_LOCATION_LEFT				 11:11
+#define CRT_HWC_LOCATION_LEFT_INSIDE			 0
+#define CRT_HWC_LOCATION_LEFT_OUTSIDE			 1
+#define CRT_HWC_LOCATION_X				 10:0
+
+#define CRT_HWC_COLOR_12				 0x080238
+#define CRT_HWC_COLOR_12_2_RGB565			 31:16
+#define CRT_HWC_COLOR_12_1_RGB565			 15:0
+
+#define CRT_HWC_COLOR_3				 0x08023C
+#define CRT_HWC_COLOR_3_RGB565 			 15:0
+
+/* Old Definitions +++ */
+#define CRT_HWC_COLOR_01				 0x080238
+#define CRT_HWC_COLOR_01_1_RED 			 31:27
+#define CRT_HWC_COLOR_01_1_GREEN			 26:21
+#define CRT_HWC_COLOR_01_1_BLUE			 20:16
+#define CRT_HWC_COLOR_01_0_RED 			 15:11
+#define CRT_HWC_COLOR_01_0_GREEN			 10:5
+#define CRT_HWC_COLOR_01_0_BLUE			 4:0
+
+#define CRT_HWC_COLOR_2				 0x08023C
+#define CRT_HWC_COLOR_2_RED				 15:11
+#define CRT_HWC_COLOR_2_GREEN				 10:5
+#define CRT_HWC_COLOR_2_BLUE				 4:0
+/* Old Definitions --- */
+
+/* Palette RAM */
+
+#define PANEL_PALETTE_RAM				 0x080400
+#define VIDEO_PALETTE_RAM				 0x080800
+#define CRT_PALETTE_RAM				 0x080C00
+
+/* Power constants to use with setDPMS function. */
+typedef enum _DPMS_t {
+	DPMS_ON,
+	DPMS_STANDBY,
+	DPMS_SUSPEND,
+	DPMS_OFF
+} DPMS_t;
+
+/* ////////////////////////////////////////////////////////////////////////////// */
+/* // */
+/* D I S P L A Y   C O N T R O L L E
R                                 // */
+/* // */
+/* ////////////////////////////////////////////////////////////////////////////// */
+
+/* Display type constants to use with setMode function and others. */
+typedef enum _display_t {
+	PANEL = 0,
+	CRT = 1,
+} display_t;
+
+/* Type of LCD display */
+typedef enum _lcd_display_t {
+	LCD_TFT = 0,
+	LCD_STN_8 = 2,
+	LCD_STN_12 = 3
+} lcd_display_t;
+
+/* Polarity constants. */
+typedef enum _polarity_t {
+	POSITIVE,
+	NEGATIVE,
+} polarity_t;
+
+/* Format of mode table record. */
+typedef struct _mode_table_t {
+	/* Horizontal timing. */
+	int horizontal_total;
+	int horizontal_display_end;
+	int horizontal_sync_start;
+	int horizontal_sync_width;
+	polarity_t horizontal_sync_polarity;
+
+	/* Vertical timing. */
+	int vertical_total;
+	int vertical_display_end;
+	int vertical_sync_start;
+	int vertical_sync_height;
+	polarity_t vertical_sync_polarity;
+
+	/* Refresh timing. */
+	long pixel_clock;
+	long horizontal_frequency;
+	long vertical_frequency;
+/*
+    /* Programe PLL3 */
+	int M;
+	int N;
+	int bit15;
+	int bit31;
+*/
+} mode_table_t, *pmode_table_t;
+
+/* Clock value structure. */
+typedef struct clock_select_t {
+	long mclk;
+	long test_clock;
+	int divider;
+	int shift;
+
+	long multipleM;
+	int dividerN;
+	short divby2;
+} clock_select_t, *pclock_select_t;
+
+/* Registers necessary to set mode. */
+typedef struct _reg_table_t {
+	unsigned long clock;
+	unsigned long control;
+	unsigned long fb_width;
+	unsigned long horizontal_total;
+	unsigned long horizontal_sync;
+	unsigned long vertical_total;
+	unsigned long vertical_sync;
+	unsigned long width;
+	unsigned long height;
+	display_t display;
+} reg_table_t, *preg_table_t;
+
+/* Panel On/Off constants to use with panelPowerSequence. */
+typedef enum _panel_state_t {
+	PANEL_OFF,
+	PANEL_ON,
+} panel_state_t;
+
+/* Structure used to initialize Panel hardware module */
+typedef struct {
+	unsigned long mask;	/* Holds flags indicating which register bitfields
to init */
+	unsigned long dp;	/* TFT dithering pattern */
+	unsigned long tft;	/* TFT panel interface */
+	unsigned long de;	/* Enable/disable TFT dithering */
+	unsigned long lcd;	/* LCD type */
+	unsigned long fifo_level;	/* FIFO request level */
+	unsigned long cp;	/* Clock phase select */
+	unsigned long format;	/* Panel graphics plane format */
+} init_panel, *pinit_panel;
+
+/* Structure used to initialize Panel cursor hardware module */
+typedef struct {
+	unsigned long mask;	/* Holds flags indicating which register bitfields
to init */
+} init_panel_hwc, *pinit_panel_hwc;
+
+/* Structure used to initialize Alpha hardware module */
+typedef struct {
+	unsigned long mask;	/* Holds flags indicating which register bitfields
to init */
+	unsigned long fifo_level;	/* FIFO request level */
+	unsigned long format;	/* Alpha plane format */
+} init_alpha, *pinit_alpha;
+
+/* Structure used to initialize CRT hardware module */
+typedef struct {
+	unsigned long mask;	/* Holds flags indicating which register bitfields
to init */
+	unsigned long fifo_level;	/* FIFO request level */
+	unsigned long tvp;	/* TV clock phase select */
+	unsigned long cp;	/* CRT clock phase select */
+	unsigned long blank;	/* CRT data blanking */
+	unsigned long format;	/* CRT graphics plane format */
+} init_crt, *pinit_crt;
+
+/* Structure used to initialize CRT cursor hardware module */
+typedef struct {
+	unsigned long mask;	/* Holds flags indicating which register bitfields
to init */
+} init_crt_hwc, *pinit_crt_hwc;
+
+/* Init flags and values used in init_panel, init_alpha, and init_crt
structures */
+#define DISP_FIFO_LEVEL		    0x00000001	/* FIFO request level */
+#define DISP_FIFO_LEVEL_1		    0x00000000
+#define DISP_FIFO_LEVEL_3		    0x00010000
+#define DISP_FIFO_LEVEL_7		    0x00020000
+#define DISP_FIFO_LEVEL_11		    0x00030000
+
+/* Init flags and values used in init_panel structure */
+#define DISP_PANEL_DP			    0x00000100	/* TFT dithering pattern */
+#define DISP_PANEL_DP_4GRAY		    0x00000000
+#define DISP_PANEL_DP_8GRAY		    0x00800000
+
+#define DISP_PANEL_TFT 		    0x00000200	/* TFT panel interface */
+#define DISP_PANEL_TFT_24		    0x00000000
+#define DISP_PANEL_TFT_9		    0x00200000
+#define DISP_PANEL_TFT_12		    0x00400000
+
+#define DISP_PANEL_DE			    0x00000400	/* Enable/disable TFT dithering
*/
+#define DISP_PANEL_DE_DISABLE		    0x00000000
+#define DISP_PANEL_DE_ENABLE		    0x00100000
+
+#define DISP_PANEL_LCD 		    0x00000800	/* LCD type */
+#define DISP_PANEL_LCD_TFT		    0x00000000
+#define DISP_PANEL_LCD_STN8		    0x00080000
+#define DISP_PANEL_LCD_STN12		    0x000C0000
+
+#define DISP_PANEL_CP			    0x00001000	/* Clock phase select */
+#define DISP_PANEL_CP_HIGH		    0x00000000
+#define DISP_PANEL_CP_LOW		    0x00004000
+
+#define DISP_PANEL_FORMAT		    0x00002000	/* Panel graphics plane
format */
+#define DISP_PANEL_FORMAT_8		    0x00000000
+#define DISP_PANEL_FORMAT_16		    0x00000001
+#define DISP_PANEL_FORMAT_32		    0x00000002
+
+/* Init flags and values used in init_alpha structure */
+#define DISP_ALPHA_FORMAT		    0x00000100	/* Alpha plane format */
+#define DISP_ALPHA_FORMAT_RGB565	    0x00000001
+#define DISP_ALPHA_FORMAT_ALPHA44	    0x00000002
+#define DISP_ALPHA_FORMAT_ALPHA4444	    0x00000003
+
+/* Init flags and values used in init_crt structure */
+#define DISP_CRT_TVP			    0x00000100	/* TV clock phase select */
+#define DISP_CRT_TVP_HIGH		    0x00000000
+#define DISP_CRT_TVP_LOW		    0x00008000
+
+#define DISP_CRT_CP			    0x00000200	/* CRT clock phase select */
+#define DISP_CRT_CP_HIGH		    0x00000000
+#define DISP_CRT_CP_LOW		    0x00004000
+
+#define DISP_CRT_BLANK 		    0x00000400	/* CRT data blanking */
+#define DISP_CRT_BLANK_OFF		    0x00000000
+#define DISP_CRT_BLANK_ON		    0x00000400
+
+#define DISP_CRT_FORMAT		    0x00000800	/* CRT graphics plane format */
+#define DISP_CRT_FORMAT_8		    0x00000000
+#define DISP_CRT_FORMAT_16		    0x00000001
+#define DISP_CRT_FORMAT_32		    0x00000002
+
+#define DISP_MODE_8_BPP				   0	/* 8 bits per pixel i8RGB */
+#define DISP_MODE_16_BPP			   1	/* 16 bits per pixel RGB565 */
+#define DISP_MODE_32_BPP			   2	/* 32 bits per pixel RGB888 */
+#define DISP_MODE_YUV				   3	/* 16 bits per pixel YUV422 */
+#define DISP_MODE_ALPHA_8			   4	/* 8 bits per pixel a4i4RGB */
+#define DISP_MODE_ALPHA_16			   5	/* 16 bits per pixel a4RGB444 */
+
+#define DISP_PAN_LEFT				   0	/* Pan left */
+#define DISP_PAN_RIGHT				   1	/* Pan right */
+#define DISP_PAN_UP				   2	/* Pan upwards */
+#define DISP_PAN_DOWN			           3	/* Pan downwards */
+
+#define DISP_DPMS_QUERY				   -1	/* Query DPMS value */
+#define DISP_DPMS_ON				   0	/* DPMS on */
+#define DISP_DPMS_STANDBY		           1	/* DPMS standby */
+#define DISP_DPMS_SUSPEND			   2	/* DPMS suspend */
+#define DISP_DPMS_OFF				   3	/* DPMS off */
+
+#define DISP_DELAY_DEFAULT			   0	/* Default delay */
+
+#define DISP_HVTOTAL_UNKNOWN		    	   -1	/* Used in panelSetTiming,
crtSetTiming if */
+							  /* nHTotal, nVTotal not specified by user */
+#define DISP_HVTOTAL_SCALEFACTOR	    	   1.25	/* Used in
panelSetTiming, crtSetTiming if */
+							  /* nHTotal, nVTotal not specified by user */
+
+#define VGX_SIGNAL_PANEL_VSYNC 	   	    100	/* Panel VSYNC */
+#define VGX_SIGNAL_PANEL_PAN		    101	/* Panel auto panning complete */
+#define VGX_SIGNAL_CRT_VSYNC		    102	/* CRT VSYNC */
+
+#define VSYNCTIMEOUT			    10000
+
+#define ALPHA_MODE_PER_PIXEL		    0	/* Use per-pixel alpha values */
+#define ALPHA_MODE_ALPHA		    1	/* Use alpha value specified in Alpha
bitfield */
+#define ALPHA_COLOR_LUT_SIZE		    16	/* Number of colors in alpha/video
alpha palette */
+
+#define HWC_ON_SCREEN			    0	/* Cursor is within screen top/left
boundary */
+#define HWC_OFF_SCREEN 		    1	/* Cursor is outside screen top/left
boundary */
+#define HWC_NUM_COLORS 		    3	/* Number of cursor colors */
diff --git a/drivers/video/smi/sm7xxhw.h b/drivers/video/smi/sm7xxhw.h
new file mode 100644
index 0000000..8460847
--- /dev/null
+++ b/drivers/video/smi/sm7xxhw.h
@@ -0,0 +1,100 @@
+/*
+ *  linux/drivers/video/sm7xxhw.h -- Silicon Motion SM7xx frame buffer
device
+ *
+ *	 Copyright (C) 2006 Silicon Motion, Inc.
+ *	 Ge Wang, gewang@siliconmotion.com
+ *
+ *  This file is subject to the terms and conditions of the GNU General
Public
+ *  License. See the file COPYING in the main directory of this archive
for
+ *  more details.
+ */
+
+#define SM712_VIDEOMEMORYSIZE	  0x00400000	/*Assume SM712 graphics chip
has 4MB VRAM */
+#define SM722_VIDEOMEMORYSIZE	  0x00800000	/*Assume SM722 graphics chip
has 8MB VRAM */
+
+#define dac_reg	(0x3c8)
+#define dac_val	(0x3c9)
+
+#define smtc_mmiowb(dat,reg)	writeb(dat, smtc_RegBaseAddress + reg)
+#define smtc_mmioww(dat,reg)	writew(dat, smtc_RegBaseAddress + reg)
+#define smtc_mmiowl(dat,reg)	writel(dat, smtc_RegBaseAddress + reg)
+
+#define smtc_mmiorb(reg)		readb(smtc_RegBaseAddress + reg)
+#define smtc_mmiorw(reg)		readw(smtc_RegBaseAddress + reg)
+#define smtc_mmiorl(reg)		readl(smtc_RegBaseAddress + reg)
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
+#define SIZE_VPR	     (0x6C + 1)
+#define SIZE_DPR			(0x44 + 1)
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
+/* The next structure holds all information relevant for a specific
video mode. */
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
diff --git a/drivers/video/smi/smtc2d.c b/drivers/video/smi/smtc2d.c
new file mode 100644
index 0000000..b14909a
--- /dev/null
+++ b/drivers/video/smi/smtc2d.c
@@ -0,0 +1,1451 @@
+/*
+ *  linux/drivers/video/smtc2d.c -- Silicon Motion SM501 and SM7xx 2D
drawing engine functions.
+ *
+ *	 Copyright (C) 2006 Silicon Motion Technology Corp.
+ *	 Boyod boyod.yang@siliconmotion.com.cn
+ *
+ *  This file is subject to the terms and conditions of the GNU General
Public
+ *  License. See the file COPYING in the main directory of this archive
for
+ *  more details.
+*
+*
+* Version 0.10.26192.21.01
+    - Add PowerPC support
+	- Add 2D support for Lynx
+    - Verified on 2.6.19.2			     Boyod.yang
<boyod.yang@siliconmotion.com.cn>
+
+*/
+
+unsigned char smtc_de_busy = 0;
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
+
**********************************************************************/
+void deInit(unsigned int nModeWidth, unsigned int nModeHeight, unsigned
int bpp)
+{
+
+	/* Get current power configuration. */
+	unsigned char clock;
+	clock = smtc_seqr(0x21);
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
+									  DE_PITCH,
+									  SOURCE,
+									  nModeWidth
+									  * 3));
+	} else {
+		SMTC_write2Dreg(DE_PITCH,
+				FIELD_VALUE(0, DE_PITCH, DESTINATION,
+					    nModeWidth) | FIELD_VALUE(0,
+								      DE_PITCH,
+								      SOURCE,
+								      nModeWidth));
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
+								DE_STRETCH_FORMAT,
+								PATTERN_Y,
+								0) |
+				FIELD_VALUE(0, DE_STRETCH_FORMAT, PATTERN_X,
+					    0) | FIELD_SET(0, DE_STRETCH_FORMAT,
+							   PIXEL_FORMAT,
+							   8) | FIELD_SET(0,
+									  DE_STRETCH_FORMAT,
+									  ADDRESSING,
+									  XY) |
+				FIELD_VALUE(0, DE_STRETCH_FORMAT, SOURCE_HEIGHT,
+					    3));
+		break;
+	case 24:
+		SMTC_write2Dreg(DE_STRETCH_FORMAT,
+				FIELD_SET(0, DE_STRETCH_FORMAT, PATTERN_XY,
+					  NORMAL) | FIELD_VALUE(0,
+								DE_STRETCH_FORMAT,
+								PATTERN_Y,
+								0) |
+				FIELD_VALUE(0, DE_STRETCH_FORMAT, PATTERN_X,
+					    0) | FIELD_SET(0, DE_STRETCH_FORMAT,
+							   PIXEL_FORMAT,
+							   24) | FIELD_SET(0,
+									   DE_STRETCH_FORMAT,
+									   ADDRESSING,
+									   XY) |
+				FIELD_VALUE(0, DE_STRETCH_FORMAT, SOURCE_HEIGHT,
+					    3));
+		break;
+	case 16:
+	default:
+		SMTC_write2Dreg(DE_STRETCH_FORMAT,
+				FIELD_SET(0, DE_STRETCH_FORMAT, PATTERN_XY,
+					  NORMAL) | FIELD_VALUE(0,
+								DE_STRETCH_FORMAT,
+								PATTERN_Y,
+								0) |
+				FIELD_VALUE(0, DE_STRETCH_FORMAT, PATTERN_X,
+					    0) | FIELD_SET(0, DE_STRETCH_FORMAT,
+							   PIXEL_FORMAT,
+							   16) | FIELD_SET(0,
+									   DE_STRETCH_FORMAT,
+									   ADDRESSING,
+									   XY) |
+				FIELD_VALUE(0, DE_STRETCH_FORMAT, SOURCE_HEIGHT,
+					    3));
+		break;
+	}
+
+	SMTC_write2Dreg(DE_MASKS,
+			FIELD_VALUE(0, DE_MASKS, BYTE_MASK, 0xFFFF) |
+			FIELD_VALUE(0, DE_MASKS, BIT_MASK, 0xFFFF));
+	SMTC_write2Dreg(DE_COLOR_COMPARE_MASK,
+			FIELD_VALUE(0, DE_COLOR_COMPARE_MASK, MASKS, 0xFFFFFF));
+	SMTC_write2Dreg(DE_COLOR_COMPARE,
+			FIELD_VALUE(0, DE_COLOR_COMPARE, COLOR, 0xFFFFFF));
+}
+
+/**********************************************************************
+ *
+ * deSetClipRectangle
+ *
+ * Purpose
+ *    Set drawing engine clip rectangle.
+ *
+ * Remarks
+ *	  Caller need to pass in valid rectangle parameter in device
coordinate.
+
**********************************************************************/
+void deSetClipRectangle(int left, int top, int right, int bottom)
+{
+	/* Top left of clipping rectangle cannot be negative */
+	if (top < 0) {
+		top = 0;
+	}
+
+	if (left < 0) {
+		left = 0;
+	}
+
+	SMTC_write2Dreg(DE_CLIP_TL,
+			FIELD_VALUE(0, DE_CLIP_TL, TOP, top) |
+			FIELD_SET(0, DE_CLIP_TL, STATUS, ENABLE) |
+			FIELD_SET(0, DE_CLIP_TL, INHIBIT, OUTSIDE) |
+			FIELD_VALUE(0, DE_CLIP_TL, LEFT, left));
+	SMTC_write2Dreg(DE_CLIP_BR,
+			FIELD_VALUE(0, DE_CLIP_BR, BOTTOM, bottom) |
+			FIELD_VALUE(0, DE_CLIP_BR, RIGHT, right));
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
+				    dst_pitch) | FIELD_VALUE(0, DE_WINDOW_WIDTH,
+							     SOURCE,
+							     dst_pitch));
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
+				    dst_pitch) | FIELD_VALUE(0, DE_WINDOW_WIDTH,
+							     SOURCE,
+							     dst_pitch));
+	SMTC_write2Dreg(DE_FOREGROUND,
+			FIELD_VALUE(0, DE_FOREGROUND, COLOR, nColor));
+	SMTC_write2Dreg(DE_DESTINATION,
+			FIELD_SET(0, DE_DESTINATION, WRAP,
+				  DISABLE) | FIELD_VALUE(0, DE_DESTINATION, X,
+							 nX) | FIELD_VALUE(0,
+									   DE_DESTINATION,
+									   Y,
+									   nY));
+	SMTC_write2Dreg(DE_DIMENSION,
+			FIELD_VALUE(0, DE_DIMENSION, X,
+				    dst_width) | FIELD_VALUE(0, DE_DIMENSION,
+							     Y_ET, 1));
+	SMTC_write2Dreg(DE_CONTROL,
+			FIELD_SET(0, DE_CONTROL, STATUS, START) | FIELD_SET(0,
+									    DE_CONTROL,
+									    DIRECTION,
+									    RIGHT_TO_LEFT)
+			| FIELD_SET(0, DE_CONTROL, MAJOR, X) | FIELD_SET(0,
+									 DE_CONTROL,
+									 STEP_X,
+									 POSITIVE)
+			| FIELD_SET(0, DE_CONTROL, STEP_Y,
+				    NEGATIVE) | FIELD_SET(0, DE_CONTROL,
+							  LAST_PIXEL,
+							  OFF) | FIELD_SET(0,
+									   DE_CONTROL,
+									   COMMAND,
+									   SHORT_STROKE)
+			| FIELD_SET(0, DE_CONTROL, ROP_SELECT,
+				    ROP2) | FIELD_VALUE(0, DE_CONTROL, ROP,
+							0x0C));
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
+	if (nX1 <= nX2) {
+		DeltaX = nX2 - nX1;
+	} else {
+		DeltaX = nX1 - nX2;
+		nCommand = FIELD_SET(nCommand, DE_CONTROL, STEP_X, NEGATIVE);
+	}
+
+	/* Calculate delta Y */
+	if (nY1 <= nY2) {
+		DeltaY = nY2 - nY1;
+	} else {
+		DeltaY = nY1 - nY2;
+		nCommand = FIELD_SET(nCommand, DE_CONTROL, STEP_Y, NEGATIVE);
+	}
+
+	/* Determine the major axis */
+	if (DeltaX < DeltaY) {
+		nCommand = FIELD_SET(nCommand, DE_CONTROL, MAJOR, Y);
+	}
+
+	/* Vertical line? */
+	if (nX1 == nX2)
+		deVerticalLine(dst_base, dst_pitch, nX1, nY1, DeltaY, nColor);
+
+	/* Horizontal line? */
+	else if (nY1 == nY2)
+		deHorizontalLine(dst_base, dst_pitch, nX1, nY1, DeltaX, nColor);
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
+								     DE_PITCH,
+								     SOURCE,
+								     dst_pitch));
+
+		SMTC_write2Dreg(DE_WINDOW_WIDTH,
+				FIELD_VALUE(0, DE_WINDOW_WIDTH, DESTINATION,
+					    dst_pitch) | FIELD_VALUE(0,
+								     DE_WINDOW_WIDTH,
+								     SOURCE,
+								     dst_pitch));
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
+								     DE_PITCH,
+								     SOURCE,
+								     dst_pitch));
+
+		SMTC_write2Dreg(DE_WINDOW_WIDTH,
+				FIELD_VALUE(0, DE_WINDOW_WIDTH, DESTINATION,
+					    dst_pitch) | FIELD_VALUE(0,
+								     DE_WINDOW_WIDTH,
+								     SOURCE,
+								     dst_pitch));
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
+								     DE_PITCH,
+								     SOURCE,
+								     dst_pitch));
+
+		SMTC_write2Dreg(DE_WINDOW_WIDTH,
+				FIELD_VALUE(0, DE_WINDOW_WIDTH, DESTINATION,
+					    dst_pitch) | FIELD_VALUE(0,
+								     DE_WINDOW_WIDTH,
+								     SOURCE,
+								     dst_pitch));
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
rotated pattern
+ *
+ *
+
**********************************************************************/
+void deRotatePattern(unsigned char *pattern_dstaddr,
+		     unsigned long pattern_src_addr,
+		     unsigned long pattern_BPP,
+		     unsigned long pattern_stride, int patternX, int patternY)
+{
+	unsigned int i;
+	unsigned long pattern_read_addr;
+	unsigned long pattern[PATTERN_WIDTH * PATTERN_HEIGHT];
+	unsigned int x, y;
+	unsigned char *pjPatByte;
+
+	if (pattern_dstaddr != NULL) {
+		deWaitForNotBusy();
+
+		/* Load pattern from local video memory into pattern array */
+		pattern_read_addr = pattern_src_addr;
+
+		for (i = 0; i < (pattern_BPP * 2); i++) {
+/* pattern[i] = memRead32(pattern_read_addr);       removed by boyod */
+			pattern_read_addr += 4;
+		}
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
+			/* Don't rotate, just copy pattern into pattern_dstaddr */
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
+ * deMonoPatternFill
+ *
+ * Purpose
+ *    Copy the specified monochrome pattern into the destination
surface
+ *
+ * Remarks
+ *	  Pattern size must be 8x8 pixel.
+ *	  Pattern color depth must be same as destination bitmap or
monochrome.
+**********************************************************************/
+void deMonoPatternFill(unsigned long dst_base,
+		       unsigned long dst_pitch,
+		       unsigned long dst_BPP,
+		       unsigned long dstX,
+		       unsigned long dstY,
+		       unsigned long dst_width,
+		       unsigned long dst_height,
+		       unsigned long pattern_FGcolor,
+		       unsigned long pattern_BGcolor,
+		       unsigned long pattern_low, unsigned long pattern_high)
+{
+	deWaitForNotBusy();
+
+	SMTC_write2Dreg(DE_WINDOW_DESTINATION_BASE,
+			FIELD_VALUE(0, DE_WINDOW_DESTINATION_BASE, ADDRESS,
+				    dst_base));
+
+	SMTC_write2Dreg(DE_PITCH,
+			FIELD_VALUE(0, DE_PITCH, DESTINATION,
+				    dst_pitch) | FIELD_VALUE(0, DE_PITCH,
+							     SOURCE,
+							     dst_pitch));
+
+	SMTC_write2Dreg(DE_WINDOW_WIDTH,
+			FIELD_VALUE(0, DE_WINDOW_WIDTH, DESTINATION,
+				    dst_pitch) | FIELD_VALUE(0, DE_WINDOW_WIDTH,
+							     SOURCE,
+							     dst_pitch));
+
+	SMTC_write2Dreg(DE_FOREGROUND,
+			FIELD_VALUE(0, DE_FOREGROUND, COLOR, pattern_FGcolor));
+
+	SMTC_write2Dreg(DE_BACKGROUND,
+			FIELD_VALUE(0, DE_BACKGROUND, COLOR, pattern_BGcolor));
+
+	SMTC_write2Dreg(DE_MONO_PATTERN_LOW,
+			FIELD_VALUE(0, DE_MONO_PATTERN_LOW, PATTERN,
+				    pattern_low));
+
+	SMTC_write2Dreg(DE_MONO_PATTERN_HIGH,
+			FIELD_VALUE(0, DE_MONO_PATTERN_HIGH, PATTERN,
+				    pattern_high));
+
+	SMTC_write2Dreg(DE_DESTINATION,
+			FIELD_SET(0, DE_DESTINATION, WRAP, DISABLE) |
+			FIELD_VALUE(0, DE_DESTINATION, X, dstX) |
+			FIELD_VALUE(0, DE_DESTINATION, Y, dstY));
+
+	SMTC_write2Dreg(DE_DIMENSION,
+			FIELD_VALUE(0, DE_DIMENSION, X, dst_width) |
+			FIELD_VALUE(0, DE_DIMENSION, Y_ET, dst_height));
+
+	SMTC_write2Dreg(DE_CONTROL,
+			FIELD_VALUE(0, DE_CONTROL, ROP, 0xF0) |
+			FIELD_SET(0, DE_CONTROL, COMMAND, BITBLT) |
+			FIELD_SET(0, DE_CONTROL, PATTERN, MONO) |
+			FIELD_SET(0, DE_CONTROL, STATUS, START));
+
+	smtc_de_busy = 1;
+}				/* deMonoPatternFill() */
+
+/**********************************************************************
+ *
+ * deColorPatternFill
+ *
+ * Purpose
+ *    Copy the specified pattern into the destination surface
+ *
+ * Parameters
+ *    [in]
+ *	   pDestSurface   - Pointer to DE_SURFACE structure containing
+ *			    destination surface attributes
+ *	   nX		  - X coordinate of destination surface to be filled
+ *	   nY		  - Y coordinate of destination surface to be filled
+ *	   dst_width	     - Width (in pixels) of area to be filled
+ *	   dst_height	     - Height (in lines) of area to be filled
+ *	   pPattern	  - Pointer to DE_SURFACE structure containing
+ *			    pattern attributes
+ *	   pPatternOrigin - Pointer to Point structure containing pattern
origin
+ *	   pMonoInfo	  - Pointer to mono_pattern_info structure
+ *	   pClipRect	  - Pointer to Rect structure describing clipping
+ *			    rectangle; NULL if no clipping required
+ *
+ *    [out]
+ *	   None
+ *
+ * Remarks
+ *	  Pattern size must be 8x8 pixel.
+ *	  Pattern color depth must be same as destination bitmap.
+**********************************************************************/
+void deColorPatternFill(unsigned long dst_base,
+			unsigned long dst_pitch,
+			unsigned long dst_BPP,
+			unsigned long dst_X,
+			unsigned long dst_Y,
+			unsigned long dst_width,
+			unsigned long dst_height,
+			unsigned long pattern_src_addr,
+			unsigned long pattern_stride,
+			int PatternOriginX, int PatternOriginY)
+{
+	unsigned int i;
+	unsigned long de_data_port_write_addr;
+	unsigned char ajPattern[PATTERN_WIDTH * PATTERN_HEIGHT * 4];
+	unsigned long de_ctrl = 0;
+
+	deWaitForNotBusy();
+
+	de_ctrl = FIELD_SET(0, DE_CONTROL, PATTERN, COLOR);
+
+	SMTC_write2Dreg(DE_CONTROL, de_ctrl);
+
+	/* Rotate pattern if necessary */
+	deRotatePattern(ajPattern, pattern_src_addr, dst_BPP, pattern_stride,
+			PatternOriginX, PatternOriginY);
+
+	/* Load pattern to 2D Engine Data Port */
+	de_data_port_write_addr = 0;
+
+	for (i = 0; i < (dst_BPP * 2); i++) {
+		SMTC_write2Ddataport(de_data_port_write_addr,
+				     ((unsigned long *)ajPattern)[i]);
+		de_data_port_write_addr += 4;
+	}
+
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
+				    dst_pitch) | FIELD_VALUE(0, DE_WINDOW_WIDTH,
+							     SOURCE,
+							     dst_pitch));
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
+			FIELD_VALUE(0, DE_CONTROL, ROP, 0xF0) |
+			FIELD_SET(0, DE_CONTROL, COMMAND, BITBLT) |
+			FIELD_SET(0, DE_CONTROL, PATTERN, COLOR) |
+			FIELD_SET(0, DE_CONTROL, STATUS, START));
+
+	smtc_de_busy = 1;
+}				/* deColorPatternFill() */
+
+/**********************************************************************
+ *
+ * deCopy
+ *
+ * Purpose
+ *    Copy a rectangular area of the source surface to a destination
surface
+ *
+ * Remarks
+ *	  Source bitmap must have the same color depth (BPP) as the
destination bitmap.
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
+	unsigned long opSign = 1;	/* Direction of ROP2 operation: 1 = Left to
Right, (-1) = Right to Left */
+	unsigned long xWidth = 192 / (dst_BPP / 8);	/* xWidth is in pixels */
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
+				FIELD_VALUE(0, DE_PITCH, DESTINATION,
+					    dst_pitch) | FIELD_VALUE(0,
+								     DE_PITCH,
+								     SOURCE,
+								     src_pitch));
+
+		SMTC_write2Dreg(DE_WINDOW_WIDTH,
+				FIELD_VALUE(0, DE_WINDOW_WIDTH, DESTINATION,
+					    dst_pitch) | FIELD_VALUE(0,
+								     DE_WINDOW_WIDTH,
+								     SOURCE,
+								     src_pitch));
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
+		   |S       |
+		   |         +----------+
+		   |         |      |   |
+		   |         |      |   |
+		   +---|------+   |
+		   |               D|
+		   +----------+ */
+
+		nDirection = BOTTOM_TO_TOP;
+	} else if (src_Y > dst_Y) {
+		/* +----------+
+		   |D       |
+		   |         +----------+
+		   |         |      |   |
+		   |         |      |   |
+		   +---|------+   |
+		   |               S|
+		   +----------+ */
+
+		nDirection = TOP_TO_BOTTOM;
+	} else {
+		/* src_Y == dst_Y */
+
+		if (src_X <= dst_X) {
+			/* +------+---+------+
+			   |S  |   |     D|
+			   |   |   |      |
+			   |   |   |      |
+			   |   |   |      |
+			   +------+---+------+ */
+
+			nDirection = RIGHT_TO_LEFT;
+		} else {
+			/* src_X > dst_X */
+
+			/* +------+---+------+
+			   |D     |        |     S|
+			   |           |   |      |
+			   |           |   |      |
+			   |           |   |      |
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
+		/* Perform the ROP2 operation in chunks of (xWidth * dst_height) */
+		while (1) {
+			deWaitForNotBusy();
+			SMTC_write2Dreg(DE_SOURCE,
+					FIELD_SET(0, DE_SOURCE, WRAP, DISABLE) |
+					FIELD_VALUE(0, DE_SOURCE, X_K1, src_X) |
+					FIELD_VALUE(0, DE_SOURCE, Y_K2, src_Y));
+			SMTC_write2Dreg(DE_DESTINATION,
+					FIELD_SET(0, DE_DESTINATION, WRAP,
+						  DISABLE) | FIELD_VALUE(0,
+									 DE_DESTINATION,
+									 X,
+									 dst_X)
+					| FIELD_VALUE(0, DE_DESTINATION, Y,
+						      dst_Y));
+			SMTC_write2Dreg(DE_DIMENSION,
+					FIELD_VALUE(0, DE_DIMENSION, X,
+						    xWidth) | FIELD_VALUE(0,
+									  DE_DIMENSION,
+									  Y_ET,
+									  dst_height));
+			de_ctrl =
+			    FIELD_VALUE(0, DE_CONTROL, ROP,
+					nROP2) | nTransparent | FIELD_SET(0,
+									  DE_CONTROL,
+									  ROP_SELECT,
+									  ROP2)
+			    | FIELD_SET(0, DE_CONTROL, COMMAND,
+					BITBLT) | ((nDirection ==
+						    1) ? FIELD_SET(0,
+								   DE_CONTROL,
+								   DIRECTION,
+								   RIGHT_TO_LEFT)
+						   : FIELD_SET(0, DE_CONTROL,
+							       DIRECTION,
+							       LEFT_TO_RIGHT)) |
+			    FIELD_SET(0, DE_CONTROL, STATUS, START);
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
+			if (xWidth > dst_width) {
+				xWidth = dst_width;
+			}
+		}
+	} else {
+		deWaitForNotBusy();
+		SMTC_write2Dreg(DE_SOURCE,
+				FIELD_SET(0, DE_SOURCE, WRAP, DISABLE) |
+				FIELD_VALUE(0, DE_SOURCE, X_K1, src_X) |
+				FIELD_VALUE(0, DE_SOURCE, Y_K2, src_Y));
+		SMTC_write2Dreg(DE_DESTINATION,
+				FIELD_SET(0, DE_DESTINATION, WRAP, DISABLE) |
+				FIELD_VALUE(0, DE_DESTINATION, X, dst_X) |
+				FIELD_VALUE(0, DE_DESTINATION, Y, dst_Y));
+		SMTC_write2Dreg(DE_DIMENSION,
+				FIELD_VALUE(0, DE_DIMENSION, X, dst_width) |
+				FIELD_VALUE(0, DE_DIMENSION, Y_ET, dst_height));
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
+/**********************************************************************
+ *
+ * deSrcCopyHost
+ *
+ * Purpose
+ *    Copy a rectangular area of the source surface in system memory to
+ *    a destination surface in video memory
+ *
+ * Remarks
+ *	  Source bitmap must have the same color depth (BPP) as the
destination bitmap.
+ *
+**********************************************************************/
+void deSrcCopyHost(unsigned long dst_base,
+		   unsigned long dst_pitch,
+		   unsigned long dst_BPP,
+		   unsigned long dst_X,
+		   unsigned long dst_Y,
+		   unsigned long dst_width,
+		   unsigned long dst_height,
+		   unsigned long src_base,
+		   unsigned long src_stride,
+		   unsigned long src_X,
+		   unsigned long src_Y,
+		   pTransparent pTransp, unsigned char nROP2)
+{
+	int nBytes_per_scan;
+	int nBytes8_per_scan;
+	int nBytes_remain;
+	int nLong;
+	unsigned long nTransparent = 0;
+	unsigned long de_ctrl = 0;
+	unsigned long i;
+	int j;
+	unsigned long ulSrc;
+	unsigned long de_data_port_write_addr;
+	unsigned char abyRemain[8] = { 0, 0, 0, 0, 0, 0, 0, 0 };
+	unsigned char *pSrcBuffer;
+
+	pSrcBuffer =
+	    (unsigned char *)(src_base + src_Y * src_stride +
+			      src_X * (dst_BPP / 8));
+
+	nBytes_per_scan = dst_width * (dst_BPP / 8);
+	nBytes8_per_scan = (nBytes_per_scan + 7) & ~7;
+	nBytes_remain = nBytes_per_scan & 7;
+	nLong = nBytes_per_scan & ~7;
+
+	/* Program 2D Drawing Engine */
+	deWaitForNotBusy();
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
+	SMTC_write2Dreg(DE_WINDOW_DESTINATION_BASE,
+			FIELD_VALUE(0, DE_WINDOW_DESTINATION_BASE, ADDRESS,
+				    dst_base));
+
+	SMTC_write2Dreg(DE_WINDOW_SOURCE_BASE,
+			FIELD_VALUE(0, DE_WINDOW_SOURCE_BASE, ADDRESS, 0));
+
+	SMTC_write2Dreg(DE_SOURCE,
+			FIELD_SET(0, DE_SOURCE, WRAP, DISABLE) |
+			FIELD_VALUE(0, DE_SOURCE, X_K1, 0) |
+			FIELD_VALUE(0, DE_SOURCE, Y_K2, src_Y));
+	SMTC_write2Dreg(DE_DESTINATION,
+			FIELD_SET(0, DE_DESTINATION, WRAP, DISABLE) |
+			FIELD_VALUE(0, DE_DESTINATION, X, dst_X) |
+			FIELD_VALUE(0, DE_DESTINATION, Y, dst_Y));
+	SMTC_write2Dreg(DE_DIMENSION,
+			FIELD_VALUE(0, DE_DIMENSION, X, dst_width) |
+			FIELD_VALUE(0, DE_DIMENSION, Y_ET, dst_height));
+	SMTC_write2Dreg(DE_PITCH,
+			FIELD_VALUE(0, DE_PITCH, DESTINATION, dst_width) |
+			FIELD_VALUE(0, DE_PITCH, SOURCE, dst_width));
+	SMTC_write2Dreg(DE_WINDOW_WIDTH,
+			FIELD_VALUE(0, DE_WINDOW_WIDTH, DESTINATION,
+				    dst_width) | FIELD_VALUE(0, DE_WINDOW_WIDTH,
+							     SOURCE,
+							     dst_width));
+	de_ctrl =
+	    FIELD_VALUE(0, DE_CONTROL, ROP, nROP2) | nTransparent |
FIELD_SET(0,
+									      DE_CONTROL,
+									      ROP_SELECT,
+									      ROP2)
+	    | FIELD_SET(0, DE_CONTROL, COMMAND, HOST_WRITE) | FIELD_SET(0,
+									DE_CONTROL,
+									STATUS,
+									START);
+	SMTC_write2Dreg(DE_CONTROL, de_ctrl);
+
+	/* Write bitmap/image data (line by line) to 2D Engine data port */
+	de_data_port_write_addr = 0;
+
+	for (i = 1; i < dst_height; i++) {
+		for (j = 0; j < (nBytes8_per_scan / 4); j++) {
+			memcpy(&ulSrc, (pSrcBuffer + (j * 4)), 4);
+			SMTC_write2Ddataport(de_data_port_write_addr, ulSrc);
+		}
+
+		pSrcBuffer += src_stride;
+	}
+
+	/* Special handling for last line of bitmap */
+	if (nLong) {
+		for (j = 0; j < (nLong / 4); j++) {
+			memcpy(&ulSrc, (pSrcBuffer + (j * 4)), 4);
+			SMTC_write2Ddataport(de_data_port_write_addr, ulSrc);
+		}
+	}
+
+	if (nBytes_remain) {
+		memcpy(abyRemain, (pSrcBuffer + nLong), nBytes_remain);
+		SMTC_write2Ddataport(de_data_port_write_addr,
+				     *(unsigned long *)abyRemain);
+		SMTC_write2Ddataport(de_data_port_write_addr,
+				     *(unsigned long *)(abyRemain + 4));
+	}
+
+	smtc_de_busy = 1;
+}
+
+/**********************************************************************
+ *
+ * deMonoSrcCopyHost
+ *
+ * Purpose
+ *    Copy a rectangular area of the monochrome source surface in
+ *    system memory to a destination surface in video memory
+ *
+ * Parameters
+ *    [in]
+ *	   pSrcSurface	- Pointer to DE_SURFACE structure containing
+ *			  source surface attributes
+ *	   pSrcBuffer	- Pointer to source buffer (system memory)
+ *			  containing monochrome image
+ *	   src_X	- X coordinate of source surface
+ *	   src_Y	- Y coordinate of source surface
+ *	   pDestSurface - Pointer to DE_SURFACE structure containing
+ *			  destination surface attributes
+ *	   dst_X       - X coordinate of destination surface
+ *	   dst_Y       - Y coordinate of destination surface
+ *	   dst_width	   - Width (in pixels) of the area to be copied
+ *	   dst_height	   - Height (in lines) of the area to be copied
+ *	   nFgColor	- Foreground color
+ *	   nBgColor	- Background color
+ *	   pClipRect	- Pointer to Rect structure describing clipping
+ *			  rectangle; NULL if no clipping required
+ *	   pTransp	- Pointer to Transparent structure containing
+ *			  transparency settings; NULL if no transparency
+ *			  required
+ *
+ *    [out]
+ *	   None
+ *
+ * Returns
+ *    DDK_OK			   - function is successful
+ *    DDK_ERROR_NULL_PSRCSURFACE  - pSrcSurface is NULL
+ *    DDK_ERROR_NULL_PDESTSURFACE - pDestSurface is NULL
+ *
+**********************************************************************/
+void deMonoSrcCopyHost(unsigned long dst_base,
+		       unsigned long dst_pitch,
+		       unsigned long dst_BPP,
+		       unsigned long dst_X,
+		       unsigned long dst_Y,
+		       unsigned long dst_width,
+		       unsigned long dst_height,
+		       unsigned long src_base,
+		       unsigned long src_stride,
+		       unsigned long src_X,
+		       unsigned long src_Y,
+		       unsigned long nFgColor,
+		       unsigned long nBgColor, pTransparent pTransp)
+{
+	int nLeft_bits_off;
+	int nBytes_per_scan;
+	int nBytes4_per_scan;
+	int nBytes_remain;
+	int nLong;
+	unsigned long nTransparent = 0;
+	unsigned long de_ctrl = 0;
+	unsigned long de_data_port_write_addr;
+	unsigned long i;
+	int j;
+	unsigned long ulSrc;
+	unsigned char *pSrcBuffer;
+
+	pSrcBuffer =
+	    (unsigned char *)src_base + (src_Y * src_stride) + (src_X / 8);
+	nLeft_bits_off = (src_X & 0x07);
+	nBytes_per_scan = (dst_width + nLeft_bits_off + 7) / 8;
+	nBytes4_per_scan = (nBytes_per_scan + 3) & ~3;
+	nBytes_remain = nBytes_per_scan & 3;
+	nLong = nBytes_per_scan & ~3;
+
+	deWaitForNotBusy();
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
+	/* Program 2D Drawing Engine */
+
+	SMTC_write2Dreg(DE_WINDOW_DESTINATION_BASE,
+			FIELD_VALUE(0, DE_WINDOW_DESTINATION_BASE, ADDRESS,
+				    dst_base));
+
+	SMTC_write2Dreg(DE_WINDOW_SOURCE_BASE,
+			FIELD_VALUE(0, DE_WINDOW_SOURCE_BASE, ADDRESS, 0));
+
+	SMTC_write2Dreg(DE_PITCH,
+			FIELD_VALUE(0, DE_PITCH, DESTINATION, dst_pitch) |
+			FIELD_VALUE(0, DE_PITCH, SOURCE, dst_pitch));
+
+	SMTC_write2Dreg(DE_WINDOW_WIDTH,
+			FIELD_VALUE(0, DE_WINDOW_WIDTH, DESTINATION,
+				    dst_pitch) | FIELD_VALUE(0, DE_WINDOW_WIDTH,
+							     SOURCE,
+							     dst_pitch));
+
+	SMTC_write2Dreg(DE_SOURCE,
+			FIELD_SET(0, DE_SOURCE, WRAP, DISABLE) |
+			FIELD_VALUE(0, DE_SOURCE, X_K1, nLeft_bits_off) |
+			FIELD_VALUE(0, DE_SOURCE, Y_K2, src_Y));
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
+	SMTC_write2Dreg(DE_FOREGROUND,
+			FIELD_VALUE(0, DE_FOREGROUND, COLOR, nFgColor));
+
+	SMTC_write2Dreg(DE_BACKGROUND,
+			FIELD_VALUE(0, DE_BACKGROUND, COLOR, nBgColor));
+
+	de_ctrl = 0x0000000C |
+	    FIELD_SET(0, DE_CONTROL, ROP_SELECT, ROP2) |
+	    FIELD_SET(0, DE_CONTROL, COMMAND, HOST_WRITE) |
+	    FIELD_SET(0, DE_CONTROL, HOST, MONO) |
+	    nTransparent | FIELD_SET(0, DE_CONTROL, STATUS, START);
+	SMTC_write2Dreg(DE_CONTROL, de_ctrl);
+
+	/* Write bitmap/image data (line by line) to 2D Engine data port */
+	de_data_port_write_addr = 0;
+
+	for (i = 1; i < dst_height; i++) {
+		for (j = 0; j < (nBytes4_per_scan / 4); j++) {
+			memcpy(&ulSrc, (pSrcBuffer + (j * 4)), 4);
+			SMTC_write2Ddataport(de_data_port_write_addr, ulSrc);
+		}
+
+		pSrcBuffer += src_stride;
+	}
+
+	/* Special handling for last line of bitmap */
+	if (nLong) {
+		for (j = 0; j < (nLong / 4); j++) {
+			memcpy(&ulSrc, (pSrcBuffer + (j * 4)), 4);
+			SMTC_write2Ddataport(de_data_port_write_addr, ulSrc);
+		}
+	}
+
+	if (nBytes_remain) {
+		memcpy(&ulSrc, (pSrcBuffer + nLong), nBytes_remain);
+		SMTC_write2Ddataport(de_data_port_write_addr, ulSrc);
+	}
+
+	smtc_de_busy = 1;
+}
+
+/*
+ * This function sets the pixel format that will apply to the 2D
Engine.
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
+ * Source is monochrome image in system memory.
+ * This function expands the monochrome data to color image in video
memory.
+ */
+long deSystemMem2VideoMemMonoBlt(unsigned char *pSrcbuf,	/* pointer to
start of source buffer in system memory */
+				 long srcDelta,	/* Pitch value (in bytes) of the source buffer,
+ive means top down and -ive mean button up */
+				 unsigned long startBit,	/* Mono data can start at any bit in a
byte, this value should be 0 to 7 */
+				 unsigned long dBase,	/* Address of destination: offset in frame
buffer */
+				 unsigned long dPitch,	/* Pitch value of destination surface in
BYTE */
+				 unsigned long bpp,	/* Color depth of destination surface */
+				 unsigned long dx, unsigned long dy,	/* Starting coordinate of
destination surface */
+				 unsigned long width, unsigned long height,	/* width and height of
rectange in pixel value */
+				 unsigned long fColor,	/* Foreground color (corresponding to a 1 in
the monochrome data */
+				 unsigned long bColor,	/* Background color (corresponding to a 0 in
the monochrome data */
+				 unsigned long rop2) {	/* ROP value */
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
+	startBit &= 7;		/* Just make sure the start bit is within legal range
*/
+	ulBytesPerScan = (width + startBit + 7) / 8;
+	ul4BytesPerScan = ulBytesPerScan & ~3;
+	ulBytesRemain = ulBytesPerScan & 3;
+
+	if (smtc_de_busy)
+		deWaitForNotBusy();
+
+	/* 2D Source Base.
+	   Use 0 for HOST Blt.
+	 */
+	SMTC_write2Dreg(DE_WINDOW_SOURCE_BASE, 0);
+
+	/* 2D Destination Base.
+	   It is an address offset (128 bit aligned) from the beginning of
frame buffer.
+	 */
+	SMTC_write2Dreg(DE_WINDOW_DESTINATION_BASE, dBase);
+
+	if (dPitch) {
+		/* Program pitch (distance between the 1st points of two adjacent
lines).
+		   Note that input pitch is BYTE value, but the 2D Pitch register
uses
+		   pixel values. Need Byte to pixel convertion.
+		 */
+		SMTC_write2Dreg(DE_PITCH,
+				FIELD_VALUE(0, DE_PITCH, DESTINATION,
+					    dPitch /
+					    bytePerPixel) | FIELD_VALUE(0,
+									DE_PITCH,
+									SOURCE,
+									dPitch /
+									bytePerPixel));
+
+		/* Screen Window width in Pixels.
+		   2D engine uses this value to calculate the linear address in frame
buffer for a given point.
+		 */
+		SMTC_write2Dreg(DE_WINDOW_WIDTH,
+				FIELD_VALUE(0, DE_WINDOW_WIDTH, DESTINATION,
+					    (dPitch /
+					     bytePerPixel)) | FIELD_VALUE(0,
+									  DE_WINDOW_WIDTH,
+									  SOURCE,
+									  (dPitch
+									   /
+									   bytePerPixel)));
+	}
+	/* Note: For 2D Source in Host Write, only X_K1 field is needed, and
Y_K2 field is not used.
+	   For mono bitmap, use startBit for X_K1. */
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
+		for (j = 0; j < (ul4BytesPerScan / 4); j++) {
+			SMTC_write2Ddataport(0,
+					     *(unsigned long *)(pSrcbuf +
+								(j * 4)));
+		}
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
+unsigned long deGetTransparency()
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
+
+/**********************************************************************
+ *
+ * Misc. functions
+ *
+
**********************************************************************/
+/* Load 8x8 pattern into local video memory */
+void deLoadPattern(unsigned char *pattern, unsigned long write_addr)
+{
+	int i;
+	for (i = 0; i < (8 * 8 * 2); i += 4) {
+		/* memWrite32(write_addr, *(unsigned long*)(&pattern[i]));
removed by boyod */
+		write_addr += 4;
+	}
+}
diff --git a/drivers/video/smi/smtc2d.h b/drivers/video/smi/smtc2d.h
new file mode 100644
index 0000000..c8b3bf4
--- /dev/null
+++ b/drivers/video/smi/smtc2d.h
@@ -0,0 +1,541 @@
+/*
+ *  linux/drivers/video/smtc2d.h -- Silicon Motion SM501 and SM7xx 2D
drawing engine functions.
+ *
+ *	 Copyright (C) 2006 Silicon Motion Technology Corp.
+ *	 Ge Wang, gewang@siliconmotion.com
+ *
+ *  This file is subject to the terms and conditions of the GNU General
Public
+ *  License. See the file COPYING in the main directory of this archive
for
+ *  more details.
+ */
+
+#ifndef NULL
+#define NULL	 0
+#endif
+
+/* Internal macros */
+
+#define _F_START(f)		 (0 ? f)
+#define _F_END(f)		 (1 ? f)
+#define _F_SIZE(f)		 (1 + _F_END(f) - _F_START(f))
+#define _F_MASK(f)		 ((((unsigned long)1 << _F_SIZE(f)) - 1) <<
_F_START(f))
+#define _F_NORMALIZE(v, f)	 (((v) & _F_MASK(f)) >> _F_START(f))
+#define _F_DENORMALIZE(v, f)	 (((v) << _F_START(f)) & _F_MASK(f))
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
+    | _F_DENORMALIZE(reg ## _ ## field ## _ ## value, reg ## _ ##
field) \
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
+    ~ _F_MASK(reg ## _ ## field) \
+)
+
+/* Field Macros
*/
+
+#define FIELD_START(field)		 (0 ? field)
+#define FIELD_END(field)		 (1 ? field)
+#define FIELD_SIZE(field)		 (1 + FIELD_END(field) - FIELD_START(field))
+#define FIELD_MASK(field)		 (((1 << (FIELD_SIZE(field)-1)) | ((1 <<
(FIELD_SIZE(field)-1)) - 1)) << FIELD_START(field))
+#define FIELD_NORMALIZE(reg, field)	 (((reg) & FIELD_MASK(field)) >>
FIELD_START(field))
+#define FIELD_DENORMALIZE(field, value) (((value) <<
FIELD_START(field)) & FIELD_MASK(field))
+
+#define FIELD_INIT(reg, field, value)	 FIELD_DENORMALIZE(reg ## _ ##
field, \
+							   reg ## _ ## field ## _ ## value)
+#define FIELD_INIT_VAL(reg, field, value) \
+					 (FIELD_DENORMALIZE(reg ## _ ## field, value))
+#define FIELD_VAL_SET(x, r, f, v)	 x = x & ~FIELD_MASK(r ## _ ## f) \
+					       | FIELD_DENORMALIZE(r ## _ ## f, r ## _ ## f ## _ ## v)
+
+#define RGB(r, g, b) ((unsigned long)(((r) << 16) | ((g) << 8) | (b)))
+
+/* Transparent info definition */
+typedef struct {
+	unsigned long match;	/* Matching pixel is OPAQUE/TRANSPARENT */
+	unsigned long select;	/* Transparency controlled by SOURCE/DESTINATION
*/
+	unsigned long control;	/* ENABLE/DISABLE transparency */
+	unsigned long color;	/* Transparent color */
+} Transparent, *pTransparent;
+
+#define PIXEL_DEPTH_1_BP		0	/* 1 bit per pixel */
+#define PIXEL_DEPTH_8_BPP		1	/* 8 bits per pixel */
+#define PIXEL_DEPTH_16_BPP		2	/* 16 bits per pixel */
+#define PIXEL_DEPTH_32_BPP		3	/* 32 bits per pixel */
+#define PIXEL_DEPTH_YUV422		8	/* 16 bits per pixel YUV422 */
+#define PIXEL_DEPTH_YUV420		9	/* 16 bits per pixel YUV420 */
+
+#define PATTERN_WIDTH		 8
+#define PATTERN_HEIGHT 	 8
+
+#define	TOP_TO_BOTTOM			0
+#define	BOTTOM_TO_TOP			1
+#define RIGHT_TO_LEFT			BOTTOM_TO_TOP
+#define LEFT_TO_RIGHT			TOP_TO_BOTTOM
+
+/* Constants used in Transparent structure */
+#define MATCH_OPAQUE		 0x00000000
+#define MATCH_TRANSPARENT	 0x00000400
+#define SOURCE 		 0x00000000
+#define DESTINATION		 0x00000200
+
+/* 2D registers. */
+
+#define DE_SOURCE					 0x000000
+#define DE_SOURCE_WRAP 				 31:31
+#define DE_SOURCE_WRAP_DISABLE 			 0
+#define DE_SOURCE_WRAP_ENABLE				 1
+#define DE_SOURCE_X_K1 				 29:16
+#define DE_SOURCE_Y_K2 				 15:0
+
+#define DE_DESTINATION 				 0x000004
+#define DE_DESTINATION_WRAP				 31:31
+#define DE_DESTINATION_WRAP_DISABLE			 0
+#define DE_DESTINATION_WRAP_ENABLE			 1
+#define DE_DESTINATION_X				 28:16
+#define DE_DESTINATION_Y				 15:0
+
+#define DE_DIMENSION					 0x000008
+#define DE_DIMENSION_X 				 28:16
+#define DE_DIMENSION_Y_ET				 15:0
+
+#define DE_CONTROL					 0x00000C
+#define DE_CONTROL_STATUS				 31:31
+#define DE_CONTROL_STATUS_STOP 			 0
+#define DE_CONTROL_STATUS_START			 1
+#define DE_CONTROL_PATTERN				 30:30
+#define DE_CONTROL_PATTERN_MONO			 0
+#define DE_CONTROL_PATTERN_COLOR			 1
+#define DE_CONTROL_UPDATE_DESTINATION_X		 29:29
+#define DE_CONTROL_UPDATE_DESTINATION_X_DISABLE	 0
+#define DE_CONTROL_UPDATE_DESTINATION_X_ENABLE 	 1
+#define DE_CONTROL_QUICK_START 			 28:28
+#define DE_CONTROL_QUICK_START_DISABLE 		 0
+#define DE_CONTROL_QUICK_START_ENABLE			 1
+#define DE_CONTROL_DIRECTION				 27:27
+#define DE_CONTROL_DIRECTION_LEFT_TO_RIGHT		 0
+#define DE_CONTROL_DIRECTION_RIGHT_TO_LEFT		 1
+#define DE_CONTROL_MAJOR				 26:26
+#define DE_CONTROL_MAJOR_X				 0
+#define DE_CONTROL_MAJOR_Y				 1
+#define DE_CONTROL_STEP_X				 25:25
+#define DE_CONTROL_STEP_X_POSITIVE			 1
+#define DE_CONTROL_STEP_X_NEGATIVE			 0
+#define DE_CONTROL_STEP_Y				 24:24
+#define DE_CONTROL_STEP_Y_POSITIVE			 1
+#define DE_CONTROL_STEP_Y_NEGATIVE			 0
+#define DE_CONTROL_STRETCH				 23:23
+#define DE_CONTROL_STRETCH_DISABLE			 0
+#define DE_CONTROL_STRETCH_ENABLE			 1
+#define DE_CONTROL_HOST				 22:22
+#define DE_CONTROL_HOST_COLOR				 0
+#define DE_CONTROL_HOST_MONO				 1
+#define DE_CONTROL_LAST_PIXEL				 21:21
+#define DE_CONTROL_LAST_PIXEL_OFF			 0
+#define DE_CONTROL_LAST_PIXEL_ON			 1
+#define DE_CONTROL_COMMAND				 20:16
+#define DE_CONTROL_COMMAND_BITBLT			 0
+#define DE_CONTROL_COMMAND_RECTANGLE_FILL		 1
+#define DE_CONTROL_COMMAND_DE_TILE			 2
+#define DE_CONTROL_COMMAND_TRAPEZOID_FILL		 3
+#define DE_CONTROL_COMMAND_ALPHA_BLEND 		 4
+#define DE_CONTROL_COMMAND_RLE_STRIP			 5
+#define DE_CONTROL_COMMAND_SHORT_STROKE		 6
+#define DE_CONTROL_COMMAND_LINE_DRAW			 7
+#define DE_CONTROL_COMMAND_HOST_WRITE			 8
+#define DE_CONTROL_COMMAND_HOST_READ			 9
+#define DE_CONTROL_COMMAND_HOST_WRITE_BOTTOM_UP	 10
+#define DE_CONTROL_COMMAND_ROTATE			 11
+#define DE_CONTROL_COMMAND_FONT			 12
+#define DE_CONTROL_COMMAND_TEXTURE_LOAD		 15
+#define DE_CONTROL_ROP_SELECT				 15:15
+#define DE_CONTROL_ROP_SELECT_ROP3			 0
+#define DE_CONTROL_ROP_SELECT_ROP2			 1
+#define DE_CONTROL_ROP2_SOURCE 			 14:14
+#define DE_CONTROL_ROP2_SOURCE_BITMAP			 0
+#define DE_CONTROL_ROP2_SOURCE_PATTERN 		 1
+#define DE_CONTROL_MONO_DATA				 13:12
+#define DE_CONTROL_MONO_DATA_NOT_PACKED		 0
+#define DE_CONTROL_MONO_DATA_8_PACKED			 1
+#define DE_CONTROL_MONO_DATA_16_PACKED 		 2
+#define DE_CONTROL_MONO_DATA_32_PACKED 		 3
+#define DE_CONTROL_REPEAT_ROTATE			 11:11
+#define DE_CONTROL_REPEAT_ROTATE_DISABLE		 0
+#define DE_CONTROL_REPEAT_ROTATE_ENABLE		 1
+#define DE_CONTROL_TRANSPARENCY_MATCH			 10:10
+#define DE_CONTROL_TRANSPARENCY_MATCH_OPAQUE		 0
+#define DE_CONTROL_TRANSPARENCY_MATCH_TRANSPARENT	 1
+#define DE_CONTROL_TRANSPARENCY_SELECT 		 9:9
+#define DE_CONTROL_TRANSPARENCY_SELECT_SOURCE		 0
+#define DE_CONTROL_TRANSPARENCY_SELECT_DESTINATION	 1
+#define DE_CONTROL_TRANSPARENCY			 8:8
+#define DE_CONTROL_TRANSPARENCY_DISABLE		 0
+#define DE_CONTROL_TRANSPARENCY_ENABLE 		 1
+#define DE_CONTROL_ROP 				 7:0
+
+/* Pseudo fields. */
+
+#define DE_CONTROL_SHORT_STROKE_DIR			 27:24
+#define DE_CONTROL_SHORT_STROKE_DIR_225		 0
+#define DE_CONTROL_SHORT_STROKE_DIR_135		 1
+#define DE_CONTROL_SHORT_STROKE_DIR_315		 2
+#define DE_CONTROL_SHORT_STROKE_DIR_45 		 3
+#define DE_CONTROL_SHORT_STROKE_DIR_270		 4
+#define DE_CONTROL_SHORT_STROKE_DIR_90 		 5
+#define DE_CONTROL_SHORT_STROKE_DIR_180		 8
+#define DE_CONTROL_SHORT_STROKE_DIR_0			 10
+#define DE_CONTROL_ROTATION				 25:24
+#define DE_CONTROL_ROTATION_0				 0
+#define DE_CONTROL_ROTATION_270			 1
+#define DE_CONTROL_ROTATION_90 			 2
+#define DE_CONTROL_ROTATION_180			 3
+
+#define DE_PITCH					 0x000010
+#define DE_PITCH_DESTINATION				 28:16
+#define DE_PITCH_SOURCE				 12:0
+
+#define DE_FOREGROUND					 0x000014
+#define DE_FOREGROUND_COLOR				 31:0
+
+#define DE_BACKGROUND					 0x000018
+#define DE_BACKGROUND_COLOR				 31:0
+
+#define DE_STRETCH_FORMAT				 0x00001C
+#define DE_STRETCH_FORMAT_PATTERN_XY			 30:30
+#define DE_STRETCH_FORMAT_PATTERN_XY_NORMAL		 0
+#define DE_STRETCH_FORMAT_PATTERN_XY_OVERWRITE 	 1
+#define DE_STRETCH_FORMAT_PATTERN_Y			 29:27
+#define DE_STRETCH_FORMAT_PATTERN_X			 25:23
+#define DE_STRETCH_FORMAT_PIXEL_FORMAT 		 21:20
+#define DE_STRETCH_FORMAT_PIXEL_FORMAT_8		 0
+#define DE_STRETCH_FORMAT_PIXEL_FORMAT_16		 1
+#define DE_STRETCH_FORMAT_PIXEL_FORMAT_24		 3
+#define DE_STRETCH_FORMAT_PIXEL_FORMAT_32		 2
+#define DE_STRETCH_FORMAT_ADDRESSING			 19:16
+#define DE_STRETCH_FORMAT_ADDRESSING_XY		 0
+#define DE_STRETCH_FORMAT_ADDRESSING_LINEAR		 15
+#define DE_STRETCH_FORMAT_SOURCE_HEIGHT		 11:0
+
+#define DE_COLOR_COMPARE				 0x000020
+#define DE_COLOR_COMPARE_COLOR 			 23:0
+
+#define DE_COLOR_COMPARE_MASK				 0x000024
+#define DE_COLOR_COMPARE_MASK_MASKS			 23:0
+
+#define DE_MASKS					 0x000028
+#define DE_MASKS_BYTE_MASK				 31:16
+#define DE_MASKS_BIT_MASK				 15:0
+
+#define DE_CLIP_TL					 0x00002C
+#define DE_CLIP_TL_TOP 				 31:16
+#define DE_CLIP_TL_STATUS				 13:13
+#define DE_CLIP_TL_STATUS_DISABLE			 0
+#define DE_CLIP_TL_STATUS_ENABLE			 1
+#define DE_CLIP_TL_INHIBIT				 12:12
+#define DE_CLIP_TL_INHIBIT_OUTSIDE			 0
+#define DE_CLIP_TL_INHIBIT_INSIDE			 1
+#define DE_CLIP_TL_LEFT				 11:0
+
+#define DE_CLIP_BR					 0x000030
+#define DE_CLIP_BR_BOTTOM				 31:16
+#define DE_CLIP_BR_RIGHT				 12:0
+
+#define DE_MONO_PATTERN_LOW				 0x000034
+#define DE_MONO_PATTERN_LOW_PATTERN			 31:0
+
+#define DE_MONO_PATTERN_HIGH				 0x000038
+#define DE_MONO_PATTERN_HIGH_PATTERN			 31:0
+
+#define DE_WINDOW_WIDTH				 0x00003C
+#define DE_WINDOW_WIDTH_DESTINATION			 28:16
+#define DE_WINDOW_WIDTH_SOURCE 			 12:0
+
+#define DE_WINDOW_SOURCE_BASE				 0x000040
+#define DE_WINDOW_SOURCE_BASE_EXT			 27:27
+#define DE_WINDOW_SOURCE_BASE_EXT_LOCAL		 0
+#define DE_WINDOW_SOURCE_BASE_EXT_EXTERNAL		 1
+#define DE_WINDOW_SOURCE_BASE_CS			 26:26
+#define DE_WINDOW_SOURCE_BASE_CS_0			 0
+#define DE_WINDOW_SOURCE_BASE_CS_1			 1
+#define DE_WINDOW_SOURCE_BASE_ADDRESS			 25:0
+
+#define DE_WINDOW_DESTINATION_BASE			 0x000044
+#define DE_WINDOW_DESTINATION_BASE_EXT 		 27:27
+#define DE_WINDOW_DESTINATION_BASE_EXT_LOCAL		 0
+#define DE_WINDOW_DESTINATION_BASE_EXT_EXTERNAL	 1
+#define DE_WINDOW_DESTINATION_BASE_CS			 26:26
+#define DE_WINDOW_DESTINATION_BASE_CS_0		 0
+#define DE_WINDOW_DESTINATION_BASE_CS_1		 1
+#define DE_WINDOW_DESTINATION_BASE_ADDRESS		 25:0
+
+#define DE_ALPHA					 0x000048
+#define DE_ALPHA_VALUE 				 7:0
+
+#define DE_WRAP					 0x00004C
+#define DE_WRAP_X					 31:16
+#define DE_WRAP_Y					 15:0
+
+#define DE_STATUS					 0x000050
+#define DE_STATUS_CSC					 1:1
+#define DE_STATUS_CSC_CLEAR				 0
+#define DE_STATUS_CSC_NOT_ACTIVE			 0
+#define DE_STATUS_CSC_ACTIVE				 1
+#define DE_STATUS_2D					 0:0
+#define DE_STATUS_2D_CLEAR				 0
+#define DE_STATUS_2D_NOT_ACTIVE			 0
+#define DE_STATUS_2D_ACTIVE				 1
+
+/* Color Space Conversion registers. */
+
+#define CSC_Y_SOURCE_BASE				 0x0000C8
+#define CSC_Y_SOURCE_BASE_EXT				 27:27
+#define CSC_Y_SOURCE_BASE_EXT_LOCAL			 0
+#define CSC_Y_SOURCE_BASE_EXT_EXTERNAL 		 1
+#define CSC_Y_SOURCE_BASE_CS				 26:26
+#define CSC_Y_SOURCE_BASE_CS_0 			 0
+#define CSC_Y_SOURCE_BASE_CS_1 			 1
+#define CSC_Y_SOURCE_BASE_ADDRESS			 25:0
+
+#define CSC_CONSTANTS					 0x0000CC
+#define CSC_CONSTANTS_Y				 31:24
+#define CSC_CONSTANTS_R				 23:16
+#define CSC_CONSTANTS_G				 15:8
+#define CSC_CONSTANTS_B				 7:0
+
+#define CSC_Y_SOURCE_X 				 0x0000D0
+#define CSC_Y_SOURCE_X_INTEGER 			 26:16
+#define CSC_Y_SOURCE_X_FRACTION			 15:3
+
+#define CSC_Y_SOURCE_Y 				 0x0000D4
+#define CSC_Y_SOURCE_Y_INTEGER 			 27:16
+#define CSC_Y_SOURCE_Y_FRACTION			 15:3
+
+#define CSC_U_SOURCE_BASE				 0x0000D8
+#define CSC_U_SOURCE_BASE_EXT				 27:27
+#define CSC_U_SOURCE_BASE_EXT_LOCAL			 0
+#define CSC_U_SOURCE_BASE_EXT_EXTERNAL 		 1
+#define CSC_U_SOURCE_BASE_CS				 26:26
+#define CSC_U_SOURCE_BASE_CS_0 			 0
+#define CSC_U_SOURCE_BASE_CS_1 			 1
+#define CSC_U_SOURCE_BASE_ADDRESS			 25:0
+
+#define CSC_V_SOURCE_BASE				 0x0000DC
+#define CSC_V_SOURCE_BASE_EXT				 27:27
+#define CSC_V_SOURCE_BASE_EXT_LOCAL			 0
+#define CSC_V_SOURCE_BASE_EXT_EXTERNAL 		 1
+#define CSC_V_SOURCE_BASE_CS				 26:26
+#define CSC_V_SOURCE_BASE_CS_0 			 0
+#define CSC_V_SOURCE_BASE_CS_1 			 1
+#define CSC_V_SOURCE_BASE_ADDRESS			 25:0
+
+#define CSC_SOURCE_DIMENSION				 0x0000E0
+#define CSC_SOURCE_DIMENSION_X 			 31:16
+#define CSC_SOURCE_DIMENSION_Y 			 15:0
+
+#define CSC_SOURCE_PITCH				 0x0000E4
+#define CSC_SOURCE_PITCH_Y				 31:16
+#define CSC_SOURCE_PITCH_UV				 15:0
+
+#define CSC_DESTINATION				 0x0000E8
+#define CSC_DESTINATION_WRAP				 31:31
+#define CSC_DESTINATION_WRAP_DISABLE			 0
+#define CSC_DESTINATION_WRAP_ENABLE			 1
+#define CSC_DESTINATION_X				 27:16
+#define CSC_DESTINATION_Y				 11:0
+
+#define CSC_DESTINATION_DIMENSION			 0x0000EC
+#define CSC_DESTINATION_DIMENSION_X			 31:16
+#define CSC_DESTINATION_DIMENSION_Y			 15:0
+
+#define CSC_DESTINATION_PITCH				 0x0000F0
+#define CSC_DESTINATION_PITCH_X			 31:16
+#define CSC_DESTINATION_PITCH_Y			 15:0
+
+#define CSC_SCALE_FACTOR				 0x0000F4
+#define CSC_SCALE_FACTOR_HORIZONTAL			 31:16
+#define CSC_SCALE_FACTOR_VERTICAL			 15:0
+
+#define CSC_DESTINATION_BASE				 0x0000F8
+#define CSC_DESTINATION_BASE_EXT			 27:27
+#define CSC_DESTINATION_BASE_EXT_LOCAL 		 0
+#define CSC_DESTINATION_BASE_EXT_EXTERNAL		 1
+#define CSC_DESTINATION_BASE_CS			 26:26
+#define CSC_DESTINATION_BASE_CS_0			 0
+#define CSC_DESTINATION_BASE_CS_1			 1
+#define CSC_DESTINATION_BASE_ADDRESS			 25:0
+
+#define CSC_CONTROL					 0x0000FC
+#define CSC_CONTROL_STATUS				 31:31
+#define CSC_CONTROL_STATUS_STOP			 0
+#define CSC_CONTROL_STATUS_START			 1
+#define CSC_CONTROL_SOURCE_FORMAT			 30:28
+#define CSC_CONTROL_SOURCE_FORMAT_YUV422		 0
+#define CSC_CONTROL_SOURCE_FORMAT_YUV420I		 1
+#define CSC_CONTROL_SOURCE_FORMAT_YUV420		 2
+#define CSC_CONTROL_SOURCE_FORMAT_YVU9 		 3
+#define CSC_CONTROL_SOURCE_FORMAT_IYU1 		 4
+#define CSC_CONTROL_SOURCE_FORMAT_IYU2 		 5
+#define CSC_CONTROL_SOURCE_FORMAT_RGB565		 6
+#define CSC_CONTROL_SOURCE_FORMAT_RGB8888		 7
+#define CSC_CONTROL_DESTINATION_FORMAT 		 27:26
+#define CSC_CONTROL_DESTINATION_FORMAT_RGB565		 0
+#define CSC_CONTROL_DESTINATION_FORMAT_RGB8888 	 1
+#define CSC_CONTROL_HORIZONTAL_FILTER			 25:25
+#define CSC_CONTROL_HORIZONTAL_FILTER_DISABLE		 0
+#define CSC_CONTROL_HORIZONTAL_FILTER_ENABLE		 1
+#define CSC_CONTROL_VERTICAL_FILTER			 24:24
+#define CSC_CONTROL_VERTICAL_FILTER_DISABLE		 0
+#define CSC_CONTROL_VERTICAL_FILTER_ENABLE		 1
+#define CSC_CONTROL_BYTE_ORDER 			 23:23
+#define CSC_CONTROL_BYTE_ORDER_YUYV			 0
+#define CSC_CONTROL_BYTE_ORDER_UYVY			 1
+
+#define DE_DATA_PORT_501				 0x110000
+#define DE_DATA_PORT_712				 0x400000
+#define DE_DATA_PORT_722				 0x6000
+
+extern char *smtc_RegBaseAddress;	/* point to virtual Memory Map IO
starting address */
+extern char *smtc_VRAMBaseAddress;	/* point to virtual video memory
starting address */
+extern unsigned char smtc_de_busy;
+
+extern unsigned long memRead32(unsigned long nOffset);
+extern void memWrite32(unsigned long nOffset, unsigned long nData);
+unsigned long SMTC_read2Dreg(unsigned long nOffset);
+
+/* 2D functions */
+extern void deInit(unsigned int nModeWidth, unsigned int nModeHeight,
+		   unsigned int bpp);
+
+extern void deWaitForNotBusy(void);
+
+extern void deSetClipRectangle(int left, int top, int right, int
bottom);
+
+extern void deVerticalLine(unsigned long dst_base,
+			   unsigned long dst_pitch,
+			   unsigned long nX,
+			   unsigned long nY,
+			   unsigned long dst_height, unsigned long nColor);
+
+extern void deHorizontalLine(unsigned long dst_base,
+			     unsigned long dst_pitch,
+			     unsigned long nX,
+			     unsigned long nY,
+			     unsigned long dst_width, unsigned long nColor);
+
+extern void deLine(unsigned long dst_base,
+		   unsigned long dst_pitch,
+		   unsigned long nX1,
+		   unsigned long nY1,
+		   unsigned long nX2, unsigned long nY2, unsigned long nColor);
+
+extern void deFillRect(unsigned long dst_base,
+		       unsigned long dst_pitch,
+		       unsigned long dst_X,
+		       unsigned long dst_Y,
+		       unsigned long dst_width,
+		       unsigned long dst_height, unsigned long nColor);
+
+extern void deRotatePattern(unsigned char *pattern_dstaddr,
+			    unsigned long pattern_src_addr,
+			    unsigned long pattern_BPP,
+			    unsigned long pattern_stride,
+			    int patternX, int patternY);
+
+extern void deMonoPatternFill(unsigned long dst_base,
+			      unsigned long dst_pitch,
+			      unsigned long dst_BPP,
+			      unsigned long dstX,
+			      unsigned long dstY,
+			      unsigned long dst_width,
+			      unsigned long dst_height,
+			      unsigned long pattern_FGcolor,
+			      unsigned long pattern_BGcolor,
+			      unsigned long pattern_low,
+			      unsigned long pattern_high);
+
+extern void deColorPatternFill(unsigned long dst_base,
+			       unsigned long dst_pitch,
+			       unsigned long dst_BPP,
+			       unsigned long dst_X,
+			       unsigned long dst_Y,
+			       unsigned long dst_width,
+			       unsigned long dst_height,
+			       unsigned long pattern_src_addr,
+			       unsigned long pattern_stride,
+			       int PatternOriginX, int PatternOriginY);
+
+extern void deCopy(unsigned long dst_base,
+		   unsigned long dst_pitch,
+		   unsigned long dst_BPP,
+		   unsigned long dst_X,
+		   unsigned long dst_Y,
+		   unsigned long dst_width,
+		   unsigned long dst_height,
+		   unsigned long src_base,
+		   unsigned long src_pitch,
+		   unsigned long src_X,
+		   unsigned long src_Y,
+		   pTransparent pTransp, unsigned char nROP2);
+
+extern void deSrcCopyHost(unsigned long dst_base,
+			  unsigned long dst_pitch,
+			  unsigned long dst_BPP,
+			  unsigned long dst_X,
+			  unsigned long dst_Y,
+			  unsigned long dst_width,
+			  unsigned long dst_height,
+			  unsigned long src_base,
+			  unsigned long src_stride,
+			  unsigned long src_X,
+			  unsigned long src_Y,
+			  pTransparent pTransp, unsigned char nROP2);
+
+extern void deMonoSrcCopyHost(unsigned long dst_base,
+			      unsigned long dst_pitch,
+			      unsigned long dst_BPP,
+			      unsigned long dst_X,
+			      unsigned long dst_Y,
+			      unsigned long dst_width,
+			      unsigned long dst_height,
+			      unsigned long src_base,
+			      unsigned long src_stride,
+			      unsigned long src_X,
+			      unsigned long src_Y,
+			      unsigned long nFgColor,
+			      unsigned long nBgColor, pTransparent pTransp);
+
+/*
+ * System memory to Video memory monochrome expansion.
+ * Source is monochrome image in system memory.
+ * This function expands the monochrome data to color image in video
memory.
+ */
+long deSystemMem2VideoMemMonoBlt(unsigned char *pSrcbuf,	/* pointer to
start of source buffer in system memory */
+				 long srcDelta,	/* Pitch value (in bytes) of the source buffer,
+ive means top down and -ive mean button up */
+				 unsigned long startBit,	/* Mono data can start at any bit in a
byte, this value should be 0 to 7 */
+				 unsigned long dBase,	/* Address of destination: offset in frame
buffer */
+				 unsigned long dPitch,	/* Pitch value of destination surface in
BYTE */
+				 unsigned long bpp,	/* Color depth of destination surface */
+				 unsigned long dx, unsigned long dy,	/* Starting coordinate of
destination surface */
+				 unsigned long width, unsigned long height,	/* width and height of
rectange in pixel value */
+				 unsigned long fColor,	/* Foreground color (corresponding to a 1 in
the monochrome data */
+				 unsigned long bColor,	/* Background color (corresponding to a 0 in
the monochrome data */
+				 unsigned long rop2);	/* ROP value */
+
+unsigned long deGetTransparency(void);
+void deSetPixelFormat(unsigned long bpp);
+
+extern void deLoadPattern(unsigned char *pattern, unsigned long
write_addr);
diff --git a/drivers/video/smi/smtcfb.c b/drivers/video/smi/smtcfb.c
new file mode 100644
index 0000000..33fe74b
--- /dev/null
+++ b/drivers/video/smi/smtcfb.c
@@ -0,0 +1,1145 @@
+/*
+ *  linux/drivers/video/smtcfb.c -- Silicon Motion SM501 and SM7xx
frame buffer device
+ *
+ *	 Copyright (C) 2006 Silicon Motion Technology Corp.
+ *	 Ge Wang, gewang@siliconmotion.com
+ *	 Boyod boyod.yang@siliconmotion.com.cn
+ *
+ *  This file is subject to the terms and conditions of the GNU General
Public
+ *  License. See the file COPYING in the main directory of this archive
for
+ *  more details.
+*
+*
+* Version 0.10.26192.21.01
+    - Add PowerPC/Big endian support
+	- Add 2D support for Lynx
+    - Verified on 2.6.19.2			     Boyod.yang
<boyod.yang@siliconmotion.com.cn>
+
+* Version 0.09.2621.00.01
+    - Only support Linux Kernel's version 2.6.21.	Boyod.yang
<boyod.yang@siliconmotion.com.cn>
+
+* Version 0.09
+    - Only support Linux Kernel's version 2.6.12.	Boyod.yang
<boyod.yang@siliconmotion.com.cn>
+
+*/
+
+#ifndef __KERNEL__
+#define __KERNEL__
+#endif
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/mm.h>
+#include <linux/tty.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/fb.h>
+#include <linux/init.h>
+#include <linux/vmalloc.h>
+#include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
+#include <linux/workqueue.h>
+#include <linux/wait.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/console.h>
+
+#include <asm/io.h>
+#include <asm/uaccess.h>
+#include <asm/div64.h>
+
+#ifdef CONFIG_PM
+#include <linux/pm.h>
+#endif
+
+#include <linux/screen_info.h>
+#include <linux/pci.h>
+#include <linux/init.h>
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
+#define DEFAULT_VIDEO_MODE "800x600-16@60"
+#ifdef __BIG_ENDIAN
+struct screen_info screen_info;
+#endif
+
+/*
+ * globals
+ */
+
+#if 0
+static char *mode_option __devinitdata = DEFAULT_VIDEO_MODE;
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
+	char mode_index[6];
+	u16 lfb_width;
+	u16 lfb_height;
+	u16 lfb_depth;
+};
+
+#if 0
+static struct vesa_mode_table vesa_mode[] = {
+	{"0x301", 640, 480, 8},
+	{"0x303", 800, 600, 8},
+	{"0x305", 1024, 768, 8},
+	{"0x307", 1280, 1024, 8},
+
+	{"0x311", 640, 480, 16},
+	{"0x314", 800, 600, 16},
+	{"0x317", 1024, 768, 16},
+	{"0x31A", 1280, 1024, 16},
+
+	{"0x312", 640, 480, 24},
+	{"0x315", 800, 600, 24},
+	{"0x318", 1024, 768, 24},
+	{"0x31B", 1280, 1024, 24},
+
+};
+#endif
+char __iomem *smtc_RegBaseAddress;	/* Memory Map IO starting address */
+char __iomem *smtc_VRAMBaseAddress;	/* video memory starting address */
+
+char *smtc_2DBaseAddress;	/* 2D engine starting address */
+char *smtc_2Ddataport;		/* 2D data port offset */
+short smtc_2Dacceleration = 0;	/* default no 2D acceleration */
+
+static u32 colreg[17];
+static struct par_info hw;	/* hardware information */
+
+#if defined(CONFIG_FB_SM7XX_DUALHEAD)
+
+static u32 colreg2[17];
+static struct par_info hw2;	/* hardware information for second display
(CRT) */
+struct smtcfb_info smtcfb_info2;	/* fb_info for second display (CRT) */
+
+#endif				/* CONFIG_FB_SM501_DUALHEAD */
+
+u16 smtc_ChipIDs[] = {
+	0x710,
+	0x712,
+	0x720
+};
+
+int sm712be_flag;
+
+int numSMTCchipIDs = sizeof(smtc_ChipIDs) / sizeof(u16);
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
+	smdbg
+	    ("\nppar_info->width = %d ppar_info->height = %d
sfb->fb.var.bits_per_pixel = %d ppar_info->hz = %d\n",
+	     ppar_info->width, ppar_info->height, sfb->fb.var.bits_per_pixel,
+	     ppar_info->hz);
+
+	for (j = 0; j < numVGAModes; j++) {
+		if (VGAMode[j].mmSizeX == ppar_info->width &&
+		    VGAMode[j].mmSizeY == ppar_info->height &&
+		    VGAMode[j].bpp == sfb->fb.var.bits_per_pixel &&
+		    VGAMode[j].hz == ppar_info->hz) {
+			smdbg
+			    ("\nVGAMode[j].mmSizeX  = %d VGAMode[j].mmSizeY = %d
VGAMode[j].bpp = %d VGAMode[j].hz=%d\n",
+			     VGAMode[j].mmSizeX, VGAMode[j].mmSizeY,
+			     VGAMode[j].bpp, VGAMode[j].hz);
+			smdbg("VGAMode index=%d\n", j);
+
+			smtc_mmiowb(0x0, 0x3c6);
+
+			smtc_seqw(0, 0x1);
+
+			smtc_mmiowb(VGAMode[j].Init_MISC, 0x3c2);
+
+			for (i = 0; i < SIZE_SR00_SR04; i++) {	/* init SEQ register SR00 -
SR04 */
+				smtc_seqw(i, VGAMode[j].Init_SR00_SR04[i]);
+			}
+
+			for (i = 0; i < SIZE_SR10_SR24; i++) {	/* init SEQ register SR10 -
SR24 */
+				smtc_seqw(i + 0x10,
+					  VGAMode[j].Init_SR10_SR24[i]);
+			}
+
+			for (i = 0; i < SIZE_SR30_SR75; i++) {	/* init SEQ register SR30 -
SR75 */
+				if (((i + 0x30) != 0x62) && ((i + 0x30) != 0x6a)
+				    && ((i + 0x30) != 0x6b))
+					smtc_seqw(i + 0x30,
+						  VGAMode[j].Init_SR30_SR75[i]);
+			}
+			for (i = 0; i < SIZE_SR80_SR93; i++) {	/* init SEQ register SR80 -
SR93 */
+				smtc_seqw(i + 0x80,
+					  VGAMode[j].Init_SR80_SR93[i]);
+			}
+			for (i = 0; i < SIZE_SRA0_SRAF; i++) {	/* init SEQ register SRA0 -
SRAF */
+				smtc_seqw(i + 0xa0,
+					  VGAMode[j].Init_SRA0_SRAF[i]);
+			}
+
+			for (i = 0; i < SIZE_GR00_GR08; i++) {	/* init Graphic register GR00
- GR08 */
+				smtc_grphw(i, VGAMode[j].Init_GR00_GR08[i]);
+			}
+
+			for (i = 0; i < SIZE_AR00_AR14; i++) {	/* init Attribute register
AR00 - AR14 */
+
+				smtc_attrw(i, VGAMode[j].Init_AR00_AR14[i]);
+			}
+
+			for (i = 0; i < SIZE_CR00_CR18; i++) {	/* init CRTC register CR00 -
CR18 */
+				smtc_crtcw(i, VGAMode[j].Init_CR00_CR18[i]);
+			}
+
+			for (i = 0; i < SIZE_CR30_CR4D; i++) {	/* init CRTC register CR30 -
CR4D */
+				smtc_crtcw(i + 0x30,
+					   VGAMode[j].Init_CR30_CR4D[i]);
+			}
+
+			for (i = 0; i < SIZE_CR90_CRA7; i++) {	/* init CRTC register CR90 -
CRA7 */
+				smtc_crtcw(i + 0x90,
+					   VGAMode[j].Init_CR90_CRA7[i]);
+			}
+
+		}
+	}
+	smtc_mmiowb(0x67, 0x3c2);
+
+	/* set VPR registers */
+	writel(0x0, ppar_info->m_pVPR + 0x0C);
+	writel(0x0, ppar_info->m_pVPR + 0x40);
+
+	/* set data width */
+	m_nScreenStride = (ppar_info->width * sfb->fb.var.bits_per_pixel) /
64;
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
+		smtc_seqw(0x66, (smtc_seqr(0x66) & 0xC3) | 0x20);	/* second display
palette for dual head. Enable CRT RAM, 6-bit RAM */
+	else
+		smtc_seqw(0x66, (smtc_seqr(0x66) & 0xC3) | 0x10);	/* primary display
palette. Enable LCD RAM only, 6-bit RAM */
+	smtc_mmiowb(regno, dac_reg);
+	smtc_mmiowb(red >> 10, dac_val);
+	smtc_mmiowb(green >> 10, dac_val);
+	smtc_mmiowb(blue >> 10, dac_val);
+}
+
+static void smtc_set_timing(struct smtcfb_info *sfb, struct par_info
*ppar_info)
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
+		/* 16/32 bit true-colour, use pseuo-palette for 16 base color */
+		if (regno < 16) {
+			if (sfb->fb.var.bits_per_pixel == 16) {
+				u32 *pal = sfb->fb.pseudo_palette;
+				val = chan_to_field(red, &sfb->fb.var.red);
+				val |= chan_to_field(green, &sfb->fb.var.green);
+				val |= chan_to_field(blue, &sfb->fb.var.blue);
+#ifdef __BIG_ENDIAN
+				pal[regno] =
+				    ((red & 0xf800) >> 8) | ((green & 0xe000) >>
+							     13) | ((green &
+								     0x1c00) <<
+								    3) | ((blue
+									   &
+									   0xf800)
+									  >> 3);
+#else
+				pal[regno] = val;
+#endif
+			} else {
+				u32 *pal = sfb->fb.pseudo_palette;
+				val = chan_to_field(red, &sfb->fb.var.red);
+				val |= chan_to_field(green, &sfb->fb.var.green);
+				val |= chan_to_field(blue, &sfb->fb.var.blue);
+#ifdef __BIG_ENDIAN
+				val =
+				    (val & 0xff00ff00 >> 8) | (val & 0x00ff00ff
+							       << 8);
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
+#if 0
+static ssize_t
+smtcfb_read(struct file *file, char __user * buf, size_t count, loff_t
* ppos)
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
+			    (*dst & 0xff00ff00 >> 8) | (*dst & 0x00ff00ff << 8);
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
+smtcfb_write(struct file *file, const char __user * buf, size_t count,
+	     loff_t * ppos)
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
+#endif
+
+#include "smtc2d.c"
+
+void smtcfb_copyarea(struct fb_info *info, const struct fb_copyarea
*area)
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
+
+		cfb_copyarea(info, area);
+}
+
+void smtcfb_fillrect(struct fb_info *info, const struct fb_fillrect
*rect)
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
+
+		cfb_fillrect(info, rect);
+}
+
+void smtcfb_imageblit(struct fb_info *info, const struct fb_image
*image)
+{
+	struct par_info *p = (struct par_info *)info->par;
+	u32 bg_col = 0, fg_col = 0;
+	if (smtc_2Dacceleration) {
+		if (image->depth == 1) {
+			if (smtc_de_busy)
+				deWaitForNotBusy();
+
+			switch (info->var.bits_per_pixel) {
+			case 8:
+				bg_col = image->bg_color;
+				fg_col = image->fg_color;
+				break;
+			case 16:
+				bg_col =
+				    ((u32 *) (info->pseudo_palette))[image->
+								     bg_color];
+				fg_col =
+				    ((u32 *) (info->pseudo_palette))[image->
+								     fg_color];
+				break;
+			case 32:
+				bg_col =
+				    ((u32 *) (info->pseudo_palette))[image->
+								     bg_color];
+				fg_col =
+				    ((u32 *) (info->pseudo_palette))[image->
+								     fg_color];
+				break;
+			}
+			deSystemMem2VideoMemMonoBlt((unsigned char *)image->data,	/* pointer
to start of source buffer in system memory */
+						    image->width / 8,	/* Pitch value (in bytes) of the source
buffer, +ive means top down and -ive mean button up */
+						    0,	/* Mono data can start at any bit in a byte, this value
should be 0 to 7 */
+						    p->BaseAddressInVRAM,	/* Address of destination: offset in
frame buffer */
+						    0,	/* Pitch value of destination surface in BYTE */
+						    0,	/* Color depth of destination surface */
+						    image->dx, image->dy,	/* Starting coordinate of destination
surface */
+						    image->width, image->height,	/* width and height of rectange
in pixel value */
+						    fg_col,	/* Foreground color (corresponding to a 1 in the
monochrome data */
+						    bg_col,	/* Background color (corresponding to a 0 in the
monochrome data */
+						    0x0C) /* ROP value */ ;
+		} else
+			cfb_imageblit(info, image);
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
+		/* kylin */
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
+		deInit(sfb->fb.var.xres, sfb->fb.var.yres,
sfb->fb.var.bits_per_pixel);	/* Init smtc drawing engine */
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
+	hw2.BaseAddressInVRAM = smtcfb_info2.fb.fix.smem_len / 2;	/*hard code
2nd head starting from half VRAM size postion */
+	smtcfb_info2.fb.screen_base = hw2.m_pLFB =
+	    smtc_VRAMBaseAddress + hw2.BaseAddressInVRAM;
+
+	/*  sm712crtSetMode(hw2.width, hw2.height, 0, hw2.hz,
smtcfb_info2.fb.var.bits_per_pixel); */
+	writel(hw2.BaseAddressInVRAM >> 3, hw2.m_pVPR + 0x10);
+}
+#endif
+
+/*
+ * Alloc struct smtcfb_info and assign the default value
+ */
+static struct smtcfb_info *__devinit smtc_alloc_fb_info(struct pci_dev
*dev,
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
+	sfb->fb.var.accel_flags = FB_ACCELF_TEXT;	/* text mode acceleration */
+	sfb->fb.var.vmode = FB_VMODE_NONINTERLACED;
+	sfb->fb.par = &hw;
+	sfb->fb.pseudo_palette = colreg;
+
+	return sfb;
+}
+
+/*
+ * Unmap in the memory mapped IO registers
+ *
+ */
+
+static void __devinit smtc_unmap_mmio(struct smtcfb_info *sfb)
+{
+	if (sfb && smtc_RegBaseAddress) {
+		smtc_RegBaseAddress = NULL;
+	}
+}
+
+/*
+ * Map in the screen memory
+ *
+ */
+static int __devinit smtc_map_smem(struct smtcfb_info *sfb, struct
pci_dev *dev,
+				   u_long smem_len)
+{
+	if (sfb->fb.var.bits_per_pixel == 32) {
+#ifdef __BIG_ENDIAN
+		sfb->fb.fix.smem_start = pci_resource_start(dev, 0) + 0x800000;
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
+		printk("%s: unable to map screen memory\n", sfb->fb.fix.id);
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
+ * We need to wake up the LynxEM+, and make sure its in linear memory
mode.
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
+	printk("Silicon Motion display driver " SMTC_LINUX_FB_VERSION "\n");
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
+	if (err) {
+		return err;
+	}
+	err = -ENOMEM;
+
+	sprintf(name, "sm%Xfb", hw.chipID);
+
+	sfb = smtc_alloc_fb_info(pdev, name);
+
+	if (!sfb) {
+		goto failed;
+	}
+
+	sm7xx_init_hw();
+
+	/*get mode parameter from screen_info */
+	if (screen_info.lfb_width != 0) {
+		sfb->fb.var.xres = screen_info.lfb_width;
+		sfb->fb.var.yres = screen_info.lfb_height;
+		sfb->fb.var.bits_per_pixel = screen_info.lfb_depth;
+	} else {
+		sfb->fb.var.xres = SCREEN_X_RES;	/* default resolution 1024x600 16bit
mode */
+		sfb->fb.var.yres = SCREEN_Y_RES;
+		sfb->fb.var.bits_per_pixel = SCREEN_BPP;
+	}
+
+	smdbg("\nsfb->fb.var.bits_per_pixel = %d sm712be_flag = %d\n",
+	      sfb->fb.var.bits_per_pixel, sm712be_flag);
+#ifdef __BIG_ENDIAN
+	if (sm712be_flag == 1 && sfb->fb.var.bits_per_pixel == 24) {
+		sfb->fb.var.bits_per_pixel = screen_info.lfb_depth = 32;
+	}
+#endif
+	/* Map address and memory detection */
+	pFramebufferPhysical = pci_resource_start(pdev, 0);
+	pci_read_config_byte(pdev, PCI_REVISION_ID, &hw.chipRevID);
+
+	switch (hw.chipID) {
+
+	case 0x710:
+	case 0x712:
+		sfb->fb.fix.mmio_start = pFramebufferPhysical + 0x00400000;
+		sfb->fb.fix.mmio_len = 0x00400000;
+		smem_size = SM712_VIDEOMEMORYSIZE;
+#ifdef __BIG_ENDIAN
+		hw.m_pLFB = smtc_VRAMBaseAddress =
+		    ioremap(pFramebufferPhysical, 0x00c00000);
+#else
+		hw.m_pLFB = smtc_VRAMBaseAddress =
+		    ioremap(pFramebufferPhysical, 0x00800000);
+#endif
+		hw.m_pMMIO = smtc_RegBaseAddress =
+		    smtc_VRAMBaseAddress + 0x00700000;
+		smtc_2DBaseAddress = hw.m_pDPR =
+		    smtc_VRAMBaseAddress + 0x00408000;
+		smtc_2Ddataport = smtc_VRAMBaseAddress + DE_DATA_PORT_712;
+		hw.m_pVPR = hw.m_pLFB + 0x0040c000;
+		if (sfb->fb.var.bits_per_pixel == 32) {
+#ifdef __BIG_ENDIAN
+			smtc_VRAMBaseAddress += 0x800000;
+			hw.m_pLFB += 0x800000;
+			printk("\nsmtc_VRAMBaseAddress=0x%X hw.m_pLFB=0x%X\n",
+			       smtc_VRAMBaseAddress, hw.m_pLFB);
+#endif
+		}
+		if (!smtc_RegBaseAddress) {
+			printk("%s: unable to map memory mapped IO\n",
+			       sfb->fb.fix.id);
+			return -ENOMEM;
+		}
+
+		smtc_seqw(0x6a, 0x16);	/* set MCLK = 14.31818 *  (0x16 / 0x2) */
+		smtc_seqw(0x6b, 0x02);
+		smtc_seqw(0x62, 0x3e);
+		smtc_seqw(0x17, 0x20);	/* enable PCI burst */
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
+		smtc_2DBaseAddress = hw.m_pDPR =
+		    ioremap(pFramebufferPhysical, 0x00a00000);
+		hw.m_pLFB = smtc_VRAMBaseAddress =
+		    smtc_2DBaseAddress + 0x00200000;
+		hw.m_pMMIO = smtc_RegBaseAddress =
+		    smtc_2DBaseAddress + 0x000c0000;
+		smtc_2Ddataport = smtc_2DBaseAddress + DE_DATA_PORT_722;
+		hw.m_pVPR = smtc_2DBaseAddress + 0x800;
+
+		smtc_seqw(0x62, 0xff);
+		smtc_seqw(0x6a, 0x0d);
+		smtc_seqw(0x6b, 0x02);
+		smtc_2Dacceleration = 0;
+		break;
+	default:
+		printk("No valid Silicon Motion display chip was detected!\n");
+		smtc_free_fb_info(sfb);
+		return err;
+	}
+
+	/* can support 32 bpp */
+	if (15 == sfb->fb.var.bits_per_pixel)
+		sfb->fb.var.bits_per_pixel = 16;
+	/* else if (32==sfb->fb.var.bits_per_pixel) */
+	/* sfb->fb.var.bits_per_pixel = 24; */
+
+	sfb->fb.var.xres_virtual = sfb->fb.var.xres;
+
+	sfb->fb.var.yres_virtual = sfb->fb.var.yres;
+	err = smtc_map_smem(sfb, pdev, smem_size);
+	if (err) {
+		goto failed;
+	}
+
+	smtcfb_setmode(sfb);
+	hw.BaseAddressInVRAM = 0;	/* Primary display starting from 0 postion
*/
+	sfb->fb.par = &hw;
+
+	err = register_framebuffer(&sfb->fb);
+	if (err < 0) {
+		goto failed;
+	}
+
+	printk
+	    ("Silicon Motion SM%X Rev%X primary display mode %dx%d-%d Init
Complete.\n",
+	     hw.chipID, hw.chipRevID, sfb->fb.var.xres, sfb->fb.var.yres,
+	     sfb->fb.var.bits_per_pixel);
+
+#if defined(CONFIG_FB_SM7XX_DUALHEAD)
+	smtc_head2_init(sfb);
+	err = register_framebuffer(&smtcfb_info2.fb);
+
+	if (err < 0) {
+		printk("Silicon Motion, Inc.  second head init fail\n");
+		goto failed;	/* if second head display fails, also fails the primary
display */
+	}
+
+	printk
+	    ("Silicon Motion SM%X Rev%X secondary display mode %dx%d-%d Init
Complete.\n",
+	     hw.chipID, hw.chipRevID, hw2.width, hw2.height,
+	     smtcfb_info2.fb.var.bits_per_pixel);
+
+#endif
+
+	return 0;
+
+ failed:
+	printk("Silicon Motion, Inc.  primary display init fail\n");
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
+	int retval = 0;
+	sm712be_flag = 0;
+	if (!options || !*options) {
+		retval = 1;
+		smdbg("\n No sm712be parameter\n", __LINE__);
+	}
+	if (!retval && strstr(options, "enable")) {
+		sm712be_flag = 1;
+	}
+	smdbg("\nsm712be_setup = %s sm712be_flag = %d\n", options,
+	      sm712be_flag);
+	return 1;
+}
+
+__setup("sm712be=", sm712be_setup);
+
+#ifdef __BIG_ENDIAN
+/*
+ *	sm712vga_setup - process command line options, get vga parameter
+ *	@options: string of options
+ *	Returns zero.
+ *
+ */
+static int __init sm712vga_setup(char *options)
+{
+	int retval = 0;
+	int index;
+	sm712be_flag = 0;
+
+	if (!options || !*options) {
+		retval = 1;
+		smdbg("\n No vga parameter\n", __LINE__);
+	}
+
+	screen_info.lfb_width = 0;
+	screen_info.lfb_height = 0;
+	screen_info.lfb_depth = 0;
+
+	for (index = 0;
+	     index < (sizeof(vesa_mode) / sizeof(struct vesa_mode_table));
+	     index++) {
+		if (strstr(options, vesa_mode[index].mode_index)) {
+			screen_info.lfb_width = vesa_mode[index].lfb_width;
+			screen_info.lfb_height = vesa_mode[index].lfb_height;
+			screen_info.lfb_depth = vesa_mode[index].lfb_depth;
+		}
+	}
+	smdbg("\nsm712vga_setup = %s\n", options);
+	return 1;
+}
+
+__setup("vga=", sm712vga_setup);
+#endif
+
+MODULE_AUTHOR("Siliconmotion ");
+MODULE_DESCRIPTION("Framebuffer driver for SMI Graphic Cards");
+MODULE_LICENSE("GPL");
diff --git a/drivers/video/smi/smtcfb.h b/drivers/video/smi/smtcfb.h
new file mode 100644
index 0000000..2cb0c77
--- /dev/null
+++ b/drivers/video/smi/smtcfb.h
@@ -0,0 +1,786 @@
+/*
+ *  linux/drivers/video/smtcfb.h -- Silicon Motion SM501 and SM7xx
frame buffer device
+ *
+ *	 Copyright (C) 2006 Silicon Motion Technology Corp.
+ *	 Ge Wang, gewang@siliconmotion.com
+ *	 Boyod boyod.yang@siliconmotion.com.cn
+ *
+ *  This file is subject to the terms and conditions of the GNU General
Public
+ *  License. See the file COPYING in the main directory of this archive
for
+ *  more details.
+ */
+
+#define SMTC_LINUX_FB_VERSION	"version 0.11.2619.21.01 July 27, 2008"
+
+#define NR_PALETTE	256
+#define NR_RGB 	 2
+
+#define FB_ACCEL_SMI_LYNX  88
+
+#ifdef __BIG_ENDIAN
+#define PC_VGA 0
+#else
+#define PC_VGA 1
+#endif
+
+#define SCREEN_X_RES	1024
+#define SCREEN_Y_RES	600
+#define SCREEN_BPP	16
+
+#ifndef FIELD_OFFSET
+#define FIELD_OFSFET(type, field)	((unsigned long) (PUCHAR) &(((type
*)0)->field))
+#endif
+
+#define SM712_VIDEOMEMORYSIZE	  0x00400000	/*Assume SM712 graphics chip
has 4MB VRAM */
+#define SM722_VIDEOMEMORYSIZE	  0x00800000	/*Assume SM722 graphics chip
has 8MB VRAM */
+
+#define dac_reg	(0x3c8)
+#define dac_val	(0x3c9)
+
+extern char *smtc_RegBaseAddress;
+#define smtc_mmiowb(dat,reg)	writeb(dat, smtc_RegBaseAddress + reg)
+#define smtc_mmioww(dat,reg)	writew(dat, smtc_RegBaseAddress + reg)
+#define smtc_mmiowl(dat,reg)	writel(dat, smtc_RegBaseAddress + reg)
+
+#define smtc_mmiorb(reg)		readb(smtc_RegBaseAddress + reg)
+#define smtc_mmiorw(reg)		readw(smtc_RegBaseAddress + reg)
+#define smtc_mmiorl(reg)		readl(smtc_RegBaseAddress + reg)
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
+#define SIZE_VPR	     (0x6C + 1)
+#define SIZE_DPR			(0x44 + 1)
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
+/* The next structure holds all information relevant for a specific
video mode. */
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
+
**********************************************************************/
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
+
+	{			/*  mode#4: 1024 x 600  16Bpp  60Hz  We use 1024x768 table to
light 1024x600 panel for lemote */
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
+#define numVGAModes			sizeof(VGAMode)/sizeof(struct ModeInit)
-- 
1.6.2.1
