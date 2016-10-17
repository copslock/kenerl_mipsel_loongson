Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Oct 2016 18:55:58 +0200 (CEST)
Received: from mailapp02.imgtec.com ([217.156.133.132]:32923 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992990AbcJQQxQFolqz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Oct 2016 18:53:16 +0200
Received: from HHMAIL03.hh.imgtec.org (unknown [10.44.0.21])
        by Forcepoint Email with ESMTPS id B62BBFE46F597;
        Mon, 17 Oct 2016 17:53:03 +0100 (IST)
Received: from HHMAIL01.hh.imgtec.org (10.100.10.19) by HHMAIL03.hh.imgtec.org
 (10.44.0.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 17 Oct 2016
 17:53:07 +0100
Received: from zkakakhel-linux.le.imgtec.org (192.168.154.45) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 17 Oct 2016 17:53:06 +0100
From:   Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
To:     <monstr@monstr.eu>, <ralf@linux-mips.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <marc.zyngier@arm.com>,
        <alistair@popple.id.au>, <mporter@kernel.crashing.org>
CC:     <soren.brinkmann@xilinx.com>, <linux-kernel@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <michal.simek@xilinx.com>,
        <linuxppc-dev@lists.ozlabs.org>, <mpe@ellerman.id.au>,
        <paulus@samba.org>, <benh@kernel.crashing.org>
Subject: [Patch v5 06/12] powerpc/virtex: Use generic xilinx irqchip driver
Date:   Mon, 17 Oct 2016 17:52:50 +0100
Message-ID: <1476723176-39891-7-git-send-email-Zubair.Kakakhel@imgtec.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1476723176-39891-1-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1476723176-39891-1-git-send-email-Zubair.Kakakhel@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.45]
Return-Path: <Zubair.Kakakhel@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55472
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Zubair.Kakakhel@imgtec.com
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

The Xilinx interrupt controller driver is now available in drivers/irqchip.
Switch to using that driver.

Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>

---
V5 New patch

Tested on virtex440-ml507 using qemu
---
 arch/powerpc/include/asm/xilinx_intc.h |   2 +-
 arch/powerpc/platforms/40x/Kconfig     |   1 +
 arch/powerpc/platforms/40x/virtex.c    |   2 +-
 arch/powerpc/platforms/44x/Kconfig     |   1 +
 arch/powerpc/platforms/44x/virtex.c    |   2 +-
 arch/powerpc/sysdev/xilinx_intc.c      | 211 +--------------------------------
 drivers/irqchip/irq-xilinx-intc.c      |   3 +-
 7 files changed, 9 insertions(+), 213 deletions(-)

diff --git a/arch/powerpc/include/asm/xilinx_intc.h b/arch/powerpc/include/asm/xilinx_intc.h
index 343612f..3192d7f 100644
--- a/arch/powerpc/include/asm/xilinx_intc.h
+++ b/arch/powerpc/include/asm/xilinx_intc.h
@@ -14,7 +14,7 @@
 #ifdef __KERNEL__
 
 extern void __init xilinx_intc_init_tree(void);
-extern unsigned int xilinx_intc_get_irq(void);
+extern unsigned int xintc_get_irq(void);
 
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_XILINX_INTC_H */
diff --git a/arch/powerpc/platforms/40x/Kconfig b/arch/powerpc/platforms/40x/Kconfig
index e3257f2..1d7c1b1 100644
--- a/arch/powerpc/platforms/40x/Kconfig
+++ b/arch/powerpc/platforms/40x/Kconfig
@@ -64,6 +64,7 @@ config XILINX_VIRTEX_GENERIC_BOARD
 	default n
 	select XILINX_VIRTEX_II_PRO
 	select XILINX_VIRTEX_4_FX
+	select XILINX_INTC
 	help
 	  This option enables generic support for Xilinx Virtex based boards.
 
diff --git a/arch/powerpc/platforms/40x/virtex.c b/arch/powerpc/platforms/40x/virtex.c
index 91a08ea..e3d5e09 100644
--- a/arch/powerpc/platforms/40x/virtex.c
+++ b/arch/powerpc/platforms/40x/virtex.c
@@ -48,7 +48,7 @@ static int __init virtex_probe(void)
 	.probe			= virtex_probe,
 	.setup_arch		= xilinx_pci_init,
 	.init_IRQ		= xilinx_intc_init_tree,
-	.get_irq		= xilinx_intc_get_irq,
+	.get_irq		= xintc_get_irq,
 	.restart		= ppc4xx_reset_system,
 	.calibrate_decr		= generic_calibrate_decr,
 };
diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
index 48fc180..25b8d64 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -241,6 +241,7 @@ config XILINX_VIRTEX440_GENERIC_BOARD
 	depends on 44x
 	default n
 	select XILINX_VIRTEX_5_FXT
+	select XILINX_INTC
 	help
 	  This option enables generic support for Xilinx Virtex based boards
 	  that use a 440 based processor in the Virtex 5 FXT FPGA architecture.
diff --git a/arch/powerpc/platforms/44x/virtex.c b/arch/powerpc/platforms/44x/virtex.c
index a7e0802..3eb13ed 100644
--- a/arch/powerpc/platforms/44x/virtex.c
+++ b/arch/powerpc/platforms/44x/virtex.c
@@ -54,7 +54,7 @@ static int __init virtex_probe(void)
 	.probe			= virtex_probe,
 	.setup_arch		= xilinx_pci_init,
 	.init_IRQ		= xilinx_intc_init_tree,
-	.get_irq		= xilinx_intc_get_irq,
+	.get_irq		= xintc_get_irq,
 	.calibrate_decr		= generic_calibrate_decr,
 	.restart		= ppc4xx_reset_system,
 };
diff --git a/arch/powerpc/sysdev/xilinx_intc.c b/arch/powerpc/sysdev/xilinx_intc.c
index 0f52d79..4a86dcf 100644
--- a/arch/powerpc/sysdev/xilinx_intc.c
+++ b/arch/powerpc/sysdev/xilinx_intc.c
@@ -29,194 +29,7 @@
 #include <asm/processor.h>
 #include <asm/i8259.h>
 #include <asm/irq.h>
-
-/*
- * INTC Registers
- */
-#define XINTC_ISR	0	/* Interrupt Status */
-#define XINTC_IPR	4	/* Interrupt Pending */
-#define XINTC_IER	8	/* Interrupt Enable */
-#define XINTC_IAR	12	/* Interrupt Acknowledge */
-#define XINTC_SIE	16	/* Set Interrupt Enable bits */
-#define XINTC_CIE	20	/* Clear Interrupt Enable bits */
-#define XINTC_IVR	24	/* Interrupt Vector */
-#define XINTC_MER	28	/* Master Enable */
-
-static struct irq_domain *master_irqhost;
-
-#define XILINX_INTC_MAXIRQS	(32)
-
-/* The following table allows the interrupt type, edge or level,
- * to be cached after being read from the device tree until the interrupt
- * is mapped
- */
-static int xilinx_intc_typetable[XILINX_INTC_MAXIRQS];
-
-/* Map the interrupt type from the device tree to the interrupt types
- * used by the interrupt subsystem
- */
-static unsigned char xilinx_intc_map_senses[] = {
-	IRQ_TYPE_EDGE_RISING,
-	IRQ_TYPE_EDGE_FALLING,
-	IRQ_TYPE_LEVEL_HIGH,
-	IRQ_TYPE_LEVEL_LOW,
-};
-
-/*
- * The interrupt controller is setup such that it doesn't work well with
- * the level interrupt handler in the kernel because the handler acks the
- * interrupt before calling the application interrupt handler. To deal with
- * that, we use 2 different irq chips so that different functions can be
- * used for level and edge type interrupts.
- *
- * IRQ Chip common (across level and edge) operations
- */
-static void xilinx_intc_mask(struct irq_data *d)
-{
-	int irq = irqd_to_hwirq(d);
-	void * regs = irq_data_get_irq_chip_data(d);
-	pr_debug("mask: %d\n", irq);
-	out_be32(regs + XINTC_CIE, 1 << irq);
-}
-
-static int xilinx_intc_set_type(struct irq_data *d, unsigned int flow_type)
-{
-	return 0;
-}
-
-/*
- * IRQ Chip level operations
- */
-static void xilinx_intc_level_unmask(struct irq_data *d)
-{
-	int irq = irqd_to_hwirq(d);
-	void * regs = irq_data_get_irq_chip_data(d);
-	pr_debug("unmask: %d\n", irq);
-	out_be32(regs + XINTC_SIE, 1 << irq);
-
-	/* ack level irqs because they can't be acked during
-	 * ack function since the handle_level_irq function
-	 * acks the irq before calling the inerrupt handler
-	 */
-	out_be32(regs + XINTC_IAR, 1 << irq);
-}
-
-static struct irq_chip xilinx_intc_level_irqchip = {
-	.name = "Xilinx Level INTC",
-	.irq_mask = xilinx_intc_mask,
-	.irq_mask_ack = xilinx_intc_mask,
-	.irq_unmask = xilinx_intc_level_unmask,
-	.irq_set_type = xilinx_intc_set_type,
-};
-
-/*
- * IRQ Chip edge operations
- */
-static void xilinx_intc_edge_unmask(struct irq_data *d)
-{
-	int irq = irqd_to_hwirq(d);
-	void *regs = irq_data_get_irq_chip_data(d);
-	pr_debug("unmask: %d\n", irq);
-	out_be32(regs + XINTC_SIE, 1 << irq);
-}
-
-static void xilinx_intc_edge_ack(struct irq_data *d)
-{
-	int irq = irqd_to_hwirq(d);
-	void * regs = irq_data_get_irq_chip_data(d);
-	pr_debug("ack: %d\n", irq);
-	out_be32(regs + XINTC_IAR, 1 << irq);
-}
-
-static struct irq_chip xilinx_intc_edge_irqchip = {
-	.name = "Xilinx Edge  INTC",
-	.irq_mask = xilinx_intc_mask,
-	.irq_unmask = xilinx_intc_edge_unmask,
-	.irq_ack = xilinx_intc_edge_ack,
-	.irq_set_type = xilinx_intc_set_type,
-};
-
-/*
- * IRQ Host operations
- */
-
-/**
- * xilinx_intc_xlate - translate virq# from device tree interrupts property
- */
-static int xilinx_intc_xlate(struct irq_domain *h, struct device_node *ct,
-				const u32 *intspec, unsigned int intsize,
-				irq_hw_number_t *out_hwirq,
-				unsigned int *out_flags)
-{
-	if ((intsize < 2) || (intspec[0] >= XILINX_INTC_MAXIRQS))
-		return -EINVAL;
-
-	/* keep a copy of the interrupt type til the interrupt is mapped
-	 */
-	xilinx_intc_typetable[intspec[0]] = xilinx_intc_map_senses[intspec[1]];
-
-	/* Xilinx uses 2 interrupt entries, the 1st being the h/w
-	 * interrupt number, the 2nd being the interrupt type, edge or level
-	 */
-	*out_hwirq = intspec[0];
-	*out_flags = xilinx_intc_map_senses[intspec[1]];
-
-	return 0;
-}
-static int xilinx_intc_map(struct irq_domain *h, unsigned int virq,
-				  irq_hw_number_t irq)
-{
-	irq_set_chip_data(virq, h->host_data);
-
-	if (xilinx_intc_typetable[irq] == IRQ_TYPE_LEVEL_HIGH ||
-	    xilinx_intc_typetable[irq] == IRQ_TYPE_LEVEL_LOW) {
-		irq_set_chip_and_handler(virq, &xilinx_intc_level_irqchip,
-					 handle_level_irq);
-	} else {
-		irq_set_chip_and_handler(virq, &xilinx_intc_edge_irqchip,
-					 handle_edge_irq);
-	}
-	return 0;
-}
-
-static const struct irq_domain_ops xilinx_intc_ops = {
-	.map = xilinx_intc_map,
-	.xlate = xilinx_intc_xlate,
-};
-
-struct irq_domain * __init
-xilinx_intc_init(struct device_node *np)
-{
-	struct irq_domain * irq;
-	void * regs;
-
-	/* Find and map the intc registers */
-	regs = of_iomap(np, 0);
-	if (!regs) {
-		pr_err("xilinx_intc: could not map registers\n");
-		return NULL;
-	}
-
-	/* Setup interrupt controller */
-	out_be32(regs + XINTC_IER, 0); /* disable all irqs */
-	out_be32(regs + XINTC_IAR, ~(u32) 0); /* Acknowledge pending irqs */
-	out_be32(regs + XINTC_MER, 0x3UL); /* Turn on the Master Enable. */
-
-	/* Allocate and initialize an irq_domain structure. */
-	irq = irq_domain_add_linear(np, XILINX_INTC_MAXIRQS, &xilinx_intc_ops,
-				    regs);
-	if (!irq)
-		panic(__FILE__ ": Cannot allocate IRQ host\n");
-
-	return irq;
-}
-
-int xilinx_intc_get_irq(void)
-{
-	void * regs = master_irqhost->host_data;
-	pr_debug("get_irq:\n");
-	return irq_linear_revmap(master_irqhost, in_be32(regs + XINTC_IVR));
-}
+#include <linux/irqchip.h>
 
 #if defined(CONFIG_PPC_I8259)
 /*
@@ -265,31 +78,11 @@ static void __init xilinx_i8259_setup_cascade(void)
 static inline void xilinx_i8259_setup_cascade(void) { return; }
 #endif /* defined(CONFIG_PPC_I8259) */
 
-static const struct of_device_id xilinx_intc_match[] __initconst = {
-	{ .compatible = "xlnx,opb-intc-1.00.c", },
-	{ .compatible = "xlnx,xps-intc-1.00.a", },
-	{}
-};
-
 /*
  * Initialize master Xilinx interrupt controller
  */
 void __init xilinx_intc_init_tree(void)
 {
-	struct device_node *np;
-
-	/* find top level interrupt controller */
-	for_each_matching_node(np, xilinx_intc_match) {
-		if (!of_get_property(np, "interrupts", NULL))
-			break;
-	}
-	BUG_ON(!np);
-
-	master_irqhost = xilinx_intc_init(np);
-	BUG_ON(!master_irqhost);
-
-	irq_set_default_host(master_irqhost);
-	of_node_put(np);
-
+	irqchip_init();
 	xilinx_i8259_setup_cascade();
 }
diff --git a/drivers/irqchip/irq-xilinx-intc.c b/drivers/irqchip/irq-xilinx-intc.c
index 485fb11..dd372d7 100644
--- a/drivers/irqchip/irq-xilinx-intc.c
+++ b/drivers/irqchip/irq-xilinx-intc.c
@@ -254,4 +254,5 @@ static int __init xilinx_intc_of_init(struct device_node *intc,
 
 }
 
-IRQCHIP_DECLARE(xilinx_intc, "xlnx,xps-intc-1.00.a", xilinx_intc_of_init);
+IRQCHIP_DECLARE(xilinx_intc_xps, "xlnx,xps-intc-1.00.a", xilinx_intc_of_init);
+IRQCHIP_DECLARE(xilinx_intc_opb, "xlnx,opb-intc-1.00.c", xilinx_intc_of_init);
-- 
1.9.1
