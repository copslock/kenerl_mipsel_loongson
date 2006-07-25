Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Jul 2006 15:28:46 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:36933 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S8133933AbWGYO07 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 25 Jul 2006 15:26:59 +0100
Received: by mo.po.2iij.net (mo30) id k6PEQvWV047028; Tue, 25 Jul 2006 23:26:57 +0900 (JST)
Received: from localhost.localdomain (203.25.30.125.dy.iij4u.or.jp [125.30.25.203])
	by mbox.po.2iij.net (mbox32) id k6PEQr8R057544
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 25 Jul 2006 23:26:53 +0900 (JST)
Date:	Tue, 25 Jul 2006 23:24:54 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] update workpad defconfig
Message-Id: <20060725232454.70d5f078.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12067
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has updated workpad defconfig.
Please apply.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/configs/workpad_defconfig mips/arch/mips/configs/workpad_defconfig
--- mips-orig/arch/mips/configs/workpad_defconfig	2006-07-25 22:52:01.587230000 +0900
+++ mips/arch/mips/configs/workpad_defconfig	2006-07-25 23:13:22.855304250 +0900
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.18-rc1
-# Thu Jul  6 10:04:21 2006
+# Linux kernel version: 2.6.18-rc2
+# Tue Jul 25 23:13:04 2006
 #
 CONFIG_MIPS=y
 
@@ -166,6 +166,7 @@ CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
 # CONFIG_POSIX_MQUEUE is not set
 # CONFIG_BSD_PROCESS_ACCT is not set
+# CONFIG_TASKSTATS is not set
 CONFIG_SYSCTL=y
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
@@ -379,6 +380,7 @@ CONFIG_CONNECTOR=m
 CONFIG_BLK_DEV_RAM=m
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=4096
+CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
 # CONFIG_BLK_DEV_INITRD is not set
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
@@ -855,7 +857,6 @@ CONFIG_SUNRPC=y
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
 # CONFIG_CIFS is not set
-# CONFIG_CIFS_DEBUG2 is not set
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
 # CONFIG_AFS_FS is not set
@@ -880,6 +881,7 @@ CONFIG_MSDOS_PARTITION=y
 #
 # Kernel hacking
 #
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
@@ -887,7 +889,7 @@ CONFIG_MSDOS_PARTITION=y
 CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_DEBUG_FS is not set
 CONFIG_CROSSCOMPILE=y
-CONFIG_CMDLINE="console=ttyVR0,19200 mem=16M"
+CONFIG_CMDLINE="console=ttyVR0,19200 ide0=0x170,0x376,49 mem=16M"
 
 #
 # Security options
