Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Aug 2017 06:43:41 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:58562 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993912AbdHMEmUy5Ucd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Aug 2017 06:42:20 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 7F25C99F43F2B;
        Sun, 13 Aug 2017 05:42:11 +0100 (IST)
Received: from localhost (10.20.79.142) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sun, 13 Aug
 2017 05:42:13 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 16/38] irqchip: mips-gic: Convert remaining shared reg access to new accessors
Date:   Sat, 12 Aug 2017 21:36:24 -0700
Message-ID: <20170813043646.25821-17-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.14.0
In-Reply-To: <20170813043646.25821-1-paul.burton@imgtec.com>
References: <20170813043646.25821-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.79.142]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59532
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Convert the remaining accesses to registers in the GIC shared register
block to use the new accessor functions provided by asm/mips-gic.h,
resulting in code which is often shorter & easier to read.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mips@linux-mips.org
---

 drivers/irqchip/irq-mips-gic.c   | 16 ++++++++--------
 include/linux/irqchip/mips-gic.h | 20 --------------------
 2 files changed, 8 insertions(+), 28 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index bc7a4e320f89..90b8644e1264 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -119,7 +119,7 @@ static void gic_send_ipi(struct irq_data *d, unsigned int cpu)
 {
 	irq_hw_number_t hwirq = GIC_HWIRQ_TO_SHARED(irqd_to_hwirq(d));
 
-	gic_write(GIC_REG(SHARED, GIC_SH_WEDGE), GIC_SH_WEDGE_SET(hwirq));
+	write_gic_wedge(GIC_WEDGE_RW | hwirq);
 }
 
 int gic_get_c0_compare_int(void)
@@ -215,7 +215,7 @@ static void gic_ack_irq(struct irq_data *d)
 {
 	unsigned int irq = GIC_HWIRQ_TO_SHARED(d->hwirq);
 
-	gic_write(GIC_REG(SHARED, GIC_SH_WEDGE), GIC_SH_WEDGE_CLR(irq));
+	write_gic_wedge(irq);
 }
 
 static int gic_set_type(struct irq_data *d, unsigned int type)
@@ -700,13 +700,13 @@ static void __init __gic_init(unsigned long gic_base_addr,
 
 	mips_gic_base = ioremap_nocache(gic_base_addr, gic_addrspace_size);
 
-	gicconfig = gic_read(GIC_REG(SHARED, GIC_SH_CONFIG));
-	gic_shared_intrs = (gicconfig & GIC_SH_CONFIG_NUMINTRS_MSK) >>
-		   GIC_SH_CONFIG_NUMINTRS_SHF;
-	gic_shared_intrs = ((gic_shared_intrs + 1) * 8);
+	gicconfig = read_gic_config();
+	gic_shared_intrs = gicconfig & GIC_CONFIG_NUMINTERRUPTS;
+	gic_shared_intrs >>= __fls(GIC_CONFIG_NUMINTERRUPTS);
+	gic_shared_intrs = (gic_shared_intrs + 1) * 8;
 
-	gic_vpes = (gicconfig & GIC_SH_CONFIG_NUMVPES_MSK) >>
-		  GIC_SH_CONFIG_NUMVPES_SHF;
+	gic_vpes = gicconfig & GIC_CONFIG_PVPS;
+	gic_vpes >>= __fls(GIC_CONFIG_PVPS);
 	gic_vpes = gic_vpes + 1;
 
 	if (cpu_has_veic) {
diff --git a/include/linux/irqchip/mips-gic.h b/include/linux/irqchip/mips-gic.h
index ad8b216b6056..f0a60770d775 100644
--- a/include/linux/irqchip/mips-gic.h
+++ b/include/linux/irqchip/mips-gic.h
@@ -19,8 +19,6 @@
 #define GIC_REG(segment, offset) (segment##_##SECTION_OFS + offset##_##OFS)
 
 /* GIC Address Space */
-#define SHARED_SECTION_OFS		0x0000
-#define SHARED_SECTION_SIZE		0x8000
 #define VPE_LOCAL_SECTION_OFS		0x8000
 #define VPE_LOCAL_SECTION_SIZE		0x4000
 #define VPE_OTHER_SECTION_OFS		0xc000
@@ -28,15 +26,6 @@
 #define USM_VISIBLE_SECTION_OFS		0x10000
 #define USM_VISIBLE_SECTION_SIZE	0x10000
 
-/* Register Map for Shared Section */
-
-#define GIC_SH_CONFIG_OFS		0x0000
-
-#define GIC_SH_REVISIONID_OFS		0x0020
-
-/* Set/Clear corresponding bit in Edge Detect Register */
-#define GIC_SH_WEDGE_OFS		0x0280
-
 /* Register Map for Local Section */
 #define GIC_VPE_CTL_OFS			0x0000
 #define GIC_VPE_PEND_OFS		0x0004
@@ -65,15 +54,6 @@
 #define GIC_UMV_SH_COUNTER_63_32_OFS	0x0004
 
 /* Masks */
-#define GIC_SH_CONFIG_NUMINTRS_SHF	16
-#define GIC_SH_CONFIG_NUMINTRS_MSK	(MSK(8) << GIC_SH_CONFIG_NUMINTRS_SHF)
-
-#define GIC_SH_CONFIG_NUMVPES_SHF	0
-#define GIC_SH_CONFIG_NUMVPES_MSK	(MSK(8) << GIC_SH_CONFIG_NUMVPES_SHF)
-
-#define GIC_SH_WEDGE_SET(intr)		((intr) | (0x1 << 31))
-#define GIC_SH_WEDGE_CLR(intr)		((intr) & ~(0x1 << 31))
-
 #define GIC_MAP_SHF			0
 #define GIC_MAP_MSK			(MSK(6) << GIC_MAP_SHF)
 
-- 
2.14.0
