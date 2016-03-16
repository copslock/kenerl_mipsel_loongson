From: Qais Yousef <qsyousef@gmail.com>
Date: Wed, 16 Mar 2016 21:55:04 +0000
Subject: [PATCH] MIPS: Fix broken malta qemu
Message-ID: <20160316215504.JBby0GkfNKTRz-bG57dQIcfNX8PU2NFMnT3-H5BdpmY@z>

Malta defconfig compile with GIC on. Hence when compiling for SMP it causes the
new IPI code to be activated. But on qemu malta there's no GIC causing a
BUG_ON(!ipidomain) to be hit in mips_smp_ipi_init().

Introduce an extra check that gic_preset is true and skip initialising IPIs if
it's not.

Signed-off-by: Qais Yousef <qsyousef@gmail.com>
---
 arch/mips/kernel/smp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 37708d9..972f64d 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -33,6 +33,7 @@
 #include <linux/cpu.h>
 #include <linux/err.h>
 #include <linux/ftrace.h>
+#include <linux/irqchip/mips-gic.h>
 #include <linux/irqdomain.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
@@ -243,6 +244,13 @@ static int __init mips_smp_ipi_init(void)
 	struct irq_domain *ipidomain;
 	struct device_node *node;
 
+	/*
+	 * If the config says GIC is present, but the harware doesn't actually
+	 * have it we could get stuffed, so double check that GIC is present
+	 */
+	if (WARN_ON(!gic_present))
+		return 0;
+
 	node = of_irq_find_parent(of_root);
 	ipidomain = irq_find_matching_host(node, DOMAIN_BUS_IPI);
 
-- 
1.9.1


--------------070206070600080600020506--
