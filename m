Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Jan 2013 14:24:16 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:44767 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825725Ab3AaNXakbWe4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 31 Jan 2013 14:23:30 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, devicetree-discuss@lists.ozlabs.org,
        Gabor Juhos <juhosg@openwrt.org>,
        John Crispin <blogic@openwrt.org>
Subject: [PATCH 2/3] MIPS: add irqdomain support for the CPU IRQ controller
Date:   Thu, 31 Jan 2013 14:20:43 +0100
Message-Id: <1359638444-8891-2-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1359638444-8891-1-git-send-email-blogic@openwrt.org>
References: <1359638444-8891-1-git-send-email-blogic@openwrt.org>
X-archive-position: 35662
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: Gabor Juhos <juhosg@openwrt.org>

Add code to load a irq_domain for the MIPS IRQ controller from a devicetree
file.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/include/asm/irq_cpu.h |    6 ++++++
 arch/mips/kernel/irq_cpu.c      |   42 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/arch/mips/include/asm/irq_cpu.h b/arch/mips/include/asm/irq_cpu.h
index ef6a07c..3f11fdb 100644
--- a/arch/mips/include/asm/irq_cpu.h
+++ b/arch/mips/include/asm/irq_cpu.h
@@ -17,4 +17,10 @@ extern void mips_cpu_irq_init(void);
 extern void rm7k_cpu_irq_init(void);
 extern void rm9k_cpu_irq_init(void);
 
+#ifdef CONFIG_IRQ_DOMAIN
+struct device_node;
+extern int mips_cpu_intc_init(struct device_node *of_node,
+			      struct device_node *parent);
+#endif
+
 #endif /* _ASM_IRQ_CPU_H */
diff --git a/arch/mips/kernel/irq_cpu.c b/arch/mips/kernel/irq_cpu.c
index 972263b..49bc9ca 100644
--- a/arch/mips/kernel/irq_cpu.c
+++ b/arch/mips/kernel/irq_cpu.c
@@ -31,6 +31,7 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/irq.h>
+#include <linux/irqdomain.h>
 
 #include <asm/irq_cpu.h>
 #include <asm/mipsregs.h>
@@ -113,3 +114,44 @@ void __init mips_cpu_irq_init(void)
 		irq_set_chip_and_handler(i, &mips_cpu_irq_controller,
 					 handle_percpu_irq);
 }
+
+#ifdef CONFIG_IRQ_DOMAIN
+static int mips_cpu_intc_map(struct irq_domain *d, unsigned int irq,
+			     irq_hw_number_t hw)
+{
+	static struct irq_chip *chip;
+
+	if (hw < 2 && cpu_has_mipsmt) {
+		/* Software interrupts are used for MT/CMT IPI */
+		chip = &mips_mt_cpu_irq_controller;
+	} else {
+		chip = &mips_cpu_irq_controller;
+	}
+
+	irq_set_chip_and_handler(irq, chip, handle_percpu_irq);
+
+	return 0;
+}
+
+static const struct irq_domain_ops mips_cpu_intc_irq_domain_ops = {
+	.map = mips_cpu_intc_map,
+	.xlate = irq_domain_xlate_onecell,
+};
+
+int __init mips_cpu_intc_init(struct device_node *of_node,
+			      struct device_node *parent)
+{
+	struct irq_domain *domain;
+
+	/* Mask interrupts. */
+	clear_c0_status(ST0_IM);
+	clear_c0_cause(CAUSEF_IP);
+
+	domain = irq_domain_add_legacy(of_node, 8, MIPS_CPU_IRQ_BASE, 0,
+				       &mips_cpu_intc_irq_domain_ops, NULL);
+	if (!domain)
+		panic("Failed to add irqdomain for MIPS CPU\n");
+
+	return 0;
+}
+#endif /* CONFIG_IRQ_DOMAIN */
-- 
1.7.10.4
