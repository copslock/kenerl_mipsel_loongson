Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Aug 2017 04:51:06 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:9242 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991978AbdHMCup4iNO6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Aug 2017 04:50:45 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 41FFB7A250B3D;
        Sun, 13 Aug 2017 03:50:37 +0100 (IST)
Received: from localhost (10.20.79.142) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sun, 13 Aug
 2017 03:50:38 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 02/19] MIPS: CM: Specify register size when generating accessors
Date:   Sat, 12 Aug 2017 19:49:26 -0700
Message-ID: <20170813024943.14989-3-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.14.0
In-Reply-To: <20170813024943.14989-1-paul.burton@imgtec.com>
References: <20170813024943.14989-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.79.142]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59498
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

Some CM registers are always 32 bits, or at least only use bits in the
lower 32 bits of the register. For these registers it is wasteful for us
to generate accessors which bother to check mips_cm_is64 & perform 64
bit accesses.

This patch modifies the accessor generation to take into account the
size of the register, and for 32 bit registers we generate accessors
which only ever perform 32 bit accesses. For 64 bit registers we either
perform a 64 bit access or two 32 bit accesses, depending upon the value
of mips_cm_is64. Doing this saves us ~1.5KiB of code in a generic 64r6el
kernel, and perhaps more importantly simplifies various code paths.

This removes the read64_gcr_* accessors, so mips_cm_error_report() is
modified to stop using them & instead use the regular read_gcr_*
accessors which will return 64 bit values from the 64 bit registers.

The new accessor macros are placed in asm/mips-cps.h such that they can
be shared by CPC & GIC code in later patches.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/include/asm/mips-cm.h  | 154 ++++++++++++---------------------------
 arch/mips/include/asm/mips-cps.h |  87 ++++++++++++++++++++++
 arch/mips/kernel/mips-cm.c       |   9 +--
 3 files changed, 135 insertions(+), 115 deletions(-)
 create mode 100644 arch/mips/include/asm/mips-cps.h

diff --git a/arch/mips/include/asm/mips-cm.h b/arch/mips/include/asm/mips-cm.h
index a13d721669e6..b01fcf4647d2 100644
--- a/arch/mips/include/asm/mips-cm.h
+++ b/arch/mips/include/asm/mips-cm.h
@@ -15,6 +15,7 @@
 #include <linux/errno.h>
 #include <linux/io.h>
 #include <linux/types.h>
+#include <asm/mips-cps.h>
 
 /* The base address of the CM GCR block */
 extern void __iomem *mips_gcr_base;
@@ -112,122 +113,57 @@ static inline bool mips_cm_has_l2sync(void)
 /* Size of the L2-only sync region */
 #define MIPS_CM_L2SYNC_SIZE	0x1000
 
-/* Macros to ease the creation of register access functions */
-#define BUILD_CM_R_(name, off)					\
-static inline unsigned long __iomem *addr_gcr_##name(void)	\
-{								\
-	return (unsigned long __iomem *)(mips_gcr_base + (off));\
-}								\
-								\
-static inline u32 read32_gcr_##name(void)			\
-{								\
-	return __raw_readl(addr_gcr_##name());			\
-}								\
-								\
-static inline u64 read64_gcr_##name(void)			\
-{								\
-	void __iomem *addr = addr_gcr_##name();			\
-	u64 ret;						\
-								\
-	if (mips_cm_is64) {					\
-		ret = __raw_readq(addr);			\
-	} else {						\
-		ret = __raw_readl(addr);			\
-		ret |= (u64)__raw_readl(addr + 0x4) << 32;	\
-	}							\
-								\
-	return ret;						\
-}								\
-								\
-static inline unsigned long read_gcr_##name(void)		\
-{								\
-	if (mips_cm_is64)					\
-		return read64_gcr_##name();			\
-	else							\
-		return read32_gcr_##name();			\
-}
-
-#define BUILD_CM__W(name, off)					\
-static inline void write32_gcr_##name(u32 value)		\
-{								\
-	__raw_writel(value, addr_gcr_##name());			\
-}								\
-								\
-static inline void write64_gcr_##name(u64 value)		\
-{								\
-	__raw_writeq(value, addr_gcr_##name());			\
-}								\
-								\
-static inline void write_gcr_##name(unsigned long value)	\
-{								\
-	if (mips_cm_is64)					\
-		write64_gcr_##name(value);			\
-	else							\
-		write32_gcr_##name(value);			\
-}
-
-#define BUILD_CM_RW(name, off)					\
-	BUILD_CM_R_(name, off)					\
-	BUILD_CM__W(name, off)
+#define GCR_ACCESSOR_RO(sz, off, name)					\
+	CPS_ACCESSOR_RO(gcr, sz, MIPS_CM_GCB_OFS + off, name)
 
-#define BUILD_CM_Cx_R_(name, off)				\
-	BUILD_CM_R_(cl_##name, MIPS_CM_CLCB_OFS + (off))	\
-	BUILD_CM_R_(co_##name, MIPS_CM_COCB_OFS + (off))
+#define GCR_ACCESSOR_RW(sz, off, name)					\
+	CPS_ACCESSOR_RW(gcr, sz, MIPS_CM_GCB_OFS + off, name)
 
-#define BUILD_CM_Cx__W(name, off)				\
-	BUILD_CM__W(cl_##name, MIPS_CM_CLCB_OFS + (off))	\
-	BUILD_CM__W(co_##name, MIPS_CM_COCB_OFS + (off))
+#define GCR_CX_ACCESSOR_RO(sz, off, name)				\
+	CPS_ACCESSOR_RO(gcr, sz, MIPS_CM_CLCB_OFS + off, cl_##name)	\
+	CPS_ACCESSOR_RO(gcr, sz, MIPS_CM_COCB_OFS + off, co_##name)
 
-#define BUILD_CM_Cx_RW(name, off)				\
-	BUILD_CM_Cx_R_(name, off)				\
-	BUILD_CM_Cx__W(name, off)
+#define GCR_CX_ACCESSOR_RW(sz, off, name)				\
+	CPS_ACCESSOR_RW(gcr, sz, MIPS_CM_CLCB_OFS + off, cl_##name)	\
+	CPS_ACCESSOR_RW(gcr, sz, MIPS_CM_COCB_OFS + off, co_##name)
 
 /* GCB register accessor functions */
-BUILD_CM_R_(config,		MIPS_CM_GCB_OFS + 0x00)
-BUILD_CM_RW(base,		MIPS_CM_GCB_OFS + 0x08)
-BUILD_CM_RW(access,		MIPS_CM_GCB_OFS + 0x20)
-BUILD_CM_R_(rev,		MIPS_CM_GCB_OFS + 0x30)
-BUILD_CM_RW(err_control,	MIPS_CM_GCB_OFS + 0x38)
-BUILD_CM_RW(error_mask,		MIPS_CM_GCB_OFS + 0x40)
-BUILD_CM_RW(error_cause,	MIPS_CM_GCB_OFS + 0x48)
-BUILD_CM_RW(error_addr,		MIPS_CM_GCB_OFS + 0x50)
-BUILD_CM_RW(error_mult,		MIPS_CM_GCB_OFS + 0x58)
-BUILD_CM_RW(l2_only_sync_base,	MIPS_CM_GCB_OFS + 0x70)
-BUILD_CM_RW(gic_base,		MIPS_CM_GCB_OFS + 0x80)
-BUILD_CM_RW(cpc_base,		MIPS_CM_GCB_OFS + 0x88)
-BUILD_CM_RW(reg0_base,		MIPS_CM_GCB_OFS + 0x90)
-BUILD_CM_RW(reg0_mask,		MIPS_CM_GCB_OFS + 0x98)
-BUILD_CM_RW(reg1_base,		MIPS_CM_GCB_OFS + 0xa0)
-BUILD_CM_RW(reg1_mask,		MIPS_CM_GCB_OFS + 0xa8)
-BUILD_CM_RW(reg2_base,		MIPS_CM_GCB_OFS + 0xb0)
-BUILD_CM_RW(reg2_mask,		MIPS_CM_GCB_OFS + 0xb8)
-BUILD_CM_RW(reg3_base,		MIPS_CM_GCB_OFS + 0xc0)
-BUILD_CM_RW(reg3_mask,		MIPS_CM_GCB_OFS + 0xc8)
-BUILD_CM_R_(gic_status,		MIPS_CM_GCB_OFS + 0xd0)
-BUILD_CM_R_(cpc_status,		MIPS_CM_GCB_OFS + 0xf0)
-BUILD_CM_RW(l2_config,		MIPS_CM_GCB_OFS + 0x130)
-BUILD_CM_RW(sys_config2,	MIPS_CM_GCB_OFS + 0x150)
-BUILD_CM_RW(l2_pft_control,	MIPS_CM_GCB_OFS + 0x300)
-BUILD_CM_RW(l2_pft_control_b,	MIPS_CM_GCB_OFS + 0x308)
-BUILD_CM_RW(bev_base,		MIPS_CM_GCB_OFS + 0x680)
+GCR_ACCESSOR_RO(64, 0x000, config)
+GCR_ACCESSOR_RW(64, 0x008, base)
+GCR_ACCESSOR_RW(32, 0x020, access)
+GCR_ACCESSOR_RO(32, 0x030, rev)
+GCR_ACCESSOR_RW(32, 0x038, err_control)
+GCR_ACCESSOR_RW(64, 0x040, error_mask)
+GCR_ACCESSOR_RW(64, 0x048, error_cause)
+GCR_ACCESSOR_RW(64, 0x050, error_addr)
+GCR_ACCESSOR_RW(64, 0x058, error_mult)
+GCR_ACCESSOR_RW(64, 0x070, l2_only_sync_base)
+GCR_ACCESSOR_RW(64, 0x080, gic_base)
+GCR_ACCESSOR_RW(64, 0x088, cpc_base)
+GCR_ACCESSOR_RW(64, 0x090, reg0_base)
+GCR_ACCESSOR_RW(64, 0x098, reg0_mask)
+GCR_ACCESSOR_RW(64, 0x0a0, reg1_base)
+GCR_ACCESSOR_RW(64, 0x0a8, reg1_mask)
+GCR_ACCESSOR_RW(64, 0x0b0, reg2_base)
+GCR_ACCESSOR_RW(64, 0x0b8, reg2_mask)
+GCR_ACCESSOR_RW(64, 0x0c0, reg3_base)
+GCR_ACCESSOR_RW(64, 0x0c8, reg3_mask)
+GCR_ACCESSOR_RO(32, 0x0d0, gic_status)
+GCR_ACCESSOR_RO(32, 0x0f0, cpc_status)
+GCR_ACCESSOR_RW(32, 0x130, l2_config)
+GCR_ACCESSOR_RO(32, 0x150, sys_config2)
+GCR_ACCESSOR_RW(32, 0x300, l2_pft_control)
+GCR_ACCESSOR_RW(32, 0x308, l2_pft_control_b)
+GCR_ACCESSOR_RW(64, 0x680, bev_base)
 
 /* Core Local & Core Other register accessor functions */
-BUILD_CM_Cx_RW(reset_release,	0x00)
-BUILD_CM_Cx_RW(coherence,	0x08)
-BUILD_CM_Cx_R_(config,		0x10)
-BUILD_CM_Cx_RW(other,		0x18)
-BUILD_CM_Cx_RW(reset_base,	0x20)
-BUILD_CM_Cx_R_(id,		0x28)
-BUILD_CM_Cx_RW(reset_ext_base,	0x30)
-BUILD_CM_Cx_R_(tcid_0_priority,	0x40)
-BUILD_CM_Cx_R_(tcid_1_priority,	0x48)
-BUILD_CM_Cx_R_(tcid_2_priority,	0x50)
-BUILD_CM_Cx_R_(tcid_3_priority,	0x58)
-BUILD_CM_Cx_R_(tcid_4_priority,	0x60)
-BUILD_CM_Cx_R_(tcid_5_priority,	0x68)
-BUILD_CM_Cx_R_(tcid_6_priority,	0x70)
-BUILD_CM_Cx_R_(tcid_7_priority,	0x78)
-BUILD_CM_Cx_R_(tcid_8_priority,	0x80)
+GCR_CX_ACCESSOR_RW(32, 0x000, reset_release)
+GCR_CX_ACCESSOR_RW(32, 0x008, coherence)
+GCR_CX_ACCESSOR_RO(32, 0x010, config)
+GCR_CX_ACCESSOR_RW(32, 0x018, other)
+GCR_CX_ACCESSOR_RW(32, 0x020, reset_base)
+GCR_CX_ACCESSOR_RO(32, 0x028, id)
+GCR_CX_ACCESSOR_RW(32, 0x030, reset_ext_base)
 
 /* GCR_CONFIG register fields */
 #define CM_GCR_CONFIG_NUMIOCU_SHF		8
diff --git a/arch/mips/include/asm/mips-cps.h b/arch/mips/include/asm/mips-cps.h
new file mode 100644
index 000000000000..6ced7ba102b6
--- /dev/null
+++ b/arch/mips/include/asm/mips-cps.h
@@ -0,0 +1,87 @@
+/*
+ * Copyright (C) 2017 Imagination Technologies
+ * Author: Paul Burton <paul.burton@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifndef __MIPS_ASM_MIPS_CPS_H__
+#define __MIPS_ASM_MIPS_CPS_H__
+
+#include <linux/io.h>
+#include <linux/types.h>
+
+extern unsigned long __cps_access_bad_size(void)
+	__compiletime_error("Bad size for CPS accessor");
+
+#define CPS_ACCESSOR_A(unit, off, name)					\
+static inline void *addr_##unit##_##name(void)				\
+{									\
+	return mips_##unit##_base + (off);				\
+}
+
+#define CPS_ACCESSOR_R(unit, sz, name)					\
+static inline uint##sz##_t read_##unit##_##name(void)			\
+{									\
+	uint64_t val64;							\
+									\
+	switch (sz) {							\
+	case 32:							\
+		return __raw_readl(addr_##unit##_##name());		\
+									\
+	case 64:							\
+		if (mips_cm_is64)					\
+			return __raw_readq(addr_##unit##_##name());	\
+									\
+		val64 = __raw_readl(addr_##unit##_##name() + 4);	\
+		val64 <<= 32;						\
+		val64 |= __raw_readl(addr_##unit##_##name());		\
+		return val64;						\
+									\
+	default:							\
+		return __cps_access_bad_size();				\
+	}								\
+}
+
+#define CPS_ACCESSOR_W(unit, sz, name)					\
+static inline void write_##unit##_##name(uint##sz##_t val)		\
+{									\
+	switch (sz) {							\
+	case 32:							\
+		__raw_writel(val, addr_##unit##_##name());		\
+		break;							\
+									\
+	case 64:							\
+		if (mips_cm_is64) {					\
+			__raw_writeq(val, addr_##unit##_##name());	\
+			break;						\
+		}							\
+									\
+		__raw_writel((uint64_t)val >> 32,			\
+			     addr_##unit##_##name() + 4);		\
+		__raw_writel(val, addr_##unit##_##name());		\
+		break;							\
+									\
+	default:							\
+		__cps_access_bad_size();				\
+		break;							\
+	}								\
+}
+
+#define CPS_ACCESSOR_RO(unit, sz, off, name)				\
+	CPS_ACCESSOR_A(unit, off, name)					\
+	CPS_ACCESSOR_R(unit, sz, name)
+
+#define CPS_ACCESSOR_WO(unit, sz, off, name)				\
+	CPS_ACCESSOR_A(unit, off, name)					\
+	CPS_ACCESSOR_W(unit, sz, name)
+
+#define CPS_ACCESSOR_RW(unit, sz, off, name)				\
+	CPS_ACCESSOR_A(unit, off, name)					\
+	CPS_ACCESSOR_R(unit, sz, name)					\
+	CPS_ACCESSOR_W(unit, sz, name)
+
+#endif /* __MIPS_ASM_MIPS_CPS_H__ */
diff --git a/arch/mips/kernel/mips-cm.c b/arch/mips/kernel/mips-cm.c
index caac4a523968..8b6b4976fb2f 100644
--- a/arch/mips/kernel/mips-cm.c
+++ b/arch/mips/kernel/mips-cm.c
@@ -332,11 +332,11 @@ void mips_cm_error_report(void)
 		return;
 
 	revision = mips_cm_revision();
+	cm_error = read_gcr_error_cause();
+	cm_addr = read_gcr_error_addr();
+	cm_other = read_gcr_error_mult();
 
 	if (revision < CM_REV_CM3) { /* CM2 */
-		cm_error = read_gcr_error_cause();
-		cm_addr = read_gcr_error_addr();
-		cm_other = read_gcr_error_mult();
 		cause = cm_error >> CM_GCR_ERROR_CAUSE_ERRTYPE_SHF;
 		ocause = cm_other >> CM_GCR_ERROR_MULT_ERR2ND_SHF;
 
@@ -380,9 +380,6 @@ void mips_cm_error_report(void)
 		ulong core_id_bits, vp_id_bits, cmd_bits, cmd_group_bits;
 		ulong cm3_cca_bits, mcp_bits, cm3_tr_bits, sched_bit;
 
-		cm_error = read64_gcr_error_cause();
-		cm_addr = read64_gcr_error_addr();
-		cm_other = read64_gcr_error_mult();
 		cause = cm_error >> CM3_GCR_ERROR_CAUSE_ERRTYPE_SHF;
 		ocause = cm_other >> CM_GCR_ERROR_MULT_ERR2ND_SHF;
 
-- 
2.14.0
