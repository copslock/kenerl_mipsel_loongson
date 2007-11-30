Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Nov 2007 21:51:13 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:41369 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S28579381AbXK3VvE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 30 Nov 2007 21:51:04 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1IyDiD-0000y1-00; Fri, 30 Nov 2007 22:47:53 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id 7E597C2EAB; Fri, 30 Nov 2007 22:47:49 +0100 (CET)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] SNI_RM: EISA support for A20R/RM200
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
Message-Id: <20071130214749.7E597C2EAB@solo.franken.de>
Date:	Fri, 30 Nov 2007 22:47:49 +0100 (CET)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17651
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

This patch adds EISA support for non PCI RMs (RM200 and RM400-xxx). The
major part is the splitting of the EISA and onboard ISA of the RM200,
which makes the EISA bus on the RM200 look like on other RMs.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

 arch/mips/sni/Makefile |    1 +
 arch/mips/sni/a20r.c   |    2 +-
 arch/mips/sni/eisa.c   |   52 ++++++++
 arch/mips/sni/rm200.c  |  322 ++++++++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 366 insertions(+), 11 deletions(-)

diff --git a/arch/mips/sni/Makefile b/arch/mips/sni/Makefile
index 3a99cd6..8f4e30a 100644
--- a/arch/mips/sni/Makefile
+++ b/arch/mips/sni/Makefile
@@ -4,5 +4,6 @@
 
 obj-y += irq.o reset.o setup.o a20r.o rm200.o pcimt.o pcit.o time.o
 obj-$(CONFIG_CPU_BIG_ENDIAN) += sniprom.o
+obj-$(CONFIG_EISA) += eisa.o
 
 EXTRA_CFLAGS += -Werror
diff --git a/arch/mips/sni/a20r.c b/arch/mips/sni/a20r.c
index b746075..2eaaa5e 100644
--- a/arch/mips/sni/a20r.c
+++ b/arch/mips/sni/a20r.c
@@ -231,9 +231,9 @@ static int __init snirm_a20r_setup_devinit(void)
 	        platform_device_register(&sc26xx_pdev);
 	        platform_device_register(&a20r_serial8250_device);
 	        platform_device_register(&a20r_ds1216_device);
+		sni_eisa_root_init();
 	        break;
 	}
-
 	return 0;
 }
 
diff --git a/arch/mips/sni/eisa.c b/arch/mips/sni/eisa.c
new file mode 100644
index 0000000..2fd2412
--- /dev/null
+++ b/arch/mips/sni/eisa.c
@@ -0,0 +1,52 @@
+/*
+ * Virtual EISA root driver.
+ * Acts as a placeholder if we don't have a proper EISA bridge.
+ *
+ * (C) 2003 Marc Zyngier <maz@wild-wind.fr.eu.org>
+ * modified for SNI usage by Thomas Bogendoerfer
+ *
+ * This code is released under the GPL version 2.
+ */
+
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/eisa.h>
+#include <linux/init.h>
+
+/* The default EISA device parent (virtual root device).
+ * Now use a platform device, since that's the obvious choice. */
+
+static struct platform_device eisa_root_dev = {
+	.name = "eisa",
+	.id   = 0,
+};
+
+static struct eisa_root_device eisa_bus_root = {
+	.dev           = &eisa_root_dev.dev,
+	.bus_base_addr = 0,
+	.res	       = &ioport_resource,
+	.slots	       = EISA_MAX_SLOTS,
+	.dma_mask      = 0xffffffff,
+	.force_probe   = 1,
+};
+
+int __init sni_eisa_root_init(void)
+{
+	int r;
+
+	r = platform_device_register(&eisa_root_dev);
+	if (!r)
+		return r;
+
+	eisa_root_dev.dev.driver_data = &eisa_bus_root;
+
+	if (eisa_root_register(&eisa_bus_root)) {
+		/* A real bridge may have been registered before
+		 * us. So quietly unregister. */
+		platform_device_unregister(&eisa_root_dev);
+		return -1;
+	}
+	return 0;
+}
+
+
diff --git a/arch/mips/sni/rm200.c b/arch/mips/sni/rm200.c
index 67b061e..0a3ae99 100644
--- a/arch/mips/sni/rm200.c
+++ b/arch/mips/sni/rm200.c
@@ -5,30 +5,36 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 2006 Thomas Bogendoerfer (tsbogend@alpha.franken.de)
+ * Copyright (C) 2006,2007 Thomas Bogendoerfer (tsbogend@alpha.franken.de)
+ *
+ * i8259 parts ripped out of arch/mips/kernel/i8259.c
  */
 
+#include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/serial_8250.h>
+#include <linux/io.h>
 
 #include <asm/sni.h>
 #include <asm/time.h>
 #include <asm/irq_cpu.h>
 
-#define PORT(_base,_irq)				\
+#define RM200_I8259A_IRQ_BASE 32
+
+#define MEMPORT(_base,_irq)				\
 	{						\
-		.iobase		= _base,		\
+		.mapbase	= _base,		\
 		.irq		= _irq,			\
 		.uartclk	= 1843200,		\
-		.iotype		= UPIO_PORT,		\
-		.flags		= UPF_BOOT_AUTOCONF,	\
+		.iotype		= UPIO_MEM,		\
+		.flags		= UPF_BOOT_AUTOCONF|UPF_IOREMAP, \
 	}
 
 static struct plat_serial8250_port rm200_data[] = {
-	PORT(0x3f8, 4),
-	PORT(0x2f8, 3),
+	MEMPORT(0x160003f8, RM200_I8259A_IRQ_BASE + 4),
+	MEMPORT(0x160002f8, RM200_I8259A_IRQ_BASE + 3),
 	{ },
 };
 
@@ -112,12 +118,308 @@ static int __init snirm_setup_devinit(void)
 		platform_device_register(&rm200_ds1216_device);
 		platform_device_register(&snirm_82596_rm200_pdev);
 		platform_device_register(&snirm_53c710_rm200_pdev);
+		sni_eisa_root_init();
 	}
 	return 0;
 }
 
 device_initcall(snirm_setup_devinit);
 
+/*
+ * RM200 has an ISA and an EISA bus. The iSA bus is only used
+ * for onboard devices and also has twi i8259 PICs. Since these
+ * PICs are no accessible via inb/outb the following code uses
+ * readb/writeb to access them
+ */
+
+DEFINE_SPINLOCK(sni_rm200_i8259A_lock);
+#define PIC_CMD    0x00
+#define PIC_IMR    0x01
+#define PIC_ISR    PIC_CMD
+#define PIC_POLL   PIC_ISR
+#define PIC_OCW3   PIC_ISR
+
+/* i8259A PIC related value */
+#define PIC_CASCADE_IR		2
+#define MASTER_ICW4_DEFAULT	0x01
+#define SLAVE_ICW4_DEFAULT	0x01
+
+/*
+ * This contains the irq mask for both 8259A irq controllers,
+ */
+static unsigned int rm200_cached_irq_mask = 0xffff;
+static __iomem u8 *rm200_pic_master;
+static __iomem u8 *rm200_pic_slave;
+
+#define cached_master_mask	(rm200_cached_irq_mask)
+#define cached_slave_mask	(rm200_cached_irq_mask >> 8)
+
+static void sni_rm200_disable_8259A_irq(unsigned int irq)
+{
+	unsigned int mask;
+	unsigned long flags;
+
+	irq -= RM200_I8259A_IRQ_BASE;
+	mask = 1 << irq;
+	spin_lock_irqsave(&sni_rm200_i8259A_lock, flags);
+	rm200_cached_irq_mask |= mask;
+	if (irq & 8)
+		writeb(cached_slave_mask, rm200_pic_slave + PIC_IMR);
+	else
+		writeb(cached_master_mask, rm200_pic_master + PIC_IMR);
+	spin_unlock_irqrestore(&sni_rm200_i8259A_lock, flags);
+}
+
+static void sni_rm200_enable_8259A_irq(unsigned int irq)
+{
+	unsigned int mask;
+	unsigned long flags;
+
+	irq -= RM200_I8259A_IRQ_BASE;
+	mask = ~(1 << irq);
+	spin_lock_irqsave(&sni_rm200_i8259A_lock, flags);
+	rm200_cached_irq_mask &= mask;
+	if (irq & 8)
+		writeb(cached_slave_mask, rm200_pic_slave + PIC_IMR);
+	else
+		writeb(cached_master_mask, rm200_pic_master + PIC_IMR);
+	spin_unlock_irqrestore(&sni_rm200_i8259A_lock, flags);
+}
+
+static inline int sni_rm200_i8259A_irq_real(unsigned int irq)
+{
+	int value;
+	int irqmask = 1 << irq;
+
+	if (irq < 8) {
+		writeb(0x0B, rm200_pic_master + PIC_CMD);
+		value = readb(rm200_pic_master + PIC_CMD) & irqmask;
+		writeb(0x0A, rm200_pic_master + PIC_CMD);
+		return value;
+	}
+	writeb(0x0B, rm200_pic_slave + PIC_CMD); /* ISR register */
+	value = readb(rm200_pic_slave + PIC_CMD) & (irqmask >> 8);
+	writeb(0x0A, rm200_pic_slave + PIC_CMD);
+	return value;
+}
+
+/*
+ * Careful! The 8259A is a fragile beast, it pretty
+ * much _has_ to be done exactly like this (mask it
+ * first, _then_ send the EOI, and the order of EOI
+ * to the two 8259s is important!
+ */
+void sni_rm200_mask_and_ack_8259A(unsigned int irq)
+{
+	unsigned int irqmask;
+	unsigned long flags;
+
+	irq -= RM200_I8259A_IRQ_BASE;
+	irqmask = 1 << irq;
+	spin_lock_irqsave(&sni_rm200_i8259A_lock, flags);
+	/*
+	 * Lightweight spurious IRQ detection. We do not want
+	 * to overdo spurious IRQ handling - it's usually a sign
+	 * of hardware problems, so we only do the checks we can
+	 * do without slowing down good hardware unnecessarily.
+	 *
+	 * Note that IRQ7 and IRQ15 (the two spurious IRQs
+	 * usually resulting from the 8259A-1|2 PICs) occur
+	 * even if the IRQ is masked in the 8259A. Thus we
+	 * can check spurious 8259A IRQs without doing the
+	 * quite slow i8259A_irq_real() call for every IRQ.
+	 * This does not cover 100% of spurious interrupts,
+	 * but should be enough to warn the user that there
+	 * is something bad going on ...
+	 */
+	if (rm200_cached_irq_mask & irqmask)
+		goto spurious_8259A_irq;
+	rm200_cached_irq_mask |= irqmask;
+
+handle_real_irq:
+	if (irq & 8) {
+		readb(rm200_pic_slave + PIC_IMR);
+		writeb(cached_slave_mask, rm200_pic_slave + PIC_IMR);
+		writeb(0x60+(irq & 7), rm200_pic_slave + PIC_CMD);
+		writeb(0x60+PIC_CASCADE_IR, rm200_pic_master + PIC_CMD);
+	} else {
+		readb(rm200_pic_master + PIC_IMR);
+		writeb(cached_master_mask, rm200_pic_master + PIC_IMR);
+		writeb(0x60+irq, rm200_pic_master + PIC_CMD);
+	}
+	spin_unlock_irqrestore(&sni_rm200_i8259A_lock, flags);
+	return;
+
+spurious_8259A_irq:
+	/*
+	 * this is the slow path - should happen rarely.
+	 */
+	if (sni_rm200_i8259A_irq_real(irq))
+		/*
+		 * oops, the IRQ _is_ in service according to the
+		 * 8259A - not spurious, go handle it.
+		 */
+		goto handle_real_irq;
+
+	{
+		static int spurious_irq_mask;
+		/*
+		 * At this point we can be sure the IRQ is spurious,
+		 * lets ACK and report it. [once per IRQ]
+		 */
+		if (!(spurious_irq_mask & irqmask)) {
+			printk(KERN_DEBUG
+			       "spurious RM200 8259A interrupt: IRQ%d.\n", irq);
+			spurious_irq_mask |= irqmask;
+		}
+		atomic_inc(&irq_err_count);
+		/*
+		 * Theoretically we do not have to handle this IRQ,
+		 * but in Linux this does not cause problems and is
+		 * simpler for us.
+		 */
+		goto handle_real_irq;
+	}
+}
+
+static struct irq_chip sni_rm200_i8259A_chip = {
+	.name		= "RM200-XT-PIC",
+	.mask		= sni_rm200_disable_8259A_irq,
+	.unmask		= sni_rm200_enable_8259A_irq,
+	.mask_ack	= sni_rm200_mask_and_ack_8259A,
+};
+
+/*
+ * Do the traditional i8259 interrupt polling thing.  This is for the few
+ * cases where no better interrupt acknowledge method is available and we
+ * absolutely must touch the i8259.
+ */
+static inline int sni_rm200_i8259_irq(void)
+{
+	int irq;
+
+	spin_lock(&sni_rm200_i8259A_lock);
+
+	/* Perform an interrupt acknowledge cycle on controller 1. */
+	writeb(0x0C, rm200_pic_master + PIC_CMD);	/* prepare for poll */
+	irq = readb(rm200_pic_master + PIC_CMD) & 7;
+	if (irq == PIC_CASCADE_IR) {
+		/*
+		 * Interrupt is cascaded so perform interrupt
+		 * acknowledge on controller 2.
+		 */
+		writeb(0x0C, rm200_pic_slave + PIC_CMD); /* prepare for poll */
+		irq = (readb(rm200_pic_slave + PIC_CMD) & 7) + 8;
+	}
+
+	if (unlikely(irq == 7)) {
+		/*
+		 * This may be a spurious interrupt.
+		 *
+		 * Read the interrupt status register (ISR). If the most
+		 * significant bit is not set then there is no valid
+		 * interrupt.
+		 */
+		writeb(0x0B, rm200_pic_master + PIC_ISR); /* ISR register */
+		if (~readb(rm200_pic_master + PIC_ISR) & 0x80)
+			irq = -1;
+	}
+
+	spin_unlock(&sni_rm200_i8259A_lock);
+
+	return likely(irq >= 0) ? irq + RM200_I8259A_IRQ_BASE : irq;
+}
+
+void sni_rm200_init_8259A(void)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&sni_rm200_i8259A_lock, flags);
+
+	writeb(0xff, rm200_pic_master + PIC_IMR);
+	writeb(0xff, rm200_pic_slave + PIC_IMR);
+
+	writeb(0x11, rm200_pic_master + PIC_CMD);
+	writeb(0, rm200_pic_master + PIC_IMR);
+	writeb(1U << PIC_CASCADE_IR, rm200_pic_master + PIC_IMR);
+	writeb(MASTER_ICW4_DEFAULT, rm200_pic_master + PIC_IMR);
+	writeb(0x11, rm200_pic_slave + PIC_CMD);
+	writeb(8, rm200_pic_slave + PIC_IMR);
+	writeb(PIC_CASCADE_IR, rm200_pic_slave + PIC_IMR);
+	writeb(SLAVE_ICW4_DEFAULT, rm200_pic_slave + PIC_IMR);
+	udelay(100);		/* wait for 8259A to initialize */
+
+	writeb(cached_master_mask, rm200_pic_master + PIC_IMR);
+	writeb(cached_slave_mask, rm200_pic_slave + PIC_IMR);
+
+	spin_unlock_irqrestore(&sni_rm200_i8259A_lock, flags);
+}
+
+/*
+ * IRQ2 is cascade interrupt to second interrupt controller
+ */
+static struct irqaction sni_rm200_irq2 = {
+	no_action, 0, CPU_MASK_NONE, "cascade", NULL, NULL
+};
+
+static struct resource sni_rm200_pic1_resource = {
+	.name = "onboard ISA pic1",
+	.start = 0x16000020,
+	.end = 0x16000023,
+	.flags = IORESOURCE_BUSY
+};
+
+static struct resource sni_rm200_pic2_resource = {
+	.name = "onboard ISA pic2",
+	.start = 0x160000a0,
+	.end = 0x160000a3,
+	.flags = IORESOURCE_BUSY
+};
+
+/* ISA irq handler */
+static irqreturn_t sni_rm200_i8259A_irq_handler(int dummy, void *p)
+{
+	int irq;
+
+	irq = sni_rm200_i8259_irq();
+	if (unlikely(irq < 0))
+		return IRQ_NONE;
+
+	do_IRQ(irq);
+	return IRQ_HANDLED;
+}
+
+struct irqaction sni_rm200_i8259A_irq = {
+	.handler = sni_rm200_i8259A_irq_handler,
+	.name = "onboard ISA",
+	.flags = IRQF_SHARED
+};
+
+void __init sni_rm200_i8259_irqs(void)
+{
+	int i;
+
+	rm200_pic_master = ioremap_nocache(0x16000020, 4);
+	if (!rm200_pic_master)
+		return;
+	rm200_pic_slave = ioremap_nocache(0x160000a0, 4);
+	if (!rm200_pic_master) {
+		iounmap(rm200_pic_master);
+		return;
+	}
+
+	insert_resource(&iomem_resource, &sni_rm200_pic1_resource);
+	insert_resource(&iomem_resource, &sni_rm200_pic2_resource);
+
+	sni_rm200_init_8259A();
+
+	for (i = RM200_I8259A_IRQ_BASE; i < RM200_I8259A_IRQ_BASE + 16; i++)
+		set_irq_chip_and_handler(i, &sni_rm200_i8259A_chip,
+					 handle_level_irq);
+
+	setup_irq(RM200_I8259A_IRQ_BASE + PIC_CASCADE_IR, &sni_rm200_irq2);
+}
+
 
 #define SNI_RM200_INT_STAT_REG  0xbc000000
 #define SNI_RM200_INT_ENA_REG   0xbc080000
@@ -181,17 +483,17 @@ void __init sni_rm200_irq_init(void)
 
 	* (volatile u8 *)SNI_RM200_INT_ENA_REG = 0x1f;
 
+	sni_rm200_i8259_irqs();
 	mips_cpu_irq_init();
 	/* Actually we've got more interrupts to handle ...  */
 	for (i = SNI_RM200_INT_START; i <= SNI_RM200_INT_END; i++)
 		set_irq_chip(i, &rm200_irq_type);
 	sni_hwint = sni_rm200_hwint;
 	change_c0_status(ST0_IM, IE_IRQ0);
-	setup_irq(SNI_RM200_INT_START + 0, &sni_isa_irq);
+	setup_irq(SNI_RM200_INT_START + 0, &sni_rm200_i8259A_irq);
+	setup_irq(SNI_RM200_INT_START + 1, &sni_isa_irq);
 }
 
 void __init sni_rm200_init(void)
 {
-	set_io_port_base(SNI_PORT_BASE + 0x02000000);
-	ioport_resource.end += 0x02000000;
 }
