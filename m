Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Feb 2007 13:32:30 +0000 (GMT)
Received: from mo30.po.2iij.net ([210.128.50.53]:48652 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20038583AbXBVNcY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 22 Feb 2007 13:32:24 +0000
Received: by mo.po.2iij.net (mo30) id l1MDV5pi012476; Thu, 22 Feb 2007 22:31:05 +0900 (JST)
Received: from localhost.localdomain (70.27.30.125.dy.iij4u.or.jp [125.30.27.70])
	by mbox.po.2iij.net (mbox33) id l1MDV0NF041036
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 22 Feb 2007 22:31:01 +0900 (JST)
Date:	Thu, 22 Feb 2007 22:31:00 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] add new SM501 drivers support to tb0287_defconfig
Message-Id: <20070222223100.47911367.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14201
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has added new SM501 drivers support to TB0287 defconfig.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/configs/tb0287_defconfig mips/arch/mips/configs/tb0287_defconfig
--- mips-orig/arch/mips/configs/tb0287_defconfig	2007-02-22 10:04:12.196917750 +0900
+++ mips/arch/mips/configs/tb0287_defconfig	2007-02-22 11:47:27.710893500 +0900
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.20
-# Tue Feb 20 21:47:41 2007
+# Linux kernel version: 2.6.21-rc1
+# Thu Feb 22 10:38:09 2007
 #
 CONFIG_MIPS=y
 
@@ -826,6 +826,11 @@ CONFIG_GPIO_VR41XX=y
 # CONFIG_HWMON_VID is not set
 
 #
+# Multifunction device drivers
+#
+CONFIG_MFD_SM501=y
+
+#
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
@@ -839,8 +844,10 @@ CONFIG_GPIO_VR41XX=y
 #
 # Graphics support
 #
-# CONFIG_FIRMWARE_EDID is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 CONFIG_FB=y
+# CONFIG_FIRMWARE_EDID is not set
+# CONFIG_FB_DDC is not set
 CONFIG_FB_CFB_FILLRECT=y
 CONFIG_FB_CFB_COPYAREA=y
 CONFIG_FB_CFB_IMAGEBLIT=y
@@ -849,6 +856,10 @@ CONFIG_FB_CFB_IMAGEBLIT=y
 # CONFIG_FB_BACKLIGHT is not set
 # CONFIG_FB_MODE_HELPERS is not set
 # CONFIG_FB_TILEBLITTING is not set
+
+#
+# Frambuffer hardware drivers
+#
 # CONFIG_FB_CIRRUS is not set
 # CONFIG_FB_PM2 is not set
 # CONFIG_FB_CYBER2000 is not set
@@ -868,8 +879,9 @@ CONFIG_FB_CFB_IMAGEBLIT=y
 # CONFIG_FB_KYRO is not set
 # CONFIG_FB_3DFX is not set
 # CONFIG_FB_VOODOO1 is not set
-CONFIG_FB_SMIVGX=y
+# CONFIG_FB_SMIVGX is not set
 # CONFIG_FB_TRIDENT is not set
+CONFIG_FB_SM501=y
 # CONFIG_FB_VIRTUAL is not set
 
 #
@@ -883,7 +895,6 @@ CONFIG_DUMMY_CONSOLE=y
 # Logo configuration
 #
 # CONFIG_LOGO is not set
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
 # Sound
