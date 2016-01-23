Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Jan 2016 13:58:24 +0100 (CET)
Received: from smtp3-g21.free.fr ([212.27.42.3]:17769 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010779AbcAWM6P7cv0I (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 23 Jan 2016 13:58:15 +0100
Received: from localhost.localdomain (unknown [78.54.16.94])
        (Authenticated sender: albeu)
        by smtp3-g21.free.fr (Postfix) with ESMTPA id 9A9C5A627D;
        Sat, 23 Jan 2016 13:56:32 +0100 (CET)
From:   Alban Bedel <albeu@free.fr>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Alexander Couzens <lynxis@fe80.eu>,
        Joel Porquet <joel@porquet.org>, linux-kernel@vger.kernel.org,
        Alban Bedel <albeu@free.fr>
Subject: [PATCH v2 2/2] MIPS: ath79: irq: Move the CPU IRQ driver to drivers/irqchip
Date:   Sat, 23 Jan 2016 13:57:47 +0100
Message-Id: <1453553867-27003-2-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1453553867-27003-1-git-send-email-albeu@free.fr>
References: <1453553867-27003-1-git-send-email-albeu@free.fr>
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51321
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

Signed-off-by: Alban Bedel <albeu@free.fr>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/mips/ath79/irq.c                    | 81 ++------------------------
 arch/mips/include/asm/mach-ath79/ath79.h |  1 +
 drivers/irqchip/Makefile                 |  1 +
 drivers/irqchip/irq-ath79-cpu.c          | 97 ++++++++++++++++++++++++++++++++
 4 files changed, 105 insertions(+), 75 deletions(-)
 create mode 100644 drivers/irqchip/irq-ath79-cpu.c

diff --git a/arch/mips/ath79/irq.c b/arch/mips/ath79/irq.c
index 05b4514..2dfff1f 100644
--- a/arch/mips/ath79/irq.c
+++ b/arch/mips/ath79/irq.c
@@ -128,79 +128,10 @@ static void qca955x_irq_init(void)
 	irq_set_chained_handler(ATH79_CPU_IRQ(3), qca955x_ip3_irq_dispatch);
 }
 
-/*
- * The IP2/IP3 lines are tied to a PCI/WMAC/USB device. Drivers for
- * these devices typically allocate coherent DMA memory, however the
- * DMA controller may still have some unsynchronized data in the FIFO.
- * Issue a flush in the handlers to ensure that the driver sees
- * the update.
- *
- * This array map the interrupt lines to the DDR write buffer channels.
- */
-
-static unsigned irq_wb_chan[8] = {
-	-1, -1, -1, -1, -1, -1, -1, -1,
-};
-
-asmlinkage void plat_irq_dispatch(void)
-{
-	unsigned long pending;
-	int irq;
-
-	pending = read_c0_status() & read_c0_cause() & ST0_IM;
-
-	if (!pending) {
-		spurious_interrupt();
-		return;
-	}
-
-	pending >>= CAUSEB_IP;
-	while (pending) {
-		irq = fls(pending) - 1;
-		if (irq < ARRAY_SIZE(irq_wb_chan) && irq_wb_chan[irq] != -1)
-			ath79_ddr_wb_flush(irq_wb_chan[irq]);
-		do_IRQ(MIPS_CPU_IRQ_BASE + irq);
-		pending &= ~BIT(irq);
-	}
-}
-
-static int __init ar79_cpu_intc_of_init(
-	struct device_node *node, struct device_node *parent)
-{
-	int err, i, count;
-
-	/* Fill the irq_wb_chan table */
-	count = of_count_phandle_with_args(
-		node, "qca,ddr-wb-channels", "#qca,ddr-wb-channel-cells");
-
-	for (i = 0; i < count; i++) {
-		struct of_phandle_args args;
-		u32 irq = i;
-
-		of_property_read_u32_index(
-			node, "qca,ddr-wb-channel-interrupts", i, &irq);
-		if (irq >= ARRAY_SIZE(irq_wb_chan))
-			continue;
-
-		err = of_parse_phandle_with_args(
-			node, "qca,ddr-wb-channels",
-			"#qca,ddr-wb-channel-cells",
-			i, &args);
-		if (err)
-			return err;
-
-		irq_wb_chan[irq] = args.args[0];
-		pr_info("IRQ: Set flush channel of IRQ%d to %d\n",
-			irq, args.args[0]);
-	}
-
-	return mips_cpu_irq_of_init(node, parent);
-}
-IRQCHIP_DECLARE(ar79_cpu_intc, "qca,ar7100-cpu-intc",
-		ar79_cpu_intc_of_init);
-
 void __init arch_init_irq(void)
 {
+	unsigned irq_wb_chan2 = -1;
+	unsigned irq_wb_chan3 = -1;
 	bool misc_is_ar71xx;
 
 	if (mips_machtype == ATH79_MACH_GENERIC_OF) {
@@ -210,13 +141,13 @@ void __init arch_init_irq(void)
 
 	if (soc_is_ar71xx() || soc_is_ar724x() ||
 	    soc_is_ar913x() || soc_is_ar933x()) {
-		irq_wb_chan[2] = 3;
-		irq_wb_chan[3] = 2;
+		irq_wb_chan2 = 3;
+		irq_wb_chan3 = 2;
 	} else if (soc_is_ar934x()) {
-		irq_wb_chan[3] = 2;
+		irq_wb_chan3 = 2;
 	}
 
-	mips_cpu_irq_init();
+	ath79_cpu_irq_init(irq_wb_chan2, irq_wb_chan3);
 
 	if (soc_is_ar71xx() || soc_is_ar913x())
 		misc_is_ar71xx = true;
diff --git a/arch/mips/include/asm/mach-ath79/ath79.h b/arch/mips/include/asm/mach-ath79/ath79.h
index 22a2f56..441faa9 100644
--- a/arch/mips/include/asm/mach-ath79/ath79.h
+++ b/arch/mips/include/asm/mach-ath79/ath79.h
@@ -144,6 +144,7 @@ static inline u32 ath79_reset_rr(unsigned reg)
 void ath79_device_reset_set(u32 mask);
 void ath79_device_reset_clear(u32 mask);
 
+void ath79_cpu_irq_init(unsigned irq_wb_chan2, unsigned irq_wb_chan3);
 void ath79_misc_irq_init(void __iomem *regs, int irq,
 			int irq_base, bool is_ar71xx);
 
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index a8f9075..91c24ed 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -1,5 +1,6 @@
 obj-$(CONFIG_IRQCHIP)			+= irqchip.o
 
+obj-$(CONFIG_ATH79)			+= irq-ath79-cpu.o
 obj-$(CONFIG_ATH79)			+= irq-ath79-misc.o
 obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2835.o
 obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2836.o
diff --git a/drivers/irqchip/irq-ath79-cpu.c b/drivers/irqchip/irq-ath79-cpu.c
new file mode 100644
index 0000000..befe93c
--- /dev/null
+++ b/drivers/irqchip/irq-ath79-cpu.c
@@ -0,0 +1,97 @@
+/*
+ *  Atheros AR71xx/AR724x/AR913x specific interrupt handling
+ *
+ *  Copyright (C) 2015 Alban Bedel <albeu@free.fr>
+ *  Copyright (C) 2010-2011 Jaiganesh Narayanan <jnarayanan@atheros.com>
+ *  Copyright (C) 2008-2011 Gabor Juhos <juhosg@openwrt.org>
+ *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
+ *
+ *  Parts of this file are based on Atheros' 2.6.15/2.6.31 BSP
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/irqchip.h>
+#include <linux/of.h>
+
+#include <asm/irq_cpu.h>
+#include <asm/mach-ath79/ath79.h>
+
+/*
+ * The IP2/IP3 lines are tied to a PCI/WMAC/USB device. Drivers for
+ * these devices typically allocate coherent DMA memory, however the
+ * DMA controller may still have some unsynchronized data in the FIFO.
+ * Issue a flush in the handlers to ensure that the driver sees
+ * the update.
+ *
+ * This array map the interrupt lines to the DDR write buffer channels.
+ */
+
+static unsigned irq_wb_chan[8] = {
+	-1, -1, -1, -1, -1, -1, -1, -1,
+};
+
+asmlinkage void plat_irq_dispatch(void)
+{
+	unsigned long pending;
+	int irq;
+
+	pending = read_c0_status() & read_c0_cause() & ST0_IM;
+
+	if (!pending) {
+		spurious_interrupt();
+		return;
+	}
+
+	pending >>= CAUSEB_IP;
+	while (pending) {
+		irq = fls(pending) - 1;
+		if (irq < ARRAY_SIZE(irq_wb_chan) && irq_wb_chan[irq] != -1)
+			ath79_ddr_wb_flush(irq_wb_chan[irq]);
+		do_IRQ(MIPS_CPU_IRQ_BASE + irq);
+		pending &= ~BIT(irq);
+	}
+}
+
+static int __init ar79_cpu_intc_of_init(
+	struct device_node *node, struct device_node *parent)
+{
+	int err, i, count;
+
+	/* Fill the irq_wb_chan table */
+	count = of_count_phandle_with_args(
+		node, "qca,ddr-wb-channels", "#qca,ddr-wb-channel-cells");
+
+	for (i = 0; i < count; i++) {
+		struct of_phandle_args args;
+		u32 irq = i;
+
+		of_property_read_u32_index(
+			node, "qca,ddr-wb-channel-interrupts", i, &irq);
+		if (irq >= ARRAY_SIZE(irq_wb_chan))
+			continue;
+
+		err = of_parse_phandle_with_args(
+			node, "qca,ddr-wb-channels",
+			"#qca,ddr-wb-channel-cells",
+			i, &args);
+		if (err)
+			return err;
+
+		irq_wb_chan[irq] = args.args[0];
+	}
+
+	return mips_cpu_irq_of_init(node, parent);
+}
+IRQCHIP_DECLARE(ar79_cpu_intc, "qca,ar7100-cpu-intc",
+		ar79_cpu_intc_of_init);
+
+void __init ath79_cpu_irq_init(unsigned irq_wb_chan2, unsigned irq_wb_chan3)
+{
+	irq_wb_chan[2] = irq_wb_chan2;
+	irq_wb_chan[3] = irq_wb_chan3;
+	mips_cpu_irq_init();
+}
-- 
2.0.0
