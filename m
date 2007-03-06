Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Mar 2007 12:36:15 +0000 (GMT)
Received: from mo31.po.2iij.net ([210.128.50.54]:60959 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20021367AbXCFMgM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 6 Mar 2007 12:36:12 +0000
Received: by mo.po.2iij.net (mo31) id l26CYo3G041416; Tue, 6 Mar 2007 21:34:50 +0900 (JST)
Received: from localhost.localdomain (70.27.30.125.dy.iij4u.or.jp [125.30.27.70])
	by mbox.po.2iij.net (mbox32) id l26CYi0I014215
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 6 Mar 2007 21:34:45 +0900 (JST)
Date:	Tue, 6 Mar 2007 21:34:44 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] clean up include files for Cobalt
Message-Id: <20070306213444.7b826d1d.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14370
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has cleaned up include files for Cobalt.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/console.c mips/arch/mips/cobalt/console.c
--- mips-orig/arch/mips/cobalt/console.c	2007-03-05 06:51:23.517795750 +0900
+++ mips/arch/mips/cobalt/console.c	2007-03-05 06:54:18.104706750 +0900
@@ -1,13 +1,11 @@
 /*
  * (C) P. Horton 2006
  */
-
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/console.h>
 #include <linux/serial_reg.h>
+
 #include <asm/addrspace.h>
-#include <asm/mach-cobalt/cobalt.h>
+
+#include <cobalt.h>
 
 void prom_putchar(char c)
 {
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/irq.c mips/arch/mips/cobalt/irq.c
--- mips-orig/arch/mips/cobalt/irq.c	2007-03-05 06:51:23.517795750 +0900
+++ mips/arch/mips/cobalt/irq.c	2007-03-05 06:54:18.104706750 +0900
@@ -17,7 +17,7 @@
 #include <asm/irq_cpu.h>
 #include <asm/gt64120.h>
 
-#include <asm/mach-cobalt/cobalt.h>
+#include <cobalt.h>
 
 /*
  * We have two types of interrupts that we handle, ones that come in through
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/reset.c mips/arch/mips/cobalt/reset.c
--- mips-orig/arch/mips/cobalt/reset.c	2007-03-05 06:51:23.521796000 +0900
+++ mips/arch/mips/cobalt/reset.c	2007-03-05 06:54:18.104706750 +0900
@@ -8,15 +8,12 @@
  * Copyright (C) 1995, 1996, 1997 by Ralf Baechle
  * Copyright (C) 2001 by Liam Davies (ldavies@agile.tv)
  */
-#include <linux/sched.h>
-#include <linux/mm.h>
-#include <asm/cacheflush.h>
+#include <linux/jiffies.h>
+
 #include <asm/io.h>
-#include <asm/processor.h>
 #include <asm/reboot.h>
-#include <asm/system.h>
-#include <asm/mipsregs.h>
-#include <asm/mach-cobalt/cobalt.h>
+
+#include <cobalt.h>
 
 void cobalt_machine_halt(void)
 {
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/setup.c mips/arch/mips/cobalt/setup.c
--- mips-orig/arch/mips/cobalt/setup.c	2007-03-05 06:56:04.679367250 +0900
+++ mips/arch/mips/cobalt/setup.c	2007-03-05 06:54:18.120707750 +0900
@@ -19,12 +19,10 @@
 #include <asm/bootinfo.h>
 #include <asm/time.h>
 #include <asm/io.h>
-#include <asm/irq.h>
-#include <asm/processor.h>
 #include <asm/reboot.h>
 #include <asm/gt64120.h>
 
-#include <asm/mach-cobalt/cobalt.h>
+#include <cobalt.h>
 
 extern void cobalt_machine_restart(char *command);
 extern void cobalt_machine_halt(void);
