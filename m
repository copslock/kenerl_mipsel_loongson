Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Oct 2007 11:49:38 +0100 (BST)
Received: from mo32.po.2iij.NET ([210.128.50.17]:53064 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20022266AbXJAKta (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 1 Oct 2007 11:49:30 +0100
Received: by mo.po.2iij.net (mo32) id l91AnRpB098352; Mon, 1 Oct 2007 19:49:27 +0900 (JST)
Received: from localhost (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (po-mbox303) id l91AnPrF030544
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 1 Oct 2007 19:49:26 +0900
Message-Id: <200710011049.l91AnPrF030544@po-mbox303.hop.2iij.net>
Date:	Mon, 1 Oct 2007 19:48:31 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp,
	linux-mips <linux-mips@linux-mips.org>,
	Richard Purdie <rpurdie@rpsys.net>
Subject: [PATCH][3/3] add LED support to cobalt_defconfig
References: <20071001194505.979185df.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16756
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
