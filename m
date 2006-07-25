Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Jul 2006 15:27:56 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:57420 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S8133810AbWGYO06 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 25 Jul 2006 15:26:58 +0100
Received: by mo.po.2iij.net (mo30) id k6PEQuao047018; Tue, 25 Jul 2006 23:26:56 +0900 (JST)
Received: from localhost.localdomain (203.25.30.125.dy.iij4u.or.jp [125.30.25.203])
	by mbox.po.2iij.net (mbox32) id k6PEQspX057558
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 25 Jul 2006 23:26:55 +0900 (JST)
Date:	Tue, 25 Jul 2006 23:26:09 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] update mpc30x defconfig
Message-Id: <20060725232609.2021c28f.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12066
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has updated mpc30x defconfig.
Please apply.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/configs/mpc30x_defconfig mips/arch/mips/configs/mpc30x_defconfig
--- mips-orig/arch/mips/configs/mpc30x_defconfig	2006-07-25 22:52:01.579229500 +0900
+++ mips/arch/mips/configs/mpc30x_defconfig	2006-07-25 23:17:09.261453750 +0900
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.18-rc1
-# Thu Jul  6 10:04:15 2006
+# Linux kernel version: 2.6.18-rc2
+# Tue Jul 25 23:16:46 2006
 #
 CONFIG_MIPS=y
 
@@ -71,7 +71,6 @@ CONFIG_MACH_VR41XX=y
 CONFIG_VICTOR_MPC30X=y
 # CONFIG_ZAO_CAPCELLA is not set
 CONFIG_PCI_VR41XX=y
-CONFIG_VRC4173=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
 CONFIG_GENERIC_HWEIGHT=y
@@ -168,6 +167,7 @@ CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
 # CONFIG_POSIX_MQUEUE is not set
 # CONFIG_BSD_PROCESS_ACCT is not set
+# CONFIG_TASKSTATS is not set
 CONFIG_SYSCTL=y
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
@@ -841,7 +841,7 @@ CONFIG_USB_PEGASUS=m
 # CONFIG_USB_LEGOTOWER is not set
 # CONFIG_USB_LCD is not set
 # CONFIG_USB_LED is not set
-# CONFIG_USB_CY7C63 is not set
+# CONFIG_USB_CYPRESS_CY7C63 is not set
 # CONFIG_USB_CYTHERM is not set
 # CONFIG_USB_PHIDGETKIT is not set
 # CONFIG_USB_PHIDGETSERVO is not set
@@ -982,7 +982,6 @@ CONFIG_SUNRPC=y
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
 # CONFIG_CIFS is not set
-# CONFIG_CIFS_DEBUG2 is not set
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
 # CONFIG_AFS_FS is not set
@@ -1007,6 +1006,7 @@ CONFIG_MSDOS_PARTITION=y
 #
 # Kernel hacking
 #
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
@@ -1014,7 +1014,7 @@ CONFIG_MSDOS_PARTITION=y
 CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_DEBUG_FS is not set
 CONFIG_CROSSCOMPILE=y
-CONFIG_CMDLINE="mem=32M console=ttyVR0,19200"
+CONFIG_CMDLINE="mem=32M console=ttyVR0,19200 ide0=0x170,0x376,73"
 
 #
 # Security options
