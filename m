Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Apr 2005 15:28:30 +0100 (BST)
Received: from mo00.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:37355 "EHLO
	mo00.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225619AbVDRO2N>;
	Mon, 18 Apr 2005 15:28:13 +0100
Received: MO(mo00)id j3IES9Pc013463; Mon, 18 Apr 2005 23:28:09 +0900 (JST)
Received: MDO(mdo00) id j3IES9ls016810; Mon, 18 Apr 2005 23:28:09 +0900 (JST)
Received: from stratos (64.43.138.210.xn.2iij.net [210.138.43.64])
	by mbox.iij4u.or.jp (4U-MR/mbox00) id j3IES71o018696
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NOT);
	Mon, 18 Apr 2005 23:28:08 +0900 (JST)
Date:	Mon, 18 Apr 2005 23:28:05 +0900
From:	Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 2.6] vr41xx: update init.c
Message-Id: <20050418232805.68e9828b.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7748
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

This patch had updated init.c for vr41xx.
 - add iomem resource init
 - add CP0 timer init
 - add clock frequency calculation

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff c-orig/arch/mips/vr41xx/common/init.c c/arch/mips/vr41xx/common/init.c
--- c-orig/arch/mips/vr41xx/common/init.c	Thu May 27 02:11:11 2004
+++ c/arch/mips/vr41xx/common/init.c	Sat Apr  9 23:42:40 2005
@@ -1,7 +1,7 @@
 /*
  *  init.c, Common initialization routines for NEC VR4100 series.
  *
- *  Copyright (C) 2003-2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *  Copyright (C) 2003-2005  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -18,9 +18,45 @@
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 #include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/irq.h>
 #include <linux/string.h>
 
 #include <asm/bootinfo.h>
+#include <asm/time.h>
+#include <asm/vr41xx/vr41xx.h>
+
+#define IO_MEM_RESOURCE_START	0UL
+#define IO_MEM_RESOURCE_END	0x1fffffffUL
+
+static void __init iomem_resource_init(void)
+{
+	iomem_resource.start = IO_MEM_RESOURCE_START;
+	iomem_resource.end = IO_MEM_RESOURCE_END;
+}
+
+static void __init setup_timer_frequency(void)
+{
+	unsigned long tclock;
+
+	tclock = vr41xx_get_tclock_frequency();
+	if (current_cpu_data.processor_id == PRID_VR4131_REV2_0 ||
+	    current_cpu_data.processor_id == PRID_VR4131_REV2_1)
+		mips_hpt_frequency = tclock / 2;
+	else
+		mips_hpt_frequency = tclock / 4;
+}
+
+static void __init setup_timer_irq(struct irqaction *irq)
+{
+	setup_irq(TIMER_IRQ, irq);
+}
+
+static void __init timer_init(void)
+{
+	board_time_init = setup_timer_frequency;
+	board_timer_setup = setup_timer_irq;
+}
 
 void __init prom_init(void)
 {
@@ -35,6 +71,12 @@
 		if (i < (argc - 1))
 			strcat(arcs_cmdline, " ");
 	}
+
+	vr41xx_calculate_clock_frequency();
+
+	timer_init();
+
+	iomem_resource_init();
 }
 
 unsigned long __init prom_free_prom_memory (void)
diff -urN -X dontdiff c-orig/include/asm-mips/vr41xx/vr41xx.h c/include/asm-mips/vr41xx/vr41xx.h
--- c-orig/include/asm-mips/vr41xx/vr41xx.h	Sat Apr  9 23:42:21 2005
+++ c/include/asm-mips/vr41xx/vr41xx.h	Sat Apr  9 23:43:22 2005
@@ -84,7 +84,7 @@
 #define INT2_CASCADE_IRQ	MIPS_CPU_IRQ(4)
 #define INT3_CASCADE_IRQ	MIPS_CPU_IRQ(5)
 #define INT4_CASCADE_IRQ	MIPS_CPU_IRQ(6)
-#define MIPS_COUNTER_IRQ	MIPS_CPU_IRQ(7)
+#define TIMER_IRQ		MIPS_CPU_IRQ(7)
 
 /* SYINT1 Interrupt Numbers */
 #define SYSINT1_IRQ_BASE	8
