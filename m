Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Nov 2007 09:44:10 +0000 (GMT)
Received: from mo32.po.2iij.NET ([210.128.50.17]:15434 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20021646AbXKIJoB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 9 Nov 2007 09:44:01 +0000
Received: by mo.po.2iij.net (mo32) id lA99gWXv095126; Fri, 9 Nov 2007 18:42:32 +0900 (JST)
Received: from localhost (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (po-mbox301) id lA99gVuY016643
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 9 Nov 2007 18:42:31 +0900
Date:	Fri, 9 Nov 2007 18:42:35 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] fix LASAT IRQ overlap
Message-Id: <20071109184235.d87433e6.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17455
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

The range of MIPS_CPU IRQ and the range of LASAT IRQ overlap.
This patch has fixed it.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/lasat/interrupt.c mips/arch/mips/lasat/interrupt.c
--- mips-orig/arch/mips/lasat/interrupt.c	2007-11-09 07:54:54.572826750 +0900
+++ mips/arch/mips/lasat/interrupt.c	2007-11-09 08:15:06.752835750 +0900
@@ -19,17 +19,14 @@
  * Lasat boards.
  */
 #include <linux/init.h>
-#include <linux/irq.h>
-#include <linux/sched.h>
-#include <linux/slab.h>
 #include <linux/interrupt.h>
-#include <linux/kernel_stat.h>
+#include <linux/irq.h>
 
 #include <asm/bootinfo.h>
 #include <asm/irq_cpu.h>
 #include <asm/lasat/lasatint.h>
-#include <asm/time.h>
-#include <asm/gdb-stub.h>
+
+#include <irq.h>
 
 static volatile int *lasat_int_status;
 static volatile int *lasat_int_mask;
@@ -97,12 +94,18 @@ asmlinkage void plat_irq_dispatch(void)
 
 	/* if int_status == 0, then the interrupt has already been cleared */
 	if (int_status) {
-		irq = LASATINT_BASE + ls1bit32(int_status);
+		irq = LASAT_IRQ_BASE + ls1bit32(int_status);
 
 		do_IRQ(irq);
 	}
 }
 
+static struct irqaction cascade = {
+	.handler	= no_action,
+	.mask		= CPU_MASK_NONE,
+	.name		= "cascade",
+};
+
 void __init arch_init_irq(void)
 {
 	int i;
@@ -127,6 +130,9 @@ void __init arch_init_irq(void)
 	}
 
 	mips_cpu_irq_init();
-	for (i = LASATINT_BASE; i <= LASATINT_END; i++)
+
+	for (i = LASAT_IRQ_BASE; i <= LASAT_IRQ_END; i++)
 		set_irq_chip_and_handler(i, &lasat_irq_type, handle_level_irq);
+
+	setup_irq(LASAT_CASCADE_IRQ, &cascade);
 }
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/pci/pci-lasat.c mips/arch/mips/pci/pci-lasat.c
--- mips-orig/arch/mips/pci/pci-lasat.c	2007-11-09 07:54:55.596890750 +0900
+++ mips/arch/mips/pci/pci-lasat.c	2007-11-09 08:33:30.421810750 +0900
@@ -5,12 +5,14 @@
  *
  * Copyright (C) 2000, 2001, 04 Keith M Wesolowski
  */
-#include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/types.h>
+
 #include <asm/bootinfo.h>
-#include <asm/lasat/lasatint.h>
+
+#include <irq.h>
 
 extern struct pci_ops nile4_pci_ops;
 extern struct pci_ops gt64xxx_pci0_ops;
@@ -55,15 +57,15 @@ static int __init lasat_pci_setup(void)
 
 arch_initcall(lasat_pci_setup);
 
-#define LASATINT_ETH1   (LASATINT_BASE + 0)
-#define LASATINT_ETH0   (LASATINT_BASE + 1)
-#define LASATINT_HDC    (LASATINT_BASE + 2)
-#define LASATINT_COMP   (LASATINT_BASE + 3)
-#define LASATINT_HDLC   (LASATINT_BASE + 4)
-#define LASATINT_PCIA   (LASATINT_BASE + 5)
-#define LASATINT_PCIB   (LASATINT_BASE + 6)
-#define LASATINT_PCIC   (LASATINT_BASE + 7)
-#define LASATINT_PCID   (LASATINT_BASE + 8)
+#define LASAT_IRQ_ETH1   (LASAT_IRQ_BASE + 0)
+#define LASAT_IRQ_ETH0   (LASAT_IRQ_BASE + 1)
+#define LASAT_IRQ_HDC    (LASAT_IRQ_BASE + 2)
+#define LASAT_IRQ_COMP   (LASAT_IRQ_BASE + 3)
+#define LASAT_IRQ_HDLC   (LASAT_IRQ_BASE + 4)
+#define LASAT_IRQ_PCIA   (LASAT_IRQ_BASE + 5)
+#define LASAT_IRQ_PCIB   (LASAT_IRQ_BASE + 6)
+#define LASAT_IRQ_PCIC   (LASAT_IRQ_BASE + 7)
+#define LASAT_IRQ_PCID   (LASAT_IRQ_BASE + 8)
 
 int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
@@ -71,13 +73,13 @@ int __init pcibios_map_irq(const struct 
 	case 1:
 	case 2:
 	case 3:
-		return LASATINT_PCIA + (((slot-1) + (pin-1)) % 4);
+		return LASAT_IRQ_PCIA + (((slot-1) + (pin-1)) % 4);
 	case 4:
-		return LASATINT_ETH1;   /* Ethernet 1 (LAN 2) */
+		return LASAT_IRQ_ETH1;   /* Ethernet 1 (LAN 2) */
 	case 5:
-		return LASATINT_ETH0;   /* Ethernet 0 (LAN 1) */
+		return LASAT_IRQ_ETH0;   /* Ethernet 0 (LAN 1) */
 	case 6:
-		return LASATINT_HDC;    /* IDE controller */
+		return LASAT_IRQ_HDC;    /* IDE controller */
 	default:
 		return 0xff;            /* Illegal */
 	}
diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/lasat/lasatint.h mips/include/asm-mips/lasat/lasatint.h
--- mips-orig/include/asm-mips/lasat/lasatint.h	2007-11-09 07:57:42.283308000 +0900
+++ mips/include/asm-mips/lasat/lasatint.h	2007-11-09 08:04:47.862157500 +0900
@@ -1,11 +1,6 @@
 #ifndef __ASM_LASAT_LASATINT_H
 #define __ASM_LASAT_LASATINT_H
 
-#include <linux/irq.h>
-
-#define LASATINT_BASE	MIPS_CPU_IRQ_BASE
-#define LASATINT_END	(LASATINT_BASE + 16)
-
 /* lasat 100 */
 #define LASAT_INT_STATUS_REG_100	(KSEG1ADDR(0x1c880000))
 #define LASAT_INT_MASK_REG_100		(KSEG1ADDR(0x1c890000))
diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/mach-lasat/irq.h mips/include/asm-mips/mach-lasat/irq.h
--- mips-orig/include/asm-mips/mach-lasat/irq.h	1970-01-01 09:00:00.000000000 +0900
+++ mips/include/asm-mips/mach-lasat/irq.h	2007-11-09 08:13:55.012352250 +0900
@@ -0,0 +1,13 @@
+#ifndef _ASM_MACH_LASAT_IRQ_H
+#define _ASM_MACH_LASAT_IRQ_H
+
+#define LASAT_CASCADE_IRQ	(MIPS_CPU_IRQ_BASE + 0)
+
+#define LASAT_IRQ_BASE		8
+#define LASAT_IRQ_END		23
+
+#define NR_IRQS			24
+
+#include_next <irq.h>
+
+#endif /* _ASM_MACH_LASAT_IRQ_H */
