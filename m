Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Aug 2017 06:39:04 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:26544 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992054AbdHMEiklXYhd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Aug 2017 06:38:40 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id E68DB74341469;
        Sun, 13 Aug 2017 05:38:31 +0100 (IST)
Received: from localhost (10.20.79.142) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sun, 13 Aug
 2017 05:38:33 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 04/38] irqchip: mips-gic: Remove counter access functions
Date:   Sat, 12 Aug 2017 21:36:12 -0700
Message-ID: <20170813043646.25821-5-paul.burton@imgtec.com>
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
X-archive-position: 59520
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

The MIPS GIC clocksource driver is no longer using the accessor
functions provided by the irqchip driver, so remove them.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mips@linux-mips.org
---

 drivers/irqchip/irq-mips-gic.c   | 95 ----------------------------------------
 include/linux/irqchip/mips-gic.h | 22 ----------
 2 files changed, 117 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index aaa4c046ccfe..e49d48438626 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -138,101 +138,6 @@ static inline void gic_map_to_vpe(unsigned int intr, unsigned int vpe)
 		  GIC_SH_MAP_TO_VPE_REG_BIT(vpe));
 }
 
-#ifdef CONFIG_CLKSRC_MIPS_GIC
-u64 notrace gic_read_count(void)
-{
-	unsigned int hi, hi2, lo;
-
-	if (mips_cm_is64)
-		return (u64)gic_read(GIC_REG(SHARED, GIC_SH_COUNTER));
-
-	do {
-		hi = gic_read32(GIC_REG(SHARED, GIC_SH_COUNTER_63_32));
-		lo = gic_read32(GIC_REG(SHARED, GIC_SH_COUNTER_31_00));
-		hi2 = gic_read32(GIC_REG(SHARED, GIC_SH_COUNTER_63_32));
-	} while (hi2 != hi);
-
-	return (((u64) hi) << 32) + lo;
-}
-
-unsigned int gic_get_count_width(void)
-{
-	unsigned int bits, config;
-
-	config = gic_read(GIC_REG(SHARED, GIC_SH_CONFIG));
-	bits = 32 + 4 * ((config & GIC_SH_CONFIG_COUNTBITS_MSK) >>
-			 GIC_SH_CONFIG_COUNTBITS_SHF);
-
-	return bits;
-}
-
-void notrace gic_write_compare(u64 cnt)
-{
-	if (mips_cm_is64) {
-		gic_write(GIC_REG(VPE_LOCAL, GIC_VPE_COMPARE), cnt);
-	} else {
-		gic_write32(GIC_REG(VPE_LOCAL, GIC_VPE_COMPARE_HI),
-					(int)(cnt >> 32));
-		gic_write32(GIC_REG(VPE_LOCAL, GIC_VPE_COMPARE_LO),
-					(int)(cnt & 0xffffffff));
-	}
-}
-
-void notrace gic_write_cpu_compare(u64 cnt, int cpu)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-
-	gic_write(GIC_REG(VPE_LOCAL, GIC_VPE_OTHER_ADDR), mips_cm_vp_id(cpu));
-
-	if (mips_cm_is64) {
-		gic_write(GIC_REG(VPE_OTHER, GIC_VPE_COMPARE), cnt);
-	} else {
-		gic_write32(GIC_REG(VPE_OTHER, GIC_VPE_COMPARE_HI),
-					(int)(cnt >> 32));
-		gic_write32(GIC_REG(VPE_OTHER, GIC_VPE_COMPARE_LO),
-					(int)(cnt & 0xffffffff));
-	}
-
-	local_irq_restore(flags);
-}
-
-u64 gic_read_compare(void)
-{
-	unsigned int hi, lo;
-
-	if (mips_cm_is64)
-		return (u64)gic_read(GIC_REG(VPE_LOCAL, GIC_VPE_COMPARE));
-
-	hi = gic_read32(GIC_REG(VPE_LOCAL, GIC_VPE_COMPARE_HI));
-	lo = gic_read32(GIC_REG(VPE_LOCAL, GIC_VPE_COMPARE_LO));
-
-	return (((u64) hi) << 32) + lo;
-}
-
-void gic_start_count(void)
-{
-	u32 gicconfig;
-
-	/* Start the counter */
-	gicconfig = gic_read(GIC_REG(SHARED, GIC_SH_CONFIG));
-	gicconfig &= ~(1 << GIC_SH_CONFIG_COUNTSTOP_SHF);
-	gic_write(GIC_REG(SHARED, GIC_SH_CONFIG), gicconfig);
-}
-
-void gic_stop_count(void)
-{
-	u32 gicconfig;
-
-	/* Stop the counter */
-	gicconfig = gic_read(GIC_REG(SHARED, GIC_SH_CONFIG));
-	gicconfig |= 1 << GIC_SH_CONFIG_COUNTSTOP_SHF;
-	gic_write(GIC_REG(SHARED, GIC_SH_CONFIG), gicconfig);
-}
-
-#endif
-
 unsigned gic_read_local_vp_id(void)
 {
 	unsigned long ident;
diff --git a/include/linux/irqchip/mips-gic.h b/include/linux/irqchip/mips-gic.h
index 2b0e56619e53..c9e1c993cf5b 100644
--- a/include/linux/irqchip/mips-gic.h
+++ b/include/linux/irqchip/mips-gic.h
@@ -40,11 +40,6 @@
 
 #define GIC_SH_CONFIG_OFS		0x0000
 
-/* Shared Global Counter */
-#define GIC_SH_COUNTER_31_00_OFS	0x0010
-/* 64-bit counter register for CM3 */
-#define GIC_SH_COUNTER_OFS		GIC_SH_COUNTER_31_00_OFS
-#define GIC_SH_COUNTER_63_32_OFS	0x0014
 #define GIC_SH_REVISIONID_OFS		0x0020
 
 /* Convert an interrupt number to a byte offset/bit for multi-word registers */
@@ -107,10 +102,6 @@
 #define GIC_VPE_WD_CONFIG0_OFS		0x0090
 #define GIC_VPE_WD_COUNT0_OFS		0x0094
 #define GIC_VPE_WD_INITIAL0_OFS		0x0098
-#define GIC_VPE_COMPARE_LO_OFS		0x00a0
-/* 64-bit Compare register on CM3 */
-#define GIC_VPE_COMPARE_OFS		GIC_VPE_COMPARE_LO_OFS
-#define GIC_VPE_COMPARE_HI_OFS		0x00a4
 
 #define GIC_VPE_EIC_SHADOW_SET_BASE_OFS	0x0100
 #define GIC_VPE_EIC_SS(intr)		(4 * (intr))
@@ -128,12 +119,6 @@
 #define GIC_UMV_SH_COUNTER_63_32_OFS	0x0004
 
 /* Masks */
-#define GIC_SH_CONFIG_COUNTSTOP_SHF	28
-#define GIC_SH_CONFIG_COUNTSTOP_MSK	(MSK(1) << GIC_SH_CONFIG_COUNTSTOP_SHF)
-
-#define GIC_SH_CONFIG_COUNTBITS_SHF	24
-#define GIC_SH_CONFIG_COUNTBITS_MSK	(MSK(4) << GIC_SH_CONFIG_COUNTBITS_SHF)
-
 #define GIC_SH_CONFIG_NUMINTRS_SHF	16
 #define GIC_SH_CONFIG_NUMINTRS_MSK	(MSK(8) << GIC_SH_CONFIG_NUMINTRS_SHF)
 
@@ -258,13 +243,6 @@ extern unsigned int gic_present;
 extern void gic_init(unsigned long gic_base_addr,
 	unsigned long gic_addrspace_size, unsigned int cpu_vec,
 	unsigned int irqbase);
-extern u64 gic_read_count(void);
-extern unsigned int gic_get_count_width(void);
-extern u64 gic_read_compare(void);
-extern void gic_write_compare(u64 cnt);
-extern void gic_write_cpu_compare(u64 cnt, int cpu);
-extern void gic_start_count(void);
-extern void gic_stop_count(void);
 extern int gic_get_c0_compare_int(void);
 extern int gic_get_c0_perfcount_int(void);
 extern int gic_get_c0_fdc_int(void);
-- 
2.14.0
