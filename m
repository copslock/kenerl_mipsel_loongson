Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Jun 2009 01:59:14 +0200 (CEST)
Received: from fw1-az.mvista.com ([65.200.49.156]:54721 "EHLO
	shomer.az.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by ftp.linux-mips.org with ESMTP id S1491802AbZFPX7G (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 17 Jun 2009 01:59:06 +0200
Received: from shomer.az.mvista.com (localhost.localdomain [127.0.0.1])
	by shomer.az.mvista.com (8.14.2/8.14.2) with ESMTP id n5GNvpu4006380;
	Tue, 16 Jun 2009 16:57:51 -0700
Received: (from tsa@localhost)
	by shomer.az.mvista.com (8.14.2/8.14.2/Submit) id n5GNvp5x006379;
	Tue, 16 Jun 2009 16:57:51 -0700
Date:	Tue, 16 Jun 2009 16:57:51 -0700
From:	Tim Anderson <tanderson@mvista.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH 1/5] Extend the GIC IPI interrupts beyond 32
Message-ID: <20090616235751.GD6346@shomer.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <tsa@shomer.az.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23437
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tanderson@mvista.com
Precedence: bulk
X-list: linux-mips

This patch extends the GIC interrupt handling beyond the
current 32 bit range as well as extending the number of
interrupts based on the number of CPUs.

Signed-off-by: Tim Anderson <tanderson@mvista.com>
---
 arch/mips/include/asm/gic.h |    4 ++++
 arch/mips/kernel/irq-gic.c  |   15 ++++-----------
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/arch/mips/include/asm/gic.h b/arch/mips/include/asm/gic.h
index 954807d..e8fdd92 100644
--- a/arch/mips/include/asm/gic.h
+++ b/arch/mips/include/asm/gic.h
@@ -20,7 +20,11 @@
 #define GIC_TRIG_EDGE			1
 #define GIC_TRIG_LEVEL			0
 
+#if CONFIG_SMP
+#define GIC_NUM_INTRS			(24 + NR_CPUS * 2)
+#else
 #define GIC_NUM_INTRS			32
+#endif
 
 #define MSK(n) ((1 << (n)) - 1)
 #define REG32(addr)		(*(volatile unsigned int *) (addr))
diff --git a/arch/mips/kernel/irq-gic.c b/arch/mips/kernel/irq-gic.c
index 87deb8f..1d6ac92 100644
--- a/arch/mips/kernel/irq-gic.c
+++ b/arch/mips/kernel/irq-gic.c
@@ -106,9 +106,7 @@ static unsigned int gic_irq_startup(unsigned int irq)
 {
 	pr_debug("CPU%d: %s: irq%d\n", smp_processor_id(), __func__, irq);
 	irq -= _irqbase;
-	/* FIXME: this is wrong for !GICISWORDLITTLEENDIAN */
-	GICWRITE(GIC_REG_ADDR(SHARED, (GIC_SH_SMASK_31_0_OFS + (irq / 32))),
-		 1 << (irq % 32));
+	GIC_SET_INTR_MASK(irq, 1);
 	return 0;
 }
 
@@ -119,8 +117,7 @@ static void gic_irq_ack(unsigned int irq)
 #endif
 	pr_debug("CPU%d: %s: irq%d\n", smp_processor_id(), __func__, irq);
 	irq -= _irqbase;
-	GICWRITE(GIC_REG_ADDR(SHARED, (GIC_SH_RMASK_31_0_OFS + (irq / 32))),
-		 1 << (irq % 32));
+	GIC_CLR_INTR_MASK(irq, 1);
 
 	if (_intrmap[irq].trigtype == GIC_TRIG_EDGE) {
 		if (!gic_wedgeb2bok)
@@ -137,18 +134,14 @@ static void gic_mask_irq(unsigned int irq)
 {
 	pr_debug("CPU%d: %s: irq%d\n", smp_processor_id(), __func__, irq);
 	irq -= _irqbase;
-	/* FIXME: this is wrong for !GICISWORDLITTLEENDIAN */
-	GICWRITE(GIC_REG_ADDR(SHARED, (GIC_SH_RMASK_31_0_OFS + (irq / 32))),
-		 1 << (irq % 32));
+	GIC_CLR_INTR_MASK(irq, 1);
 }
 
 static void gic_unmask_irq(unsigned int irq)
 {
 	pr_debug("CPU%d: %s: irq%d\n", smp_processor_id(), __func__, irq);
 	irq -= _irqbase;
-	/* FIXME: this is wrong for !GICISWORDLITTLEENDIAN */
-	GICWRITE(GIC_REG_ADDR(SHARED, (GIC_SH_SMASK_31_0_OFS + (irq / 32))),
-		 1 << (irq % 32));
+	GIC_SET_INTR_MASK(irq, 1);
 }
 
 #ifdef CONFIG_SMP
-- 
1.6.2.5.170.gf2181
