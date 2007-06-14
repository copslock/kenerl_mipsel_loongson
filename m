Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jun 2007 22:55:10 +0100 (BST)
Received: from mother.pmc-sierra.com ([216.241.224.12]:47262 "HELO
	mother.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20022939AbXFNVzF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 14 Jun 2007 22:55:05 +0100
Received: (qmail 15152 invoked by uid 101); 14 Jun 2007 21:54:49 -0000
Received: from unknown (HELO pmxedge1.pmc-sierra.bc.ca) (216.241.226.183)
  by mother.pmc-sierra.com with SMTP; 14 Jun 2007 21:54:49 -0000
Received: from pasqua.pmc-sierra.bc.ca (pasqua.pmc-sierra.bc.ca [134.87.183.161])
	by pmxedge1.pmc-sierra.bc.ca (8.13.4/8.12.7) with ESMTP id l5ELsmm8003333;
	Thu, 14 Jun 2007 14:54:48 -0700
From:	Marc St-Jean <stjeanma@pmc-sierra.com>
Received: (from stjeanma@localhost)
	by pasqua.pmc-sierra.bc.ca (8.13.4/8.12.11) id l5ELslhw021385;
	Thu, 14 Jun 2007 15:54:47 -0600
Date:	Thu, 14 Jun 2007 15:54:47 -0600
Message-Id: <200706142154.l5ELslhw021385@pasqua.pmc-sierra.bc.ca>
To:	ralf@linux-mips.org
Subject: [PATCH 1/12] mips: PMC MSP71xx core platform
Cc:	linux-mips@linux-mips.org
Return-Path: <stjeanma@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15408
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stjeanma@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

[PATCH 1/12] mips: PMC MSP71xx core platform

Patch to add core platform support for the PMC-Sierra
MSP71xx devices.

Thanks,
Marc

Signed-off-by: Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
---
Re-posting patch as requested by Ralf. Changes since last post:
-Minor cleanups as recommended by checkpatch.pl.

 arch/mips/pmc-sierra/msp71xx/Makefile             |   11 
 arch/mips/pmc-sierra/msp71xx/msp_elb.c            |   46 +
 arch/mips/pmc-sierra/msp71xx/msp_hwbutton.c       |  179 +++++
 arch/mips/pmc-sierra/msp71xx/msp_irq.c            |  124 ++++
 arch/mips/pmc-sierra/msp71xx/msp_irq_cic.c        |  134 ++++
 arch/mips/pmc-sierra/msp71xx/msp_irq_slp.c        |  109 +++
 arch/mips/pmc-sierra/msp71xx/msp_prom.c           |  566 ++++++++++++++++++
 arch/mips/pmc-sierra/msp71xx/msp_setup.c          |  260 ++++++++
 arch/mips/pmc-sierra/msp71xx/msp_time.c           |   94 +++
 arch/mips/pmc-sierra/msp71xx/msp_usb.c            |  150 ++++
 include/asm-mips/pmc-sierra/msp71xx/msp_cic_int.h |  151 ++++
 include/asm-mips/pmc-sierra/msp71xx/msp_int.h     |   43 +
 include/asm-mips/pmc-sierra/msp71xx/msp_prom.h    |  176 +++++
 include/asm-mips/pmc-sierra/msp71xx/msp_regops.h  |  236 +++++++
 include/asm-mips/pmc-sierra/msp71xx/msp_regs.h    |  667 ++++++++++++++++++++++
 include/asm-mips/pmc-sierra/msp71xx/msp_slp_int.h |  141 ++++
 16 files changed, 3087 insertions(+)

diff --git a/arch/mips/pmc-sierra/msp71xx/Makefile b/arch/mips/pmc-sierra/msp71xx/Makefile
new file mode 100644
index 0000000..4bba79c
--- /dev/null
+++ b/arch/mips/pmc-sierra/msp71xx/Makefile
@@ -0,0 +1,11 @@
+#
+# Makefile for the PMC-Sierra MSP SOCs
+#
+obj-y += msp_prom.o msp_setup.o msp_irq.o \
+	 msp_time.o msp_serial.o msp_elb.o
+obj-$(CONFIG_PMC_MSP7120_GW) += msp_hwbutton.o
+obj-$(CONFIG_IRQ_MSP_SLP) += msp_irq_slp.o
+obj-$(CONFIG_IRQ_MSP_CIC) += msp_irq_cic.o
+obj-$(CONFIG_PCI) += msp_pci.o
+obj-$(CONFIG_MSPETH) += msp_eth.o
+obj-$(CONFIG_USB_MSP71XX) += msp_usb.o
diff --git a/arch/mips/pmc-sierra/msp71xx/msp_elb.c b/arch/mips/pmc-sierra/msp71xx/msp_elb.c
new file mode 100644
index 0000000..3e96410
--- /dev/null
+++ b/arch/mips/pmc-sierra/msp71xx/msp_elb.c
@@ -0,0 +1,46 @@
+/*
+ * Sets up the proper Chip Select configuration registers.  It is assumed that
+ * PMON sets up the ADDR and MASK registers properly.
+ *
+ * Copyright 2005-2006 PMC-Sierra, Inc.
+ * Author: Marc St-Jean, Marc_St-Jean@pmc-sierra.com
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <msp_regs.h>
+
+static int __init msp_elb_setup(void)
+{
+#if defined(CONFIG_PMC_MSP7120_GW) \
+ || defined(CONFIG_PMC_MSP7120_EVAL)
+	/*
+	 * Force all CNFG to be identical and equal to CS0,
+	 * according to OPS doc
+	 */
+	*CS1_CNFG_REG = *CS2_CNFG_REG = *CS3_CNFG_REG = *CS0_CNFG_REG;
+#endif
+	return 0;
+}
+
+subsys_initcall(msp_elb_setup);
diff --git a/arch/mips/pmc-sierra/msp71xx/msp_hwbutton.c b/arch/mips/pmc-sierra/msp71xx/msp_hwbutton.c
new file mode 100644
index 0000000..72c3ed4
--- /dev/null
+++ b/arch/mips/pmc-sierra/msp71xx/msp_hwbutton.c
@@ -0,0 +1,179 @@
+/*
+ * Sets up interrupt handlers for various hardware switches which are
+ * connected to interrupt lines.
+ *
+ * Copyright 2005-2207 PMC-Sierra, Inc.
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+
+#include <msp_int.h>
+#include <msp_regs.h>
+#include <msp_regops.h>
+#ifdef CONFIG_PMCTWILED
+#include <msp_led_macros.h>
+#endif
+
+/* For hwbutton_interrupt->initial_state */
+#define HWBUTTON_HI	0x1
+#define HWBUTTON_LO	0x2
+
+/*
+ * This struct describes a hardware button
+ */
+struct hwbutton_interrupt {
+	char *name;			/* Name of button */
+	int irq;			/* Actual LINUX IRQ */
+	int eirq;			/* Extended IRQ number (0-7) */
+	int initial_state;		/* The "normal" state of the switch */
+	void (*handle_hi)(void *);	/* Handler: switch input has gone HI */
+	void (*handle_lo)(void *);	/* Handler: switch input has gone LO */
+	void *data;			/* Optional data to pass to handler */
+};
+
+#ifdef CONFIG_PMC_MSP7120_GW
+extern void msp_restart(char *);
+
+static void softreset_push(void *data)
+{
+	printk(KERN_WARNING "SOFTRESET switch was pushed\n");
+
+	/*
+	 * In the future you could move this to the release handler,
+	 * timing the difference between the 'push' and 'release', and only
+	 * doing this ungraceful restart if the button has been down for
+	 * a certain amount of time; otherwise doing a graceful restart.
+	 */
+
+	msp_restart(NULL);
+}
+
+static void softreset_release(void *data)
+{
+	printk(KERN_WARNING "SOFTRESET switch was released\n");
+
+	/* Do nothing */
+}
+
+static void standby_on(void *data)
+{
+	printk(KERN_WARNING "STANDBY switch was set to ON (not implemented)\n");
+
+	/* TODO: Put board in standby mode */
+#ifdef CONFIG_PMCTWILED
+	msp_led_turn_off(MSP_LED_PWRSTANDBY_GREEN);
+	msp_led_turn_on(MSP_LED_PWRSTANDBY_RED);
+#endif
+}
+
+static void standby_off(void *data)
+{
+	printk(KERN_WARNING
+		"STANDBY switch was set to OFF (not implemented)\n");
+
+	/* TODO: Take out of standby mode */
+#ifdef CONFIG_PMCTWILED
+	msp_led_turn_on(MSP_LED_PWRSTANDBY_GREEN);
+	msp_led_turn_off(MSP_LED_PWRSTANDBY_RED);
+#endif
+}
+
+static struct hwbutton_interrupt softreset_sw = {
+	.name = "Softreset button",
+	.irq = MSP_INT_EXT0,
+	.eirq = 0,
+	.initial_state = HWBUTTON_HI,
+	.handle_hi = softreset_release,
+	.handle_lo = softreset_push,
+	.data = NULL,
+};
+
+static struct hwbutton_interrupt standby_sw = {
+	.name = "Standby switch",
+	.irq = MSP_INT_EXT1,
+	.eirq = 1,
+	.initial_state = HWBUTTON_HI,
+	.handle_hi = standby_off,
+	.handle_lo = standby_on,
+	.data = NULL,
+};
+#endif /* CONFIG_PMC_MSP7120_GW */
+
+static irqreturn_t hwbutton_handler(int irq, void *data)
+{
+	struct hwbutton_interrupt *hirq = data;
+	unsigned long cic_ext = *CIC_EXT_CFG_REG;
+
+	if (irq != hirq->irq)
+		return IRQ_NONE;
+
+	if (CIC_EXT_IS_ACTIVE_HI(cic_ext, hirq->eirq)) {
+		/* Interrupt: pin is now HI */
+		CIC_EXT_SET_ACTIVE_LO(cic_ext, hirq->eirq);
+		hirq->handle_hi(hirq->data);
+	} else {
+		/* Interrupt: pin is now LO */
+		CIC_EXT_SET_ACTIVE_HI(cic_ext, hirq->eirq);
+		hirq->handle_lo(hirq->data);
+	}
+
+	/*
+	 * Invert the POLARITY of this level interrupt to ack the interrupt
+	 * Thus next state change will invoke the opposite message
+	 */
+	*CIC_EXT_CFG_REG = cic_ext;
+
+	return IRQ_HANDLED;
+}
+
+static int msp_hwbutton_register(struct hwbutton_interrupt *hirq)
+{
+	unsigned long cic_ext;
+
+	if (hirq->handle_hi == NULL || hirq->handle_lo == NULL)
+		return -EINVAL;
+       
+	cic_ext = *CIC_EXT_CFG_REG;
+	CIC_EXT_SET_TRIGGER_LEVEL(cic_ext, hirq->eirq);
+	if (hirq->initial_state == HWBUTTON_HI)
+		CIC_EXT_SET_ACTIVE_LO(cic_ext, hirq->eirq);
+	else
+		CIC_EXT_SET_ACTIVE_HI(cic_ext, hirq->eirq);
+	*CIC_EXT_CFG_REG = cic_ext;
+
+	return request_irq(hirq->irq, hwbutton_handler, SA_INTERRUPT,
+				hirq->name, (void *)hirq);
+}
+
+static int __init msp_hwbutton_setup(void)
+{
+#ifdef CONFIG_PMC_MSP7120_GW
+	msp_hwbutton_register(&softreset_sw);
+	msp_hwbutton_register(&standby_sw);
+#endif
+	return 0;
+}
+
+subsys_initcall(msp_hwbutton_setup);
diff --git a/arch/mips/pmc-sierra/msp71xx/msp_irq.c b/arch/mips/pmc-sierra/msp71xx/msp_irq.c
new file mode 100644
index 0000000..b2cb5d3
--- /dev/null
+++ b/arch/mips/pmc-sierra/msp71xx/msp_irq.c
@@ -0,0 +1,124 @@
+/*
+ * IRQ vector handles
+ *
+ * Copyright (C) 1995, 1996, 1997, 2003 by Ralf Baechle
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/ptrace.h>
+#include <lnux/time.h>
+
+#include <asm/irq_cpu.h>
+
+#include <msp_int.h>
+
+extern void msp_int_handle(void);
+
+/* SLP bases systems */
+extern void msp_slp_irq_init(void);
+extern void msp_slp_irq_dispatch(void);
+
+/* CIC based systems */
+extern void msp_cic_irq_init(void);
+extern void msp_cic_irq_dispatch(void);
+
+/*
+ * The PMC-Sierra MSP interrupts are arranged in a 3 level cascaded
+ * hierarchical system.  The first level are the direct MIPS interrupts
+ * and are assigned the interrupt range 0-7.  The second level is the SLM
+ * interrupt controller and is assigned the range 8-39.  The third level
+ * comprises the Peripherial block, the PCI block, the PCI MSI block and
+ * the SLP.  The PCI interrupts and the SLP errors are handled by the
+ * relevant subsystems so the core interrupt code needs only concern
+ * itself with the Peripheral block.  These are assigned interrupts in
+ * the range 40-71.
+ */
+
+asmlinkage void plat_irq_dispatch(struct pt_regs *regs)
+{
+	u32 pending;
+
+	pending = read_c0_status() & read_c0_cause();
+	
+	/*
+	 * jump to the correct interrupt routine
+	 * These are arranged in priority order and the timer
+	 * comes first!
+	 */
+
+#ifdef CONFIG_IRQ_MSP_CIC	/* break out the CIC stuff for now */
+	if (pending & C_IRQ4)	/* do the peripherals first, that's the timer */
+		msp_cic_irq_dispatch();
+		
+	else if (pending & C_IRQ0)
+		do_IRQ(MSP_INT_MAC0);
+		
+	else if (pending & C_IRQ1)
+		do_IRQ(MSP_INT_MAC1);
+
+	else if (pending & C_IRQ2)
+		do_IRQ(MSP_INT_USB);
+	
+	else if (pending & C_IRQ3)
+		do_IRQ(MSP_INT_SAR);
+
+	else if (pending & C_IRQ5)
+		do_IRQ(MSP_INT_SEC);
+
+#else
+	if (pending & C_IRQ5)
+		do_IRQ(MSP_INT_TIMER);
+	
+	else if (pending & C_IRQ0)
+		do_IRQ(MSP_INT_MAC0);
+
+	else if (pending & C_IRQ1)
+		do_IRQ(MSP_INT_MAC1);
+	
+	else if (pending & C_IRQ3)
+		do_IRQ(MSP_INT_VE);
+
+	else if (pending & C_IRQ4)
+		msp_slp_irq_dispatch();
+#endif
+
+	else if (pending & C_SW0)	/* do software after hardware */
+		do_IRQ(MSP_INT_SW0);
+
+	else if (pending & C_SW1)
+		do_IRQ(MSP_INT_SW1);
+}
+
+static struct irqaction cascade_msp = {
+	.handler = no_action,
+	.name	 = "MSP cascade"
+};
+
+
+void __init arch_init_irq(void)
+{
+	/* initialize the 1st-level CPU based interrupt controller */
+	mips_cpu_irq_init();
+
+#ifdef CONFIG_IRQ_MSP_CIC
+	msp_cic_irq_init();
+
+	/* setup the cascaded interrupts */
+	setup_irq(MSP_INT_CIC, &cascade_msp);
+	setup_irq(MSP_INT_PER, &cascade_msp);
+#else
+	/* setup the 2nd-level SLP register based interrupt controller */
+	msp_slp_irq_init();
+
+	/* setup the cascaded SLP/PER interrupts */
+	setup_irq(MSP_INT_SLP, &cascade_msp);
+	setup_irq(MSP_INT_PER, &cascade_msp);
+#endif
+}
diff --git a/arch/mips/pmc-sierra/msp71xx/msp_irq_cic.c b/arch/mips/pmc-sierra/msp71xx/msp_irq_cic.c
new file mode 100644
index 0000000..63abb93
--- /dev/null
+++ b/arch/mips/pmc-sierra/msp71xx/msp_irq_cic.c
@@ -0,0 +1,134 @@
+/*
+ * This file define the irq handler for MSP SLM subsystem interrupts.
+ *
+ * Copyright 2005-2007 PMC-Sierra, Inc, derived from irq_cpu.c
+ * Author: Andrew Hughes, Andrew_Hughes@pmc-sierra.com
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/bitops.h>
+
+#include <asm/system.h>
+
+#include <msp_cic_int.h>
+#include <msp_regs.h>
+
+/*
+ * NOTE: We are only enabling support for VPE0 right now.
+ */
+
+static inline void unmask_msp_cic_irq(unsigned int irq)
+{
+
+	/* check for PER interrupt range */
+	if (irq < MSP_PER_INTBASE)
+		*CIC_VPE0_MSK_REG |= (1 << (irq - MSP_CIC_INTBASE));
+	else
+		*PER_INT_MSK_REG |= (1 << (irq - MSP_PER_INTBASE));
+}
+
+static inline void mask_msp_cic_irq(unsigned int irq)
+{
+	/* check for PER interrupt range */
+	if (irq < MSP_PER_INTBASE)
+		*CIC_VPE0_MSK_REG &= ~(1 << (irq - MSP_CIC_INTBASE));
+	else
+		*PER_INT_MSK_REG &= ~(1 << (irq - MSP_PER_INTBASE));
+}
+
+/*
+ * While we ack the interrupt interrupts are disabled and thus we don't need
+ * to deal with concurrency issues.  Same for msp_cic_irq_end.
+ */
+static inline void ack_msp_cic_irq(unsigned int irq)
+{
+	mask_msp_cic_irq(irq);
+
+	/*
+	 * only really necessary for 18, 16-14 and sometimes 3:0 (since
+	 * these can be edge sensitive) but it doesn't hurt for the others.
+	 */
+
+	/* check for PER interrupt range */
+	if (irq < MSP_PER_INTBASE)
+		*CIC_STS_REG = (1 << (irq - MSP_CIC_INTBASE));
+	else
+		*PER_INT_STS_REG = (1 << (irq - MSP_PER_INTBASE));
+}
+
+static struct irq_chip msp_cic_irq_controller = {
+	.name = "MSP_CIC",
+	.ack = ack_msp_cic_irq,
+	.mask = ack_msp_cic_irq,
+	.mask_ack = ack_msp_cic_irq,
+	.unmask = unmask_msp_cic_irq,
+};
+
+
+void __init msp_cic_irq_init(void)
+{
+	int i;
+
+	/* Mask/clear interrupts. */
+	*CIC_VPE0_MSK_REG = 0x00000000;
+	*PER_INT_MSK_REG  = 0x00000000;
+	*CIC_STS_REG      = 0xFFFFFFFF;
+	*PER_INT_STS_REG  = 0xFFFFFFFF;
+ 
+#if defined(CONFIG_PMC_MSP7120_GW) || \
+    defined(CONFIG_PMC_MSP7120_EVAL)
+	/*
+	 * The MSP7120 RG and EVBD boards use IRQ[6:4] for PCI.
+	 * These inputs map to EXT_INT_POL[6:4] inside the CIC.
+	 * They are to be active low, level sensitive.
+	 */
+	*CIC_EXT_CFG_REG &= 0xFFFF8F8F;
+#endif
+
+	/* initialize all the IRQ descriptors */
+	for (i = MSP_CIC_INTBASE; i < MSP_PER_INTBASE + 32; i++)
+		set_irq_chip_and_handler(i, &msp_cic_irq_controller,
+					 handle_level_irq);
+}
+
+void msp_cic_irq_dispatch(void)
+{
+	u32 pending;
+	int intbase;
+
+	intbase = MSP_CIC_INTBASE;
+	pending = *CIC_STS_REG & *CIC_VPE0_MSK_REG;
+
+	/* check for PER interrupt */
+	if (pending == (1 << (MSP_INT_PER - MSP_CIC_INTBASE))) {
+		intbase = MSP_PER_INTBASE;
+		pending = *PER_INT_STS_REG & *PER_INT_MSK_REG;
+	}
+
+	/* check for spurious interrupt */
+	if (pending == 0x00000000) {
+		printk(KERN_ERR
+			"Spurious %s interrupt? status %08x, mask %08x\n",
+			(intbase == MSP_CIC_INTBASE) ? "CIC" : "PER",
+			(intbase == MSP_CIC_INTBASE) ?
+				*CIC_STS_REG : *PER_INT_STS_REG,
+			(intbase == MSP_CIC_INTBASE) ?
+				*CIC_VPE0_MSK_REG : *PER_INT_MSK_REG);
+		return;
+	}
+
+	/* check for the timer and dispatch it first */
+	if ((intbase == MSP_CIC_INTBASE) &&
+	    (pending & (1 << (MSP_INT_VPE0_TIMER - MSP_CIC_INTBASE))))
+		do_IRQ(MSP_INT_VPE0_TIMER);
+	else
+		do_IRQ(ffs(pending) + intbase - 1);
+}
+
diff --git a/arch/mips/pmc-sierra/msp71xx/msp_irq_slp.c b/arch/mips/pmc-sierra/msp71xx/msp_irq_slp.c
new file mode 100644
index 0000000..c6cc6ea
--- /dev/null
+++ b/arch/mips/pmc-sierra/msp71xx/msp_irq_slp.c
@@ -0,0 +1,109 @@
+/*
+ * This file define the irq handler for MSP SLM subsystem interrupts.
+ *
+ * Copyright 2005-2006 PMC-Sierra, Inc, derived from irq_cpu.c
+ * Author: Andrew Hughes, Andrew_Hughes@pmc-sierra.com
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+ 
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/bitops.h>
+
+#include <asm/mipsregs.h>
+#include <asm/system.h>
+
+#include <msp_slp_int.h>
+#include <msp_regs.h>
+
+static inline void unmask_msp_slp_irq(unsigned int irq)
+{
+	/* check for PER interrupt range */
+	if (irq < MSP_PER_INTBASE)
+		*SLP_INT_MSK_REG |= (1 << (irq - MSP_SLP_INTBASE));
+	else
+		*PER_INT_MSK_REG |= (1 << (irq - MSP_PER_INTBASE));
+}
+
+static inline void mask_msp_slp_irq(unsigned int irq)
+{
+	/* check for PER interrupt range */
+	if (irq < MSP_PER_INTBASE)
+		*SLP_INT_MSK_REG &= ~(1 << (irq - MSP_SLP_INTBASE));
+	else
+		*PER_INT_MSK_REG &= ~(1 << (irq - MSP_PER_INTBASE));
+}
+
+/*
+ * While we ack the interrupt interrupts are disabled and thus we don't need
+ * to deal with concurrency issues.  Same for msp_slp_irq_end.
+ */
+static inline void ack_msp_slp_irq(unsigned int irq)
+{
+	mask_slp_irq(irq);
+
+	/*
+	 * only really necessary for 18, 16-14 and sometimes 3:0 (since
+	 * these can be edge sensitive) but it doesn't hurt  for the others.
+	 */
+
+	/* check for PER interrupt range */
+	if (irq < MSP_PER_INTBASE)
+		*SLP_INT_STS_REG = (1 << (irq - MSP_SLP_INTBASE));
+	else
+		*PER_INT_STS_REG = (1 << (irq - MSP_PER_INTBASE));
+}
+
+static struct irq_chip msp_slp_irq_controller = {
+	.name = "MSP_SLP",
+	.ack = ack_msp_slp_irq,
+	.mask = ack_msp_slp_irq,
+	.mask_ack = ack_msp_slp_irq,
+	.unmask = unmask_msp_slp_irq,
+};
+
+void __init msp_slp_irq_init(void)
+{
+	int i;
+
+	/* Mask/clear interrupts. */
+	*SLP_INT_MSK_REG = 0x00000000;
+	*PER_INT_MSK_REG = 0x00000000;
+	*SLP_INT_STS_REG = 0xFFFFFFFF;
+	*PER_INT_STS_REG = 0xFFFFFFFF;
+
+	/* initialize all the IRQ descriptors */
+	for (i = MSP_SLP_INTBASE; i < MSP_PER_INTBASE + 32; i++)
+		set_irq_chip_and_handler(i, &msp_slp_irq_controller
+					 handle_level_irq);
+}
+
+void msp_slp_irq_dispatch(void)
+{
+	u32 pending;
+	int intbase;
+
+	intbase = MSP_SLP_INTBASE;
+	pending = *SLP_INT_STS_REG & *SLP_INT_MSK_REG;
+
+	/* check for PER interrupt */
+	if (pending == (1 << (MSP_INT_PER - MSP_SLP_INTBASE))) {
+		intbase = MSP_PER_INTBASE;
+		pending = *PER_INT_STS_REG & *PER_INT_MSK_REG;
+	}
+
+	/* check for spurious interrupt */
+	if (pending == 0x00000000) {
+		printk(KERN_ERR "Spurious %s interrupt?\n",
+			(intbase == MSP_SLP_INTBASE) ? "SLP" : "PER");
+		return;
+	}
+
+	/* dispatch the irq */
+	do_IRQ(ffs(pending) + intbase - 1);
+}
diff --git a/arch/mips/pmc-sierra/msp71xx/msp_prom.c b/arch/mips/pmc-sierra/msp71xx/msp_prom.c
new file mode 100644
index 0000000..3887d9e
--- /dev/null
+++ b/arch/mips/pmc-sierra/msp71xx/msp_prom.c
@@ -0,0 +1,566 @@
+/*
+ * BRIEF MODULE DESCRIPTION
+ *    PROM library initialisation code, assuming a version of
+ *    pmon is the boot code.
+ *
+ * Copyright 2000,2001 MontaVista Software Inc.
+ * Author: MontaVista Software, Inc.
+ *         	ppopov@mvista.com or source@mvista.com
+ *
+ * This file was derived from Carsten Langgaard's
+ * arch/mips/mips-boards/xx files.
+ *
+ * Carsten Langgaard, carstenl@mips.com
+ * Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/string.h>
+#include <linux/interrupt.h>
+#include <linux/mm.h>
+#ifdef CONFIG_CRAMFS
+#include <linux/cramfs_fs.h>
+#endif
+#ifdef CONFIG_SQUASHFS
+#include <linux/squashfs_fs.h>
+#endif
+
+#include <asm/addrspace.h>
+#include <asm/bootinfo.h>
+#include <asm-generic/sections.h>
+#include <asm/page.h>
+
+#include <msp_prom.h>
+#include <msp_regs.h>
+
+/* global PROM environment variables and pointers */
+int prom_argc;
+char **prom_argv, **prom_envp;
+int *prom_vec;
+
+/* debug flag */
+int init_debug = 1;
+
+/* memory blocks */
+struct prom_pmemblock mdesc[PROM_MAX_PMEMBLOCKS];
+
+/* default feature sets */
+static char msp_default_features[] =
+#if defined(CONFIG_PMC_MSP4200_EVAL) \
+ || defined(CONFIG_PMC_MSP4200_GW)
+	"ERER";
+#elif defined(CONFIG_PMC_MSP7120_EVAL) \
+ || defined(CONFIG_PMC_MSP7120_GW)
+	"EMEMSP";
+#elif defined(CONFIG_PMC_MSP7120_FPGA)
+	"EMEM";
+#endif
+
+/* conversion functions */
+static inline unsigned char str2hexnum(unsigned char c)
+{
+	if (c >= '0' && c <= '9')
+		return c - '0';
+	if (c >= 'a' && c <= 'f')
+		return c - 'a' + 10;
+	return 0; /* foo */
+}
+
+static inline int str2eaddr(unsigned char *ea, unsigned char *str)
+{
+	int index = 0;
+	unsigned char num = 0;
+
+	while (*str != '\0') {
+		if ((*str == '.') || (*str == ':')) {
+			ea[index++] = num;
+			num = 0;
+			str++;
+		} else {
+			num = num << 4;
+			num |= str2hexnum(*str++);
+		}
+	}
+
+	if (index == 5)	{
+		ea[index++] = num;
+		return 0;
+	} else
+		return -1;
+}
+EXPORT_SYMBOL(str2eaddr);
+
+static inline unsigned long str2hex(unsigned char *str)
+{
+	int value = 0;
+
+	while (*str) {
+		value = value << 4;
+		value |= str2hexnum(*str++);
+	}
+
+	return value;
+}
+
+/* function to query the system information */
+const char *get_system_type(void)
+{
+#if defined(CONFIG_PMC_MSP4200_EVAL)
+	return "PMC-Sierra MSP4200 Eval Board";
+#elif defined(CONFIG_PMC_MSP4200_GW)
+	return "PMC-Sierra MSP4200 VoIP Gateway";
+#elif defined(CONFIG_PMC_MSP7120_EVAL)
+	return "PMC-Sierra MSP7120 Eval Board";
+#elif defined(CONFIG_PMC_MSP7120_GW)
+	return "PMC-Sierra MSP7120 Residential Gateway";
+#elif defined(CONFIG_PMC_MSP7120_FPGA)
+	return "PMC-Sierra MSP7120 FPGA";
+#else
+	#error "What is the type of *your* MSP?"
+#endif
+}
+
+int get_ethernet_addr(char *ethaddr_name, char *ethernet_addr)
+{
+	char *ethaddr_str;
+
+	ethaddr_str = prom_getenv(ethaddr_name);
+	if (!ethaddr_str) {
+		printk(KERN_WARNING "%s not set in boot prom\n", ethaddr_name);
+		return -1;
+	}
+		
+	if (str2eaddr(ethernet_addr, ethaddr_str) == -1) {
+		printk(KERN_WARNING "%s badly formatted-<%s>\n",
+			ethaddr_name, ethaddr_str);
+		return -1;
+	}
+
+	if (init_debug > 1) {
+		int i;
+		printk(KERN_DEBUG "get_ethernet_addr: for %s ", ethaddr_name);
+		for (i = 0; i < 5; i++)
+			printk(KERN_DEBUG "%02x:",
+				(unsigned char)*(ethernet_addr+i));
+		printk(KERN_DEBUG "%02x\n", *(ethernet_addr+i));
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(get_ethernet_addr);
+
+static char *get_features(void)
+{
+	char *feature = prom_getenv(FEATURES);
+
+	if (feature == NULL) {
+		/* default features based on MACHINE_TYPE */
+		feature = msp_default_features;
+	}
+
+	return feature;
+}
+
+static char test_feature(char c)
+{
+	char *feature = get_features();
+
+	while (*feature) {
+		if (*feature++ == c)
+			return *feature;
+		feature++;
+	}
+
+	return FEATURE_NOEXIST;
+}
+
+unsigned long get_deviceid(void)
+{
+	char *deviceid = prom_getenv(DEVICEID);
+
+	if (deviceid == NULL)
+		return *DEV_ID_REG;
+	else
+		return str2hex(deviceid);
+}
+
+char identify_pci(void)
+{
+	return test_feature(PCI_KEY);
+}
+EXPORT_SYMBOL(identify_pci);
+
+char identify_pcimux(void)
+{
+	return test_feature(PCIMUX_KEY);
+}
+
+char identify_sec(void)
+{
+	return test_feature(SEC_KEY);
+}
+EXPORT_SYMBOL(identify_sec);
+
+char identify_spad(void)
+{
+	return test_feature(SPAD_KEY);
+}
+EXPORT_SYMBOL(identify_spad);
+
+char identify_tdm(void)
+{
+	return test_feature(TDM_KEY);
+}
+EXPORT_SYMBOL(identify_tdm);
+
+char identify_zsp(void)
+{
+	return test_feature(ZSP_KEY);
+}
+EXPORT_SYMBOL(identify_zsp);
+
+static char identify_enetfeature(char key, unsigned long interface_num)
+{
+	char *feature = get_features();
+
+	while (*feature) {
+		if (*feature++ == key && interface_num-- == 0)
+			return *feature;
+		feature++;
+	}
+
+	return FEATURE_NOEXIST;
+}
+
+char identify_enet(unsigned long interface_num)
+{
+	return identify_enetfeature(ENET_KEY, interface_num);
+}
+EXPORT_SYMBOL(identify_enet);
+
+char identify_enetTxD(unsigned long interface_num)
+{
+	return identify_enetfeature(ENETTXD_KEY, interface_num);
+}
+EXPORT_SYMBOL(identify_enetTxD);
+
+unsigned long identify_family(void)
+{
+	unsigned long deviceid;
+
+	deviceid = get_deviceid();
+
+	return deviceid & CPU_DEVID_FAMILY;
+}
+EXPORT_SYMBOL(identify_family);
+
+unsigned long identify_revision(void)
+{
+	unsigned long deviceid;
+
+	deviceid = get_deviceid();
+
+	return deviceid & CPU_DEVID_REVISION;
+}
+EXPORT_SYMBOL(identify_revision);
+
+/* PROM environment functions */
+char *prom_getenv(char *env_name)
+{
+	/*
+	 * Return a pointer to the given environment variable.  prom_envp
+	 * points to a null terminated array of pointers to variables.
+	 * Environment variables are stored in the form of "memsize=64"
+	 */
+
+	char **var = prom_envp;
+	int i = strlen(env_name);
+
+	while (*var) {
+		if (strncmp(env_name, *var, i) == 0) {
+			return (*var + strlen(env_name) + 1);
+		}
+		var++;
+	}
+	
+	return NULL;
+}
+
+/* PROM commandline functions */
+char *prom_getcmdline(void)
+{
+	return &(arcs_cmdline[0]);
+}
+EXPORT_SYMBOL(prom_getcmdline);
+
+void  __init prom_init_cmdline(void)
+{
+	char *cp;
+	int actr;
+
+	actr = 1; /* Always ignore argv[0] */
+
+	cp = &(arcs_cmdline[0]);
+	while (actr < prom_argc) {
+		strcpy(cp, prom_argv[actr]);
+		cp += strlen(prom_argv[actr]);
+		*cp++ = ' ';
+		actr++;
+	}
+	if (cp != &(arcs_cmdline[0])) /* get rid of trailing space */
+		--cp;
+	*cp = '\0';
+}
+
+/* memory allocation functions */
+static int __init prom_memtype_classify(unsigned int type)
+{
+	switch (type) {
+	case yamon_free:
+		return BOOT_MEM_RAM;
+	case yamon_prom:
+		return BOOT_MEM_ROM_DATA;
+	default:
+		return BOOT_MEM_RESERVED;
+	}
+}
+
+void __init prom_meminit(void)
+{
+	struct prom_pmemblock *p;
+
+	p = prom_getmdesc();
+
+	while (p->size) {
+		long type;
+		unsigned long base, size;
+
+		type = prom_memtype_classify(p->type);
+		base = p->base;
+		size = p->size;
+
+		add_memory_region(base, size, type);
+		p++;
+	}
+}
+
+void __init prom_free_prom_memory(void)
+{
+	int	argc;
+	char	**argv;
+	char	**envp;
+	char	*ptr;
+	int	len = 0;
+	int	i;
+	unsigned long addr;
+
+	/*
+	 * preserve environment variables and command line from pmon/bbload
+	 * first preserve the command line
+	 */
+	for (argc = 0; argc < prom_argc; argc++) {
+		len += sizeof(char *);			/* length of pointer */
+		len += strlen(prom_argv[argc]) + 1;	/* length of string */
+	}
+	len += sizeof(char *);		/* plus length of null pointer */
+
+	argv = kmalloc(len, GFP_KERNEL);
+	ptr = (char *) &argv[prom_argc + 1];	/* strings follow array */
+
+	for (argc = 0; argc < prom_argc; argc++) {
+		argv[argc] = ptr;
+		strcpy(ptr, prom_argv[argc]);
+		ptr += strlen(prom_argv[argc]) + 1;
+	}
+	argv[prom_argc] = NULL;		/* end array with null pointer */
+	prom_argv = argv;
+
+	/* next preserve the environment variables */
+	len = 0;
+	i = 0;
+	for (envp = prom_envp; *envp != NULL; envp++) {
+		i++;		/* count number of environment variables */
+		len += sizeof(char *);		/* length of pointer */
+		len += strlen(*envp) + 1;	/* length of string */
+	}
+	len += sizeof(char *);		/* plus length of null pointer */
+
+	envp = kmalloc(len, GFP_KERNEL);
+	ptr = (char *) &envp[i+1];
+
+	for (argc = 0; argc < i; argc++) {
+		envp[argc] = ptr;
+		strcpy(ptr, prom_envp[argc]);
+		ptr += strlen(prom_envp[argc]) + 1;
+	}
+	envp[i] = NULL;			/* end array with null pointer */
+	prom_envp = envp;
+
+	for (i = 0; i < boot_mem_map.nr_map; i++) {
+		if (boot_mem_map.map[i].type != BOOT_MEM_ROM_DATA)
+			continue;
+
+		addr = boot_mem_map.map[i].addr;
+		free_init_pages("prom memory",
+				addr, addr + boot_mem_map.map[i].size);
+	}
+}
+
+struct prom_pmemblock *__init prom_getmdesc(void)
+{
+	static char	memsz_env[] __initdata = "memsize";
+	static char	heaptop_env[] __initdata = "heaptop";
+	char		*str;
+	unsigned int	memsize;
+	unsigned int	heaptop;
+#ifdef CONFIG_MTD_PMC_MSP_RAMROOT
+	void		*ramroot_start;
+	unsigned long	ramroot_size;
+#endif
+	int i;
+
+	str = prom_getenv(memsz_env);
+	if (!str) {
+		ppfinit("memsize not set in boot prom, "
+			"set to default (32Mb)\n");
+		memsize = 0x02000000;
+	} else {
+		memsize = simple_strtol(str, NULL, 0);
+
+		if (memsize == 0) {
+			/* if memsize is a bad size, use reasonable default */
+			memsize = 0x02000000;
+		}
+
+		/* convert to physical address (removing caching bits, etc) */
+		memsize = CPHYSADDR(memsize);
+	}
+
+	str = prom_getenv(heaptop_env);
+	if (!str) {
+		heaptop = CPHYSADDR((u32)&_text);
+		ppfinit("heaptop not set in boot prom, "
+			"set to default 0x%08x\n", heaptop);
+	} else {
+		heaptop = simple_strtol(str, NULL, 16);
+		if (heaptop == 0) {
+			/* heaptop conversion bad, might have 0xValue */
+			heaptop = simple_strtol(str, NULL, 0);
+
+			if (heaptop == 0) {
+				/* heaptop still bad, use reasonable default */
+				heaptop = CPHYSADDR((u32)&_text);
+			}
+		}
+
+		/* convert to physical address (removing caching bits, etc) */
+		heaptop = CPHYSADDR((u32)heaptop);
+	}
+
+	/* the base region */
+	i = 0;
+	mdesc[i].type = BOOT_MEM_RESERVED;
+	mdesc[i].base = 0x00000000;
+	mdesc[i].size = PAGE_ALIGN(0x300 + 0x80);
+		/* jtag interrupt vector + sizeof vector */
+
+	/* PMON data */
+	if (heaptop > mdesc[i].base + mdesc[i].size) {
+		i++;			/* 1 */
+		mdesc[i].type = BOOT_MEM_ROM_DATA;
+		mdesc[i].base = mdesc[i-1].base + mdesc[i-1].size;
+		mdesc[i].size = heaptop - mdesc[i].base;
+	}
+
+	/* end of PMON data to start of kernel -- probably zero .. */
+	if (heaptop != CPHYSADDR((u32)_text)) {
+		i++;	/* 2 */
+		mdesc[i].type = BOOT_MEM_RAM;
+		mdesc[i].base = heaptop;
+		mdesc[i].size = CPHYSADDR((u32)_text) - mdesc[i].base;
+	}
+
+	/*  kernel proper */
+	i++;			/* 3 */
+	mdesc[i].type = BOOT_MEM_RESERVED;
+	mdesc[i].base = CPHYSADDR((u32)_text);
+#ifdef CONFIG_MTD_PMC_MSP_RAMROOT
+	if (get_ramroot(&ramroot_start, &ramroot_size)) {
+		/*
+		 * Rootfs in RAM -- follows kernel
+		 * Combine rootfs image with kernel block so a
+		 * page (4k) isn't wasted between memory blocks
+		 */
+		mdesc[i].size = CPHYSADDR(PAGE_ALIGN(
+			(u32)ramroot_start + ramroot_size)) - mdesc[i].base;
+	} else
+#endif
+		mdesc[i].size = CPHYSADDR(PAGE_ALIGN(
+			(u32)_end)) - mdesc[i].base;
+
+	/* Remainder of RAM -- under memsize */
+	i++;			/* 5 */
+	mdesc[i].type = yamon_free;
+	mdesc[i].base = mdesc[i-1].base + mdesc[i-1].size;
+	mdesc[i].size = memsize - mdesc[i].base;
+
+	return &mdesc[0];
+}
+
+/* rootfs functions */
+#ifdef CONFIG_MTD_PMC_MSP_RAMROOT
+bool get_ramroot(void **start, unsigned long *size)
+{
+	extern char _end[];
+	
+	/* Check for start following the end of the kernel */
+	void *check_start = (void *)_end;
+
+	/* Check for supported rootfs types */
+#ifdef CONFIG_CRAMFS
+	if (*(__u32 *)check_start == CRAMFS_MAGIC) {
+		/* Get CRAMFS size */
+		*start = check_start;
+		*size = PAGE_ALIGN(((struct cramfs_super *)
+				   check_start)->size);
+		
+		return true;
+	}
+#endif
+#ifdef CONFIG_SQUASHFS
+	if (*((unsigned int *)check_start) == SQUASHFS_MAGIC) {
+		/* Get SQUASHFS size */
+		*start = check_start;
+		*size = PAGE_ALIGN(((struct squashfs_super_block *)
+				   check_start)->bytes_used);
+		
+		return true;
+	}
+#endif
+
+	return false;
+}
+EXPORT_SYMBOL(get_ramroot);
+#endif
diff --git a/arch/mips/pmc-sierra/msp71xx/msp_setup.c b/arch/mips/pmc-sierra/msp71xx/msp_setup.c
new file mode 100644
index 0000000..de851f7
--- /dev/null
+++ b/arch/mips/pmc-sierra/msp71xx/msp_setup.c
@@ -0,0 +1,260 @@
+/*
+ * The generic setup file for PMC-Sierra MSP processors
+ *
+ * Copyright 2005-2007 PMC-Sierra, Inc,
+ * Author: Jun Sun, jsun@mvista.com or jsun@junsun.net
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/reboot.h>
+#include <linux/time.h>
+
+#include <asm/bootinfo.h>
+#include <asm/cacheflush.h>
+#include <asm/r4kcache.h>
+
+
+#include <msp_prom.h>
+#include <msp_regs.h>
+
+#if defined(CONFIG_PMC_MSP7120_GW)
+#include <msp_regops.h>
+#include <msp_gpio.h>
+#define MSP_BOARD_RESET_GPIO	9
+#define MSP_BOARD_RESET_OGPIO	(MSP_BOARD_RESET_GPIO - 6)
+#endif
+
+extern void msp_timer_init(void);
+extern void msp_serial_setup(void);
+extern void pmctwiled_setup(void);
+
+#if defined(CONFIG_PMC_MSP7120_EVAL) || \
+    defined(CONFIG_PMC_MSP7120_GW) || \
+    defined(CONFIG_PMC_MSP7120_FPGA)
+/*
+ * Performs the reset for MSP7120-based boards
+ */
+void msp7120_reset(void)
+{
+	void *start, *end, *iptr;
+	int i;
+
+	/* Diasble all interrupts */
+	local_irq_disable();
+#ifdef CONFIG_SYS_SUPPORTS_MULTITHREADING
+	dvpe();
+#endif
+
+	/* Cache the reset code of this function */
+	__asm__ __volatile__ (
+		"	.set	push				\n"
+		"	.set	mips3				\n"
+		"	la	%0,startpoint			\n"
+		"	la	%1,endpoint			\n"
+		"	.set	pop				\n"
+		: "=r" (start), "=r" (end)
+		:
+	);
+	;
+	for (iptr = (void *)((unsigned int)start & ~(L1_CACHE_BYTES - 1));
+	     iptr < end; iptr += L1_CACHE_BYTES)
+		cache_op(Fill, iptr);
+	
+	__asm__ __volatile__ (
+		"startpoint:					\n"
+	);
+
+	/* Put the DDRC into self-refresh mode */
+	DDRC_INDIRECT_WRITE(DDRC_CTL(10), 0xb, 1 << 16);
+
+	/*
+	 * IMPORTANT!
+	 * DO NOT do anything from here on out that might even
+	 * think about fetching from RAM - i.e., don't call any
+	 * non-inlined functions, and be VERY sure that any inline
+	 * functions you do call do NOT access any sort of RAM
+	 * anywhere!
+	 */
+
+	/* Wait a bit for the DDRC to settle */
+	for (i = 0; i < 100000000; i++);
+
+#if defined(CONFIG_PMC_MSP7120_GW)
+	/*
+	 * Set GPIO 9 HI, (tied to board reset logic)
+	 * GPIO 9 is the 4th GPIO of register 3
+	 *
+	 * Note, we cannot use the higher-level 'msp_gpio_pin_...'
+	 * functions as they look up data in a static table somewhere
+	 * else in RAM!
+	 */
+	set_value_reg32(GPIO_CFG3_REG,
+			BASIC_MODE_REG_MASK(MSP_BOARD_RESET_OGPIO),
+			BASIC_MODE_REG_VALUE(MSP_GPIO_OUTPUT,
+						MSP_BOARD_RESET_OGPIO));
+	set_reg32(GPIO_DATA3_REG,
+			BASIC_DATA_REG_MASK(MSP_BOARD_RESET_OGPIO));
+
+	/*
+	 * In case GPIO9 doesn't reset the board (jumper configurable!)
+	 * fallback to device reset below.
+	 */
+#endif
+	/* Set bit 1 of the MSP7120 reset register */
+	*RST_SET_REG = 0x00000001;
+
+	__asm__ __volatile__ (
+		"endpoint:					\n"
+	);
+}
+#endif
+
+void msp_restart(char *command)
+{
+	printk(KERN_WARNING "Now rebooting .......\n");
+
+#if defined(CONFIG_PMC_MSP7120_EVAL) || \
+    defined(CONFIG_PMC_MSP7120_GW) || \
+    defined(CONFIG_PMC_MSP7120_FPGA)
+	msp7120_reset();
+#else
+	/* No chip-specific reset code, just jump to the ROM reset vector */
+	set_c0_status(ST0_BEV | ST0_ERL);
+	change_c0_config(CONF_CM_CMASK, CONF_CM_UNCACHED);
+	flush_cache_all();
+	write_c0_wired(0);
+
+	__asm__ __volatile__("jr\t%0"::"r"(0xbfc00000));
+#endif
+}
+
+void msp_halt(void)
+{
+	printk(KERN_WARNING "\n** You can safely turn off the power\n");
+	while (1)
+		/* If possible call official function to get CPU WARs */
+		if (cpu_wait)
+			(*cpu_wait)();
+		else
+			__asm__(".set\tmips3\n\t" "wait\n\t" ".set\tmips0");
+}
+
+void msp_power_off(void)
+{
+	msp_halt();
+}
+
+void __init plat_mem_setup(void)
+{
+	_machine_restart = msp_restart;
+	_machine_halt = msp_halt;
+	pm_power_off = msp_power_off;
+
+	board_time_init = msp_timer_init;
+}
+
+void __init prom_init(void)
+{
+	unsigned long family;
+	unsigned long revision;
+
+	prom_argc = fw_arg0;
+	prom_argv = (char **)fw_arg1;
+	prom_envp = (char **)fw_arg2;
+
+	/*
+	 * Someday we can use this with PMON2000 to get a
+	 * platform call prom routines for output etc. without
+	 * having to use grody hacks.  For now it's unused.
+	 *
+	 * struct callvectors *cv = (struct callvectors *) fw_arg3;
+	 */
+	family = identify_family();
+	revision = identify_revision();
+
+	switch (family)	{
+	case FAMILY_FPGA:
+		if (FPGA_IS_MSP4200(revision)) {
+			/* Old-style revision ID */
+			mips_machgroup = MACH_GROUP_MSP;
+			mips_machtype = MACH_MSP4200_FPGA;
+		} else {
+			mips_machgroup = MACH_GROUP_MSP;
+			mips_machtype = MACH_MSP_OTHER;
+		}
+		break;
+
+	case FAMILY_MSP4200:
+		mips_machgroup = MACH_GROUP_MSP;
+#if defined(CONFIG_PMC_MSP4200_EVAL)
+		mips_machtype  = MACH_MSP4200_EVAL;
+#elif defined(CONFIG_PMC_MSP4200_GW)
+		mips_machtype  = MACH_MSP4200_GW;
+#else
+		mips_machtype = MACH_MSP_OTHER;
+#endif
+		break;
+
+	case FAMILY_MSP4200_FPGA:
+		mips_machgroup = MACH_GROUP_MSP;
+		mips_machtype  = MACH_MSP4200_FPGA;
+		break;
+
+	case FAMILY_MSP7100:
+		mips_machgroup = MACH_GROUP_MSP;
+#if defined(CONFIG_PMC_MSP7120_EVAL)
+		mips_machtype = MACH_MSP7120_EVAL;
+#elif defined(CONFIG_PMC_MSP7120_GW)
+		mips_machtype = MACH_MSP7120_GW;
+#else
+		mips_machtype = MACH_MSP_OTHER;
+#endif
+		break;
+
+	case FAMILY_MSP7100_FPGA:
+		mips_machgroup = MACH_GROUP_MSP;
+		mips_machtype  = MACH_MSP7120_FPGA;
+		break;
+
+	default:
+		/* we don't recognize the machine */
+		mips_machgroup = MACH_GROUP_UNKNOWN;
+		mips_machtype  = MACH_UNKNOWN;
+		break;
+	}
+	
+	/* make sure we have the right initialization routine - sanity */
+	if (mips_machgroup != MACH_GROUP_MSP) {
+		ppfinit("Unknown machine group in a "
+			"MSP initialization routine\n");
+		panic("***Bogosity factor five***, exiting\n");
+	}
+
+	prom_init_cmdline();
+	
+	prom_meminit();
+
+	/*
+	 * Sub-system setup follows.
+	 * Setup functions can  either be called here or using the
+	 * subsys_initcall mechanism (i.e. see msp_pci_setup). The
+	 * order in which they are called can be changed by using the
+	 * link order in arch/mips/pmc-sierra/msp71xx/Makefile.
+	 *
+	 * NOTE: Please keep sub-system specific initialization code
+	 * in separate specific files.
+	 */
+	msp_serial_setup();
+	 
+#ifdef CONFIG_PMCTWILED
+	/*
+	 * Setup LED states before the subsys_initcall loads other
+	 * dependant drivers/modules.
+	 */
+	pmctwiled_setup();
+#endif
+}
diff --git a/arch/mips/pmc-sierra/msp71xx/msp_time.c b/arch/mips/pmc-sierra/msp71xx/msp_time.c
new file mode 100644
index 0000000..8ec9929
--- /dev/null
+++ b/arch/mips/pmc-sierra/msp71xx/msp_time.c
@@ -0,0 +1,94 @@
+/*
+ * Setting up the clock on MSP SOCs.  No RTC typically.
+ *
+ * Carsten Langgaard, carstenl@mips.com
+ * Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
+ *
+ * ########################################################################
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ *
+ * ########################################################################
+ */
+
+#include <linux/init.h>
+#include <linux/kernel_stat.h>
+#include <linux/sched.h>
+#include <linux/spinlock.h>
+#include <linux/module.h>
+#include <linux/ptrace.h>
+#include <linux/time.h>
+
+#include <asm/mipsregs.h>
+
+#include <msp_prom.h>
+#include <msp_int.h>
+#include <msp_regs.h>
+
+void __init msp_timer_init(void)
+{
+	char    *endp, *s;
+	unsigned long cpu_rate = 0;
+    
+	if (cpu_rate == 0) {
+		s = prom_getenv("clkfreqhz");
+		cpu_rate = simple_strtoul(s, &endp, 10);
+		if (endp != NULL && *endp != 0) {
+			printk(KERN_ERR
+				"Clock rate in Hz parse error: %s\n", s);
+			cpu_rate = 0;
+		}
+	}
+	
+	if (cpu_rate == 0) {
+		s = prom_getenv("clkfreq");
+		cpu_rate = 1000 * simple_strtoul(s, &endp, 10);
+		if (endp != NULL && *endp != 0) {
+			printk(KERN_ERR
+				"Clock rate in MHz parse error: %s\n", s);
+			cpu_rate = 0;
+		}
+	}
+	
+	if (cpu_rate == 0) {
+#if defined(CONFIG_PMC_MSP7120_EVAL) \
+ || defined(CONFIG_PMC_MSP7120_GW)
+		cpu_rate = 400000000;
+#elif defined(CONFIG_PMC_MSP7120_FPGA)
+		cpu_rate = 25000000;
+#else
+		cpu_rate = 150000000;
+#endif
+		printk(KERN_ERR
+			"Failed to determine CPU clock rate, "
+			"assuming %ld hz ...\n", cpu_rate);
+	}
+
+	printk(KERN_WARNING "Clock rate set to %ld\n", cpu_rate);
+	
+	/* timer frequency is 1/2 clock rate */
+	mips_hpt_frequency = cpu_rate/2;
+}
+
+
+void __init plat_timer_setup(struct irqaction *irq)
+{
+#ifdef CONFIG_IRQ_MSP_CIC
+	/* we are using the vpe0 counter for timer interrupts */
+	setup_irq(MSP_INT_VPE0_TIMER, irq);
+#else
+	/* we are using the mips counter for timer interrupts */
+	setup_irq(MSP_INT_TIMER, irq);
+#endif
+}
diff --git a/arch/mips/pmc-sierra/msp71xx/msp_usb.c b/arch/mips/pmc-sierra/msp71xx/msp_usb.c
new file mode 100644
index 0000000..87331e9
--- /dev/null
+++ b/arch/mips/pmc-sierra/msp71xx/msp_usb.c
@@ -0,0 +1,150 @@
+/*
+ * The setup file for USB related hardware on PMC-Sierra MSP processors.
+ *
+ * Copyright 2006-2007 PMC-Sierra, Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/platform_device.h>
+
+#include <asm/mipsregs.h>
+
+#include <msp_regs.h>
+#include <msp_int.h>
+#include <msp_prom.h>
+
+#if defined(CONFIG_USB_EHCI_HCD)
+static struct resource msp_usbhost_resources [] = {
+	[0] = {
+		.start	= MSP_USB_BASE_START,
+		.end	= MSP_USB_BASE_END,
+		.flags 	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= MSP_INT_USB,
+		.end	= MSP_INT_USB,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static u64 msp_usbhost_dma_mask = DMA_32BIT_MASK;
+
+static struct platform_device msp_usbhost_device = {
+	.name	= "pmcmsp-ehci",
+	.id	= 0,
+	.dev	= {
+		.dma_mask = &msp_usbhost_dma_mask,
+		.coherent_dma_mask = DMA_32BIT_MASK,
+	},
+	.num_resources 	= ARRAY_SIZE (msp_usbhost_resources),
+	.resource	= msp_usbhost_resources,
+};
+#endif /* CONFIG_USB_EHCI_HCD */
+
+#if defined(CONFIG_USB_GADGET)
+static struct resource msp_usbdev_resources [] = {
+	[0] = {
+		.start	= MSP_USB_BASE,
+		.end	= MSP_USB_BASE_END,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= MSP_INT_USB,
+		.end	= MSP_INT_USB,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static u64 msp_usbdev_dma_mask = DMA_32BIT_MASK;
+
+static struct platform_device msp_usbdev_device = {
+	.name	= "msp71xx_udc",
+	.id	= 0,
+	.dev	= {
+		.dma_mask = &msp_usbdev_dma_mask,
+		.coherent_dma_mask = DMA_32BIT_MASK,
+	},
+	.num_resources	= ARRAY_SIZE (msp_usbdev_resources),
+	.resource	= msp_usbdev_resources,
+};
+#endif /* CONFIG_USB_GADGET */
+
+#if defined(CONFIG_USB_EHCI_HCD) || defined(CONFIG_USB_GADGET)
+static struct platform_device *msp_devs[1];
+#endif
+
+
+static int __init msp_usb_setup(void)
+{
+#if defined(CONFIG_USB_EHCI_HCD) || defined(CONFIG_USB_GADGET)
+	char *strp;
+	char envstr[32];
+	unsigned int val = 0;
+	int result = 0;
+	
+	/*
+	 * construct environment name usbmode
+	 * set usbmode <host/device> as pmon environment var
+	 */
+	snprintf((char *)&envstr[0], sizeof(envstr), "usbmode");
+
+#if defined(CONFIG_USB_EHCI_HCD)
+	/* default to host mode */
+	val = 1;
+#endif
+
+	/* get environment string */
+	strp = prom_getenv((char *)&envstr[0]);
+	if (strp) {
+		if (!strcmp(strp, "device"))
+			val = 0;
+	}
+
+	if (val) {
+#if defined(CONFIG_USB_EHCI_HCD)
+		/* get host mode device */
+		msp_devs[0] = &msp_usbhost_device;
+		ppfinit("platform add USB HOST done %s.\n",
+			    msp_devs[0]->name);
+
+		result = platform_add_devices(msp_devs, ARRAY_SIZE (msp_devs));
+#endif /* CONFIG_USB_EHCI_HCD */
+	}
+#if defined(CONFIG_USB_GADGET)
+	else {
+		/* get device mode structure */
+		msp_devs[0] = &msp_usbdev_device;
+		ppfinit("platform add USB DEVICE done %s.\n",
+			    msp_devs[0]->name);
+
+		result = platform_add_devices(msp_devs, ARRAY_SIZE (msp_devs));
+	}
+#endif /* CONFIG_USB_GADGET */
+#endif /* CONFIG_USB_EHCI_HCD || CONFIG_USB_GADGET */
+
+	return result;
+}
+
+subsys_initcall(msp_usb_setup);
diff --git a/include/asm-mips/pmc-sierra/msp71xx/msp_cic_int.h b/include/asm-mips/pmc-sierra/msp71xx/msp_cic_int.h
new file mode 100644
index 0000000..c84bcf9
--- /dev/null
+++ b/include/asm-mips/pmc-sierra/msp71xx/msp_cic_int.h
@@ -0,0 +1,151 @@
+/*
+ * Defines for the MSP interrupt controller.
+ *
+ * Copyright (C) 1999 MIPS Technologies, Inc.  All rights reserved.
+ * Author: Carsten Langgaard, carstenl@mips.com
+ *
+ * ########################################################################
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ *
+ * ########################################################################
+ */
+
+#ifndef _MSP_CIC_INT_H
+#define _MSP_CIC_INT_H
+
+/*
+ * The PMC-Sierra CIC interrupts are all centrally managed by the
+ * CIC sub-system.
+ * We attempt to keep the interrupt numbers as consistent as possible
+ * across all of the MSP devices, but some differences will creep in ...
+ * The interrupts which are directly forwarded to the MIPS core interrupts
+ * are assigned interrupts in the range 0-7, interrupts cascaded through
+ * the CIC are assigned interrupts 8-39.  The cascade occurs on C_IRQ4
+ * (MSP_INT_CIC).  Currently we don't really distinguish between VPE1
+ * and VPE0 (or thread contexts for that matter).  Will have to fix.
+ * The PER interrupts are assigned interrupts in the range 40-71.
+*/
+
+
+/*
+ * IRQs directly forwarded to the CPU
+ */
+#define MSP_MIPS_INTBASE	0
+#define MSP_INT_SW0		0	/* IRQ for swint0,       C_SW0  */
+#define MSP_INT_SW1		1	/* IRQ for swint1,       C_SW1  */
+#define MSP_INT_MAC0		2	/* IRQ for MAC 0,        C_IRQ0 */
+#define MSP_INT_MAC1		3	/* IRQ for MAC 1,        C_IRQ1 */
+#define MSP_INT_USB		4	/* IRQ for USB,          C_IRQ2 */
+#define MSP_INT_SAR		5	/* IRQ for ADSL2+ SAR,   C_IRQ3 */
+#define MSP_INT_CIC		6	/* IRQ for CIC block,    C_IRQ4 */
+#define MSP_INT_SEC		7	/* IRQ for Sec engine,   C_IRQ5 */
+
+/*
+ * IRQs cascaded on CPU interrupt 4 (CAUSE bit 12, C_IRQ4)
+ * These defines should be tied to the register definitions for the CIC
+ * interrupt routine.  For now, just use hard-coded values.
+ */
+#define MSP_CIC_INTBASE		(MSP_MIPS_INTBASE + 8)
+#define MSP_INT_EXT0		(MSP_CIC_INTBASE + 0)
+					/* External interrupt 0         */
+#define MSP_INT_EXT1		(MSP_CIC_INTBASE + 1)
+					/* External interrupt 1         */
+#define MSP_INT_EXT2		(MSP_CIC_INTBASE + 2)
+					/* External interrupt 2         */
+#define MSP_INT_EXT3		(MSP_CIC_INTBASE + 3)
+					/* External interrupt 3         */
+#define MSP_INT_CPUIF		(MSP_CIC_INTBASE + 4)
+					/* CPU interface interrupt      */
+#define MSP_INT_EXT4		(MSP_CIC_INTBASE + 5)
+					/* External interrupt 4         */
+#define MSP_INT_CIC_USB		(MSP_CIC_INTBASE + 6)
+					/* Cascaded IRQ for USB         */
+#define MSP_INT_MBOX		(MSP_CIC_INTBASE + 7)
+					/* Sec engine mailbox IRQ       */
+#define MSP_INT_EXT5		(MSP_CIC_INTBASE + 8)
+					/* External interrupt 5         */
+#define MSP_INT_TDM		(MSP_CIC_INTBASE + 9)
+					/* TDM interrupt                */
+#define MSP_INT_CIC_MAC0	(MSP_CIC_INTBASE + 10)
+					/* Cascaded IRQ for MAC 0       */
+#define MSP_INT_CIC_MAC1	(MSP_CIC_INTBASE + 11)
+					/* Cascaded IRQ for MAC 1       */
+#define MSP_INT_CIC_SEC		(MSP_CIC_INTBASE + 12)
+					/* Cascaded IRQ for sec engine  */
+#define	MSP_INT_PER		(MSP_CIC_INTBASE + 13)
+					/* Peripheral interrupt         */
+#define	MSP_INT_TIMER0		(MSP_CIC_INTBASE + 14)
+					/* SLP timer 0                  */
+#define	MSP_INT_TIMER1		(MSP_CIC_INTBASE + 15)
+					/* SLP timer 1                  */
+#define	MSP_INT_TIMER2		(MSP_CIC_INTBASE + 16)
+					/* SLP timer 2                  */
+#define	MSP_INT_VPE0_TIMER	(MSP_CIC_INTBASE + 17)
+					/* VPE0 MIPS timer              */
+#define MSP_INT_BLKCP		(MSP_CIC_INTBASE + 18)
+					/* Block Copy                   */
+#define MSP_INT_UART0		(MSP_CIC_INTBASE + 19)
+					/* UART 0                       */
+#define MSP_INT_PCI		(MSP_CIC_INTBASE + 20)
+					/* PCI subsystem                */
+#define MSP_INT_EXT6		(MSP_CIC_INTBASE + 21)
+					/* External interrupt 5         */
+#define MSP_INT_PCI_MSI		(MSP_CIC_INTBASE + 22)
+					/* PCI Message Signal           */
+#define MSP_INT_CIC_SAR		(MSP_CIC_INTBASE + 23)
+					/* Cascaded ADSL2+ SAR IRQ      */
+#define MSP_INT_DSL		(MSP_CIC_INTBASE + 24)
+					/* ADSL2+ IRQ                   */
+#define MSP_INT_CIC_ERR		(MSP_CIC_INTBASE + 25)
+					/* SLP error condition          */
+#define MSP_INT_VPE1_TIMER	(MSP_CIC_INTBASE + 26)
+					/* VPE1 MIPS timer              */
+#define MSP_INT_VPE0_PC		(MSP_CIC_INTBASE + 27)
+					/* VPE0 Performance counter     */
+#define MSP_INT_VPE1_PC		(MSP_CIC_INTBASE + 28)
+					/* VPE1 Performance counter     */
+#define MSP_INT_EXT7		(MSP_CIC_INTBASE + 29)
+					/* External interrupt 5         */
+#define MSP_INT_VPE0_SW		(MSP_CIC_INTBASE + 30)
+					/* VPE0 Software interrupt      */
+#define MSP_INT_VPE1_SW		(MSP_CIC_INTBASE + 31)
+					/* VPE0 Software interrupt      */
+
+/*
+ * IRQs cascaded on CIC PER interrupt (MSP_INT_PER)
+ */
+#define MSP_PER_INTBASE		(MSP_CIC_INTBASE + 32)
+/* Reserved					   0-1                  */
+#define MSP_INT_UART1		(MSP_PER_INTBASE + 2)
+					/* UART 1                       */
+/* Reserved					   3-5                  */
+#define MSP_INT_2WIRE		(MSP_PER_INTBASE + 6)
+					/* 2-wire                       */
+#define MSP_INT_TM0		(MSP_PER_INTBASE + 7)
+					/* Peripheral timer block out 0 */
+#define MSP_INT_TM1		(MSP_PER_INTBASE + 8)
+					/* Peripheral timer block out 1 */
+/* Reserved					   9                    */
+#define MSP_INT_SPRX		(MSP_PER_INTBASE + 10)
+					/* SPI RX complete              */
+#define MSP_INT_SPTX		(MSP_PER_INTBASE + 11)
+					/* SPI TX complete              */
+#define MSP_INT_GPIO		(MSP_PER_INTBASE + 12)
+					/* GPIO                         */
+#define MSP_INT_PER_ERR		(MSP_PER_INTBASE + 13)
+					/* Peripheral error             */
+/* Reserved					   14-31                */
+
+#endif /* !_MSP_CIC_INT_H */
diff --git a/include/asm-mips/pmc-sierra/msp71xx/msp_int.h b/include/asm-mips/pmc-sierra/msp71xx/msp_int.h
new file mode 100644
index 0000000..1d9f054
--- /dev/null
+++ b/include/asm-mips/pmc-sierra/msp71xx/msp_int.h
@@ -0,0 +1,43 @@
+/*
+ * Defines for the MSP interrupt handlers.
+ *
+ * Copyright (C) 2005, PMC-Sierra, Inc.  All rights reserved.
+ * Author: Andrew Hughes, Andrew_Hughes@pmc-sierra.com
+ *
+ * ########################################################################
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ *
+ * ########################################################################
+ */
+
+#ifndef _MSP_INT_H
+#define _MSP_INT_H
+
+/*
+ * The PMC-Sierra MSP product line has at least two different interrupt
+ * controllers, the SLP register based scheme and the CIC interrupt
+ * controller block mechanism.  This file distinguishes between them
+ * so that devices see a uniform interface.
+ */
+
+#if defined(CONFIG_IRQ_MSP_SLP)
+	#include "msp_slp_int.h"
+#elif defined(CONFIG_IRQ_MSP_CIC)
+	#include "msp_cic_int.h"
+#else
+	#error "What sort of interrupt controller does *your* MSP have?"
+#endif
+
+#endif /* !_MSP_INT_H */
diff --git a/include/asm-mips/pmc-sierra/msp71xx/msp_prom.h b/include/asm-mips/pmc-sierra/msp71xx/msp_prom.h
new file mode 100644
index 0000000..14ca7dc
--- /dev/null
+++ b/include/asm-mips/pmc-sierra/msp71xx/msp_prom.h
@@ -0,0 +1,176 @@
+/*
+ * MIPS boards bootprom interface for the Linux kernel.
+ *
+ * Copyright (C) 2000 MIPS Technologies, Inc.  All rights reserved.
+ * Author: Carsten Langgaard, carstenl@mips.com
+ *
+ * ########################################################################
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ *
+ * ########################################################################
+ */
+
+#ifndef _ASM_MSP_PROM_H
+#define _ASM_MSP_PROM_H
+
+#include <linux/types.h>
+
+#define DEVICEID			"deviceid"
+#define FEATURES			"features"
+#define PROM_ENV			"prom_env"
+#define PROM_ENV_FILE			"/proc/"PROM_ENV
+#define PROM_ENV_SIZE			256
+
+#define CPU_DEVID_FAMILY		0x0000ff00
+#define CPU_DEVID_REVISION		0x000000ff
+
+#define FPGA_IS_POLO(revision) \
+		(((revision >= 0xb0) && (revision < 0xd0)))
+#define FPGA_IS_5000(revision) \
+		((revision >= 0x80) && (revision <= 0x90))
+#define	FPGA_IS_ZEUS(revision)		((revision < 0x7f))
+#define FPGA_IS_DUET(revision) \
+		(((revision >= 0xa0) && (revision < 0xb0)))
+#define FPGA_IS_MSP4200(revision)	((revision >= 0xd0))
+#define FPGA_IS_MSP7100(revision)	((revision >= 0xd0))
+
+#define MACHINE_TYPE_POLO		"POLO"
+#define MACHINE_TYPE_DUET		"DUET"
+#define	MACHINE_TYPE_ZEUS		"ZEUS"
+#define MACHINE_TYPE_MSP2000REVB	"MSP2000REVB"
+#define MACHINE_TYPE_MSP5000		"MSP5000"
+#define MACHINE_TYPE_MSP4200		"MSP4200"
+#define MACHINE_TYPE_MSP7120		"MSP7120"
+#define MACHINE_TYPE_MSP7130		"MSP7130"
+#define MACHINE_TYPE_OTHER		"OTHER"
+
+#define MACHINE_TYPE_POLO_FPGA		"POLO-FPGA"
+#define MACHINE_TYPE_DUET_FPGA		"DUET-FPGA"
+#define	MACHINE_TYPE_ZEUS_FPGA		"ZEUS_FPGA"
+#define MACHINE_TYPE_MSP2000REVB_FPGA	"MSP2000REVB-FPGA"
+#define MACHINE_TYPE_MSP5000_FPGA	"MSP5000-FPGA"
+#define MACHINE_TYPE_MSP4200_FPGA	"MSP4200-FPGA"
+#define MACHINE_TYPE_MSP7100_FPGA	"MSP7100-FPGA"
+#define MACHINE_TYPE_OTHER_FPGA		"OTHER-FPGA"
+
+/* Device Family definitions */
+#define FAMILY_FPGA			0x0000
+#define FAMILY_ZEUS			0x1000
+#define FAMILY_POLO			0x2000
+#define FAMILY_DUET			0x4000
+#define FAMILY_TRIAD			0x5000
+#define FAMILY_MSP4200			0x4200
+#define FAMILY_MSP4200_FPGA		0x4f00
+#define FAMILY_MSP7100			0x7100
+#define FAMILY_MSP7100_FPGA		0x7f00
+
+/* Device Type definitions */
+#define TYPE_MSP7120			0x7120
+#define TYPE_MSP7130			0x7130
+
+#define ENET_KEY		'E'
+#define ENETTXD_KEY		'e'
+#define PCI_KEY			'P'
+#define PCIMUX_KEY		'p'
+#define SEC_KEY			'S'
+#define SPAD_KEY		'D'
+#define TDM_KEY			'T'
+#define ZSP_KEY			'Z'
+
+#define FEATURE_NOEXIST		'-'
+#define FEATURE_EXIST		'+'
+
+#define ENET_MII		'M'
+#define ENET_RMII		'R'
+
+#define	ENETTXD_FALLING		'F'
+#define ENETTXD_RISING		'R'
+
+#define PCI_HOST		'H'
+#define PCI_PERIPHERAL		'P'
+
+#define PCIMUX_FULL		'F'
+#define PCIMUX_SINGLE		'S'
+
+#define SEC_DUET		'D'
+#define SEC_POLO		'P'
+#define SEC_SLOW		'S'
+#define SEC_TRIAD		'T'
+
+#define SPAD_POLO		'P'
+
+#define TDM_DUET		'D'	/* DUET TDMs might exist */
+#define TDM_POLO		'P'	/* POLO TDMs might exist */
+#define TDM_TRIAD		'T'	/* TRIAD TDMs might exist */
+
+#define ZSP_DUET		'D'	/* one DUET zsp engine */
+#define ZSP_TRIAD		'T'	/* two TRIAD zsp engines */
+
+extern char *prom_getcmdline(void);
+extern char *prom_getenv(char *name);
+extern void prom_init_cmdline(void);
+extern void prom_meminit(void);
+extern void prom_fixup_mem_map(unsigned long start_mem,
+			       unsigned long end_mem);
+
+#ifdef CONFIG_MTD_PMC_MSP_RAMROOT
+extern bool get_ramroot(void **start, unsigned long *size);
+#endif
+
+extern int get_ethernet_addr(char *ethaddr_name, char *ethernet_addr);
+extern unsigned long get_deviceid(void);
+extern char identify_enet(unsigned long interface_num);
+extern char identify_enetTxD(unsigned long interface_num);
+extern char identify_pci(void);
+extern char identify_sec(void);
+extern char identify_spad(void);
+extern char identify_sec(void);
+extern char identify_tdm(void);
+extern char identify_zsp(void);
+extern unsigned long identify_family(void);
+extern unsigned long identify_revision(void);
+
+/*
+ * The following macro calls prom_printf and puts the format string
+ * into an init section so it can be reclaimed.
+ */
+#define ppfinit(f, x...) \
+	do { \
+		static char _f[] __initdata = KERN_INFO f; \
+		printk(_f, ## x); \
+	} while (0)
+
+/* Memory descriptor management. */
+#define PROM_MAX_PMEMBLOCKS    7	/* 6 used */
+
+enum yamon_memtypes {
+	yamon_dontuse,
+	yamon_prom,
+	yamon_free,
+};
+
+struct prom_pmemblock {
+	unsigned long base; /* Within KSEG0. */
+	unsigned int size;  /* In bytes. */
+	unsigned int type;  /* free or prom memory */
+};
+
+extern int prom_argc;
+extern char **prom_argv;
+extern char **prom_envp;
+extern int *prom_vec;
+extern struct prom_pmemblock *prom_getmdesc(void);
+
+#endif /* !_ASM_MSP_PROM_H */
diff --git a/include/asm-mips/pmc-sierra/msp71xx/msp_regs.h b/include/asm-mips/pmc-sierra/msp71xx/msp_regs.h
new file mode 100644
index 0000000..0b56f55
--- /dev/null
+++ b/include/asm-mips/pmc-sierra/msp71xx/msp_regs.h
@@ -0,0 +1,667 @@
+/*
+ * Defines for the address space, registers and register configuration
+ * (bit masks, access macros etc) for the PMC-Sierra line of MSP products.
+ * This file contains addess maps for all the devices in the line of
+ * products but only has register definitions and configuration masks for
+ * registers which aren't definitely associated with any device.  Things
+ * like clock settings, reset access, the ELB etc.  Individual device
+ * drivers will reference the appropriate XXX_BASE value defined here
+ * and have individual registers offset from that.
+ *
+ * Copyright (C) 2005-2007 PMC-Sierra, Inc.  All rights reserved.
+ * Author: Andrew Hughes, Andrew_Hughes@pmc-sierra.com
+ *
+ * ########################################################################
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ *
+ * ########################################################################
+ */
+
+#include <asm/addrspace.h>
+#include <linux/types.h>
+
+#ifndef _ASM_MSP_REGS_H
+#define _ASM_MSP_REGS_H
+
+/*
+ ########################################################################
+ #  Address space and device base definitions                           #
+ ########################################################################
+ */
+
+/*
+ ***************************************************************************
+ * System Logic and Peripherals (ELB, UART0, etc) device address space     *
+ ***************************************************************************
+ */
+#define MSP_SLP_BASE		0x1c000000
+					/* System Logic and Peripherals */
+#define MSP_RST_BASE		(MSP_SLP_BASE + 0x10)
+					/* System reset register base	*/
+#define MSP_RST_SIZE		0x0C	/* System reset register space	*/
+
+#define MSP_WTIMER_BASE		(MSP_SLP_BASE + 0x04C)
+					/* watchdog timer base          */
+#define MSP_ITIMER_BASE		(MSP_SLP_BASE + 0x054)
+					/* internal timer base          */
+#define MSP_UART0_BASE		(MSP_SLP_BASE + 0x100)
+					/* UART0 controller base        */
+#define MSP_BCPY_CTRL_BASE	(MSP_SLP_BASE + 0x120)
+					/* Block Copy controller base   */
+#define MSP_BCPY_DESC_BASE	(MSP_SLP_BASE + 0x160)
+					/* Block Copy descriptor base   */
+
+/*
+ ***************************************************************************
+ * PCI address space                                                       *
+ ***************************************************************************
+ */
+#define MSP_PCI_BASE		0x19000000
+
+/*
+ ***************************************************************************
+ * MSbus device address space                                              *
+ ***************************************************************************
+ */
+#define MSP_MSB_BASE		0x18000000
+					/* MSbus address start          */
+#define MSP_PER_BASE		(MSP_MSB_BASE + 0x400000)
+					/* Peripheral device registers  */
+#define MSP_MAC0_BASE		(MSP_MSB_BASE + 0x600000)
+					/* MAC A device registers       */
+#define MSP_MAC1_BASE		(MSP_MSB_BASE + 0x700000)
+					/* MAC B device registers       */
+#define MSP_MAC_SIZE		0xE0	/* MAC register space		*/
+
+#define MSP_SEC_BASE		(MSP_MSB_BASE + 0x800000)
+					/* Security Engine registers    */
+#define MSP_MAC2_BASE		(MSP_MSB_BASE + 0x900000)
+					/* MAC C device registers       */
+#define MSP_ADSL2_BASE		(MSP_MSB_BASE + 0xA80000)
+					/* ADSL2 device registers       */
+#define MSP_USB_BASE		(MSP_MSB_BASE + 0xB40000)
+					/* USB device registers         */
+#define MSP_USB_BASE_START	(MSP_MSB_BASE + 0xB40100)
+					/* USB device registers         */
+#define MSP_USB_BASE_END	(MSP_MSB_BASE + 0xB401FF)
+					/* USB device registers         */
+#define MSP_CPUIF_BASE		(MSP_MSB_BASE + 0xC00000)
+					/* CPU interface registers      */
+
+/* Devices within the MSbus peripheral block */
+#define MSP_UART1_BASE		(MSP_PER_BASE + 0x030)
+					/* UART1 controller base        */
+#define MSP_SPI_BASE		(MSP_PER_BASE + 0x058)
+					/* SPI/MPI control registers    */
+#define MSP_TWI_BASE		(MSP_PER_BASE + 0x090)
+					/* Two-wire control registers   */
+#define MSP_PTIMER_BASE		(MSP_PER_BASE + 0x0F0)
+					/* Programmable timer control   */
+
+/*
+ ***************************************************************************
+ * Physical Memory configuration address space                             *
+ ***************************************************************************
+ */
+#define MSP_MEM_CFG_BASE	0x17f00000
+
+#define MSP_MEM_INDIRECT_CTL_10	0x10
+
+/*
+ * Notes:
+ *  1) The SPI registers are split into two blocks, one offset from the
+ *     MSP_SPI_BASE by 0x00 and the other offset from the MSP_SPI_BASE by
+ *     0x68.  The SPI driver definitions for the register must be aware
+ *     of this.
+ *  2) The block copy engine register are divided into two regions, one
+ *     for the control/configuration of the engine proper and one for the
+ *     values of the descriptors used in the copy process.  These have
+ *     different base defines (CTRL_BASE vs DESC_BASE)
+ *  3) These constants are for physical addresses which means that they
+ *     work correctly with "ioremap" and friends.  This means that device
+ *     drivers will need to remap these addresses using ioremap and perhaps
+ *     the readw/writew macros.  Or they could use the regptr() macro
+ *     defined below, but the readw/writew calls are the correct thing.
+ *  4) The UARTs have an additional status register offset from the base
+ *     address.  This register isn't used in the standard 8250 driver but
+ *     may be used in other software.  Consult the hardware datasheet for
+ *     offset details.
+ *  5) For some unknown reason the security engine (MSP_SEC_BASE) registers
+ *     start at an offset of 0x84 from the base address but the block of
+ *     registers before this is reserved for the security engine.  The
+ *     driver will have to be aware of this but it makes the register
+ *     definitions line up better with the documentation.
+ */
+
+/*
+ ########################################################################
+ #  System register definitions.  Not associated with a specific device #
+ ########################################################################
+ */
+
+/*
+ * This macro maps the physical register number into uncached space
+ * and (for C code) casts it into a u32 pointer so it can be dereferenced
+ * Normally these would be accessed with ioremap and readX/writeX, but
+ * these are convenient for a lot of internal kernel code.
+ */
+#ifdef __ASSEMBLER__
+	#define regptr(addr) (KSEG1ADDR(addr))
+#else
+	#define regptr(addr) ((volatile u32 *const)(KSEG1ADDR(addr)))
+#endif
+
+/*
+ ***************************************************************************
+ * System Logic and Peripherals (RESET, ELB, etc) registers                *
+ ***************************************************************************
+ */
+
+/* System Control register definitions */
+#define	DEV_ID_REG	regptr(MSP_SLP_BASE + 0x00)
+					/* Device-ID                 RO */
+#define	FWR_ID_REG	regptr(MSP_SLP_BASE + 0x04)
+					/* Firmware-ID Register      RW */
+#define	SYS_ID_REG0	regptr(MSP_SLP_BASE + 0x08)
+					/* System-ID Register-0      RW */
+#define	SYS_ID_REG1	regptr(MSP_SLP_BASE + 0x0C)
+					/* System-ID Register-1      RW */
+
+/* System Reset register definitions */
+#define	RST_STS_REG	regptr(MSP_SLP_BASE + 0x10)
+					/* System Reset Status       RO */
+#define	RST_SET_REG	regptr(MSP_SLP_BASE + 0x14)
+					/* System Set Reset          WO */
+#define	RST_CLR_REG	regptr(MSP_SLP_BASE + 0x18)
+					/* System Clear Reset        WO */
+
+/* System Clock Registers */
+#define PCI_SLP_REG	regptr(MSP_SLP_BASE + 0x1C)
+					/* PCI clock generator       RW */
+#define URT_SLP_REG	regptr(MSP_SLP_BASE + 0x20)
+					/* UART clock generator      RW */
+/* reserved		      (MSP_SLP_BASE + 0x24)                     */
+/* reserved		      (MSP_SLP_BASE + 0x28)                     */
+#define PLL1_SLP_REG	regptr(MSP_SLP_BASE + 0x2C)
+					/* PLL1 clock generator      RW */
+#define PLL0_SLP_REG	regptr(MSP_SLP_BASE + 0x30)
+					/* PLL0 clock generator      RW */
+#define MIPS_SLP_REG	regptr(MSP_SLP_BASE + 0x34)
+					/* MIPS clock generator      RW */
+#define	VE_SLP_REG	regptr(MSP_SLP_BASE + 0x38)
+					/* Voice Eng clock generator RW */
+/* reserved		      (MSP_SLP_BASE + 0x3C)                     */
+#define MSB_SLP_REG	regptr(MSP_SLP_BASE + 0x40)
+					/* MS-Bus clock generator    RW */
+#define SMAC_SLP_REG	regptr(MSP_SLP_BASE + 0x44)
+					/* Sec & MAC clock generator RW */
+#define PERF_SLP_REG	regptr(MSP_SLP_BASE + 0x48)
+					/* Per & TDM clock generator RW */
+
+/* Interrupt Controller Registers */
+#define SLP_INT_STS_REG regptr(MSP_SLP_BASE + 0x70)
+					/* Interrupt status register RW */
+#define SLP_INT_MSK_REG regptr(MSP_SLP_BASE + 0x74)
+					/* Interrupt enable/mask     RW */
+#define SE_MBOX_REG	regptr(MSP_SLP_BASE + 0x78)
+					/* Security Engine mailbox   RW */
+#define VE_MBOX_REG	regptr(MSP_SLP_BASE + 0x7C)
+					/* Voice Engine mailbox      RW */
+
+/* ELB Controller Registers */
+#define CS0_CNFG_REG	regptr(MSP_SLP_BASE + 0x80)
+					/* ELB CS0 Configuration Reg    */
+#define CS0_ADDR_REG	regptr(MSP_SLP_BASE + 0x84)
+					/* ELB CS0 Base Address Reg     */
+#define CS0_MASK_REG	regptr(MSP_SLP_BASE + 0x88)
+					/* ELB CS0 Mask Register        */
+#define CS0_ACCESS_REG	regptr(MSP_SLP_BASE + 0x8C)
+					/* ELB CS0 access register      */
+
+#define CS1_CNFG_REG	regptr(MSP_SLP_BASE + 0x90)
+					/* ELB CS1 Configuration Reg    */
+#define CS1_ADDR_REG	regptr(MSP_SLP_BASE + 0x94)
+					/* ELB CS1 Base Address Reg     */
+#define CS1_MASK_REG	regptr(MSP_SLP_BASE + 0x98)
+					/* ELB CS1 Mask Register        */
+#define CS1_ACCESS_REG	regptr(MSP_SLP_BASE + 0x9C)
+					/* ELB CS1 access register      */
+
+#define CS2_CNFG_REG	regptr(MSP_SLP_BASE + 0xA0)
+					/* ELB CS2 Configuration Reg    */
+#define CS2_ADDR_REG	regptr(MSP_SLP_BASE + 0xA4)
+					/* ELB CS2 Base Address Reg     */
+#define CS2_MASK_REG	regptr(MSP_SLP_BASE + 0xA8)
+					/* ELB CS2 Mask Register        */
+#define CS2_ACCESS_REG	regptr(MSP_SLP_BASE + 0xAC)
+					/* ELB CS2 access register      */
+
+#define CS3_CNFG_REG	regptr(MSP_SLP_BASE + 0xB0)
+					/* ELB CS3 Configuration Reg    */
+#define CS3_ADDR_REG	regptr(MSP_SLP_BASE + 0xB4)
+					/* ELB CS3 Base Address Reg     */
+#define CS3_MASK_REG	regptr(MSP_SLP_BASE + 0xB8)
+					/* ELB CS3 Mask Register        */
+#define CS3_ACCESS_REG	regptr(MSP_SLP_BASE + 0xBC)
+					/* ELB CS3 access register      */
+
+#define CS4_CNFG_REG	regptr(MSP_SLP_BASE + 0xC0)
+					/* ELB CS4 Configuration Reg    */
+#define CS4_ADDR_REG	regptr(MSP_SLP_BASE + 0xC4)
+					/* ELB CS4 Base Address Reg     */
+#define CS4_MASK_REG	regptr(MSP_SLP_BASE + 0xC8)
+					/* ELB CS4 Mask Register        */
+#define CS4_ACCESS_REG	regptr(MSP_SLP_BASE + 0xCC)
+					/* ELB CS4 access register      */
+
+#define CS5_CNFG_REG	regptr(MSP_SLP_BASE + 0xD0)
+					/* ELB CS5 Configuration Reg    */
+#define CS5_ADDR_REG	regptr(MSP_SLP_BASE + 0xD4)
+					/* ELB CS5 Base Address Reg     */
+#define CS5_MASK_REG	regptr(MSP_SLP_BASE + 0xD8)
+					/* ELB CS5 Mask Register        */
+#define CS5_ACCESS_REG	regptr(MSP_SLP_BASE + 0xDC)
+					/* ELB CS5 access register      */
+
+/* reserved			       0xE0 - 0xE8                      */
+#define ELB_1PC_EN_REG	regptr(MSP_SLP_BASE + 0xEC)
+					/* ELB single PC card detect    */
+
+/* reserved			       0xF0 - 0xF8                      */
+#define ELB_CLK_CFG_REG	regptr(MSP_SLP_BASE + 0xFC)
+					/* SDRAM read/ELB timing Reg    */
+
+/* Extended UART status registers */
+#define UART0_STATUS_REG	regptr(MSP_UART0_BASE + 0x0c0)
+					/* UART Status Register 0       */
+#define UART1_STATUS_REG	regptr(MSP_UART1_BASE + 0x170)
+					/* UART Status Register 1       */
+
+/* Performance monitoring registers */
+#define PERF_MON_CTRL_REG	regptr(MSP_SLP_BASE + 0x140)
+					/* Performance monitor control  */
+#define PERF_MON_CLR_REG	regptr(MSP_SLP_BASE + 0x144)
+					/* Performance monitor clear    */
+#define PERF_MON_CNTH_REG	regptr(MSP_SLP_BASE + 0x148)
+					/* Perf monitor counter high    */
+#define PERF_MON_CNTL_REG	regptr(MSP_SLP_BASE + 0x14C)
+					/* Perf monitor counter low     */
+
+/* System control registers */
+#define SYS_CTRL_REG		regptr(MSP_SLP_BASE + 0x150)
+					/* System control register      */
+#define SYS_ERR1_REG		regptr(MSP_SLP_BASE + 0x154)
+					/* System Error status 1        */
+#define SYS_ERR2_REG		regptr(MSP_SLP_BASE + 0x158)
+					/* System Error status 2        */
+#define SYS_INT_CFG_REG		regptr(MSP_SLP_BASE + 0x15C)
+					/* System Interrupt config      */
+
+/* Voice Engine Memory configuration */
+#define VE_MEM_REG		regptr(MSP_SLP_BASE + 0x17C)
+					/* Voice engine memory config   */
+
+/* CPU/SLP Error Status registers */
+#define CPU_ERR1_REG		regptr(MSP_SLP_BASE + 0x180)
+					/* CPU/SLP Error status 1       */
+#define CPU_ERR2_REG		regptr(MSP_SLP_BASE + 0x184)
+					/* CPU/SLP Error status 1       */
+
+#define EXTENDED_GPIO_REG	regptr(MSP_SLP_BASE + 0x188)
+					/* Extended GPIO register       */
+
+/* System Error registers */
+#define SLP_ERR_STS_REG		regptr(MSP_SLP_BASE + 0x190)
+					/* Int status for SLP errors    */
+#define SLP_ERR_MSK_REG		regptr(MSP_SLP_BASE + 0x194)
+					/* Int mask for SLP errors      */
+#define SLP_ELB_ERST_REG	regptr(MSP_SLP_BASE + 0x198)
+					/* External ELB reset           */
+#define SLP_BOOT_STS_REG	regptr(MSP_SLP_BASE + 0x19C)
+					/* Boot Status                  */
+
+/* Extended ELB addressing */
+#define CS0_EXT_ADDR_REG	regptr(MSP_SLP_BASE + 0x1A0)
+					/* CS0 Extended address         */
+#define CS1_EXT_ADDR_REG	regptr(MSP_SLP_BASE + 0x1A4)
+					/* CS1 Extended address         */
+#define CS2_EXT_ADDR_REG	regptr(MSP_SLP_BASE + 0x1A8)
+					/* CS2 Extended address         */
+#define CS3_EXT_ADDR_REG	regptr(MSP_SLP_BASE + 0x1AC)
+					/* CS3 Extended address         */
+/* reserved					      0x1B0             */
+#define CS5_EXT_ADDR_REG	regptr(MSP_SLP_BASE + 0x1B4)
+					/* CS5 Extended address         */
+
+/* PLL Adjustment registers */
+#define PLL_LOCK_REG		regptr(MSP_SLP_BASE + 0x200)
+					/* PLL0 lock status             */
+#define PLL_ARST_REG		regptr(MSP_SLP_BASE + 0x204)
+					/* PLL Analog reset status      */
+#define PLL0_ADJ_REG		regptr(MSP_SLP_BASE + 0x208)
+					/* PLL0 Adjustment value        */
+#define PLL1_ADJ_REG		regptr(MSP_SLP_BASE + 0x20C)
+					/* PLL1 Adjustment value        */
+
+/*
+ ***************************************************************************
+ * Peripheral Register definitions                                         *
+ ***************************************************************************
+ */
+
+/* Peripheral status */
+#define PER_CTRL_REG		regptr(MSP_PER_BASE + 0x50)
+					/* Peripheral control register  */
+#define PER_STS_REG		regptr(MSP_PER_BASE + 0x54)
+					/* Peripheral status register   */
+
+/* SPI/MPI Registers */
+#define SMPI_TX_SZ_REG		regptr(MSP_PER_BASE + 0x58)
+					/* SPI/MPI Tx Size register     */
+#define SMPI_RX_SZ_REG		regptr(MSP_PER_BASE + 0x5C)
+					/* SPI/MPI Rx Size register     */
+#define SMPI_CTL_REG		regptr(MSP_PER_BASE + 0x60)
+					/* SPI/MPI Control register     */
+#define SMPI_MS_REG		regptr(MSP_PER_BASE + 0x64)
+					/* SPI/MPI Chip Select reg      */
+#define SMPI_CORE_DATA_REG	regptr(MSP_PER_BASE + 0xC0)
+					/* SPI/MPI Core Data reg        */
+#define SMPI_CORE_CTRL_REG	regptr(MSP_PER_BASE + 0xC4)
+					/* SPI/MPI Core Control reg     */
+#define SMPI_CORE_STAT_REG	regptr(MSP_PER_BASE + 0xC8)
+					/* SPI/MPI Core Status reg      */
+#define SMPI_CORE_SSEL_REG	regptr(MSP_PER_BASE + 0xCC)
+					/* SPI/MPI Core Ssel reg        */
+#define SMPI_FIFO_REG		regptr(MSP_PER_BASE + 0xD0)
+					/* SPI/MPI Data FIFO reg        */
+
+/* Peripheral Block Error Registers           */
+#define PER_ERR_STS_REG		regptr(MSP_PER_BASE + 0x70)
+					/* Error Bit Status Register    */
+#define PER_ERR_MSK_REG		regptr(MSP_PER_BASE + 0x74)
+					/* Error Bit Mask Register      */
+#define PER_HDR1_REG		regptr(MSP_PER_BASE + 0x78)
+					/* Error Header 1 Register      */
+#define PER_HDR2_REG		regptr(MSP_PER_BASE + 0x7C)
+					/* Error Header 2 Register      */
+
+/* Peripheral Block Interrupt Registers       */
+#define PER_INT_STS_REG		regptr(MSP_PER_BASE + 0x80)
+					/* Interrupt status register    */
+#define PER_INT_MSK_REG		regptr(MSP_PER_BASE + 0x84)
+					/* Interrupt Mask Register      */
+#define GPIO_INT_STS_REG	regptr(MSP_PER_BASE + 0x88)
+					/* GPIO interrupt status reg    */
+#define GPIO_INT_MSK_REG	regptr(MSP_PER_BASE + 0x8C)
+					/* GPIO interrupt MASK Reg      */
+
+/* POLO GPIO registers                        */
+#define POLO_GPIO_DAT1_REG	regptr(MSP_PER_BASE + 0x0E0)
+					/* Polo GPIO[8:0]  data reg     */
+#define POLO_GPIO_CFG1_REG	regptr(MSP_PER_BASE + 0x0E4)
+					/* Polo GPIO[7:0]  config reg   */
+#define POLO_GPIO_CFG2_REG	regptr(MSP_PER_BASE + 0x0E8)
+					/* Polo GPIO[15:8] config reg   */
+#define POLO_GPIO_OD1_REG	regptr(MSP_PER_BASE + 0x0EC)
+					/* Polo GPIO[31:0] output drive */
+#define POLO_GPIO_CFG3_REG	regptr(MSP_PER_BASE + 0x170)
+					/* Polo GPIO[23:16] config reg  */
+#define POLO_GPIO_DAT2_REG	regptr(MSP_PER_BASE + 0x174)
+					/* Polo GPIO[15:9]  data reg    */
+#define POLO_GPIO_DAT3_REG	regptr(MSP_PER_BASE + 0x178)
+					/* Polo GPIO[23:16]  data reg   */
+#define POLO_GPIO_DAT4_REG	regptr(MSP_PER_BASE + 0x17C)
+					/* Polo GPIO[31:24]  data reg   */
+#define POLO_GPIO_DAT5_REG	regptr(MSP_PER_BASE + 0x180)
+					/* Polo GPIO[39:32]  data reg   */
+#define POLO_GPIO_DAT6_REG	regptr(MSP_PER_BASE + 0x184)
+					/* Polo GPIO[47:40]  data reg   */
+#define POLO_GPIO_DAT7_REG	regptr(MSP_PER_BASE + 0x188)
+					/* Polo GPIO[54:48]  data reg   */
+#define POLO_GPIO_CFG4_REG	regptr(MSP_PER_BASE + 0x18C)
+					/* Polo GPIO[31:24] config reg  */
+#define POLO_GPIO_CFG5_REG	regptr(MSP_PER_BASE + 0x190)
+					/* Polo GPIO[39:32] config reg  */
+#define POLO_GPIO_CFG6_REG	regptr(MSP_PER_BASE + 0x194)
+					/* Polo GPIO[47:40] config reg  */
+#define POLO_GPIO_CFG7_REG	regptr(MSP_PER_BASE + 0x198)
+					/* Polo GPIO[54:48] config reg  */
+#define POLO_GPIO_OD2_REG	regptr(MSP_PER_BASE + 0x19C)
+					/* Polo GPIO[54:32] output drive */
+
+/* Generic GPIO registers                     */
+#define GPIO_DATA1_REG		regptr(MSP_PER_BASE + 0x170)
+					/* GPIO[1:0] data register      */
+#define GPIO_DATA2_REG		regptr(MSP_PER_BASE + 0x174)
+					/* GPIO[5:2] data register      */
+#define GPIO_DATA3_REG		regptr(MSP_PER_BASE + 0x178)
+					/* GPIO[9:6] data register      */
+#define GPIO_DATA4_REG		regptr(MSP_PER_BASE + 0x17C)
+					/* GPIO[15:10] data register    */
+#define GPIO_CFG1_REG		regptr(MSP_PER_BASE + 0x180)
+					/* GPIO[1:0] config register    */
+#define GPIO_CFG2_REG		regptr(MSP_PER_BASE + 0x184)
+					/* GPIO[5:2] config register    */
+#define GPIO_CFG3_REG		regptr(MSP_PER_BASE + 0x188)
+					/* GPIO[9:6] config register    */
+#define GPIO_CFG4_REG		regptr(MSP_PER_BASE + 0x18C)
+					/* GPIO[15:10] config register  */
+#define GPIO_OD_REG		regptr(MSP_PER_BASE + 0x190)
+					/* GPIO[15:0] output drive      */
+
+/*
+ ***************************************************************************
+ * CPU Interface register definitions                                      *
+ ***************************************************************************
+ */
+#define PCI_FLUSH_REG		regptr(MSP_CPUIF_BASE + 0x00)
+					/* PCI-SDRAM queue flush trigger */
+#define OCP_ERR1_REG		regptr(MSP_CPUIF_BASE + 0x04)
+					/* OCP Error Attribute 1        */
+#define OCP_ERR2_REG		regptr(MSP_CPUIF_BASE + 0x08)
+					/* OCP Error Attribute 2        */
+#define OCP_STS_REG		regptr(MSP_CPUIF_BASE + 0x0C)
+					/* OCP Error Status             */
+#define CPUIF_PM_REG		regptr(MSP_CPUIF_BASE + 0x10)
+					/* CPU policy configuration     */
+#define CPUIF_CFG_REG		regptr(MSP_CPUIF_BASE + 0x10)
+					/* Misc configuration options   */
+
+/* Central Interrupt Controller Registers */
+#define MSP_CIC_BASE		(MSP_CPUIF_BASE + 0x8000)
+					/* Central Interrupt registers  */
+#define CIC_EXT_CFG_REG		regptr(MSP_CIC_BASE + 0x00)
+					/* External interrupt config    */
+#define CIC_STS_REG		regptr(MSP_CIC_BASE + 0x04)
+					/* CIC Interrupt Status         */
+#define CIC_VPE0_MSK_REG	regptr(MSP_CIC_BASE + 0x08)
+					/* VPE0 Interrupt Mask          */
+#define CIC_VPE1_MSK_REG	regptr(MSP_CIC_BASE + 0x0C)
+					/* VPE1 Interrupt Mask          */
+#define CIC_TC0_MSK_REG		regptr(MSP_CIC_BASE + 0x10)
+					/* Thread Context 0 Int Mask    */
+#define CIC_TC1_MSK_REG		regptr(MSP_CIC_BASE + 0x14)
+					/* Thread Context 1 Int Mask    */
+#define CIC_TC2_MSK_REG		regptr(MSP_CIC_BASE + 0x18)
+					/* Thread Context 2 Int Mask    */
+#define CIC_TC3_MSK_REG		regptr(MSP_CIC_BASE + 0x18)
+					/* Thread Context 3 Int Mask    */
+#define CIC_TC4_MSK_REG		regptr(MSP_CIC_BASE + 0x18)
+					/* Thread Context 4 Int Mask    */
+#define CIC_PCIMSI_STS_REG	regptr(MSP_CIC_BASE + 0x18)
+#define CIC_PCIMSI_MSK_REG	regptr(MSP_CIC_BASE + 0x18)
+#define CIC_PCIFLSH_REG		regptr(MSP_CIC_BASE + 0x18)
+#define CIC_VPE0_SWINT_REG	regptr(MSP_CIC_BASE + 0x08)
+
+
+/*
+ ***************************************************************************
+ * Memory controller registers                                             *
+ ***************************************************************************
+ */
+#define MEM_CFG1_REG		regptr(MSP_MEM_CFG_BASE + 0x00)
+#define MEM_SS_ADDR		regptr(MSP_MEM_CFG_BASE + 0x00)
+#define MEM_SS_DATA		regptr(MSP_MEM_CFG_BASE + 0x04)
+#define MEM_SS_WRITE		regptr(MSP_MEM_CFG_BASE + 0x08)
+
+/*
+ ***************************************************************************
+ * PCI controller registers                                                *
+ ***************************************************************************
+ */
+#define PCI_BASE_REG		regptr(MSP_PCI_BASE + 0x00)
+#define PCI_CONFIG_SPACE_REG	regptr(MSP_PCI_BASE + 0x800)
+#define PCI_JTAG_DEVID_REG	regptr(MSP_SLP_BASE + 0x13c)
+
+/*
+ ########################################################################
+ #  Register content & macro definitions                                #
+ ########################################################################
+ */
+
+/*
+ ***************************************************************************
+ * DEV_ID defines                                                          *
+ ***************************************************************************
+ */
+#define DEV_ID_PCI_DIS		(1 << 26)       /* Set if PCI disabled */
+#define DEV_ID_PCI_HOST		(1 << 20)       /* Set if PCI host */
+#define DEV_ID_SINGLE_PC	(1 << 19)       /* Set if single PC Card */
+#define DEV_ID_FAMILY		(0xff << 8)     /* family ID code */
+#define POLO_ZEUS_SUB_FAMILY	(0x7  << 16)    /* sub family for Polo/Zeus */
+
+#define MSPFPGA_ID		(0x00  << 8)    /* you are on your own here */
+#define MSP5000_ID		(0x50  << 8)
+#define MSP4F00_ID		(0x4f  << 8)    /* FPGA version of MSP4200 */
+#define MSP4E00_ID		(0x4f  << 8)    /* FPGA version of MSP7120 */
+#define MSP4200_ID		(0x42  << 8)
+#define MSP4000_ID		(0x40  << 8)
+#define MSP2XXX_ID		(0x20  << 8)
+#define MSPZEUS_ID		(0x10  << 8)
+
+#define MSP2004_SUB_ID		(0x0   << 16)
+#define MSP2005_SUB_ID		(0x1   << 16)
+#define MSP2006_SUB_ID		(0x1   << 16)
+#define MSP2007_SUB_ID		(0x2   << 16)
+#define MSP2010_SUB_ID		(0x3   << 16)
+#define MSP2015_SUB_ID		(0x4   << 16)
+#define MSP2020_SUB_ID		(0x5   << 16)
+#define MSP2100_SUB_ID		(0x6   << 16)
+
+/*
+ ***************************************************************************
+ * RESET defines                                                           *
+ ***************************************************************************
+ */
+#define MSP_GR_RST		(0x01 << 0)     /* Global reset bit     */
+#define MSP_MR_RST		(0x01 << 1)     /* MIPS reset bit       */
+#define MSP_PD_RST		(0x01 << 2)     /* PVC DMA reset bit    */
+#define MSP_PP_RST		(0x01 << 3)     /* PVC reset bit        */
+/* reserved                                                             */
+#define MSP_EA_RST		(0x01 << 6)     /* Mac A reset bit      */
+#define MSP_EB_RST		(0x01 << 7)     /* Mac B reset bit      */
+#define MSP_SE_RST		(0x01 << 8)     /* Security Eng reset bit */
+#define MSP_PB_RST		(0x01 << 9)     /* Per block reset bit  */
+#define MSP_EC_RST		(0x01 << 10)    /* Mac C reset bit      */
+#define MSP_TW_RST		(0x01 << 11)    /* TWI reset bit        */
+#define MSP_SPI_RST		(0x01 << 12)    /* SPI/MPI reset bit    */
+#define MSP_U1_RST		(0x01 << 13)    /* UART1 reset bit      */
+#define MSP_U0_RST		(0x01 << 14)    /* UART0 reset bit      */
+
+/*
+ ***************************************************************************
+ * UART defines                                                            *
+ ***************************************************************************
+ */
+#ifndef CONFIG_MSP_FPGA
+#define MSP_BASE_BAUD		25000000
+#else
+#define MSP_BASE_BAUD		6000000
+#endif
+#define MSP_UART_REG_LEN	0x20
+
+/*
+ ***************************************************************************
+ * ELB defines                                                             *
+ ***************************************************************************
+ */
+#define PCCARD_32		0x02    /* Set if is PCCARD 32 (Cardbus) */
+#define SINGLE_PCCARD		0x01    /* Set to enable single PC card */
+
+/*
+ ***************************************************************************
+ * CIC defines                                                             *
+ ***************************************************************************
+ */
+
+/* CIC_EXT_CFG_REG */
+#define EXT_INT_POL(eirq)			(1 << (eirq + 8))
+#define EXT_INT_EDGE(eirq)			(1 << eirq)
+
+#define CIC_EXT_SET_TRIGGER_LEVEL(reg, eirq)	(reg &= ~EXT_INT_EDGE(eirq))
+#define CIC_EXT_SET_TRIGGER_EDGE(reg, eirq)	(reg |= EXT_INT_EDGE(eirq))
+#define CIC_EXT_SET_ACTIVE_HI(reg, eirq)	(reg |= EXT_INT_POL(eirq))
+#define CIC_EXT_SET_ACTIVE_LO(reg, eirq)	(reg &= ~EXT_INT_POL(eirq))
+#define CIC_EXT_SET_ACTIVE_RISING		CIC_EXT_SET_ACTIVE_HI
+#define CIC_EXT_SET_ACTIVE_FALLING		CIC_EXT_SET_ACTIVE_LO
+
+#define CIC_EXT_IS_TRIGGER_LEVEL(reg, eirq) \
+				((reg & EXT_INT_EDGE(eirq)) == 0)
+#define CIC_EXT_IS_TRIGGER_EDGE(reg, eirq)	(reg & EXT_INT_EDGE(eirq))
+#define CIC_EXT_IS_ACTIVE_HI(reg, eirq)		(reg & EXT_INT_POL(eirq))
+#define CIC_EXT_IS_ACTIVE_LO(reg, eirq) \
+				((reg & EXT_INT_POL(eirq)) == 0)
+#define CIC_EXT_IS_ACTIVE_RISING		CIC_EXT_IS_ACTIVE_HI
+#define CIC_EXT_IS_ACTIVE_FALLING		CIC_EXT_IS_ACTIVE_LO
+
+/*
+ ***************************************************************************
+ * Memory Controller defines                                               *
+ ***************************************************************************
+ */
+
+/* Indirect memory controller registers */
+#define DDRC_CFG(n)		(n)
+#define DDRC_DEBUG(n)		(0x04 + n)
+#define DDRC_CTL(n)		(0x40 + n)
+
+/* Macro to perform DDRC indirect write */
+#define DDRC_INDIRECT_WRITE(reg, mask, value) \
+({ \
+	*MEM_SS_ADDR = (((mask) & 0xf) << 8) | ((reg) & 0xff); \
+	*MEM_SS_DATA = (value); \
+	*MEM_SS_WRITE = 1; \
+})
+
+/*
+ ***************************************************************************
+ * SPI/MPI Mode                                                            *
+ ***************************************************************************
+ */
+#define SPI_MPI_RX_BUSY		0x00008000	/* SPI/MPI Receive Busy */
+#define SPI_MPI_FIFO_EMPTY	0x00004000	/* SPI/MPI Fifo Empty   */
+#define SPI_MPI_TX_BUSY		0x00002000	/* SPI/MPI Transmit Busy */
+#define SPI_MPI_FIFO_FULL	0x00001000	/* SPI/MPU FIFO full    */
+
+/*
+ ***************************************************************************
+ * SPI/MPI Control Register                                                *
+ ***************************************************************************
+ */
+#define SPI_MPI_RX_START	0x00000004	/* Start receive command */
+#define SPI_MPI_FLUSH_Q		0x00000002	/* Flush SPI/MPI Queue */
+#define SPI_MPI_TX_START	0x00000001	/* Start Transmit Command */
+
+#endif /* !_ASM_MSP_REGS_H */
diff --git a/include/asm-mips/pmc-sierra/msp71xx/msp_slp_int.h b/include/asm-mips/pmc-sierra/msp71xx/msp_slp_int.h
new file mode 100644
index 0000000..96d4c8c
--- /dev/null
+++ b/include/asm-mips/pmc-sierra/msp71xx/msp_slp_int.h
@@ -0,0 +1,141 @@
+/*
+ * Defines for the MSP interrupt controller.
+ *
+ * Copyright (C) 1999 MIPS Technologies, Inc.  All rights reserved.
+ * Author: Carsten Langgaard, carstenl@mips.com
+ *
+ * ########################################################################
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ *
+ * ########################################################################
+ */
+
+#ifndef _MSP_SLP_INT_H
+#define _MSP_SLP_INT_H
+
+/*
+ * The PMC-Sierra SLP interrupts are arranged in a 3 level cascaded
+ * hierarchical system.  The first level are the direct MIPS interrupts
+ * and are assigned the interrupt range 0-7.  The second level is the SLM
+ * interrupt controller and is assigned the range 8-39.  The third level
+ * comprises the Peripherial block, the PCI block, the PCI MSI block and
+ * the SLP.  The PCI interrupts and the SLP errors are handled by the
+ * relevant subsystems so the core interrupt code needs only concern
+ * itself with the Peripheral block.  These are assigned interrupts in
+ * the range 40-71.
+ */
+
+/*
+ * IRQs directly connected to CPU
+ */
+#define MSP_MIPS_INTBASE	0
+#define MSP_INT_SW0		0  /* IRQ for swint0,         C_SW0  */
+#define MSP_INT_SW1		1  /* IRQ for swint1,         C_SW1  */
+#define MSP_INT_MAC0 		2  /* IRQ for MAC 0,          C_IRQ0 */
+#define MSP_INT_MAC1		3  /* IRQ for MAC 1,          C_IRQ1 */
+#define MSP_INT_C_IRQ2		4  /* Wired off,              C_IRQ2 */
+#define MSP_INT_VE		5  /* IRQ for Voice Engine,   C_IRQ3 */
+#define MSP_INT_SLP		6  /* IRQ for SLM block,      C_IRQ4 */
+#define MSP_INT_TIMER		7  /* IRQ for the MIPS timer, C_IRQ5 */
+
+/*
+ * IRQs cascaded on CPU interrupt 4 (CAUSE bit 12, C_IRQ4)
+ * These defines should be tied to the register definition for the SLM
+ * interrupt routine.  For now, just use hard-coded values.
+ */
+#define MSP_SLP_INTBASE		(MSP_MIPS_INTBASE + 8)
+#define MSP_INT_EXT0		(MSP_SLP_INTBASE + 0)
+					/* External interrupt 0         */
+#define MSP_INT_EXT1		(MSP_SLP_INTBASE + 1)
+					/* External interrupt 1         */
+#define MSP_INT_EXT2		(MSP_SLP_INTBASE + 2)
+					/* External interrupt 2         */
+#define MSP_INT_EXT3		(MSP_SLP_INTBASE + 3)
+					/* External interrupt 3         */
+/* Reserved					   4-7                  */
+
+/*
+ *************************************************************************
+ * DANGER/DANGER/DANGER/DANGER/DANGER/DANGER/DANGER/DANGER/DANGER/DANGER *
+ * Some MSP produces have this interrupt labelled as Voice and some are  *
+ * SEC mbox ...                                                          *
+ *************************************************************************
+ */
+#define MSP_INT_SLP_VE		(MSP_SLP_INTBASE + 8)
+					/* Cascaded IRQ for Voice Engine*/
+#define MSP_INT_SLP_TDM		(MSP_SLP_INTBASE + 9)
+					/* TDM interrupt                */
+#define MSP_INT_SLP_MAC0	(MSP_SLP_INTBASE + 10)
+					/* Cascaded IRQ for MAC 0       */
+#define MSP_INT_SLP_MAC1	(MSP_SLP_INTBASE + 11)
+					/* Cascaded IRQ for MAC 1       */
+#define MSP_INT_SEC		(MSP_SLP_INTBASE + 12)
+					/* IRQ for security engine      */
+#define	MSP_INT_PER		(MSP_SLP_INTBASE + 13)
+					/* Peripheral interrupt         */
+#define	MSP_INT_TIMER0		(MSP_SLP_INTBASE + 14)
+					/* SLP timer 0                  */
+#define	MSP_INT_TIMER1		(MSP_SLP_INTBASE + 15)
+					/* SLP timer 1                  */
+#define	MSP_INT_TIMER2		(MSP_SLP_INTBASE + 16)
+					/* SLP timer 2                  */
+#define	MSP_INT_SLP_TIMER	(MSP_SLP_INTBASE + 17)
+					/* Cascaded MIPS timer          */
+#define MSP_INT_BLKCP		(MSP_SLP_INTBASE + 18)
+					/* Block Copy                   */
+#define MSP_INT_UART0		(MSP_SLP_INTBASE + 19)
+					/* UART 0                       */
+#define MSP_INT_PCI		(MSP_SLP_INTBASE + 20)
+					/* PCI subsystem                */
+#define MSP_INT_PCI_DBELL	(MSP_SLP_INTBASE + 21)
+					/* PCI doorbell                 */
+#define MSP_INT_PCI_MSI		(MSP_SLP_INTBASE + 22)
+					/* PCI Message Signal           */
+#define MSP_INT_PCI_BC0		(MSP_SLP_INTBASE + 23)
+					/* PCI Block Copy 0             */
+#define MSP_INT_PCI_BC1		(MSP_SLP_INTBASE + 24)
+					/* PCI Block Copy 1             */
+#define MSP_INT_SLP_ERR		(MSP_SLP_INTBASE + 25)
+					/* SLP error condition          */
+#define MSP_INT_MAC2		(MSP_SLP_INTBASE + 26)
+					/* IRQ for MAC2                 */
+/* Reserved					   26-31                */
+
+/*
+ * IRQs cascaded on SLP PER interrupt (MSP_INT_PER)
+ */
+#define MSP_PER_INTBASE		(MSP_SLP_INTBASE + 32)
+/* Reserved					   0-1                  */
+#define MSP_INT_UART1		(MSP_PER_INTBASE + 2)
+					/* UART 1                       */
+/* Reserved					   3-5                  */
+#define MSP_INT_2WIRE		(MSP_PER_INTBASE + 6)
+					/* 2-wire                       */
+#define MSP_INT_TM0		(MSP_PER_INTBASE + 7)
+					/* Peripheral timer block out 0 */
+#define MSP_INT_TM1		(MSP_PER_INTBASE + 8)
+					/* Peripheral timer block out 1 */
+/* Reserved					   9                    */
+#define MSP_INT_SPRX		(MSP_PER_INTBASE + 10)
+					/* SPI RX complete              */
+#define MSP_INT_SPTX		(MSP_PER_INTBASE + 11)
+					/* SPI TX complete              */
+#define MSP_INT_GPIO		(MSP_PER_INTBASE + 12)
+					/* GPIO                         */
+#define MSP_INT_PER_ERR		(MSP_PER_INTBASE + 13)
+					/* Peripheral error             */
+/* Reserved					   14-31                */
+
+#endif /* !_MSP_SLP_INT_H */
diff --git a/include/asm-mips/pmc-sierra/msp71xx/msp_regops.h b/include/asm-mips/pmc-sierra/msp71xx/msp_regops.h
new file mode 100644
index 0000000..60a5a38
--- /dev/null
+++ b/include/asm-mips/pmc-sierra/msp71xx/msp_regops.h
@@ -0,0 +1,236 @@
+/*
+ * SMP/VPE-safe functions to access "registers" (see note).
+ *
+ * NOTES:
+* - These macros use ll/sc instructions, so it is your responsibility to
+ * ensure these are available on your platform before including this file.
+ * - The MIPS32 spec states that ll/sc results are undefined for uncached
+ * accesses. This means they can't be used on HW registers accessed
+ * through kseg1. Code which requires these macros for this purpose must
+ * front-end the registers with cached memory "registers" and have a single
+ * thread update the actual HW registers.
+ * - A maximum of 2k of code can be inserted between ll and sc. Every
+ * memory accesses between the instructions will increase the chance of
+ * sc failing and having to loop.
+ * - When using custom_read_reg32/custom_write_reg32 only perform the
+ * necessary logical operations on the register value in between these
+ * two calls. All other logic should be performed before the first call.
+  * - There is a bug on the R10000 chips which has a workaround. If you
+ * are affected by this bug, make sure to define the symbol 'R10000_LLSC_WAR'
+ * to be non-zero.  If you are using this header from within linux, you may
+ * include <asm/war.h> before including this file to have this defined
+ * appropriately for you.
+ *
+ * Copyright 2005-2007 PMC-Sierra, Inc.
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO
+ *  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ *  LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF USE,
+ *  DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+ *  THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc., 675
+ *  Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef __ASM_REGOPS_H__
+#define __ASM_REGOPS_H__
+
+#include <linux/types.h>
+
+#include <asm/war.h>
+
+#ifndef R10000_LLSC_WAR
+#define R10000_LLSC_WAR 0
+#endif
+
+#if R10000_LLSC_WAR == 1
+#define __beqz	"beqzl	"
+#else
+#define __beqz	"beqz	"
+#endif
+
+#ifndef _LINUX_TYPES_H
+typedef unsigned int u32;
+#endif
+
+/*
+ * Sets all the masked bits to the corresponding value bits
+ */
+static inline void set_value_reg32(volatile u32 *const addr,
+					u32 const mask,
+					u32 const value)
+{
+	u32 temp;
+
+	__asm__ __volatile__(
+	"	.set	push				\n"
+	"	.set	mips3				\n"
+	"1:	ll	%0, %1	# set_value_reg32	\n"
+	"	and	%0, %2				\n"
+	"	or	%0, %3				\n"
+	"	sc	%0, %1				\n"
+	"	"__beqz"%0, 1b				\n"
+	"	nop					\n"
+	"	.set	pop				\n"
+	: "=&r" (temp), "=m" (*addr)
+	: "ir" (~mask), "ir" (value), "m" (*addr));
+}
+
+/*
+ * Sets all the masked bits to '1'
+ */
+static inline void set_reg32(volatile u32 *const addr,
+				u32 const mask)
+{
+	u32 temp;
+
+	__asm__ __volatile__(
+	"	.set	push				\n"
+	"	.set	mips3				\n"
+	"1:	ll	%0, %1		# set_reg32	\n"
+	"	or	%0, %2				\n"
+	"	sc	%0, %1				\n"
+	"	"__beqz"%0, 1b				\n"
+	"	nop					\n"
+	"	.set	pop				\n"
+	: "=&r" (temp), "=m" (*addr)
+	: "ir" (mask), "m" (*addr));
+}
+
+/*
+ * Sets all the masked bits to '0'
+ */
+static inline void clear_reg32(volatile u32 *const addr,
+				u32 const mask)
+{
+	u32 temp;
+
+	__asm__ __volatile__(
+	"	.set	push				\n"
+	"	.set	mips3				\n"
+	"1:	ll	%0, %1		# clear_reg32	\n"
+	"	and	%0, %2				\n"
+	"	sc	%0, %1				\n"
+	"	"__beqz"%0, 1b				\n"
+	"	nop					\n"
+	"	.set	pop				\n"
+	: "=&r" (temp), "=m" (*addr)
+	: "ir" (~mask), "m" (*addr));
+}
+
+/*
+ * Toggles all masked bits from '0' to '1' and '1' to '0'
+ */
+static inline void toggle_reg32(volatile u32 *const addr,
+				u32 const mask)
+{
+	u32 temp;
+
+	__asm__ __volatile__(
+	"	.set	push				\n"
+	"	.set	mips3				\n"
+	"1:	ll	%0, %1		# toggle_reg32	\n"
+	"	xor	%0, %2				\n"
+	"	sc	%0, %1				\n"
+	"	"__beqz"%0, 1b				\n"
+	"	nop					\n"
+	"	.set	pop				\n"
+	: "=&r" (temp), "=m" (*addr)
+	: "ir" (mask), "m" (*addr));
+}
+
+/*
+ * Read all masked bits others are returned as '0'
+ */
+static inline u32 read_reg32(volatile u32 *const addr,
+				u32 const mask)
+{
+	u32 temp;
+
+	__asm__ __volatile__(
+	"	.set	push				\n"
+	"	.set	noreorder			\n"
+	"	lw	%0, %1		# read		\n"
+	"	and	%0, %2		# mask		\n"
+	"	.set	pop				\n"
+	: "=&r" (temp)
+	: "m" (*addr), "ir" (mask));
+
+	return temp;
+}
+
+/*
+ * blocking_read_reg32 - Read address with blocking load
+ *
+ * Uncached writes need to be read back to ensure they reach RAM.
+ * The returned value must be 'used' to prevent from becoming a
+ * non-blocking load.
+ */
+static inline u32 blocking_read_reg32(volatile u32 *const addr)
+{
+	u32 temp;
+
+	__asm__ __volatile__(
+	"	.set	push				\n"
+	"	.set	noreorder			\n"
+	"	lw	%0, %1		# read		\n"
+	"	move	%0, %0		# block		\n"
+	"	.set	pop				\n"
+	: "=&r" (temp)
+	: "m" (*addr));
+
+	return temp;
+}
+
+/*
+ * For special strange cases only:
+ *
+ * If you need custom processing within a ll/sc loop, use the following macros
+ * VERY CAREFULLY:
+ *
+ *   u32 tmp;				<-- Define a variable to hold the data
+ *
+ *   custom_read_reg32(address, tmp);	<-- Reads the address and put the value
+ *						in the 'tmp' variable given
+ *
+ *	From here on out, you are (basicly) atomic, so don't do anything too
+ *	fancy!
+ *	Also, this code may loop if the end of this block fails to write
+ *	everything back safely due do the other CPU, so do NOT do anything
+ *	with side-effects!
+ *
+ *   custom_write_reg32(address, tmp);	<-- Writes back 'tmp' safely.
+ */
+#define custom_read_reg32(address, tmp)				\
+	__asm__ __volatile__(					\
+	"	.set	push				\n"	\
+	"	.set	mips3				\n"	\
+	"1:	ll	%0, %1	#custom_read_reg32	\n"	\
+	"	.set	pop				\n"	\
+	: "=r" (tmp), "=m" (*address)				\
+	: "m" (*address))
+
+#define custom_write_reg32(address, tmp)			\
+	__asm__ __volatile__(					\
+	"	.set	push				\n"	\
+	"	.set	mips3				\n"	\
+	"	sc	%0, %1	#custom_write_reg32	\n"	\
+	"	"__beqz"%0, 1b				\n"	\
+	"	nop					\n"	\
+	"	.set	pop				\n"	\
+	: "=&r" (tmp), "=m" (*address)				\
+	: "0" (tmp), "m" (*address))
+
+#endif  /* __ASM_REGOPS_H__ */
