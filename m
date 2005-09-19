Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Sep 2005 16:08:41 +0100 (BST)
Received: from verein.lst.de ([IPv6:::ffff:213.95.11.210]:8111 "EHLO
	mail.lst.de") by linux-mips.org with ESMTP id <S8225196AbVISPIY>;
	Mon, 19 Sep 2005 16:08:24 +0100
Received: from verein.lst.de (localhost [127.0.0.1])
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id j8JF8M6t013533
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 19 Sep 2005 17:08:22 +0200
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id j8JF8M79013531;
	Mon, 19 Sep 2005 17:08:22 +0200
Date:	Mon, 19 Sep 2005 17:08:22 +0200
From:	Christoph Hellwig <hch@lst.de>
To:	ralf@linux-mips.org, akpm@osdl.org
Cc:	linux-mips@linux-mips.org
Subject: [PATCH] switch sibyte profiling driver to ->compat_ioctl
Message-ID: <20050919150822.GB13478@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Scanned-By: MIMEDefang 2.39
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8975
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
Precedence: bulk
X-list: linux-mips


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/arch/mips/kernel/ioctl32.c
===================================================================
--- linux-2.6.orig/arch/mips/kernel/ioctl32.c	2005-09-18 13:46:51.000000000 +0200
+++ linux-2.6/arch/mips/kernel/ioctl32.c	2005-09-19 15:14:05.000000000 +0200
@@ -41,12 +41,6 @@
 #define DECLARES
 #include "compat_ioctl.c"
 
-#ifdef CONFIG_SIBYTE_TBPROF
-COMPATIBLE_IOCTL(SBPROF_ZBSTART)
-COMPATIBLE_IOCTL(SBPROF_ZBSTOP)
-COMPATIBLE_IOCTL(SBPROF_ZBWAITFULL)
-#endif /* CONFIG_SIBYTE_TBPROF */
-
 /*HANDLE_IOCTL(RTC_IRQP_READ, w_long)
 COMPATIBLE_IOCTL(RTC_IRQP_SET)
 HANDLE_IOCTL(RTC_EPOCH_READ, w_long)
Index: linux-2.6/arch/mips/sibyte/sb1250/bcm1250_tbprof.c
===================================================================
--- linux-2.6.orig/arch/mips/sibyte/sb1250/bcm1250_tbprof.c	2005-09-18 13:46:52.000000000 +0200
+++ linux-2.6/arch/mips/sibyte/sb1250/bcm1250_tbprof.c	2005-09-19 15:13:53.000000000 +0200
@@ -28,6 +28,7 @@
 #include <linux/fs.h>
 #include <linux/errno.h>
 #include <linux/reboot.h>
+#include <linux/smp_lock.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
 #include <asm/sibyte/sb1250.h>
@@ -333,13 +334,13 @@
 	return count;
 }
 
-static int sbprof_tb_ioctl(struct inode *inode,
-			   struct file *filp,
-			   unsigned int command,
-			   unsigned long arg)
+static long sbprof_tb_ioctl(struct file *filp,
+			    unsigned int command,
+			    unsigned long arg)
 {
 	int error = 0;
 
+	lock_kernel();
 	switch (command) {
 	case SBPROF_ZBSTART:
 		error = sbprof_zbprof_start(filp);
@@ -355,6 +356,7 @@
 		error = -EINVAL;
 		break;
 	}
+	unlock_kernel();
 
 	return error;
 }
@@ -364,7 +366,8 @@
 	.open		= sbprof_tb_open,
 	.release	= sbprof_tb_release,
 	.read		= sbprof_tb_read,
-	.ioctl		= sbprof_tb_ioctl,
+	.unlocked_ioctl	= sbprof_tb_ioctl,
+	.comapt_ioctl	= sbprof_tb_ioctl,
 	.mmap		= NULL,
 };
 
