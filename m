Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Sep 2008 14:24:05 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:22237 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20031259AbYIANWo (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 1 Sep 2008 14:22:44 +0100
Received: from localhost.localdomain (p5198-ipad203funabasi.chiba.ocn.ne.jp [222.146.84.198])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 7BE4FB642; Mon,  1 Sep 2008 22:22:38 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 4/6] TXx9: Add TX4939 SoC support
Date:	Mon,  1 Sep 2008 22:22:39 +0900
Message-Id: <1220275361-5001-4-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.6.3
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20398
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/pci/Makefile                |    1 +
 arch/mips/pci/pci-tx4939.c            |  109 +++++++
 arch/mips/txx9/Kconfig                |    7 +
 arch/mips/txx9/generic/Makefile       |    1 +
 arch/mips/txx9/generic/irq_tx4939.c   |  215 +++++++++++++
 arch/mips/txx9/generic/setup_tx4939.c |  460 ++++++++++++++++++++++++++++
 include/asm-mips/txx9/tx4939.h        |  544 +++++++++++++++++++++++++++++++++
 7 files changed, 1337 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/pci/pci-tx4939.c
 create mode 100644 arch/mips/txx9/generic/irq_tx4939.c
 create mode 100644 arch/mips/txx9/generic/setup_tx4939.c
 create mode 100644 include/asm-mips/txx9/tx4939.h

diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
index 15e01ae..9a20985 100644
--- a/arch/mips/pci/Makefile
+++ b/arch/mips/pci/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_TANBAC_TB0287)	+= fixup-tb0287.o
 obj-$(CONFIG_TOSHIBA_JMR3927)	+= fixup-jmr3927.o
 obj-$(CONFIG_SOC_TX4927)	+= pci-tx4927.o
 obj-$(CONFIG_SOC_TX4938)	+= pci-tx4938.o
+obj-$(CONFIG_SOC_TX4939)	+= pci-tx4939.o
 obj-$(CONFIG_TOSHIBA_RBTX4927)	+= fixup-rbtx4927.o
 obj-$(CONFIG_TOSHIBA_RBTX4938)	+= fixup-rbtx4938.o
 obj-$(CONFIG_VICTOR_MPC30X)	+= fixup-mpc30x.o
diff --git a/arch/mips/pci/pci-tx4939.c b/arch/mips/pci/pci-tx4939.c
new file mode 100644
index 0000000..5fecf1c
--- /dev/null
+++ b/arch/mips/pci/pci-tx4939.c
@@ -0,0 +1,109 @@
+/*
+ * linux/arch/mips/pci/pci-tx4939.c
+ *
+ * Based on linux/arch/mips/txx9/rbtx4939/setup.c,
+ *	    and RBTX49xx patch from CELF patch archive.
+ *
+ * Copyright 2001, 2003-2005 MontaVista Software Inc.
+ * Copyright (C) 2004 by Ralf Baechle (ralf@linux-mips.org)
+ * (C) Copyright TOSHIBA CORPORATION 2000-2001, 2004-2007
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <asm/txx9/generic.h>
+#include <asm/txx9/tx4939.h>
+
+int __init tx4939_report_pciclk(void)
+{
+	int pciclk = 0;
+
+	pr_info("PCIC --%s PCICLK:",
+		(__raw_readq(&tx4939_ccfgptr->ccfg) & TX4939_CCFG_PCI66) ?
+		" PCI66" : "");
+	if (__raw_readq(&tx4939_ccfgptr->pcfg) & TX4939_PCFG_PCICLKEN_ALL) {
+		pciclk = txx9_master_clock * 20 / 6;
+		if (!(__raw_readq(&tx4939_ccfgptr->ccfg) & TX4939_CCFG_PCI66))
+			pciclk /= 2;
+		printk(KERN_CONT "Internal(%u.%uMHz)",
+		       (pciclk + 50000) / 1000000,
+		       ((pciclk + 50000) / 100000) % 10);
+	} else {
+		printk(KERN_CONT "External");
+		pciclk = -1;
+	}
+	printk(KERN_CONT "\n");
+	return pciclk;
+}
+
+void __init tx4939_report_pci1clk(void)
+{
+	unsigned int pciclk = txx9_master_clock * 20 / 6;
+
+	pr_info("PCIC1 -- PCICLK:%u.%uMHz\n",
+		(pciclk + 50000) / 1000000,
+		((pciclk + 50000) / 100000) % 10);
+}
+
+int __init tx4939_pcic1_map_irq(const struct pci_dev *dev, u8 slot)
+{
+	if (get_tx4927_pcicptr(dev->bus->sysdata) == tx4939_pcic1ptr) {
+		switch (slot) {
+		case TX4927_PCIC_IDSEL_AD_TO_SLOT(31):
+			if (__raw_readq(&tx4939_ccfgptr->pcfg) &
+			    TX4939_PCFG_ET0MODE)
+				return TXX9_IRQ_BASE + TX4939_IR_ETH(0);
+			break;
+		case TX4927_PCIC_IDSEL_AD_TO_SLOT(30):
+			if (__raw_readq(&tx4939_ccfgptr->pcfg) &
+			    TX4939_PCFG_ET1MODE)
+				return TXX9_IRQ_BASE + TX4939_IR_ETH(1);
+			break;
+		}
+		return 0;
+	}
+	return -1;
+}
+
+int __init tx4939_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+{
+	int irq = tx4939_pcic1_map_irq(dev, slot);
+
+	if (irq >= 0)
+		return irq;
+	irq = pin;
+	/* IRQ rotation */
+	irq--;	/* 0-3 */
+	irq = (irq + 33 - slot) % 4;
+	irq++;	/* 1-4 */
+
+	switch (irq) {
+	case 1:
+		irq = TXX9_IRQ_BASE + TX4939_IR_INTA;
+		break;
+	case 2:
+		irq = TXX9_IRQ_BASE + TX4939_IR_INTB;
+		break;
+	case 3:
+		irq = TXX9_IRQ_BASE + TX4939_IR_INTC;
+		break;
+	case 4:
+		irq = TXX9_IRQ_BASE + TX4939_IR_INTD;
+		break;
+	}
+	return irq;
+}
+
+void __init tx4939_setup_pcierr_irq(void)
+{
+	if (request_irq(TXX9_IRQ_BASE + TX4939_IR_PCIERR,
+			tx4927_pcierr_interrupt,
+			IRQF_DISABLED, "PCI error",
+			(void *)TX4939_PCIC_REG))
+		pr_warning("Failed to request irq for PCIERR\n");
+}
diff --git a/arch/mips/txx9/Kconfig b/arch/mips/txx9/Kconfig
index aade334..58691a1 100644
--- a/arch/mips/txx9/Kconfig
+++ b/arch/mips/txx9/Kconfig
@@ -71,6 +71,13 @@ config SOC_TX4938
 	select PCI_TX4927
 	select GPIO_TXX9
 
+config SOC_TX4939
+	bool
+	select CEVT_TXX9
+	select HAS_TXX9_SERIAL
+	select HW_HAS_PCI
+	select PCI_TX4927
+
 config TOSHIBA_FPCIB0
 	bool "FPCIB0 Backplane Support"
 	depends on PCI && MACH_TXX9
diff --git a/arch/mips/txx9/generic/Makefile b/arch/mips/txx9/generic/Makefile
index 986852c..0030d23 100644
--- a/arch/mips/txx9/generic/Makefile
+++ b/arch/mips/txx9/generic/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_PCI)	+= pci.o
 obj-$(CONFIG_SOC_TX3927)	+= setup_tx3927.o irq_tx3927.o
 obj-$(CONFIG_SOC_TX4927)	+= mem_tx4927.o setup_tx4927.o irq_tx4927.o
 obj-$(CONFIG_SOC_TX4938)	+= mem_tx4927.o setup_tx4938.o irq_tx4938.o
+obj-$(CONFIG_SOC_TX4939)	+= setup_tx4939.o irq_tx4939.o
 obj-$(CONFIG_TOSHIBA_FPCIB0)	+= smsc_fdc37m81x.o
 obj-$(CONFIG_SPI)		+= spi_eeprom.o
 
diff --git a/arch/mips/txx9/generic/irq_tx4939.c b/arch/mips/txx9/generic/irq_tx4939.c
new file mode 100644
index 0000000..013213a
--- /dev/null
+++ b/arch/mips/txx9/generic/irq_tx4939.c
@@ -0,0 +1,215 @@
+/*
+ * TX4939 irq routines
+ * Based on linux/arch/mips/kernel/irq_txx9.c,
+ *	    and RBTX49xx patch from CELF patch archive.
+ *
+ * Copyright 2001, 2003-2005 MontaVista Software Inc.
+ * Author: MontaVista Software, Inc.
+ *         ahennessy@mvista.com
+ *         source@mvista.com
+ * Copyright (C) 2000-2001,2005-2007 Toshiba Corporation
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+/*
+ * TX4939 defines 64 IRQs.
+ * Similer to irq_txx9.c but different register layouts.
+ */
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/types.h>
+#include <asm/irq_cpu.h>
+#include <asm/txx9irq.h>
+#include <asm/txx9/tx4939.h>
+
+/* IRCER : Int. Control Enable */
+#define TXx9_IRCER_ICE	0x00000001
+
+/* IRCR : Int. Control */
+#define TXx9_IRCR_LOW	0x00000000
+#define TXx9_IRCR_HIGH	0x00000001
+#define TXx9_IRCR_DOWN	0x00000002
+#define TXx9_IRCR_UP	0x00000003
+#define TXx9_IRCR_EDGE(cr)	((cr) & 0x00000002)
+
+/* IRSCR : Int. Status Control */
+#define TXx9_IRSCR_EIClrE	0x00000100
+#define TXx9_IRSCR_EIClr_MASK	0x0000000f
+
+/* IRCSR : Int. Current Status */
+#define TXx9_IRCSR_IF	0x00010000
+
+#define irc_dlevel	0
+#define irc_elevel	1
+
+static struct {
+	unsigned char level;
+	unsigned char mode;
+} tx4939irq[TX4939_NUM_IR] __read_mostly;
+
+static void tx4939_irq_unmask(unsigned int irq)
+{
+	unsigned int irq_nr = irq - TXX9_IRQ_BASE;
+	u32 __iomem *lvlp;
+	int ofs;
+	if (irq_nr < 32) {
+		irq_nr--;
+		lvlp = &tx4939_ircptr->lvl[(irq_nr % 16) / 2].r;
+	} else {
+		irq_nr -= 32;
+		lvlp = &tx4939_ircptr->lvl[8 + (irq_nr % 16) / 2].r;
+	}
+	ofs = (irq_nr & 16) + (irq_nr & 1) * 8;
+	__raw_writel((__raw_readl(lvlp) & ~(0xff << ofs))
+		     | (tx4939irq[irq_nr].level << ofs),
+		     lvlp);
+}
+
+static inline void tx4939_irq_mask(unsigned int irq)
+{
+	unsigned int irq_nr = irq - TXX9_IRQ_BASE;
+	u32 __iomem *lvlp;
+	int ofs;
+	if (irq_nr < 32) {
+		irq_nr--;
+		lvlp = &tx4939_ircptr->lvl[(irq_nr % 16) / 2].r;
+	} else {
+		irq_nr -= 32;
+		lvlp = &tx4939_ircptr->lvl[8 + (irq_nr % 16) / 2].r;
+	}
+	ofs = (irq_nr & 16) + (irq_nr & 1) * 8;
+	__raw_writel((__raw_readl(lvlp) & ~(0xff << ofs))
+		     | (irc_dlevel << ofs),
+		     lvlp);
+	mmiowb();
+}
+
+static void tx4939_irq_mask_ack(unsigned int irq)
+{
+	unsigned int irq_nr = irq - TXX9_IRQ_BASE;
+
+	tx4939_irq_mask(irq);
+	if (TXx9_IRCR_EDGE(tx4939irq[irq_nr].mode)) {
+		irq_nr--;
+		/* clear edge detection */
+		__raw_writel((TXx9_IRSCR_EIClrE | (irq_nr & 0xf))
+			     << (irq_nr & 0x10),
+			     &tx4939_ircptr->edc.r);
+	}
+}
+
+static int tx4939_irq_set_type(unsigned int irq, unsigned int flow_type)
+{
+	unsigned int irq_nr = irq - TXX9_IRQ_BASE;
+	u32 cr;
+	u32 __iomem *crp;
+	int ofs;
+	int mode;
+
+	if (flow_type & IRQF_TRIGGER_PROBE)
+		return 0;
+	switch (flow_type & IRQF_TRIGGER_MASK) {
+	case IRQF_TRIGGER_RISING:
+		mode = TXx9_IRCR_UP;
+		break;
+	case IRQF_TRIGGER_FALLING:
+		mode = TXx9_IRCR_DOWN;
+		break;
+	case IRQF_TRIGGER_HIGH:
+		mode = TXx9_IRCR_HIGH;
+		break;
+	case IRQF_TRIGGER_LOW:
+		mode = TXx9_IRCR_LOW;
+		break;
+	default:
+		return -EINVAL;
+	}
+	if (irq_nr < 32) {
+		irq_nr--;
+		crp = &tx4939_ircptr->dm[(irq_nr & 8) >> 3].r;
+	} else {
+		irq_nr -= 32;
+		crp = &tx4939_ircptr->dm2[((irq_nr & 8) >> 3)].r;
+	}
+	ofs = (((irq_nr & 16) >> 1) | (irq_nr & (8 - 1))) * 2;
+	cr = __raw_readl(crp);
+	cr &= ~(0x3 << ofs);
+	cr |= (mode & 0x3) << ofs;
+	__raw_writel(cr, crp);
+	tx4939irq[irq_nr].mode = mode;
+	return 0;
+}
+
+static struct irq_chip tx4939_irq_chip = {
+	.name		= "TX4939",
+	.ack		= tx4939_irq_mask_ack,
+	.mask		= tx4939_irq_mask,
+	.mask_ack	= tx4939_irq_mask_ack,
+	.unmask		= tx4939_irq_unmask,
+	.set_type	= tx4939_irq_set_type,
+};
+
+static int tx4939_irq_set_pri(int irc_irq, int new_pri)
+{
+	int old_pri;
+
+	if ((unsigned int)irc_irq >= TX4939_NUM_IR)
+		return 0;
+	old_pri = tx4939irq[irc_irq].level;
+	tx4939irq[irc_irq].level = new_pri;
+	return old_pri;
+}
+
+void __init tx4939_irq_init(void)
+{
+	int i;
+
+	mips_cpu_irq_init();
+	/* disable interrupt control */
+	__raw_writel(0, &tx4939_ircptr->den.r);
+	__raw_writel(0, &tx4939_ircptr->maskint.r);
+	__raw_writel(0, &tx4939_ircptr->maskext.r);
+	/* irq_base + 0 is not used */
+	for (i = 1; i < TX4939_NUM_IR; i++) {
+		tx4939irq[i].level = 4; /* middle level */
+		tx4939irq[i].mode = TXx9_IRCR_LOW;
+		set_irq_chip_and_handler(TXX9_IRQ_BASE + i,
+					 &tx4939_irq_chip, handle_level_irq);
+	}
+
+	/* mask all IRC interrupts */
+	__raw_writel(0, &tx4939_ircptr->msk.r);
+	for (i = 0; i < 16; i++)
+		__raw_writel(0, &tx4939_ircptr->lvl[i].r);
+	/* setup IRC interrupt mode (Low Active) */
+	for (i = 0; i < 2; i++)
+		__raw_writel(0, &tx4939_ircptr->dm[i].r);
+	for (i = 0; i < 2; i++)
+		__raw_writel(0, &tx4939_ircptr->dm2[i].r);
+	/* enable interrupt control */
+	__raw_writel(TXx9_IRCER_ICE, &tx4939_ircptr->den.r);
+	__raw_writel(irc_elevel, &tx4939_ircptr->msk.r);
+
+	set_irq_chained_handler(MIPS_CPU_IRQ_BASE + TX4939_IRC_INT,
+				handle_simple_irq);
+
+	/* raise priority for errors, timers, sio */
+	tx4939_irq_set_pri(TX4939_IR_WTOERR, 7);
+	tx4939_irq_set_pri(TX4939_IR_PCIERR, 7);
+	tx4939_irq_set_pri(TX4939_IR_PCIPME, 7);
+	for (i = 0; i < TX4939_NUM_IR_TMR; i++)
+		tx4939_irq_set_pri(TX4939_IR_TMR(i), 6);
+	for (i = 0; i < TX4939_NUM_IR_SIO; i++)
+		tx4939_irq_set_pri(TX4939_IR_SIO(i), 5);
+}
+
+int tx4939_irq(void)
+{
+	u32 csr = __raw_readl(&tx4939_ircptr->cs.r);
+
+	if (likely(!(csr & TXx9_IRCSR_IF)))
+		return TXX9_IRQ_BASE + (csr & (TX4939_NUM_IR - 1));
+	return -1;
+}
diff --git a/arch/mips/txx9/generic/setup_tx4939.c b/arch/mips/txx9/generic/setup_tx4939.c
new file mode 100644
index 0000000..f14a497
--- /dev/null
+++ b/arch/mips/txx9/generic/setup_tx4939.c
@@ -0,0 +1,460 @@
+/*
+ * TX4939 setup routines
+ * Based on linux/arch/mips/txx9/generic/setup_tx4938.c,
+ *	    and RBTX49xx patch from CELF patch archive.
+ *
+ * 2003-2005 (c) MontaVista Software, Inc.
+ * (C) Copyright TOSHIBA CORPORATION 2000-2001, 2004-2007
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/delay.h>
+#include <linux/netdevice.h>
+#include <linux/notifier.h>
+#include <linux/sysdev.h>
+#include <linux/ethtool.h>
+#include <linux/param.h>
+#include <linux/ptrace.h>
+#include <linux/mtd/physmap.h>
+#include <asm/bootinfo.h>
+#include <asm/reboot.h>
+#include <asm/traps.h>
+#include <asm/txx9irq.h>
+#include <asm/txx9tmr.h>
+#include <asm/txx9/generic.h>
+#include <asm/txx9/tx4939.h>
+
+static void __init tx4939_wdr_init(void)
+{
+	/* report watchdog reset status */
+	if (____raw_readq(&tx4939_ccfgptr->ccfg) & TX4939_CCFG_WDRST)
+		pr_warning("Watchdog reset detected at 0x%lx\n",
+			   read_c0_errorepc());
+	/* clear WatchDogReset (W1C) */
+	tx4939_ccfg_set(TX4939_CCFG_WDRST);
+	/* do reset on watchdog */
+	tx4939_ccfg_set(TX4939_CCFG_WR);
+}
+
+void __init tx4939_wdt_init(void)
+{
+	txx9_wdt_init(TX4939_TMR_REG(2) & 0xfffffffffULL);
+}
+
+static void tx4939_machine_restart(char *command)
+{
+	local_irq_disable();
+	pr_emerg("Rebooting (with %s watchdog reset)...\n",
+		 (____raw_readq(&tx4939_ccfgptr->ccfg) & TX4939_CCFG_WDREXEN) ?
+		 "external" : "internal");
+	/* clear watchdog status */
+	tx4939_ccfg_set(TX4939_CCFG_WDRST);	/* W1C */
+	txx9_wdt_now(TX4939_TMR_REG(2) & 0xfffffffffULL);
+	while (!(____raw_readq(&tx4939_ccfgptr->ccfg) & TX4939_CCFG_WDRST))
+		;
+	mdelay(10);
+	if (____raw_readq(&tx4939_ccfgptr->ccfg) & TX4939_CCFG_WDREXEN) {
+		pr_emerg("Rebooting (with internal watchdog reset)...\n");
+		/* External WDRST failed.  Do internal watchdog reset */
+		tx4939_ccfg_clear(TX4939_CCFG_WDREXEN);
+	}
+	/* fallback */
+	(*_machine_halt)();
+}
+
+void show_registers(struct pt_regs *regs);
+static int tx4939_be_handler(struct pt_regs *regs, int is_fixup)
+{
+	int data = regs->cp0_cause & 4;
+	console_verbose();
+	pr_err("%cBE exception at %#lx\n",
+	       data ? 'D' : 'I', regs->cp0_epc);
+	pr_err("ccfg:%llx, toea:%llx\n",
+	       (unsigned long long)____raw_readq(&tx4939_ccfgptr->ccfg),
+	       (unsigned long long)____raw_readq(&tx4939_ccfgptr->toea));
+#ifdef CONFIG_PCI
+	tx4927_report_pcic_status();
+#endif
+	show_registers(regs);
+	panic("BusError!");
+}
+static void __init tx4939_be_init(void)
+{
+	board_be_handler = tx4939_be_handler;
+}
+
+static struct resource tx4939_sdram_resource[4];
+static struct resource tx4939_sram_resource;
+#define TX4939_SRAM_SIZE 0x800
+
+void __init tx4939_add_memory_regions(void)
+{
+	int i;
+	unsigned long start, size;
+	u64 win;
+
+	for (i = 0; i < 4; i++) {
+		if (!((__u32)____raw_readq(&tx4939_ddrcptr->winen) & (1 << i)))
+			continue;
+		win = ____raw_readq(&tx4939_ddrcptr->win[i]);
+		start = (unsigned long)(win >> 48);
+		size = (((unsigned long)(win >> 32) & 0xffff) + 1) - start;
+		add_memory_region(start << 20, size << 20, BOOT_MEM_RAM);
+	}
+}
+
+void __init tx4939_setup(void)
+{
+	int i;
+	__u32 divmode;
+	__u64 pcfg;
+	int cpuclk = 0;
+
+	txx9_reg_res_init(TX4939_REV_PCODE(), TX4939_REG_BASE,
+			  TX4939_REG_SIZE);
+	set_c0_config(TX49_CONF_CWFON);
+
+	/* SDRAMC,EBUSC are configured by PROM */
+	for (i = 0; i < 4; i++) {
+		if (!(TX4939_EBUSC_CR(i) & 0x8))
+			continue;	/* disabled */
+		txx9_ce_res[i].start = (unsigned long)TX4939_EBUSC_BA(i);
+		txx9_ce_res[i].end =
+			txx9_ce_res[i].start + TX4939_EBUSC_SIZE(i) - 1;
+		request_resource(&iomem_resource, &txx9_ce_res[i]);
+	}
+
+	/* clocks */
+	if (txx9_master_clock) {
+		/* calculate cpu_clock from master_clock */
+		divmode = (__u32)____raw_readq(&tx4939_ccfgptr->ccfg) &
+			TX4939_CCFG_MULCLK_MASK;
+		cpuclk = txx9_master_clock * 20 / 2;
+		switch (divmode) {
+		case TX4939_CCFG_MULCLK_8:
+			cpuclk = cpuclk / 3 * 4 /* / 6 *  8 */; break;
+		case TX4939_CCFG_MULCLK_9:
+			cpuclk = cpuclk / 2 * 3 /* / 6 *  9 */; break;
+		case TX4939_CCFG_MULCLK_10:
+			cpuclk = cpuclk / 3 * 5 /* / 6 * 10 */; break;
+		case TX4939_CCFG_MULCLK_11:
+			cpuclk = cpuclk / 6 * 11; break;
+		case TX4939_CCFG_MULCLK_12:
+			cpuclk = cpuclk * 2 /* / 6 * 12 */; break;
+		case TX4939_CCFG_MULCLK_13:
+			cpuclk = cpuclk / 6 * 13; break;
+		case TX4939_CCFG_MULCLK_14:
+			cpuclk = cpuclk / 3 * 7 /* / 6 * 14 */; break;
+		case TX4939_CCFG_MULCLK_15:
+			cpuclk = cpuclk / 2 * 5 /* / 6 * 15 */; break;
+		}
+		txx9_cpu_clock = cpuclk;
+	} else {
+		if (txx9_cpu_clock == 0)
+			txx9_cpu_clock = 400000000;	/* 400MHz */
+		/* calculate master_clock from cpu_clock */
+		cpuclk = txx9_cpu_clock;
+		divmode = (__u32)____raw_readq(&tx4939_ccfgptr->ccfg) &
+			TX4939_CCFG_MULCLK_MASK;
+		switch (divmode) {
+		case TX4939_CCFG_MULCLK_8:
+			txx9_master_clock = cpuclk * 6 / 8; break;
+		case TX4939_CCFG_MULCLK_9:
+			txx9_master_clock = cpuclk * 6 / 9; break;
+		case TX4939_CCFG_MULCLK_10:
+			txx9_master_clock = cpuclk * 6 / 10; break;
+		case TX4939_CCFG_MULCLK_11:
+			txx9_master_clock = cpuclk * 6 / 11; break;
+		case TX4939_CCFG_MULCLK_12:
+			txx9_master_clock = cpuclk * 6 / 12; break;
+		case TX4939_CCFG_MULCLK_13:
+			txx9_master_clock = cpuclk * 6 / 13; break;
+		case TX4939_CCFG_MULCLK_14:
+			txx9_master_clock = cpuclk * 6 / 14; break;
+		case TX4939_CCFG_MULCLK_15:
+			txx9_master_clock = cpuclk * 6 / 15; break;
+		}
+		txx9_master_clock /= 10; /* * 2 / 20 */
+	}
+	/* calculate gbus_clock from cpu_clock */
+	divmode = (__u32)____raw_readq(&tx4939_ccfgptr->ccfg) &
+		TX4939_CCFG_YDIVMODE_MASK;
+	txx9_gbus_clock = txx9_cpu_clock;
+	switch (divmode) {
+	case TX4939_CCFG_YDIVMODE_2:
+		txx9_gbus_clock /= 2; break;
+	case TX4939_CCFG_YDIVMODE_3:
+		txx9_gbus_clock /= 3; break;
+	case TX4939_CCFG_YDIVMODE_5:
+		txx9_gbus_clock /= 5; break;
+	case TX4939_CCFG_YDIVMODE_6:
+		txx9_gbus_clock /= 6; break;
+	}
+	/* change default value to udelay/mdelay take reasonable time */
+	loops_per_jiffy = txx9_cpu_clock / HZ / 2;
+
+	/* CCFG */
+	tx4939_wdr_init();
+	/* clear BusErrorOnWrite flag (W1C) */
+	tx4939_ccfg_set(TX4939_CCFG_WDRST | TX4939_CCFG_BEOW);
+	/* enable Timeout BusError */
+	if (txx9_ccfg_toeon)
+		tx4939_ccfg_set(TX4939_CCFG_TOE);
+
+	/* DMA selection */
+	txx9_clear64(&tx4939_ccfgptr->pcfg, TX4939_PCFG_DMASEL_ALL);
+
+	/* Use external clock for external arbiter */
+	if (!(____raw_readq(&tx4939_ccfgptr->ccfg) & TX4939_CCFG_PCIARB))
+		txx9_clear64(&tx4939_ccfgptr->pcfg, TX4939_PCFG_PCICLKEN_ALL);
+
+	pr_info("%s -- %dMHz(M%dMHz,G%dMHz) CRIR:%08x CCFG:%llx PCFG:%llx\n",
+		txx9_pcode_str,
+		(cpuclk + 500000) / 1000000,
+		(txx9_master_clock + 500000) / 1000000,
+		(txx9_gbus_clock + 500000) / 1000000,
+		(__u32)____raw_readq(&tx4939_ccfgptr->crir),
+		(unsigned long long)____raw_readq(&tx4939_ccfgptr->ccfg),
+		(unsigned long long)____raw_readq(&tx4939_ccfgptr->pcfg));
+
+	pr_info("%s DDRC -- EN:%08x", txx9_pcode_str,
+		(__u32)____raw_readq(&tx4939_ddrcptr->winen));
+	for (i = 0; i < 4; i++) {
+		__u64 win = ____raw_readq(&tx4939_ddrcptr->win[i]);
+		if (!((__u32)____raw_readq(&tx4939_ddrcptr->winen) & (1 << i)))
+			continue;	/* disabled */
+		printk(KERN_CONT " #%d:%016llx", i, (unsigned long long)win);
+		tx4939_sdram_resource[i].name = "DDR SDRAM";
+		tx4939_sdram_resource[i].start =
+			(unsigned long)(win >> 48) << 20;
+		tx4939_sdram_resource[i].end =
+			((((unsigned long)(win >> 32) & 0xffff) + 1) <<
+			 20) - 1;
+		tx4939_sdram_resource[i].flags = IORESOURCE_MEM;
+		request_resource(&iomem_resource, &tx4939_sdram_resource[i]);
+	}
+	printk(KERN_CONT "\n");
+
+	/* SRAM */
+	if (____raw_readq(&tx4939_sramcptr->cr) & 1) {
+		unsigned int size = TX4939_SRAM_SIZE;
+		tx4939_sram_resource.name = "SRAM";
+		tx4939_sram_resource.start =
+			(____raw_readq(&tx4939_sramcptr->cr) >> (39-11))
+			& ~(size - 1);
+		tx4939_sram_resource.end =
+			tx4939_sram_resource.start + TX4939_SRAM_SIZE - 1;
+		tx4939_sram_resource.flags = IORESOURCE_MEM;
+		request_resource(&iomem_resource, &tx4939_sram_resource);
+	}
+
+	/* TMR */
+	/* disable all timers */
+	for (i = 0; i < TX4939_NR_TMR; i++)
+		txx9_tmr_init(TX4939_TMR_REG(i) & 0xfffffffffULL);
+
+	/* DMA */
+	for (i = 0; i < 2; i++)
+		____raw_writeq(TX4938_DMA_MCR_MSTEN,
+			       (void __iomem *)(TX4939_DMA_REG(i) + 0x50));
+
+	/* set PCIC1 reset (required to prevent hangup on BIST) */
+	txx9_set64(&tx4939_ccfgptr->clkctr, TX4939_CLKCTR_PCI1RST);
+	pcfg = ____raw_readq(&tx4939_ccfgptr->pcfg);
+	if (pcfg & (TX4939_PCFG_ET0MODE | TX4939_PCFG_ET1MODE)) {
+		mdelay(1);	/* at least 128 cpu clock */
+		/* clear PCIC1 reset */
+		txx9_clear64(&tx4939_ccfgptr->clkctr, TX4939_CLKCTR_PCI1RST);
+	} else {
+		pr_info("%s: stop PCIC1\n", txx9_pcode_str);
+		/* stop PCIC1 */
+		txx9_set64(&tx4939_ccfgptr->clkctr, TX4939_CLKCTR_PCI1CKD);
+	}
+	if (!(pcfg & TX4939_PCFG_ET0MODE)) {
+		pr_info("%s: stop ETH0\n", txx9_pcode_str);
+		txx9_set64(&tx4939_ccfgptr->clkctr, TX4939_CLKCTR_ETH0RST);
+		txx9_set64(&tx4939_ccfgptr->clkctr, TX4939_CLKCTR_ETH0CKD);
+	}
+	if (!(pcfg & TX4939_PCFG_ET1MODE)) {
+		pr_info("%s: stop ETH1\n", txx9_pcode_str);
+		txx9_set64(&tx4939_ccfgptr->clkctr, TX4939_CLKCTR_ETH1RST);
+		txx9_set64(&tx4939_ccfgptr->clkctr, TX4939_CLKCTR_ETH1CKD);
+	}
+
+	_machine_restart = tx4939_machine_restart;
+	board_be_init = tx4939_be_init;
+}
+
+void __init tx4939_time_init(unsigned int tmrnr)
+{
+	if (____raw_readq(&tx4939_ccfgptr->ccfg) & TX4939_CCFG_TINTDIS)
+		txx9_clockevent_init(TX4939_TMR_REG(tmrnr) & 0xfffffffffULL,
+				     TXX9_IRQ_BASE + TX4939_IR_TMR(tmrnr),
+				     TXX9_IMCLK);
+}
+
+void __init tx4939_sio_init(unsigned int sclk, unsigned int cts_mask)
+{
+	int i;
+	unsigned int ch_mask = 0;
+	__u64 pcfg = __raw_readq(&tx4939_ccfgptr->pcfg);
+
+	cts_mask |= ~1;	/* only SIO0 have RTS/CTS */
+	if ((pcfg & TX4939_PCFG_SIO2MODE_MASK) != TX4939_PCFG_SIO2MODE_SIO0)
+		cts_mask |= 1 << 0; /* disable SIO0 RTS/CTS by PCFG setting */
+	if ((pcfg & TX4939_PCFG_SIO2MODE_MASK) != TX4939_PCFG_SIO2MODE_SIO2)
+		ch_mask |= 1 << 2; /* disable SIO2 by PCFG setting */
+	if (pcfg & TX4939_PCFG_SIO3MODE)
+		ch_mask |= 1 << 3; /* disable SIO3 by PCFG setting */
+	for (i = 0; i < 4; i++) {
+		if ((1 << i) & ch_mask)
+			continue;
+		txx9_sio_init(TX4939_SIO_REG(i) & 0xfffffffffULL,
+			      TXX9_IRQ_BASE + TX4939_IR_SIO(i),
+			      i, sclk, (1 << i) & cts_mask);
+	}
+}
+
+#if defined(CONFIG_TC35815) || defined(CONFIG_TC35815_MODULE)
+static int tx4939_get_eth_speed(struct net_device *dev)
+{
+	struct ethtool_cmd cmd = { ETHTOOL_GSET };
+	int speed = 100;	/* default 100Mbps */
+	int err;
+	if (!dev->ethtool_ops || !dev->ethtool_ops->get_settings)
+		return speed;
+	err = dev->ethtool_ops->get_settings(dev, &cmd);
+	if (err < 0)
+		return speed;
+	speed = cmd.speed == SPEED_100 ? 100 : 10;
+	return speed;
+}
+static int tx4939_netdev_event(struct notifier_block *this,
+			       unsigned long event,
+			       void *ptr)
+{
+	struct net_device *dev = ptr;
+	if (event == NETDEV_CHANGE && netif_carrier_ok(dev)) {
+		__u64 bit = 0;
+		if (dev->irq == TXX9_IRQ_BASE + TX4939_IR_ETH(0))
+			bit = TX4939_PCFG_SPEED0;
+		else if (dev->irq == TXX9_IRQ_BASE + TX4939_IR_ETH(1))
+			bit = TX4939_PCFG_SPEED1;
+		if (bit) {
+			int speed = tx4939_get_eth_speed(dev);
+			if (speed == 100)
+				txx9_set64(&tx4939_ccfgptr->pcfg, bit);
+			else
+				txx9_clear64(&tx4939_ccfgptr->pcfg, bit);
+		}
+	}
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block tx4939_netdev_notifier = {
+	.notifier_call = tx4939_netdev_event,
+	.priority = 1,
+};
+
+void __init tx4939_ethaddr_init(unsigned char *addr0, unsigned char *addr1)
+{
+	u64 pcfg = __raw_readq(&tx4939_ccfgptr->pcfg);
+
+	if (addr0 && (pcfg & TX4939_PCFG_ET0MODE))
+		txx9_ethaddr_init(TXX9_IRQ_BASE + TX4939_IR_ETH(0), addr0);
+	if (addr1 && (pcfg & TX4939_PCFG_ET1MODE))
+		txx9_ethaddr_init(TXX9_IRQ_BASE + TX4939_IR_ETH(1), addr1);
+	register_netdevice_notifier(&tx4939_netdev_notifier);
+}
+#else
+void __init tx4939_ethaddr_init(unsigned char *addr0, unsigned char *addr1)
+{
+}
+#endif
+
+void __init tx4939_mtd_init(int ch)
+{
+	struct physmap_flash_data pdata = {
+		.width = TX4939_EBUSC_WIDTH(ch) / 8,
+	};
+	unsigned long start = txx9_ce_res[ch].start;
+	unsigned long size = txx9_ce_res[ch].end - start + 1;
+
+	if (!(TX4939_EBUSC_CR(ch) & 0x8))
+		return;	/* disabled */
+	txx9_physmap_flash_init(ch, start, size, &pdata);
+}
+
+static void __init tx4939_stop_unused_modules(void)
+{
+	__u64 pcfg, rst = 0, ckd = 0;
+	char buf[128];
+
+	buf[0] = '\0';
+	local_irq_disable();
+	pcfg = ____raw_readq(&tx4939_ccfgptr->pcfg);
+	if ((pcfg & TX4939_PCFG_I2SMODE_MASK) !=
+	    TX4939_PCFG_I2SMODE_ACLC) {
+		rst |= TX4939_CLKCTR_ACLRST;
+		ckd |= TX4939_CLKCTR_ACLCKD;
+		strcat(buf, " ACLC");
+	}
+	if ((pcfg & TX4939_PCFG_I2SMODE_MASK) !=
+	    TX4939_PCFG_I2SMODE_I2S &&
+	    (pcfg & TX4939_PCFG_I2SMODE_MASK) !=
+	    TX4939_PCFG_I2SMODE_I2S_ALT) {
+		rst |= TX4939_CLKCTR_I2SRST;
+		ckd |= TX4939_CLKCTR_I2SCKD;
+		strcat(buf, " I2S");
+	}
+	if (!(pcfg & TX4939_PCFG_ATA0MODE)) {
+		rst |= TX4939_CLKCTR_ATA0RST;
+		ckd |= TX4939_CLKCTR_ATA0CKD;
+		strcat(buf, " ATA0");
+	}
+	if (!(pcfg & TX4939_PCFG_ATA1MODE)) {
+		rst |= TX4939_CLKCTR_ATA1RST;
+		ckd |= TX4939_CLKCTR_ATA1CKD;
+		strcat(buf, " ATA1");
+	}
+	if (pcfg & TX4939_PCFG_SPIMODE) {
+		rst |= TX4939_CLKCTR_SPIRST;
+		ckd |= TX4939_CLKCTR_SPICKD;
+		strcat(buf, " SPI");
+	}
+	if (!(pcfg & (TX4939_PCFG_VSSMODE | TX4939_PCFG_VPSMODE))) {
+		rst |= TX4939_CLKCTR_VPCRST;
+		ckd |= TX4939_CLKCTR_VPCCKD;
+		strcat(buf, " VPC");
+	}
+	if ((pcfg & TX4939_PCFG_SIO2MODE_MASK) != TX4939_PCFG_SIO2MODE_SIO2) {
+		rst |= TX4939_CLKCTR_SIO2RST;
+		ckd |= TX4939_CLKCTR_SIO2CKD;
+		strcat(buf, " SIO2");
+	}
+	if (pcfg & TX4939_PCFG_SIO3MODE) {
+		rst |= TX4939_CLKCTR_SIO3RST;
+		ckd |= TX4939_CLKCTR_SIO3CKD;
+		strcat(buf, " SIO3");
+	}
+	if (rst | ckd) {
+		txx9_set64(&tx4939_ccfgptr->clkctr, rst);
+		txx9_set64(&tx4939_ccfgptr->clkctr, ckd);
+	}
+	local_irq_enable();
+	if (buf[0])
+		pr_info("%s: stop%s\n", txx9_pcode_str, buf);
+}
+
+static int __init tx4939_late_init(void)
+{
+	if (txx9_pcode != 0x4939)
+		return -ENODEV;
+	tx4939_stop_unused_modules();
+	return 0;
+}
+late_initcall(tx4939_late_init);
diff --git a/include/asm-mips/txx9/tx4939.h b/include/asm-mips/txx9/tx4939.h
new file mode 100644
index 0000000..7ce2dff
--- /dev/null
+++ b/include/asm-mips/txx9/tx4939.h
@@ -0,0 +1,544 @@
+/*
+ * Definitions for TX4939
+ *
+ * Copyright (C) 2000-2001,2005-2006 Toshiba Corporation
+ * 2003-2005 (c) MontaVista Software, Inc. This file is licensed under the
+ * terms of the GNU General Public License version 2. This program is
+ * licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+#ifndef __ASM_TXX9_TX4939_H
+#define __ASM_TXX9_TX4939_H
+
+/* some controllers are compatible with 4927/4938 */
+#include <asm/txx9/tx4938.h>
+
+#ifdef CONFIG_64BIT
+#define TX4939_REG_BASE	0xffffffffff1f0000UL /* == TX4938_REG_BASE */
+#else
+#define TX4939_REG_BASE	0xff1f0000UL /* == TX4938_REG_BASE */
+#endif
+#define TX4939_REG_SIZE	0x00010000 /* == TX4938_REG_SIZE */
+
+#define TX4939_ATA_REG(ch)	(TX4939_REG_BASE + 0x3000 + (ch) * 0x1000)
+#define TX4939_NDFMC_REG	(TX4939_REG_BASE + 0x5000)
+#define TX4939_SRAMC_REG	(TX4939_REG_BASE + 0x6000)
+#define TX4939_CRYPTO_REG	(TX4939_REG_BASE + 0x6800)
+#define TX4939_PCIC1_REG	(TX4939_REG_BASE + 0x7000)
+#define TX4939_DDRC_REG		(TX4939_REG_BASE + 0x8000)
+#define TX4939_EBUSC_REG	(TX4939_REG_BASE + 0x9000)
+#define TX4939_VPC_REG		(TX4939_REG_BASE + 0xa000)
+#define TX4939_DMA_REG(ch)	(TX4939_REG_BASE + 0xb000 + (ch) * 0x800)
+#define TX4939_PCIC_REG		(TX4939_REG_BASE + 0xd000)
+#define TX4939_CCFG_REG		(TX4939_REG_BASE + 0xe000)
+#define TX4939_IRC_REG		(TX4939_REG_BASE + 0xe800)
+#define TX4939_NR_TMR	6	/* 0xf000,0xf100,0xf200,0xfd00,0xfe00,0xff00 */
+#define TX4939_TMR_REG(ch)	\
+	(TX4939_REG_BASE + 0xf000 + ((ch) + ((ch) >= 3) * 10) * 0x100)
+#define TX4939_NR_SIO	4	/* 0xf300, 0xf400, 0xf380, 0xf480 */
+#define TX4939_SIO_REG(ch)	\
+	(TX4939_REG_BASE + 0xf300 + (((ch) & 1) << 8) + (((ch) & 2) << 6))
+#define TX4939_ACLC_REG		(TX4939_REG_BASE + 0xf700)
+#define TX4939_SPI_REG		(TX4939_REG_BASE + 0xf800)
+#define TX4939_I2C_REG		(TX4939_REG_BASE + 0xf900)
+#define TX4939_I2S_REG		(TX4939_REG_BASE + 0xfa00)
+#define TX4939_RTC_REG		(TX4939_REG_BASE + 0xfb00)
+#define TX4939_CIR_REG		(TX4939_REG_BASE + 0xfc00)
+
+struct tx4939_le_reg {
+	__u32 r;
+	__u32 unused;
+};
+
+struct tx4939_ddrc_reg {
+	struct tx4939_le_reg ctl[47];
+	__u64 unused0[17];
+	__u64 winen;
+	__u64 win[4];
+};
+
+struct tx4939_ccfg_reg {
+	__u64 ccfg;
+	__u64 crir;
+	__u64 pcfg;
+	__u64 toea;
+	__u64 clkctr;
+	__u64 unused0;
+	__u64 garbc;
+	__u64 unused1[2];
+	__u64 ramp;
+	__u64 unused2[2];
+	__u64 dskwctrl;
+	__u64 mclkosc;
+	__u64 mclkctl;
+	__u64 unused3[17];
+	struct {
+		__u64 mr;
+		__u64 dr;
+	} gpio[2];
+};
+
+struct tx4939_irc_reg {
+	struct tx4939_le_reg den;
+	struct tx4939_le_reg scipb;
+	struct tx4939_le_reg dm[2];
+	struct tx4939_le_reg lvl[16];
+	struct tx4939_le_reg msk;
+	struct tx4939_le_reg edc;
+	struct tx4939_le_reg pnd0;
+	struct tx4939_le_reg cs;
+	struct tx4939_le_reg pnd1;
+	struct tx4939_le_reg dm2[2];
+	struct tx4939_le_reg dbr[2];
+	struct tx4939_le_reg dben;
+	struct tx4939_le_reg unused0[2];
+	struct tx4939_le_reg flag[2];
+	struct tx4939_le_reg pol;
+	struct tx4939_le_reg cnt;
+	struct tx4939_le_reg maskint;
+	struct tx4939_le_reg maskext;
+};
+
+struct tx4939_rtc_reg {
+	__u32 ctl;
+	__u32 adr;
+	__u32 dat;
+	__u32 tbc;
+};
+
+struct tx4939_crypto_reg {
+	struct tx4939_le_reg csr;
+	struct tx4939_le_reg idesptr;
+	struct tx4939_le_reg cdesptr;
+	struct tx4939_le_reg buserr;
+	struct tx4939_le_reg cip_tout;
+	struct tx4939_le_reg cir;
+	union {
+		struct {
+			struct tx4939_le_reg data[8];
+			struct tx4939_le_reg ctrl;
+		} gen;
+		struct {
+			struct {
+				struct tx4939_le_reg l;
+				struct tx4939_le_reg u;
+			} key[3], ini;
+			struct tx4939_le_reg ctrl;
+		} des;
+		struct {
+			struct tx4939_le_reg key[4];
+			struct tx4939_le_reg ini[4];
+			struct tx4939_le_reg ctrl;
+		} aes;
+		struct {
+			struct {
+				struct tx4939_le_reg l;
+				struct tx4939_le_reg u;
+			} cnt;
+			struct tx4939_le_reg ini[5];
+			struct tx4939_le_reg unused;
+			struct tx4939_le_reg ctrl;
+		} hash;
+	} cdr;
+	struct tx4939_le_reg unused0[7];
+	struct tx4939_le_reg rcsr;
+	struct tx4939_le_reg rpr;
+	__u64 rdr;
+	__u64 ror[3];
+	struct tx4939_le_reg unused1[2];
+	struct tx4939_le_reg xorslr;
+	struct tx4939_le_reg xorsur;
+};
+
+struct tx4939_crypto_desc {
+	__u32 src;
+	__u32 dst;
+	__u32 next;
+	__u32 ctrl;
+	__u32 index;
+	__u32 xor;
+};
+
+struct tx4939_vpc_reg {
+	struct tx4939_le_reg csr;
+	struct {
+		struct tx4939_le_reg ctrlA;
+		struct tx4939_le_reg ctrlB;
+		struct tx4939_le_reg idesptr;
+		struct tx4939_le_reg cdesptr;
+	} port[3];
+	struct tx4939_le_reg buserr;
+};
+
+struct tx4939_vpc_desc {
+	__u32 src;
+	__u32 next;
+	__u32 ctrl1;
+	__u32 ctrl2;
+};
+
+/*
+ * IRC
+ */
+#define TX4939_IR_NONE	0
+#define TX4939_IR_DDR	1
+#define TX4939_IR_WTOERR	2
+#define TX4939_NUM_IR_INT	3
+#define TX4939_IR_INT(n)	(3 + (n))
+#define TX4939_NUM_IR_ETH	2
+#define TX4939_IR_ETH(n)	((n) ? 43 : 6)
+#define TX4939_IR_VIDEO	7
+#define TX4939_IR_CIR	8
+#define TX4939_NUM_IR_SIO	4
+#define TX4939_IR_SIO(n)	((n) ? 43 + (n) : 9)	/* 9,44-46 */
+#define TX4939_NUM_IR_DMA	4
+#define TX4939_IR_DMA(ch, n)	(((ch) ? 22 : 10) + (n)) /* 10-13,22-25 */
+#define TX4939_IR_IRC	14
+#define TX4939_IR_PDMAC	15
+#define TX4939_NUM_IR_TMR	6
+#define TX4939_IR_TMR(n)	(((n) >= 3 ? 45 : 16) + (n)) /* 16-18,48-50 */
+#define TX4939_NUM_IR_ATA	2
+#define TX4939_IR_ATA(n)	(19 + (n))
+#define TX4939_IR_ACLC	21
+#define TX4939_IR_CIPHER	26
+#define TX4939_IR_INTA	27
+#define TX4939_IR_INTB	28
+#define TX4939_IR_INTC	29
+#define TX4939_IR_INTD	30
+#define TX4939_IR_I2C	33
+#define TX4939_IR_SPI	34
+#define TX4939_IR_PCIC	35
+#define TX4939_IR_PCIC1	36
+#define TX4939_IR_PCIERR	37
+#define TX4939_IR_PCIPME	38
+#define TX4939_IR_NDFMC	39
+#define TX4939_IR_ACLCPME	40
+#define TX4939_IR_RTC	41
+#define TX4939_IR_RND	42
+#define TX4939_IR_I2S	47
+#define TX4939_NUM_IR	64
+
+#define TX4939_IRC_INT	2	/* IP[2] in Status register */
+
+/*
+ * CCFG
+ */
+/* CCFG : Chip Configuration */
+#define TX4939_CCFG_PCIBOOT	0x0000040000000000ULL
+#define TX4939_CCFG_WDRST	0x0000020000000000ULL
+#define TX4939_CCFG_WDREXEN	0x0000010000000000ULL
+#define TX4939_CCFG_BCFG_MASK	0x000000ff00000000ULL
+#define TX4939_CCFG_GTOT_MASK	0x06000000
+#define TX4939_CCFG_GTOT_4096	0x06000000
+#define TX4939_CCFG_GTOT_2048	0x04000000
+#define TX4939_CCFG_GTOT_1024	0x02000000
+#define TX4939_CCFG_GTOT_512	0x00000000
+#define TX4939_CCFG_TINTDIS	0x01000000
+#define TX4939_CCFG_PCI66	0x00800000
+#define TX4939_CCFG_PCIMODE	0x00400000
+#define TX4939_CCFG_SSCG	0x00100000
+#define TX4939_CCFG_MULCLK_MASK	0x000e0000
+#define TX4939_CCFG_MULCLK_8	(0x7 << 17)
+#define TX4939_CCFG_MULCLK_9	(0x0 << 17)
+#define TX4939_CCFG_MULCLK_10	(0x1 << 17)
+#define TX4939_CCFG_MULCLK_11	(0x2 << 17)
+#define TX4939_CCFG_MULCLK_12	(0x3 << 17)
+#define TX4939_CCFG_MULCLK_13	(0x4 << 17)
+#define TX4939_CCFG_MULCLK_14	(0x5 << 17)
+#define TX4939_CCFG_MULCLK_15	(0x6 << 17)
+#define TX4939_CCFG_BEOW	0x00010000
+#define TX4939_CCFG_WR	0x00008000
+#define TX4939_CCFG_TOE	0x00004000
+#define TX4939_CCFG_PCIARB	0x00002000
+#define TX4939_CCFG_YDIVMODE_MASK	0x00001c00
+#define TX4939_CCFG_YDIVMODE_2	(0x0 << 10)
+#define TX4939_CCFG_YDIVMODE_3	(0x1 << 10)
+#define TX4939_CCFG_YDIVMODE_5	(0x6 << 10)
+#define TX4939_CCFG_YDIVMODE_6	(0x7 << 10)
+#define TX4939_CCFG_PTSEL	0x00000200
+#define TX4939_CCFG_BESEL	0x00000100
+#define TX4939_CCFG_SYSSP_MASK	0x000000c0
+#define TX4939_CCFG_ACKSEL	0x00000020
+#define TX4939_CCFG_ROMW	0x00000010
+#define TX4939_CCFG_ENDIAN	0x00000004
+#define TX4939_CCFG_ARMODE	0x00000002
+#define TX4939_CCFG_ACEHOLD	0x00000001
+
+/* PCFG : Pin Configuration */
+#define TX4939_PCFG_SIO2MODE_MASK	0xc000000000000000ULL
+#define TX4939_PCFG_SIO2MODE_GPIO	0x8000000000000000ULL
+#define TX4939_PCFG_SIO2MODE_SIO2	0x4000000000000000ULL
+#define TX4939_PCFG_SIO2MODE_SIO0	0x0000000000000000ULL
+#define TX4939_PCFG_SPIMODE	0x2000000000000000ULL
+#define TX4939_PCFG_I2CMODE	0x1000000000000000ULL
+#define TX4939_PCFG_I2SMODE_MASK	0x0c00000000000000ULL
+#define TX4939_PCFG_I2SMODE_GPIO	0x0c00000000000000ULL
+#define TX4939_PCFG_I2SMODE_I2S	0x0800000000000000ULL
+#define TX4939_PCFG_I2SMODE_I2S_ALT	0x0400000000000000ULL
+#define TX4939_PCFG_I2SMODE_ACLC	0x0000000000000000ULL
+#define TX4939_PCFG_SIO3MODE	0x0200000000000000ULL
+#define TX4939_PCFG_DMASEL3	0x0004000000000000ULL
+#define TX4939_PCFG_DMASEL3_SIO0	0x0004000000000000ULL
+#define TX4939_PCFG_DMASEL3_NDFC	0x0000000000000000ULL
+#define TX4939_PCFG_VSSMODE	0x0000200000000000ULL
+#define TX4939_PCFG_VPSMODE	0x0000100000000000ULL
+#define TX4939_PCFG_ET1MODE	0x0000080000000000ULL
+#define TX4939_PCFG_ET0MODE	0x0000040000000000ULL
+#define TX4939_PCFG_ATA1MODE	0x0000020000000000ULL
+#define TX4939_PCFG_ATA0MODE	0x0000010000000000ULL
+#define TX4939_PCFG_BP_PLL	0x0000000100000000ULL
+
+#define TX4939_PCFG_SYSCLKEN	0x08000000
+#define TX4939_PCFG_PCICLKEN_ALL	0x000f0000
+#define TX4939_PCFG_PCICLKEN(ch)	(0x00010000<<(ch))
+#define TX4939_PCFG_SPEED1	0x00002000
+#define TX4939_PCFG_SPEED0	0x00001000
+#define TX4939_PCFG_ITMODE	0x00000300
+#define TX4939_PCFG_DMASEL_ALL	(0x00000007 | TX4939_PCFG_DMASEL3)
+#define TX4939_PCFG_DMASEL2	0x00000004
+#define TX4939_PCFG_DMASEL2_DRQ2	0x00000000
+#define TX4939_PCFG_DMASEL2_SIO0	0x00000004
+#define TX4939_PCFG_DMASEL1	0x00000002
+#define TX4939_PCFG_DMASEL1_DRQ1	0x00000000
+#define TX4939_PCFG_DMASEL0	0x00000001
+#define TX4939_PCFG_DMASEL0_DRQ0	0x00000000
+
+/* CLKCTR : Clock Control */
+#define TX4939_CLKCTR_IOSCKD	0x8000000000000000ULL
+#define TX4939_CLKCTR_SYSCKD	0x4000000000000000ULL
+#define TX4939_CLKCTR_TM5CKD	0x2000000000000000ULL
+#define TX4939_CLKCTR_TM4CKD	0x1000000000000000ULL
+#define TX4939_CLKCTR_TM3CKD	0x0800000000000000ULL
+#define TX4939_CLKCTR_CIRCKD	0x0400000000000000ULL
+#define TX4939_CLKCTR_SIO3CKD	0x0200000000000000ULL
+#define TX4939_CLKCTR_SIO2CKD	0x0100000000000000ULL
+#define TX4939_CLKCTR_SIO1CKD	0x0080000000000000ULL
+#define TX4939_CLKCTR_VPCCKD	0x0040000000000000ULL
+#define TX4939_CLKCTR_EPCICKD	0x0020000000000000ULL
+#define TX4939_CLKCTR_ETH1CKD	0x0008000000000000ULL
+#define TX4939_CLKCTR_ATA1CKD	0x0004000000000000ULL
+#define TX4939_CLKCTR_BROMCKD	0x0002000000000000ULL
+#define TX4939_CLKCTR_NDCCKD	0x0001000000000000ULL
+#define TX4939_CLKCTR_I2CCKD	0x0000800000000000ULL
+#define TX4939_CLKCTR_ETH0CKD	0x0000400000000000ULL
+#define TX4939_CLKCTR_SPICKD	0x0000200000000000ULL
+#define TX4939_CLKCTR_SRAMCKD	0x0000100000000000ULL
+#define TX4939_CLKCTR_PCI1CKD	0x0000080000000000ULL
+#define TX4939_CLKCTR_DMA1CKD	0x0000040000000000ULL
+#define TX4939_CLKCTR_ACLCKD	0x0000020000000000ULL
+#define TX4939_CLKCTR_ATA0CKD	0x0000010000000000ULL
+#define TX4939_CLKCTR_DMA0CKD	0x0000008000000000ULL
+#define TX4939_CLKCTR_PCICCKD	0x0000004000000000ULL
+#define TX4939_CLKCTR_I2SCKD	0x0000002000000000ULL
+#define TX4939_CLKCTR_TM0CKD	0x0000001000000000ULL
+#define TX4939_CLKCTR_TM1CKD	0x0000000800000000ULL
+#define TX4939_CLKCTR_TM2CKD	0x0000000400000000ULL
+#define TX4939_CLKCTR_SIO0CKD	0x0000000200000000ULL
+#define TX4939_CLKCTR_CYPCKD	0x0000000100000000ULL
+#define TX4939_CLKCTR_IOSRST	0x80000000
+#define TX4939_CLKCTR_SYSRST	0x40000000
+#define TX4939_CLKCTR_TM5RST	0x20000000
+#define TX4939_CLKCTR_TM4RST	0x10000000
+#define TX4939_CLKCTR_TM3RST	0x08000000
+#define TX4939_CLKCTR_CIRRST	0x04000000
+#define TX4939_CLKCTR_SIO3RST	0x02000000
+#define TX4939_CLKCTR_SIO2RST	0x01000000
+#define TX4939_CLKCTR_SIO1RST	0x00800000
+#define TX4939_CLKCTR_VPCRST	0x00400000
+#define TX4939_CLKCTR_EPCIRST	0x00200000
+#define TX4939_CLKCTR_ETH1RST	0x00080000
+#define TX4939_CLKCTR_ATA1RST	0x00040000
+#define TX4939_CLKCTR_BROMRST	0x00020000
+#define TX4939_CLKCTR_NDCRST	0x00010000
+#define TX4939_CLKCTR_I2CRST	0x00008000
+#define TX4939_CLKCTR_ETH0RST	0x00004000
+#define TX4939_CLKCTR_SPIRST	0x00002000
+#define TX4939_CLKCTR_SRAMRST	0x00001000
+#define TX4939_CLKCTR_PCI1RST	0x00000800
+#define TX4939_CLKCTR_DMA1RST	0x00000400
+#define TX4939_CLKCTR_ACLRST	0x00000200
+#define TX4939_CLKCTR_ATA0RST	0x00000100
+#define TX4939_CLKCTR_DMA0RST	0x00000080
+#define TX4939_CLKCTR_PCICRST	0x00000040
+#define TX4939_CLKCTR_I2SRST	0x00000020
+#define TX4939_CLKCTR_TM0RST	0x00000010
+#define TX4939_CLKCTR_TM1RST	0x00000008
+#define TX4939_CLKCTR_TM2RST	0x00000004
+#define TX4939_CLKCTR_SIO0RST	0x00000002
+#define TX4939_CLKCTR_CYPRST	0x00000001
+
+/*
+ * RTC
+ */
+#define TX4939_RTCCTL_ALME	0x00000080
+#define TX4939_RTCCTL_ALMD	0x00000040
+#define TX4939_RTCCTL_BUSY	0x00000020
+
+#define TX4939_RTCCTL_COMMAND	0x00000007
+#define TX4939_RTCCTL_COMMAND_NOP	0x00000000
+#define TX4939_RTCCTL_COMMAND_GETTIME	0x00000001
+#define TX4939_RTCCTL_COMMAND_SETTIME	0x00000002
+#define TX4939_RTCCTL_COMMAND_GETALARM	0x00000003
+#define TX4939_RTCCTL_COMMAND_SETALARM	0x00000004
+
+#define TX4939_RTCTBC_PM	0x00000080
+#define TX4939_RTCTBC_COMP	0x0000007f
+
+#define TX4939_RTC_REG_RAMSIZE	0x00000100
+#define TX4939_RTC_REG_RWBSIZE	0x00000006
+
+/*
+ * CRYPTO
+ */
+#define TX4939_CRYPTO_CSR_SAESO	0x08000000
+#define TX4939_CRYPTO_CSR_SAESI	0x04000000
+#define TX4939_CRYPTO_CSR_SDESO	0x02000000
+#define TX4939_CRYPTO_CSR_SDESI	0x01000000
+#define TX4939_CRYPTO_CSR_INDXBST_MASK	0x00700000
+#define TX4939_CRYPTO_CSR_INDXBST(n)	((n) << 20)
+#define TX4939_CRYPTO_CSR_TOINT	0x00080000
+#define TX4939_CRYPTO_CSR_DCINT	0x00040000
+#define TX4939_CRYPTO_CSR_GBINT	0x00010000
+#define TX4939_CRYPTO_CSR_INDXAST_MASK	0x0000e000
+#define TX4939_CRYPTO_CSR_INDXAST(n)	((n) << 13)
+#define TX4939_CRYPTO_CSR_CSWAP_MASK	0x00001800
+#define TX4939_CRYPTO_CSR_CSWAP_NONE	0x00000000
+#define TX4939_CRYPTO_CSR_CSWAP_IN	0x00000800
+#define TX4939_CRYPTO_CSR_CSWAP_OUT	0x00001000
+#define TX4939_CRYPTO_CSR_CSWAP_BOTH	0x00001800
+#define TX4939_CRYPTO_CSR_CDIV_MASK	0x00000600
+#define TX4939_CRYPTO_CSR_CDIV_DIV2	0x00000000
+#define TX4939_CRYPTO_CSR_CDIV_DIV1	0x00000200
+#define TX4939_CRYPTO_CSR_CDIV_DIV2ALT	0x00000400
+#define TX4939_CRYPTO_CSR_CDIV_DIV1ALT	0x00000600
+#define TX4939_CRYPTO_CSR_PDINT_MASK	0x000000c0
+#define TX4939_CRYPTO_CSR_PDINT_ALL	0x00000000
+#define TX4939_CRYPTO_CSR_PDINT_END	0x00000040
+#define TX4939_CRYPTO_CSR_PDINT_NEXT	0x00000080
+#define TX4939_CRYPTO_CSR_PDINT_NONE	0x000000c0
+#define TX4939_CRYPTO_CSR_GINTE	0x00000008
+#define TX4939_CRYPTO_CSR_RSTD	0x00000004
+#define TX4939_CRYPTO_CSR_RSTC	0x00000002
+#define TX4939_CRYPTO_CSR_ENCR	0x00000001
+
+/* bits for tx4939_crypto_reg.cdr.gen.ctrl */
+#define TX4939_CRYPTO_CTX_ENGINE_MASK	0x00000003
+#define TX4939_CRYPTO_CTX_ENGINE_DES	0x00000000
+#define TX4939_CRYPTO_CTX_ENGINE_AES	0x00000001
+#define TX4939_CRYPTO_CTX_ENGINE_MD5	0x00000002
+#define TX4939_CRYPTO_CTX_ENGINE_SHA1	0x00000003
+#define TX4939_CRYPTO_CTX_TDMS	0x00000010
+#define TX4939_CRYPTO_CTX_CMS	0x00000020
+#define TX4939_CRYPTO_CTX_DMS	0x00000040
+#define TX4939_CRYPTO_CTX_UPDATE	0x00000080
+
+/* bits for tx4939_crypto_desc.ctrl */
+#define TX4939_CRYPTO_DESC_OB_CNT_MASK	0xffe00000
+#define TX4939_CRYPTO_DESC_OB_CNT(cnt)	((cnt) << 21)
+#define TX4939_CRYPTO_DESC_IB_CNT_MASK	0x001ffc00
+#define TX4939_CRYPTO_DESC_IB_CNT(cnt)	((cnt) << 10)
+#define TX4939_CRYPTO_DESC_START	0x00000200
+#define TX4939_CRYPTO_DESC_END	0x00000100
+#define TX4939_CRYPTO_DESC_XOR	0x00000010
+#define TX4939_CRYPTO_DESC_LAST	0x00000008
+#define TX4939_CRYPTO_DESC_ERR_MASK	0x00000006
+#define TX4939_CRYPTO_DESC_ERR_NONE	0x00000000
+#define TX4939_CRYPTO_DESC_ERR_TOUT	0x00000002
+#define TX4939_CRYPTO_DESC_ERR_DIGEST	0x00000004
+#define TX4939_CRYPTO_DESC_OWN	0x00000001
+
+/* bits for tx4939_crypto_desc.index */
+#define TX4939_CRYPTO_DESC_HASH_IDX_MASK	0x00000070
+#define TX4939_CRYPTO_DESC_HASH_IDX(idx)	((idx) << 4)
+#define TX4939_CRYPTO_DESC_ENCRYPT_IDX_MASK	0x00000007
+#define TX4939_CRYPTO_DESC_ENCRYPT_IDX(idx)	((idx) << 0)
+
+#define TX4939_CRYPTO_NR_SET	6
+
+#define TX4939_CRYPTO_RCSR_INTE	0x00000008
+#define TX4939_CRYPTO_RCSR_RST	0x00000004
+#define TX4939_CRYPTO_RCSR_FIN	0x00000002
+#define TX4939_CRYPTO_RCSR_ST	0x00000001
+
+/*
+ * VPC
+ */
+#define TX4939_VPC_CSR_GBINT	0x00010000
+#define TX4939_VPC_CSR_SWAPO	0x00000020
+#define TX4939_VPC_CSR_SWAPI	0x00000010
+#define TX4939_VPC_CSR_GINTE	0x00000008
+#define TX4939_VPC_CSR_RSTD	0x00000004
+#define TX4939_VPC_CSR_RSTVPC	0x00000002
+
+#define TX4939_VPC_CTRLA_VDPSN	0x00000200
+#define TX4939_VPC_CTRLA_PBUSY	0x00000100
+#define TX4939_VPC_CTRLA_DCINT	0x00000080
+#define TX4939_VPC_CTRLA_UOINT	0x00000040
+#define TX4939_VPC_CTRLA_PDINT_MASK	0x00000030
+#define TX4939_VPC_CTRLA_PDINT_ALL	0x00000000
+#define TX4939_VPC_CTRLA_PDINT_NEXT	0x00000010
+#define TX4939_VPC_CTRLA_PDINT_NONE	0x00000030
+#define TX4939_VPC_CTRLA_VDVLDP	0x00000008
+#define TX4939_VPC_CTRLA_VDMODE	0x00000004
+#define TX4939_VPC_CTRLA_VDFOR	0x00000002
+#define TX4939_VPC_CTRLA_ENVPC	0x00000001
+
+/* bits for tx4939_vpc_desc.ctrl1 */
+#define TX4939_VPC_DESC_CTRL1_ERR_MASK	0x00000006
+#define TX4939_VPC_DESC_CTRL1_OWN	0x00000001
+
+#define tx4939_ddrcptr	((struct tx4939_ddrc_reg __iomem *)TX4939_DDRC_REG)
+#define tx4939_ebuscptr		tx4938_ebuscptr
+#define tx4939_ircptr \
+		((struct tx4939_irc_reg __iomem *)TX4939_IRC_REG)
+#define tx4939_pcicptr		tx4938_pcicptr
+#define tx4939_pcic1ptr		tx4938_pcic1ptr
+#define tx4939_ccfgptr \
+		((struct tx4939_ccfg_reg __iomem *)TX4939_CCFG_REG)
+#define tx4939_sramcptr		tx4938_sramcptr
+#define tx4939_rtcptr \
+		((struct tx4939_rtc_reg __iomem *)TX4939_RTC_REG)
+#define tx4939_cryptoptr \
+		((struct tx4939_crypto_reg __iomem *)TX4939_CRYPTO_REG)
+#define tx4939_vpcptr	((struct tx4939_vpc_reg __iomem *)TX4939_VPC_REG)
+
+#define TX4939_REV_MAJ_MIN()	\
+	((__u32)__raw_readq(&tx4939_ccfgptr->crir) & 0x00ff)
+#define TX4939_REV_PCODE()	\
+	((__u32)__raw_readq(&tx4939_ccfgptr->crir) >> 16)
+#define TX4939_CCFG_BCFG()	\
+	((__u32)((__raw_readq(&tx4939_ccfgptr->ccfg) & TX4939_CCFG_BCFG_MASK) \
+		 >> 32))
+
+#define tx4939_ccfg_clear(bits)	tx4938_ccfg_clear(bits)
+#define tx4939_ccfg_set(bits)	tx4938_ccfg_set(bits)
+#define tx4939_ccfg_change(change, new)	tx4938_ccfg_change(change, new)
+
+#define TX4939_EBUSC_CR(ch)	TX4927_EBUSC_CR(ch)
+#define TX4939_EBUSC_BA(ch)	TX4927_EBUSC_BA(ch)
+#define TX4939_EBUSC_SIZE(ch)	TX4927_EBUSC_SIZE(ch)
+#define TX4939_EBUSC_WIDTH(ch)	\
+	(16 >> ((__u32)(TX4939_EBUSC_CR(ch) >> 20) & 0x1))
+
+/* SCLK0 = MSTCLK * 429/19 * 16/245 / 2  (14.745MHz for MST 20MHz) */
+#define TX4939_SCLK0(mst)	\
+	((((mst) + 245/2) / 245UL * 429 * 16 + 19) / 19 / 2)
+
+void tx4939_wdt_init(void);
+void tx4939_add_memory_regions(void);
+void tx4939_setup(void);
+void tx4939_time_init(unsigned int tmrnr);
+void tx4939_sio_init(unsigned int sclk, unsigned int cts_mask);
+void tx4939_spi_init(int busid);
+void tx4939_ethaddr_init(unsigned char *addr0, unsigned char *addr1);
+int tx4939_report_pciclk(void);
+void tx4939_report_pci1clk(void);
+struct pci_dev;
+int tx4939_pcic1_map_irq(const struct pci_dev *dev, u8 slot);
+int tx4939_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin);
+void tx4939_setup_pcierr_irq(void);
+void tx4939_irq_init(void);
+int tx4939_irq(void);
+void tx4939_mtd_init(int ch);
+
+#endif /* __ASM_TXX9_TX4939_H */
-- 
1.5.6.3
