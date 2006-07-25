Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Jul 2006 15:27:06 +0100 (BST)
Received: from mo32.po.2iij.net ([210.128.50.17]:25375 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S8133797AbWGYO05 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 25 Jul 2006 15:26:57 +0100
Received: by mo.po.2iij.net (mo32) id k6PEQr8L072953; Tue, 25 Jul 2006 23:26:53 +0900 (JST)
Received: from localhost.localdomain (203.25.30.125.dy.iij4u.or.jp [125.30.25.203])
	by mbox.po.2iij.net (mbox32) id k6PEQplD057538
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 25 Jul 2006 23:26:52 +0900 (JST)
Date:	Tue, 25 Jul 2006 23:24:47 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] update e55 defconfig
Message-Id: <20060725232447.3e2404b6.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12065
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has updated e55 defconfig.
Please apply.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/configs/e55_defconfig mips/arch/mips/configs/e55_defconfig
--- mips-orig/arch/mips/configs/e55_defconfig	2006-07-25 22:52:01.575229250 +0900
+++ mips/arch/mips/configs/e55_defconfig	2006-07-25 23:15:32.663416750 +0900
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.18-rc1
-# Thu Jul  6 10:04:02 2006
+# Linux kernel version: 2.6.18-rc2
+# Tue Jul 25 23:15:03 2006
 #
 CONFIG_MIPS=y
 
@@ -227,7 +227,6 @@ CONFIG_MMU=y
 #
 # PCCARD (PCMCIA/CardBus) support
 #
-# CONFIG_PCCARD is not set
 
 #
 # PCI Hotplug Support
@@ -254,7 +253,6 @@ CONFIG_TRAD_SIGNALS=y
 #
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
-# CONFIG_FW_LOADER is not set
 # CONFIG_SYS_HYPERVISOR is not set
 
 #
@@ -284,6 +282,7 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 CONFIG_BLK_DEV_RAM=m
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=4096
+CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
 # CONFIG_BLK_DEV_INITRD is not set
 # CONFIG_CDROM_PKTCDVD is not set
 
@@ -643,6 +642,7 @@ CONFIG_MSDOS_PARTITION=y
 #
 # Kernel hacking
 #
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
@@ -650,7 +650,7 @@ CONFIG_MSDOS_PARTITION=y
 CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_DEBUG_FS is not set
 CONFIG_CROSSCOMPILE=y
-CONFIG_CMDLINE="console=ttyVR0,19200 mem=8M"
+CONFIG_CMDLINE="console=ttyVR0,19200 ide0=0x1f0,0x3f6,40 mem=8M"
 
 #
 # Security options
