From: Felix Fietkau <nbd@openwrt.org>
Date: Thu, 15 Jan 2015 19:05:28 +0100
Subject: MIPS: IRQ: Fix disable_irq on CPU IRQs
Message-ID: <20150115180528.dCTxI4t9oO1DZjmTZ1AcRVxwy72QAkQDqG6KDkixLsk@z>

commit a3e6c1eff54878506b2dddcc202df9cc8180facb upstream.

If the irq_chip does not define .irq_disable, any call to disable_irq
will defer disabling the IRQ until it fires while marked as disabled.
This assumes that the handler function checks for this condition, which
handle_percpu_irq does not. In this case, calling disable_irq leads to
an IRQ storm, if the interrupt fires while disabled.

This optimization is only useful when disabling the IRQ is slow, which
is not true for the MIPS CPU IRQ.

Disable this optimization by implementing .irq_disable and .irq_enable

Signed-off-by: Felix Fietkau <nbd@openwrt.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/8949/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/kernel/irq_cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/kernel/irq_cpu.c b/arch/mips/kernel/irq_cpu.c
index e498f2b..f5598e2 100644
--- a/arch/mips/kernel/irq_cpu.c
+++ b/arch/mips/kernel/irq_cpu.c
@@ -56,6 +56,8 @@ static struct irq_chip mips_cpu_irq_controller = {
 	.irq_mask_ack	= mask_mips_irq,
 	.irq_unmask	= unmask_mips_irq,
 	.irq_eoi	= unmask_mips_irq,
+	.irq_disable	= mask_mips_irq,
+	.irq_enable	= unmask_mips_irq,
 };

 /*
@@ -92,6 +94,8 @@ static struct irq_chip mips_mt_cpu_irq_controller = {
 	.irq_mask_ack	= mips_mt_cpu_irq_ack,
 	.irq_unmask	= unmask_mips_irq,
 	.irq_eoi	= unmask_mips_irq,
+	.irq_disable	= mask_mips_irq,
+	.irq_enable	= unmask_mips_irq,
 };

 void __init mips_cpu_irq_init(void)
--
1.9.1
