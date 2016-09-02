Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Sep 2016 17:52:20 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:45709 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992029AbcIBPvbr0HUA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Sep 2016 17:51:31 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id B8968998056EA;
        Fri,  2 Sep 2016 16:51:10 +0100 (IST)
Received: from localhost (10.100.200.40) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 2 Sep
 2016 16:51:13 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 06/12] MIPS: Malta: Probe interrupt controllers via DT
Date:   Fri, 2 Sep 2016 16:48:52 +0100
Message-ID: <20160902154859.24269-7-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160902154859.24269-1-paul.burton@imgtec.com>
References: <20160902154859.24269-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.40]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55010
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

 arch/mips/Kconfig                  |  1 +
 arch/mips/boot/dts/mti/malta.dts   | 41 ++++++++++++++++
 arch/mips/mti-malta/malta-dtshim.c | 78 +++++++++++++++++++++++++++++++
 arch/mips/mti-malta/malta-int.c    | 96 ++------------------------------------
 4 files changed, 125 insertions(+), 91 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 2638856..d875a5a 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -478,6 +478,7 @@ config MIPS_MALTA
 	select SYS_SUPPORTS_ZBOOT
 	select SYS_SUPPORTS_RELOCATABLE
 	select USE_OF
+	select LIBFDT
 	select ZONE_DMA32 if 64BIT
 	select BUILTIN_DTB
 	select LIBFDT
diff --git a/arch/mips/boot/dts/mti/malta.dts b/arch/mips/boot/dts/mti/malta.dts
index b18c466..af765af 100644
--- a/arch/mips/boot/dts/mti/malta.dts
+++ b/arch/mips/boot/dts/mti/malta.dts
@@ -1,5 +1,8 @@
 /dts-v1/;
 
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/mips-gic.h>
+
 /memreserve/ 0x00000000 0x00001000;	/* YAMON exception vectors */
 /memreserve/ 0x00001000 0x000ef000;	/* YAMON */
 /memreserve/ 0x000f0000 0x00010000;	/* PIIX4 ISA memory */
@@ -8,4 +11,42 @@
 	#address-cells = <1>;
 	#size-cells = <1>;
 	compatible = "mti,malta";
+
+	cpu_intc: interrupt-controller {
+		compatible = "mti,cpu-interrupt-controller";
+
+		interrupt-controller;
+		#interrupt-cells = <1>;
+	};
+
+	gic: interrupt-controller@1bdc0000 {
+		compatible = "mti,gic";
+		reg = <0x1bdc0000 0x20000>;
+
+		interrupt-controller;
+		#interrupt-cells = <3>;
+
+		/*
+		 * Declare the interrupt-parent even though the mti,gic
+		 * binding doesn't require it, such that the kernel can
+		 * figure out that cpu_intc is the root interrupt
+		 * controller & should be probed first.
+		 */
+		interrupt-parent = <&cpu_intc>;
+
+		timer {
+			compatible = "mti,gic-timer";
+			interrupts = <GIC_LOCAL 1 IRQ_TYPE_NONE>;
+		};
+	};
+
+	i8259: interrupt-controller@20 {
+		compatible = "intel,i8259";
+
+		interrupt-controller;
+		#interrupt-cells = <1>;
+
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SHARED 3 IRQ_TYPE_LEVEL_HIGH>;
+	};
 };
diff --git a/arch/mips/mti-malta/malta-dtshim.c b/arch/mips/mti-malta/malta-dtshim.c
index 5d37b7e..c398582 100644
--- a/arch/mips/mti-malta/malta-dtshim.c
+++ b/arch/mips/mti-malta/malta-dtshim.c
@@ -16,6 +16,9 @@
 #include <asm/addrspace.h>
 #include <asm/bootinfo.h>
 #include <asm/fw/fw.h>
+#include <asm/mips-boards/generic.h>
+#include <asm/mips-boards/malta.h>
+#include <asm/mips-cm.h>
 #include <asm/page.h>
 
 #define ROCIT_REG_BASE			0x1f403000
@@ -225,6 +228,80 @@ static void __init append_memory(void *fdt, int root_off)
 		panic("Unable to set linux,usable-memory property: %d", err);
 }
 
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
+	if (malta_scon() == MIPS_REVISION_SCON_ROCIT) {
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
 void __init *malta_dt_shim(void *fdt)
 {
 	int root_off, len, err;
@@ -250,6 +327,7 @@ void __init *malta_dt_shim(void *fdt)
 		return fdt;
 
 	append_memory(fdt_buf, root_off);
+	remove_gic(fdt_buf);
 
 	err = fdt_pack(fdt_buf);
 	if (err)
diff --git a/arch/mips/mti-malta/malta-int.c b/arch/mips/mti-malta/malta-int.c
index c6a6c7a..9f83224 100644
--- a/arch/mips/mti-malta/malta-int.c
+++ b/arch/mips/mti-malta/malta-int.c
@@ -14,11 +14,13 @@
  */
 #include <linux/init.h>
 #include <linux/irq.h>
+#include <linux/irqchip.h>
 #include <linux/sched.h>
 #include <linux/smp.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/irqchip/mips-gic.h>
+#include <linux/of_irq.h>
 #include <linux/kernel_stat.h>
 #include <linux/kernel.h>
 #include <linux/random.h>
@@ -37,10 +39,6 @@
 #include <asm/setup.h>
 #include <asm/rtlx.h>
 
-static void __iomem *_msc01_biu_base;
-
-static DEFINE_RAW_SPINLOCK(mips_irq_lock);
-
 static inline int mips_pcibios_iack(void)
 {
 	int irq;
@@ -85,49 +83,6 @@ static inline int mips_pcibios_iack(void)
 	return irq;
 }
 
-static inline int get_int(void)
-{
-	unsigned long flags;
-	int irq;
-	raw_spin_lock_irqsave(&mips_irq_lock, flags);
-
-	irq = mips_pcibios_iack();
-
-	/*
-	 * The only way we can decide if an interrupt is spurious
-	 * is by checking the 8259 registers.  This needs a spinlock
-	 * on an SMP system,  so leave it up to the generic code...
-	 */
-
-	raw_spin_unlock_irqrestore(&mips_irq_lock, flags);
-
-	return irq;
-}
-
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
@@ -240,12 +195,6 @@ static struct irqaction irq_call = {
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
@@ -281,28 +230,10 @@ void __init arch_init_ipiirq(int irq, struct irqaction *action)
 
 void __init arch_init_irq(void)
 {
-	int corehi_irq, i8259_irq;
+	int corehi_irq;
 
-	init_i8259_irqs();
-
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
+	i8259_set_poll(mips_pcibios_iack);
+	irqchip_init();
 
 	switch (mips_revision_sconid) {
 	case MIPS_REVISION_SCON_SOCIT:
@@ -330,18 +261,6 @@ void __init arch_init_irq(void)
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
@@ -361,19 +280,14 @@ void __init arch_init_irq(void)
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
 
-- 
2.9.3
