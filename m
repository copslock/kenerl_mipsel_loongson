Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Apr 2005 16:02:25 +0100 (BST)
Received: from mo01.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:16595 "EHLO
	mo01.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225008AbVDLPCI>;
	Tue, 12 Apr 2005 16:02:08 +0100
Received: MO(mo01)id j3CF25h2007917; Wed, 13 Apr 2005 00:02:05 +0900 (JST)
Received: MDO(mdo00) id j3CF24ah002300; Wed, 13 Apr 2005 00:02:05 +0900 (JST)
Received: from stratos (64.43.138.210.xn.2iij.net [210.138.43.64])
	by mbox.iij4u.or.jp (4U-MR/mbox01) id j3CF23Gi023089
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NOT);
	Wed, 13 Apr 2005 00:02:04 +0900 (JST)
Date:	Wed, 13 Apr 2005 00:02:01 +0900
From:	Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 2.6] vr41xx: add resource management to cmu.c
Message-Id: <20050413000201.151293d3.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7705
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

This patch had added resource management to cmu.c.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff c-orig/arch/mips/vr41xx/common/cmu.c c/arch/mips/vr41xx/common/cmu.c
--- c-orig/arch/mips/vr41xx/common/cmu.c	Thu May 27 02:11:11 2004
+++ c/arch/mips/vr41xx/common/cmu.c	Sat Apr  9 18:27:02 2005
@@ -3,7 +3,7 @@
  *
  *  Copyright (C) 2001-2002  MontaVista Software Inc.
  *    Author: Yoichi Yuasa <yyuasa@mvista.com or source@mvista.com>
- *  Copuright (C) 2003-2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *  Copuright (C) 2003-2005  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -29,6 +29,8 @@
  *  - Added support for NEC VR4133.
  */
 #include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/module.h>
 #include <linux/smp.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
@@ -37,8 +39,16 @@
 #include <asm/io.h>
 #include <asm/vr41xx/vr41xx.h>
 
-#define CMUCLKMSK_TYPE1	KSEG1ADDR(0x0b000060)
-#define CMUCLKMSK_TYPE2	KSEG1ADDR(0x0f000060)
+#define CMU_TYPE1_BASE	0x0b000060UL
+#define CMU_TYPE1_SIZE	0x4
+
+#define CMU_TYPE2_BASE	0x0f000060UL
+#define CMU_TYPE2_SIZE	0x4
+
+#define CMU_TYPE3_BASE	0x0f000060UL
+#define CMU_TYPE3_SIZE	0x8
+
+#define CMUCLKMSK	0x0
  #define MSKPIU		0x0001
  #define MSKSIU		0x0002
  #define MSKAIU		0x0004
@@ -52,19 +62,17 @@
  #define MSKFFIR	0x0400
  #define MSKSCSI	0x1000
  #define MSKPPCIU	0x2000
-#define CMUCLKMSK2	KSEG1ADDR(0x0f000064)
+#define CMUCLKMSK2	0x4
  #define MSKCEU		0x0001
  #define MSKMAC0	0x0002
  #define MSKMAC1	0x0004
 
-static uint32_t cmu_base;
+static void __iomem *cmu_base;
 static uint16_t cmuclkmsk, cmuclkmsk2;
 static spinlock_t cmu_lock;
 
-#define read_cmuclkmsk()	readw(cmu_base)
-#define read_cmuclkmsk2()	readw(CMUCLKMSK2)
-#define write_cmuclkmsk()	writew(cmuclkmsk, cmu_base)
-#define write_cmuclkmsk2()	writew(cmuclkmsk2, CMUCLKMSK2)
+#define cmu_read(offset)		readw(cmu_base + (offset))
+#define cmu_write(offset, value)	writew((value), cmu_base + (offset))
 
 void vr41xx_supply_clock(vr41xx_clock_t clock)
 {
@@ -120,13 +128,15 @@
 
 	if (clock == CEU_CLOCK || clock == ETHER0_CLOCK ||
 	    clock == ETHER1_CLOCK)
-		write_cmuclkmsk2();
+		cmu_write(CMUCLKMSK2, cmuclkmsk2);
 	else
-		write_cmuclkmsk();
+		cmu_write(CMUCLKMSK, cmuclkmsk);
 
 	spin_unlock_irq(&cmu_lock);
 }
 
+EXPORT_SYMBOL_GPL(vr41xx_supply_clock);
+
 void vr41xx_mask_clock(vr41xx_clock_t clock)
 {
 	spin_lock_irq(&cmu_lock);
@@ -160,7 +170,7 @@
 		    current_cpu_data.cputype == CPU_VR4121) {
 			cmuclkmsk &= ~MSKDSIU;
 		} else {
-			if (cmuclkmsk & MSKSIU)
+			if (cmuclkmsk & MSKSSIU)
 				cmuclkmsk &= ~MSKDSIU;
 			else
 				cmuclkmsk &= ~(MSKSIU | MSKDSIU);
@@ -193,38 +203,55 @@
 
 	if (clock == CEU_CLOCK || clock == ETHER0_CLOCK ||
 	    clock == ETHER1_CLOCK)
-		write_cmuclkmsk2();
+		cmu_write(CMUCLKMSK2, cmuclkmsk2);
 	else
-		write_cmuclkmsk();
+		cmu_write(CMUCLKMSK, cmuclkmsk);
 
 	spin_unlock_irq(&cmu_lock);
 }
 
+EXPORT_SYMBOL_GPL(vr41xx_mask_clock);
+
 static int __init vr41xx_cmu_init(void)
 {
+	unsigned long start, size;
+
 	switch (current_cpu_data.cputype) {
         case CPU_VR4111:
         case CPU_VR4121:
-                cmu_base = CMUCLKMSK_TYPE1;
+		start = CMU_TYPE1_BASE;
+		size = CMU_TYPE1_SIZE;
                 break;
         case CPU_VR4122:
         case CPU_VR4131:
-                cmu_base = CMUCLKMSK_TYPE2;
-                break;
+		start = CMU_TYPE2_BASE;
+		size = CMU_TYPE2_SIZE;
+		break;
         case CPU_VR4133:
-                cmu_base = CMUCLKMSK_TYPE2;
-		cmuclkmsk2 = read_cmuclkmsk2();
+		start = CMU_TYPE3_BASE;
+		size = CMU_TYPE3_SIZE;
                 break;
 	default:
 		panic("Unexpected CPU of NEC VR4100 series");
 		break;
         }
 
-	cmuclkmsk = read_cmuclkmsk();
+	if (request_mem_region(start, size, "CMU") == NULL)
+		return -EBUSY;
+
+	cmu_base = ioremap(start, size);
+	if (cmu_base == NULL) {
+		release_mem_region(start, size);
+		return -EBUSY;
+	}
+
+	cmuclkmsk = cmu_read(CMUCLKMSK);
+	if (current_cpu_data.cputype == CPU_VR4133)
+		cmuclkmsk2 = cmu_read(CMUCLKMSK2);
 
 	spin_lock_init(&cmu_lock);
 
 	return 0;
 }
 
-early_initcall(vr41xx_cmu_init);
+core_initcall(vr41xx_cmu_init);
