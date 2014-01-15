Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jan 2014 11:35:07 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:10838 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827441AbaAOKehYq0if (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Jan 2014 11:34:37 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 07/15] MIPS: add CPC probe, access functions
Date:   Wed, 15 Jan 2014 10:31:52 +0000
Message-ID: <1389781920-31151-8-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1389781920-31151-1-git-send-email-paul.burton@imgtec.com>
References: <1389781920-31151-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.152.22]
X-SEF-Processed: 7_3_0_01192__2014_01_15_10_34_32
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38991
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

This patch introduces code to probe for a MIPS Cluster Power Controller
& accessor functions to allow for easy register access. This support
code will be used by a subsequent patch.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/Kconfig                |   3 +
 arch/mips/include/asm/mips-cpc.h | 150 +++++++++++++++++++++++++++++++++++++++
 arch/mips/kernel/Makefile        |   1 +
 arch/mips/kernel/mips-cpc.c      |  52 ++++++++++++++
 4 files changed, 206 insertions(+)
 create mode 100644 arch/mips/include/asm/mips-cpc.h
 create mode 100644 arch/mips/kernel/mips-cpc.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 616e040..8110934 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1990,6 +1990,9 @@ config MIPS_GIC_IPI
 config MIPS_CM
 	bool
 
+config MIPS_CPC
+	bool
+
 config SB1_PASS_1_WORKAROUNDS
 	bool
 	depends on CPU_SB1_PASS_1
diff --git a/arch/mips/include/asm/mips-cpc.h b/arch/mips/include/asm/mips-cpc.h
new file mode 100644
index 0000000..fb78935
--- /dev/null
+++ b/arch/mips/include/asm/mips-cpc.h
@@ -0,0 +1,150 @@
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
+#ifndef __MIPS_ASM_MIPS_CPC_H__
+#define __MIPS_ASM_MIPS_CPC_H__
+
+#include <linux/io.h>
+#include <linux/types.h>
+
+/* The base address of the CPC registers */
+extern void __iomem *mips_cpc_base;
+
+/**
+ * mips_cpc_default_phys_base - retrieve the default physical base address of
+ *                              the CPC
+ *
+ * Returns the default physical base address of the Cluster Power Controller
+ * memory mapped registers. This is platform dependant & must therefore be
+ * implemented per-platform.
+ */
+extern phys_t mips_cpc_default_phys_base(void);
+
+/**
+ * mips_cpc_phys_base - retrieve the physical base address of the CPC
+ *
+ * This function returns the physical base address of the Cluster Power
+ * Controller memory mapped registers, or 0 if no Cluster Power Controller
+ * is present. It may be overriden by individual platforms which determine
+ * this address in a different way.
+ */
+extern phys_t __weak mips_cpc_phys_base(void);
+
+/**
+ * mips_cpc_probe - probe for a Cluster Power Controller
+ *
+ * Attempt to detect the presence of a Cluster Power Controller. Returns 0 if
+ * a CPC is successfully detected, else -errno.
+ */
+#ifdef CONFIG_MIPS_CPC
+extern int mips_cpc_probe(void);
+#else
+static inline int mips_cpc_probe(void)
+{
+	return -ENODEV;
+}
+#endif
+
+/**
+ * mips_cpc_present - determine whether a Cluster Power Controller is present
+ *
+ * Returns true if a CPC is present in the system, else false.
+ */
+static inline bool mips_cpc_present(void)
+{
+#ifdef CONFIG_MIPS_CPC
+	return mips_cpc_base != NULL;
+#else
+	return false;
+#endif
+}
+
+/* Offsets from the CPC base address to various control blocks */
+#define MIPS_CPC_GCB_OFS	0x0000
+#define MIPS_CPC_CLCB_OFS	0x2000
+#define MIPS_CPC_COCB_OFS	0x4000
+
+/* Macros to ease the creation of register access functions */
+#define BUILD_CPC_R_(name, off) \
+static inline u32 read_cpc_##name(void)				\
+{								\
+	return readl(mips_cpc_base + (off));			\
+}
+
+#define BUILD_CPC__W(name, off) \
+static inline void write_cpc_##name(u32 value)			\
+{								\
+	writel(value, mips_cpc_base + (off));			\
+}
+
+#define BUILD_CPC_RW(name, off)					\
+	BUILD_CPC_R_(name, off)					\
+	BUILD_CPC__W(name, off)
+
+#define BUILD_CPC_Cx_R_(name, off)				\
+	BUILD_CPC_R_(cl_##name, MIPS_CPC_CLCB_OFS + (off))	\
+	BUILD_CPC_R_(co_##name, MIPS_CPC_COCB_OFS + (off))
+
+#define BUILD_CPC_Cx__W(name, off)				\
+	BUILD_CPC__W(cl_##name, MIPS_CPC_CLCB_OFS + (off))	\
+	BUILD_CPC__W(co_##name, MIPS_CPC_COCB_OFS + (off))
+
+#define BUILD_CPC_Cx_RW(name, off)				\
+	BUILD_CPC_Cx_R_(name, off)				\
+	BUILD_CPC_Cx__W(name, off)
+
+/* GCB register accessor functions */
+BUILD_CPC_RW(access,		MIPS_CPC_GCB_OFS + 0x00)
+BUILD_CPC_RW(seqdel,		MIPS_CPC_GCB_OFS + 0x08)
+BUILD_CPC_RW(rail,		MIPS_CPC_GCB_OFS + 0x10)
+BUILD_CPC_RW(resetlen,		MIPS_CPC_GCB_OFS + 0x18)
+BUILD_CPC_R_(revision,		MIPS_CPC_GCB_OFS + 0x20)
+
+/* Core Local & Core Other accessor functions */
+BUILD_CPC_Cx_RW(cmd,		0x00)
+BUILD_CPC_Cx_RW(stat_conf,	0x08)
+BUILD_CPC_Cx_RW(other,		0x10)
+
+/* CPC_Cx_CMD register fields */
+#define CPC_Cx_CMD_SHF				0
+#define CPC_Cx_CMD_MSK				(_ULCAST_(0xf) << 0)
+#define  CPC_Cx_CMD_CLOCKOFF			(_ULCAST_(0x1) << 0)
+#define  CPC_Cx_CMD_PWRDOWN			(_ULCAST_(0x2) << 0)
+#define  CPC_Cx_CMD_PWRUP			(_ULCAST_(0x3) << 0)
+#define  CPC_Cx_CMD_RESET			(_ULCAST_(0x4) << 0)
+
+/* CPC_Cx_STAT_CONF register fields */
+#define CPC_Cx_STAT_CONF_PWRUPE_SHF		23
+#define CPC_Cx_STAT_CONF_PWRUPE_MSK		(_ULCAST_(0x1) << 23)
+#define CPC_Cx_STAT_CONF_SEQSTATE_SHF		19
+#define CPC_Cx_STAT_CONF_SEQSTATE_MSK		(_ULCAST_(0xf) << 19)
+#define  CPC_Cx_STAT_CONF_SEQSTATE_D0		(_ULCAST_(0x0) << 19)
+#define  CPC_Cx_STAT_CONF_SEQSTATE_U0		(_ULCAST_(0x1) << 19)
+#define  CPC_Cx_STAT_CONF_SEQSTATE_U1		(_ULCAST_(0x2) << 19)
+#define  CPC_Cx_STAT_CONF_SEQSTATE_U2		(_ULCAST_(0x3) << 19)
+#define  CPC_Cx_STAT_CONF_SEQSTATE_U3		(_ULCAST_(0x4) << 19)
+#define  CPC_Cx_STAT_CONF_SEQSTATE_U4		(_ULCAST_(0x5) << 19)
+#define  CPC_Cx_STAT_CONF_SEQSTATE_U5		(_ULCAST_(0x6) << 19)
+#define  CPC_Cx_STAT_CONF_SEQSTATE_U6		(_ULCAST_(0x7) << 19)
+#define  CPC_Cx_STAT_CONF_SEQSTATE_D1		(_ULCAST_(0x8) << 19)
+#define  CPC_Cx_STAT_CONF_SEQSTATE_D3		(_ULCAST_(0x9) << 19)
+#define  CPC_Cx_STAT_CONF_SEQSTATE_D2		(_ULCAST_(0xa) << 19)
+#define CPC_Cx_STAT_CONF_CLKGAT_IMPL_SHF	17
+#define CPC_Cx_STAT_CONF_CLKGAT_IMPL_MSK	(_ULCAST_(0x1) << 17)
+#define CPC_Cx_STAT_CONF_PWRDN_IMPL_SHF		16
+#define CPC_Cx_STAT_CONF_PWRDN_IMPL_MSK		(_ULCAST_(0x1) << 16)
+#define CPC_Cx_STAT_CONF_EJTAG_PROBE_SHF	15
+#define CPC_Cx_STAT_CONF_EJTAG_PROBE_MSK	(_ULCAST_(0x1) << 15)
+
+/* CPC_Cx_OTHER register fields */
+#define CPC_Cx_OTHER_CORENUM_SHF		16
+#define CPC_Cx_OTHER_CORENUM_MSK		(_ULCAST_(0xff) << 16)
+
+#endif /* __MIPS_ASM_MIPS_CPC_H__ */
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index be56cd8..a6a8717 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -104,6 +104,7 @@ obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event_mipsxx.o
 obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
 
 obj-$(CONFIG_MIPS_CM)		+= mips-cm.o
+obj-$(CONFIG_MIPS_CPC)		+= mips-cpc.o
 
 #
 # DSP ASE supported for MIPS32 or MIPS64 Release 2 cores only. It is not
diff --git a/arch/mips/kernel/mips-cpc.c b/arch/mips/kernel/mips-cpc.c
new file mode 100644
index 0000000..c9dc674
--- /dev/null
+++ b/arch/mips/kernel/mips-cpc.c
@@ -0,0 +1,52 @@
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
+#include <asm/mips-cpc.h>
+
+void __iomem *mips_cpc_base;
+
+phys_t __weak mips_cpc_phys_base(void)
+{
+	u32 cpc_base;
+
+	if (!mips_cm_present())
+		return 0;
+
+	if (!(read_gcr_cpc_status() & CM_GCR_CPC_STATUS_EX_MSK))
+		return 0;
+
+	/* If the CPC is already enabled, leave it so */
+	cpc_base = read_gcr_cpc_base();
+	if (cpc_base & CM_GCR_CPC_BASE_CPCEN_MSK)
+		return cpc_base & CM_GCR_CPC_BASE_CPCBASE_MSK;
+
+	/* Otherwise, give it the default address & enable it */
+	cpc_base = mips_cpc_default_phys_base();
+	write_gcr_cpc_base(cpc_base | CM_GCR_CPC_BASE_CPCEN_MSK);
+	return cpc_base;
+}
+
+int mips_cpc_probe(void)
+{
+	phys_t addr;
+
+	addr = mips_cpc_phys_base();
+	if (!addr)
+		return -ENODEV;
+
+	mips_cpc_base = ioremap_nocache(addr, 0x8000);
+	if (!mips_cpc_base)
+		return -ENXIO;
+
+	return 0;
+}
-- 
1.8.4.2
