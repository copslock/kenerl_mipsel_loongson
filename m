Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2008 11:15:10 +0000 (GMT)
Received: from mail.windriver.com ([147.11.1.11]:13822 "EHLO mail.wrs.com")
	by ftp.linux-mips.org with ESMTP id S22721847AbYJ3LO5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 30 Oct 2008 11:14:57 +0000
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id m9UBEk19002643;
	Thu, 30 Oct 2008 04:14:46 -0700 (PDT)
Received: from localhost.localdomain ([128.224.162.71]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 30 Oct 2008 04:14:45 -0700
From:	Tiejun Chen <tiejun.chen@windriver.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	Tiejun Chen <tiejun.chen@windriver.com>
Subject: [PATCH] Support RTC on Malta
Date:	Thu, 30 Oct 2008 19:15:44 +0800
Message-Id: <1225365345-15635-1-git-send-email-tiejun.chen@windriver.com>
X-Mailer: git-send-email 1.5.5.1
X-OriginalArrivalTime: 30 Oct 2008 11:14:45.0638 (UTC) FILETIME=[B6F31A60:01C93A80]
Return-Path: <Tiejun.Chen@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21110
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiejun.chen@windriver.com
Precedence: bulk
X-list: linux-mips

To create platform device for RTC to call platform driver successfully.

Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
---
 arch/mips/configs/malta_defconfig |    4 +-
 arch/mips/mti-malta/Makefile      |    2 +-
 arch/mips/mti-malta/malta-rtc.c   |   73 +++++++++++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+), 3 deletions(-)
 create mode 100644 arch/mips/mti-malta/malta-rtc.c

diff --git a/arch/mips/configs/malta_defconfig b/arch/mips/configs/malta_defconfig
index 74daa0c..f84bdf6 100644
--- a/arch/mips/configs/malta_defconfig
+++ b/arch/mips/configs/malta_defconfig
@@ -1126,7 +1126,6 @@ CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_IPMI_HANDLER is not set
 # CONFIG_WATCHDOG is not set
 CONFIG_HW_RANDOM=m
-CONFIG_RTC=y
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
 # CONFIG_DRM is not set
@@ -1199,7 +1198,8 @@ CONFIG_USB_ARCH_HAS_EHCI=y
 # CONFIG_MMC is not set
 # CONFIG_NEW_LEDS is not set
 # CONFIG_INFINIBAND is not set
-# CONFIG_RTC_CLASS is not set
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_CMOS=y
 
 #
 # DMA Engine support
diff --git a/arch/mips/mti-malta/Makefile b/arch/mips/mti-malta/Makefile
index cef2db8..26284fc 100644
--- a/arch/mips/mti-malta/Makefile
+++ b/arch/mips/mti-malta/Makefile
@@ -9,7 +9,7 @@ obj-y				:= malta-amon.o malta-cmdline.o \
 				   malta-display.o malta-init.o malta-int.o \
 				   malta-memory.o malta-mtd.o \
 				   malta-platform.o malta-reset.o \
-				   malta-setup.o malta-time.o
+				   malta-setup.o malta-time.o malta-rtc.o
 
 obj-$(CONFIG_EARLY_PRINTK)	+= malta-console.o
 obj-$(CONFIG_PCI)		+= malta-pci.o
diff --git a/arch/mips/mti-malta/malta-rtc.c b/arch/mips/mti-malta/malta-rtc.c
new file mode 100644
index 0000000..b987c31
--- /dev/null
+++ b/arch/mips/mti-malta/malta-rtc.c
@@ -0,0 +1,73 @@
+/*
+ *  Registration of Malta RTC platform device.
+ *
+ *  Copyright (C) 2008  Tiejun Chen <tiejun.chen@windriver.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include <linux/mc146818rtc.h>
+#include <linux/platform_device.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/ioport.h>
+
+static struct resource malta_platform_rtc_resource[] __initdata = {
+	{
+		.start	= RTC_PORT(0),
+		.end	= RTC_PORT(7),
+		.flags	= IORESOURCE_IO,
+	},
+	{
+		.start	= RTC_IRQ,
+		.end	= RTC_IRQ,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static __init int malta_platform_rtc_add(void)
+{
+	struct platform_device *pdev;
+	int ret;
+
+	pdev = platform_device_alloc("rtc_cmos", -1);
+	if (!pdev)
+		return -ENOMEM;
+
+	ret = platform_device_add_resources(pdev, malta_platform_rtc_resource,
+	                                       ARRAY_SIZE(malta_platform_rtc_resource));
+	if (ret)
+		goto err;
+
+	ret = platform_device_add(pdev);
+	if (ret)
+		goto err;
+
+	/* Try setting rtc as BCD mode to support
+	 * current alarm code if possible.
+	 */
+	if (!RTC_ALWAYS_BCD)
+		CMOS_WRITE(CMOS_READ(RTC_CONTROL) & ~RTC_DM_BINARY, RTC_CONTROL);
+
+	return 0;
+
+err:
+	platform_device_put(pdev);
+
+	return ret;
+}
+
+device_initcall(malta_platform_rtc_add);
+
-- 
1.5.5.1
