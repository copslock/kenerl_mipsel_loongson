Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 May 2007 15:39:19 +0100 (BST)
Received: from mo31.po.2iij.NET ([210.128.50.54]:49419 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20023605AbXEIOjQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 9 May 2007 15:39:16 +0100
Received: by mo.po.2iij.net (mo31) id l49EbwX2081853; Wed, 9 May 2007 23:37:58 +0900 (JST)
Received: from localhost.localdomain (70.27.30.125.dy.iij4u.or.jp [125.30.27.70])
	by mbox.po.2iij.net (mbox31) id l49Ebs5k013518
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 9 May 2007 23:37:54 +0900 (JST)
Date:	Wed, 9 May 2007 23:31:46 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS][1/2] update tb0229_defconfig
Message-Id: <20070509233146.6e82a301.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15006
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has updated tb0229_defconfig.
It's added CONFIG_GPIO_TB0219.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/configs/tb0229_defconfig mips/arch/mips/configs/tb0229_defconfig
--- mips-orig/arch/mips/configs/tb0229_defconfig	2007-04-15 01:01:05.341956750 +0900
+++ mips/arch/mips/configs/tb0229_defconfig	2007-04-15 01:10:51.182569500 +0900
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.20
-# Tue Feb 20 21:47:41 2007
+# Linux kernel version: 2.6.21-rc6
+# Sun Apr 15 01:06:01 2007
 #
 CONFIG_MIPS=y
 
@@ -66,10 +66,11 @@ CONFIG_MACH_VR41XX=y
 # CONFIG_IBM_WORKPAD is not set
 # CONFIG_NEC_CMBVR4133 is not set
 CONFIG_TANBAC_TB022X=y
-# CONFIG_TANBAC_TB0226 is not set
-# CONFIG_TANBAC_TB0287 is not set
 # CONFIG_VICTOR_MPC30X is not set
 # CONFIG_ZAO_CAPCELLA is not set
+CONFIG_TANBAC_TB0219=y
+# CONFIG_TANBAC_TB0226 is not set
+# CONFIG_TANBAC_TB0287 is not set
 CONFIG_PCI_VR41XX=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_ARCH_HAS_ILOG2_U32 is not set
@@ -184,6 +185,7 @@ CONFIG_SYSVIPC_SYSCTL=y
 # CONFIG_IKCONFIG is not set
 CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
+# CONFIG_BLK_DEV_INITRD is not set
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_SYSCTL=y
 CONFIG_EMBEDDED=y
@@ -375,7 +377,7 @@ CONFIG_FIB_RULES=y
 #
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
-# CONFIG_FW_LOADER is not set
+CONFIG_FW_LOADER=m
 # CONFIG_SYS_HYPERVISOR is not set
 
 #
@@ -415,7 +417,6 @@ CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=4096
 CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
-# CONFIG_BLK_DEV_INITRD is not set
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
 
@@ -646,7 +647,7 @@ CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
-CONFIG_TANBAC_TB0219=y
+CONFIG_GPIO_TB0219=y
 # CONFIG_DRM is not set
 CONFIG_GPIO_VR41XX=y
 # CONFIG_RAW_DRIVER is not set
@@ -679,6 +680,11 @@ CONFIG_GPIO_VR41XX=y
 # CONFIG_HWMON_VID is not set
 
 #
+# Multifunction device drivers
+#
+# CONFIG_MFD_SM501 is not set
+
+#
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
@@ -692,7 +698,7 @@ CONFIG_GPIO_VR41XX=y
 #
 # Graphics support
 #
-# CONFIG_FIRMWARE_EDID is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 # CONFIG_FB is not set
 
 #
@@ -700,7 +706,6 @@ CONFIG_GPIO_VR41XX=y
 #
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_DUMMY_CONSOLE=y
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
 # Sound
@@ -831,6 +836,7 @@ CONFIG_USB_MON=y
 # CONFIG_USB_SISUSBVGA is not set
 # CONFIG_USB_LD is not set
 # CONFIG_USB_TRANCEVIBRATOR is not set
+# CONFIG_USB_IOWARRIOR is not set
 # CONFIG_USB_TEST is not set
 
 #
