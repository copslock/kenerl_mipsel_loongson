Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Nov 2006 17:06:26 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:30960 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20039292AbWKARGT (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 1 Nov 2006 17:06:19 +0000
Received: from localhost (p4119-ipad201funabasi.chiba.ocn.ne.jp [222.146.67.119])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP id B0F4FA766
	for <linux-mips@linux-mips.org>; Thu,  2 Nov 2006 02:06:05 +0900 (JST)
Date:	Thu, 02 Nov 2006 02:08:36 +0900 (JST)
Message-Id: <20061102.020836.25912635.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Subject: [PATCH] mips irq cleanups
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13137
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

This is a big irq cleanup patch.

* Use set_irq_chip() to register irq_chip.
* Initialize .mask, .unmask, .mask_ack field.  Functions for these
  method are already exist in most case.
* Do not initialize .startup, .shutdown, .enable, .disable fields if
  default routines provided by irq_chip_set_defaults() were suitable.
* Remove redundant irq_desc initializations.
* Remove unnecessary local_irq_save/local_irq_restore, spin_lock.

With this cleanup, it would be easy to switch to slightly lightwait
irq flow handlers (handle_level_irq(), etc.) instead of __do_IRQ().

Though whole this patch is quite large, changes in each irq_chip are
not quite simple.  Please review and test on your platform.  Thanks.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

 arch/mips/au1000/common/irq.c                            |   63 +----
 arch/mips/ddb5xxx/ddb5477/irq_5477.c                     |   23 -
 arch/mips/dec/ecc-berr.c                                 |    6 
 arch/mips/dec/ioasic-irq.c                               |   72 +----
 arch/mips/dec/kn02-irq.c                                 |   53 ----
 arch/mips/emma2rh/common/irq_emma2rh.c                   |   34 --
 arch/mips/emma2rh/markeins/irq_markeins.c                |   55 ----
 arch/mips/gt64120/ev64120/irq.c                          |   40 ---
 arch/mips/jazz/irq.c                                     |   27 --
 arch/mips/jmr3927/rbhma3100/irq.c                        |   32 --
 arch/mips/kernel/i8259.c                                 |   21 -
 arch/mips/kernel/irq-msc01.c                             |   45 ---
 arch/mips/kernel/irq-mv6434x.c                           |   53 ----
 arch/mips/kernel/irq-rm7000.c                            |   53 ----
 arch/mips/kernel/irq-rm9000.c                            |   45 ---
 arch/mips/kernel/irq.c                                   |   13 -
 arch/mips/kernel/irq_cpu.c                               |   64 -----
 arch/mips/lasat/interrupt.c                              |   36 --
 arch/mips/mips-boards/atlas/atlas_int.c                  |   28 --
 arch/mips/momentum/ocelot_c/cpci-irq.c                   |   53 ----
 arch/mips/momentum/ocelot_c/uart-irq.c                   |   56 ----
 arch/mips/philips/pnx8550/common/int.c                   |   66 -----
 arch/mips/sgi-ip22/ip22-eisa.c                           |   33 --
 arch/mips/sgi-ip22/ip22-int.c                            |  109 +-------
 arch/mips/sgi-ip27/ip27-irq.c                            |   17 -
 arch/mips/sgi-ip27/ip27-timer.c                          |   27 --
 arch/mips/sgi-ip32/ip32-irq.c                            |  133 +---------
 arch/mips/sibyte/bcm1480/irq.c                           |   30 --
 arch/mips/sibyte/sb1250/irq.c                            |   30 --
 arch/mips/sni/irq.c                                      |   40 ---
 arch/mips/tx4927/common/tx4927_irq.c                     |  162 -------------
 arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c |  183 ---------------
 arch/mips/tx4938/common/irq.c                            |  113 ---------
 arch/mips/tx4938/toshiba_rbtx4938/irq.c                  |   53 ----
 arch/mips/vr41xx/common/icu.c                            |   46 ---
 arch/mips/vr41xx/nec-cmbvr4133/irq.c                     |   20 -
 include/asm-mips/dec/kn02.h                              |    2 
 37 files changed, 289 insertions(+), 1647 deletions(-)

diff --git a/arch/mips/au1000/common/irq.c b/arch/mips/au1000/common/irq.c
index 2abe132..9cf7b67 100644
--- a/arch/mips/au1000/common/irq.c
+++ b/arch/mips/au1000/common/irq.c
@@ -70,7 +70,6 @@ extern irq_cpustat_t irq_stat [NR_CPUS];
 extern void mips_timer_interrupt(void);
 
 static void setup_local_irq(unsigned int irq, int type, int int_req);
-static unsigned int startup_irq(unsigned int irq);
 static void end_irq(unsigned int irq_nr);
 static inline void mask_and_ack_level_irq(unsigned int irq_nr);
 static inline void mask_and_ack_rise_edge_irq(unsigned int irq_nr);
@@ -84,20 +83,6 @@ void	(*board_init_irq)(void);
 static DEFINE_SPINLOCK(irq_lock);
 
 
-static unsigned int startup_irq(unsigned int irq_nr)
-{
-	local_enable_irq(irq_nr);
-	return 0;
-}
-
-
-static void shutdown_irq(unsigned int irq_nr)
-{
-	local_disable_irq(irq_nr);
-	return;
-}
-
-
 inline void local_enable_irq(unsigned int irq_nr)
 {
 	if (irq_nr > AU1000_LAST_INTC0_INT) {
@@ -249,41 +234,37 @@ void restore_local_and_enable(int contro
 
 static struct irq_chip rise_edge_irq_type = {
 	.typename = "Au1000 Rise Edge",
-	.startup = startup_irq,
-	.shutdown = shutdown_irq,
-	.enable = local_enable_irq,
-	.disable = local_disable_irq,
 	.ack = mask_and_ack_rise_edge_irq,
+	.mask = local_disable_irq,
+	.mask_ack = mask_and_ack_rise_edge_irq,
+	.unmask = local_enable_irq,
 	.end = end_irq,
 };
 
 static struct irq_chip fall_edge_irq_type = {
 	.typename = "Au1000 Fall Edge",
-	.startup = startup_irq,
-	.shutdown = shutdown_irq,
-	.enable = local_enable_irq,
-	.disable = local_disable_irq,
 	.ack = mask_and_ack_fall_edge_irq,
+	.mask = local_disable_irq,
+	.mask_ack = mask_and_ack_fall_edge_irq,
+	.unmask = local_enable_irq,
 	.end = end_irq,
 };
 
 static struct irq_chip either_edge_irq_type = {
 	.typename = "Au1000 Rise or Fall Edge",
-	.startup = startup_irq,
-	.shutdown = shutdown_irq,
-	.enable = local_enable_irq,
-	.disable = local_disable_irq,
 	.ack = mask_and_ack_either_edge_irq,
+	.mask = local_disable_irq,
+	.mask_ack = mask_and_ack_either_edge_irq,
+	.unmask = local_enable_irq,
 	.end = end_irq,
 };
 
 static struct irq_chip level_irq_type = {
 	.typename = "Au1000 Level",
-	.startup = startup_irq,
-	.shutdown = shutdown_irq,
-	.enable = local_enable_irq,
-	.disable = local_disable_irq,
 	.ack = mask_and_ack_level_irq,
+	.mask = local_disable_irq,
+	.mask_ack = mask_and_ack_level_irq,
+	.unmask = local_enable_irq,
 	.end = end_irq,
 };
 
@@ -328,31 +309,31 @@ static void setup_local_irq(unsigned int
 				au_writel(1<<(irq_nr-32), IC1_CFG2CLR);
 				au_writel(1<<(irq_nr-32), IC1_CFG1CLR);
 				au_writel(1<<(irq_nr-32), IC1_CFG0SET);
-				irq_desc[irq_nr].chip = &rise_edge_irq_type;
+				set_irq_chip(irq_nr, &rise_edge_irq_type);
 				break;
 			case INTC_INT_FALL_EDGE: /* 0:1:0 */
 				au_writel(1<<(irq_nr-32), IC1_CFG2CLR);
 				au_writel(1<<(irq_nr-32), IC1_CFG1SET);
 				au_writel(1<<(irq_nr-32), IC1_CFG0CLR);
-				irq_desc[irq_nr].chip = &fall_edge_irq_type;
+				set_irq_chip(irq_nr, &fall_edge_irq_type);
 				break;
 			case INTC_INT_RISE_AND_FALL_EDGE: /* 0:1:1 */
 				au_writel(1<<(irq_nr-32), IC1_CFG2CLR);
 				au_writel(1<<(irq_nr-32), IC1_CFG1SET);
 				au_writel(1<<(irq_nr-32), IC1_CFG0SET);
-				irq_desc[irq_nr].chip = &either_edge_irq_type;
+				set_irq_chip(irq_nr, &either_edge_irq_type);
 				break;
 			case INTC_INT_HIGH_LEVEL: /* 1:0:1 */
 				au_writel(1<<(irq_nr-32), IC1_CFG2SET);
 				au_writel(1<<(irq_nr-32), IC1_CFG1CLR);
 				au_writel(1<<(irq_nr-32), IC1_CFG0SET);
-				irq_desc[irq_nr].chip = &level_irq_type;
+				set_irq_chip(irq_nr, &level_irq_type);
 				break;
 			case INTC_INT_LOW_LEVEL: /* 1:1:0 */
 				au_writel(1<<(irq_nr-32), IC1_CFG2SET);
 				au_writel(1<<(irq_nr-32), IC1_CFG1SET);
 				au_writel(1<<(irq_nr-32), IC1_CFG0CLR);
-				irq_desc[irq_nr].chip = &level_irq_type;
+				set_irq_chip(irq_nr, &level_irq_type);
 				break;
 			case INTC_INT_DISABLED: /* 0:0:0 */
 				au_writel(1<<(irq_nr-32), IC1_CFG0CLR);
@@ -380,31 +361,31 @@ static void setup_local_irq(unsigned int
 				au_writel(1<<irq_nr, IC0_CFG2CLR);
 				au_writel(1<<irq_nr, IC0_CFG1CLR);
 				au_writel(1<<irq_nr, IC0_CFG0SET);
-				irq_desc[irq_nr].chip = &rise_edge_irq_type;
+				set_irq_chip(irq_nr, &rise_edge_irq_type);
 				break;
 			case INTC_INT_FALL_EDGE: /* 0:1:0 */
 				au_writel(1<<irq_nr, IC0_CFG2CLR);
 				au_writel(1<<irq_nr, IC0_CFG1SET);
 				au_writel(1<<irq_nr, IC0_CFG0CLR);
-				irq_desc[irq_nr].chip = &fall_edge_irq_type;
+				set_irq_chip(irq_nr, &fall_edge_irq_type);
 				break;
 			case INTC_INT_RISE_AND_FALL_EDGE: /* 0:1:1 */
 				au_writel(1<<irq_nr, IC0_CFG2CLR);
 				au_writel(1<<irq_nr, IC0_CFG1SET);
 				au_writel(1<<irq_nr, IC0_CFG0SET);
-				irq_desc[irq_nr].chip = &either_edge_irq_type;
+				set_irq_chip(irq_nr, &either_edge_irq_type);
 				break;
 			case INTC_INT_HIGH_LEVEL: /* 1:0:1 */
 				au_writel(1<<irq_nr, IC0_CFG2SET);
 				au_writel(1<<irq_nr, IC0_CFG1CLR);
 				au_writel(1<<irq_nr, IC0_CFG0SET);
-				irq_desc[irq_nr].chip = &level_irq_type;
+				set_irq_chip(irq_nr, &level_irq_type);
 				break;
 			case INTC_INT_LOW_LEVEL: /* 1:1:0 */
 				au_writel(1<<irq_nr, IC0_CFG2SET);
 				au_writel(1<<irq_nr, IC0_CFG1SET);
 				au_writel(1<<irq_nr, IC0_CFG0CLR);
-				irq_desc[irq_nr].chip = &level_irq_type;
+				set_irq_chip(irq_nr, &level_irq_type);
 				break;
 			case INTC_INT_DISABLED: /* 0:0:0 */
 				au_writel(1<<irq_nr, IC0_CFG0CLR);
diff --git a/arch/mips/ddb5xxx/ddb5477/irq_5477.c b/arch/mips/ddb5xxx/ddb5477/irq_5477.c
index ba52705..96249aa 100644
--- a/arch/mips/ddb5xxx/ddb5477/irq_5477.c
+++ b/arch/mips/ddb5xxx/ddb5477/irq_5477.c
@@ -53,14 +53,6 @@ vrc5477_irq_disable(unsigned int irq)
 	ll_vrc5477_irq_disable(irq - vrc5477_irq_base);
 }
 
-static unsigned int vrc5477_irq_startup(unsigned int irq)
-{
-	vrc5477_irq_enable(irq);
-	return 0;
-}
-
-#define	vrc5477_irq_shutdown	vrc5477_irq_disable
-
 static void
 vrc5477_irq_ack(unsigned int irq)
 {
@@ -91,11 +83,10 @@ vrc5477_irq_end(unsigned int irq)
 
 struct irq_chip vrc5477_irq_controller = {
 	.typename = "vrc5477_irq",
-	.startup = vrc5477_irq_startup,
-	.shutdown = vrc5477_irq_shutdown,
-	.enable = vrc5477_irq_enable,
-	.disable = vrc5477_irq_disable,
 	.ack = vrc5477_irq_ack,
+	.mask = vrc5477_irq_disable,
+	.mask_ack = vrc5477_irq_ack,
+	.unmask = vrc5477_irq_enable,
 	.end = vrc5477_irq_end
 };
 
@@ -103,12 +94,8 @@ void __init vrc5477_irq_init(u32 irq_bas
 {
 	u32 i;
 
-	for (i= irq_base; i< irq_base+ NUM_5477_IRQ; i++) {
-		irq_desc[i].status = IRQ_DISABLED;
-		irq_desc[i].action = NULL;
-		irq_desc[i].depth = 1;
-		irq_desc[i].chip = &vrc5477_irq_controller;
-	}
+	for (i= irq_base; i< irq_base+ NUM_5477_IRQ; i++)
+		set_irq_chip(i, &vrc5477_irq_controller);
 
 	vrc5477_irq_base = irq_base;
 }
diff --git a/arch/mips/dec/ecc-berr.c b/arch/mips/dec/ecc-berr.c
index 3e374d0..c8430c0 100644
--- a/arch/mips/dec/ecc-berr.c
+++ b/arch/mips/dec/ecc-berr.c
@@ -18,7 +18,6 @@ #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
-#include <linux/spinlock.h>
 #include <linux/types.h>
 
 #include <asm/addrspace.h>
@@ -231,13 +230,10 @@ irqreturn_t dec_ecc_be_interrupt(int irq
 static inline void dec_kn02_be_init(void)
 {
 	volatile u32 *csr = (void *)CKSEG1ADDR(KN02_SLOT_BASE + KN02_CSR);
-	unsigned long flags;
 
 	kn0x_erraddr = (void *)CKSEG1ADDR(KN02_SLOT_BASE + KN02_ERRADDR);
 	kn0x_chksyn = (void *)CKSEG1ADDR(KN02_SLOT_BASE + KN02_CHKSYN);
 
-	spin_lock_irqsave(&kn02_lock, flags);
-
 	/* Preset write-only bits of the Control Register cache. */
 	cached_kn02_csr = *csr | KN02_CSR_LEDS;
 
@@ -247,8 +243,6 @@ static inline void dec_kn02_be_init(void
 	cached_kn02_csr |= KN02_CSR_CORRECT;
 	*csr = cached_kn02_csr;
 	iob();
-
-	spin_unlock_irqrestore(&kn02_lock, flags);
 }
 
 static inline void dec_kn03_be_init(void)
diff --git a/arch/mips/dec/ioasic-irq.c b/arch/mips/dec/ioasic-irq.c
index 41cd2a9..d0af08b 100644
--- a/arch/mips/dec/ioasic-irq.c
+++ b/arch/mips/dec/ioasic-irq.c
@@ -13,7 +13,6 @@
 
 #include <linux/init.h>
 #include <linux/irq.h>
-#include <linux/spinlock.h>
 #include <linux/types.h>
 
 #include <asm/dec/ioasic.h>
@@ -21,8 +20,6 @@ #include <asm/dec/ioasic_addrs.h>
 #include <asm/dec/ioasic_ints.h>
 
 
-static DEFINE_SPINLOCK(ioasic_lock);
-
 static int ioasic_irq_base;
 
 
@@ -52,65 +49,31 @@ static inline void clear_ioasic_irq(unsi
 	ioasic_write(IO_REG_SIR, sir);
 }
 
-static inline void enable_ioasic_irq(unsigned int irq)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&ioasic_lock, flags);
-	unmask_ioasic_irq(irq);
-	spin_unlock_irqrestore(&ioasic_lock, flags);
-}
-
-static inline void disable_ioasic_irq(unsigned int irq)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&ioasic_lock, flags);
-	mask_ioasic_irq(irq);
-	spin_unlock_irqrestore(&ioasic_lock, flags);
-}
-
-
-static inline unsigned int startup_ioasic_irq(unsigned int irq)
-{
-	enable_ioasic_irq(irq);
-	return 0;
-}
-
-#define shutdown_ioasic_irq disable_ioasic_irq
-
 static inline void ack_ioasic_irq(unsigned int irq)
 {
-	spin_lock(&ioasic_lock);
 	mask_ioasic_irq(irq);
-	spin_unlock(&ioasic_lock);
 	fast_iob();
 }
 
 static inline void end_ioasic_irq(unsigned int irq)
 {
 	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
-		enable_ioasic_irq(irq);
+		unmask_ioasic_irq(irq);
 }
 
 static struct irq_chip ioasic_irq_type = {
 	.typename = "IO-ASIC",
-	.startup = startup_ioasic_irq,
-	.shutdown = shutdown_ioasic_irq,
-	.enable = enable_ioasic_irq,
-	.disable = disable_ioasic_irq,
 	.ack = ack_ioasic_irq,
+	.mask = mask_ioasic_irq,
+	.mask_ack = ack_ioasic_irq,
+	.unmask = unmask_ioasic_irq,
 	.end = end_ioasic_irq,
 };
 
 
-#define startup_ioasic_dma_irq startup_ioasic_irq
-
-#define shutdown_ioasic_dma_irq shutdown_ioasic_irq
-
-#define enable_ioasic_dma_irq enable_ioasic_irq
+#define unmask_ioasic_dma_irq unmask_ioasic_irq
 
-#define disable_ioasic_dma_irq disable_ioasic_irq
+#define mask_ioasic_dma_irq mask_ioasic_irq
 
 #define ack_ioasic_dma_irq ack_ioasic_irq
 
@@ -123,11 +86,10 @@ static inline void end_ioasic_dma_irq(un
 
 static struct irq_chip ioasic_dma_irq_type = {
 	.typename = "IO-ASIC-DMA",
-	.startup = startup_ioasic_dma_irq,
-	.shutdown = shutdown_ioasic_dma_irq,
-	.enable = enable_ioasic_dma_irq,
-	.disable = disable_ioasic_dma_irq,
 	.ack = ack_ioasic_dma_irq,
+	.mask = mask_ioasic_dma_irq,
+	.mask_ack = ack_ioasic_dma_irq,
+	.unmask = unmask_ioasic_dma_irq,
 	.end = end_ioasic_dma_irq,
 };
 
@@ -140,18 +102,10 @@ void __init init_ioasic_irqs(int base)
 	ioasic_write(IO_REG_SIMR, 0);
 	fast_iob();
 
-	for (i = base; i < base + IO_INR_DMA; i++) {
-		irq_desc[i].status = IRQ_DISABLED;
-		irq_desc[i].action = 0;
-		irq_desc[i].depth = 1;
-		irq_desc[i].chip = &ioasic_irq_type;
-	}
-	for (; i < base + IO_IRQ_LINES; i++) {
-		irq_desc[i].status = IRQ_DISABLED;
-		irq_desc[i].action = 0;
-		irq_desc[i].depth = 1;
-		irq_desc[i].chip = &ioasic_dma_irq_type;
-	}
+	for (i = base; i < base + IO_INR_DMA; i++)
+		set_irq_chip(i, &ioasic_irq_type);
+	for (; i < base + IO_IRQ_LINES; i++)
+		set_irq_chip(i, &ioasic_dma_irq_type);
 
 	ioasic_irq_base = base;
 }
diff --git a/arch/mips/dec/kn02-irq.c b/arch/mips/dec/kn02-irq.c
index 04a367a..c761d97 100644
--- a/arch/mips/dec/kn02-irq.c
+++ b/arch/mips/dec/kn02-irq.c
@@ -14,7 +14,6 @@
 
 #include <linux/init.h>
 #include <linux/irq.h>
-#include <linux/spinlock.h>
 #include <linux/types.h>
 
 #include <asm/dec/kn02.h>
@@ -29,7 +28,6 @@ #include <asm/dec/kn02.h>
  * There is no default value -- it has to be initialized.
  */
 u32 cached_kn02_csr;
-DEFINE_SPINLOCK(kn02_lock);
 
 
 static int kn02_irq_base;
@@ -53,54 +51,24 @@ static inline void mask_kn02_irq(unsigne
 	*csr = cached_kn02_csr;
 }
 
-static inline void enable_kn02_irq(unsigned int irq)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&kn02_lock, flags);
-	unmask_kn02_irq(irq);
-	spin_unlock_irqrestore(&kn02_lock, flags);
-}
-
-static inline void disable_kn02_irq(unsigned int irq)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&kn02_lock, flags);
-	mask_kn02_irq(irq);
-	spin_unlock_irqrestore(&kn02_lock, flags);
-}
-
-
-static unsigned int startup_kn02_irq(unsigned int irq)
-{
-	enable_kn02_irq(irq);
-	return 0;
-}
-
-#define shutdown_kn02_irq disable_kn02_irq
-
 static void ack_kn02_irq(unsigned int irq)
 {
-	spin_lock(&kn02_lock);
 	mask_kn02_irq(irq);
-	spin_unlock(&kn02_lock);
 	iob();
 }
 
 static void end_kn02_irq(unsigned int irq)
 {
 	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
-		enable_kn02_irq(irq);
+		unmask_kn02_irq(irq);
 }
 
 static struct irq_chip kn02_irq_type = {
 	.typename = "KN02-CSR",
-	.startup = startup_kn02_irq,
-	.shutdown = shutdown_kn02_irq,
-	.enable = enable_kn02_irq,
-	.disable = disable_kn02_irq,
 	.ack = ack_kn02_irq,
+	.mask = mask_kn02_irq,
+	.mask_ack = ack_kn02_irq,
+	.unmask = unmask_kn02_irq,
 	.end = end_kn02_irq,
 };
 
@@ -109,22 +77,15 @@ void __init init_kn02_irqs(int base)
 {
 	volatile u32 *csr = (volatile u32 *)CKSEG1ADDR(KN02_SLOT_BASE +
 						       KN02_CSR);
-	unsigned long flags;
 	int i;
 
 	/* Mask interrupts. */
-	spin_lock_irqsave(&kn02_lock, flags);
 	cached_kn02_csr &= ~KN02_CSR_IOINTEN;
 	*csr = cached_kn02_csr;
 	iob();
-	spin_unlock_irqrestore(&kn02_lock, flags);
-
-	for (i = base; i < base + KN02_IRQ_LINES; i++) {
-		irq_desc[i].status = IRQ_DISABLED;
-		irq_desc[i].action = 0;
-		irq_desc[i].depth = 1;
-		irq_desc[i].chip = &kn02_irq_type;
-	}
+
+	for (i = base; i < base + KN02_IRQ_LINES; i++)
+		set_irq_chip(i, &kn02_irq_type);
 
 	kn02_irq_base = base;
 }
diff --git a/arch/mips/emma2rh/common/irq_emma2rh.c b/arch/mips/emma2rh/common/irq_emma2rh.c
index 197ed4c..bf1b83b 100644
--- a/arch/mips/emma2rh/common/irq_emma2rh.c
+++ b/arch/mips/emma2rh/common/irq_emma2rh.c
@@ -56,22 +56,6 @@ static void emma2rh_irq_disable(unsigned
 	ll_emma2rh_irq_disable(irq - emma2rh_irq_base);
 }
 
-static unsigned int emma2rh_irq_startup(unsigned int irq)
-{
-	emma2rh_irq_enable(irq);
-	return 0;
-}
-
-#define	emma2rh_irq_shutdown	emma2rh_irq_disable
-
-static void emma2rh_irq_ack(unsigned int irq)
-{
-	/* disable interrupt - some handler will re-enable the irq
-	 * and if the interrupt is leveled, we will have infinite loop
-	 */
-	ll_emma2rh_irq_disable(irq - emma2rh_irq_base);
-}
-
 static void emma2rh_irq_end(unsigned int irq)
 {
 	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
@@ -80,25 +64,19 @@ static void emma2rh_irq_end(unsigned int
 
 struct irq_chip emma2rh_irq_controller = {
 	.typename = "emma2rh_irq",
-	.startup = emma2rh_irq_startup,
-	.shutdown = emma2rh_irq_shutdown,
-	.enable = emma2rh_irq_enable,
-	.disable = emma2rh_irq_disable,
-	.ack = emma2rh_irq_ack,
+	.ack = emma2rh_irq_disable,
+	.mask = emma2rh_irq_disable,
+	.mask_ack = emma2rh_irq_disable,
+	.unmask = emma2rh_irq_enable,
 	.end = emma2rh_irq_end,
-	.set_affinity = NULL	/* no affinity stuff for UP */
 };
 
 void emma2rh_irq_init(u32 irq_base)
 {
 	u32 i;
 
-	for (i = irq_base; i < irq_base + NUM_EMMA2RH_IRQ; i++) {
-		irq_desc[i].status = IRQ_DISABLED;
-		irq_desc[i].action = NULL;
-		irq_desc[i].depth = 1;
-		irq_desc[i].chip = &emma2rh_irq_controller;
-	}
+	for (i = irq_base; i < irq_base + NUM_EMMA2RH_IRQ; i++)
+		set_irq_chip(i, &emma2rh_irq_controller);
 
 	emma2rh_irq_base = irq_base;
 }
diff --git a/arch/mips/emma2rh/markeins/irq_markeins.c b/arch/mips/emma2rh/markeins/irq_markeins.c
index 0b36eb0..8e5f08a 100644
--- a/arch/mips/emma2rh/markeins/irq_markeins.c
+++ b/arch/mips/emma2rh/markeins/irq_markeins.c
@@ -48,19 +48,6 @@ static void emma2rh_sw_irq_disable(unsig
 	ll_emma2rh_sw_irq_disable(irq - emma2rh_sw_irq_base);
 }
 
-static unsigned int emma2rh_sw_irq_startup(unsigned int irq)
-{
-	emma2rh_sw_irq_enable(irq);
-	return 0;
-}
-
-#define emma2rh_sw_irq_shutdown emma2rh_sw_irq_disable
-
-static void emma2rh_sw_irq_ack(unsigned int irq)
-{
-	ll_emma2rh_sw_irq_disable(irq - emma2rh_sw_irq_base);
-}
-
 static void emma2rh_sw_irq_end(unsigned int irq)
 {
 	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
@@ -69,25 +56,19 @@ static void emma2rh_sw_irq_end(unsigned 
 
 struct irq_chip emma2rh_sw_irq_controller = {
 	.typename = "emma2rh_sw_irq",
-	.startup = emma2rh_sw_irq_startup,
-	.shutdown = emma2rh_sw_irq_shutdown,
-	.enable = emma2rh_sw_irq_enable,
-	.disable = emma2rh_sw_irq_disable,
-	.ack = emma2rh_sw_irq_ack,
+	.ack = emma2rh_sw_irq_disable,
+	.mask = emma2rh_sw_irq_disable,
+	.mask_ack = emma2rh_sw_irq_disable,
+	.unmask = emma2rh_sw_irq_enable,
 	.end = emma2rh_sw_irq_end,
-	.set_affinity = NULL,
 };
 
 void emma2rh_sw_irq_init(u32 irq_base)
 {
 	u32 i;
 
-	for (i = irq_base; i < irq_base + NUM_EMMA2RH_IRQ_SW; i++) {
-		irq_desc[i].status = IRQ_DISABLED;
-		irq_desc[i].action = NULL;
-		irq_desc[i].depth = 2;
-		irq_desc[i].chip = &emma2rh_sw_irq_controller;
-	}
+	for (i = irq_base; i < irq_base + NUM_EMMA2RH_IRQ_SW; i++)
+		set_irq_chip(i, &emma2rh_sw_irq_controller);
 
 	emma2rh_sw_irq_base = irq_base;
 }
@@ -126,14 +107,6 @@ static void emma2rh_gpio_irq_disable(uns
 	ll_emma2rh_gpio_irq_disable(irq - emma2rh_gpio_irq_base);
 }
 
-static unsigned int emma2rh_gpio_irq_startup(unsigned int irq)
-{
-	emma2rh_gpio_irq_enable(irq);
-	return 0;
-}
-
-#define emma2rh_gpio_irq_shutdown emma2rh_gpio_irq_disable
-
 static void emma2rh_gpio_irq_ack(unsigned int irq)
 {
 	irq -= emma2rh_gpio_irq_base;
@@ -149,25 +122,19 @@ static void emma2rh_gpio_irq_end(unsigne
 
 struct irq_chip emma2rh_gpio_irq_controller = {
 	.typename = "emma2rh_gpio_irq",
-	.startup = emma2rh_gpio_irq_startup,
-	.shutdown = emma2rh_gpio_irq_shutdown,
-	.enable = emma2rh_gpio_irq_enable,
-	.disable = emma2rh_gpio_irq_disable,
 	.ack = emma2rh_gpio_irq_ack,
+	.mask = emma2rh_gpio_irq_disable,
+	.mask_ack = emma2rh_gpio_irq_ack,
+	.unmask = emma2rh_gpio_irq_enable,
 	.end = emma2rh_gpio_irq_end,
-	.set_affinity = NULL,
 };
 
 void emma2rh_gpio_irq_init(u32 irq_base)
 {
 	u32 i;
 
-	for (i = irq_base; i < irq_base + NUM_EMMA2RH_IRQ_GPIO; i++) {
-		irq_desc[i].status = IRQ_DISABLED;
-		irq_desc[i].action = NULL;
-		irq_desc[i].depth = 2;
-		irq_desc[i].chip = &emma2rh_gpio_irq_controller;
-	}
+	for (i = irq_base; i < irq_base + NUM_EMMA2RH_IRQ_GPIO; i++)
+		set_irq_chip(i, &emma2rh_gpio_irq_controller);
 
 	emma2rh_gpio_irq_base = irq_base;
 }
diff --git a/arch/mips/gt64120/ev64120/irq.c b/arch/mips/gt64120/ev64120/irq.c
index ed4d82b..b3e5796 100644
--- a/arch/mips/gt64120/ev64120/irq.c
+++ b/arch/mips/gt64120/ev64120/irq.c
@@ -66,38 +66,21 @@ asmlinkage void plat_irq_dispatch(void)
 
 static void disable_ev64120_irq(unsigned int irq_nr)
 {
-	unsigned long flags;
-
-	local_irq_save(flags);
 	if (irq_nr >= 8) {	// All PCI interrupts are on line 5 or 2
 		clear_c0_status(9 << 10);
 	} else {
 		clear_c0_status(1 << (irq_nr + 8));
 	}
-	local_irq_restore(flags);
 }
 
 static void enable_ev64120_irq(unsigned int irq_nr)
 {
-	unsigned long flags;
-
-	local_irq_save(flags);
 	if (irq_nr >= 8)	// All PCI interrupts are on line 5 or 2
 		set_c0_status(9 << 10);
 	else
 		set_c0_status(1 << (irq_nr + 8));
-	local_irq_restore(flags);
-}
-
-static unsigned int startup_ev64120_irq(unsigned int irq)
-{
-	enable_ev64120_irq(irq);
-	return 0;		/* Never anything pending  */
 }
 
-#define shutdown_ev64120_irq     disable_ev64120_irq
-#define mask_and_ack_ev64120_irq disable_ev64120_irq
-
 static void end_ev64120_irq(unsigned int irq)
 {
 	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
@@ -106,13 +89,11 @@ static void end_ev64120_irq(unsigned int
 
 static struct irq_chip ev64120_irq_type = {
 	.typename	= "EV64120",
-	.startup	= startup_ev64120_irq,
-	.shutdown	= shutdown_ev64120_irq,
-	.enable		= enable_ev64120_irq,
-	.disable	= disable_ev64120_irq,
-	.ack		= mask_and_ack_ev64120_irq,
+	.ack		= disable_ev64120_irq,
+	.mask		= disable_ev64120_irq,
+	.mask_ack	= disable_ev64120_irq,
+	.unmask		= enable_ev64120_irq,
 	.end		= end_ev64120_irq,
-	.set_affinity	= NULL
 };
 
 void gt64120_irq_setup(void)
@@ -122,8 +103,6 @@ void gt64120_irq_setup(void)
 	 */
 	clear_c0_status(ST0_IM);
 
-	local_irq_disable();
-
 	/*
 	 * Enable timer.  Other interrupts will be enabled as they are
 	 * registered.
@@ -133,16 +112,5 @@ void gt64120_irq_setup(void)
 
 void __init arch_init_irq(void)
 {
-	int i;
-
-	/*  Let's initialize our IRQ descriptors  */
-	for (i = 0; i < NR_IRQS; i++) {
-		irq_desc[i].status = 0;
-		irq_desc[i].chip = &no_irq_chip;
-		irq_desc[i].action = NULL;
-		irq_desc[i].depth = 0;
-		spin_lock_init(&irq_desc[i].lock);
-	}
-
 	gt64120_irq_setup();
 }
diff --git a/arch/mips/jazz/irq.c b/arch/mips/jazz/irq.c
index d5bd6b3..4bbb6cb 100644
--- a/arch/mips/jazz/irq.c
+++ b/arch/mips/jazz/irq.c
@@ -28,14 +28,6 @@ static void enable_r4030_irq(unsigned in
 	spin_unlock_irqrestore(&r4030_lock, flags);
 }
 
-static unsigned int startup_r4030_irq(unsigned int irq)
-{
-	enable_r4030_irq(irq);
-	return 0; /* never anything pending */
-}
-
-#define shutdown_r4030_irq	disable_r4030_irq
-
 void disable_r4030_irq(unsigned int irq)
 {
 	unsigned int mask = ~(1 << (irq - JAZZ_PARALLEL_IRQ));
@@ -47,8 +39,6 @@ void disable_r4030_irq(unsigned int irq)
 	spin_unlock_irqrestore(&r4030_lock, flags);
 }
 
-#define mask_and_ack_r4030_irq disable_r4030_irq
-
 static void end_r4030_irq(unsigned int irq)
 {
 	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
@@ -57,11 +47,10 @@ static void end_r4030_irq(unsigned int i
 
 static struct irq_chip r4030_irq_type = {
 	.typename = "R4030",
-	.startup = startup_r4030_irq,
-	.shutdown = shutdown_r4030_irq,
-	.enable = enable_r4030_irq,
-	.disable = disable_r4030_irq,
-	.ack = mask_and_ack_r4030_irq,
+	.ack = disable_r4030_irq,
+	.mask = disable_r4030_irq,
+	.mask_ack = disable_r4030_irq,
+	.unmask = enable_r4030_irq,
 	.end = end_r4030_irq,
 };
 
@@ -69,12 +58,8 @@ void __init init_r4030_ints(void)
 {
 	int i;
 
-	for (i = JAZZ_PARALLEL_IRQ; i <= JAZZ_TIMER_IRQ; i++) {
-		irq_desc[i].status     = IRQ_DISABLED;
-		irq_desc[i].action     = 0;
-		irq_desc[i].depth      = 1;
-		irq_desc[i].chip    = &r4030_irq_type;
-	}
+	for (i = JAZZ_PARALLEL_IRQ; i <= JAZZ_TIMER_IRQ; i++)
+		set_irq_chip(i, &r4030_irq_type);
 
 	r4030_write_reg16(JAZZ_IO_IRQ_ENABLE, 0);
 	r4030_read_reg16(JAZZ_IO_IRQ_SOURCE);		/* clear pending IRQs */
diff --git a/arch/mips/jmr3927/rbhma3100/irq.c b/arch/mips/jmr3927/rbhma3100/irq.c
index de4a238..3da49c5 100644
--- a/arch/mips/jmr3927/rbhma3100/irq.c
+++ b/arch/mips/jmr3927/rbhma3100/irq.c
@@ -90,17 +90,6 @@ static unsigned char irc_level[TX3927_NU
 static void jmr3927_irq_disable(unsigned int irq_nr);
 static void jmr3927_irq_enable(unsigned int irq_nr);
 
-static DEFINE_SPINLOCK(jmr3927_irq_lock);
-
-static unsigned int jmr3927_irq_startup(unsigned int irq)
-{
-	jmr3927_irq_enable(irq);
-
-	return 0;
-}
-
-#define	jmr3927_irq_shutdown	jmr3927_irq_disable
-
 static void jmr3927_irq_ack(unsigned int irq)
 {
 	if (irq == JMR3927_IRQ_IRC_TMR0)
@@ -118,9 +107,7 @@ static void jmr3927_irq_end(unsigned int
 static void jmr3927_irq_disable(unsigned int irq_nr)
 {
 	struct tb_irq_space* sp;
-	unsigned long flags;
 
-	spin_lock_irqsave(&jmr3927_irq_lock, flags);
 	for (sp = tb_irq_spaces; sp; sp = sp->next) {
 		if (sp->start_irqno <= irq_nr &&
 		    irq_nr < sp->start_irqno + sp->nr_irqs) {
@@ -130,15 +117,12 @@ static void jmr3927_irq_disable(unsigned
 			break;
 		}
 	}
-	spin_unlock_irqrestore(&jmr3927_irq_lock, flags);
 }
 
 static void jmr3927_irq_enable(unsigned int irq_nr)
 {
 	struct tb_irq_space* sp;
-	unsigned long flags;
 
-	spin_lock_irqsave(&jmr3927_irq_lock, flags);
 	for (sp = tb_irq_spaces; sp; sp = sp->next) {
 		if (sp->start_irqno <= irq_nr &&
 		    irq_nr < sp->start_irqno + sp->nr_irqs) {
@@ -148,7 +132,6 @@ static void jmr3927_irq_enable(unsigned 
 			break;
 		}
 	}
-	spin_unlock_irqrestore(&jmr3927_irq_lock, flags);
 }
 
 /*
@@ -457,11 +440,10 @@ #endif
 
 static struct irq_chip jmr3927_irq_controller = {
 	.typename = "jmr3927_irq",
-	.startup = jmr3927_irq_startup,
-	.shutdown = jmr3927_irq_shutdown,
-	.enable = jmr3927_irq_enable,
-	.disable = jmr3927_irq_disable,
 	.ack = jmr3927_irq_ack,
+	.mask = jmr3927_irq_disable,
+	.mask_ack = jmr3927_irq_ack,
+	.unmask = jmr3927_irq_enable,
 	.end = jmr3927_irq_end,
 };
 
@@ -469,12 +451,8 @@ void jmr3927_irq_init(u32 irq_base)
 {
 	u32 i;
 
-	for (i= irq_base; i< irq_base + JMR3927_NR_IRQ_IRC + JMR3927_NR_IRQ_IOC; i++) {
-		irq_desc[i].status = IRQ_DISABLED;
-		irq_desc[i].action = NULL;
-		irq_desc[i].depth = 1;
-		irq_desc[i].chip = &jmr3927_irq_controller;
-	}
+	for (i= irq_base; i< irq_base + JMR3927_NR_IRQ_IRC + JMR3927_NR_IRQ_IOC; i++)
+		set_irq_chip(i, &jmr3927_irq_controller);
 
 	jmr3927_irq_base = irq_base;
 }
diff --git a/arch/mips/kernel/i8259.c b/arch/mips/kernel/i8259.c
index 48e3418..2526c0c 100644
--- a/arch/mips/kernel/i8259.c
+++ b/arch/mips/kernel/i8259.c
@@ -40,21 +40,10 @@ static void end_8259A_irq (unsigned int 
 		enable_8259A_irq(irq);
 }
 
-#define shutdown_8259A_irq	disable_8259A_irq
-
 void mask_and_ack_8259A(unsigned int);
 
-static unsigned int startup_8259A_irq(unsigned int irq)
-{
-	enable_8259A_irq(irq);
-
-	return 0; /* never anything pending */
-}
-
 static struct irq_chip i8259A_irq_type = {
 	.typename = "XT-PIC",
-	.startup = startup_8259A_irq,
-	.shutdown = shutdown_8259A_irq,
 	.enable = enable_8259A_irq,
 	.disable = disable_8259A_irq,
 	.ack = mask_and_ack_8259A,
@@ -120,7 +109,7 @@ int i8259A_irq_pending(unsigned int irq)
 void make_8259A_irq(unsigned int irq)
 {
 	disable_irq_nosync(irq);
-	irq_desc[irq].chip = &i8259A_irq_type;
+	set_irq_chip(irq, &i8259A_irq_type);
 	enable_irq(irq);
 }
 
@@ -323,12 +312,8 @@ void __init init_i8259_irqs (void)
 
 	init_8259A(0);
 
-	for (i = 0; i < 16; i++) {
-		irq_desc[i].status = IRQ_DISABLED;
-		irq_desc[i].action = NULL;
-		irq_desc[i].depth = 1;
-		irq_desc[i].chip = &i8259A_irq_type;
-	}
+	for (i = 0; i < 16; i++)
+		set_irq_chip(i, &i8259A_irq_type);
 
 	setup_irq(2, &irq2);
 }
diff --git a/arch/mips/kernel/irq-msc01.c b/arch/mips/kernel/irq-msc01.c
index 650a80c..e1880b2 100644
--- a/arch/mips/kernel/irq-msc01.c
+++ b/arch/mips/kernel/irq-msc01.c
@@ -45,31 +45,6 @@ static inline void unmask_msc_irq(unsign
 }
 
 /*
- * Enables the IRQ on SOC-it
- */
-static void enable_msc_irq(unsigned int irq)
-{
-	unmask_msc_irq(irq);
-}
-
-/*
- * Initialize the IRQ on SOC-it
- */
-static unsigned int startup_msc_irq(unsigned int irq)
-{
-	unmask_msc_irq(irq);
-	return 0;
-}
-
-/*
- * Disables the IRQ on SOC-it
- */
-static void disable_msc_irq(unsigned int irq)
-{
-	mask_msc_irq(irq);
-}
-
-/*
  * Masks and ACKs an IRQ
  */
 static void level_mask_and_ack_msc_irq(unsigned int irq)
@@ -136,25 +111,21 @@ msc_bind_eic_interrupt (unsigned int irq
 		    (irq<<MSC01_IC_RAMW_ADDR_SHF) | (set<<MSC01_IC_RAMW_DATA_SHF));
 }
 
-#define shutdown_msc_irq	disable_msc_irq
-
 struct irq_chip msc_levelirq_type = {
 	.typename = "SOC-it-Level",
-	.startup = startup_msc_irq,
-	.shutdown = shutdown_msc_irq,
-	.enable = enable_msc_irq,
-	.disable = disable_msc_irq,
 	.ack = level_mask_and_ack_msc_irq,
+	.mask = mask_msc_irq,
+	.mask_ack = level_mask_and_ack_msc_irq,
+	.unmask = unmask_msc_irq,
 	.end = end_msc_irq,
 };
 
 struct irq_chip msc_edgeirq_type = {
 	.typename = "SOC-it-Edge",
-	.startup =startup_msc_irq,
-	.shutdown = shutdown_msc_irq,
-	.enable = enable_msc_irq,
-	.disable = disable_msc_irq,
 	.ack = edge_mask_and_ack_msc_irq,
+	.mask = mask_msc_irq,
+	.mask_ack = edge_mask_and_ack_msc_irq,
+	.unmask = unmask_msc_irq,
 	.end = end_msc_irq,
 };
 
@@ -175,14 +146,14 @@ void __init init_msc_irqs(unsigned int b
 
 		switch (imp->im_type) {
 		case MSC01_IRQ_EDGE:
-			irq_desc[base+n].chip = &msc_edgeirq_type;
+			set_irq_chip(base+n, &msc_edgeirq_type);
 			if (cpu_has_veic)
 				MSCIC_WRITE(MSC01_IC_SUP+n*8, MSC01_IC_SUP_EDGE_BIT);
 			else
 				MSCIC_WRITE(MSC01_IC_SUP+n*8, MSC01_IC_SUP_EDGE_BIT | imp->im_lvl);
 			break;
 		case MSC01_IRQ_LEVEL:
-			irq_desc[base+n].chip = &msc_levelirq_type;
+			set_irq_chip(base+n, &msc_levelirq_type);
 			if (cpu_has_veic)
 				MSCIC_WRITE(MSC01_IC_SUP+n*8, 0);
 			else
diff --git a/arch/mips/kernel/irq-mv6434x.c b/arch/mips/kernel/irq-mv6434x.c
index 37d1062..5012b9d 100644
--- a/arch/mips/kernel/irq-mv6434x.c
+++ b/arch/mips/kernel/irq-mv6434x.c
@@ -67,39 +67,6 @@ static inline void unmask_mv64340_irq(un
 }
 
 /*
- * Enables the IRQ on Marvell Chip
- */
-static void enable_mv64340_irq(unsigned int irq)
-{
-	unmask_mv64340_irq(irq);
-}
-
-/*
- * Initialize the IRQ on Marvell Chip
- */
-static unsigned int startup_mv64340_irq(unsigned int irq)
-{
-	unmask_mv64340_irq(irq);
-	return 0;
-}
-
-/*
- * Disables the IRQ on Marvell Chip
- */
-static void disable_mv64340_irq(unsigned int irq)
-{
-	mask_mv64340_irq(irq);
-}
-
-/*
- * Masks and ACKs an IRQ
- */
-static void mask_and_ack_mv64340_irq(unsigned int irq)
-{
-	mask_mv64340_irq(irq);
-}
-
-/*
  * End IRQ processing
  */
 static void end_mv64340_irq(unsigned int irq)
@@ -133,15 +100,12 @@ void ll_mv64340_irq(void)
 		do_IRQ(ls1bit32(irq_src_high) + irq_base + 32);
 }
 
-#define shutdown_mv64340_irq	disable_mv64340_irq
-
 struct irq_chip mv64340_irq_type = {
 	.typename = "MV-64340",
-	.startup = startup_mv64340_irq,
-	.shutdown = shutdown_mv64340_irq,
-	.enable = enable_mv64340_irq,
-	.disable = disable_mv64340_irq,
-	.ack = mask_and_ack_mv64340_irq,
+	.ack = mask_mv64340_irq,
+	.mask = mask_mv64340_irq,
+	.mask_ack = mask_mv64340_irq,
+	.unmask = unmask_mv64340_irq,
 	.end = end_mv64340_irq,
 };
 
@@ -149,13 +113,8 @@ void __init mv64340_irq_init(unsigned in
 {
 	int i;
 
-	/* Reset irq handlers pointers to NULL */
-	for (i = base; i < base + 64; i++) {
-		irq_desc[i].status = IRQ_DISABLED;
-		irq_desc[i].action = 0;
-		irq_desc[i].depth = 2;
-		irq_desc[i].chip = &mv64340_irq_type;
-	}
+	for (i = base; i < base + 64; i++)
+		set_irq_chip(i, &mv64340_irq_type);
 
 	irq_base = base;
 }
diff --git a/arch/mips/kernel/irq-rm7000.c b/arch/mips/kernel/irq-rm7000.c
index 6b54c71..6a297e3 100644
--- a/arch/mips/kernel/irq-rm7000.c
+++ b/arch/mips/kernel/irq-rm7000.c
@@ -29,42 +29,6 @@ static inline void mask_rm7k_irq(unsigne
 	clear_c0_intcontrol(0x100 << (irq - irq_base));
 }
 
-static inline void rm7k_cpu_irq_enable(unsigned int irq)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	unmask_rm7k_irq(irq);
-	local_irq_restore(flags);
-}
-
-static void rm7k_cpu_irq_disable(unsigned int irq)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	mask_rm7k_irq(irq);
-	local_irq_restore(flags);
-}
-
-static unsigned int rm7k_cpu_irq_startup(unsigned int irq)
-{
-	rm7k_cpu_irq_enable(irq);
-
-	return 0;
-}
-
-#define	rm7k_cpu_irq_shutdown	rm7k_cpu_irq_disable
-
-/*
- * While we ack the interrupt interrupts are disabled and thus we don't need
- * to deal with concurrency issues.  Same for rm7k_cpu_irq_end.
- */
-static void rm7k_cpu_irq_ack(unsigned int irq)
-{
-	mask_rm7k_irq(irq);
-}
-
 static void rm7k_cpu_irq_end(unsigned int irq)
 {
 	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
@@ -73,11 +37,10 @@ static void rm7k_cpu_irq_end(unsigned in
 
 static struct irq_chip rm7k_irq_controller = {
 	.typename = "RM7000",
-	.startup = rm7k_cpu_irq_startup,
-	.shutdown = rm7k_cpu_irq_shutdown,
-	.enable = rm7k_cpu_irq_enable,
-	.disable = rm7k_cpu_irq_disable,
-	.ack = rm7k_cpu_irq_ack,
+	.ack = mask_rm7k_irq,
+	.mask = mask_rm7k_irq,
+	.mask_ack = mask_rm7k_irq,
+	.unmask = unmask_rm7k_irq,
 	.end = rm7k_cpu_irq_end,
 };
 
@@ -87,12 +50,8 @@ void __init rm7k_cpu_irq_init(int base)
 
 	clear_c0_intcontrol(0x00000f00);		/* Mask all */
 
-	for (i = base; i < base + 4; i++) {
-		irq_desc[i].status = IRQ_DISABLED;
-		irq_desc[i].action = NULL;
-		irq_desc[i].depth = 1;
-		irq_desc[i].chip = &rm7k_irq_controller;
-	}
+	for (i = base; i < base + 4; i++)
+		set_irq_chip(i, &rm7k_irq_controller);
 
 	irq_base = base;
 }
diff --git a/arch/mips/kernel/irq-rm9000.c b/arch/mips/kernel/irq-rm9000.c
index 62f011b..9775384 100644
--- a/arch/mips/kernel/irq-rm9000.c
+++ b/arch/mips/kernel/irq-rm9000.c
@@ -48,15 +48,6 @@ static void rm9k_cpu_irq_disable(unsigne
 	local_irq_restore(flags);
 }
 
-static unsigned int rm9k_cpu_irq_startup(unsigned int irq)
-{
-	rm9k_cpu_irq_enable(irq);
-
-	return 0;
-}
-
-#define	rm9k_cpu_irq_shutdown	rm9k_cpu_irq_disable
-
 /*
  * Performance counter interrupts are global on all processors.
  */
@@ -89,16 +80,6 @@ static void rm9k_perfcounter_irq_shutdow
 	on_each_cpu(local_rm9k_perfcounter_irq_shutdown, (void *) irq, 0, 1);
 }
 
-
-/*
- * While we ack the interrupt interrupts are disabled and thus we don't need
- * to deal with concurrency issues.  Same for rm9k_cpu_irq_end.
- */
-static void rm9k_cpu_irq_ack(unsigned int irq)
-{
-	mask_rm9k_irq(irq);
-}
-
 static void rm9k_cpu_irq_end(unsigned int irq)
 {
 	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
@@ -107,11 +88,10 @@ static void rm9k_cpu_irq_end(unsigned in
 
 static struct irq_chip rm9k_irq_controller = {
 	.typename = "RM9000",
-	.startup = rm9k_cpu_irq_startup,
-	.shutdown = rm9k_cpu_irq_shutdown,
-	.enable = rm9k_cpu_irq_enable,
-	.disable = rm9k_cpu_irq_disable,
-	.ack = rm9k_cpu_irq_ack,
+	.ack = mask_rm9k_irq,
+	.mask = mask_rm9k_irq,
+	.mask_ack = mask_rm9k_irq,
+	.unmask = unmask_rm9k_irq,
 	.end = rm9k_cpu_irq_end,
 };
 
@@ -119,9 +99,10 @@ static struct irq_chip rm9k_perfcounter_
 	.typename = "RM9000",
 	.startup = rm9k_perfcounter_irq_startup,
 	.shutdown = rm9k_perfcounter_irq_shutdown,
-	.enable = rm9k_cpu_irq_enable,
-	.disable = rm9k_cpu_irq_disable,
-	.ack = rm9k_cpu_irq_ack,
+	.ack = mask_rm9k_irq,
+	.mask = mask_rm9k_irq,
+	.mask_ack = mask_rm9k_irq,
+	.unmask = unmask_rm9k_irq,
 	.end = rm9k_cpu_irq_end,
 };
 
@@ -135,15 +116,11 @@ void __init rm9k_cpu_irq_init(int base)
 
 	clear_c0_intcontrol(0x0000f000);		/* Mask all */
 
-	for (i = base; i < base + 4; i++) {
-		irq_desc[i].status = IRQ_DISABLED;
-		irq_desc[i].action = NULL;
-		irq_desc[i].depth = 1;
-		irq_desc[i].chip = &rm9k_irq_controller;
-	}
+	for (i = base; i < base + 4; i++)
+		set_irq_chip(i, &rm9k_irq_controller);
 
 	rm9000_perfcount_irq = base + 1;
-	irq_desc[rm9000_perfcount_irq].chip = &rm9k_perfcounter_irq;
+	set_irq_chip(rm9000_perfcount_irq, &rm9k_perfcounter_irq);
 
 	irq_base = base;
 }
diff --git a/arch/mips/kernel/irq.c b/arch/mips/kernel/irq.c
index dd24434..c9961d8 100644
--- a/arch/mips/kernel/irq.c
+++ b/arch/mips/kernel/irq.c
@@ -130,19 +130,6 @@ #endif
 
 void __init init_IRQ(void)
 {
-	int i;
-
-	for (i = 0; i < NR_IRQS; i++) {
-		irq_desc[i].status  = IRQ_DISABLED;
-		irq_desc[i].action  = NULL;
-		irq_desc[i].depth   = 1;
-		irq_desc[i].chip = &no_irq_chip;
-		spin_lock_init(&irq_desc[i].lock);
-#ifdef CONFIG_MIPS_MT_SMTC
-		irq_hwmask[i] = 0;
-#endif /* CONFIG_MIPS_MT_SMTC */
-	}
-
 	arch_init_irq();
 
 #ifdef CONFIG_KGDB
diff --git a/arch/mips/kernel/irq_cpu.c b/arch/mips/kernel/irq_cpu.c
index 9bb21c7..79fea0f 100644
--- a/arch/mips/kernel/irq_cpu.c
+++ b/arch/mips/kernel/irq_cpu.c
@@ -50,35 +50,6 @@ static inline void mask_mips_irq(unsigne
 	irq_disable_hazard();
 }
 
-static inline void mips_cpu_irq_enable(unsigned int irq)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	unmask_mips_irq(irq);
-	back_to_back_c0_hazard();
-	local_irq_restore(flags);
-}
-
-static void mips_cpu_irq_disable(unsigned int irq)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	mask_mips_irq(irq);
-	back_to_back_c0_hazard();
-	local_irq_restore(flags);
-}
-
-static unsigned int mips_cpu_irq_startup(unsigned int irq)
-{
-	mips_cpu_irq_enable(irq);
-
-	return 0;
-}
-
-#define	mips_cpu_irq_shutdown		mips_cpu_irq_disable
-
 /*
  * While we ack the interrupt interrupts are disabled and thus we don't need
  * to deal with concurrency issues.  Same for mips_cpu_irq_end.
@@ -96,11 +67,9 @@ static void mips_cpu_irq_end(unsigned in
 
 static struct irq_chip mips_cpu_irq_controller = {
 	.typename	= "MIPS",
-	.startup	= mips_cpu_irq_startup,
-	.shutdown	= mips_cpu_irq_shutdown,
-	.enable		= mips_cpu_irq_enable,
-	.disable	= mips_cpu_irq_disable,
 	.ack		= mips_cpu_irq_ack,
+	.mask		= mask_mips_irq,
+	.unmask		= unmask_mips_irq,
 	.end		= mips_cpu_irq_end,
 };
 
@@ -110,8 +79,6 @@ static struct irq_chip mips_cpu_irq_cont
 
 #define unmask_mips_mt_irq	unmask_mips_irq
 #define mask_mips_mt_irq	mask_mips_irq
-#define mips_mt_cpu_irq_enable	mips_cpu_irq_enable
-#define mips_mt_cpu_irq_disable	mips_cpu_irq_disable
 
 static unsigned int mips_mt_cpu_irq_startup(unsigned int irq)
 {
@@ -119,13 +86,11 @@ static unsigned int mips_mt_cpu_irq_star
 
 	clear_c0_cause(0x100 << (irq - mips_cpu_irq_base));
 	evpe(vpflags);
-	mips_mt_cpu_irq_enable(irq);
+	unmask_mips_mt_irq(irq);
 
 	return 0;
 }
 
-#define	mips_mt_cpu_irq_shutdown	mips_mt_cpu_irq_disable
-
 /*
  * While we ack the interrupt interrupts are disabled and thus we don't need
  * to deal with concurrency issues.  Same for mips_cpu_irq_end.
@@ -143,10 +108,9 @@ #define mips_mt_cpu_irq_end mips_cpu_irq
 static struct irq_chip mips_mt_cpu_irq_controller = {
 	.typename	= "MIPS",
 	.startup	= mips_mt_cpu_irq_startup,
-	.shutdown	= mips_mt_cpu_irq_shutdown,
-	.enable		= mips_mt_cpu_irq_enable,
-	.disable	= mips_mt_cpu_irq_disable,
 	.ack		= mips_mt_cpu_irq_ack,
+	.mask		= mask_mips_mt_irq,
+	.unmask		= unmask_mips_mt_irq,
 	.end		= mips_mt_cpu_irq_end,
 };
 
@@ -163,19 +127,11 @@ void __init mips_cpu_irq_init(int irq_ba
 	 * leave them uninitialized for other processors.
 	 */
 	if (cpu_has_mipsmt)
-		for (i = irq_base; i < irq_base + 2; i++) {
-			irq_desc[i].status = IRQ_DISABLED;
-			irq_desc[i].action = NULL;
-			irq_desc[i].depth = 1;
-			irq_desc[i].chip = &mips_mt_cpu_irq_controller;
-		}
-
-	for (i = irq_base + 2; i < irq_base + 8; i++) {
-		irq_desc[i].status = IRQ_DISABLED;
-		irq_desc[i].action = NULL;
-		irq_desc[i].depth = 1;
-		irq_desc[i].chip = &mips_cpu_irq_controller;
-	}
+		for (i = irq_base; i < irq_base + 2; i++)
+			set_irq_chip(i, &mips_mt_cpu_irq_controller);
+
+	for (i = irq_base + 2; i < irq_base + 8; i++)
+		set_irq_chip(i, &mips_cpu_irq_controller);
 
 	mips_cpu_irq_base = irq_base;
 }
diff --git a/arch/mips/lasat/interrupt.c b/arch/mips/lasat/interrupt.c
index a144a00..cac82af 100644
--- a/arch/mips/lasat/interrupt.c
+++ b/arch/mips/lasat/interrupt.c
@@ -36,33 +36,14 @@ static volatile int lasat_int_mask_shift
 
 void disable_lasat_irq(unsigned int irq_nr)
 {
-	unsigned long flags;
-
-	local_irq_save(flags);
 	*lasat_int_mask &= ~(1 << irq_nr) << lasat_int_mask_shift;
-	local_irq_restore(flags);
 }
 
 void enable_lasat_irq(unsigned int irq_nr)
 {
-	unsigned long flags;
-
-	local_irq_save(flags);
 	*lasat_int_mask |= (1 << irq_nr) << lasat_int_mask_shift;
-	local_irq_restore(flags);
 }
 
-static unsigned int startup_lasat_irq(unsigned int irq)
-{
-	enable_lasat_irq(irq);
-
-	return 0; /* never anything pending */
-}
-
-#define shutdown_lasat_irq	disable_lasat_irq
-
-#define mask_and_ack_lasat_irq disable_lasat_irq
-
 static void end_lasat_irq(unsigned int irq)
 {
 	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
@@ -71,11 +52,10 @@ static void end_lasat_irq(unsigned int i
 
 static struct irq_chip lasat_irq_type = {
 	.typename = "Lasat",
-	.startup = startup_lasat_irq,
-	.shutdown = shutdown_lasat_irq,
-	.enable = enable_lasat_irq,
-	.disable = disable_lasat_irq,
-	.ack = mask_and_ack_lasat_irq,
+	.ack = disable_lasat_irq,
+	.mask = disable_lasat_irq,
+	.mask_ack = disable_lasat_irq,
+	.unmask = enable_lasat_irq,
 	.end = end_lasat_irq,
 };
 
@@ -152,10 +132,6 @@ void __init arch_init_irq(void)
 		panic("arch_init_irq: mips_machtype incorrect");
 	}
 
-	for (i = 0; i <= LASATINT_END; i++) {
-		irq_desc[i].status	= IRQ_DISABLED;
-		irq_desc[i].action	= 0;
-		irq_desc[i].depth	= 1;
-		irq_desc[i].chip	= &lasat_irq_type;
-	}
+	for (i = 0; i <= LASATINT_END; i++)
+		set_irq_chip(i, &lasat_irq_type);
 }
diff --git a/arch/mips/mips-boards/atlas/atlas_int.c b/arch/mips/mips-boards/atlas/atlas_int.c
index be624b8..7c71004 100644
--- a/arch/mips/mips-boards/atlas/atlas_int.c
+++ b/arch/mips/mips-boards/atlas/atlas_int.c
@@ -62,16 +62,6 @@ void enable_atlas_irq(unsigned int irq_n
 	iob();
 }
 
-static unsigned int startup_atlas_irq(unsigned int irq)
-{
-	enable_atlas_irq(irq);
-	return 0; /* never anything pending */
-}
-
-#define shutdown_atlas_irq	disable_atlas_irq
-
-#define mask_and_ack_atlas_irq disable_atlas_irq
-
 static void end_atlas_irq(unsigned int irq)
 {
 	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
@@ -80,11 +70,10 @@ static void end_atlas_irq(unsigned int i
 
 static struct irq_chip atlas_irq_type = {
 	.typename = "Atlas",
-	.startup = startup_atlas_irq,
-	.shutdown = shutdown_atlas_irq,
-	.enable = enable_atlas_irq,
-	.disable = disable_atlas_irq,
-	.ack = mask_and_ack_atlas_irq,
+	.ack = disable_atlas_irq,
+	.mask = disable_atlas_irq,
+	.mask_ack = disable_atlas_irq,
+	.unmask = enable_atlas_irq,
 	.end = end_atlas_irq,
 };
 
@@ -217,13 +206,8 @@ static inline void init_atlas_irqs (int 
 	 */
 	atlas_hw0_icregs->intrsten = 0xffffffff;
 
-	for (i = ATLAS_INT_BASE; i <= ATLAS_INT_END; i++) {
-		irq_desc[i].status	= IRQ_DISABLED;
-		irq_desc[i].action	= 0;
-		irq_desc[i].depth	= 1;
-		irq_desc[i].chip	= &atlas_irq_type;
-		spin_lock_init(&irq_desc[i].lock);
-	}
+	for (i = ATLAS_INT_BASE; i <= ATLAS_INT_END; i++)
+		set_irq_chip(i, &atlas_irq_type);
 }
 
 static struct irqaction atlasirq = {
diff --git a/arch/mips/momentum/ocelot_c/cpci-irq.c b/arch/mips/momentum/ocelot_c/cpci-irq.c
index 47e3fa3..7723f09 100644
--- a/arch/mips/momentum/ocelot_c/cpci-irq.c
+++ b/arch/mips/momentum/ocelot_c/cpci-irq.c
@@ -66,39 +66,6 @@ static inline void unmask_cpci_irq(unsig
 }
 
 /*
- * Enables the IRQ in the FPGA
- */
-static void enable_cpci_irq(unsigned int irq)
-{
-	unmask_cpci_irq(irq);
-}
-
-/*
- * Initialize the IRQ in the FPGA
- */
-static unsigned int startup_cpci_irq(unsigned int irq)
-{
-	unmask_cpci_irq(irq);
-	return 0;
-}
-
-/*
- * Disables the IRQ in the FPGA
- */
-static void disable_cpci_irq(unsigned int irq)
-{
-	mask_cpci_irq(irq);
-}
-
-/*
- * Masks and ACKs an IRQ
- */
-static void mask_and_ack_cpci_irq(unsigned int irq)
-{
-	mask_cpci_irq(irq);
-}
-
-/*
  * End IRQ processing
  */
 static void end_cpci_irq(unsigned int irq)
@@ -125,15 +92,12 @@ void ll_cpci_irq(void)
 	do_IRQ(ls1bit8(irq_src) + CPCI_IRQ_BASE);
 }
 
-#define shutdown_cpci_irq	disable_cpci_irq
-
 struct irq_chip cpci_irq_type = {
 	.typename = "CPCI/FPGA",
-	.startup = startup_cpci_irq,
-	.shutdown = shutdown_cpci_irq,
-	.enable = enable_cpci_irq,
-	.disable = disable_cpci_irq,
-	.ack = mask_and_ack_cpci_irq,
+	.ack = mask_cpci_irq,
+	.mask = mask_cpci_irq,
+	.mask_ack = mask_cpci_irq,
+	.unmask = unmask_cpci_irq,
 	.end = end_cpci_irq,
 };
 
@@ -141,11 +105,6 @@ void cpci_irq_init(void)
 {
 	int i;
 
-	/* Reset irq handlers pointers to NULL */
-	for (i = CPCI_IRQ_BASE; i < (CPCI_IRQ_BASE + 8); i++) {
-		irq_desc[i].status = IRQ_DISABLED;
-		irq_desc[i].action = 0;
-		irq_desc[i].depth = 2;
-		irq_desc[i].chip = &cpci_irq_type;
-	}
+	for (i = CPCI_IRQ_BASE; i < (CPCI_IRQ_BASE + 8); i++)
+		set_irq_chip(i, &cpci_irq_type);
 }
diff --git a/arch/mips/momentum/ocelot_c/uart-irq.c b/arch/mips/momentum/ocelot_c/uart-irq.c
index 510257d..72faf81 100644
--- a/arch/mips/momentum/ocelot_c/uart-irq.c
+++ b/arch/mips/momentum/ocelot_c/uart-irq.c
@@ -60,39 +60,6 @@ static inline void unmask_uart_irq(unsig
 }
 
 /*
- * Enables the IRQ in the FPGA
- */
-static void enable_uart_irq(unsigned int irq)
-{
-	unmask_uart_irq(irq);
-}
-
-/*
- * Initialize the IRQ in the FPGA
- */
-static unsigned int startup_uart_irq(unsigned int irq)
-{
-	unmask_uart_irq(irq);
-	return 0;
-}
-
-/*
- * Disables the IRQ in the FPGA
- */
-static void disable_uart_irq(unsigned int irq)
-{
-	mask_uart_irq(irq);
-}
-
-/*
- * Masks and ACKs an IRQ
- */
-static void mask_and_ack_uart_irq(unsigned int irq)
-{
-	mask_uart_irq(irq);
-}
-
-/*
  * End IRQ processing
  */
 static void end_uart_irq(unsigned int irq)
@@ -118,28 +85,17 @@ void ll_uart_irq(void)
 	do_IRQ(ls1bit8(irq_src) + 74);
 }
 
-#define shutdown_uart_irq	disable_uart_irq
-
 struct irq_chip uart_irq_type = {
 	.typename = "UART/FPGA",
-	.startup = startup_uart_irq,
-	.shutdown = shutdown_uart_irq,
-	.enable = enable_uart_irq,
-	.disable = disable_uart_irq,
-	.ack = mask_and_ack_uart_irq,
+	.ack = mask_uart_irq,
+	.mask = mask_uart_irq,
+	.mask_ack = mask_uart_irq,
+	.unmask = unmask_uart_irq,
 	.end = end_uart_irq,
 };
 
 void uart_irq_init(void)
 {
-	/* Reset irq handlers pointers to NULL */
-	irq_desc[80].status = IRQ_DISABLED;
-	irq_desc[80].action = 0;
-	irq_desc[80].depth = 2;
-	irq_desc[80].chip = &uart_irq_type;
-
-	irq_desc[81].status = IRQ_DISABLED;
-	irq_desc[81].action = 0;
-	irq_desc[81].depth = 2;
-	irq_desc[81].chip = &uart_irq_type;
+	set_irq_chip(80, &uart_irq_type);
+	set_irq_chip(81, &uart_irq_type);
 }
diff --git a/arch/mips/philips/pnx8550/common/int.c b/arch/mips/philips/pnx8550/common/int.c
index 7106116..e4bf494 100644
--- a/arch/mips/philips/pnx8550/common/int.c
+++ b/arch/mips/philips/pnx8550/common/int.c
@@ -38,8 +38,6 @@ #include <asm/gdb-stub.h>
 #include <int.h>
 #include <uart.h>
 
-static DEFINE_SPINLOCK(irq_lock);
-
 /* default prio for interrupts */
 /* first one is a no-no so therefore always prio 0 (disabled) */
 static char gic_prio[PNX8550_INT_GIC_TOTINT] = {
@@ -149,38 +147,6 @@ static inline void unmask_irq(unsigned i
 	}
 }
 
-#define pnx8550_disable pnx8550_ack
-static void pnx8550_ack(unsigned int irq)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&irq_lock, flags);
-	mask_irq(irq);
-	spin_unlock_irqrestore(&irq_lock, flags);
-}
-
-#define pnx8550_enable pnx8550_unmask
-static void pnx8550_unmask(unsigned int irq)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&irq_lock, flags);
-	unmask_irq(irq);
-	spin_unlock_irqrestore(&irq_lock, flags);
-}
-
-static unsigned int startup_irq(unsigned int irq_nr)
-{
-	pnx8550_unmask(irq_nr);
-	return 0;
-}
-
-static void shutdown_irq(unsigned int irq_nr)
-{
-	pnx8550_ack(irq_nr);
-	return;
-}
-
 int pnx8550_set_gic_priority(int irq, int priority)
 {
 	int gic_irq = irq-PNX8550_INT_GIC_MIN;
@@ -192,26 +158,19 @@ int pnx8550_set_gic_priority(int irq, in
 	return prev_priority;
 }
 
-static inline void mask_and_ack_level_irq(unsigned int irq)
-{
-	pnx8550_disable(irq);
-	return;
-}
-
 static void end_irq(unsigned int irq)
 {
 	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS))) {
-		pnx8550_enable(irq);
+		unmask_irq(irq);
 	}
 }
 
 static struct irq_chip level_irq_type = {
 	.typename =	"PNX Level IRQ",
-	.startup =	startup_irq,
-	.shutdown =	shutdown_irq,
-	.enable =	pnx8550_enable,
-	.disable =	pnx8550_disable,
-	.ack =		mask_and_ack_level_irq,
+	.ack =		mask_irq,
+	.mask =		mask_irq,
+	.mask_ack =	mask_irq,
+	.unmask =	unmask_irq,
 	.end =		end_irq,
 };
 
@@ -233,8 +192,8 @@ void __init arch_init_irq(void)
 	int configPR;
 
 	for (i = 0; i < PNX8550_INT_CP0_TOTINT; i++) {
-		irq_desc[i].chip = &level_irq_type;
-		pnx8550_ack(i);	/* mask the irq just in case  */
+		set_irq_chip(i, &level_irq_type);
+		mask_irq(i);	/* mask the irq just in case  */
 	}
 
 	/* init of GIC/IPC interrupts */
@@ -270,7 +229,7 @@ #endif
 		/* mask/priority is still 0 so we will not get any
 		 * interrupts until it is unmasked */
 
-		irq_desc[i].chip = &level_irq_type;
+		set_irq_chip(i, &level_irq_type);
 	}
 
 	/* Priority level 0 */
@@ -279,20 +238,19 @@ #endif
 	/* Set int vector table address */
 	PNX8550_GIC_VECTOR_0 = PNX8550_GIC_VECTOR_1 = 0;
 
-	irq_desc[MIPS_CPU_GIC_IRQ].chip = &level_irq_type;
+	set_irq_chip(MIPS_CPU_GIC_IRQ, &level_irq_type);
 	setup_irq(MIPS_CPU_GIC_IRQ, &gic_action);
 
 	/* init of Timer interrupts */
-	for (i = PNX8550_INT_TIMER_MIN; i <= PNX8550_INT_TIMER_MAX; i++) {
-		irq_desc[i].chip = &level_irq_type;
-	}
+	for (i = PNX8550_INT_TIMER_MIN; i <= PNX8550_INT_TIMER_MAX; i++)
+		set_irq_chip(i, &level_irq_type);
 
 	/* Stop Timer 1-3 */
 	configPR = read_c0_config7();
 	configPR |= 0x00000038;
 	write_c0_config7(configPR);
 
-	irq_desc[MIPS_CPU_TIMER_IRQ].chip = &level_irq_type;
+	set_irq_chip(MIPS_CPU_TIMER_IRQ, &level_irq_type);
 	setup_irq(MIPS_CPU_TIMER_IRQ, &timer_action);
 }
 
diff --git a/arch/mips/sgi-ip22/ip22-eisa.c b/arch/mips/sgi-ip22/ip22-eisa.c
index 0d18ed4..a1a9af6 100644
--- a/arch/mips/sgi-ip22/ip22-eisa.c
+++ b/arch/mips/sgi-ip22/ip22-eisa.c
@@ -95,16 +95,11 @@ static irqreturn_t ip22_eisa_intr(int ir
 
 static void enable_eisa1_irq(unsigned int irq)
 {
-	unsigned long flags;
 	u8 mask;
 
-	local_irq_save(flags);
-
 	mask = inb(EISA_INT1_MASK);
 	mask &= ~((u8) (1 << irq));
 	outb(mask, EISA_INT1_MASK);
-
-	local_irq_restore(flags);
 }
 
 static unsigned int startup_eisa1_irq(unsigned int irq)
@@ -130,8 +125,6 @@ static void disable_eisa1_irq(unsigned i
 	outb(mask, EISA_INT1_MASK);
 }
 
-#define shutdown_eisa1_irq	disable_eisa1_irq
-
 static void mask_and_ack_eisa1_irq(unsigned int irq)
 {
 	disable_eisa1_irq(irq);
@@ -148,25 +141,20 @@ static void end_eisa1_irq(unsigned int i
 static struct irq_chip ip22_eisa1_irq_type = {
 	.typename	= "IP22 EISA",
 	.startup	= startup_eisa1_irq,
-	.shutdown	= shutdown_eisa1_irq,
-	.enable		= enable_eisa1_irq,
-	.disable	= disable_eisa1_irq,
 	.ack		= mask_and_ack_eisa1_irq,
+	.mask		= disable_eisa1_irq,
+	.mask_ack	= mask_and_ack_eisa1_irq,
+	.unmask		= enable_eisa1_irq,
 	.end		= end_eisa1_irq,
 };
 
 static void enable_eisa2_irq(unsigned int irq)
 {
-	unsigned long flags;
 	u8 mask;
 
-	local_irq_save(flags);
-
 	mask = inb(EISA_INT2_MASK);
 	mask &= ~((u8) (1 << (irq - 8)));
 	outb(mask, EISA_INT2_MASK);
-
-	local_irq_restore(flags);
 }
 
 static unsigned int startup_eisa2_irq(unsigned int irq)
@@ -192,8 +180,6 @@ static void disable_eisa2_irq(unsigned i
 	outb(mask, EISA_INT2_MASK);
 }
 
-#define shutdown_eisa2_irq	disable_eisa2_irq
-
 static void mask_and_ack_eisa2_irq(unsigned int irq)
 {
 	disable_eisa2_irq(irq);
@@ -210,10 +196,10 @@ static void end_eisa2_irq(unsigned int i
 static struct irq_chip ip22_eisa2_irq_type = {
 	.typename	= "IP22 EISA",
 	.startup	= startup_eisa2_irq,
-	.shutdown	= shutdown_eisa2_irq,
-	.enable		= enable_eisa2_irq,
-	.disable	= disable_eisa2_irq,
 	.ack		= mask_and_ack_eisa2_irq,
+	.mask		= disable_eisa2_irq,
+	.mask_ack	= mask_and_ack_eisa2_irq,
+	.unmask		= enable_eisa2_irq,
 	.end		= end_eisa2_irq,
 };
 
@@ -275,13 +261,10 @@ #endif
 	outb(0, EISA_DMA2_WRITE_SINGLE);
 
 	for (i = SGINT_EISA; i < (SGINT_EISA + EISA_MAX_IRQ); i++) {
-		irq_desc[i].status = IRQ_DISABLED;
-		irq_desc[i].action = 0;
-		irq_desc[i].depth = 1;
 		if (i < (SGINT_EISA + 8))
-			irq_desc[i].chip = &ip22_eisa1_irq_type;
+			set_irq_chip(i, &ip22_eisa1_irq_type);
 		else
-			irq_desc[i].chip = &ip22_eisa2_irq_type;
+			set_irq_chip(i, &ip22_eisa2_irq_type);
 	}
 
 	/* Cannot use request_irq because of kmalloc not being ready at such
diff --git a/arch/mips/sgi-ip22/ip22-int.c b/arch/mips/sgi-ip22/ip22-int.c
index af51889..8e2074b 100644
--- a/arch/mips/sgi-ip22/ip22-int.c
+++ b/arch/mips/sgi-ip22/ip22-int.c
@@ -40,34 +40,17 @@ extern int ip22_eisa_init(void);
 
 static void enable_local0_irq(unsigned int irq)
 {
-	unsigned long flags;
-
-	local_irq_save(flags);
 	/* don't allow mappable interrupt to be enabled from setup_irq,
 	 * we have our own way to do so */
 	if (irq != SGI_MAP_0_IRQ)
 		sgint->imask0 |= (1 << (irq - SGINT_LOCAL0));
-	local_irq_restore(flags);
-}
-
-static unsigned int startup_local0_irq(unsigned int irq)
-{
-	enable_local0_irq(irq);
-	return 0;		/* Never anything pending  */
 }
 
 static void disable_local0_irq(unsigned int irq)
 {
-	unsigned long flags;
-
-	local_irq_save(flags);
 	sgint->imask0 &= ~(1 << (irq - SGINT_LOCAL0));
-	local_irq_restore(flags);
 }
 
-#define shutdown_local0_irq	disable_local0_irq
-#define mask_and_ack_local0_irq	disable_local0_irq
-
 static void end_local0_irq (unsigned int irq)
 {
 	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
@@ -76,44 +59,26 @@ static void end_local0_irq (unsigned int
 
 static struct irq_chip ip22_local0_irq_type = {
 	.typename	= "IP22 local 0",
-	.startup	= startup_local0_irq,
-	.shutdown	= shutdown_local0_irq,
-	.enable		= enable_local0_irq,
-	.disable	= disable_local0_irq,
-	.ack		= mask_and_ack_local0_irq,
+	.ack		= disable_local0_irq,
+	.mask		= disable_local0_irq,
+	.mask_ack	= disable_local0_irq,
+	.unmask		= enable_local0_irq,
 	.end		= end_local0_irq,
 };
 
 static void enable_local1_irq(unsigned int irq)
 {
-	unsigned long flags;
-
-	local_irq_save(flags);
 	/* don't allow mappable interrupt to be enabled from setup_irq,
 	 * we have our own way to do so */
 	if (irq != SGI_MAP_1_IRQ)
 		sgint->imask1 |= (1 << (irq - SGINT_LOCAL1));
-	local_irq_restore(flags);
-}
-
-static unsigned int startup_local1_irq(unsigned int irq)
-{
-	enable_local1_irq(irq);
-	return 0;		/* Never anything pending  */
 }
 
 void disable_local1_irq(unsigned int irq)
 {
-	unsigned long flags;
-
-	local_irq_save(flags);
 	sgint->imask1 &= ~(1 << (irq - SGINT_LOCAL1));
-	local_irq_restore(flags);
 }
 
-#define shutdown_local1_irq	disable_local1_irq
-#define mask_and_ack_local1_irq	disable_local1_irq
-
 static void end_local1_irq (unsigned int irq)
 {
 	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
@@ -122,44 +87,26 @@ static void end_local1_irq (unsigned int
 
 static struct irq_chip ip22_local1_irq_type = {
 	.typename	= "IP22 local 1",
-	.startup	= startup_local1_irq,
-	.shutdown	= shutdown_local1_irq,
-	.enable		= enable_local1_irq,
-	.disable	= disable_local1_irq,
-	.ack		= mask_and_ack_local1_irq,
+	.ack		= disable_local1_irq,
+	.mask		= disable_local1_irq,
+	.mask_ack	= disable_local1_irq,
+	.unmask		= enable_local1_irq,
 	.end		= end_local1_irq,
 };
 
 static void enable_local2_irq(unsigned int irq)
 {
-	unsigned long flags;
-
-	local_irq_save(flags);
 	sgint->imask0 |= (1 << (SGI_MAP_0_IRQ - SGINT_LOCAL0));
 	sgint->cmeimask0 |= (1 << (irq - SGINT_LOCAL2));
-	local_irq_restore(flags);
-}
-
-static unsigned int startup_local2_irq(unsigned int irq)
-{
-	enable_local2_irq(irq);
-	return 0;		/* Never anything pending  */
 }
 
 void disable_local2_irq(unsigned int irq)
 {
-	unsigned long flags;
-
-	local_irq_save(flags);
 	sgint->cmeimask0 &= ~(1 << (irq - SGINT_LOCAL2));
 	if (!sgint->cmeimask0)
 		sgint->imask0 &= ~(1 << (SGI_MAP_0_IRQ - SGINT_LOCAL0));
-	local_irq_restore(flags);
 }
 
-#define shutdown_local2_irq disable_local2_irq
-#define mask_and_ack_local2_irq	disable_local2_irq
-
 static void end_local2_irq (unsigned int irq)
 {
 	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
@@ -168,44 +115,26 @@ static void end_local2_irq (unsigned int
 
 static struct irq_chip ip22_local2_irq_type = {
 	.typename	= "IP22 local 2",
-	.startup	= startup_local2_irq,
-	.shutdown	= shutdown_local2_irq,
-	.enable		= enable_local2_irq,
-	.disable	= disable_local2_irq,
-	.ack		= mask_and_ack_local2_irq,
+	.ack		= disable_local2_irq,
+	.mask		= disable_local2_irq,
+	.mask_ack	= disable_local2_irq,
+	.unmask		= enable_local2_irq,
 	.end		= end_local2_irq,
 };
 
 static void enable_local3_irq(unsigned int irq)
 {
-	unsigned long flags;
-
-	local_irq_save(flags);
 	sgint->imask1 |= (1 << (SGI_MAP_1_IRQ - SGINT_LOCAL1));
 	sgint->cmeimask1 |= (1 << (irq - SGINT_LOCAL3));
-	local_irq_restore(flags);
-}
-
-static unsigned int startup_local3_irq(unsigned int irq)
-{
-	enable_local3_irq(irq);
-	return 0;		/* Never anything pending  */
 }
 
 void disable_local3_irq(unsigned int irq)
 {
-	unsigned long flags;
-
-	local_irq_save(flags);
 	sgint->cmeimask1 &= ~(1 << (irq - SGINT_LOCAL3));
 	if (!sgint->cmeimask1)
 		sgint->imask1 &= ~(1 << (SGI_MAP_1_IRQ - SGINT_LOCAL1));
-	local_irq_restore(flags);
 }
 
-#define shutdown_local3_irq disable_local3_irq
-#define mask_and_ack_local3_irq	disable_local3_irq
-
 static void end_local3_irq (unsigned int irq)
 {
 	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
@@ -214,11 +143,10 @@ static void end_local3_irq (unsigned int
 
 static struct irq_chip ip22_local3_irq_type = {
 	.typename	= "IP22 local 3",
-	.startup	= startup_local3_irq,
-	.shutdown	= shutdown_local3_irq,
-	.enable		= enable_local3_irq,
-	.disable	= disable_local3_irq,
-	.ack		= mask_and_ack_local3_irq,
+	.ack		= disable_local3_irq,
+	.mask		= disable_local3_irq,
+	.mask_ack	= disable_local3_irq,
+	.unmask		= enable_local3_irq,
 	.end		= end_local3_irq,
 };
 
@@ -430,10 +358,7 @@ void __init arch_init_irq(void)
 		else
 			handler		= &ip22_local3_irq_type;
 
-		irq_desc[i].status	= IRQ_DISABLED;
-		irq_desc[i].action	= 0;
-		irq_desc[i].depth	= 1;
-		irq_desc[i].chip	= handler;
+		set_irq_chip(i, handler);
 	}
 
 	/* vector handler. this register the IRQ as non-sharable */
diff --git a/arch/mips/sgi-ip27/ip27-irq.c b/arch/mips/sgi-ip27/ip27-irq.c
index f01ba1f..a73f537 100644
--- a/arch/mips/sgi-ip27/ip27-irq.c
+++ b/arch/mips/sgi-ip27/ip27-irq.c
@@ -332,11 +332,6 @@ static inline void disable_bridge_irq(un
 	intr_disconnect_level(cpu, swlevel);
 }
 
-static void mask_and_ack_bridge_irq(unsigned int irq)
-{
-	disable_bridge_irq(irq);
-}
-
 static void end_bridge_irq(unsigned int irq)
 {
 	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)) &&
@@ -348,9 +343,10 @@ static struct irq_chip bridge_irq_type =
 	.typename	= "bridge",
 	.startup	= startup_bridge_irq,
 	.shutdown	= shutdown_bridge_irq,
-	.enable		= enable_bridge_irq,
-	.disable	= disable_bridge_irq,
-	.ack		= mask_and_ack_bridge_irq,
+	.ack		= disable_bridge_irq,
+	.mask		= disable_bridge_irq,
+	.mask_ack	= disable_bridge_irq,
+	.unmask		= enable_bridge_irq,
 	.end		= end_bridge_irq,
 };
 
@@ -379,10 +375,7 @@ void free_irqno(unsigned int irq)
 
 void __devinit register_bridge_irq(unsigned int irq)
 {
-	irq_desc[irq].status	= IRQ_DISABLED;
-	irq_desc[irq].action	= 0;
-	irq_desc[irq].depth	= 1;
-	irq_desc[irq].chip	= &bridge_irq_type;
+	set_irq_chip(irq, &bridge_irq_type);
 }
 
 int __devinit request_bridge_irq(struct bridge_controller *bc)
diff --git a/arch/mips/sgi-ip27/ip27-timer.c b/arch/mips/sgi-ip27/ip27-timer.c
index c965705..b76f86d 100644
--- a/arch/mips/sgi-ip27/ip27-timer.c
+++ b/arch/mips/sgi-ip27/ip27-timer.c
@@ -172,15 +172,6 @@ static __init unsigned long get_m48t35_t
         return mktime(year, month, date, hour, min, sec);
 }
 
-static unsigned int startup_rt_irq(unsigned int irq)
-{
-	return 0;
-}
-
-static void shutdown_rt_irq(unsigned int irq)
-{
-}
-
 static void enable_rt_irq(unsigned int irq)
 {
 }
@@ -189,21 +180,16 @@ static void disable_rt_irq(unsigned int 
 {
 }
 
-static void mask_and_ack_rt(unsigned int irq)
-{
-}
-
 static void end_rt_irq(unsigned int irq)
 {
 }
 
 static struct irq_chip rt_irq_type = {
 	.typename	= "SN HUB RT timer",
-	.startup	= startup_rt_irq,
-	.shutdown	= shutdown_rt_irq,
-	.enable		= enable_rt_irq,
-	.disable	= disable_rt_irq,
-	.ack		= mask_and_ack_rt,
+	.ack		= disable_rt_irq,
+	.mask		= disable_rt_irq,
+	.mask_ack	= disable_rt_irq,
+	.unmask		= enable_rt_irq,
 	.end		= end_rt_irq,
 };
 
@@ -223,10 +209,7 @@ void __init plat_timer_setup(struct irqa
 	if (irqno < 0)
 		panic("Can't allocate interrupt number for timer interrupt");
 
-	irq_desc[irqno].status	= IRQ_DISABLED;
-	irq_desc[irqno].action	= NULL;
-	irq_desc[irqno].depth	= 1;
-	irq_desc[irqno].chip	= &rt_irq_type;
+	set_irq_chip(irqno, &rt_irq_type);
 
 	/* over-write the handler, we use our own way */
 	irq->handler = no_action;
diff --git a/arch/mips/sgi-ip32/ip32-irq.c b/arch/mips/sgi-ip32/ip32-irq.c
index c9acadd..ae06386 100644
--- a/arch/mips/sgi-ip32/ip32-irq.c
+++ b/arch/mips/sgi-ip32/ip32-irq.c
@@ -113,12 +113,6 @@ #endif
  * is quite different anyway.
  */
 
-/*
- * IRQ spinlock - Ralf says not to disable CPU interrupts,
- * and I think he knows better.
- */
-static DEFINE_SPINLOCK(ip32_irq_lock);
-
 /* Some initial interrupts to set up */
 extern irqreturn_t crime_memerr_intr(int irq, void *dev_id);
 extern irqreturn_t crime_cpuerr_intr(int irq, void *dev_id);
@@ -138,12 +132,6 @@ static void enable_cpu_irq(unsigned int 
 	set_c0_status(STATUSF_IP7);
 }
 
-static unsigned int startup_cpu_irq(unsigned int irq)
-{
-	enable_cpu_irq(irq);
-	return 0;
-}
-
 static void disable_cpu_irq(unsigned int irq)
 {
 	clear_c0_status(STATUSF_IP7);
@@ -155,16 +143,12 @@ static void end_cpu_irq(unsigned int irq
 		enable_cpu_irq (irq);
 }
 
-#define shutdown_cpu_irq disable_cpu_irq
-#define mask_and_ack_cpu_irq disable_cpu_irq
-
 static struct irq_chip ip32_cpu_interrupt = {
 	.typename = "IP32 CPU",
-	.startup = startup_cpu_irq,
-	.shutdown = shutdown_cpu_irq,
-	.enable = enable_cpu_irq,
-	.disable = disable_cpu_irq,
-	.ack = mask_and_ack_cpu_irq,
+	.ack = disable_cpu_irq,
+	.mask = disable_cpu_irq,
+	.mask_ack = disable_cpu_irq,
+	.unmask = enable_cpu_irq,
 	.end = end_cpu_irq,
 };
 
@@ -177,45 +161,27 @@ static uint64_t crime_mask;
 
 static void enable_crime_irq(unsigned int irq)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&ip32_irq_lock, flags);
 	crime_mask |= 1 << (irq - 1);
 	crime->imask = crime_mask;
-	spin_unlock_irqrestore(&ip32_irq_lock, flags);
-}
-
-static unsigned int startup_crime_irq(unsigned int irq)
-{
-	enable_crime_irq(irq);
-	return 0; /* This is probably not right; we could have pending irqs */
 }
 
 static void disable_crime_irq(unsigned int irq)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&ip32_irq_lock, flags);
 	crime_mask &= ~(1 << (irq - 1));
 	crime->imask = crime_mask;
 	flush_crime_bus();
-	spin_unlock_irqrestore(&ip32_irq_lock, flags);
 }
 
 static void mask_and_ack_crime_irq(unsigned int irq)
 {
-	unsigned long flags;
-
 	/* Edge triggered interrupts must be cleared. */
 	if ((irq >= CRIME_GBE0_IRQ && irq <= CRIME_GBE3_IRQ)
 	    || (irq >= CRIME_RE_EMPTY_E_IRQ && irq <= CRIME_RE_IDLE_E_IRQ)
 	    || (irq >= CRIME_SOFT0_IRQ && irq <= CRIME_SOFT2_IRQ)) {
 	        uint64_t crime_int;
-		spin_lock_irqsave(&ip32_irq_lock, flags);
 		crime_int = crime->hard_int;
 		crime_int &= ~(1 << (irq - 1));
 		crime->hard_int = crime_int;
-		spin_unlock_irqrestore(&ip32_irq_lock, flags);
 	}
 	disable_crime_irq(irq);
 }
@@ -226,15 +192,12 @@ static void end_crime_irq(unsigned int i
 		enable_crime_irq(irq);
 }
 
-#define shutdown_crime_irq disable_crime_irq
-
 static struct irq_chip ip32_crime_interrupt = {
 	.typename = "IP32 CRIME",
-	.startup = startup_crime_irq,
-	.shutdown = shutdown_crime_irq,
-	.enable = enable_crime_irq,
-	.disable = disable_crime_irq,
 	.ack = mask_and_ack_crime_irq,
+	.mask = disable_crime_irq,
+	.mask_ack = mask_and_ack_crime_irq,
+	.unmask = enable_crime_irq,
 	.end = end_crime_irq,
 };
 
@@ -248,34 +211,20 @@ static unsigned long macepci_mask;
 
 static void enable_macepci_irq(unsigned int irq)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&ip32_irq_lock, flags);
 	macepci_mask |= MACEPCI_CONTROL_INT(irq - 9);
 	mace->pci.control = macepci_mask;
 	crime_mask |= 1 << (irq - 1);
 	crime->imask = crime_mask;
-	spin_unlock_irqrestore(&ip32_irq_lock, flags);
-}
-
-static unsigned int startup_macepci_irq(unsigned int irq)
-{
-  	enable_macepci_irq (irq);
-	return 0;
 }
 
 static void disable_macepci_irq(unsigned int irq)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&ip32_irq_lock, flags);
 	crime_mask &= ~(1 << (irq - 1));
 	crime->imask = crime_mask;
 	flush_crime_bus();
 	macepci_mask &= ~MACEPCI_CONTROL_INT(irq - 9);
 	mace->pci.control = macepci_mask;
 	flush_mace_bus();
-	spin_unlock_irqrestore(&ip32_irq_lock, flags);
 }
 
 static void end_macepci_irq(unsigned int irq)
@@ -284,16 +233,12 @@ static void end_macepci_irq(unsigned int
 		enable_macepci_irq(irq);
 }
 
-#define shutdown_macepci_irq disable_macepci_irq
-#define mask_and_ack_macepci_irq disable_macepci_irq
-
 static struct irq_chip ip32_macepci_interrupt = {
 	.typename = "IP32 MACE PCI",
-	.startup = startup_macepci_irq,
-	.shutdown = shutdown_macepci_irq,
-	.enable = enable_macepci_irq,
-	.disable = disable_macepci_irq,
-	.ack = mask_and_ack_macepci_irq,
+	.ack = disable_macepci_irq,
+	.mask = disable_macepci_irq,
+	.mask_ack = disable_macepci_irq,
+	.unmask = enable_macepci_irq,
 	.end = end_macepci_irq,
 };
 
@@ -339,7 +284,6 @@ static unsigned long maceisa_mask;
 static void enable_maceisa_irq (unsigned int irq)
 {
 	unsigned int crime_int = 0;
-	unsigned long flags;
 
 	DBG ("maceisa enable: %u\n", irq);
 
@@ -355,26 +299,16 @@ static void enable_maceisa_irq (unsigned
 		break;
 	}
 	DBG ("crime_int %08x enabled\n", crime_int);
-	spin_lock_irqsave(&ip32_irq_lock, flags);
 	crime_mask |= crime_int;
 	crime->imask = crime_mask;
 	maceisa_mask |= 1 << (irq - 33);
 	mace->perif.ctrl.imask = maceisa_mask;
-	spin_unlock_irqrestore(&ip32_irq_lock, flags);
-}
-
-static unsigned int startup_maceisa_irq(unsigned int irq)
-{
-	enable_maceisa_irq(irq);
-	return 0;
 }
 
 static void disable_maceisa_irq(unsigned int irq)
 {
 	unsigned int crime_int = 0;
-	unsigned long flags;
 
-	spin_lock_irqsave(&ip32_irq_lock, flags);
 	maceisa_mask &= ~(1 << (irq - 33));
         if(!(maceisa_mask & MACEISA_AUDIO_INT))
 		crime_int |= MACE_AUDIO_INT;
@@ -387,23 +321,20 @@ static void disable_maceisa_irq(unsigned
 	flush_crime_bus();
 	mace->perif.ctrl.imask = maceisa_mask;
 	flush_mace_bus();
-	spin_unlock_irqrestore(&ip32_irq_lock, flags);
 }
 
 static void mask_and_ack_maceisa_irq(unsigned int irq)
 {
-	unsigned long mace_int, flags;
+	unsigned long mace_int;
 
 	switch (irq) {
 	case MACEISA_PARALLEL_IRQ:
 	case MACEISA_SERIAL1_TDMAPR_IRQ:
 	case MACEISA_SERIAL2_TDMAPR_IRQ:
 		/* edge triggered */
-		spin_lock_irqsave(&ip32_irq_lock, flags);
 		mace_int = mace->perif.ctrl.istat;
 		mace_int &= ~(1 << (irq - 33));
 		mace->perif.ctrl.istat = mace_int;
-		spin_unlock_irqrestore(&ip32_irq_lock, flags);
 		break;
 	}
 	disable_maceisa_irq(irq);
@@ -415,15 +346,12 @@ static void end_maceisa_irq(unsigned irq
 		enable_maceisa_irq(irq);
 }
 
-#define shutdown_maceisa_irq disable_maceisa_irq
-
 static struct irq_chip ip32_maceisa_interrupt = {
 	.typename = "IP32 MACE ISA",
-	.startup = startup_maceisa_irq,
-	.shutdown = shutdown_maceisa_irq,
-	.enable = enable_maceisa_irq,
-	.disable = disable_maceisa_irq,
 	.ack = mask_and_ack_maceisa_irq,
+	.mask = disable_maceisa_irq,
+	.mask_ack = mask_and_ack_maceisa_irq,
+	.unmask = enable_maceisa_irq,
 	.end = end_maceisa_irq,
 };
 
@@ -433,29 +361,15 @@ static struct irq_chip ip32_maceisa_inte
 
 static void enable_mace_irq(unsigned int irq)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&ip32_irq_lock, flags);
 	crime_mask |= 1 << (irq - 1);
 	crime->imask = crime_mask;
-	spin_unlock_irqrestore(&ip32_irq_lock, flags);
-}
-
-static unsigned int startup_mace_irq(unsigned int irq)
-{
-	enable_mace_irq(irq);
-	return 0;
 }
 
 static void disable_mace_irq(unsigned int irq)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&ip32_irq_lock, flags);
 	crime_mask &= ~(1 << (irq - 1));
 	crime->imask = crime_mask;
 	flush_crime_bus();
-	spin_unlock_irqrestore(&ip32_irq_lock, flags);
 }
 
 static void end_mace_irq(unsigned int irq)
@@ -464,16 +378,12 @@ static void end_mace_irq(unsigned int ir
 		enable_mace_irq(irq);
 }
 
-#define shutdown_mace_irq disable_mace_irq
-#define mask_and_ack_mace_irq disable_mace_irq
-
 static struct irq_chip ip32_mace_interrupt = {
 	.typename = "IP32 MACE",
-	.startup = startup_mace_irq,
-	.shutdown = shutdown_mace_irq,
-	.enable = enable_mace_irq,
-	.disable = disable_mace_irq,
-	.ack = mask_and_ack_mace_irq,
+	.ack = disable_mace_irq,
+	.mask = disable_mace_irq,
+	.mask_ack = disable_mace_irq,
+	.unmask = enable_mace_irq,
 	.end = end_mace_irq,
 };
 
@@ -586,10 +496,7 @@ void __init arch_init_irq(void)
 		else
 			controller = &ip32_maceisa_interrupt;
 
-		irq_desc[irq].status = IRQ_DISABLED;
-		irq_desc[irq].action = 0;
-		irq_desc[irq].depth = 0;
-		irq_desc[irq].chip = controller;
+		set_irq_chip(irq, controller);
 	}
 	setup_irq(CRIME_MEMERR_IRQ, &memerr_irq);
 	setup_irq(CRIME_CPUERR_IRQ, &cpuerr_irq);
diff --git a/arch/mips/sibyte/bcm1480/irq.c b/arch/mips/sibyte/bcm1480/irq.c
index 8b1f414..2e8f6b2 100644
--- a/arch/mips/sibyte/bcm1480/irq.c
+++ b/arch/mips/sibyte/bcm1480/irq.c
@@ -45,11 +45,9 @@ #include <asm/sibyte/sb1250.h>
  */
 
 
-#define shutdown_bcm1480_irq	disable_bcm1480_irq
 static void end_bcm1480_irq(unsigned int irq);
 static void enable_bcm1480_irq(unsigned int irq);
 static void disable_bcm1480_irq(unsigned int irq);
-static unsigned int startup_bcm1480_irq(unsigned int irq);
 static void ack_bcm1480_irq(unsigned int irq);
 #ifdef CONFIG_SMP
 static void bcm1480_set_affinity(unsigned int irq, cpumask_t mask);
@@ -85,11 +83,10 @@ #endif
 
 static struct irq_chip bcm1480_irq_type = {
 	.typename = "BCM1480-IMR",
-	.startup = startup_bcm1480_irq,
-	.shutdown = shutdown_bcm1480_irq,
-	.enable = enable_bcm1480_irq,
-	.disable = disable_bcm1480_irq,
 	.ack = ack_bcm1480_irq,
+	.mask = disable_bcm1480_irq,
+	.mask_ack = ack_bcm1480_irq,
+	.unmask = enable_bcm1480_irq,
 	.end = end_bcm1480_irq,
 #ifdef CONFIG_SMP
 	.set_affinity = bcm1480_set_affinity
@@ -188,14 +185,6 @@ #endif
 
 /*****************************************************************************/
 
-static unsigned int startup_bcm1480_irq(unsigned int irq)
-{
-	bcm1480_unmask_irq(bcm1480_irq_owner[irq], irq);
-
-	return 0;		/* never anything pending */
-}
-
-
 static void disable_bcm1480_irq(unsigned int irq)
 {
 	bcm1480_mask_irq(bcm1480_irq_owner[irq], irq);
@@ -270,16 +259,9 @@ void __init init_bcm1480_irqs(void)
 {
 	int i;
 
-	for (i = 0; i < NR_IRQS; i++) {
-		irq_desc[i].status = IRQ_DISABLED;
-		irq_desc[i].action = 0;
-		irq_desc[i].depth = 1;
-		if (i < BCM1480_NR_IRQS) {
-			irq_desc[i].chip = &bcm1480_irq_type;
-			bcm1480_irq_owner[i] = 0;
-		} else {
-			irq_desc[i].chip = &no_irq_chip;
-		}
+	for (i = 0; i < BCM1480_NR_IRQS; i++) {
+		set_irq_chip(i, &bcm1480_irq_type);
+		bcm1480_irq_owner[i] = 0;
 	}
 }
 
diff --git a/arch/mips/sibyte/sb1250/irq.c b/arch/mips/sibyte/sb1250/irq.c
index d5d2677..82ce753 100644
--- a/arch/mips/sibyte/sb1250/irq.c
+++ b/arch/mips/sibyte/sb1250/irq.c
@@ -44,11 +44,9 @@ #include <asm/sibyte/sb1250.h>
  */
 
 
-#define shutdown_sb1250_irq	disable_sb1250_irq
 static void end_sb1250_irq(unsigned int irq);
 static void enable_sb1250_irq(unsigned int irq);
 static void disable_sb1250_irq(unsigned int irq);
-static unsigned int startup_sb1250_irq(unsigned int irq);
 static void ack_sb1250_irq(unsigned int irq);
 #ifdef CONFIG_SMP
 static void sb1250_set_affinity(unsigned int irq, cpumask_t mask);
@@ -70,11 +68,10 @@ #endif
 
 static struct irq_chip sb1250_irq_type = {
 	.typename = "SB1250-IMR",
-	.startup = startup_sb1250_irq,
-	.shutdown = shutdown_sb1250_irq,
-	.enable = enable_sb1250_irq,
-	.disable = disable_sb1250_irq,
 	.ack = ack_sb1250_irq,
+	.mask = disable_sb1250_irq,
+	.mask_ack = ack_sb1250_irq,
+	.unmask = enable_sb1250_irq,
 	.end = end_sb1250_irq,
 #ifdef CONFIG_SMP
 	.set_affinity = sb1250_set_affinity
@@ -163,14 +160,6 @@ #endif
 
 /*****************************************************************************/
 
-static unsigned int startup_sb1250_irq(unsigned int irq)
-{
-	sb1250_unmask_irq(sb1250_irq_owner[irq], irq);
-
-	return 0;		/* never anything pending */
-}
-
-
 static void disable_sb1250_irq(unsigned int irq)
 {
 	sb1250_mask_irq(sb1250_irq_owner[irq], irq);
@@ -239,16 +228,9 @@ void __init init_sb1250_irqs(void)
 {
 	int i;
 
-	for (i = 0; i < NR_IRQS; i++) {
-		irq_desc[i].status = IRQ_DISABLED;
-		irq_desc[i].action = 0;
-		irq_desc[i].depth = 1;
-		if (i < SB1250_NR_IRQS) {
-			irq_desc[i].chip = &sb1250_irq_type;
-			sb1250_irq_owner[i] = 0;
-		} else {
-			irq_desc[i].chip = &no_irq_chip;
-		}
+	for (i = 0; i < SB1250_NR_IRQS; i++) {
+		set_irq_chip(i, &sb1250_irq_type);
+		sb1250_irq_owner[i] = 0;
 	}
 }
 
diff --git a/arch/mips/sni/irq.c b/arch/mips/sni/irq.c
index 48fb74a..8511bcc 100644
--- a/arch/mips/sni/irq.c
+++ b/arch/mips/sni/irq.c
@@ -11,44 +11,25 @@ #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/kernel.h>
-#include <linux/spinlock.h>
 
 #include <asm/i8259.h>
 #include <asm/io.h>
 #include <asm/sni.h>
 
-DEFINE_SPINLOCK(pciasic_lock);
-
 static void enable_pciasic_irq(unsigned int irq)
 {
 	unsigned int mask = 1 << (irq - PCIMT_IRQ_INT2);
-	unsigned long flags;
 
-	spin_lock_irqsave(&pciasic_lock, flags);
 	*(volatile u8 *) PCIMT_IRQSEL |= mask;
-	spin_unlock_irqrestore(&pciasic_lock, flags);
-}
-
-static unsigned int startup_pciasic_irq(unsigned int irq)
-{
-	enable_pciasic_irq(irq);
-	return 0; /* never anything pending */
 }
 
-#define shutdown_pciasic_irq	disable_pciasic_irq
-
 void disable_pciasic_irq(unsigned int irq)
 {
 	unsigned int mask = ~(1 << (irq - PCIMT_IRQ_INT2));
-	unsigned long flags;
 
-	spin_lock_irqsave(&pciasic_lock, flags);
 	*(volatile u8 *) PCIMT_IRQSEL &= mask;
-	spin_unlock_irqrestore(&pciasic_lock, flags);
 }
 
-#define mask_and_ack_pciasic_irq disable_pciasic_irq
-
 static void end_pciasic_irq(unsigned int irq)
 {
 	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
@@ -57,11 +38,10 @@ static void end_pciasic_irq(unsigned int
 
 static struct irq_chip pciasic_irq_type = {
 	.typename = "ASIC-PCI",
-	.startup = startup_pciasic_irq,
-	.shutdown = shutdown_pciasic_irq,
-	.enable = enable_pciasic_irq,
-	.disable = disable_pciasic_irq,
-	.ack = mask_and_ack_pciasic_irq,
+	.ack = disable_pciasic_irq,
+	.mask = disable_pciasic_irq,
+	.mask_ack = disable_pciasic_irq,
+	.unmask = enable_pciasic_irq,
 	.end = end_pciasic_irq,
 };
 
@@ -178,12 +158,8 @@ asmlinkage void plat_irq_dispatch(void)
 
 void __init init_pciasic(void)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&pciasic_lock, flags);
 	* (volatile u8 *) PCIMT_IRQSEL =
 		IT_EISA | IT_INTA | IT_INTB | IT_INTC | IT_INTD;
-	spin_unlock_irqrestore(&pciasic_lock, flags);
 }
 
 /*
@@ -199,12 +175,8 @@ void __init arch_init_irq(void)
 	init_pciasic();
 
 	/* Actually we've got more interrupts to handle ...  */
-	for (i = PCIMT_IRQ_INT2; i <= PCIMT_IRQ_ETHERNET; i++) {
-		irq_desc[i].status     = IRQ_DISABLED;
-		irq_desc[i].action     = 0;
-		irq_desc[i].depth      = 1;
-		irq_desc[i].chip    = &pciasic_irq_type;
-	}
+	for (i = PCIMT_IRQ_INT2; i <= PCIMT_IRQ_ETHERNET; i++)
+		set_irq_chip(i, &pciasic_irq_type);
 
 	change_c0_status(ST0_IM, IE_IRQ1|IE_IRQ2|IE_IRQ3|IE_IRQ4);
 }
diff --git a/arch/mips/tx4927/common/tx4927_irq.c b/arch/mips/tx4927/common/tx4927_irq.c
index 8266a88..2c57ced 100644
--- a/arch/mips/tx4927/common/tx4927_irq.c
+++ b/arch/mips/tx4927/common/tx4927_irq.c
@@ -64,19 +64,13 @@ #define TX4927_IRQ_NEST3       ( 1 <<  8
 #define TX4927_IRQ_NEST4       ( 1 <<  9 )
 
 #define TX4927_IRQ_CP0_INIT     ( 1 << 10 )
-#define TX4927_IRQ_CP0_STARTUP  ( 1 << 11 )
-#define TX4927_IRQ_CP0_SHUTDOWN ( 1 << 12 )
 #define TX4927_IRQ_CP0_ENABLE   ( 1 << 13 )
 #define TX4927_IRQ_CP0_DISABLE  ( 1 << 14 )
-#define TX4927_IRQ_CP0_MASK     ( 1 << 15 )
 #define TX4927_IRQ_CP0_ENDIRQ   ( 1 << 16 )
 
 #define TX4927_IRQ_PIC_INIT     ( 1 << 20 )
-#define TX4927_IRQ_PIC_STARTUP  ( 1 << 21 )
-#define TX4927_IRQ_PIC_SHUTDOWN ( 1 << 22 )
 #define TX4927_IRQ_PIC_ENABLE   ( 1 << 23 )
 #define TX4927_IRQ_PIC_DISABLE  ( 1 << 24 )
-#define TX4927_IRQ_PIC_MASK     ( 1 << 25 )
 #define TX4927_IRQ_PIC_ENDIRQ   ( 1 << 26 )
 
 #define TX4927_IRQ_ALL         0xffffffff
@@ -87,18 +81,12 @@ static const u32 tx4927_irq_debug_flag =
 					  | TX4927_IRQ_INFO
 					  | TX4927_IRQ_WARN | TX4927_IRQ_EROR
 //                                       | TX4927_IRQ_CP0_INIT
-//                                       | TX4927_IRQ_CP0_STARTUP
-//                                       | TX4927_IRQ_CP0_SHUTDOWN
 //                                       | TX4927_IRQ_CP0_ENABLE
 //                                       | TX4927_IRQ_CP0_DISABLE
-//                                       | TX4927_IRQ_CP0_MASK
 //                                       | TX4927_IRQ_CP0_ENDIRQ
 //                                       | TX4927_IRQ_PIC_INIT
-//                                       | TX4927_IRQ_PIC_STARTUP
-//                                       | TX4927_IRQ_PIC_SHUTDOWN
 //                                       | TX4927_IRQ_PIC_ENABLE
 //                                       | TX4927_IRQ_PIC_DISABLE
-//                                       | TX4927_IRQ_PIC_MASK
 //                                       | TX4927_IRQ_PIC_ENDIRQ
 //                                       | TX4927_IRQ_INIT
 //                                       | TX4927_IRQ_NEST1
@@ -124,49 +112,36 @@ #endif
  * Forwad definitions for all pic's
  */
 
-static unsigned int tx4927_irq_cp0_startup(unsigned int irq);
-static void tx4927_irq_cp0_shutdown(unsigned int irq);
 static void tx4927_irq_cp0_enable(unsigned int irq);
 static void tx4927_irq_cp0_disable(unsigned int irq);
-static void tx4927_irq_cp0_mask_and_ack(unsigned int irq);
 static void tx4927_irq_cp0_end(unsigned int irq);
 
-static unsigned int tx4927_irq_pic_startup(unsigned int irq);
-static void tx4927_irq_pic_shutdown(unsigned int irq);
 static void tx4927_irq_pic_enable(unsigned int irq);
 static void tx4927_irq_pic_disable(unsigned int irq);
-static void tx4927_irq_pic_mask_and_ack(unsigned int irq);
 static void tx4927_irq_pic_end(unsigned int irq);
 
 /*
  * Kernel structs for all pic's
  */
 
-static DEFINE_SPINLOCK(tx4927_cp0_lock);
-static DEFINE_SPINLOCK(tx4927_pic_lock);
-
 #define TX4927_CP0_NAME "TX4927-CP0"
 static struct irq_chip tx4927_irq_cp0_type = {
 	.typename	= TX4927_CP0_NAME,
-	.startup	= tx4927_irq_cp0_startup,
-	.shutdown	= tx4927_irq_cp0_shutdown,
-	.enable		= tx4927_irq_cp0_enable,
-	.disable	= tx4927_irq_cp0_disable,
-	.ack		= tx4927_irq_cp0_mask_and_ack,
+	.ack		= tx4927_irq_cp0_disable,
+	.mask		= tx4927_irq_cp0_disable,
+	.mask_ack	= tx4927_irq_cp0_disable,
+	.unmask		= tx4927_irq_cp0_enable,
 	.end		= tx4927_irq_cp0_end,
-	.set_affinity	= NULL
 };
 
 #define TX4927_PIC_NAME "TX4927-PIC"
 static struct irq_chip tx4927_irq_pic_type = {
 	.typename	= TX4927_PIC_NAME,
-	.startup	= tx4927_irq_pic_startup,
-	.shutdown	= tx4927_irq_pic_shutdown,
-	.enable		= tx4927_irq_pic_enable,
-	.disable	= tx4927_irq_pic_disable,
-	.ack		= tx4927_irq_pic_mask_and_ack,
+	.ack		= tx4927_irq_pic_disable,
+	.mask		= tx4927_irq_pic_disable,
+	.mask_ack	= tx4927_irq_pic_disable,
+	.unmask		= tx4927_irq_pic_enable,
 	.end		= tx4927_irq_pic_end,
-	.set_affinity	= NULL
 };
 
 #define TX4927_PIC_ACTION(s) { no_action, 0, CPU_MASK_NONE, s, NULL, NULL }
@@ -211,8 +186,6 @@ tx4927_irq_cp0_modify(unsigned cp0_reg, 
 			break;
 		}
 	}
-
-	return;
 }
 
 static void __init tx4927_irq_cp0_init(void)
@@ -222,71 +195,22 @@ static void __init tx4927_irq_cp0_init(v
 	TX4927_IRQ_DPRINTK(TX4927_IRQ_CP0_INIT, "beg=%d end=%d\n",
 			   TX4927_IRQ_CP0_BEG, TX4927_IRQ_CP0_END);
 
-	for (i = TX4927_IRQ_CP0_BEG; i <= TX4927_IRQ_CP0_END; i++) {
-		irq_desc[i].status = IRQ_DISABLED;
-		irq_desc[i].action = 0;
-		irq_desc[i].depth = 1;
-		irq_desc[i].chip = &tx4927_irq_cp0_type;
-	}
-
-	return;
-}
-
-static unsigned int tx4927_irq_cp0_startup(unsigned int irq)
-{
-	TX4927_IRQ_DPRINTK(TX4927_IRQ_CP0_STARTUP, "irq=%d \n", irq);
-
-	tx4927_irq_cp0_enable(irq);
-
-	return (0);
-}
-
-static void tx4927_irq_cp0_shutdown(unsigned int irq)
-{
-	TX4927_IRQ_DPRINTK(TX4927_IRQ_CP0_SHUTDOWN, "irq=%d \n", irq);
-
-	tx4927_irq_cp0_disable(irq);
-
-	return;
+	for (i = TX4927_IRQ_CP0_BEG; i <= TX4927_IRQ_CP0_END; i++)
+		set_irq_chip(i, &tx4927_irq_cp0_type);
 }
 
 static void tx4927_irq_cp0_enable(unsigned int irq)
 {
-	unsigned long flags;
-
 	TX4927_IRQ_DPRINTK(TX4927_IRQ_CP0_ENABLE, "irq=%d \n", irq);
 
-	spin_lock_irqsave(&tx4927_cp0_lock, flags);
-
 	tx4927_irq_cp0_modify(CCP0_STATUS, 0, tx4927_irq_cp0_mask(irq));
-
-	spin_unlock_irqrestore(&tx4927_cp0_lock, flags);
-
-	return;
 }
 
 static void tx4927_irq_cp0_disable(unsigned int irq)
 {
-	unsigned long flags;
-
 	TX4927_IRQ_DPRINTK(TX4927_IRQ_CP0_DISABLE, "irq=%d \n", irq);
 
-	spin_lock_irqsave(&tx4927_cp0_lock, flags);
-
 	tx4927_irq_cp0_modify(CCP0_STATUS, tx4927_irq_cp0_mask(irq), 0);
-
-	spin_unlock_irqrestore(&tx4927_cp0_lock, flags);
-
-	return;
-}
-
-static void tx4927_irq_cp0_mask_and_ack(unsigned int irq)
-{
-	TX4927_IRQ_DPRINTK(TX4927_IRQ_CP0_MASK, "irq=%d \n", irq);
-
-	tx4927_irq_cp0_disable(irq);
-
-	return;
 }
 
 static void tx4927_irq_cp0_end(unsigned int irq)
@@ -296,8 +220,6 @@ static void tx4927_irq_cp0_end(unsigned 
 	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS))) {
 		tx4927_irq_cp0_enable(irq);
 	}
-
-	return;
 }
 
 /*
@@ -418,94 +340,38 @@ static void tx4927_irq_pic_modify(unsign
 	val &= (~clr_bits);
 	val |= (set_bits);
 	TX4927_WR(pic_reg, val);
-
-	return;
 }
 
 static void __init tx4927_irq_pic_init(void)
 {
-	unsigned long flags;
 	int i;
 
 	TX4927_IRQ_DPRINTK(TX4927_IRQ_PIC_INIT, "beg=%d end=%d\n",
 			   TX4927_IRQ_PIC_BEG, TX4927_IRQ_PIC_END);
 
-	for (i = TX4927_IRQ_PIC_BEG; i <= TX4927_IRQ_PIC_END; i++) {
-		irq_desc[i].status = IRQ_DISABLED;
-		irq_desc[i].action = 0;
-		irq_desc[i].depth = 2;
-		irq_desc[i].chip = &tx4927_irq_pic_type;
-	}
+	for (i = TX4927_IRQ_PIC_BEG; i <= TX4927_IRQ_PIC_END; i++)
+		set_irq_chip(i, &tx4927_irq_pic_type);
 
 	setup_irq(TX4927_IRQ_NEST_PIC_ON_CP0, &tx4927_irq_pic_action);
 
-	spin_lock_irqsave(&tx4927_pic_lock, flags);
-
 	TX4927_WR(0xff1ff640, 0x6);	/* irq level mask -- only accept hightest */
 	TX4927_WR(0xff1ff600, TX4927_RD(0xff1ff600) | 0x1);	/* irq enable */
-
-	spin_unlock_irqrestore(&tx4927_pic_lock, flags);
-
-	return;
-}
-
-static unsigned int tx4927_irq_pic_startup(unsigned int irq)
-{
-	TX4927_IRQ_DPRINTK(TX4927_IRQ_PIC_STARTUP, "irq=%d\n", irq);
-
-	tx4927_irq_pic_enable(irq);
-
-	return (0);
-}
-
-static void tx4927_irq_pic_shutdown(unsigned int irq)
-{
-	TX4927_IRQ_DPRINTK(TX4927_IRQ_PIC_SHUTDOWN, "irq=%d\n", irq);
-
-	tx4927_irq_pic_disable(irq);
-
-	return;
 }
 
 static void tx4927_irq_pic_enable(unsigned int irq)
 {
-	unsigned long flags;
-
 	TX4927_IRQ_DPRINTK(TX4927_IRQ_PIC_ENABLE, "irq=%d\n", irq);
 
-	spin_lock_irqsave(&tx4927_pic_lock, flags);
-
 	tx4927_irq_pic_modify(tx4927_irq_pic_addr(irq), 0,
 			      tx4927_irq_pic_mask(irq));
-
-	spin_unlock_irqrestore(&tx4927_pic_lock, flags);
-
-	return;
 }
 
 static void tx4927_irq_pic_disable(unsigned int irq)
 {
-	unsigned long flags;
-
 	TX4927_IRQ_DPRINTK(TX4927_IRQ_PIC_DISABLE, "irq=%d\n", irq);
 
-	spin_lock_irqsave(&tx4927_pic_lock, flags);
-
 	tx4927_irq_pic_modify(tx4927_irq_pic_addr(irq),
 			      tx4927_irq_pic_mask(irq), 0);
-
-	spin_unlock_irqrestore(&tx4927_pic_lock, flags);
-
-	return;
-}
-
-static void tx4927_irq_pic_mask_and_ack(unsigned int irq)
-{
-	TX4927_IRQ_DPRINTK(TX4927_IRQ_PIC_MASK, "irq=%d\n", irq);
-
-	tx4927_irq_pic_disable(irq);
-
-	return;
 }
 
 static void tx4927_irq_pic_end(unsigned int irq)
@@ -515,8 +381,6 @@ static void tx4927_irq_pic_end(unsigned 
 	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS))) {
 		tx4927_irq_pic_enable(irq);
 	}
-
-	return;
 }
 
 /*
@@ -533,8 +397,6 @@ void __init tx4927_irq_init(void)
 	tx4927_irq_pic_init();
 
 	TX4927_IRQ_DPRINTK(TX4927_IRQ_INIT, "+\n");
-
-	return;
 }
 
 static int tx4927_irq_nested(void)
diff --git a/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c b/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c
index 0c3c3f6..1040ab3 100644
--- a/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c
+++ b/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c
@@ -151,16 +151,11 @@ #define TOSHIBA_RBTX4927_IRQ_WARN       
 #define TOSHIBA_RBTX4927_IRQ_EROR          ( 1 <<  2 )
 
 #define TOSHIBA_RBTX4927_IRQ_IOC_INIT      ( 1 << 10 )
-#define TOSHIBA_RBTX4927_IRQ_IOC_STARTUP   ( 1 << 11 )
-#define TOSHIBA_RBTX4927_IRQ_IOC_SHUTDOWN  ( 1 << 12 )
 #define TOSHIBA_RBTX4927_IRQ_IOC_ENABLE    ( 1 << 13 )
 #define TOSHIBA_RBTX4927_IRQ_IOC_DISABLE   ( 1 << 14 )
-#define TOSHIBA_RBTX4927_IRQ_IOC_MASK      ( 1 << 15 )
 #define TOSHIBA_RBTX4927_IRQ_IOC_ENDIRQ    ( 1 << 16 )
 
 #define TOSHIBA_RBTX4927_IRQ_ISA_INIT      ( 1 << 20 )
-#define TOSHIBA_RBTX4927_IRQ_ISA_STARTUP   ( 1 << 21 )
-#define TOSHIBA_RBTX4927_IRQ_ISA_SHUTDOWN  ( 1 << 22 )
 #define TOSHIBA_RBTX4927_IRQ_ISA_ENABLE    ( 1 << 23 )
 #define TOSHIBA_RBTX4927_IRQ_ISA_DISABLE   ( 1 << 24 )
 #define TOSHIBA_RBTX4927_IRQ_ISA_MASK      ( 1 << 25 )
@@ -175,15 +170,10 @@ static const u32 toshiba_rbtx4927_irq_de
     (TOSHIBA_RBTX4927_IRQ_NONE | TOSHIBA_RBTX4927_IRQ_INFO |
      TOSHIBA_RBTX4927_IRQ_WARN | TOSHIBA_RBTX4927_IRQ_EROR
 //                                                 | TOSHIBA_RBTX4927_IRQ_IOC_INIT
-//                                                 | TOSHIBA_RBTX4927_IRQ_IOC_STARTUP
-//                                                 | TOSHIBA_RBTX4927_IRQ_IOC_SHUTDOWN
 //                                                 | TOSHIBA_RBTX4927_IRQ_IOC_ENABLE
 //                                                 | TOSHIBA_RBTX4927_IRQ_IOC_DISABLE
-//                                                 | TOSHIBA_RBTX4927_IRQ_IOC_MASK
 //                                                 | TOSHIBA_RBTX4927_IRQ_IOC_ENDIRQ
 //                                                 | TOSHIBA_RBTX4927_IRQ_ISA_INIT
-//                                                 | TOSHIBA_RBTX4927_IRQ_ISA_STARTUP
-//                                                 | TOSHIBA_RBTX4927_IRQ_ISA_SHUTDOWN
 //                                                 | TOSHIBA_RBTX4927_IRQ_ISA_ENABLE
 //                                                 | TOSHIBA_RBTX4927_IRQ_ISA_DISABLE
 //                                                 | TOSHIBA_RBTX4927_IRQ_ISA_MASK
@@ -231,35 +221,25 @@ extern void disable_8259A_irq(unsigned i
 extern void mask_and_ack_8259A(unsigned int irq);
 #endif
 
-static unsigned int toshiba_rbtx4927_irq_ioc_startup(unsigned int irq);
-static void toshiba_rbtx4927_irq_ioc_shutdown(unsigned int irq);
 static void toshiba_rbtx4927_irq_ioc_enable(unsigned int irq);
 static void toshiba_rbtx4927_irq_ioc_disable(unsigned int irq);
-static void toshiba_rbtx4927_irq_ioc_mask_and_ack(unsigned int irq);
 static void toshiba_rbtx4927_irq_ioc_end(unsigned int irq);
 
 #ifdef CONFIG_TOSHIBA_FPCIB0
-static unsigned int toshiba_rbtx4927_irq_isa_startup(unsigned int irq);
-static void toshiba_rbtx4927_irq_isa_shutdown(unsigned int irq);
 static void toshiba_rbtx4927_irq_isa_enable(unsigned int irq);
 static void toshiba_rbtx4927_irq_isa_disable(unsigned int irq);
 static void toshiba_rbtx4927_irq_isa_mask_and_ack(unsigned int irq);
 static void toshiba_rbtx4927_irq_isa_end(unsigned int irq);
 #endif
 
-static DEFINE_SPINLOCK(toshiba_rbtx4927_ioc_lock);
-
-
 #define TOSHIBA_RBTX4927_IOC_NAME "RBTX4927-IOC"
 static struct irq_chip toshiba_rbtx4927_irq_ioc_type = {
 	.typename = TOSHIBA_RBTX4927_IOC_NAME,
-	.startup = toshiba_rbtx4927_irq_ioc_startup,
-	.shutdown = toshiba_rbtx4927_irq_ioc_shutdown,
-	.enable = toshiba_rbtx4927_irq_ioc_enable,
-	.disable = toshiba_rbtx4927_irq_ioc_disable,
-	.ack = toshiba_rbtx4927_irq_ioc_mask_and_ack,
+	.ack = toshiba_rbtx4927_irq_ioc_disable,
+	.mask = toshiba_rbtx4927_irq_ioc_disable,
+	.mask_ack = toshiba_rbtx4927_irq_ioc_disable,
+	.unmask = toshiba_rbtx4927_irq_ioc_enable,
 	.end = toshiba_rbtx4927_irq_ioc_end,
-	.set_affinity = NULL
 };
 #define TOSHIBA_RBTX4927_IOC_INTR_ENAB 0xbc002000
 #define TOSHIBA_RBTX4927_IOC_INTR_STAT 0xbc002006
@@ -269,13 +249,11 @@ #ifdef CONFIG_TOSHIBA_FPCIB0
 #define TOSHIBA_RBTX4927_ISA_NAME "RBTX4927-ISA"
 static struct irq_chip toshiba_rbtx4927_irq_isa_type = {
 	.typename = TOSHIBA_RBTX4927_ISA_NAME,
-	.startup = toshiba_rbtx4927_irq_isa_startup,
-	.shutdown = toshiba_rbtx4927_irq_isa_shutdown,
-	.enable = toshiba_rbtx4927_irq_isa_enable,
-	.disable = toshiba_rbtx4927_irq_isa_disable,
 	.ack = toshiba_rbtx4927_irq_isa_mask_and_ack,
+	.mask = toshiba_rbtx4927_irq_isa_disable,
+	.mask_ack = toshiba_rbtx4927_irq_isa_mask_and_ack,
+	.unmask = toshiba_rbtx4927_irq_isa_enable,
 	.end = toshiba_rbtx4927_irq_isa_end,
-	.set_affinity = NULL
 };
 #endif
 
@@ -363,58 +341,15 @@ static void __init toshiba_rbtx4927_irq_
 				     TOSHIBA_RBTX4927_IRQ_IOC_END);
 
 	for (i = TOSHIBA_RBTX4927_IRQ_IOC_BEG;
-	     i <= TOSHIBA_RBTX4927_IRQ_IOC_END; i++) {
-		irq_desc[i].status = IRQ_DISABLED;
-		irq_desc[i].action = 0;
-		irq_desc[i].depth = 3;
-		irq_desc[i].chip = &toshiba_rbtx4927_irq_ioc_type;
-	}
+	     i <= TOSHIBA_RBTX4927_IRQ_IOC_END; i++)
+		set_irq_chip(i, &toshiba_rbtx4927_irq_ioc_type);
 
 	setup_irq(TOSHIBA_RBTX4927_IRQ_NEST_IOC_ON_PIC,
 		  &toshiba_rbtx4927_irq_ioc_action);
-
-	return;
 }
 
-static unsigned int toshiba_rbtx4927_irq_ioc_startup(unsigned int irq)
-{
-	TOSHIBA_RBTX4927_IRQ_DPRINTK(TOSHIBA_RBTX4927_IRQ_IOC_STARTUP,
-				     "irq=%d\n", irq);
-
-	if (irq < TOSHIBA_RBTX4927_IRQ_IOC_BEG
-	    || irq > TOSHIBA_RBTX4927_IRQ_IOC_END) {
-		TOSHIBA_RBTX4927_IRQ_DPRINTK(TOSHIBA_RBTX4927_IRQ_EROR,
-					     "bad irq=%d\n", irq);
-		panic("\n");
-	}
-
-	toshiba_rbtx4927_irq_ioc_enable(irq);
-
-	return (0);
-}
-
-
-static void toshiba_rbtx4927_irq_ioc_shutdown(unsigned int irq)
-{
-	TOSHIBA_RBTX4927_IRQ_DPRINTK(TOSHIBA_RBTX4927_IRQ_IOC_SHUTDOWN,
-				     "irq=%d\n", irq);
-
-	if (irq < TOSHIBA_RBTX4927_IRQ_IOC_BEG
-	    || irq > TOSHIBA_RBTX4927_IRQ_IOC_END) {
-		TOSHIBA_RBTX4927_IRQ_DPRINTK(TOSHIBA_RBTX4927_IRQ_EROR,
-					     "bad irq=%d\n", irq);
-		panic("\n");
-	}
-
-	toshiba_rbtx4927_irq_ioc_disable(irq);
-
-	return;
-}
-
-
 static void toshiba_rbtx4927_irq_ioc_enable(unsigned int irq)
 {
-	unsigned long flags;
 	volatile unsigned char v;
 
 	TOSHIBA_RBTX4927_IRQ_DPRINTK(TOSHIBA_RBTX4927_IRQ_IOC_ENABLE,
@@ -427,21 +362,14 @@ static void toshiba_rbtx4927_irq_ioc_ena
 		panic("\n");
 	}
 
-	spin_lock_irqsave(&toshiba_rbtx4927_ioc_lock, flags);
-
 	v = TX4927_RD08(TOSHIBA_RBTX4927_IOC_INTR_ENAB);
 	v |= (1 << (irq - TOSHIBA_RBTX4927_IRQ_IOC_BEG));
 	TOSHIBA_RBTX4927_WR08(TOSHIBA_RBTX4927_IOC_INTR_ENAB, v);
-
-	spin_unlock_irqrestore(&toshiba_rbtx4927_ioc_lock, flags);
-
-	return;
 }
 
 
 static void toshiba_rbtx4927_irq_ioc_disable(unsigned int irq)
 {
-	unsigned long flags;
 	volatile unsigned char v;
 
 	TOSHIBA_RBTX4927_IRQ_DPRINTK(TOSHIBA_RBTX4927_IRQ_IOC_DISABLE,
@@ -454,36 +382,11 @@ static void toshiba_rbtx4927_irq_ioc_dis
 		panic("\n");
 	}
 
-	spin_lock_irqsave(&toshiba_rbtx4927_ioc_lock, flags);
-
 	v = TX4927_RD08(TOSHIBA_RBTX4927_IOC_INTR_ENAB);
 	v &= ~(1 << (irq - TOSHIBA_RBTX4927_IRQ_IOC_BEG));
 	TOSHIBA_RBTX4927_WR08(TOSHIBA_RBTX4927_IOC_INTR_ENAB, v);
-
-	spin_unlock_irqrestore(&toshiba_rbtx4927_ioc_lock, flags);
-
-	return;
 }
 
-
-static void toshiba_rbtx4927_irq_ioc_mask_and_ack(unsigned int irq)
-{
-	TOSHIBA_RBTX4927_IRQ_DPRINTK(TOSHIBA_RBTX4927_IRQ_IOC_MASK,
-				     "irq=%d\n", irq);
-
-	if (irq < TOSHIBA_RBTX4927_IRQ_IOC_BEG
-	    || irq > TOSHIBA_RBTX4927_IRQ_IOC_END) {
-		TOSHIBA_RBTX4927_IRQ_DPRINTK(TOSHIBA_RBTX4927_IRQ_EROR,
-					     "bad irq=%d\n", irq);
-		panic("\n");
-	}
-
-	toshiba_rbtx4927_irq_ioc_disable(irq);
-
-	return;
-}
-
-
 static void toshiba_rbtx4927_irq_ioc_end(unsigned int irq)
 {
 	TOSHIBA_RBTX4927_IRQ_DPRINTK(TOSHIBA_RBTX4927_IRQ_IOC_ENDIRQ,
@@ -499,8 +402,6 @@ static void toshiba_rbtx4927_irq_ioc_end
 	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS))) {
 		toshiba_rbtx4927_irq_ioc_enable(irq);
 	}
-
-	return;
 }
 
 
@@ -520,13 +421,8 @@ static void __init toshiba_rbtx4927_irq_
 				     TOSHIBA_RBTX4927_IRQ_ISA_END);
 
 	for (i = TOSHIBA_RBTX4927_IRQ_ISA_BEG;
-	     i <= TOSHIBA_RBTX4927_IRQ_ISA_END; i++) {
-		irq_desc[i].status = IRQ_DISABLED;
-		irq_desc[i].action = 0;
-		irq_desc[i].depth =
-		    ((i < TOSHIBA_RBTX4927_IRQ_ISA_MID) ? (4) : (5));
-		irq_desc[i].chip = &toshiba_rbtx4927_irq_isa_type;
-	}
+	     i <= TOSHIBA_RBTX4927_IRQ_ISA_END; i++)
+		set_irq_chip(i, &toshiba_rbtx4927_irq_isa_type);
 
 	setup_irq(TOSHIBA_RBTX4927_IRQ_NEST_ISA_ON_IOC,
 		  &toshiba_rbtx4927_irq_isa_master);
@@ -537,48 +433,6 @@ static void __init toshiba_rbtx4927_irq_
 	outb(0x0A, 0x20);
 	outb(0x0A, 0xA0);
 
-	return;
-}
-#endif
-
-
-#ifdef CONFIG_TOSHIBA_FPCIB0
-static unsigned int toshiba_rbtx4927_irq_isa_startup(unsigned int irq)
-{
-	TOSHIBA_RBTX4927_IRQ_DPRINTK(TOSHIBA_RBTX4927_IRQ_ISA_STARTUP,
-				     "irq=%d\n", irq);
-
-	if (irq < TOSHIBA_RBTX4927_IRQ_ISA_BEG
-	    || irq > TOSHIBA_RBTX4927_IRQ_ISA_END) {
-		TOSHIBA_RBTX4927_IRQ_DPRINTK(TOSHIBA_RBTX4927_IRQ_EROR,
-					     "bad irq=%d\n", irq);
-		panic("\n");
-	}
-
-	toshiba_rbtx4927_irq_isa_enable(irq);
-
-	return (0);
-}
-#endif
-
-
-#ifdef CONFIG_TOSHIBA_FPCIB0
-static void toshiba_rbtx4927_irq_isa_shutdown(unsigned int irq)
-{
-	TOSHIBA_RBTX4927_IRQ_DPRINTK(TOSHIBA_RBTX4927_IRQ_ISA_SHUTDOWN,
-				     "irq=%d\n", irq);
-
-	if (irq < TOSHIBA_RBTX4927_IRQ_ISA_BEG
-	    || irq > TOSHIBA_RBTX4927_IRQ_ISA_END) {
-		TOSHIBA_RBTX4927_IRQ_DPRINTK(TOSHIBA_RBTX4927_IRQ_EROR,
-					     "bad irq=%d\n", irq);
-		panic("\n");
-	}
-
-	toshiba_rbtx4927_irq_isa_disable(irq);
-
-	return;
-}
 #endif
 
 
@@ -596,8 +450,6 @@ static void toshiba_rbtx4927_irq_isa_ena
 	}
 
 	enable_8259A_irq(irq);
-
-	return;
 }
 #endif
 
@@ -616,8 +468,6 @@ static void toshiba_rbtx4927_irq_isa_dis
 	}
 
 	disable_8259A_irq(irq);
-
-	return;
 }
 #endif
 
@@ -636,8 +486,6 @@ static void toshiba_rbtx4927_irq_isa_mas
 	}
 
 	mask_and_ack_8259A(irq);
-
-	return;
 }
 #endif
 
@@ -658,8 +506,6 @@ static void toshiba_rbtx4927_irq_isa_end
 	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS))) {
 		toshiba_rbtx4927_irq_isa_enable(irq);
 	}
-
-	return;
 }
 #endif
 
@@ -668,8 +514,6 @@ void __init arch_init_irq(void)
 {
 	extern void tx4927_irq_init(void);
 
-	local_irq_disable();
-
 	tx4927_irq_init();
 	toshiba_rbtx4927_irq_ioc_init();
 #ifdef CONFIG_TOSHIBA_FPCIB0
@@ -681,8 +525,6 @@ #ifdef CONFIG_TOSHIBA_FPCIB0
 #endif
 
 	wbflush();
-
-	return;
 }
 
 void toshiba_rbtx4927_irq_dump(char *key)
@@ -715,7 +557,6 @@ #ifdef TOSHIBA_RBTX4927_IRQ_DEBUG
 		}
 	}
 #endif
-	return;
 }
 
 void toshiba_rbtx4927_irq_dump_pics(char *s)
@@ -780,6 +621,4 @@ void toshiba_rbtx4927_irq_dump_pics(char
 				     level5_s);
 	TOSHIBA_RBTX4927_IRQ_DPRINTK(TOSHIBA_RBTX4927_IRQ_INFO, "[%s]\n",
 				     s);
-
-	return;
 }
diff --git a/arch/mips/tx4938/common/irq.c b/arch/mips/tx4938/common/irq.c
index 77fe245..19c9ee9 100644
--- a/arch/mips/tx4938/common/irq.c
+++ b/arch/mips/tx4938/common/irq.c
@@ -37,48 +37,36 @@ #include <asm/tx4938/rbtx4938.h>
 /* Forwad definitions for all pic's                                               */
 /**********************************************************************************/
 
-static unsigned int tx4938_irq_cp0_startup(unsigned int irq);
-static void tx4938_irq_cp0_shutdown(unsigned int irq);
 static void tx4938_irq_cp0_enable(unsigned int irq);
 static void tx4938_irq_cp0_disable(unsigned int irq);
-static void tx4938_irq_cp0_mask_and_ack(unsigned int irq);
 static void tx4938_irq_cp0_end(unsigned int irq);
 
-static unsigned int tx4938_irq_pic_startup(unsigned int irq);
-static void tx4938_irq_pic_shutdown(unsigned int irq);
 static void tx4938_irq_pic_enable(unsigned int irq);
 static void tx4938_irq_pic_disable(unsigned int irq);
-static void tx4938_irq_pic_mask_and_ack(unsigned int irq);
 static void tx4938_irq_pic_end(unsigned int irq);
 
 /**********************************************************************************/
 /* Kernel structs for all pic's                                                   */
 /**********************************************************************************/
-DEFINE_SPINLOCK(tx4938_cp0_lock);
-DEFINE_SPINLOCK(tx4938_pic_lock);
 
 #define TX4938_CP0_NAME "TX4938-CP0"
 static struct irq_chip tx4938_irq_cp0_type = {
 	.typename = TX4938_CP0_NAME,
-	.startup = tx4938_irq_cp0_startup,
-	.shutdown = tx4938_irq_cp0_shutdown,
-	.enable = tx4938_irq_cp0_enable,
-	.disable = tx4938_irq_cp0_disable,
-	.ack = tx4938_irq_cp0_mask_and_ack,
+	.ack = tx4938_irq_cp0_disable,
+	.mask = tx4938_irq_cp0_disable,
+	.mask_ack = tx4938_irq_cp0_disable,
+	.unmask = tx4938_irq_cp0_enable,
 	.end = tx4938_irq_cp0_end,
-	.set_affinity = NULL
 };
 
 #define TX4938_PIC_NAME "TX4938-PIC"
 static struct irq_chip tx4938_irq_pic_type = {
 	.typename = TX4938_PIC_NAME,
-	.startup = tx4938_irq_pic_startup,
-	.shutdown = tx4938_irq_pic_shutdown,
-	.enable = tx4938_irq_pic_enable,
-	.disable = tx4938_irq_pic_disable,
-	.ack = tx4938_irq_pic_mask_and_ack,
+	.ack = tx4938_irq_pic_disable,
+	.mask = tx4938_irq_pic_disable,
+	.mask_ack = tx4938_irq_pic_disable,
+	.unmask = tx4938_irq_pic_enable,
 	.end = tx4938_irq_pic_end,
-	.set_affinity = NULL
 };
 
 static struct irqaction tx4938_irq_pic_action = {
@@ -99,56 +87,20 @@ tx4938_irq_cp0_init(void)
 {
 	int i;
 
-	for (i = TX4938_IRQ_CP0_BEG; i <= TX4938_IRQ_CP0_END; i++) {
-		irq_desc[i].status = IRQ_DISABLED;
-		irq_desc[i].action = 0;
-		irq_desc[i].depth = 1;
-		irq_desc[i].chip = &tx4938_irq_cp0_type;
-	}
-}
-
-static unsigned int
-tx4938_irq_cp0_startup(unsigned int irq)
-{
-	tx4938_irq_cp0_enable(irq);
-
-	return 0;
-}
-
-static void
-tx4938_irq_cp0_shutdown(unsigned int irq)
-{
-	tx4938_irq_cp0_disable(irq);
+	for (i = TX4938_IRQ_CP0_BEG; i <= TX4938_IRQ_CP0_END; i++)
+		set_irq_chip(i, &tx4938_irq_cp0_type);
 }
 
 static void
 tx4938_irq_cp0_enable(unsigned int irq)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&tx4938_cp0_lock, flags);
-
 	set_c0_status(tx4938_irq_cp0_mask(irq));
-
-	spin_unlock_irqrestore(&tx4938_cp0_lock, flags);
 }
 
 static void
 tx4938_irq_cp0_disable(unsigned int irq)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&tx4938_cp0_lock, flags);
-
 	clear_c0_status(tx4938_irq_cp0_mask(irq));
-
-	spin_unlock_irqrestore(&tx4938_cp0_lock, flags);
-}
-
-static void
-tx4938_irq_cp0_mask_and_ack(unsigned int irq)
-{
-	tx4938_irq_cp0_disable(irq);
 }
 
 static void
@@ -290,70 +242,29 @@ tx4938_irq_pic_modify(unsigned pic_reg, 
 static void __init
 tx4938_irq_pic_init(void)
 {
-	unsigned long flags;
 	int i;
 
-	for (i = TX4938_IRQ_PIC_BEG; i <= TX4938_IRQ_PIC_END; i++) {
-		irq_desc[i].status = IRQ_DISABLED;
-		irq_desc[i].action = 0;
-		irq_desc[i].depth = 2;
-		irq_desc[i].chip = &tx4938_irq_pic_type;
-	}
+	for (i = TX4938_IRQ_PIC_BEG; i <= TX4938_IRQ_PIC_END; i++)
+		set_irq_chip(i, &tx4938_irq_pic_type);
 
 	setup_irq(TX4938_IRQ_NEST_PIC_ON_CP0, &tx4938_irq_pic_action);
 
-	spin_lock_irqsave(&tx4938_pic_lock, flags);
-
 	TX4938_WR(0xff1ff640, 0x6);	/* irq level mask -- only accept hightest */
 	TX4938_WR(0xff1ff600, TX4938_RD(0xff1ff600) | 0x1);	/* irq enable */
-
-	spin_unlock_irqrestore(&tx4938_pic_lock, flags);
-}
-
-static unsigned int
-tx4938_irq_pic_startup(unsigned int irq)
-{
-	tx4938_irq_pic_enable(irq);
-
-	return 0;
-}
-
-static void
-tx4938_irq_pic_shutdown(unsigned int irq)
-{
-	tx4938_irq_pic_disable(irq);
 }
 
 static void
 tx4938_irq_pic_enable(unsigned int irq)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&tx4938_pic_lock, flags);
-
 	tx4938_irq_pic_modify(tx4938_irq_pic_addr(irq), 0,
 			      tx4938_irq_pic_mask(irq));
-
-	spin_unlock_irqrestore(&tx4938_pic_lock, flags);
 }
 
 static void
 tx4938_irq_pic_disable(unsigned int irq)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&tx4938_pic_lock, flags);
-
 	tx4938_irq_pic_modify(tx4938_irq_pic_addr(irq),
 			      tx4938_irq_pic_mask(irq), 0);
-
-	spin_unlock_irqrestore(&tx4938_pic_lock, flags);
-}
-
-static void
-tx4938_irq_pic_mask_and_ack(unsigned int irq)
-{
-	tx4938_irq_pic_disable(irq);
 }
 
 static void
diff --git a/arch/mips/tx4938/toshiba_rbtx4938/irq.c b/arch/mips/tx4938/toshiba_rbtx4938/irq.c
index 102e473..2735ffe 100644
--- a/arch/mips/tx4938/toshiba_rbtx4938/irq.c
+++ b/arch/mips/tx4938/toshiba_rbtx4938/irq.c
@@ -87,25 +87,18 @@ #include <asm/wbflush.h>
 #include <linux/bootmem.h>
 #include <asm/tx4938/rbtx4938.h>
 
-static unsigned int toshiba_rbtx4938_irq_ioc_startup(unsigned int irq);
-static void toshiba_rbtx4938_irq_ioc_shutdown(unsigned int irq);
 static void toshiba_rbtx4938_irq_ioc_enable(unsigned int irq);
 static void toshiba_rbtx4938_irq_ioc_disable(unsigned int irq);
-static void toshiba_rbtx4938_irq_ioc_mask_and_ack(unsigned int irq);
 static void toshiba_rbtx4938_irq_ioc_end(unsigned int irq);
 
-DEFINE_SPINLOCK(toshiba_rbtx4938_ioc_lock);
-
 #define TOSHIBA_RBTX4938_IOC_NAME "RBTX4938-IOC"
 static struct irq_chip toshiba_rbtx4938_irq_ioc_type = {
 	.typename = TOSHIBA_RBTX4938_IOC_NAME,
-	.startup = toshiba_rbtx4938_irq_ioc_startup,
-	.shutdown = toshiba_rbtx4938_irq_ioc_shutdown,
-	.enable = toshiba_rbtx4938_irq_ioc_enable,
-	.disable = toshiba_rbtx4938_irq_ioc_disable,
-	.ack = toshiba_rbtx4938_irq_ioc_mask_and_ack,
+	.ack = toshiba_rbtx4938_irq_ioc_disable,
+	.mask = toshiba_rbtx4938_irq_ioc_disable,
+	.mask_ack = toshiba_rbtx4938_irq_ioc_disable,
+	.unmask = toshiba_rbtx4938_irq_ioc_enable,
 	.end = toshiba_rbtx4938_irq_ioc_end,
-	.set_affinity = NULL
 };
 
 #define TOSHIBA_RBTX4938_IOC_INTR_ENAB 0xb7f02000
@@ -142,69 +135,35 @@ toshiba_rbtx4938_irq_ioc_init(void)
 	int i;
 
 	for (i = TOSHIBA_RBTX4938_IRQ_IOC_BEG;
-	     i <= TOSHIBA_RBTX4938_IRQ_IOC_END; i++) {
-		irq_desc[i].status = IRQ_DISABLED;
-		irq_desc[i].action = 0;
-		irq_desc[i].depth = 3;
-		irq_desc[i].chip = &toshiba_rbtx4938_irq_ioc_type;
-	}
+	     i <= TOSHIBA_RBTX4938_IRQ_IOC_END; i++)
+		set_irq_chip(i, &toshiba_rbtx4938_irq_ioc_type);
 
 	setup_irq(RBTX4938_IRQ_IOCINT,
 		  &toshiba_rbtx4938_irq_ioc_action);
 }
 
-static unsigned int
-toshiba_rbtx4938_irq_ioc_startup(unsigned int irq)
-{
-	toshiba_rbtx4938_irq_ioc_enable(irq);
-
-	return 0;
-}
-
-static void
-toshiba_rbtx4938_irq_ioc_shutdown(unsigned int irq)
-{
-	toshiba_rbtx4938_irq_ioc_disable(irq);
-}
-
 static void
 toshiba_rbtx4938_irq_ioc_enable(unsigned int irq)
 {
-	unsigned long flags;
 	volatile unsigned char v;
 
-	spin_lock_irqsave(&toshiba_rbtx4938_ioc_lock, flags);
-
 	v = TX4938_RD08(TOSHIBA_RBTX4938_IOC_INTR_ENAB);
 	v |= (1 << (irq - TOSHIBA_RBTX4938_IRQ_IOC_BEG));
 	TX4938_WR08(TOSHIBA_RBTX4938_IOC_INTR_ENAB, v);
 	mmiowb();
 	TX4938_RD08(TOSHIBA_RBTX4938_IOC_INTR_ENAB);
-
-	spin_unlock_irqrestore(&toshiba_rbtx4938_ioc_lock, flags);
 }
 
 static void
 toshiba_rbtx4938_irq_ioc_disable(unsigned int irq)
 {
-	unsigned long flags;
 	volatile unsigned char v;
 
-	spin_lock_irqsave(&toshiba_rbtx4938_ioc_lock, flags);
-
 	v = TX4938_RD08(TOSHIBA_RBTX4938_IOC_INTR_ENAB);
 	v &= ~(1 << (irq - TOSHIBA_RBTX4938_IRQ_IOC_BEG));
 	TX4938_WR08(TOSHIBA_RBTX4938_IOC_INTR_ENAB, v);
 	mmiowb();
 	TX4938_RD08(TOSHIBA_RBTX4938_IOC_INTR_ENAB);
-
-	spin_unlock_irqrestore(&toshiba_rbtx4938_ioc_lock, flags);
-}
-
-static void
-toshiba_rbtx4938_irq_ioc_mask_and_ack(unsigned int irq)
-{
-	toshiba_rbtx4938_irq_ioc_disable(irq);
 }
 
 static void
diff --git a/arch/mips/vr41xx/common/icu.c b/arch/mips/vr41xx/common/icu.c
index c215c0d..33d70a6 100644
--- a/arch/mips/vr41xx/common/icu.c
+++ b/arch/mips/vr41xx/common/icu.c
@@ -417,14 +417,7 @@ void vr41xx_disable_bcuint(void)
 
 EXPORT_SYMBOL(vr41xx_disable_bcuint);
 
-static unsigned int startup_sysint1_irq(unsigned int irq)
-{
-	icu1_set(MSYSINT1REG, 1 << SYSINT1_IRQ_TO_PIN(irq));
-
-	return 0; /* never anything pending */
-}
-
-static void shutdown_sysint1_irq(unsigned int irq)
+static void disable_sysint1_irq(unsigned int irq)
 {
 	icu1_clear(MSYSINT1REG, 1 << SYSINT1_IRQ_TO_PIN(irq));
 }
@@ -434,9 +427,6 @@ static void enable_sysint1_irq(unsigned 
 	icu1_set(MSYSINT1REG, 1 << SYSINT1_IRQ_TO_PIN(irq));
 }
 
-#define disable_sysint1_irq	shutdown_sysint1_irq
-#define ack_sysint1_irq		shutdown_sysint1_irq
-
 static void end_sysint1_irq(unsigned int irq)
 {
 	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
@@ -445,22 +435,14 @@ static void end_sysint1_irq(unsigned int
 
 static struct irq_chip sysint1_irq_type = {
 	.typename	= "SYSINT1",
-	.startup	= startup_sysint1_irq,
-	.shutdown	= shutdown_sysint1_irq,
-	.enable		= enable_sysint1_irq,
-	.disable	= disable_sysint1_irq,
-	.ack		= ack_sysint1_irq,
+	.ack		= disable_sysint1_irq,
+	.mask		= disable_sysint1_irq,
+	.mask_ack	= disable_sysint1_irq,
+	.unmask		= enable_sysint1_irq,
 	.end		= end_sysint1_irq,
 };
 
-static unsigned int startup_sysint2_irq(unsigned int irq)
-{
-	icu2_set(MSYSINT2REG, 1 << SYSINT2_IRQ_TO_PIN(irq));
-
-	return 0; /* never anything pending */
-}
-
-static void shutdown_sysint2_irq(unsigned int irq)
+static void disable_sysint2_irq(unsigned int irq)
 {
 	icu2_clear(MSYSINT2REG, 1 << SYSINT2_IRQ_TO_PIN(irq));
 }
@@ -470,9 +452,6 @@ static void enable_sysint2_irq(unsigned 
 	icu2_set(MSYSINT2REG, 1 << SYSINT2_IRQ_TO_PIN(irq));
 }
 
-#define disable_sysint2_irq	shutdown_sysint2_irq
-#define ack_sysint2_irq		shutdown_sysint2_irq
-
 static void end_sysint2_irq(unsigned int irq)
 {
 	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
@@ -481,11 +460,10 @@ static void end_sysint2_irq(unsigned int
 
 static struct irq_chip sysint2_irq_type = {
 	.typename	= "SYSINT2",
-	.startup	= startup_sysint2_irq,
-	.shutdown	= shutdown_sysint2_irq,
-	.enable		= enable_sysint2_irq,
-	.disable	= disable_sysint2_irq,
-	.ack		= ack_sysint2_irq,
+	.ack		= disable_sysint2_irq,
+	.mask		= disable_sysint2_irq,
+	.mask_ack	= disable_sysint2_irq,
+	.unmask		= enable_sysint2_irq,
 	.end		= end_sysint2_irq,
 };
 
@@ -723,10 +701,10 @@ static int __init vr41xx_icu_init(void)
 	icu2_write(MGIUINTHREG, 0xffff);
 
 	for (i = SYSINT1_IRQ_BASE; i <= SYSINT1_IRQ_LAST; i++)
-		irq_desc[i].chip = &sysint1_irq_type;
+		set_irq_chip(i, &sysint1_irq_type);
 
 	for (i = SYSINT2_IRQ_BASE; i <= SYSINT2_IRQ_LAST; i++)
-		irq_desc[i].chip = &sysint2_irq_type;
+		set_irq_chip(i, &sysint2_irq_type);
 
 	cascade_irq(INT0_IRQ, icu_get_irq);
 	cascade_irq(INT1_IRQ, icu_get_irq);
diff --git a/arch/mips/vr41xx/nec-cmbvr4133/irq.c b/arch/mips/vr41xx/nec-cmbvr4133/irq.c
index 2483487..a039bb7 100644
--- a/arch/mips/vr41xx/nec-cmbvr4133/irq.c
+++ b/arch/mips/vr41xx/nec-cmbvr4133/irq.c
@@ -30,17 +30,6 @@ extern void init_8259A(int hoge);
 
 extern int vr4133_rockhopper;
 
-static unsigned int startup_i8259_irq(unsigned int irq)
-{
-	enable_8259A_irq(irq - I8259_IRQ_BASE);
-	return 0;
-}
-
-static void shutdown_i8259_irq(unsigned int irq)
-{
-	disable_8259A_irq(irq - I8259_IRQ_BASE);
-}
-
 static void enable_i8259_irq(unsigned int irq)
 {
 	enable_8259A_irq(irq - I8259_IRQ_BASE);
@@ -64,11 +53,10 @@ static void end_i8259_irq(unsigned int i
 
 static struct irq_chip i8259_irq_type = {
 	.typename       = "XT-PIC",
-	.startup        = startup_i8259_irq,
-	.shutdown       = shutdown_i8259_irq,
-	.enable         = enable_i8259_irq,
-	.disable        = disable_i8259_irq,
 	.ack            = ack_i8259_irq,
+	.mask		= disable_i8259_irq,
+	.mask_ack	= ack_i8259_irq,
+	.unmask		= enable_i8259_irq,
 	.end            = end_i8259_irq,
 };
 
@@ -104,7 +92,7 @@ void __init rockhopper_init_irq(void)
 	}
 
 	for (i = I8259_IRQ_BASE; i <= I8259_IRQ_LAST; i++)
-		irq_desc[i].chip = &i8259_irq_type;
+		set_irq_chip(i, &i8259_irq_type);
 
 	setup_irq(I8259_SLAVE_IRQ, &i8259_slave_cascade);
 
diff --git a/include/asm-mips/dec/kn02.h b/include/asm-mips/dec/kn02.h
index 8319ad7..93430b5 100644
--- a/include/asm-mips/dec/kn02.h
+++ b/include/asm-mips/dec/kn02.h
@@ -82,11 +82,9 @@ #define KN02_IRQ_ALL		0xff
 
 #ifndef __ASSEMBLY__
 
-#include <linux/spinlock.h>
 #include <linux/types.h>
 
 extern u32 cached_kn02_csr;
-extern spinlock_t kn02_lock;
 extern void init_kn02_irqs(int base);
 #endif
 
