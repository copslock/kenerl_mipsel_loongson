From: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Date: Wed, 25 Jan 2017 15:08:25 +0100
Subject: irqchip/mips-gic: Fix local interrupts
Message-ID: <20170125140825.GkHFUnBNGdQmZJ5flzWWIoY9J-_h3eaL_YJhXEt_8uw@z>

From: Marcin Nowakowski <marcin.nowakowski@imgtec.com>

commit 4cfffcfa5106492f5785924ce2e9af49f075999b upstream.

Some local interrupts are not initialised properly at the moment and
cannot be used since the domain's alloc method is never called for them.

This has been observed earlier and partially fixed in commit
e875bd66dfb ("irqchip/mips-gic: Fix local interrupts"), but that change
still relied on the interrupt to be requested by an external driver (eg.
drivers/clocksource/mips-gic-timer.c).

This does however not solve the issue for interrupts that are not
referenced by any driver through the device tree and results in
request_irq() calls returning -ENOSYS. It can be observed when attempting
to use perf tool to access hardware performance counters.

Fix this by explicitly calling irq_create_fwspec_mapping() for local
interrupts.

Fixes: e875bd66dfb ("irqchip/mips-gic: Fix local interrupts")
Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-mips@linux-mips.org
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Cc: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/irqchip/irq-mips-gic.c |   29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -969,6 +969,34 @@ static struct irq_domain_ops gic_ipi_dom
 	.match = gic_ipi_domain_match,
 };
 
+static void __init gic_map_single_int(struct device_node *node,
+				      unsigned int irq)
+{
+	unsigned int linux_irq;
+	struct irq_fwspec local_int_fwspec = {
+		.fwnode         = &node->fwnode,
+		.param_count    = 3,
+		.param          = {
+			[0]     = GIC_LOCAL,
+			[1]     = irq,
+			[2]     = IRQ_TYPE_NONE,
+		},
+	};
+
+	if (!gic_local_irq_is_routable(irq))
+		return;
+
+	linux_irq = irq_create_fwspec_mapping(&local_int_fwspec);
+	WARN_ON(!linux_irq);
+}
+
+static void __init gic_map_interrupts(struct device_node *node)
+{
+	gic_map_single_int(node, GIC_LOCAL_INT_TIMER);
+	gic_map_single_int(node, GIC_LOCAL_INT_PERFCTR);
+	gic_map_single_int(node, GIC_LOCAL_INT_FDC);
+}
+
 static void __init __gic_init(unsigned long gic_base_addr,
 			      unsigned long gic_addrspace_size,
 			      unsigned int cpu_vec, unsigned int irqbase,
@@ -1069,6 +1097,7 @@ static void __init __gic_init(unsigned l
 
 	bitmap_copy(ipi_available, ipi_resrv, GIC_MAX_INTRS);
 	gic_basic_init();
+	gic_map_interrupts(node);
 }
 
 void __init gic_init(unsigned long gic_base_addr,


Patches currently in stable-queue which might be from marcin.nowakowski@imgtec.com are

queue-4.9/irqchip-mips-gic-fix-local-interrupts.patch
queue-4.9/mips-fix-mem-x-y-commandline-processing.patch
