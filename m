Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Apr 2012 19:59:21 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:35100 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1904081Ab2DFR7O (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Apr 2012 19:59:14 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SGDRE-00045p-5j; Fri, 06 Apr 2012 12:59:08 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, sjhill@realitydiluted.com
Subject: [PATCH 2/5] MIPS: Clean-up GIC and vectored interrupts.
Date:   Fri,  6 Apr 2012 12:59:00 -0500
Message-Id: <1333735140-15719-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.6
X-archive-position: 32868
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

This change adds macros for routing of GIC interrupts for EIC and
non-EIC hardware modes. Also added Malta GIC macros having to do
with performance and timer interrupts.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/include/asm/gic.h                  |   15 ++++++++++++++-
 arch/mips/include/asm/irq.h                  |    1 +
 arch/mips/include/asm/mips-boards/maltaint.h |   10 ++++++++++
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/gic.h b/arch/mips/include/asm/gic.h
index 86548da..991b659 100644
--- a/arch/mips/include/asm/gic.h
+++ b/arch/mips/include/asm/gic.h
@@ -206,7 +206,7 @@
 
 #define GIC_VPE_EIC_SHADOW_SET_BASE	0x0100
 #define GIC_VPE_EIC_SS(intr) \
-	(GIC_EIC_SHADOW_SET_BASE + (4 * intr))
+	(GIC_VPE_EIC_SHADOW_SET_BASE + (4 * intr))
 
 #define GIC_VPE_EIC_VEC_BASE		0x0800
 #define GIC_VPE_EIC_VEC(intr) \
@@ -330,6 +330,17 @@ struct gic_intr_map {
 #define GIC_FLAG_TRANSPARENT   0x02
 };
 
+/*
+ * This is only used in EIC mode. This helps to figure out which
+ * shared interrupts we need to process when we get a vector interrupt.
+ */
+#define GIC_MAX_SHARED_INTR  0x5
+struct gic_shared_intr_map {
+	unsigned int num_shared_intr;
+	unsigned int intr_list[GIC_MAX_SHARED_INTR];
+	unsigned int local_intr_mask;
+};
+
 extern void gic_init(unsigned long gic_base_addr,
 	unsigned long gic_addrspace_size, struct gic_intr_map *intrmap,
 	unsigned int intrmap_size, unsigned int irqbase);
@@ -338,5 +349,7 @@ extern unsigned int gic_get_int(void);
 extern void gic_send_ipi(unsigned int intr);
 extern unsigned int plat_ipi_call_int_xlate(unsigned int);
 extern unsigned int plat_ipi_resched_int_xlate(unsigned int);
+extern void gic_bind_eic_interrupt(int irq, int set);
+extern unsigned int gic_get_timer_pending(void);
 
 #endif /* _ASM_GICREGS_H */
diff --git a/arch/mips/include/asm/irq.h b/arch/mips/include/asm/irq.h
index fb698dc..78dbb8a 100644
--- a/arch/mips/include/asm/irq.h
+++ b/arch/mips/include/asm/irq.h
@@ -136,6 +136,7 @@ extern void free_irqno(unsigned int irq);
  * IE7.  Since R2 their number has to be read from the c0_intctl register.
  */
 #define CP0_LEGACY_COMPARE_IRQ 7
+#define CP0_LEGACY_PERFCNT_IRQ 7
 
 extern int cp0_compare_irq;
 extern int cp0_compare_irq_shift;
diff --git a/arch/mips/include/asm/mips-boards/maltaint.h b/arch/mips/include/asm/mips-boards/maltaint.h
index d11aa02..5447d9f 100644
--- a/arch/mips/include/asm/mips-boards/maltaint.h
+++ b/arch/mips/include/asm/mips-boards/maltaint.h
@@ -86,6 +86,16 @@
 #define GIC_CPU_INT4		4 /* .			*/
 #define GIC_CPU_INT5		5 /* Core Interrupt 5   */
 
+/* MALTA GIC local interrupts */
+#define GIC_INT_TMR             (GIC_CPU_INT5)
+#define GIC_INT_PERFCTR         (GIC_CPU_INT5)
+
+/* GIC constants */
+/* Add 2 to convert non-eic hw int # to eic vector # */
+#define GIC_CPU_TO_VEC_OFFSET   (2)
+/* If we map an intr to pin X, GIC will actually generate vector X+1 */
+#define GIC_PIN_TO_VEC_OFFSET   (1)
+
 #define GIC_EXT_INTR(x)		x
 
 /* External Interrupts used for IPI */
-- 
1.7.9.6
