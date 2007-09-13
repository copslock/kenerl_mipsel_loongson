Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Sep 2007 03:04:17 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:30733 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20024283AbXIMCEJ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 13 Sep 2007 03:04:09 +0100
Received: by mo.po.2iij.net (mo30) id l8D246XT063827; Thu, 13 Sep 2007 11:04:06 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (po-mbox300) id l8D244XV029841
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 13 Sep 2007 11:04:05 +0900
Message-Id: <200709130204.l8D244XV029841@po-mbox300.hop.2iij.net>
Date:	Thu, 13 Sep 2007 11:04:04 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips@linux-mips.org
Subject: [PATCH][MIPS] move i8259 functions to include/asm-mips/i8259.h
In-Reply-To: <20070913.003319.41011558.anemo@mba.ocn.ne.jp>
References: <20070912232333.22c4f7bb.yoichi_yuasa@tripeaks.co.jp>
	<20070913.003319.41011558.anemo@mba.ocn.ne.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16485
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

On Thu, 13 Sep 2007 00:33:19 +0900 (JST)
Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:

> 
> Please drop a comment in this part too.  The comment was there just
> because we had to drop "static" from mask_and_ack_8259A() at that
> time.

Thank you for your comment.
The patch was updated.

Yoichi

---

Move i8259 functions to include/asm-mips/i8259.h

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/kernel/i8259.c mips/arch/mips/kernel/i8259.c
--- mips-orig/arch/mips/kernel/i8259.c	2007-09-13 10:41:51.547222000 +0900
+++ mips/arch/mips/kernel/i8259.c	2007-09-13 10:40:21.973624000 +0900
@@ -30,8 +30,10 @@
 
 static int i8259A_auto_eoi = -1;
 DEFINE_SPINLOCK(i8259A_lock);
-/* some platforms call this... */
-void mask_and_ack_8259A(unsigned int);
+static void disable_8259A_irq(unsigned int irq);
+static void enable_8259A_irq(unsigned int irq);
+static void mask_and_ack_8259A(unsigned int irq);
+static void init_8259A(int auto_eoi);
 
 static struct irq_chip i8259A_chip = {
 	.name		= "XT-PIC",
@@ -53,7 +55,7 @@ static unsigned int cached_irq_mask = 0x
 #define cached_master_mask	(cached_irq_mask)
 #define cached_slave_mask	(cached_irq_mask >> 8)
 
-void disable_8259A_irq(unsigned int irq)
+static void disable_8259A_irq(unsigned int irq)
 {
 	unsigned int mask;
 	unsigned long flags;
@@ -69,7 +71,7 @@ void disable_8259A_irq(unsigned int irq)
 	spin_unlock_irqrestore(&i8259A_lock, flags);
 }
 
-void enable_8259A_irq(unsigned int irq)
+static void enable_8259A_irq(unsigned int irq)
 {
 	unsigned int mask;
 	unsigned long flags;
@@ -139,7 +141,7 @@ static inline int i8259A_irq_real(unsign
  * first, _then_ send the EOI, and the order of EOI
  * to the two 8259s is important!
  */
-void mask_and_ack_8259A(unsigned int irq)
+static void mask_and_ack_8259A(unsigned int irq)
 {
 	unsigned int irqmask;
 	unsigned long flags;
@@ -256,7 +258,7 @@ static int __init i8259A_init_sysfs(void
 
 device_initcall(i8259A_init_sysfs);
 
-void init_8259A(int auto_eoi)
+static void init_8259A(int auto_eoi)
 {
 	unsigned long flags;
 
diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/hw_irq.h mips/include/asm-mips/hw_irq.h
--- mips-orig/include/asm-mips/hw_irq.h	2007-09-13 10:41:51.559222750 +0900
+++ mips/include/asm-mips/hw_irq.h	2007-09-13 10:39:56.480030750 +0900
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
--- mips-orig/include/asm-mips/i8259.h	2007-09-13 10:41:51.575223750 +0900
+++ mips/include/asm-mips/i8259.h	2007-09-13 10:39:56.480030750 +0900
@@ -37,9 +37,8 @@
 
 extern spinlock_t i8259A_lock;
 
-extern void init_8259A(int auto_eoi);
-extern void enable_8259A_irq(unsigned int irq);
-extern void disable_8259A_irq(unsigned int irq);
+extern int i8259A_irq_pending(unsigned int irq);
+extern void make_8259A_irq(unsigned int irq);
 
 extern void init_i8259_irqs(void);
 
