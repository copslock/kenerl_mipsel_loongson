Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jan 2014 11:37:35 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:9563 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827367AbaAOKhOpr69O (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Jan 2014 11:37:14 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 09/15] MIPS: Malta: make use of generic CM support
Date:   Wed, 15 Jan 2014 10:31:54 +0000
Message-ID: <1389781920-31151-10-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1389781920-31151-1-git-send-email-paul.burton@imgtec.com>
References: <1389781920-31151-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.152.22]
X-SEF-Processed: 7_3_0_01192__2014_01_15_10_37_09
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38994
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

Remove the Malta-specific CM probe code and instead make use of the
newly added generic CM code.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/Kconfig                 |  3 ++
 arch/mips/include/asm/smp-ops.h   |  5 +++
 arch/mips/mti-malta/malta-init.c  |  8 ++---
 arch/mips/mti-malta/malta-int.c   | 70 ++++++++-------------------------------
 arch/mips/mti-malta/malta-setup.c |  4 +--
 arch/mips/pci/pci-malta.c         | 22 ++++++------
 6 files changed, 38 insertions(+), 74 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index a27863a..ba5d8ac 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -861,6 +861,7 @@ config CEVT_R4K
 	bool
 
 config CEVT_GIC
+	select MIPS_CM
 	bool
 
 config CEVT_SB1250
@@ -879,6 +880,7 @@ config CSRC_R4K
 	bool
 
 config CSRC_GIC
+	select MIPS_CM
 	bool
 
 config CSRC_SB1250
@@ -1023,6 +1025,7 @@ config IRQ_GT641XX
 	bool
 
 config IRQ_GIC
+	select MIPS_CM
 	bool
 
 config PCI_GT64XXX_PCI0
diff --git a/arch/mips/include/asm/smp-ops.h b/arch/mips/include/asm/smp-ops.h
index a02c9d4..a042d24 100644
--- a/arch/mips/include/asm/smp-ops.h
+++ b/arch/mips/include/asm/smp-ops.h
@@ -13,6 +13,8 @@
 
 #include <linux/errno.h>
 
+#include <asm/mips-cm.h>
+
 #ifdef CONFIG_SMP
 
 #include <linux/cpumask.h>
@@ -79,6 +81,9 @@ static inline int register_cmp_smp_ops(void)
 #ifdef CONFIG_MIPS_CMP
 	extern struct plat_smp_ops cmp_smp_ops;
 
+	if (!mips_cm_present())
+		return -ENODEV;
+
 	register_smp_ops(&cmp_smp_ops);
 
 	return 0;
diff --git a/arch/mips/mti-malta/malta-init.c b/arch/mips/mti-malta/malta-init.c
index fcebfce..85a62b0 100644
--- a/arch/mips/mti-malta/malta-init.c
+++ b/arch/mips/mti-malta/malta-init.c
@@ -20,7 +20,7 @@
 #include <asm/smp-ops.h>
 #include <asm/traps.h>
 #include <asm/fw/fw.h>
-#include <asm/gcmpregs.h>
+#include <asm/mips-cm.h>
 #include <asm/mips-boards/generic.h>
 #include <asm/mips-boards/malta.h>
 
@@ -276,10 +276,10 @@ mips_pci_controller:
 	console_config();
 #endif
 	/* Early detection of CMP support */
-	if (gcmp_probe(GCMP_BASE_ADDR, GCMP_ADDRSPACE_SZ))
-		if (!register_cmp_smp_ops())
-			return;
+	mips_cm_probe();
 
+	if (!register_cmp_smp_ops())
+		return;
 	if (!register_vsmp_smp_ops())
 		return;
 
diff --git a/arch/mips/mti-malta/malta-int.c b/arch/mips/mti-malta/malta-int.c
index ca3e3a4..93103f8 100644
--- a/arch/mips/mti-malta/malta-int.c
+++ b/arch/mips/mti-malta/malta-int.c
@@ -26,6 +26,7 @@
 #include <asm/i8259.h>
 #include <asm/irq_cpu.h>
 #include <asm/irq_regs.h>
+#include <asm/mips-cm.h>
 #include <asm/mips-boards/malta.h>
 #include <asm/mips-boards/maltaint.h>
 #include <asm/gt64120.h>
@@ -33,13 +34,10 @@
 #include <asm/mips-boards/msc01_pci.h>
 #include <asm/msc01_ic.h>
 #include <asm/gic.h>
-#include <asm/gcmpregs.h>
 #include <asm/setup.h>
 #include <asm/rtlx.h>
 
-int gcmp_present = -1;
 static unsigned long _msc01_biu_base;
-static unsigned long _gcmp_base;
 static unsigned int ipi_map[NR_CPUS];
 
 static DEFINE_RAW_SPINLOCK(mips_irq_lock);
@@ -418,48 +416,6 @@ static struct gic_intr_map gic_intr_map[GIC_NUM_INTRS] = {
 };
 #undef X
 
-/*
- * GCMP needs to be detected before any SMP initialisation
- */
-int __init gcmp_probe(unsigned long addr, unsigned long size)
-{
-	if ((mips_revision_sconid != MIPS_REVISION_SCON_ROCIT)  &&
-	    (mips_revision_sconid != MIPS_REVISION_SCON_GT64120)) {
-		gcmp_present = 0;
-		pr_debug("GCMP NOT present\n");
-		return gcmp_present;
-	}
-
-	if (gcmp_present >= 0)
-		return gcmp_present;
-
-	_gcmp_base = (unsigned long) ioremap_nocache(GCMP_BASE_ADDR,
-		GCMP_ADDRSPACE_SZ);
-	_msc01_biu_base = (unsigned long) ioremap_nocache(MSC01_BIU_REG_BASE,
-		MSC01_BIU_ADDRSPACE_SZ);
-	gcmp_present = ((GCMPGCB(GCMPB) & GCMP_GCB_GCMPB_GCMPBASE_MSK) ==
-		GCMP_BASE_ADDR);
-
-	if (gcmp_present)
-		pr_debug("GCMP present\n");
-	return gcmp_present;
-}
-
-/* Return the number of IOCU's present */
-int __init gcmp_niocu(void)
-{
-	return gcmp_present ? ((GCMPGCB(GC) & GCMP_GCB_GC_NUMIOCU_MSK) >>
-		GCMP_GCB_GC_NUMIOCU_SHF) : 0;
-}
-
-/* Set GCMP region attributes */
-void __init gcmp_setregion(int region, unsigned long base,
-			   unsigned long mask, int type)
-{
-	GCMPGCBn(CMxBASE, region) = base;
-	GCMPGCBn(CMxMASK, region) = mask | type;
-}
-
 #if defined(CONFIG_MIPS_MT_SMP)
 static void __init fill_ipi_map1(int baseintr, int cpu, int cpupin)
 {
@@ -496,8 +452,8 @@ void __init arch_init_irq(void)
 	if (!cpu_has_veic)
 		mips_cpu_irq_init();
 
-	if (gcmp_present)  {
-		GCMPGCB(GICBA) = GIC_BASE_ADDR | GCMP_GCB_GICBA_EN_MSK;
+	if (mips_cm_present()) {
+		write_gcr_gic_base(GIC_BASE_ADDR | CM_GCR_GIC_BASE_GICEN_MSK);
 		gic_present = 1;
 	} else {
 		if (mips_revision_sconid == MIPS_REVISION_SCON_ROCIT) {
@@ -584,7 +540,7 @@ void __init arch_init_irq(void)
 #endif
 		gic_init(GIC_BASE_ADDR, GIC_ADDRSPACE_SZ, gic_intr_map,
 				ARRAY_SIZE(gic_intr_map), MIPS_GIC_IRQ_BASE);
-		if (!gcmp_present) {
+		if (!mips_cm_present()) {
 			/* Enable the GIC */
 			i = REG(_msc01_biu_base, MSC01_SC_CFG);
 			REG(_msc01_biu_base, MSC01_SC_CFG) =
@@ -708,16 +664,16 @@ int malta_be_handler(struct pt_regs *regs, int is_fixup)
 	/* This duplicates the handling in do_be which seems wrong */
 	int retval = is_fixup ? MIPS_BE_FIXUP : MIPS_BE_FATAL;
 
-	if (gcmp_present) {
-		unsigned long cm_error = GCMPGCB(GCMEC);
-		unsigned long cm_addr = GCMPGCB(GCMEA);
-		unsigned long cm_other = GCMPGCB(GCMEO);
+	if (mips_cm_present()) {
+		unsigned long cm_error = read_gcr_error_cause();
+		unsigned long cm_addr = read_gcr_error_addr();
+		unsigned long cm_other = read_gcr_error_mult();
 		unsigned long cause, ocause;
 		char buf[256];
 
-		cause = (cm_error & GCMP_GCB_GMEC_ERROR_TYPE_MSK);
+		cause = cm_error & CM_GCR_ERROR_CAUSE_ERRTYPE_MSK;
 		if (cause != 0) {
-			cause >>= GCMP_GCB_GMEC_ERROR_TYPE_SHF;
+			cause >>= CM_GCR_ERROR_CAUSE_ERRTYPE_SHF;
 			if (cause < 16) {
 				unsigned long cca_bits = (cm_error >> 15) & 7;
 				unsigned long tr_bits = (cm_error >> 12) & 7;
@@ -748,8 +704,8 @@ int malta_be_handler(struct pt_regs *regs, int is_fixup)
 					 mcmd[cmd_bits], sport_bits);
 			}
 
-			ocause = (cm_other & GCMP_GCB_GMEO_ERROR_2ND_MSK) >>
-				 GCMP_GCB_GMEO_ERROR_2ND_SHF;
+			ocause = (cm_other & CM_GCR_ERROR_MULT_ERR2ND_MSK) >>
+				 CM_GCR_ERROR_MULT_ERR2ND_SHF;
 
 			pr_err("CM_ERROR=%08lx %s <%s>\n", cm_error,
 			       causes[cause], buf);
@@ -757,7 +713,7 @@ int malta_be_handler(struct pt_regs *regs, int is_fixup)
 			pr_err("CM_OTHER=%08lx %s\n", cm_other, causes[ocause]);
 
 			/* reprime cause register */
-			GCMPGCB(GCMEC) = 0;
+			write_gcr_error_cause(0);
 		}
 	}
 
diff --git a/arch/mips/mti-malta/malta-setup.c b/arch/mips/mti-malta/malta-setup.c
index c72a069..01a55f3 100644
--- a/arch/mips/mti-malta/malta-setup.c
+++ b/arch/mips/mti-malta/malta-setup.c
@@ -26,12 +26,12 @@
 #include <linux/time.h>
 
 #include <asm/fw/fw.h>
+#include <asm/mips-cm.h>
 #include <asm/mips-boards/generic.h>
 #include <asm/mips-boards/malta.h>
 #include <asm/mips-boards/maltaint.h>
 #include <asm/dma.h>
 #include <asm/traps.h>
-#include <asm/gcmpregs.h>
 #ifdef CONFIG_VT
 #include <linux/console.h>
 #endif
@@ -127,7 +127,7 @@ static int __init plat_enable_iocoherency(void)
 				 BONITO_PCIMEMBASECFG_MEMBASE1_CACHED);
 			pr_info("Enabled Bonito IOBC coherency\n");
 		}
-	} else if (gcmp_niocu() != 0) {
+	} else if (mips_cm_numiocu() != 0) {
 		/* Nothing special needs to be done to enable coherency */
 		pr_info("CMP IOCU detected\n");
 		if ((*(unsigned int *)0xbf403000 & 0x81) != 0x81) {
diff --git a/arch/mips/pci/pci-malta.c b/arch/mips/pci/pci-malta.c
index f1a7389..cfbbc3e 100644
--- a/arch/mips/pci/pci-malta.c
+++ b/arch/mips/pci/pci-malta.c
@@ -27,7 +27,7 @@
 #include <linux/init.h>
 
 #include <asm/gt64120.h>
-#include <asm/gcmpregs.h>
+#include <asm/mips-cm.h>
 #include <asm/mips-boards/generic.h>
 #include <asm/mips-boards/bonito64.h>
 #include <asm/mips-boards/msc01_pci.h>
@@ -201,11 +201,11 @@ void __init mips_pcibios_init(void)
 		msc_mem_resource.start = start & mask;
 		msc_mem_resource.end = (start & mask) | ~mask;
 		msc_controller.mem_offset = (start & mask) - (map & mask);
-#ifdef CONFIG_MIPS_CMP
-		if (gcmp_niocu())
-			gcmp_setregion(0, start, mask,
-				GCMP_GCB_GCMPB_CMDEFTGT_IOCU1);
-#endif
+		if (mips_cm_numiocu()) {
+			write_gcr_reg0_base(start);
+			write_gcr_reg0_mask(mask |
+					    CM_GCR_REGn_MASK_CMTGT_IOCU0);
+		}
 		MSC_READ(MSC01_PCI_SC2PIOBASL, start);
 		MSC_READ(MSC01_PCI_SC2PIOMSKL, mask);
 		MSC_READ(MSC01_PCI_SC2PIOMAPL, map);
@@ -213,11 +213,11 @@ void __init mips_pcibios_init(void)
 		msc_io_resource.end = (map & mask) | ~mask;
 		msc_controller.io_offset = 0;
 		ioport_resource.end = ~mask;
-#ifdef CONFIG_MIPS_CMP
-		if (gcmp_niocu())
-			gcmp_setregion(1, start, mask,
-				GCMP_GCB_GCMPB_CMDEFTGT_IOCU1);
-#endif
+		if (mips_cm_numiocu()) {
+			write_gcr_reg1_base(start);
+			write_gcr_reg1_mask(mask |
+					    CM_GCR_REGn_MASK_CMTGT_IOCU0);
+		}
 		/* If ranges overlap I/O takes precedence.  */
 		start = start & mask;
 		end = start | ~mask;
-- 
1.8.4.2
