Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Mar 2018 13:27:30 +0100 (CET)
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:35640 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990588AbeCCM1TVJvQB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 3 Mar 2018 13:27:19 +0100
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 921E43F4F5;
        Sat,  3 Mar 2018 13:27:10 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lBOlTwwkqp0A; Sat,  3 Mar 2018 13:27:09 +0100 (CET)
Received: from localhost.localdomain (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 187DA3F38D;
        Sat,  3 Mar 2018 13:27:04 +0100 (CET)
Date:   Sat, 3 Mar 2018 13:26:59 +0100
From:   Fredrik Noring <noring@nocrew.org>
To:     "Maciej W. Rozycki" <macro@mips.com>,
        =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>
Cc:     linux-mips@linux-mips.org
Subject: [RFC] MIPS: PS2: Interrupt request (IRQ) support
Message-ID: <20180303122657.GC24991@localhost.localdomain>
References: <alpine.DEB.2.00.1709201705070.16752@tp.orcam.me.uk>
 <20170927172107.GB2631@localhost.localdomain>
 <alpine.DEB.2.00.1709272208300.16752@tp.orcam.me.uk>
 <20170930065654.GA7714@localhost.localdomain>
 <alpine.DEB.2.00.1709301305400.12020@tp.orcam.me.uk>
 <20171029172016.GA2600@localhost.localdomain>
 <alpine.DEB.2.00.1711102209440.10088@tp.orcam.me.uk>
 <20171111160422.GA2332@localhost.localdomain>
 <20180129202715.GA4817@localhost.localdomain>
 <alpine.DEB.2.00.1801312259410.4191@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.00.1801312259410.4191@tp.orcam.me.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <noring@nocrew.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62790
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noring@nocrew.org
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

Hi Maciej & Jürgen,

This patch for IRQ support does a bit more than strictly required for the
initial submission by supporting for example the Graphics Synthesizer.
Please let me know if I should split it into several parts.

A few comments and questions:

1. The patch contains four volatile variables to handle masks:

	static volatile unsigned long intc_mask = 0;
	static volatile unsigned long dmac_mask = 0;
	static volatile unsigned long gs_mask = 0;
	static volatile unsigned long sbus_mask = 0;

   It seems the functions irq_set_chip_data and irq_data_get_irq_chip_data
   are used for similar purposes in other implementations. Perhaps it makes
   sense to use those instead?

2. Is there a reason to handle (or not handle) USB interrupts here? Is USB
   a special case as opposed to for example the Graphics Synthesizer, etc.?

3. What kind of name strings are recommended for struct irq_chip and struct
   irqaction? Heavily abbreviated such as "EE DMAC" or more spelled out such
   as "Emotion Engine DMAC"?

Fredrik

diff --git a/arch/mips/include/asm/mach-ps2/irq.h b/arch/mips/include/asm/mach-ps2/irq.h
new file mode 100644
index 000000000000..b5a9727607cf
--- /dev/null
+++ b/arch/mips/include/asm/mach-ps2/irq.h
@@ -0,0 +1,92 @@
+/*
+ * PlayStation 2 IRQs
+ *
+ * Copyright (C) 2000-2002 Sony Computer Entertainment Inc.
+ * Copyright (C) 2010-2013 Jürgen Urban
+ * Copyright (C) 2017-2018 Fredrik Noring
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#ifndef __ASM_PS2_IRQ_H
+#define __ASM_PS2_IRQ_H
+
+#define NR_IRQS		56
+
+/*
+ * The interrupt controller (INTC) arbitrates interrupts from peripheral
+ * devices, except for the DMAC.
+ */
+#define IRQ_INTC	0
+#define IRQ_INTC_GS	0	/* Graphics Synthesizer */
+#define IRQ_INTC_SBUS	1	/* Bus connecting the Emotion Engine to the
+				   I/O processor (IOP) via the sub-system
+				   interface (SIF) */
+#define IRQ_INTC_VB_ON	2	/* Vertical blank start */
+#define IRQ_INTC_VB_OFF	3	/* Vertical blank end */
+#define IRQ_INTC_VIF0	4	/* VPU0 Interface packet expansion engine */
+#define IRQ_INTC_VIF1	5	/* VPU1 Interface packet expansion engine */
+#define IRQ_INTC_VU0	6	/* Vector Core Operation Unit 0 */
+#define IRQ_INTC_VU1	7	/* Vector Core Operation Unit 1 */
+#define IRQ_INTC_IPU	8	/* Image processor unit (MPEG 2 video etc.) */
+#define IRQ_INTC_TIMER0	9	/* Independent screen timer 0 */
+#define IRQ_INTC_TIMER1	10	/* Independent screen timer 1 */
+#define IRQ_INTC_TIMER2	11	/* Independent screen timer 2 */
+#define IRQ_INTC_TIMER3	12	/* Independent screen timer 3 */
+#define IRQ_INTC_SFIFO	13	/* Error detected during SFIFO transfers */
+#define IRQ_INTC_VU0WD	14	/* VU0 watch dog for RUN (sends force break) */
+#define IRQ_INTC_PGPU	15
+
+/*
+ * The DMA controller (DMAC) handles transfers between main memory and
+ * peripheral devices or the scratch pad RAM (SPRAM).
+ *
+ * The DMAC arbitrates the main bus at the same time, and supports chain
+ * mode which switches transfer addresses according to DMA tags attached to
+ * the transfer. The stall control synchronises two-channel transfers with
+ * priority control.
+ *
+ * Data is transferred in 128-bit words which must be aligned. Bus snooping
+ * is not performed.
+ */
+#define IRQ_DMAC	16
+#define IRQ_DMAC_0	16
+#define IRQ_DMAC_1	17
+#define IRQ_DMAC_2	18
+#define IRQ_DMAC_3	19
+#define IRQ_DMAC_4	20
+#define IRQ_DMAC_5	21
+#define IRQ_DMAC_6	22
+#define IRQ_DMAC_7	23
+#define IRQ_DMAC_8	24
+#define IRQ_DMAC_9	25
+#define IRQ_DMAC_S	29
+#define IRQ_DMAC_ME	30
+#define IRQ_DMAC_BE	31
+
+/* Graphics Synthesizer */
+#define IRQ_GS		32
+#define IRQ_GS_SIGNAL	32
+#define IRQ_GS_FINISH	33
+#define IRQ_GS_HSYNC	34
+#define IRQ_GS_VSYNC	35
+#define IRQ_GS_EDW	36
+#define IRQ_GS_EXHSYNC	37
+#define IRQ_GS_EXVSYNC	38
+
+/*
+ * Bus connecting the Emotion Engine to the I/O processor (IOP)
+ * via the sub-system interface (SIF)
+ */
+#define IRQ_SBUS	40
+#define IRQ_SBUS_AIF	40
+#define IRQ_SBUS_PCIC	41
+#define IRQ_SBUS_USB	42
+
+/* MIPS IRQs */
+#define MIPS_CPU_IRQ_BASE 48
+#define IRQ_C0_INTC	50
+#define IRQ_C0_DMAC	51
+#define IRQ_C0_IRQ7	55
+
+#endif /* __ASM_PS2_IRQ_H */
diff --git a/arch/mips/include/asm/mach-ps2/speed.h b/arch/mips/include/asm/mach-ps2/speed.h
new file mode 100644
index 000000000000..3aedcb27afe9
--- /dev/null
+++ b/arch/mips/include/asm/mach-ps2/speed.h
@@ -0,0 +1,25 @@
+/*
+ * PlayStation 2 Ethernet
+ *
+ * Copyright (C) 2001      Sony Computer Entertainment Inc.
+ * Copyright (C) 2010-2013 Jürgen Urban
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#ifndef __ASM_PS2_SPEED_H
+#define __ASM_PS2_SPEED_H
+
+#define DEV9M_BASE		0x14000000
+
+#define SPD_R_REV		(DEV9M_BASE + 0x00)
+#define SPD_R_REV_1		(DEV9M_BASE + 0x00)
+#define SPD_R_REV_3		(DEV9M_BASE + 0x04)
+
+#define SPD_R_INTR_STAT		(DEV9M_BASE + 0x28)
+#define SPD_R_INTR_ENA		(DEV9M_BASE + 0x2a)
+#define SPD_R_XFR_CTRL		(DEV9M_BASE + 0x32)
+#define SPD_R_IF_CTRL		(DEV9M_BASE + 0x64)
+
+#endif /* __ASM_PS2_SPEED_H */
+
diff --git a/arch/mips/ps2/irq.c b/arch/mips/ps2/irq.c
new file mode 100644
index 000000000000..9e4392837b9f
--- /dev/null
+++ b/arch/mips/ps2/irq.c
@@ -0,0 +1,491 @@
+/*
+ * PlayStation 2 IRQs
+ *
+ * Copyright (C) 2000-2002 Sony Computer Entertainment Inc.
+ * Copyright (C) 2010-2013 Jürgen Urban
+ * Copyright (C) 2017-2018 Fredrik Noring
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/ioport.h>
+
+#include <asm/bootinfo.h>
+#include <asm/io.h>
+#include <asm/mipsregs.h>
+#include <asm/irq_cpu.h>
+
+#include <asm/mach-ps2/irq.h>
+#include <asm/mach-ps2/speed.h>
+#include <asm/mach-ps2/ps2.h>
+
+#define INTC_STAT	0x1000f000
+#define INTC_MASK	0x1000f010
+#define DMAC_STAT	0x1000e010
+#define DMAC_MASK	0x1000e010
+#define GS_CSR		0x12001000
+#define GS_IMR		0x12001010
+
+#define SBUS_SMFLG	0x1000f230
+#define SBUS_AIF_INTSR	0x18000004
+#define SBUS_AIF_INTEN	0x18000006
+#define SBUS_PCIC_EXC1	0x1f801476
+#define SBUS_PCIC_CSC1	0x1f801464
+#define SBUS_PCIC_IMR1	0x1f801468
+#define SBUS_PCIC_TIMR	0x1f80147e
+#define SBUS_PCIC3_TIMR	0x1f801466
+
+/* INTC */
+
+static volatile unsigned long intc_mask = 0;	/* FIXME: Why volatile? */
+
+static inline void intc_enable_irq(struct irq_data *data)
+{
+	if (!(intc_mask & (1 << data->irq))) {
+		intc_mask |= (1 << data->irq);
+		outl(1 << data->irq, INTC_MASK);
+	}
+}
+
+static inline void intc_disable_irq(struct irq_data *data)
+{
+	if ((intc_mask & (1 << data->irq))) {
+		intc_mask &= ~(1 << data->irq);
+		outl(1 << data->irq, INTC_MASK);
+	}
+}
+
+static unsigned int intc_startup_irq(struct irq_data *data)
+{
+	intc_enable_irq(data);
+
+	return 0;
+}
+
+static void intc_shutdown_irq(struct irq_data *data)
+{
+	intc_disable_irq(data);
+}
+
+static void intc_ack_irq(struct irq_data *data)
+{
+	intc_disable_irq(data);
+	outl(1 << data->irq, INTC_STAT);
+}
+
+static void intc_end_irq(struct irq_data *data)
+{
+	intc_enable_irq(data);
+}
+
+static struct irq_chip intc_irq_type = {
+	.name		= "Emotion Engine INTC",
+	.irq_startup	= intc_startup_irq,
+	.irq_shutdown	= intc_shutdown_irq,
+	.irq_unmask	= intc_enable_irq,
+	.irq_mask	= intc_disable_irq,
+	.irq_mask_ack	= intc_ack_irq,
+	.irq_eoi	= intc_end_irq,
+};
+
+/* DMAC */
+
+static volatile unsigned long dmac_mask = 0;	/* FIXME: Why volatile? */
+
+static inline void dmac_enable_irq(struct irq_data *data)
+{
+	const unsigned int dmac_irq_nr = data->irq - IRQ_DMAC;
+
+	if (!(dmac_mask & (1 << dmac_irq_nr))) {
+		dmac_mask |= (1 << dmac_irq_nr);
+		outl(1 << (dmac_irq_nr + 16), DMAC_MASK);
+	}
+}
+
+static inline void dmac_disable_irq(struct irq_data *data)
+{
+	const unsigned int dmac_irq_nr = data->irq - IRQ_DMAC;
+
+	if ((dmac_mask & (1 << dmac_irq_nr))) {
+		dmac_mask &= ~(1 << dmac_irq_nr);
+		outl(1 << (dmac_irq_nr + 16), DMAC_MASK);
+	}
+}
+
+static unsigned int dmac_startup_irq(struct irq_data *data)
+{
+	dmac_enable_irq(data);
+
+	return 0;
+}
+
+static void dmac_shutdown_irq(struct irq_data *data)
+{
+	dmac_disable_irq(data);
+}
+
+static void dmac_ack_irq(struct irq_data *data)
+{
+	const unsigned int dmac_irq_nr = data->irq - IRQ_DMAC;
+
+	dmac_disable_irq(data);
+	outl(1 << dmac_irq_nr, DMAC_STAT);
+}
+
+static void dmac_end_irq(struct irq_data *data)
+{
+	dmac_enable_irq(data);
+}
+
+static struct irq_chip dmac_irq_type = {
+	.name		= "Emotion Engine DMAC",
+	.irq_startup	= dmac_startup_irq,
+	.irq_shutdown	= dmac_shutdown_irq,
+	.irq_unmask	= dmac_enable_irq,
+	.irq_mask	= dmac_disable_irq,
+	.irq_mask_ack	= dmac_ack_irq,
+	.irq_eoi	= dmac_end_irq,
+};
+
+/* Graphics Synthesizer */
+
+static volatile unsigned long gs_mask = 0;	/* FIXME: Why volatile? */
+
+void ps2_setup_gs_imr(void)
+{
+	outl(0xff00, GS_IMR);
+	outl((~gs_mask & 0x7f) << 8, GS_IMR);
+}
+
+static inline void gs_enable_irq(struct irq_data *data)
+{
+	unsigned int gs_irq_nr = data->irq - IRQ_GS;
+
+	gs_mask |= (1 << gs_irq_nr);
+	ps2_setup_gs_imr();
+}
+
+static inline void gs_disable_irq(struct irq_data *data)
+{
+	unsigned int gs_irq_nr = data->irq - IRQ_GS;
+
+	gs_mask &= ~(1 << gs_irq_nr);
+	ps2_setup_gs_imr();
+}
+
+static unsigned int gs_startup_irq(struct irq_data *data)
+{
+	gs_enable_irq(data);
+	return 0;
+}
+
+static void gs_shutdown_irq(struct irq_data *data)
+{
+	gs_disable_irq(data);
+}
+
+static void gs_ack_irq(struct irq_data *data)
+{
+	unsigned int gs_irq_nr = data->irq - IRQ_GS;
+
+	outl(0xff00, GS_IMR);
+	outl(1 << gs_irq_nr, GS_CSR);
+}
+
+static void gs_end_irq(struct irq_data *data)
+{
+	outl((~gs_mask & 0x7f) << 8, GS_IMR);
+	gs_enable_irq(data);
+}
+
+static struct irq_chip gs_irq_type = {
+	.name		= "Graphics Synthesizer",
+	.irq_startup	= gs_startup_irq,
+	.irq_shutdown	= gs_shutdown_irq,
+	.irq_unmask	= gs_enable_irq,
+	.irq_mask	= gs_disable_irq,
+	.irq_mask_ack	= gs_ack_irq,
+	.irq_eoi	= gs_end_irq,
+};
+
+/* SBUS */
+
+static volatile unsigned long sbus_mask = 0;	/* FIXME: Why volatile? */
+
+static inline unsigned long sbus_enter_irq(void)
+{
+	unsigned long istat = 0;
+
+	if (inl(SBUS_SMFLG) & (1 << 8)) {
+		outl(1 << 8, SBUS_SMFLG);
+		switch (ps2_pcic_type) {
+		case 1:
+			if (inw(SBUS_PCIC_CSC1) & 0x0080) {
+				outw(0xffff, SBUS_PCIC_CSC1);
+				istat |= 1 << (IRQ_SBUS_PCIC - IRQ_SBUS);
+			}
+			break;
+		case 2:
+			if (inw(SBUS_PCIC_CSC1) & 0x0080) {
+				outw(0xffff, SBUS_PCIC_CSC1);
+				istat |= 1 << (IRQ_SBUS_PCIC - IRQ_SBUS);
+			}
+			break;
+		case 3:
+			istat |= 1 << (IRQ_SBUS_PCIC - IRQ_SBUS);
+			break;
+		}
+	}
+
+	if (inl(SBUS_SMFLG) & (1 << 10)) {
+		outl(1 << 10, SBUS_SMFLG);
+		istat |= 1 << (IRQ_SBUS_USB - IRQ_SBUS);
+	}
+
+	return istat;
+}
+
+static inline void sbus_leave_irq(void)
+{
+	unsigned short mask;
+
+	if (ps2_pccard_present == 0x0100) {
+		mask = inw(SPD_R_INTR_ENA);
+		outw(0, SPD_R_INTR_ENA);
+		outw(mask, SPD_R_INTR_ENA);
+	}
+
+	switch (ps2_pcic_type) {
+	case 1:	/* Fall-through */
+	case 2:
+		mask = inw(SBUS_PCIC_TIMR);
+		outw(1, SBUS_PCIC_TIMR);
+		outw(mask, SBUS_PCIC_TIMR);
+		break;
+	case 3:
+		mask = inw(SBUS_PCIC3_TIMR);
+		outw(1, SBUS_PCIC3_TIMR);
+		outw(mask, SBUS_PCIC3_TIMR);
+		break;
+	}
+}
+
+static inline void sbus_enable_irq(struct irq_data *data)
+{
+	unsigned int sbus_irq_nr = data->irq - IRQ_SBUS;
+
+	sbus_mask |= (1 << sbus_irq_nr);
+
+	switch (data->irq) {
+	case IRQ_SBUS_PCIC:
+		switch (ps2_pcic_type) {
+		case 1:
+			outw(0xff7f, SBUS_PCIC_IMR1);
+			break;
+		case 2:
+			outw(0, SBUS_PCIC_TIMR);
+			break;
+		case 3:
+			outw(0, SBUS_PCIC3_TIMR);
+			break;
+		}
+		break;
+	case IRQ_SBUS_USB:
+		break;
+	}
+}
+
+static inline void sbus_disable_irq(struct irq_data *data)
+{
+	unsigned int sbus_irq_nr = data->irq - IRQ_SBUS;
+
+	sbus_mask &= ~(1 << sbus_irq_nr);
+
+	switch (data->irq) {
+	case IRQ_SBUS_PCIC:
+		switch (ps2_pcic_type) {
+		case 1:
+			outw(0xffff, SBUS_PCIC_IMR1);
+			break;
+		case 2:
+			outw(1, SBUS_PCIC_TIMR);
+			break;
+		case 3:
+			outw(1, SBUS_PCIC3_TIMR);
+			break;
+		}
+		break;
+	case IRQ_SBUS_USB:
+		break;
+	}
+}
+
+static unsigned int sbus_startup_irq(struct irq_data *data)
+{
+	sbus_enable_irq(data);
+
+	return 0;
+}
+
+static void sbus_shutdown_irq(struct irq_data *data)
+{
+	sbus_disable_irq(data);
+}
+
+static void sbus_ack_irq(struct irq_data *data)
+{
+}
+
+static void sbus_end_irq(struct irq_data *data)
+{
+}
+
+static struct irq_chip sbus_irq_type = {
+	.name		= "I/O processor",
+	.irq_startup	= sbus_startup_irq,
+	.irq_shutdown	= sbus_shutdown_irq,
+	.irq_unmask	= sbus_enable_irq,
+	.irq_mask	= sbus_disable_irq,
+	.irq_mask_ack	= sbus_ack_irq,
+	.irq_eoi	= sbus_end_irq,
+};
+
+static irqreturn_t gs_cascade(int irq, void *data)
+{
+	const u32 irq_reg = inl(GS_CSR) & gs_mask;
+
+	if (irq_reg)
+		generic_handle_irq(__fls(irq_reg) + IRQ_GS);
+
+	return IRQ_HANDLED;
+}
+
+static struct irqaction cascade_gs_irqaction = {
+	.name = "Graphics Synthesizer cascade",
+	.handler = gs_cascade,
+};
+
+static irqreturn_t sbus_cascade(int irq, void *data)
+{
+	u32 irq_reg;
+
+	preempt_disable();
+
+	irq_reg = sbus_enter_irq() & sbus_mask;
+	if (irq_reg)
+		generic_handle_irq(__fls(irq_reg) + IRQ_SBUS);
+	sbus_leave_irq();
+
+	preempt_enable_no_resched();
+
+	return IRQ_HANDLED;
+}
+
+static struct irqaction cascade_sbus_irqaction = {
+	.name = "SBUS cascade",
+	.handler = sbus_cascade,
+};
+
+static irqreturn_t intc_cascade(int irq, void *data)
+{
+	const u32 irq_reg = inl(INTC_STAT) & intc_mask;
+
+	if (irq_reg)
+		generic_handle_irq(__fls(irq_reg) + IRQ_INTC);
+
+	return IRQ_HANDLED;
+}
+
+static struct irqaction cascade_intc_irqaction = {
+	.handler = intc_cascade,
+	.name = "INTC cascade",
+};
+
+static irqreturn_t dmac_cascade(int irq, void *data)
+{
+	const u32 irq_reg = inl(DMAC_STAT) & dmac_mask;
+
+	if (irq_reg)
+		generic_handle_irq(__fls(irq_reg) + IRQ_DMAC);
+
+	return IRQ_HANDLED;
+}
+
+static struct irqaction cascade_dmac_irqaction = {
+	.name = "DMAC cascade",
+	.handler = dmac_cascade,
+};
+
+void __init arch_init_irq(void)
+{
+	int err;
+	int i;
+
+	mips_cpu_irq_init();	/* Initialise CPU IRQs. */
+
+	for (i = 0; i < MIPS_CPU_IRQ_BASE; i++) {
+		struct irq_chip *handler =
+			i < IRQ_DMAC ? &intc_irq_type :
+			i < IRQ_GS   ? &dmac_irq_type :
+			i < IRQ_SBUS ?   &gs_irq_type :
+				       &sbus_irq_type ;
+
+		irq_set_chip_and_handler(i, handler, handle_level_irq);
+	}
+
+	/* Initialise interrupt mask. */
+
+	intc_mask = 0;
+	outl(inl(INTC_MASK), INTC_MASK);
+	outl(inl(INTC_STAT), INTC_STAT);
+
+	dmac_mask = 0;
+	outl(inl(DMAC_MASK), DMAC_MASK);
+
+	gs_mask = 0;
+	outl(0xff00, GS_IMR);
+	outl(0x00ff, GS_CSR);
+
+	sbus_mask = 0;
+	outl((1 << 8) | (1 << 10), SBUS_SMFLG);
+
+	/* Enable cascaded GS IRQ. */
+	err = setup_irq(IRQ_INTC_GS, &cascade_gs_irqaction);
+	if (err)
+		printk(KERN_ERR "irq: Failed to setup GS IRQ (err = %d).\n", err);
+
+	/* Enable cascaded SBUS IRQ. */
+	err = setup_irq(IRQ_INTC_SBUS, &cascade_sbus_irqaction);
+	if (err)
+		printk(KERN_ERR "irq: Failed to setup SBUS IRQ (err = %d).\n", err);
+
+	/* Enable INTC interrupt. */
+	err = setup_irq(IRQ_C0_INTC, &cascade_intc_irqaction);
+	if (err)
+		printk(KERN_ERR "irq: Failed to setup INTC (err = %d).\n", err);
+
+	/* Enable DMAC interrupt. */
+	err = setup_irq(IRQ_C0_DMAC, &cascade_dmac_irqaction);
+	if (err)
+		printk(KERN_ERR "irq: Failed to setup DMAC (err = %d).\n", err);
+}
+
+asmlinkage void plat_irq_dispatch(void)
+{
+	const int pending = read_c0_status() & read_c0_cause();
+
+	/* First check for r4k counter/timer IRQs. */
+	if (pending & CAUSEF_IP2)
+		do_IRQ(IRQ_C0_INTC);	/* INTC interrupt. */
+	else if (pending & CAUSEF_IP3)
+		do_IRQ(IRQ_C0_DMAC);	/* DMAC interrupt. */
+	else if (pending & CAUSEF_IP7)
+		do_IRQ(IRQ_C0_IRQ7);	/* Timer interrupt. */
+	else
+		spurious_interrupt();
+}
