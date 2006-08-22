Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Aug 2006 15:03:33 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:58148 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20038749AbWHVN6z (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 22 Aug 2006 14:58:55 +0100
Received: by mo.po.2iij.net (mo30) id k7MDwren013064; Tue, 22 Aug 2006 22:58:53 +0900 (JST)
Received: from localhost.localdomain (191.28.30.125.dy.iij4u.or.jp [125.30.28.191])
	by mbox.po.2iij.net (mbox33) id k7MDwou3012263
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 22 Aug 2006 22:58:51 +0900 (JST)
Date:	Tue, 22 Aug 2006 22:58:11 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 12/12] updated Cobalt defconfig
Message-Id: <20060822225811.196b3aa2.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12408
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has updated Cobalt defconfig.
CONFIG_EARLY_PRINTK is off, because it's for debug option.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/configs/cobalt_defconfig mips/arch/mips/configs/cobalt_defconfig
--- mips-orig/arch/mips/configs/cobalt_defconfig	2006-08-18 22:43:53.141845500 +0900
+++ mips/arch/mips/configs/cobalt_defconfig	2006-08-18 22:57:43.269725250 +0900
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.18-rc1
-# Thu Jul  6 10:03:25 2006
+# Linux kernel version: 2.6.18-rc4
+# Fri Aug 18 22:44:59 2006
 #
 CONFIG_MIPS=y
 
@@ -64,7 +64,7 @@ CONFIG_MIPS_COBALT=y
 # CONFIG_TOSHIBA_JMR3927 is not set
 # CONFIG_TOSHIBA_RBTX4927 is not set
 # CONFIG_TOSHIBA_RBTX4938 is not set
-CONFIG_EARLY_PRINTK=y
+# CONFIG_EARLY_PRINTK is not set
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
 CONFIG_GENERIC_HWEIGHT=y
@@ -77,7 +77,12 @@ CONFIG_I8259=y
 CONFIG_CPU_LITTLE_ENDIAN=y
 CONFIG_SYS_SUPPORTS_LITTLE_ENDIAN=y
 CONFIG_IRQ_CPU=y
-CONFIG_MIPS_GT64111=y
+CONFIG_MIPS_GT64120=y
+CONFIG_SYSCLK_50=y
+# CONFIG_SYSCLK_75 is not set
+# CONFIG_SYSCLK_83 is not set
+# CONFIG_SYSCLK_100 is not set
+CONFIG_SYSCLK=50000000
 CONFIG_MIPS_L1_CACHE_SHIFT=5
 
 #
@@ -165,6 +170,7 @@ CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
 # CONFIG_POSIX_MQUEUE is not set
 # CONFIG_BSD_PROCESS_ACCT is not set
+# CONFIG_TASKSTATS is not set
 CONFIG_SYSCTL=y
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
@@ -716,6 +722,7 @@ CONFIG_VIDEO_V4L2=y
 #
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_DUMMY_CONSOLE=y
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
 # Sound
@@ -865,7 +872,6 @@ CONFIG_SUNRPC=y
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
 # CONFIG_CIFS is not set
-# CONFIG_CIFS_DEBUG2 is not set
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
 # CONFIG_AFS_FS is not set
@@ -890,6 +896,7 @@ CONFIG_MSDOS_PARTITION=y
 #
 # Kernel hacking
 #
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
