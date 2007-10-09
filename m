Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Oct 2007 16:28:42 +0100 (BST)
Received: from mo30.po.2iij.NET ([210.128.50.53]:8012 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20022992AbXJIP2d (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 9 Oct 2007 16:28:33 +0100
Received: by mo.po.2iij.net (mo30) id l99FSUqL058502; Wed, 10 Oct 2007 00:28:30 +0900 (JST)
Received: from delta (221.25.30.125.dy.iij4u.or.jp [125.30.25.221])
	by mbox.po.2iij.net (po-mbox303) id l99FSRws005770
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 10 Oct 2007 00:28:27 +0900
Date:	Wed, 10 Oct 2007 00:28:26 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] cleanup WRPPMC include files
Message-Id: <20071010002826.5a85efc5.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.0 (GTK+ 2.10.11; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16906
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Cleanup WRPPMC include files.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/gt64120/wrppmc/irq.c mips/arch/mips/gt64120/wrppmc/irq.c
--- mips-orig/arch/mips/gt64120/wrppmc/irq.c	2007-10-09 23:49:54.264557000 +0900
+++ mips/arch/mips/gt64120/wrppmc/irq.c	2007-10-09 23:50:40.935473750 +0900
@@ -9,26 +9,13 @@
  * Free Software Foundation;  either version 2 of the  License, or (at your
  * option) any later version.
  */
-#include <linux/errno.h>
+#include <linux/hardirq.h>
 #include <linux/init.h>
-#include <linux/kernel_stat.h>
-#include <linux/module.h>
-#include <linux/signal.h>
-#include <linux/sched.h>
-#include <linux/types.h>
-#include <linux/interrupt.h>
-#include <linux/ioport.h>
-#include <linux/timex.h>
-#include <linux/slab.h>
-#include <linux/random.h>
-#include <linux/bitops.h>
-#include <asm/bootinfo.h>
-#include <asm/io.h>
-#include <asm/bitops.h>
-#include <asm/mipsregs.h>
-#include <asm/system.h>
-#include <asm/irq_cpu.h>
+#include <linux/irq.h>
+
 #include <asm/gt64120.h>
+#include <asm/irq_cpu.h>
+#include <asm/mipsregs.h>
 
 asmlinkage void plat_irq_dispatch(void)
 {
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/gt64120/wrppmc/pci.c mips/arch/mips/gt64120/wrppmc/pci.c
--- mips-orig/arch/mips/gt64120/wrppmc/pci.c	2007-10-09 23:49:54.264557000 +0900
+++ mips/arch/mips/gt64120/wrppmc/pci.c	2007-10-09 23:50:00.764963250 +0900
@@ -8,9 +8,10 @@
  * for more details.
  */
 #include <linux/init.h>
+#include <linux/ioport.h>
 #include <linux/types.h>
 #include <linux/pci.h>
-#include <linux/kernel.h>
+
 #include <asm/gt64120.h>
 
 extern struct pci_ops gt64xxx_pci0_ops;
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/gt64120/wrppmc/reset.c mips/arch/mips/gt64120/wrppmc/reset.c
--- mips-orig/arch/mips/gt64120/wrppmc/reset.c	2007-10-09 23:49:54.264557000 +0900
+++ mips/arch/mips/gt64120/wrppmc/reset.c	2007-10-09 23:50:00.824967000 +0900
@@ -5,14 +5,10 @@
  *
  * Copyright (C) 1997 Ralf Baechle
  */
-#include <linux/sched.h>
-#include <linux/mm.h>
-#include <asm/io.h>
-#include <asm/pgtable.h>
-#include <asm/processor.h>
-#include <asm/reboot.h>
-#include <asm/system.h>
+#include <linux/kernel.h>
+
 #include <asm/cacheflush.h>
+#include <asm/mipsregs.h>
 
 void wrppmc_machine_restart(char *command)
 {
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/gt64120/wrppmc/time.c mips/arch/mips/gt64120/wrppmc/time.c
--- mips-orig/arch/mips/gt64120/wrppmc/time.c	2007-10-09 23:49:54.268557250 +0900
+++ mips/arch/mips/gt64120/wrppmc/time.c	2007-10-09 23:50:00.824967000 +0900
@@ -11,18 +11,11 @@
  * Copyright (C) 2006, Wind River System Inc.
  */
 #include <linux/init.h>
-#include <linux/string.h>
-#include <linux/kernel.h>
-#include <linux/param.h>	/* for HZ */
-#include <linux/irq.h>
-#include <linux/timex.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 
-#include <asm/reboot.h>
-#include <asm/time.h>
-#include <asm/io.h>
-#include <asm/bootinfo.h>
 #include <asm/gt64120.h>
+#include <asm/time.h>
 
 #define WRPPMC_CPU_CLK_FREQ 40000000 /* 40MHZ */
 
