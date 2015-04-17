Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Apr 2015 16:26:39 +0200 (CEST)
Received: from smtp2-g21.free.fr ([212.27.42.2]:52484 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010531AbbDQO0Xb2gc2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Apr 2015 16:26:23 +0200
Received: from localhost.localdomain (unknown [85.177.206.240])
        (Authenticated sender: albeu)
        by smtp2-g21.free.fr (Postfix) with ESMTPA id 8391C4B01C9;
        Fri, 17 Apr 2015 16:23:29 +0200 (CEST)
From:   Alban Bedel <albeu@free.fr>
To:     linux-mips@linux-mips.org
Cc:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alban Bedel <albeu@free.fr>,
        Andrew Bresticker <abrestic@chromium.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/14] MIPS: ath79: Add OF support to the IRQ controllers
Date:   Fri, 17 Apr 2015 16:24:21 +0200
Message-Id: <1429280669-2986-7-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1429280669-2986-1-git-send-email-albeu@free.fr>
References: <1429280669-2986-1-git-send-email-albeu@free.fr>
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46891
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

Add OF support for the CPU and MISC interrupt controllers of most
supported ATH79 devices.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 arch/mips/ath79/irq.c | 87 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 86 insertions(+), 1 deletion(-)

diff --git a/arch/mips/ath79/irq.c b/arch/mips/ath79/irq.c
index 2c3991a..afb0096 100644
--- a/arch/mips/ath79/irq.c
+++ b/arch/mips/ath79/irq.c
@@ -15,7 +15,9 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
-#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/of_irq.h>
+#include "../../../drivers/irqchip/irqchip.h"
 
 #include <asm/irq_cpu.h>
 #include <asm/mipsregs.h>
@@ -23,6 +25,7 @@
 #include <asm/mach-ath79/ath79.h>
 #include <asm/mach-ath79/ar71xx_regs.h>
 #include "common.h"
+#include "machtypes.h"
 
 static void ath79_misc_irq_handler(unsigned int irq, struct irq_desc *desc)
 {
@@ -268,8 +271,90 @@ asmlinkage void plat_irq_dispatch(void)
 	}
 }
 
+#ifdef CONFIG_IRQCHIP
+static int misc_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
+{
+	irq_set_chip_and_handler(irq, &ath79_misc_irq_chip, handle_level_irq);
+	return 0;
+}
+
+static const struct irq_domain_ops misc_irq_domain_ops = {
+	.xlate = irq_domain_xlate_onecell,
+	.map = misc_map,
+};
+
+static int __init ath79_misc_intc_of_init(
+	struct device_node *node, struct device_node *parent)
+{
+	void __iomem *base = ath79_reset_base;
+	struct irq_domain *domain;
+	int irq;
+
+	irq = irq_of_parse_and_map(node, 0);
+	if (!irq)
+		panic("Failed to get MISC IRQ");
+
+	domain = irq_domain_add_legacy(node, ATH79_MISC_IRQ_COUNT,
+			ATH79_MISC_IRQ_BASE, 0, &misc_irq_domain_ops, NULL);
+	if (!domain)
+		panic("Failed to add MISC irqdomain");
+
+	/* Disable and clear all interrupts */
+	__raw_writel(0, base + AR71XX_RESET_REG_MISC_INT_ENABLE);
+	__raw_writel(0, base + AR71XX_RESET_REG_MISC_INT_STATUS);
+
+
+	irq_set_chained_handler(irq, ath79_misc_irq_handler);
+
+	return 0;
+}
+IRQCHIP_DECLARE(ath79_misc_intc, "qca,ar7100-misc-intc",
+		ath79_misc_intc_of_init);
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
+		pr_info("IRQ: Set flush channel of IRQ%d to %d\n",
+			irq, args.args[0]);
+	}
+
+	return mips_cpu_irq_of_init(node, parent);
+}
+IRQCHIP_DECLARE(ar79_cpu_intc, "qca,ar7100-cpu-intc",
+		ar79_cpu_intc_of_init);
+
+#endif
+
 void __init arch_init_irq(void)
 {
+	if (mips_machtype == ATH79_MACH_GENERIC_OF) {
+		irqchip_init();
+		return;
+	}
+
 	if (soc_is_ar71xx() || soc_is_ar724x() ||
 	    soc_is_ar913x() || soc_is_ar933x()) {
 		irq_wb_chan[2] = 3;
-- 
2.0.0
