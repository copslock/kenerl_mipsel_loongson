Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Mar 2011 22:21:00 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:47494 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491933Ab1CWVJS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Mar 2011 22:09:18 +0100
Received: from localhost ([127.0.0.1] helo=localhost6.localdomain6)
        by Galois.linutronix.de with esmtp (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1Q2VIm-0001wu-Ea; Wed, 23 Mar 2011 22:09:12 +0100
Message-Id: <20110323210537.501650586@linutronix.de>
User-Agent: quilt/0.48-1
Date:   Wed, 23 Mar 2011 21:09:12 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>
Subject: [patch 31/38] mips: sgi-ip27: Convert to new irq_chip functions
References: <20110323210437.398062704@linutronix.de>
Content-Disposition: inline; filename=mips-sgi-ip27.patch
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29460
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/mips/sgi-ip27/ip27-irq.c   |   38 ++++++++++++++++++--------------------
 arch/mips/sgi-ip27/ip27-timer.c |   11 ++++-------
 2 files changed, 22 insertions(+), 27 deletions(-)

Index: linux-mips-next/arch/mips/sgi-ip27/ip27-irq.c
===================================================================
--- linux-mips-next.orig/arch/mips/sgi-ip27/ip27-irq.c
+++ linux-mips-next/arch/mips/sgi-ip27/ip27-irq.c
@@ -240,7 +240,7 @@ static int intr_disconnect_level(int cpu
 }
 
 /* Startup one of the (PCI ...) IRQs routes over a bridge.  */
-static unsigned int startup_bridge_irq(unsigned int irq)
+static unsigned int startup_bridge_irq(struct irq_data *d)
 {
 	struct bridge_controller *bc;
 	bridgereg_t device;
@@ -248,16 +248,16 @@ static unsigned int startup_bridge_irq(u
 	int pin, swlevel;
 	cpuid_t cpu;
 
-	pin = SLOT_FROM_PCI_IRQ(irq);
-	bc = IRQ_TO_BRIDGE(irq);
+	pin = SLOT_FROM_PCI_IRQ(d->irq);
+	bc = IRQ_TO_BRIDGE(d->irq);
 	bridge = bc->base;
 
-	pr_debug("bridge_startup(): irq= 0x%x  pin=%d\n", irq, pin);
+	pr_debug("bridge_startup(): irq= 0x%x  pin=%d\n", d->irq, pin);
 	/*
 	 * "map" irq to a swlevel greater than 6 since the first 6 bits
 	 * of INT_PEND0 are taken
 	 */
-	swlevel = find_level(&cpu, irq);
+	swlevel = find_level(&cpu, d->irq);
 	bridge->b_int_addr[pin].addr = (0x20000 | swlevel | (bc->nasid << 8));
 	bridge->b_int_enable |= (1 << pin);
 	bridge->b_int_enable |= 0x7ffffe00;	/* more stuff in int_enable */
@@ -288,53 +288,51 @@ static unsigned int startup_bridge_irq(u
 }
 
 /* Shutdown one of the (PCI ...) IRQs routes over a bridge.  */
-static void shutdown_bridge_irq(unsigned int irq)
+static void shutdown_bridge_irq(struct irq_data *d)
 {
-	struct bridge_controller *bc = IRQ_TO_BRIDGE(irq);
+	struct bridge_controller *bc = IRQ_TO_BRIDGE(d->irq);
 	bridge_t *bridge = bc->base;
 	int pin, swlevel;
 	cpuid_t cpu;
 
-	pr_debug("bridge_shutdown: irq 0x%x\n", irq);
-	pin = SLOT_FROM_PCI_IRQ(irq);
+	pr_debug("bridge_shutdown: irq 0x%x\n", d->irq);
+	pin = SLOT_FROM_PCI_IRQ(d->irq);
 
 	/*
 	 * map irq to a swlevel greater than 6 since the first 6 bits
 	 * of INT_PEND0 are taken
 	 */
-	swlevel = find_level(&cpu, irq);
+	swlevel = find_level(&cpu, d->irq);
 	intr_disconnect_level(cpu, swlevel);
 
 	bridge->b_int_enable &= ~(1 << pin);
 	bridge->b_wid_tflush;
 }
 
-static inline void enable_bridge_irq(unsigned int irq)
+static inline void enable_bridge_irq(struct irq_data *d)
 {
 	cpuid_t cpu;
 	int swlevel;
 
-	swlevel = find_level(&cpu, irq);	/* Criminal offence */
+	swlevel = find_level(&cpu, d->irq);	/* Criminal offence */
 	intr_connect_level(cpu, swlevel);
 }
 
-static inline void disable_bridge_irq(unsigned int irq)
+static inline void disable_bridge_irq(struct irq_data *d)
 {
 	cpuid_t cpu;
 	int swlevel;
 
-	swlevel = find_level(&cpu, irq);	/* Criminal offence */
+	swlevel = find_level(&cpu, d->irq);	/* Criminal offence */
 	intr_disconnect_level(cpu, swlevel);
 }
 
 static struct irq_chip bridge_irq_type = {
 	.name		= "bridge",
-	.startup	= startup_bridge_irq,
-	.shutdown	= shutdown_bridge_irq,
-	.ack		= disable_bridge_irq,
-	.mask		= disable_bridge_irq,
-	.mask_ack	= disable_bridge_irq,
-	.unmask		= enable_bridge_irq,
+	.irq_startup	= startup_bridge_irq,
+	.irq_shutdown	= shutdown_bridge_irq,
+	.irq_mask	= disable_bridge_irq,
+	.irq_unmask	= enable_bridge_irq,
 };
 
 void __devinit register_bridge_irq(unsigned int irq)
Index: linux-mips-next/arch/mips/sgi-ip27/ip27-timer.c
===================================================================
--- linux-mips-next.orig/arch/mips/sgi-ip27/ip27-timer.c
+++ linux-mips-next/arch/mips/sgi-ip27/ip27-timer.c
@@ -36,21 +36,18 @@
 #include <asm/sn/sn0/hubio.h>
 #include <asm/pci/bridge.h>
 
-static void enable_rt_irq(unsigned int irq)
+static void enable_rt_irq(struct irq_data *d)
 {
 }
 
-static void disable_rt_irq(unsigned int irq)
+static void disable_rt_irq(struct irq_data *d)
 {
 }
 
 static struct irq_chip rt_irq_type = {
 	.name		= "SN HUB RT timer",
-	.ack		= disable_rt_irq,
-	.mask		= disable_rt_irq,
-	.mask_ack	= disable_rt_irq,
-	.unmask		= enable_rt_irq,
-	.eoi		= enable_rt_irq,
+	.irq_mask	= disable_rt_irq,
+	.irq_unmask	= enable_rt_irq,
 };
 
 static int rt_next_event(unsigned long delta, struct clock_event_device *evt)
