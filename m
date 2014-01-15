Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jan 2014 11:34:46 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:10837 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827313AbaAOKeYhLs4X (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Jan 2014 11:34:24 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 06/15] MIPS: add generic CM probe & access code
Date:   Wed, 15 Jan 2014 10:31:51 +0000
Message-ID: <1389781920-31151-7-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1389781920-31151-1-git-send-email-paul.burton@imgtec.com>
References: <1389781920-31151-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.152.22]
X-SEF-Processed: 7_3_0_01192__2014_01_15_10_34_19
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38990
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

The kernel currently only probes for a MIPS Coherence Manager in the
Malta interrupt code in order to detect & enable the GIC. However CM is
not Malta-specific, so this should really be more generic. This patch
introduces some non-Malta-specific code which probes for a CM and
performs some basic initialisation.

A new header, with temporarily duplicated register definitions, is
introduced in order to:

  1) Allow the new definitions to be correct with regards to the
     CM documentation, as many of those in gcmpregs.h aren't.

  2) Allow switching away from the REG() macro used via a few layers of
     nested macros in order to access registers in gcmpregs.h. This
     patch instead introduced accessor functions akin to the
     {read,write}_c0_* functions used for cop0 registers.

  3) Allow users of the CM to be migrated one by one.

  4) Switch from the name 'GCMP' to 'CM' since the Coherence Manager is
     what this code is actually dealing with.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/Kconfig               |   3 +
 arch/mips/include/asm/mips-cm.h | 322 ++++++++++++++++++++++++++++++++++++++++
 arch/mips/kernel/Makefile       |   2 +
 arch/mips/kernel/mips-cm.c      | 121 +++++++++++++++
 4 files changed, 448 insertions(+)
 create mode 100644 arch/mips/include/asm/mips-cm.h
 create mode 100644 arch/mips/kernel/mips-cm.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index e40c255..616e040 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1987,6 +1987,9 @@ config MIPS_CMP
 config MIPS_GIC_IPI
 	bool
 
+config MIPS_CM
+	bool
+
 config SB1_PASS_1_WORKAROUNDS
 	bool
 	depends on CPU_SB1_PASS_1
diff --git a/arch/mips/include/asm/mips-cm.h b/arch/mips/include/asm/mips-cm.h
new file mode 100644
index 0000000..12cae5e
--- /dev/null
+++ b/arch/mips/include/asm/mips-cm.h
@@ -0,0 +1,322 @@
+/*
+ * Copyright (C) 2013 Imagination Technologies
+ * Author: Paul Burton <paul.burton@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifndef __MIPS_ASM_MIPS_CM_H__
+#define __MIPS_ASM_MIPS_CM_H__
+
+#include <linux/io.h>
+#include <linux/types.h>
+
+/* The base address of the CM GCR block */
+extern void __iomem *mips_cm_base;
+
+/* The base address of the CM L2-only sync region */
+extern void __iomem *mips_cm_l2sync_base;
+
+/**
+ * __mips_cm_phys_base - retrieve the physical base address of the CM
+ *
+ * This function returns the physical base address of the Coherence Manager
+ * global control block, or 0 if no Coherence Manager is present. It provides
+ * a default implementation which reads the CMGCRBase register where available,
+ * and may be overriden by platforms which determine this address in a
+ * different way by defining a function with the same prototype except for the
+ * name mips_cm_phys_base (without underscores).
+ */
+extern phys_t __mips_cm_phys_base(void);
+
+/**
+ * mips_cm_probe - probe for a Coherence Manager
+ *
+ * Attempt to detect the presence of a Coherence Manager. Returns 0 if a CM
+ * is successfully detected, else -errno.
+ */
+#ifdef CONFIG_MIPS_CM
+extern int mips_cm_probe(void);
+#else
+static inline int mips_cm_probe(void)
+{
+	return -ENODEV;
+}
+#endif
+
+/**
+ * mips_cm_present - determine whether a Coherence Manager is present
+ *
+ * Returns true if a CM is present in the system, else false.
+ */
+static inline bool mips_cm_present(void)
+{
+#ifdef CONFIG_MIPS_CM
+	return mips_cm_base != NULL;
+#else
+	return false;
+#endif
+}
+
+/**
+ * mips_cm_has_l2sync - determine whether an L2-only sync region is present
+ *
+ * Returns true if the system implements an L2-only sync region, else false.
+ */
+static inline bool mips_cm_has_l2sync(void)
+{
+#ifdef CONFIG_MIPS_CM
+	return mips_cm_l2sync_base != NULL;
+#else
+	return false;
+#endif
+}
+
+/* Offsets to register blocks from the CM base address */
+#define MIPS_CM_GCB_OFS		0x0000 /* Global Control Block */
+#define MIPS_CM_CLCB_OFS	0x2000 /* Core Local Control Block */
+#define MIPS_CM_COCB_OFS	0x4000 /* Core Other Control Block */
+#define MIPS_CM_GDB_OFS		0x6000 /* Global Debug Block */
+
+/* Total size of the CM memory mapped registers */
+#define MIPS_CM_GCR_SIZE	0x8000
+
+/* Size of the L2-only sync region */
+#define MIPS_CM_L2SYNC_SIZE	0x1000
+
+/* Macros to ease the creation of register access functions */
+#define BUILD_CM_R_(name, off)					\
+static inline u32 *addr_gcr_##name(void)			\
+{								\
+	return (u32 *)(mips_cm_base + (off));			\
+}								\
+								\
+static inline u32 read_gcr_##name(void)				\
+{								\
+	return readl(addr_gcr_##name());			\
+}
+
+#define BUILD_CM__W(name, off)					\
+static inline void write_gcr_##name(u32 value)			\
+{								\
+	writel(value, addr_gcr_##name());			\
+}
+
+#define BUILD_CM_RW(name, off)					\
+	BUILD_CM_R_(name, off)					\
+	BUILD_CM__W(name, off)
+
+#define BUILD_CM_Cx_R_(name, off)				\
+	BUILD_CM_R_(cl_##name, MIPS_CM_CLCB_OFS + (off))	\
+	BUILD_CM_R_(co_##name, MIPS_CM_COCB_OFS + (off))
+
+#define BUILD_CM_Cx__W(name, off)				\
+	BUILD_CM__W(cl_##name, MIPS_CM_CLCB_OFS + (off))	\
+	BUILD_CM__W(co_##name, MIPS_CM_COCB_OFS + (off))
+
+#define BUILD_CM_Cx_RW(name, off)				\
+	BUILD_CM_Cx_R_(name, off)				\
+	BUILD_CM_Cx__W(name, off)
+
+/* GCB register accessor functions */
+BUILD_CM_R_(config,		MIPS_CM_GCB_OFS + 0x00)
+BUILD_CM_RW(base,		MIPS_CM_GCB_OFS + 0x08)
+BUILD_CM_RW(access,		MIPS_CM_GCB_OFS + 0x20)
+BUILD_CM_R_(rev,		MIPS_CM_GCB_OFS + 0x30)
+BUILD_CM_RW(error_mask,		MIPS_CM_GCB_OFS + 0x40)
+BUILD_CM_RW(error_cause,	MIPS_CM_GCB_OFS + 0x48)
+BUILD_CM_RW(error_addr,		MIPS_CM_GCB_OFS + 0x50)
+BUILD_CM_RW(error_mult,		MIPS_CM_GCB_OFS + 0x58)
+BUILD_CM_RW(l2_only_sync_base,	MIPS_CM_GCB_OFS + 0x70)
+BUILD_CM_RW(gic_base,		MIPS_CM_GCB_OFS + 0x80)
+BUILD_CM_RW(cpc_base,		MIPS_CM_GCB_OFS + 0x88)
+BUILD_CM_RW(reg0_base,		MIPS_CM_GCB_OFS + 0x90)
+BUILD_CM_RW(reg0_mask,		MIPS_CM_GCB_OFS + 0x98)
+BUILD_CM_RW(reg1_base,		MIPS_CM_GCB_OFS + 0xa0)
+BUILD_CM_RW(reg1_mask,		MIPS_CM_GCB_OFS + 0xa8)
+BUILD_CM_RW(reg2_base,		MIPS_CM_GCB_OFS + 0xb0)
+BUILD_CM_RW(reg2_mask,		MIPS_CM_GCB_OFS + 0xb8)
+BUILD_CM_RW(reg3_base,		MIPS_CM_GCB_OFS + 0xc0)
+BUILD_CM_RW(reg3_mask,		MIPS_CM_GCB_OFS + 0xc8)
+BUILD_CM_R_(gic_status,		MIPS_CM_GCB_OFS + 0xd0)
+BUILD_CM_R_(cpc_status,		MIPS_CM_GCB_OFS + 0xf0)
+
+/* Core Local & Core Other register accessor functions */
+BUILD_CM_Cx_RW(reset_release,	0x00)
+BUILD_CM_Cx_RW(coherence,	0x08)
+BUILD_CM_Cx_R_(config,		0x10)
+BUILD_CM_Cx_RW(other,		0x18)
+BUILD_CM_Cx_RW(reset_base,	0x20)
+BUILD_CM_Cx_R_(id,		0x28)
+BUILD_CM_Cx_RW(reset_ext_base,	0x30)
+BUILD_CM_Cx_R_(tcid_0_priority,	0x40)
+BUILD_CM_Cx_R_(tcid_1_priority,	0x48)
+BUILD_CM_Cx_R_(tcid_2_priority,	0x50)
+BUILD_CM_Cx_R_(tcid_3_priority,	0x58)
+BUILD_CM_Cx_R_(tcid_4_priority,	0x60)
+BUILD_CM_Cx_R_(tcid_5_priority,	0x68)
+BUILD_CM_Cx_R_(tcid_6_priority,	0x70)
+BUILD_CM_Cx_R_(tcid_7_priority,	0x78)
+BUILD_CM_Cx_R_(tcid_8_priority,	0x80)
+
+/* GCR_CONFIG register fields */
+#define CM_GCR_CONFIG_NUMIOCU_SHF		8
+#define CM_GCR_CONFIG_NUMIOCU_MSK		(_ULCAST_(0xf) << 8)
+#define CM_GCR_CONFIG_PCORES_SHF		0
+#define CM_GCR_CONFIG_PCORES_MSK		(_ULCAST_(0xff) << 0)
+
+/* GCR_BASE register fields */
+#define CM_GCR_BASE_GCRBASE_SHF			15
+#define CM_GCR_BASE_GCRBASE_MSK			(_ULCAST_(0x1ffff) << 15)
+#define CM_GCR_BASE_CMDEFTGT_SHF		0
+#define CM_GCR_BASE_CMDEFTGT_MSK		(_ULCAST_(0x3) << 0)
+#define  CM_GCR_BASE_CMDEFTGT_DISABLED		0
+#define  CM_GCR_BASE_CMDEFTGT_MEM		1
+#define  CM_GCR_BASE_CMDEFTGT_IOCU0		2
+#define  CM_GCR_BASE_CMDEFTGT_IOCU1		3
+
+/* GCR_ACCESS register fields */
+#define CM_GCR_ACCESS_ACCESSEN_SHF		0
+#define CM_GCR_ACCESS_ACCESSEN_MSK		(_ULCAST_(0xff) << 0)
+
+/* GCR_REV register fields */
+#define CM_GCR_REV_MAJOR_SHF			8
+#define CM_GCR_REV_MAJOR_MSK			(_ULCAST_(0xff) << 8)
+#define CM_GCR_REV_MINOR_SHF			0
+#define CM_GCR_REV_MINOR_MSK			(_ULCAST_(0xff) << 0)
+
+/* GCR_ERROR_CAUSE register fields */
+#define CM_GCR_ERROR_CAUSE_ERRTYPE_SHF		27
+#define CM_GCR_ERROR_CAUSE_ERRTYPE_MSK		(_ULCAST_(0x1f) << 27)
+#define CM_GCR_ERROR_CAUSE_ERRINFO_SHF		0
+#define CM_GCR_ERROR_CAUSE_ERRINGO_MSK		(_ULCAST_(0x7ffffff) << 0)
+
+/* GCR_ERROR_MULT register fields */
+#define CM_GCR_ERROR_MULT_ERR2ND_SHF		0
+#define CM_GCR_ERROR_MULT_ERR2ND_MSK		(_ULCAST_(0x1f) << 0)
+
+/* GCR_L2_ONLY_SYNC_BASE register fields */
+#define CM_GCR_L2_ONLY_SYNC_BASE_SYNCBASE_SHF	12
+#define CM_GCR_L2_ONLY_SYNC_BASE_SYNCBASE_MSK	(_ULCAST_(0xfffff) << 12)
+#define CM_GCR_L2_ONLY_SYNC_BASE_SYNCEN_SHF	0
+#define CM_GCR_L2_ONLY_SYNC_BASE_SYNCEN_MSK	(_ULCAST_(0x1) << 0)
+
+/* GCR_GIC_BASE register fields */
+#define CM_GCR_GIC_BASE_GICBASE_SHF		17
+#define CM_GCR_GIC_BASE_GICBASE_MSK		(_ULCAST_(0x7fff) << 17)
+#define CM_GCR_GIC_BASE_GICEN_SHF		0
+#define CM_GCR_GIC_BASE_GICEN_MSK		(_ULCAST_(0x1) << 0)
+
+/* GCR_CPC_BASE register fields */
+#define CM_GCR_CPC_BASE_CPCBASE_SHF		17
+#define CM_GCR_CPC_BASE_CPCBASE_MSK		(_ULCAST_(0x7fff) << 17)
+#define CM_GCR_CPC_BASE_CPCEN_SHF		0
+#define CM_GCR_CPC_BASE_CPCEN_MSK		(_ULCAST_(0x1) << 0)
+
+/* GCR_REGn_BASE register fields */
+#define CM_GCR_REGn_BASE_BASEADDR_SHF		16
+#define CM_GCR_REGn_BASE_BASEADDR_MSK		(_ULCAST_(0xffff) << 16)
+
+/* GCR_REGn_MASK register fields */
+#define CM_GCR_REGn_MASK_ADDRMASK_SHF		16
+#define CM_GCR_REGn_MASK_ADDRMASK_MSK		(_ULCAST_(0xffff) << 16)
+#define CM_GCR_REGn_MASK_CCAOVR_SHF		5
+#define CM_GCR_REGn_MASK_CCAOVR_MSK		(_ULCAST_(0x3) << 5)
+#define CM_GCR_REGn_MASK_CCAOVREN_SHF		4
+#define CM_GCR_REGn_MASK_CCAOVREN_MSK		(_ULCAST_(0x1) << 4)
+#define CM_GCR_REGn_MASK_DROPL2_SHF		2
+#define CM_GCR_REGn_MASK_DROPL2_MSK		(_ULCAST_(0x1) << 2)
+#define CM_GCR_REGn_MASK_CMTGT_SHF		0
+#define CM_GCR_REGn_MASK_CMTGT_MSK		(_ULCAST_(0x3) << 0)
+#define  CM_GCR_REGn_MASK_CMTGT_DISABLED	(_ULCAST_(0x0) << 0)
+#define  CM_GCR_REGn_MASK_CMTGT_MEM		(_ULCAST_(0x1) << 0)
+#define  CM_GCR_REGn_MASK_CMTGT_IOCU0		(_ULCAST_(0x2) << 0)
+#define  CM_GCR_REGn_MASK_CMTGT_IOCU1		(_ULCAST_(0x3) << 0)
+
+/* GCR_GIC_STATUS register fields */
+#define CM_GCR_GIC_STATUS_EX_SHF		0
+#define CM_GCR_GIC_STATUS_EX_MSK		(_ULCAST_(0x1) << 0)
+
+/* GCR_CPC_STATUS register fields */
+#define CM_GCR_CPC_STATUS_EX_SHF		0
+#define CM_GCR_CPC_STATUS_EX_MSK		(_ULCAST_(0x1) << 0)
+
+/* GCR_Cx_COHERENCE register fields */
+#define CM_GCR_Cx_COHERENCE_COHDOMAINEN_SHF	0
+#define CM_GCR_Cx_COHERENCE_COHDOMAINEN_MSK	(_ULCAST_(0xff) << 0)
+
+/* GCR_Cx_CONFIG register fields */
+#define CM_GCR_Cx_CONFIG_IOCUTYPE_SHF		10
+#define CM_GCR_Cx_CONFIG_IOCUTYPE_MSK		(_ULCAST_(0x3) << 10)
+#define CM_GCR_Cx_CONFIG_PVPE_SHF		0
+#define CM_GCR_Cx_CONFIG_PVPE_MSK		(_ULCAST_(0x1ff) << 0)
+
+/* GCR_Cx_OTHER register fields */
+#define CM_GCR_Cx_OTHER_CORENUM_SHF		16
+#define CM_GCR_Cx_OTHER_CORENUM_MSK		(_ULCAST_(0xffff) << 16)
+
+/* GCR_Cx_RESET_BASE register fields */
+#define CM_GCR_Cx_RESET_BASE_BEVEXCBASE_SHF	12
+#define CM_GCR_Cx_RESET_BASE_BEVEXCBASE_MSK	(_ULCAST_(0xfffff) << 12)
+
+/* GCR_Cx_RESET_EXT_BASE register fields */
+#define CM_GCR_Cx_RESET_EXT_BASE_EVARESET_SHF	31
+#define CM_GCR_Cx_RESET_EXT_BASE_EVARESET_MSK	(_ULCAST_(0x1) << 31)
+#define CM_GCR_Cx_RESET_EXT_BASE_UEB_SHF	30
+#define CM_GCR_Cx_RESET_EXT_BASE_UEB_MSK	(_ULCAST_(0x1) << 30)
+#define CM_GCR_Cx_RESET_EXT_BASE_BEVEXCMASK_SHF	20
+#define CM_GCR_Cx_RESET_EXT_BASE_BEVEXCMASK_MSK	(_ULCAST_(0xff) << 20)
+#define CM_GCR_Cx_RESET_EXT_BASE_BEVEXCPA_SHF	1
+#define CM_GCR_Cx_RESET_EXT_BASE_BEVEXCPA_MSK	(_ULCAST_(0x7f) << 1)
+#define CM_GCR_Cx_RESET_EXT_BASE_PRESENT_SHF	0
+#define CM_GCR_Cx_RESET_EXT_BASE_PRESENT_MSK	(_ULCAST_(0x1) << 0)
+
+/**
+ * mips_cm_numcores - return the number of cores present in the system
+ *
+ * Returns the value of the PCORES field of the GCR_CONFIG register plus 1, or
+ * zero if no Coherence Manager is present.
+ */
+static inline unsigned mips_cm_numcores(void)
+{
+	if (!mips_cm_present())
+		return 0;
+
+	return ((read_gcr_config() & CM_GCR_CONFIG_PCORES_MSK)
+		>> CM_GCR_CONFIG_PCORES_SHF) + 1;
+}
+
+/**
+ * mips_cm_numiocu - return the number of IOCUs present in the system
+ *
+ * Returns the value of the NUMIOCU field of the GCR_CONFIG register, or zero
+ * if no Coherence Manager is present.
+ */
+static inline unsigned mips_cm_numiocu(void)
+{
+	if (!mips_cm_present())
+		return 0;
+
+	return (read_gcr_config() & CM_GCR_CONFIG_NUMIOCU_MSK)
+		>> CM_GCR_CONFIG_NUMIOCU_SHF;
+}
+
+/**
+ * mips_cm_l2sync - perform an L2-only sync operation
+ *
+ * If an L2-only sync region is present in the system then this function
+ * performs and L2-only sync and returns zero. Otherwise it returns -ENODEV.
+ */
+static inline int mips_cm_l2sync(void)
+{
+	if (!mips_cm_has_l2sync())
+		return -ENODEV;
+
+	writel(0, mips_cm_l2sync_base);
+	return 0;
+}
+
+#endif /* __MIPS_ASM_MIPS_CM_H__ */
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 786a51d..be56cd8 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -103,6 +103,8 @@ obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event_mipsxx.o
 
 obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
 
+obj-$(CONFIG_MIPS_CM)		+= mips-cm.o
+
 #
 # DSP ASE supported for MIPS32 or MIPS64 Release 2 cores only. It is not
 # safe to unconditionnaly use the assembler -mdsp / -mdspr2 switches
diff --git a/arch/mips/kernel/mips-cm.c b/arch/mips/kernel/mips-cm.c
new file mode 100644
index 0000000..f76f7a0
--- /dev/null
+++ b/arch/mips/kernel/mips-cm.c
@@ -0,0 +1,121 @@
+/*
+ * Copyright (C) 2013 Imagination Technologies
+ * Author: Paul Burton <paul.burton@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/errno.h>
+
+#include <asm/mips-cm.h>
+#include <asm/mipsregs.h>
+
+void __iomem *mips_cm_base;
+void __iomem *mips_cm_l2sync_base;
+
+phys_t __mips_cm_phys_base(void)
+{
+	u32 config3 = read_c0_config3();
+	u32 cmgcr;
+
+	/* Check the CMGCRBase register is implemented */
+	if (!(config3 & MIPS_CONF3_CMGCR))
+		return 0;
+
+	/* Read the address from CMGCRBase */
+	cmgcr = read_c0_cmgcrbase();
+	return (cmgcr & MIPS_CMGCRF_BASE) << (36 - 32);
+}
+
+phys_t mips_cm_phys_base(void)
+	__attribute__((weak, alias("__mips_cm_phys_base")));
+
+phys_t __mips_cm_l2sync_phys_base(void)
+{
+	u32 base_reg;
+
+	/*
+	 * If the L2-only sync region is already enabled then leave it at it's
+	 * current location.
+	 */
+	base_reg = read_gcr_l2_only_sync_base();
+	if (base_reg & CM_GCR_L2_ONLY_SYNC_BASE_SYNCEN_MSK)
+		return base_reg & CM_GCR_L2_ONLY_SYNC_BASE_SYNCBASE_MSK;
+
+	/* Default to following the CM */
+	return mips_cm_phys_base() + MIPS_CM_GCR_SIZE;
+}
+
+phys_t mips_cm_l2sync_phys_base(void)
+	__attribute__((weak, alias("__mips_cm_l2sync_phys_base")));
+
+static void mips_cm_probe_l2sync(void)
+{
+	unsigned major_rev;
+	phys_t addr;
+
+	/* L2-only sync was introduced with CM major revision 6 */
+	major_rev = (read_gcr_rev() & CM_GCR_REV_MAJOR_MSK) >>
+		CM_GCR_REV_MAJOR_SHF;
+	if (major_rev < 6)
+		return;
+
+	/* Find a location for the L2 sync region */
+	addr = mips_cm_l2sync_phys_base();
+	BUG_ON((addr & CM_GCR_L2_ONLY_SYNC_BASE_SYNCBASE_MSK) != addr);
+	if (!addr)
+		return;
+
+	/* Set the region base address & enable it */
+	write_gcr_l2_only_sync_base(addr | CM_GCR_L2_ONLY_SYNC_BASE_SYNCEN_MSK);
+
+	/* Map the region */
+	mips_cm_l2sync_base = ioremap_nocache(addr, MIPS_CM_L2SYNC_SIZE);
+}
+
+int mips_cm_probe(void)
+{
+	phys_t addr;
+	u32 base_reg;
+
+	addr = mips_cm_phys_base();
+	BUG_ON((addr & CM_GCR_BASE_GCRBASE_MSK) != addr);
+	if (!addr)
+		return -ENODEV;
+
+	mips_cm_base = ioremap_nocache(addr, MIPS_CM_GCR_SIZE);
+	if (!mips_cm_base)
+		return -ENXIO;
+
+	/* sanity check that we're looking at a CM */
+	base_reg = read_gcr_base();
+	if ((base_reg & CM_GCR_BASE_GCRBASE_MSK) != addr) {
+		pr_err("GCRs appear to have been moved (expected them at 0x%08lx)!\n",
+		       (unsigned long)addr);
+		mips_cm_base = NULL;
+		return -ENODEV;
+	}
+
+	/* set default target to memory */
+	base_reg &= ~CM_GCR_BASE_CMDEFTGT_MSK;
+	base_reg |= CM_GCR_BASE_CMDEFTGT_MEM;
+	write_gcr_base(base_reg);
+
+	/* disable CM regions */
+	write_gcr_reg0_base(CM_GCR_REGn_BASE_BASEADDR_MSK);
+	write_gcr_reg0_mask(CM_GCR_REGn_MASK_ADDRMASK_MSK);
+	write_gcr_reg1_base(CM_GCR_REGn_BASE_BASEADDR_MSK);
+	write_gcr_reg1_mask(CM_GCR_REGn_MASK_ADDRMASK_MSK);
+	write_gcr_reg2_base(CM_GCR_REGn_BASE_BASEADDR_MSK);
+	write_gcr_reg2_mask(CM_GCR_REGn_MASK_ADDRMASK_MSK);
+	write_gcr_reg3_base(CM_GCR_REGn_BASE_BASEADDR_MSK);
+	write_gcr_reg3_mask(CM_GCR_REGn_MASK_ADDRMASK_MSK);
+
+	/* probe for an L2-only sync region */
+	mips_cm_probe_l2sync();
+
+	return 0;
+}
-- 
1.8.4.2
