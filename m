Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 May 2015 17:54:49 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:28745 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026807AbbEVPypC20mD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 May 2015 17:54:45 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id C0FCC86DE320;
        Fri, 22 May 2015 16:54:37 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 22 May 2015 16:53:38 +0100
Received: from localhost (192.168.159.131) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 22 May
 2015 16:53:38 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        "Paul Burton" <paul.burton@imgtec.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Andrew Bresticker <abrestic@chromium.org>,
        <linux-kernel@vger.kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Markos Chandras <markos.chandras@imgtec.com>,
        "Ralf Baechle" <ralf@linux-mips.org>
Subject: [PATCH 06/15] MIPS: malta: probe interrupt controllers via DT
Date:   Fri, 22 May 2015 16:51:05 +0100
Message-ID: <1432309875-9712-7-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.4.1
In-Reply-To: <1432309875-9712-1-git-send-email-paul.burton@imgtec.com>
References: <1432309875-9712-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.131]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47559
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

Probe the CPU, GIC & i8259 interrupt controllers present in the Malta
system using device tree. This enables interrupts to be provided to
devices using device tree as they are moved over to being probed using
it.

Since Malta is very configurable it's unknown whether a GIC will be
present at compile time. In order to support both cases the
malta_dt_shim code is added in order to detect whether a GIC is present,
adjusting the DT to route interrupts correctly and nop out the GIC node
if no GIC is found.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/Kconfig                               |   1 +
 arch/mips/boot/dts/mti/malta.dts                |  55 ++++++++++
 arch/mips/include/asm/mach-malta/malta-dtshim.h |  29 ++++++
 arch/mips/mti-malta/Makefile                    |   4 +-
 arch/mips/mti-malta/malta-dtshim.c              | 128 ++++++++++++++++++++++++
 arch/mips/mti-malta/malta-int.c                 |  77 ++------------
 arch/mips/mti-malta/malta-setup.c               |   5 +-
 7 files changed, 227 insertions(+), 72 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-malta/malta-dtshim.h
 create mode 100644 arch/mips/mti-malta/malta-dtshim.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 75dd13d..76cabdb 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -435,6 +435,7 @@ config MIPS_MALTA
 	select SYS_SUPPORTS_SMARTMIPS
 	select SYS_SUPPORTS_ZBOOT
 	select USE_OF
+	select LIBFDT
 	select BUILTIN_DTB
 	help
 	  This enables support for the MIPS Technologies Malta evaluation
diff --git a/arch/mips/boot/dts/mti/malta.dts b/arch/mips/boot/dts/mti/malta.dts
index c678115..4bcdeb4 100644
--- a/arch/mips/boot/dts/mti/malta.dts
+++ b/arch/mips/boot/dts/mti/malta.dts
@@ -1,7 +1,62 @@
 /dts-v1/;
 
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/mips-gic.h>
+
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
 	compatible = "mti,malta";
+
+	corecard {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <>;
+
+		cpu_intc: interrupt-controller {
+			compatible = "mti,cpu-interrupt-controller";
+
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		gic: interrupt-controller@1bdc0000 {
+			compatible = "mti,gic";
+			reg = <0x1bdc0000 0x20000>;
+
+			interrupt-controller;
+			#interrupt-cells = <3>;
+
+			/*
+			 * Declare the interrupt-parent even though the mti,gic
+			 * binding doesn't require it, such that the kernel can
+			 * figure out that cpu_intc is the root interrupt
+			 * controller & should be probed first.
+			 */
+			interrupt-parent = <&cpu_intc>;
+
+			timer {
+				compatible = "mti,gic-timer";
+				interrupts = <GIC_LOCAL 1 IRQ_TYPE_NONE>;
+			};
+		};
+	};
+
+	board {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <>;
+
+		i8259: interrupt-controller@20 {
+			compatible = "intel,i8259";
+
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SHARED 3 IRQ_TYPE_LEVEL_HIGH>;
+		};
+	};
 };
diff --git a/arch/mips/include/asm/mach-malta/malta-dtshim.h b/arch/mips/include/asm/mach-malta/malta-dtshim.h
new file mode 100644
index 0000000..cfd7776
--- /dev/null
+++ b/arch/mips/include/asm/mach-malta/malta-dtshim.h
@@ -0,0 +1,29 @@
+/*
+ * Copyright (C) 2015 Imagination Technologies
+ * Author: Paul Burton <paul.burton@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
+
+#ifndef __MIPS_MALTA_DTSHIM_H__
+#define __MIPS_MALTA_DTSHIM_H__
+
+#include <linux/init.h>
+
+#ifdef CONFIG_MIPS_MALTA
+
+extern void __init *malta_dt_shim(void *fdt);
+
+#else /* !CONFIG_MIPS_MALTA */
+
+static inline void *malta_dt_shim(void *fdt)
+{
+	return fdt;
+}
+
+#endif /* !CONFIG_MIPS_MALTA */
+
+#endif /* __MIPS_MALTA_DTSHIM_H__ */
diff --git a/arch/mips/mti-malta/Makefile b/arch/mips/mti-malta/Makefile
index ea35587..1d633fe 100644
--- a/arch/mips/mti-malta/Makefile
+++ b/arch/mips/mti-malta/Makefile
@@ -5,9 +5,11 @@
 # Copyright (C) 2008 Wind River Systems, Inc.
 #   written by Ralf Baechle <ralf@linux-mips.org>
 #
-obj-y				:= malta-display.o malta-dt.o malta-init.o \
+obj-y				:= malta-display.o malta-dt.o malta-dtshim.o malta-init.o \
 				   malta-int.o malta-memory.o malta-platform.o \
 				   malta-reset.o malta-setup.o malta-time.o
 
 obj-$(CONFIG_MIPS_CMP)		+= malta-amon.o
 obj-$(CONFIG_MIPS_MALTA_PM)	+= malta-pm.o
+
+CFLAGS_malta-dtshim.o = -I$(src)/../../../scripts/dtc/libfdt
diff --git a/arch/mips/mti-malta/malta-dtshim.c b/arch/mips/mti-malta/malta-dtshim.c
new file mode 100644
index 0000000..ca33201
--- /dev/null
+++ b/arch/mips/mti-malta/malta-dtshim.c
@@ -0,0 +1,128 @@
+/*
+ * Copyright (C) 2015 Imagination Technologies
+ * Author: Paul Burton <paul.burton@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/bug.h>
+#include <linux/kernel.h>
+#include <linux/libfdt.h>
+#include <linux/of_fdt.h>
+#include <asm/bootinfo.h>
+#include <asm/fw/fw.h>
+#include <asm/mips-boards/generic.h>
+#include <asm/mips-boards/malta.h>
+#include <asm/mips-cm.h>
+
+static unsigned char fdt_buf[16 << 10] __initdata;
+
+static void __init remove_gic(void *fdt)
+{
+	int err, gic_off, i8259_off, cpu_off;
+	void __iomem *biu_base;
+	uint32_t cpu_phandle, sc_cfg;
+
+	/* if we have a CM which reports a GIC is present, leave the DT alone */
+	err = mips_cm_probe();
+	if (!err && (read_gcr_gic_status() & CM_GCR_GIC_STATUS_GICEX_MSK))
+		return;
+
+	if (MIPS_REVISION_SCONID == MIPS_REVISION_SCON_ROCIT) {
+		/*
+		 * On systems using the RocIT system controller a GIC may be
+		 * present without a CM. Detect whether that is the case.
+		 */
+		biu_base = ioremap_nocache(MSC01_BIU_REG_BASE,
+				MSC01_BIU_ADDRSPACE_SZ);
+		sc_cfg = __raw_readl(biu_base + MSC01_SC_CFG_OFS);
+		if (sc_cfg & MSC01_SC_CFG_GICPRES_MSK) {
+			/* enable the GIC at the system controller level */
+			sc_cfg |= BIT(MSC01_SC_CFG_GICENA_SHF);
+			__raw_writel(sc_cfg, biu_base + MSC01_SC_CFG_OFS);
+			return;
+		}
+	}
+
+	gic_off = fdt_node_offset_by_compatible(fdt, -1, "mti,gic");
+	if (gic_off < 0) {
+		pr_warn("malta-dtshim: unable to find DT GIC node: %d\n",
+			gic_off);
+		return;
+	}
+
+	err = fdt_nop_node(fdt, gic_off);
+	if (err)
+		pr_warn("malta-dtshim: unable to nop GIC node\n");
+
+	i8259_off = fdt_node_offset_by_compatible(fdt, -1, "intel,i8259");
+	if (i8259_off < 0) {
+		pr_warn("malta-dtshim: unable to find DT i8259 node: %d\n",
+			i8259_off);
+		return;
+	}
+
+	cpu_off = fdt_node_offset_by_compatible(fdt, -1,
+			"mti,cpu-interrupt-controller");
+	if (cpu_off < 0) {
+		pr_warn("malta-dtshim: unable to find CPU intc node: %d\n",
+			cpu_off);
+		return;
+	}
+
+	cpu_phandle = fdt_get_phandle(fdt, cpu_off);
+	if (!cpu_phandle) {
+		pr_warn("malta-dtshim: unable to get CPU intc phandle\n");
+		return;
+	}
+
+	err = fdt_setprop_u32(fdt, i8259_off, "interrupt-parent", cpu_phandle);
+	if (err) {
+		pr_warn("malta-dtshim: unable to set i8259 interrupt-parent: %d\n",
+			err);
+		return;
+	}
+
+	err = fdt_setprop_u32(fdt, i8259_off, "interrupts", 2);
+	if (err) {
+		pr_warn("malta-dtshim: unable to set i8259 interrupts: %d\n",
+			err);
+		return;
+	}
+}
+
+void __init *malta_dt_shim(void *fdt)
+{
+	int root_off, len, err;
+	const char *compat;
+
+	if (fdt_check_header(fdt))
+		panic("Corrupt DT");
+
+	err = fdt_open_into(fdt, fdt_buf, sizeof(fdt_buf));
+	if (err)
+		panic("Unable to open FDT: %d", err);
+
+	root_off = fdt_path_offset(fdt_buf, "/");
+	if (root_off < 0)
+		panic("No / node in DT");
+
+	compat = fdt_getprop(fdt_buf, root_off, "compatible", &len);
+	if (!compat)
+		panic("No root compatible property in DT: %d", len);
+
+	/* if this isn't Malta, leave the DT alone */
+	if (strncmp(compat, "mti,malta", len))
+		return fdt;
+
+	remove_gic(fdt_buf);
+
+	err = fdt_pack(fdt_buf);
+	if (err)
+		panic("Unable to pack FDT: %d\n", err);
+
+	return fdt_buf;
+}
diff --git a/arch/mips/mti-malta/malta-int.c b/arch/mips/mti-malta/malta-int.c
index d1392f8..3fe5c17 100644
--- a/arch/mips/mti-malta/malta-int.c
+++ b/arch/mips/mti-malta/malta-int.c
@@ -14,6 +14,7 @@
  */
 #include <linux/init.h>
 #include <linux/irq.h>
+#include <linux/irqchip.h>
 #include <linux/sched.h>
 #include <linux/smp.h>
 #include <linux/interrupt.h>
@@ -21,6 +22,7 @@
 #include <linux/irqchip/mips-gic.h>
 #include <linux/kernel_stat.h>
 #include <linux/kernel.h>
+#include <linux/of_irq.h>
 #include <linux/random.h>
 
 #include <asm/traps.h>
@@ -37,10 +39,11 @@
 #include <asm/setup.h>
 #include <asm/rtlx.h>
 
-static void __iomem *_msc01_biu_base;
-
 static DEFINE_RAW_SPINLOCK(mips_irq_lock);
 
+OF_DECLARE_2(irqchip, mips_cpu_intc, "mti,cpu-interrupt-controller",
+	     mips_cpu_irq_of_init);
+
 static inline int mips_pcibios_iack(void)
 {
 	int irq;
@@ -104,30 +107,6 @@ static inline int get_int(void)
 	return irq;
 }
 
-static void malta_hw0_irqdispatch(void)
-{
-	int irq;
-
-	irq = get_int();
-	if (irq < 0) {
-		/* interrupt has already been cleared */
-		return;
-	}
-
-	do_IRQ(MALTA_INT_BASE + irq);
-
-#ifdef CONFIG_MIPS_VPE_APSP_API_MT
-	if (aprp_hook)
-		aprp_hook();
-#endif
-}
-
-static irqreturn_t i8259_handler(int irq, void *dev_id)
-{
-	malta_hw0_irqdispatch();
-	return IRQ_HANDLED;
-}
-
 static void corehi_irqdispatch(void)
 {
 	unsigned int intedge, intsteer, pcicmd, pcibadaddr;
@@ -240,12 +219,6 @@ static struct irqaction irq_call = {
 };
 #endif /* CONFIG_MIPS_MT_SMP */
 
-static struct irqaction i8259irq = {
-	.handler = i8259_handler,
-	.name = "XT-PIC cascade",
-	.flags = IRQF_NO_THREAD,
-};
-
 static struct irqaction corehi_irqaction = {
 	.handler = corehi_handler,
 	.name = "CoreHi",
@@ -281,28 +254,9 @@ void __init arch_init_ipiirq(int irq, struct irqaction *action)
 
 void __init arch_init_irq(void)
 {
-	int corehi_irq, i8259_irq;
-
-	init_i8259_irqs();
+	int corehi_irq;
 
-	if (!cpu_has_veic)
-		mips_cpu_irq_init();
-
-	if (mips_cm_present()) {
-		write_gcr_gic_base(GIC_BASE_ADDR | CM_GCR_GIC_BASE_GICEN_MSK);
-		gic_present = 1;
-	} else {
-		if (mips_revision_sconid == MIPS_REVISION_SCON_ROCIT) {
-			_msc01_biu_base = ioremap_nocache(MSC01_BIU_REG_BASE,
-						MSC01_BIU_ADDRSPACE_SZ);
-			gic_present =
-			  (__raw_readl(_msc01_biu_base + MSC01_SC_CFG_OFS) &
-			   MSC01_SC_CFG_GICPRES_MSK) >>
-			  MSC01_SC_CFG_GICPRES_SHF;
-		}
-	}
-	if (gic_present)
-		pr_debug("GIC present\n");
+	irqchip_init();
 
 	switch (mips_revision_sconid) {
 	case MIPS_REVISION_SCON_SOCIT:
@@ -330,18 +284,6 @@ void __init arch_init_irq(void)
 	}
 
 	if (gic_present) {
-		int i;
-
-		gic_init(GIC_BASE_ADDR, GIC_ADDRSPACE_SZ, MIPSCPU_INT_GIC,
-			 MIPS_GIC_IRQ_BASE);
-		if (!mips_cm_present()) {
-			/* Enable the GIC */
-			i = __raw_readl(_msc01_biu_base + MSC01_SC_CFG_OFS);
-			__raw_writel(i | (0x1 << MSC01_SC_CFG_GICENA_SHF),
-				 _msc01_biu_base + MSC01_SC_CFG_OFS);
-			pr_debug("GIC Enabled\n");
-		}
-		i8259_irq = MIPS_GIC_IRQ_BASE + GIC_INT_I8259A;
 		corehi_irq = MIPS_CPU_IRQ_BASE + MIPSCPU_INT_COREHI;
 	} else {
 #if defined(CONFIG_MIPS_MT_SMP)
@@ -361,19 +303,14 @@ void __init arch_init_irq(void)
 		arch_init_ipiirq(cpu_ipi_call_irq, &irq_call);
 #endif
 		if (cpu_has_veic) {
-			set_vi_handler(MSC01E_INT_I8259A,
-				       malta_hw0_irqdispatch);
 			set_vi_handler(MSC01E_INT_COREHI,
 				       corehi_irqdispatch);
-			i8259_irq = MSC01E_INT_BASE + MSC01E_INT_I8259A;
 			corehi_irq = MSC01E_INT_BASE + MSC01E_INT_COREHI;
 		} else {
-			i8259_irq = MIPS_CPU_IRQ_BASE + MIPSCPU_INT_I8259A;
 			corehi_irq = MIPS_CPU_IRQ_BASE + MIPSCPU_INT_COREHI;
 		}
 	}
 
-	setup_irq(i8259_irq, &i8259irq);
 	setup_irq(corehi_irq, &corehi_irqaction);
 }
 
diff --git a/arch/mips/mti-malta/malta-setup.c b/arch/mips/mti-malta/malta-setup.c
index 9d1e7f5..4740c82 100644
--- a/arch/mips/mti-malta/malta-setup.c
+++ b/arch/mips/mti-malta/malta-setup.c
@@ -27,6 +27,7 @@
 #include <linux/time.h>
 
 #include <asm/fw/fw.h>
+#include <asm/mach-malta/malta-dtshim.h>
 #include <asm/mips-cm.h>
 #include <asm/mips-boards/generic.h>
 #include <asm/mips-boards/malta.h>
@@ -250,8 +251,10 @@ static void __init bonito_quirks_setup(void)
 void __init plat_mem_setup(void)
 {
 	unsigned int i;
+	void *fdt = __dtb_start;
 
-	__dt_setup_arch(__dtb_start);
+	fdt = malta_dt_shim(fdt);
+	__dt_setup_arch(fdt);
 
 	if (config_enabled(CONFIG_EVA))
 		/* EVA has already been configured in mach-malta/kernel-init.h */
-- 
2.4.1
