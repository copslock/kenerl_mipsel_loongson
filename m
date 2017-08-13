Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Aug 2017 06:38:20 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:24112 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992054AbdHMEiE369hd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Aug 2017 06:38:04 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 04A828BA0226;
        Sun, 13 Aug 2017 05:37:55 +0100 (IST)
Received: from localhost (10.20.79.142) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sun, 13 Aug
 2017 05:37:56 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 02/38] MIPS: GIC: Introduce asm/mips-gic.h with accessor functions
Date:   Sat, 12 Aug 2017 21:36:10 -0700
Message-ID: <20170813043646.25821-3-paul.burton@imgtec.com>
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
X-archive-position: 59518
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

This patch introduces a new header providing accessor functions for the
MIPS Global Interrupt Controller (GIC) mirroring those provided for the
other 2 components of the MIPS Coherent Processing System (CPS) - the
Coherence Manager (CM) & Cluster Power Controller (CPC).

This header makes use of the new standardised CPS accessor macros where
possible, but does require some custom accessors for cases where we have
either a bit or a register per interrupt.

A major advantage of this over the existing
include/linux/irqchip/mips-gic.h definitions is that code performing
accesses can become much simpler, for example this:

  gic_update_bits(GIC_REG(SHARED, GIC_SH_SET_TRIGGER) +
                  GIC_INTR_OFS(intr), 1ul << GIC_INTR_BIT(intr),
                  (unsigned long)trig << GIC_INTR_BIT(intr));

...can become simply:

  change_gic_trig(intr, trig);

The accessors handle 32 vs 64 bit in the same way as for CM & CPC code,
which means that GIC code will also not need to worry about the access
size in most cases. They are also accessible outside of
drivers/irqchip/irq-mips-gic.c which will allow for simplification in
the use of the non-interrupt portions of the GIC (eg. counters) which
currently require the interrupt controller driver to expose helper
functions for access.

This patch doesn't change any existing code over to use the new
accessors yet, since a wholesale change would be invasive & difficult to
review. Instead follow-on patches will convert code piecemeal to use
this new header. The one change to existing code is to rename gic_base
to mips_gic_base & make it global, in order to fit in with the naming
expected by the standardised CPS accessor macros.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org
---

 arch/mips/include/asm/mips-cps.h |   1 +
 arch/mips/include/asm/mips-gic.h | 293 +++++++++++++++++++++++++++++++++++++++
 drivers/irqchip/irq-mips-gic.c   |  13 +-
 3 files changed, 300 insertions(+), 7 deletions(-)
 create mode 100644 arch/mips/include/asm/mips-gic.h

diff --git a/arch/mips/include/asm/mips-cps.h b/arch/mips/include/asm/mips-cps.h
index 2dd737d803e1..bf02b5070a98 100644
--- a/arch/mips/include/asm/mips-cps.h
+++ b/arch/mips/include/asm/mips-cps.h
@@ -107,6 +107,7 @@ static inline void clear_##unit##_##name(uint##sz##_t val)		\
 
 #include <asm/mips-cm.h>
 #include <asm/mips-cpc.h>
+#include <asm/mips-gic.h>
 
 /**
  * mips_cps_numclusters - return the number of clusters present in the system
diff --git a/arch/mips/include/asm/mips-gic.h b/arch/mips/include/asm/mips-gic.h
new file mode 100644
index 000000000000..8cf4bdc1a059
--- /dev/null
+++ b/arch/mips/include/asm/mips-gic.h
@@ -0,0 +1,293 @@
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
+# error Please include asm/mips-cps.h rather than asm/mips-gic.h
+#endif
+
+#ifndef __MIPS_ASM_MIPS_GIC_H__
+#define __MIPS_ASM_MIPS_GIC_H__
+
+#include <linux/bitops.h>
+
+/* The base address of the GIC registers */
+extern void __iomem *mips_gic_base;
+
+/* Offsets from the GIC base address to various control blocks */
+#define MIPS_GIC_SHARED_OFS	0x00000
+#define MIPS_GIC_SHARED_SZ	0x08000
+#define MIPS_GIC_LOCAL_OFS	0x08000
+#define MIPS_GIC_LOCAL_SZ	0x04000
+#define MIPS_GIC_REDIR_OFS	0x0c000
+#define MIPS_GIC_REDIR_SZ	0x04000
+#define MIPS_GIC_USER_OFS	0x10000
+#define MIPS_GIC_USER_SZ	0x10000
+
+/* For read-only shared registers */
+#define GIC_ACCESSOR_RO(sz, off, name)					\
+	CPS_ACCESSOR_RO(gic, sz, MIPS_GIC_SHARED_OFS + off, name)
+
+/* For read-write shared registers */
+#define GIC_ACCESSOR_RW(sz, off, name)					\
+	CPS_ACCESSOR_RW(gic, sz, MIPS_GIC_SHARED_OFS + off, name)
+
+/* For read-only local registers */
+#define GIC_VX_ACCESSOR_RO(sz, off, name)				\
+	CPS_ACCESSOR_RO(gic, sz, MIPS_GIC_LOCAL_OFS + off, vl_##name)	\
+	CPS_ACCESSOR_RO(gic, sz, MIPS_GIC_REDIR_OFS + off, vo_##name)
+
+/* For read-write local registers */
+#define GIC_VX_ACCESSOR_RW(sz, off, name)				\
+	CPS_ACCESSOR_RW(gic, sz, MIPS_GIC_LOCAL_OFS + off, vl_##name)	\
+	CPS_ACCESSOR_RW(gic, sz, MIPS_GIC_REDIR_OFS + off, vo_##name)
+
+/* For read-only shared per-interrupt registers */
+#define GIC_ACCESSOR_RO_INTR_REG(sz, off, stride, name)			\
+static inline void __iomem *addr_gic_##name(unsigned int intr)		\
+{									\
+	return mips_gic_base + (off) + (intr * (stride));		\
+}									\
+									\
+static inline unsigned int read_gic_##name(unsigned int intr)		\
+{									\
+	BUILD_BUG_ON(sz != 32);						\
+	return __raw_readl(addr_gic_##name(intr));			\
+}
+
+/* For read-write shared per-interrupt registers */
+#define GIC_ACCESSOR_RW_INTR_REG(sz, off, stride, name)			\
+	GIC_ACCESSOR_RO_INTR_REG(sz, off, stride, name)			\
+									\
+static inline void write_gic_##name(unsigned int intr,			\
+				    unsigned int val)			\
+{									\
+	BUILD_BUG_ON(sz != 32);						\
+	__raw_writel(val, addr_gic_##name(intr));			\
+}
+
+/* For read-only local per-interrupt registers */
+#define GIC_VX_ACCESSOR_RO_INTR_REG(sz, off, stride, name)		\
+	GIC_ACCESSOR_RO_INTR_REG(sz, MIPS_GIC_LOCAL_OFS + off,		\
+				 stride, vl_##name)			\
+	GIC_ACCESSOR_RO_INTR_REG(sz, MIPS_GIC_REDIR_OFS + off,		\
+				 stride, vo_##name)
+
+/* For read-write local per-interrupt registers */
+#define GIC_VX_ACCESSOR_RW_INTR_REG(sz, off, stride, name)		\
+	GIC_ACCESSOR_RW_INTR_REG(sz, MIPS_GIC_LOCAL_OFS + off,		\
+				 stride, vl_##name)			\
+	GIC_ACCESSOR_RW_INTR_REG(sz, MIPS_GIC_REDIR_OFS + off,		\
+				 stride, vo_##name)
+
+/* For read-only shared bit-per-interrupt registers */
+#define GIC_ACCESSOR_RO_INTR_BIT(off, name)				\
+static inline void __iomem *addr_gic_##name(void)			\
+{									\
+	return mips_gic_base + (off);					\
+}									\
+									\
+static inline unsigned int read_gic_##name(unsigned int intr)		\
+{									\
+	void __iomem *addr = addr_gic_##name();				\
+	unsigned int val;						\
+									\
+	if (mips_cm_is64) {						\
+		addr += (intr / 64) * sizeof(uint64_t);			\
+		val = __raw_readq(addr) >> intr % 64;			\
+	} else {							\
+		addr += (intr / 32) * sizeof(uint32_t);			\
+		val = __raw_readl(addr) >> intr % 32;			\
+	}								\
+									\
+	return val & 0x1;						\
+}
+
+/* For read-write shared bit-per-interrupt registers */
+#define GIC_ACCESSOR_RW_INTR_BIT(off, name)				\
+	GIC_ACCESSOR_RO_INTR_BIT(off, name)				\
+									\
+static inline void write_gic_##name(unsigned int intr)			\
+{									\
+	void __iomem *addr = addr_gic_##name();				\
+									\
+	if (mips_cm_is64) {						\
+		addr += (intr / 64) * sizeof(uint64_t);			\
+		__raw_writeq(BIT(intr % 64), addr);			\
+	} else {							\
+		addr += (intr / 32) * sizeof(uint32_t);			\
+		__raw_writel(BIT(intr % 32), addr);			\
+	}								\
+}									\
+									\
+static inline void change_gic_##name(unsigned int intr,			\
+				     unsigned int val)			\
+{									\
+	void __iomem *addr = addr_gic_##name();				\
+									\
+	if (mips_cm_is64) {						\
+		uint64_t _val;						\
+									\
+		addr += (intr / 64) * sizeof(uint64_t);			\
+		_val = __raw_readq(addr);				\
+		_val &= ~BIT_ULL(intr % 64);				\
+		_val |= (uint64_t)val << (intr % 64);			\
+		__raw_writeq(_val, addr);				\
+	} else {							\
+		uint32_t _val;						\
+									\
+		addr += (intr / 32) * sizeof(uint32_t);			\
+		_val = __raw_readl(addr);				\
+		_val &= ~BIT(intr % 32);				\
+		_val |= val << (intr % 32);				\
+		__raw_writel(_val, addr);				\
+	}								\
+}
+
+/* For read-only local bit-per-interrupt registers */
+#define GIC_VX_ACCESSOR_RO_INTR_BIT(sz, off, name)			\
+	GIC_ACCESSOR_RO_INTR_BIT(sz, MIPS_GIC_LOCAL_OFS + off,		\
+				 vl_##name)				\
+	GIC_ACCESSOR_RO_INTR_BIT(sz, MIPS_GIC_REDIR_OFS + off,		\
+				 vo_##name)
+
+/* For read-write local bit-per-interrupt registers */
+#define GIC_VX_ACCESSOR_RW_INTR_BIT(sz, off, name)			\
+	GIC_ACCESSOR_RW_INTR_BIT(sz, MIPS_GIC_LOCAL_OFS + off,		\
+				 vl_##name)				\
+	GIC_ACCESSOR_RW_INTR_BIT(sz, MIPS_GIC_REDIR_OFS + off,		\
+				 vo_##name)
+
+/* GIC_SH_CONFIG - Information about the GIC configuration */
+GIC_ACCESSOR_RW(32, 0x000, config)
+#define GIC_CONFIG_COUNTSTOP		BIT(28)
+#define GIC_CONFIG_COUNTBITS		GENMASK(27, 24)
+#define GIC_CONFIG_NUMINTERRUPTS	GENMASK(23, 16)
+#define GIC_CONFIG_PVPS			GENMASK(6, 0)
+
+/* GIC_SH_COUNTER - Shared global counter value */
+GIC_ACCESSOR_RW(64, 0x010, counter)
+GIC_ACCESSOR_RW(32, 0x010, counter_32l)
+GIC_ACCESSOR_RW(32, 0x014, counter_32h)
+
+/* GIC_SH_POL_* - Configures interrupt polarity */
+GIC_ACCESSOR_RW_INTR_BIT(0x100, pol)
+#define GIC_POL_ACTIVE_LOW		0	/* when level triggered */
+#define GIC_POL_ACTIVE_HIGH		1	/* when level triggered */
+#define GIC_POL_FALLING_EDGE		0	/* when single-edge triggered */
+#define GIC_POL_RISING_EDGE		1	/* when single-edge triggered */
+
+/* GIC_SH_TRIG_* - Configures interrupts to be edge or level triggered */
+GIC_ACCESSOR_RW_INTR_BIT(0x180, trig)
+#define GIC_TRIG_LEVEL			0
+#define GIC_TRIG_EDGE			1
+
+/* GIC_SH_DUAL_* - Configures whether interrupts trigger on both edges */
+GIC_ACCESSOR_RW_INTR_BIT(0x200, dual)
+#define GIC_DUAL_SINGLE			0	/* when edge-triggered */
+#define GIC_DUAL_DUAL			1	/* when edge-triggered */
+
+/* GIC_SH_WEDGE - Write an 'edge', ie. trigger an interrupt */
+GIC_ACCESSOR_RW(32, 0x280, wedge)
+#define GIC_WEDGE_RW			BIT(31)
+#define GIC_WEDGE_INTR			GENMASK(7, 0)
+
+/* GIC_SH_RMASK_* - Reset/clear shared interrupt mask bits */
+GIC_ACCESSOR_RW_INTR_BIT(0x300, rmask)
+
+/* GIC_SH_SMASK_* - Set shared interrupt mask bits */
+GIC_ACCESSOR_RW_INTR_BIT(0x380, smask)
+
+/* GIC_SH_MASK_* - Read the current shared interrupt mask */
+GIC_ACCESSOR_RO_INTR_BIT(0x400, mask)
+
+/* GIC_SH_PEND_* - Read currently pending shared interrupts */
+GIC_ACCESSOR_RO_INTR_BIT(0x480, pend)
+
+/* GIC_SH_MAPx_PIN - Map shared interrupts to a particular CPU pin */
+GIC_ACCESSOR_RW_INTR_REG(32, 0x500, 0x4, map_pin)
+#define GIC_MAP_PIN_MAP_TO_PIN		BIT(31)
+#define GIC_MAP_PIN_MAP_TO_NMI		BIT(30)
+#define GIC_MAP_PIN_MAP			GENMASK(5, 0)
+
+/* GIC_SH_MAPx_VP - Map shared interrupts to a particular Virtual Processor */
+GIC_ACCESSOR_RW_INTR_REG(32, 0x2000, 0x20, map_vp)
+
+/* GIC_Vx_CTL - VP-level interrupt control */
+GIC_VX_ACCESSOR_RW(32, 0x000, ctl)
+#define GIC_VX_CTL_FDC_ROUTABLE		BIT(4)
+#define GIC_VX_CTL_SWINT_ROUTABLE	BIT(3)
+#define GIC_VX_CTL_PERFCNT_ROUTABLE	BIT(2)
+#define GIC_VX_CTL_TIMER_ROUTABLE	BIT(1)
+#define GIC_VX_CTL_EIC			BIT(0)
+
+/* GIC_Vx_PEND - Read currently pending local interrupts */
+GIC_VX_ACCESSOR_RO(32, 0x004, pend)
+
+/* GIC_Vx_MASK - Read the current local interrupt mask */
+GIC_VX_ACCESSOR_RO(32, 0x008, mask)
+
+/* GIC_Vx_RMASK - Reset/clear local interrupt mask bits */
+GIC_VX_ACCESSOR_RW(32, 0x00c, rmask)
+
+/* GIC_Vx_SMASK - Set local interrupt mask bits */
+GIC_VX_ACCESSOR_RW(32, 0x010, smask)
+
+/* GIC_Vx_*_MAP - Route local interrupts to the desired pins */
+GIC_VX_ACCESSOR_RW_INTR_REG(32, 0x040, 0x4, map)
+
+/* GIC_Vx_WD_MAP - Route the local watchdog timer interrupt */
+GIC_VX_ACCESSOR_RW(32, 0x040, wd_map)
+
+/* GIC_Vx_COMPARE_MAP - Route the local count/compare interrupt */
+GIC_VX_ACCESSOR_RW(32, 0x044, compare_map)
+
+/* GIC_Vx_TIMER_MAP - Route the local CPU timer (cp0 count/compare) interrupt */
+GIC_VX_ACCESSOR_RW(32, 0x048, timer_map)
+
+/* GIC_Vx_FDC_MAP - Route the local fast debug channel interrupt */
+GIC_VX_ACCESSOR_RW(32, 0x04c, fdc_map)
+
+/* GIC_Vx_PERFCTR_MAP - Route the local performance counter interrupt */
+GIC_VX_ACCESSOR_RW(32, 0x050, perfctr_map)
+
+/* GIC_Vx_SWINT0_MAP - Route the local software interrupt 0 */
+GIC_VX_ACCESSOR_RW(32, 0x054, swint0_map)
+
+/* GIC_Vx_SWINT1_MAP - Route the local software interrupt 1 */
+GIC_VX_ACCESSOR_RW(32, 0x058, swint1_map)
+
+/* GIC_Vx_OTHER - Configure access to other Virtual Processor registers */
+GIC_VX_ACCESSOR_RW(32, 0x080, other)
+#define GIC_VX_OTHER_VPNUM		GENMASK(5, 0)
+
+/* GIC_Vx_IDENT - Retrieve the local Virtual Processor's ID */
+GIC_VX_ACCESSOR_RO(32, 0x088, ident)
+#define GIC_VX_IDENT_VPNUM		GENMASK(5, 0)
+
+/* GIC_Vx_COMPARE - Value to compare with GIC_SH_COUNTER */
+GIC_VX_ACCESSOR_RW(64, 0x0a0, compare)
+
+/* GIC_Vx_EIC_SHADOW_SET_BASE - Set shadow register set for each interrupt */
+GIC_VX_ACCESSOR_RW_INTR_REG(32, 0x100, 0x4, eic_shadow_set)
+
+/**
+ * mips_gic_present() - Determine whether a GIC is present
+ *
+ * Determines whether a MIPS Global Interrupt Controller (GIC) is present in
+ * the system that the kernel is running on.
+ *
+ * Return true if a GIC is present, else false.
+ */
+static inline bool mips_gic_present(void)
+{
+	return IS_ENABLED(CONFIG_MIPS_GIC) && mips_gic_base;
+}
+
+#endif /* __MIPS_ASM_MIPS_CPS_H__ */
diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 6841bd79c7c2..aaa4c046ccfe 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -24,14 +24,13 @@
 #include <dt-bindings/interrupt-controller/mips-gic.h>
 
 unsigned int gic_present;
+void __iomem *mips_gic_base;
 
 struct gic_pcpu_mask {
 	DECLARE_BITMAP(pcpu_mask, GIC_MAX_INTRS);
 };
 
 static unsigned long __gic_base_addr;
-
-static void __iomem *gic_base;
 static struct gic_pcpu_mask pcpu_masks[NR_CPUS];
 static DEFINE_SPINLOCK(gic_lock);
 static struct irq_domain *gic_irq_domain;
@@ -48,12 +47,12 @@ static void __gic_irq_dispatch(void);
 
 static inline u32 gic_read32(unsigned int reg)
 {
-	return __raw_readl(gic_base + reg);
+	return __raw_readl(mips_gic_base + reg);
 }
 
 static inline u64 gic_read64(unsigned int reg)
 {
-	return __raw_readq(gic_base + reg);
+	return __raw_readq(mips_gic_base + reg);
 }
 
 static inline unsigned long gic_read(unsigned int reg)
@@ -66,12 +65,12 @@ static inline unsigned long gic_read(unsigned int reg)
 
 static inline void gic_write32(unsigned int reg, u32 val)
 {
-	return __raw_writel(val, gic_base + reg);
+	return __raw_writel(val, mips_gic_base + reg);
 }
 
 static inline void gic_write64(unsigned int reg, u64 val)
 {
-	return __raw_writeq(val, gic_base + reg);
+	return __raw_writeq(val, mips_gic_base + reg);
 }
 
 static inline void gic_write(unsigned int reg, unsigned long val)
@@ -891,7 +890,7 @@ static void __init __gic_init(unsigned long gic_base_addr,
 
 	__gic_base_addr = gic_base_addr;
 
-	gic_base = ioremap_nocache(gic_base_addr, gic_addrspace_size);
+	mips_gic_base = ioremap_nocache(gic_base_addr, gic_addrspace_size);
 
 	gicconfig = gic_read(GIC_REG(SHARED, GIC_SH_CONFIG));
 	gic_shared_intrs = (gicconfig & GIC_SH_CONFIG_NUMINTRS_MSK) >>
-- 
2.14.0
