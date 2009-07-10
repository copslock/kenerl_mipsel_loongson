Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jul 2009 10:54:50 +0200 (CEST)
Received: from dns1.mips.com ([63.167.95.197]:46631 "EHLO dns1.mips.com"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1491952AbZGJIyY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 10 Jul 2009 10:54:24 +0200
Received: from MTVEXCHANGE.mips.com ([192.168.36.200])
	by dns1.mips.com (8.13.8/8.13.8) with ESMTP id n6A8sH2D024167
	for <linux-mips@linux-mips.org>; Fri, 10 Jul 2009 01:54:17 -0700
Received: from mercury.mips.com ([192.168.64.101]) by MTVEXCHANGE.mips.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 10 Jul 2009 01:54:16 -0700
Received: from [192.168.65.97] (linux-raghu [192.168.65.97])
	by mercury.mips.com (8.13.5/8.13.5) with ESMTP id n6A8sGMg021822;
	Fri, 10 Jul 2009 01:54:16 -0700 (PDT)
From:	Raghu Gandham <raghu@mips.com>
Subject: [PATCH 2/3] Port of GIC related changes from MTI branch.
To:	linux-mips@linux-mips.org
Cc:	raghu@mips.com, chris@mips.com
Date:	Fri, 10 Jul 2009 01:54:09 -0700
Message-ID: <20090710085409.25918.2601.stgit@linux-raghu>
In-Reply-To: <20090710085338.25918.37597.stgit@linux-raghu>
References: <20090710085338.25918.37597.stgit@linux-raghu>
User-Agent: StGIT/0.14.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Jul 2009 08:54:16.0869 (UTC) FILETIME=[0185C550:01CA013C]
Return-Path: <raghu@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23704
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: raghu@mips.com
Precedence: bulk
X-list: linux-mips

From: Chris Dearman <chris@mips.com>

Signed-off-by: Chris Dearman <chris@mips.com>
---

 arch/mips/include/asm/gcmpregs.h |   18 ++--
 arch/mips/include/asm/gic.h      |  188 ++++----------------------------------
 arch/mips/kernel/irq-gic.c       |  116 +++++++++--------------
 arch/mips/mti-malta/malta-int.c  |  101 ++++++++++++--------
 arch/mips/mti-malta/malta-pci.c  |   14 ++-
 5 files changed, 143 insertions(+), 294 deletions(-)

diff --git a/arch/mips/include/asm/gcmpregs.h b/arch/mips/include/asm/gcmpregs.h
index 36fd969..c0cf76a 100644
--- a/arch/mips/include/asm/gcmpregs.h
+++ b/arch/mips/include/asm/gcmpregs.h
@@ -19,15 +19,20 @@
 #define GCMP_GDB_OFS		0x8000 /* Global Debug Block */
 
 /* Offsets to individual GCMP registers from GCMP base */
-#define GCMPOFS(block, tag, reg)	(GCMP_##block##_OFS + GCMP_##tag##_##reg##_OFS)
+#define GCMPOFS(block, tag, reg)	\
+	(GCMP_##block##_OFS + GCMP_##tag##_##reg##_OFS)
+#define GCMPOFSn(block, tag, reg, n) \
+	(GCMP_##block##_OFS + GCMP_##tag##_##reg##_OFS(n))
 
 #define GCMPGCBOFS(reg)		GCMPOFS(GCB, GCB, reg)
+#define GCMPGCBOFSn(reg, n)	GCMPOFSn(GCB, GCB, reg, n)
 #define GCMPCLCBOFS(reg)	GCMPOFS(CLCB, CCB, reg)
 #define GCMPCOCBOFS(reg)	GCMPOFS(COCB, CCB, reg)
 #define GCMPGDBOFS(reg)		GCMPOFS(GDB, GDB, reg)
 
 /* GCMP register access */
 #define GCMPGCB(reg)			REGP(_gcmp_base, GCMPGCBOFS(reg))
+#define GCMPGCBn(reg, n)               REGP(_gcmp_base, GCMPGCBOFSn(reg, n))
 #define GCMPCLCB(reg)			REGP(_gcmp_base, GCMPCLCBOFS(reg))
 #define GCMPCOCB(reg)			REGP(_gcmp_base, GCMPCOCBOFS(reg))
 #define GCMPGDB(reg)			REGP(_gcmp_base, GCMPGDBOFS(reg))
@@ -49,10 +54,10 @@
 #define  GCMP_GCB_GCMPB_GCMPBASE_MSK	GCMPGCBMSK(GCMPB_GCMPBASE, 17)
 #define  GCMP_GCB_GCMPB_CMDEFTGT_SHF	0
 #define  GCMP_GCB_GCMPB_CMDEFTGT_MSK	GCMPGCBMSK(GCMPB_CMDEFTGT, 2)
-#define  GCMP_GCB_GCMPB_CMDEFTGT_MEM	0
-#define  GCMP_GCB_GCMPB_CMDEFTGT_MEM1	1
-#define  GCMP_GCB_GCMPB_CMDEFTGT_IOCU1 2
-#define  GCMP_GCB_GCMPB_CMDEFTGT_IOCU2 3
+#define  GCMP_GCB_GCMPB_CMDEFTGT_DISABLED	0
+#define  GCMP_GCB_GCMPB_CMDEFTGT_MEM		1
+#define  GCMP_GCB_GCMPB_CMDEFTGT_IOCU1		2
+#define  GCMP_GCB_GCMPB_CMDEFTGT_IOCU2		3
 #define GCMP_GCB_CCMC_OFS		0x0010	/* Global CM Control */
 #define GCMP_GCB_GCSRAP_OFS		0x0020	/* Global CSR Access Privilege */
 #define  GCMP_GCB_GCSRAP_CMACCESS_SHF	0
@@ -115,5 +120,6 @@
 #define GCMP_CCB_DBGGROUP_OFS		0x0100		/* DebugBreak Group */
 
 extern int __init gcmp_probe(unsigned long, unsigned long);
-
+extern int __init gcmp_niocu(void);
+extern void __init gcmp_setregion(int, unsigned long, unsigned long, int);
 #endif /* _ASM_GCMPREGS_H */
diff --git a/arch/mips/include/asm/gic.h b/arch/mips/include/asm/gic.h
index a8f5734..9b9436a 100644
--- a/arch/mips/include/asm/gic.h
+++ b/arch/mips/include/asm/gic.h
@@ -12,7 +12,6 @@
 #define _ASM_GICREGS_H
 
 #undef	GICISBYTELITTLEENDIAN
-#define GICISWORDLITTLEENDIAN
 
 /* Constants */
 #define GIC_POL_POS			1
@@ -20,11 +19,7 @@
 #define GIC_TRIG_EDGE			1
 #define GIC_TRIG_LEVEL			0
 
-#ifdef CONFIG_SMP
 #define GIC_NUM_INTRS			(24 + NR_CPUS * 2)
-#else
-#define GIC_NUM_INTRS			32
-#endif
 
 #define MSK(n) ((1 << (n)) - 1)
 #define REG32(addr)		(*(volatile unsigned int *) (addr))
@@ -70,13 +65,13 @@
 #define USM_VISIBLE_SECTION_SIZE	0x10000
 
 /* Register Map for Shared Section */
-#if defined(CONFIG_CPU_LITTLE_ENDIAN) || defined(GICISWORDLITTLEENDIAN)
 
 #define	GIC_SH_CONFIG_OFS		0x0000
 
 /* Shared Global Counter */
 #define GIC_SH_COUNTER_31_00_OFS	0x0010
 #define GIC_SH_COUNTER_63_32_OFS	0x0014
+#define GIC_SH_REVISIONID_OFS		0x0020
 
 /* Interrupt Polarity */
 #define GIC_SH_POL_31_0_OFS		0x0100
@@ -164,24 +159,31 @@
 	(GIC_SH_INTR_MAP_TO_VPE_BASE_OFS + (32 * (intr)) + (((vpe) / 32) * 4))
 #define GIC_SH_MAP_TO_VPE_REG_BIT(vpe)	(1 << ((vpe) % 32))
 
+/* Convert an interrupt number to a byte offset/bit for multi-word registers */
+#define GIC_INTR_OFS(intr) (((intr) / 32)*4)
+#define GIC_INTR_BIT(intr) ((intr) % 32)
+
 /* Polarity : Reset Value is always 0 */
 #define GIC_SH_SET_POLARITY_OFS		0x0100
 #define GIC_SET_POLARITY(intr, pol) \
-	GICBIS(GIC_REG_ADDR(SHARED, GIC_SH_SET_POLARITY_OFS + (((intr) / 32) * 4)), (pol) << ((intr) % 32))
+	GICBIS(GIC_REG_ADDR(SHARED, GIC_SH_SET_POLARITY_OFS + \
+		GIC_INTR_OFS(intr)), (pol) << GIC_INTR_BIT(intr))
 
 /* Triggering : Reset Value is always 0 */
 #define GIC_SH_SET_TRIGGER_OFS		0x0180
 #define GIC_SET_TRIGGER(intr, trig) \
-	GICBIS(GIC_REG_ADDR(SHARED, GIC_SH_SET_TRIGGER_OFS + (((intr) / 32) * 4)), (trig) << ((intr) % 32))
+	GICBIS(GIC_REG_ADDR(SHARED, GIC_SH_SET_TRIGGER_OFS + \
+		GIC_INTR_OFS(intr)), (trig) << GIC_INTR_BIT(intr))
 
 /* Mask manipulation */
 #define GIC_SH_SMASK_OFS		0x0380
-#define GIC_SET_INTR_MASK(intr, val) \
-	GICWRITE(GIC_REG_ADDR(SHARED, GIC_SH_SMASK_OFS + (((intr) / 32) * 4)), ((val) << ((intr) % 32)))
-
+#define GIC_SET_INTR_MASK(intr) \
+	GICWRITE(GIC_REG_ADDR(SHARED, GIC_SH_SMASK_OFS + \
+		GIC_INTR_OFS(intr)), 1 << GIC_INTR_BIT(intr))
 #define GIC_SH_RMASK_OFS		0x0300
-#define GIC_CLR_INTR_MASK(intr, val) \
-	GICWRITE(GIC_REG_ADDR(SHARED, GIC_SH_RMASK_OFS + (((intr) / 32) * 4)), ((val) << ((intr) % 32)))
+#define GIC_CLR_INTR_MASK(intr) \
+	GICWRITE(GIC_REG_ADDR(SHARED, GIC_SH_RMASK_OFS + \
+		GIC_INTR_OFS(intr)), 1 << GIC_INTR_BIT(intr))
 
 /* Register Map for Local Section */
 #define GIC_VPE_CTL_OFS			0x0000
@@ -219,161 +221,6 @@
 #define GIC_UMV_SH_COUNTER_31_00_OFS	0x0000
 #define GIC_UMV_SH_COUNTER_63_32_OFS	0x0004
 
-#else /* CONFIG_CPU_BIG_ENDIAN */
-
-#define	GIC_SH_CONFIG_OFS		0x0000
-
-/* Shared Global Counter */
-#define GIC_SH_COUNTER_31_00_OFS	0x0014
-#define GIC_SH_COUNTER_63_32_OFS	0x0010
-
-/* Interrupt Polarity */
-#define GIC_SH_POL_31_0_OFS		0x0104
-#define GIC_SH_POL_63_32_OFS		0x0100
-#define GIC_SH_POL_95_64_OFS		0x010c
-#define GIC_SH_POL_127_96_OFS		0x0108
-#define GIC_SH_POL_159_128_OFS		0x0114
-#define GIC_SH_POL_191_160_OFS		0x0110
-#define GIC_SH_POL_223_192_OFS		0x011c
-#define GIC_SH_POL_255_224_OFS		0x0118
-
-/* Edge/Level Triggering */
-#define GIC_SH_TRIG_31_0_OFS		0x0184
-#define GIC_SH_TRIG_63_32_OFS		0x0180
-#define GIC_SH_TRIG_95_64_OFS		0x018c
-#define GIC_SH_TRIG_127_96_OFS		0x0188
-#define GIC_SH_TRIG_159_128_OFS		0x0194
-#define GIC_SH_TRIG_191_160_OFS		0x0190
-#define GIC_SH_TRIG_223_192_OFS		0x019c
-#define GIC_SH_TRIG_255_224_OFS		0x0198
-
-/* Dual Edge Triggering */
-#define GIC_SH_DUAL_31_0_OFS		0x0204
-#define GIC_SH_DUAL_63_32_OFS		0x0200
-#define GIC_SH_DUAL_95_64_OFS		0x020c
-#define GIC_SH_DUAL_127_96_OFS		0x0208
-#define GIC_SH_DUAL_159_128_OFS		0x0214
-#define GIC_SH_DUAL_191_160_OFS		0x0210
-#define GIC_SH_DUAL_223_192_OFS		0x021c
-#define GIC_SH_DUAL_255_224_OFS		0x0218
-
-/* Set/Clear corresponding bit in Edge Detect Register */
-#define GIC_SH_WEDGE_OFS		0x0280
-
-/* Reset Mask - Disables Interrupt */
-#define GIC_SH_RMASK_31_0_OFS		0x0304
-#define GIC_SH_RMASK_63_32_OFS		0x0300
-#define GIC_SH_RMASK_95_64_OFS		0x030c
-#define GIC_SH_RMASK_127_96_OFS		0x0308
-#define GIC_SH_RMASK_159_128_OFS	0x0314
-#define GIC_SH_RMASK_191_160_OFS	0x0310
-#define GIC_SH_RMASK_223_192_OFS	0x031c
-#define GIC_SH_RMASK_255_224_OFS	0x0318
-
-/* Set Mask (WO) - Enables Interrupt */
-#define GIC_SH_SMASK_31_0_OFS		0x0384
-#define GIC_SH_SMASK_63_32_OFS		0x0380
-#define GIC_SH_SMASK_95_64_OFS		0x038c
-#define GIC_SH_SMASK_127_96_OFS		0x0388
-#define GIC_SH_SMASK_159_128_OFS	0x0394
-#define GIC_SH_SMASK_191_160_OFS	0x0390
-#define GIC_SH_SMASK_223_192_OFS	0x039c
-#define GIC_SH_SMASK_255_224_OFS	0x0398
-
-/* Global Interrupt Mask Register (RO) - Bit Set == Interrupt enabled */
-#define GIC_SH_MASK_31_0_OFS		0x0404
-#define GIC_SH_MASK_63_32_OFS		0x0400
-#define GIC_SH_MASK_95_64_OFS		0x040c
-#define GIC_SH_MASK_127_96_OFS		0x0408
-#define GIC_SH_MASK_159_128_OFS		0x0414
-#define GIC_SH_MASK_191_160_OFS		0x0410
-#define GIC_SH_MASK_223_192_OFS		0x041c
-#define GIC_SH_MASK_255_224_OFS		0x0418
-
-/* Pending Global Interrupts (RO) */
-#define GIC_SH_PEND_31_0_OFS		0x0484
-#define GIC_SH_PEND_63_32_OFS		0x0480
-#define GIC_SH_PEND_95_64_OFS		0x048c
-#define GIC_SH_PEND_127_96_OFS		0x0488
-#define GIC_SH_PEND_159_128_OFS		0x0494
-#define GIC_SH_PEND_191_160_OFS		0x0490
-#define GIC_SH_PEND_223_192_OFS		0x049c
-#define GIC_SH_PEND_255_224_OFS		0x0498
-
-#define GIC_SH_INTR_MAP_TO_PIN_BASE_OFS	0x0500
-
-/* Maps Interrupt X to a Pin */
-#define GIC_SH_MAP_TO_PIN(intr) \
-	(GIC_SH_INTR_MAP_TO_PIN_BASE_OFS + (4 * intr))
-
-#define GIC_SH_INTR_MAP_TO_VPE_BASE_OFS	0x2004
-
-/*
- * Maps Interrupt X to a VPE.  This is more complex than the LE case, as
- * odd and even registers need to be transposed.  It does work - trust me!
- */
-#define GIC_SH_MAP_TO_VPE_REG_OFF(intr, vpe) \
-	(GIC_SH_INTR_MAP_TO_VPE_BASE_OFS + (32 * (intr)) + \
-	(((((vpe) / 32) ^ 1) - 1) * 4))
-#define GIC_SH_MAP_TO_VPE_REG_BIT(vpe)	(1 << ((vpe) % 32))
-
-/* Polarity */
-#define GIC_SH_SET_POLARITY_OFS		0x0100
-#define GIC_SET_POLARITY(intr, pol) \
-	GICBIS(GIC_REG_ADDR(SHARED, GIC_SH_SET_POLARITY_OFS + 4 + (((((intr) / 32) ^ 1) - 1) * 4)), (pol) << ((intr) % 32))
-
-/* Triggering */
-#define GIC_SH_SET_TRIGGER_OFS		0x0180
-#define GIC_SET_TRIGGER(intr, trig) \
-	GICBIS(GIC_REG_ADDR(SHARED, GIC_SH_SET_TRIGGER_OFS + 4 + (((((intr) / 32) ^ 1) - 1) * 4)), (trig) << ((intr) % 32))
-
-/* Mask manipulation */
-#define GIC_SH_SMASK_OFS		0x0380
-#define GIC_SET_INTR_MASK(intr, val) \
-	GICWRITE(GIC_REG_ADDR(SHARED, GIC_SH_SMASK_OFS + 4 + (((((intr) / 32) ^ 1) - 1) * 4)), ((val) << ((intr) % 32)))
-
-#define GIC_SH_RMASK_OFS		0x0300
-#define GIC_CLR_INTR_MASK(intr, val) \
-	GICWRITE(GIC_REG_ADDR(SHARED, GIC_SH_RMASK_OFS + 4 + (((((intr) / 32) ^ 1) - 1) * 4)), ((val) << ((intr) % 32)))
-
-/* Register Map for Local Section */
-#define GIC_VPE_CTL_OFS			0x0000
-#define GIC_VPE_PEND_OFS		0x0004
-#define GIC_VPE_MASK_OFS		0x0008
-#define GIC_VPE_RMASK_OFS		0x000c
-#define GIC_VPE_SMASK_OFS		0x0010
-#define GIC_VPE_WD_MAP_OFS		0x0040
-#define GIC_VPE_COMPARE_MAP_OFS		0x0044
-#define GIC_VPE_TIMER_MAP_OFS		0x0048
-#define GIC_VPE_PERFCTR_MAP_OFS		0x0050
-#define GIC_VPE_SWINT0_MAP_OFS		0x0054
-#define GIC_VPE_SWINT1_MAP_OFS		0x0058
-#define GIC_VPE_OTHER_ADDR_OFS		0x0080
-#define GIC_VPE_WD_CONFIG0_OFS		0x0090
-#define GIC_VPE_WD_COUNT0_OFS		0x0094
-#define GIC_VPE_WD_INITIAL0_OFS		0x0098
-#define GIC_VPE_COMPARE_LO_OFS		0x00a4
-#define GIC_VPE_COMPARE_HI_OFS		0x00a0
-
-#define GIC_VPE_EIC_SHADOW_SET_BASE	0x0100
-#define GIC_VPE_EIC_SS(intr) \
-	(GIC_EIC_SHADOW_SET_BASE + (4 * intr))
-
-#define GIC_VPE_EIC_VEC_BASE		0x0800
-#define GIC_VPE_EIC_VEC(intr) \
-	(GIC_VPE_EIC_VEC_BASE + (4 * intr))
-
-#define GIC_VPE_TENABLE_NMI_OFS		0x1000
-#define GIC_VPE_TENABLE_YQ_OFS		0x1004
-#define GIC_VPE_TENABLE_INT_31_0_OFS	0x1080
-#define GIC_VPE_TENABLE_INT_63_32_OFS	0x1084
-
-/* User Mode Visible Section Register Map */
-#define GIC_UMV_SH_COUNTER_31_00_OFS	0x0004
-#define GIC_UMV_SH_COUNTER_63_32_OFS	0x0000
-
-#endif /* !LE */
-
 /* Masks */
 #define GIC_SH_CONFIG_COUNTSTOP_SHF	28
 #define GIC_SH_CONFIG_COUNTSTOP_MSK	(MSK(1) << GIC_SH_CONFIG_COUNTSTOP_SHF)
@@ -473,12 +320,13 @@ struct gic_intrmask_regs {
  * in building ipi_map.
  */
 struct gic_intr_map {
-	unsigned int intrnum; 	/* Ext Intr Num 	*/
 	unsigned int cpunum;	/* Directed to this CPU */
 	unsigned int pin;	/* Directed to this Pin */
 	unsigned int polarity;	/* Polarity : +/-	*/
 	unsigned int trigtype;	/* Trigger  : Edge/Levl */
-	unsigned int ipiflag;	/* Is used for IPI ?	*/
+	unsigned int flags;	/* Misc flags	*/
+#define GIC_FLAG_IPI           0x01
+#define GIC_FLAG_TRANSPARENT   0x02
 };
 
 extern void gic_init(unsigned long gic_base_addr,
diff --git a/arch/mips/kernel/irq-gic.c b/arch/mips/kernel/irq-gic.c
index d2072cd..06d3506 100644
--- a/arch/mips/kernel/irq-gic.c
+++ b/arch/mips/kernel/irq-gic.c
@@ -14,38 +14,23 @@
 
 
 static unsigned long _gic_base;
-static unsigned int _irqbase, _mapsize, numvpes, numintrs;
-static struct gic_intr_map *_intrmap;
+static unsigned int _irqbase;
+static unsigned int gic_irq_flags[GIC_NUM_INTRS];
+#define GIC_IRQ_FLAG_EDGE      0x0001
 
-static struct gic_pcpu_mask pcpu_masks[NR_CPUS];
+struct gic_pcpu_mask pcpu_masks[NR_CPUS];
 static struct gic_pending_regs pending_regs[NR_CPUS];
 static struct gic_intrmask_regs intrmask_regs[NR_CPUS];
 
-#define gic_wedgeb2bok 0	/*
-				 * Can GIC handle b2b writes to wedge register?
-				 */
-#if gic_wedgeb2bok == 0
-static DEFINE_SPINLOCK(gic_wedgeb2b_lock);
-#endif
-
 void gic_send_ipi(unsigned int intr)
 {
-#if gic_wedgeb2bok == 0
-	unsigned long flags;
-#endif
 	pr_debug("CPU%d: %s status %08x\n", smp_processor_id(), __func__,
 		 read_c0_status());
-	if (!gic_wedgeb2bok)
-		spin_lock_irqsave(&gic_wedgeb2b_lock, flags);
 	GICWRITE(GIC_REG(SHARED, GIC_SH_WEDGE), 0x80000000 | intr);
-	if (!gic_wedgeb2bok) {
-		(void) GIC_REG(SHARED, GIC_SH_CONFIG);
-		spin_unlock_irqrestore(&gic_wedgeb2b_lock, flags);
-	}
 }
 
 /* This is Malta specific and needs to be exported */
-static void vpe_local_setup(unsigned int numvpes)
+static void __init vpe_local_setup(unsigned int numvpes)
 {
 	int i;
 	unsigned long timer_interrupt = 5, perf_interrupt = 5;
@@ -105,44 +90,34 @@ unsigned int gic_get_int(void)
 
 static unsigned int gic_irq_startup(unsigned int irq)
 {
-	pr_debug("CPU%d: %s: irq%d\n", smp_processor_id(), __func__, irq);
 	irq -= _irqbase;
-	GIC_SET_INTR_MASK(irq, 1);
+	pr_debug("CPU%d: %s: irq%d\n", smp_processor_id(), __func__, irq);
+	GIC_SET_INTR_MASK(irq);
 	return 0;
 }
 
 static void gic_irq_ack(unsigned int irq)
 {
-#if gic_wedgeb2bok == 0
-	unsigned long flags;
-#endif
-	pr_debug("CPU%d: %s: irq%d\n", smp_processor_id(), __func__, irq);
 	irq -= _irqbase;
-	GIC_CLR_INTR_MASK(irq, 1);
+	pr_debug("CPU%d: %s: irq%d\n", smp_processor_id(), __func__, irq);
+	GIC_CLR_INTR_MASK(irq);
 
-	if (_intrmap[irq].trigtype == GIC_TRIG_EDGE) {
-		if (!gic_wedgeb2bok)
-			spin_lock_irqsave(&gic_wedgeb2b_lock, flags);
+	if (gic_irq_flags[irq] & GIC_IRQ_FLAG_EDGE)
 		GICWRITE(GIC_REG(SHARED, GIC_SH_WEDGE), irq);
-		if (!gic_wedgeb2bok) {
-			(void) GIC_REG(SHARED, GIC_SH_CONFIG);
-			spin_unlock_irqrestore(&gic_wedgeb2b_lock, flags);
-		}
-	}
 }
 
 static void gic_mask_irq(unsigned int irq)
 {
-	pr_debug("CPU%d: %s: irq%d\n", smp_processor_id(), __func__, irq);
 	irq -= _irqbase;
-	GIC_CLR_INTR_MASK(irq, 1);
+	pr_debug("CPU%d: %s: irq%d\n", smp_processor_id(), __func__, irq);
+	GIC_CLR_INTR_MASK(irq);
 }
 
 static void gic_unmask_irq(unsigned int irq)
 {
-	pr_debug("CPU%d: %s: irq%d\n", smp_processor_id(), __func__, irq);
 	irq -= _irqbase;
-	GIC_SET_INTR_MASK(irq, 1);
+	pr_debug("CPU%d: %s: irq%d\n", smp_processor_id(), __func__, irq);
+	GIC_SET_INTR_MASK(irq);
 }
 
 #ifdef CONFIG_SMP
@@ -155,9 +130,8 @@ static int gic_set_affinity(unsigned int irq, const struct cpumask *cpumask)
 	unsigned long	flags;
 	int		i;
 
-	pr_debug(KERN_DEBUG "%s called\n", __func__);
 	irq -= _irqbase;
-
+	pr_debug(KERN_DEBUG "%s(%d) called\n", __func__, irq);
 	cpumask_and(&tmp, cpumask, cpu_online_mask);
 	if (cpus_empty(tmp))
 		return -1;
@@ -168,13 +142,6 @@ static int gic_set_affinity(unsigned int irq, const struct cpumask *cpumask)
 		/* Re-route this IRQ */
 		GIC_SH_MAP_TO_VPE_SMASK(irq, first_cpu(tmp));
 
-		/*
-		 * FIXME: assumption that _intrmap is ordered and has no holes
-		 */
-
-		/* Update the intr_map */
-		_intrmap[irq].cpunum = first_cpu(tmp);
-
 		/* Update the pcpu_masks */
 		for (i = 0; i < NR_CPUS; i++)
 			clear_bit(irq, pcpu_masks[i].pcpu_mask);
@@ -201,8 +168,9 @@ static struct irq_chip gic_irq_controller = {
 #endif
 };
 
-static void __init setup_intr(unsigned int intr, unsigned int cpu,
-	unsigned int pin, unsigned int polarity, unsigned int trigtype)
+static void __init gic_setup_intr(unsigned int intr, unsigned int cpu,
+	unsigned int pin, unsigned int polarity, unsigned int trigtype,
+	unsigned int flags)
 {
 	/* Setup Intr to Pin mapping */
 	if (pin & GIC_MAP_TO_NMI_MSK) {
@@ -227,38 +195,43 @@ static void __init setup_intr(unsigned int intr, unsigned int cpu,
 	GIC_SET_TRIGGER(intr, trigtype);
 
 	/* Init Intr Masks */
-	GIC_SET_INTR_MASK(intr, 0);
+	GIC_CLR_INTR_MASK(intr);
+	/* Initialise per-cpu Interrupt software masks */
+	if (flags & GIC_FLAG_IPI)
+		set_bit(intr, pcpu_masks[cpu].pcpu_mask);
+	if (flags & GIC_FLAG_TRANSPARENT)
+		GIC_SET_INTR_MASK(intr);
+	if (trigtype == GIC_TRIG_EDGE)
+		gic_irq_flags[intr] |= GIC_IRQ_FLAG_EDGE;
 }
 
-static void __init gic_basic_init(void)
+static void __init gic_basic_init(int numintrs, int numvpes,
+			struct gic_intr_map *intrmap, int mapsize)
 {
 	unsigned int i, cpu;
 
 	/* Setup defaults */
-	for (i = 0; i < GIC_NUM_INTRS; i++) {
+	for (i = 0; i < numintrs; i++) {
 		GIC_SET_POLARITY(i, GIC_POL_POS);
 		GIC_SET_TRIGGER(i, GIC_TRIG_LEVEL);
-		GIC_SET_INTR_MASK(i, 0);
+		GIC_CLR_INTR_MASK(i);
+		if (i < GIC_NUM_INTRS)
+			gic_irq_flags[i] = 0;
 	}
 
 	/* Setup specifics */
-	for (i = 0; i < _mapsize; i++) {
-		cpu = _intrmap[i].cpunum;
+	for (i = 0; i < mapsize; i++) {
+		cpu = intrmap[i].cpunum;
 		if (cpu == X)
 			continue;
-
-		if (cpu == 0 && i != 0 && _intrmap[i].intrnum == 0 &&
-					_intrmap[i].ipiflag == 0)
+		if (cpu == 0 && i != 0 && intrmap[i].flags == 0)
 			continue;
-
-		setup_intr(_intrmap[i].intrnum,
-				_intrmap[i].cpunum,
-				_intrmap[i].pin,
-				_intrmap[i].polarity,
-				_intrmap[i].trigtype);
-		/* Initialise per-cpu Interrupt software masks */
-		if (_intrmap[i].ipiflag)
-			set_bit(_intrmap[i].intrnum, pcpu_masks[cpu].pcpu_mask);
+		gic_setup_intr(i,
+			intrmap[i].cpunum,
+			intrmap[i].pin,
+			intrmap[i].polarity,
+			intrmap[i].trigtype,
+			intrmap[i].flags);
 	}
 
 	vpe_local_setup(numvpes);
@@ -273,12 +246,11 @@ void __init gic_init(unsigned long gic_base_addr,
 		     unsigned int irqbase)
 {
 	unsigned int gicconfig;
+	int numvpes, numintrs;
 
 	_gic_base = (unsigned long) ioremap_nocache(gic_base_addr,
 						    gic_addrspace_size);
 	_irqbase = irqbase;
-	_intrmap = intr_map;
-	_mapsize = intr_map_size;
 
 	GICREAD(GIC_REG(SHARED, GIC_SH_CONFIG), gicconfig);
 	numintrs = (gicconfig & GIC_SH_CONFIG_NUMINTRS_MSK) >>
@@ -288,7 +260,7 @@ void __init gic_init(unsigned long gic_base_addr,
 	numvpes = (gicconfig & GIC_SH_CONFIG_NUMVPES_MSK) >>
 		  GIC_SH_CONFIG_NUMVPES_SHF;
 
-	pr_debug("%s called\n", __func__);
+	pr_debug("%s called\n", __FUNCTION__);
 
-	gic_basic_init();
+	gic_basic_init(numintrs, numvpes, intr_map, intr_map_size);
 }
diff --git a/arch/mips/mti-malta/malta-int.c b/arch/mips/mti-malta/malta-int.c
index e568d0d..377a925 100644
--- a/arch/mips/mti-malta/malta-int.c
+++ b/arch/mips/mti-malta/malta-int.c
@@ -379,32 +379,32 @@ static msc_irqmap_t __initdata msc_eicirqmap[] = {
 
 static int __initdata msc_nr_eicirqs = ARRAY_SIZE(msc_eicirqmap);
 
-#if defined(CONFIG_MIPS_MT_SMP)
 /*
  * This GIC specific tabular array defines the association between External
  * Interrupts and CPUs/Core Interrupts. The nature of the External
  * Interrupts is also defined here - polarity/trigger.
  */
+
+#define GIC_CPU_NMI GIC_MAP_TO_NMI_MSK
 static struct gic_intr_map gic_intr_map[GIC_NUM_INTRS] = {
-	{ GIC_EXT_INTR(0), 	X,	X,		X, 		X,		0 },
-	{ GIC_EXT_INTR(1), 	X,	X,		X, 		X,		0 },
-	{ GIC_EXT_INTR(2), 	X,	X,		X, 		X,		0 },
-	{ GIC_EXT_INTR(3), 	0,	GIC_CPU_INT0,	GIC_POL_POS, 	GIC_TRIG_LEVEL,	0 },
-	{ GIC_EXT_INTR(4), 	0,	GIC_CPU_INT1,	GIC_POL_POS, 	GIC_TRIG_LEVEL,	0 },
-	{ GIC_EXT_INTR(5), 	0,	GIC_CPU_INT2,	GIC_POL_POS, 	GIC_TRIG_LEVEL,	0 },
-	{ GIC_EXT_INTR(6), 	0,	GIC_CPU_INT3,	GIC_POL_POS, 	GIC_TRIG_LEVEL,	0 },
-	{ GIC_EXT_INTR(7), 	0,	GIC_CPU_INT4,	GIC_POL_POS, 	GIC_TRIG_LEVEL,	0 },
-	{ GIC_EXT_INTR(8), 	0,	GIC_CPU_INT3,	GIC_POL_POS, 	GIC_TRIG_LEVEL,	0 },
-	{ GIC_EXT_INTR(9), 	0,	GIC_CPU_INT3,	GIC_POL_POS, 	GIC_TRIG_LEVEL,	0 },
-	{ GIC_EXT_INTR(10), 	X,	X,		X, 		X,		0 },
-	{ GIC_EXT_INTR(11), 	X,	X,		X, 		X,		0 },
-	{ GIC_EXT_INTR(12), 	0,	GIC_CPU_INT3,	GIC_POL_POS, 	GIC_TRIG_LEVEL,	0 },
-	{ GIC_EXT_INTR(13), 	0,	GIC_MAP_TO_NMI_MSK,	GIC_POL_POS, GIC_TRIG_LEVEL,	0 },
-	{ GIC_EXT_INTR(14), 	0,	GIC_MAP_TO_NMI_MSK,	GIC_POL_POS, GIC_TRIG_LEVEL,	0 },
-	{ GIC_EXT_INTR(15), 	X,	X,		X, 		X,		0 },
-/* This is the end of the general interrupts now we do IPI ones */
+	{ X, X,		   X,		X,		0 },
+	{ X, X,		   X,	 	X,		0 },
+	{ X, X,		   X,		X,		0 },
+	{ 0, GIC_CPU_INT0, GIC_POL_POS, GIC_TRIG_LEVEL, GIC_FLAG_TRANSPARENT },
+	{ 0, GIC_CPU_INT1, GIC_POL_POS, GIC_TRIG_LEVEL, GIC_FLAG_TRANSPARENT },
+	{ 0, GIC_CPU_INT2, GIC_POL_POS, GIC_TRIG_LEVEL, GIC_FLAG_TRANSPARENT },
+	{ 0, GIC_CPU_INT3, GIC_POL_POS, GIC_TRIG_LEVEL, GIC_FLAG_TRANSPARENT },
+	{ 0, GIC_CPU_INT4, GIC_POL_POS, GIC_TRIG_LEVEL, GIC_FLAG_TRANSPARENT },
+	{ 0, GIC_CPU_INT3, GIC_POL_POS, GIC_TRIG_LEVEL, GIC_FLAG_TRANSPARENT },
+	{ 0, GIC_CPU_INT3, GIC_POL_POS, GIC_TRIG_LEVEL, GIC_FLAG_TRANSPARENT },
+	{ X, X,		   X,		X,		0 },
+	{ X, X,		   X,		X,		0 },
+	{ 0, GIC_CPU_INT3, GIC_POL_POS, GIC_TRIG_LEVEL, GIC_FLAG_TRANSPARENT },
+	{ 0, GIC_CPU_NMI,  GIC_POL_POS, GIC_TRIG_LEVEL, GIC_FLAG_TRANSPARENT },
+	{ 0, GIC_CPU_NMI,  GIC_POL_POS, GIC_TRIG_LEVEL, GIC_FLAG_TRANSPARENT },
+	{ X, X,		   X,		X,	        0 },
+	/* The remainder of this table is initialised by fill_ipi_map */
 };
-#endif
 
 /*
  * GCMP needs to be detected before any SMP initialisation
@@ -419,20 +419,35 @@ int __init gcmp_probe(unsigned long addr, unsigned long size)
 	gcmp_present = (GCMPGCB(GCMPB) & GCMP_GCB_GCMPB_GCMPBASE_MSK) == GCMP_BASE_ADDR;
 
 	if (gcmp_present)
-		printk(KERN_DEBUG "GCMP present\n");
+		pr_debug("GCMP present\n");
 	return gcmp_present;
 }
 
+/* Return the number of IOCU's present */
+int __init gcmp_niocu(void)
+{
+  return gcmp_present ?
+    (GCMPGCB(GC) & GCMP_GCB_GC_NUMIOCU_MSK) >> GCMP_GCB_GC_NUMIOCU_SHF :
+    0;
+}
+
+/* Set GCMP region attributes */
+void __init gcmp_setregion(int region, unsigned long base,
+			   unsigned long mask, int type)
+{
+	GCMPGCBn(CMxBASE, region) = base;
+	GCMPGCBn(CMxMASK, region) = mask | type;
+}
+
 #if defined(CONFIG_MIPS_MT_SMP)
 static void __init fill_ipi_map1(int baseintr, int cpu, int cpupin)
 {
 	int intr = baseintr + cpu;
-	gic_intr_map[intr].intrnum = GIC_EXT_INTR(intr);
 	gic_intr_map[intr].cpunum = cpu;
 	gic_intr_map[intr].pin = cpupin;
 	gic_intr_map[intr].polarity = GIC_POL_POS;
 	gic_intr_map[intr].trigtype = GIC_TRIG_EDGE;
-	gic_intr_map[intr].ipiflag = 1;
+	gic_intr_map[intr].flags = GIC_FLAG_IPI;
 	ipi_map[cpu] |= (1 << (cpupin + 2));
 }
 
@@ -447,6 +462,12 @@ static void __init fill_ipi_map(void)
 }
 #endif
 
+void __init arch_init_ipiirq(int irq, struct irqaction *action)
+{
+	setup_irq(irq, action);
+	set_irq_handler(irq, handle_percpu_irq);
+}
+
 void __init arch_init_irq(void)
 {
 	init_i8259_irqs();
@@ -463,7 +484,7 @@ void __init arch_init_irq(void)
 		MSC01_SC_CFG_GICPRES_MSK) >> MSC01_SC_CFG_GICPRES_SHF;
 	}
 	if (gic_present)
-		printk(KERN_DEBUG "GIC present\n");
+		pr_debug("GIC present\n");
 
 	switch (mips_revision_sconid) {
 	case MIPS_REVISION_SCON_SOCIT:
@@ -526,16 +547,16 @@ void __init arch_init_irq(void)
 						&corehi_irqaction);
 	}
 
-#if defined(CONFIG_MIPS_MT_SMP)
 	if (gic_present) {
 		/* FIXME */
 		int i;
-
+#if defined(CONFIG_MIPS_MT_SMP)
 		gic_call_int_base = GIC_NUM_INTRS - NR_CPUS;
 		gic_resched_int_base = gic_call_int_base - NR_CPUS;
-
 		fill_ipi_map();
-		gic_init(GIC_BASE_ADDR, GIC_ADDRSPACE_SZ, gic_intr_map, ARRAY_SIZE(gic_intr_map), MIPS_GIC_IRQ_BASE);
+#endif
+		gic_init(GIC_BASE_ADDR, GIC_ADDRSPACE_SZ, gic_intr_map,
+				ARRAY_SIZE(gic_intr_map), MIPS_GIC_IRQ_BASE);
 		if (!gcmp_present) {
 			/* Enable the GIC */
 			i = REG(_msc01_biu_base, MSC01_SC_CFG);
@@ -543,7 +564,7 @@ void __init arch_init_irq(void)
 				(i | (0x1 << MSC01_SC_CFG_GICENA_SHF));
 			pr_debug("GIC Enabled\n");
 		}
-
+#if defined(CONFIG_MIPS_MT_SMP)
 		/* set up ipi interrupts */
 		if (cpu_has_vint) {
 			set_vi_handler(MIPSCPU_INT_IPI0, malta_ipi_irqdispatch);
@@ -556,16 +577,14 @@ void __init arch_init_irq(void)
 		write_c0_status(0x1100dc00);
 		printk("CPU%d: status register frc %08x\n", smp_processor_id(), read_c0_status());
 		for (i = 0; i < NR_CPUS; i++) {
-			setup_irq(MIPS_GIC_IRQ_BASE +
-					GIC_RESCHED_INT(i), &irq_resched);
-			setup_irq(MIPS_GIC_IRQ_BASE +
-					GIC_CALL_INT(i), &irq_call);
-			set_irq_handler(MIPS_GIC_IRQ_BASE +
-					GIC_RESCHED_INT(i), handle_percpu_irq);
-			set_irq_handler(MIPS_GIC_IRQ_BASE +
-					GIC_CALL_INT(i), handle_percpu_irq);
+			arch_init_ipiirq(MIPS_GIC_IRQ_BASE +
+					 GIC_RESCHED_INT(i), &irq_resched);
+			arch_init_ipiirq(MIPS_GIC_IRQ_BASE +
+					 GIC_CALL_INT(i), &irq_call);
 		}
+#endif
 	} else {
+#if defined(CONFIG_MIPS_MT_SMP)
 		/* set up ipi interrupts */
 		if (cpu_has_veic) {
 			set_vi_handler (MSC01E_INT_SW0, ipi_resched_dispatch);
@@ -580,14 +599,10 @@ void __init arch_init_irq(void)
 			cpu_ipi_resched_irq = MIPS_CPU_IRQ_BASE + MIPS_CPU_IPI_RESCHED_IRQ;
 			cpu_ipi_call_irq = MIPS_CPU_IRQ_BASE + MIPS_CPU_IPI_CALL_IRQ;
 		}
-
-		setup_irq(cpu_ipi_resched_irq, &irq_resched);
-		setup_irq(cpu_ipi_call_irq, &irq_call);
-
-		set_irq_handler(cpu_ipi_resched_irq, handle_percpu_irq);
-		set_irq_handler(cpu_ipi_call_irq, handle_percpu_irq);
-	}
+		arch_init_ipiirq(cpu_ipi_resched_irq, &irq_resched);
+		arch_init_ipiirq(cpu_ipi_call_irq, &irq_call);
 #endif
+	}
 }
 
 void malta_be_init(void)
diff --git a/arch/mips/mti-malta/malta-pci.c b/arch/mips/mti-malta/malta-pci.c
index b974319..25994e6 100644
--- a/arch/mips/mti-malta/malta-pci.c
+++ b/arch/mips/mti-malta/malta-pci.c
@@ -27,7 +27,7 @@
 #include <linux/init.h>
 
 #include <asm/gt64120.h>
-
+#include <asm/gcmpregs.h>
 #include <asm/mips-boards/generic.h>
 #include <asm/mips-boards/bonito64.h>
 #include <asm/mips-boards/msc01_pci.h>
@@ -201,7 +201,11 @@ void __init mips_pcibios_init(void)
 		msc_mem_resource.start = start & mask;
 		msc_mem_resource.end = (start & mask) | ~mask;
 		msc_controller.mem_offset = (start & mask) - (map & mask);
-
+#ifdef CONFIG_MIPS_CMP
+		if (gcmp_niocu())
+			gcmp_setregion(0, start, mask,
+				GCMP_GCB_GCMPB_CMDEFTGT_IOCU1);
+#endif
 		MSC_READ(MSC01_PCI_SC2PIOBASL, start);
 		MSC_READ(MSC01_PCI_SC2PIOMSKL, mask);
 		MSC_READ(MSC01_PCI_SC2PIOMAPL, map);
@@ -209,7 +213,11 @@ void __init mips_pcibios_init(void)
 		msc_io_resource.end = (map & mask) | ~mask;
 		msc_controller.io_offset = 0;
 		ioport_resource.end = ~mask;
-
+#ifdef CONFIG_MIPS_CMP
+		if (gcmp_niocu())
+			gcmp_setregion(1, start, mask,
+				GCMP_GCB_GCMPB_CMDEFTGT_IOCU1);
+#endif
 		/* If ranges overlap I/O takes precedence.  */
 		start = start & mask;
 		end = start | ~mask;
