Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Sep 2007 15:25:06 +0100 (BST)
Received: from mo31.po.2iij.NET ([210.128.50.54]:48396 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20022730AbXILOY4 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 12 Sep 2007 15:24:56 +0100
Received: by mo.po.2iij.net (mo31) id l8CENc76010261; Wed, 12 Sep 2007 23:23:38 +0900 (JST)
Received: from localhost.localdomain (221.25.30.125.dy.iij4u.or.jp [125.30.25.221])
	by mbox.po.2iij.net (po-mbox303) id l8CENYte011008
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 12 Sep 2007 23:23:34 +0900
Date:	Wed, 12 Sep 2007 23:23:33 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] move i8259 functions to include/asm-mips/i8259.h
Message-Id: <20070912232333.22c4f7bb.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16472
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Move i8259 functions to include/asm-mips/i8259.h

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/kernel/i8259.c mips/arch/mips/kernel/i8259.c
--- mips-orig/arch/mips/kernel/i8259.c	2007-09-12 14:37:15.447287000 +0900
+++ mips/arch/mips/kernel/i8259.c	2007-09-12 14:26:42.007699500 +0900
@@ -31,7 +31,10 @@
 static int i8259A_auto_eoi = -1;
 DEFINE_SPINLOCK(i8259A_lock);
 /* some platforms call this... */
-void mask_and_ack_8259A(unsigned int);
+static void disable_8259A_irq(unsigned int irq);
+static void enable_8259A_irq(unsigned int irq);
+static void mask_and_ack_8259A(unsigned int irq);
+static void init_8259A(int auto_eoi);
 
 static struct irq_chip i8259A_chip = {
 	.name		= "XT-PIC",
@@ -53,7 +56,7 @@ static unsigned int cached_irq_mask = 0x
 #define cached_master_mask	(cached_irq_mask)
 #define cached_slave_mask	(cached_irq_mask >> 8)
 
-void disable_8259A_irq(unsigned int irq)
+static void disable_8259A_irq(unsigned int irq)
 {
 	unsigned int mask;
 	unsigned long flags;
@@ -69,7 +72,7 @@ void disable_8259A_irq(unsigned int irq)
 	spin_unlock_irqrestore(&i8259A_lock, flags);
 }
 
-void enable_8259A_irq(unsigned int irq)
+static void enable_8259A_irq(unsigned int irq)
 {
 	unsigned int mask;
 	unsigned long flags;
@@ -139,7 +142,7 @@ static inline int i8259A_irq_real(unsign
  * first, _then_ send the EOI, and the order of EOI
  * to the two 8259s is important!
  */
-void mask_and_ack_8259A(unsigned int irq)
+static void mask_and_ack_8259A(unsigned int irq)
 {
 	unsigned int irqmask;
 	unsigned long flags;
@@ -256,7 +259,7 @@ static int __init i8259A_init_sysfs(void
 
 device_initcall(i8259A_init_sysfs);
 
-void init_8259A(int auto_eoi)
+static void init_8259A(int auto_eoi)
 {
 	unsigned long flags;
 
diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/hw_irq.h mips/include/asm-mips/hw_irq.h
--- mips-orig/include/asm-mips/hw_irq.h	2007-09-12 14:37:15.459287750 +0900
+++ mips/include/asm-mips/hw_irq.h	2007-09-12 14:26:01.485167000 +0900
@@ -8,15 +8,8 @@
 #ifndef __ASM_HW_IRQ_H
 #define __ASM_HW_IRQ_H
 
-#include <linux/profile.h>
 #include <asm/atomic.h>
 
-extern void disable_8259A_irq(unsigned int irq);
-extern void enable_8259A_irq(unsigned int irq);
-extern int i8259A_irq_pending(unsigned int irq);
-extern void make_8259A_irq(unsigned int irq);
-extern void init_8259A(int aeoi);
-
 extern atomic_t irq_err_count;
 
 /*
diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/i8259.h mips/include/asm-mips/i8259.h
--- mips-orig/include/asm-mips/i8259.h	2007-09-12 14:37:15.475288750 +0900
+++ mips/include/asm-mips/i8259.h	2007-09-12 14:26:01.485167000 +0900
@@ -37,9 +37,8 @@
 
 extern spinlock_t i8259A_lock;
 
-extern void init_8259A(int auto_eoi);
-extern void enable_8259A_irq(unsigned int irq);
-extern void disable_8259A_irq(unsigned int irq);
+extern int i8259A_irq_pending(unsigned int irq);
+extern void make_8259A_irq(unsigned int irq);
 
 extern void init_i8259_irqs(void);
 
