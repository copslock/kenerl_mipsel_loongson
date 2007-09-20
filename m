Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Sep 2007 15:13:02 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:10539 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20022028AbXITOLn (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 20 Sep 2007 15:11:43 +0100
Received: by mo.po.2iij.net (mo30) id l8KEBeU1025005; Thu, 20 Sep 2007 23:11:40 +0900 (JST)
Received: from localhost.localdomain (221.25.30.125.dy.iij4u.or.jp [125.30.25.221])
	by mbox.po.2iij.net (po-mbox301) id l8KEBafp023685
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 20 Sep 2007 23:11:37 +0900
Date:	Thu, 20 Sep 2007 23:10:01 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, Richard Purdie <rpurdie@rpsys.net>,
	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][6/6] led: add LED support to cobalt_defconfig
Message-Id: <20070920231001.56d37f4e.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20070920230841.5e4b0a05.yoichi_yuasa@tripeaks.co.jp>
References: <20070920230204.0ad15513.yoichi_yuasa@tripeaks.co.jp>
	<20070920230322.6600dd83.yoichi_yuasa@tripeaks.co.jp>
	<20070920230513.1dbb1d6d.yoichi_yuasa@tripeaks.co.jp>
	<20070920230656.640886f5.yoichi_yuasa@tripeaks.co.jp>
	<20070920230841.5e4b0a05.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16576
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Add LED support to cobalt_defconfig.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/configs/cobalt_defconfig mips/arch/mips/configs/cobalt_defconfig
--- mips-orig/arch/mips/configs/cobalt_defconfig	2007-09-06 13:09:26.597218500 +0900
+++ mips/arch/mips/configs/cobalt_defconfig	2007-09-06 13:21:20.681846000 +0900
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.23-rc2
-# Tue Aug  7 22:12:54 2007
+# Linux kernel version: 2.6.23-rc5
+# Thu Sep  6 13:14:29 2007
 #
 CONFIG_MIPS=y
 
@@ -55,12 +55,14 @@ CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
 CONFIG_EARLY_PRINTK=y
 CONFIG_SYS_HAS_EARLY_PRINTK=y
+# CONFIG_HOTPLUG_CPU is not set
 CONFIG_I8259=y
 # CONFIG_NO_IOPORT is not set
 # CONFIG_CPU_BIG_ENDIAN is not set
 CONFIG_CPU_LITTLE_ENDIAN=y
 CONFIG_SYS_SUPPORTS_LITTLE_ENDIAN=y
 CONFIG_IRQ_CPU=y
+CONFIG_IRQ_GT641XX=y
 CONFIG_PCI_GT64XXX_PCI0=y
 CONFIG_MIPS_L1_CACHE_SHIFT=5
 
@@ -235,6 +237,7 @@ CONFIG_TRAD_SIGNALS=y
 # Power management options
 #
 # CONFIG_PM is not set
+CONFIG_SUSPEND_UP_POSSIBLE=y
 
 #
 # Networking
@@ -844,7 +847,21 @@ CONFIG_USB_MON=y
 #
 # CONFIG_USB_GADGET is not set
 # CONFIG_MMC is not set
-# CONFIG_NEW_LEDS is not set
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+
+#
+# LED drivers
+#
+CONFIG_LEDS_COBALT_QUBE=y
+CONFIG_LEDS_COBALT_RAQ=y
+
+#
+# LED Triggers
+#
+CONFIG_LEDS_TRIGGERS=y
+# CONFIG_LEDS_TRIGGER_TIMER is not set
+# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
 # CONFIG_INFINIBAND is not set
 CONFIG_RTC_LIB=y
 CONFIG_RTC_CLASS=y
