Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jun 2018 20:52:49 +0200 (CEST)
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:44643 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994602AbeFRSwiNWiM- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Jun 2018 20:52:38 +0200
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 546573F82F;
        Mon, 18 Jun 2018 20:52:37 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aC2wAHVRX1EC; Mon, 18 Jun 2018 20:52:35 +0200 (CEST)
Received: from localhost.localdomain (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 7BF843F40C;
        Mon, 18 Jun 2018 20:52:35 +0200 (CEST)
Date:   Mon, 18 Jun 2018 20:52:33 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     linux-mips@linux-mips.org,
        =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>
Subject: Re: [RFC v2] MIPS: PS2: Interrupt request (IRQ) support
Message-ID: <20180618185232.GA7182@localhost.localdomain>
References: <alpine.DEB.2.00.1709272208300.16752@tp.orcam.me.uk>
 <20170930065654.GA7714@localhost.localdomain>
 <alpine.DEB.2.00.1709301305400.12020@tp.orcam.me.uk>
 <20171029172016.GA2600@localhost.localdomain>
 <alpine.DEB.2.00.1711102209440.10088@tp.orcam.me.uk>
 <20171111160422.GA2332@localhost.localdomain>
 <20180129202715.GA4817@localhost.localdomain>
 <alpine.DEB.2.00.1801312259410.4191@tp.orcam.me.uk>
 <20180303122657.GC24991@localhost.localdomain>
 <20180318104521.GB2364@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180318104521.GB2364@localhost.localdomain>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <noring@nocrew.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64357
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

Hi Maciej,

I have completely reworked the handling of IRQs: it's now modular and
simplified (INTC patch attached below). The cascading interrupts for DMA
and the Graphics Synthesizer are setup in separate modules. The SBUS
interrupts are shared instead of demultiplexed and RPC is no longer used
as an alternative to interrupt forwarding.

Unrelated to IRQs: I have also replaced all previous BIOS calls. The kernel
no longer needs a BIOS and reclaims its memory space. In particular, the
I/O processor (IOP) is reset by the kernel and a boot loader is no longer
needed to perform this task. I also have a collection of patches to get
kexec working with a compressed (vmlinuz) kernel, so it can reboot itself.

I have implemented a graphical putc to render boot prints to the screen,
both when decompressing the kernel and for early boot stages (prom_putchar).
A UART requires extra hardware and soldering and is significantly more
difficult to install.

The frame buffer module is essentially complete. It can operate in two
distinct modes: console xor virtual mode. In console mode text is rendered
as textured tiles from local Graphics Synthesizer memory. This is very fast,
memory and bandwidth efficient. In virtual mode a memory buffer is allocated
in main memory and copied via DMA to the Graphics Synthesizer. This enables
mmap, but it is fairly inefficient and mostly useful for compatibility.
YWRAP and other acceleration techniques are implemented too.

I have a separate device driver for the Graphics Synthesizer. Its interface,
the GIF, is serial with a streaming graphical hardware primitive format (for
points, triangles, sprites, etc.) and a character device (such as /dev/gs)
would be ideal and the most efficient way to render graphics for the R5900,
especially if scatter-gather DMA is implemented as well.

I have many more ideas yet to explore and implement. :)

Fredrik

--- /dev/null
+++ b/arch/mips/ps2/irq.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PlayStation 2 Interrupt controller (INTC) IRQs
+ *
+ * Copyright (C) 2018 Fredrik Noring
+ */
+
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/ioport.h>
+#include <linux/module.h>
+#include <linux/types.h>
+
+#include <asm/bootinfo.h>
+#include <asm/io.h>
+#include <asm/irq_cpu.h>
+#include <asm/mipsregs.h>
+
+#include <asm/mach-ps2/irq.h>
+#include <asm/mach-ps2/ps2.h>
+
+static inline void intc_reverse_mask(struct irq_data *data)
+{
+	outl(BIT(data->irq - IRQ_INTC), INTC_MASK);
+}
+
+static void intc_mask_ack(struct irq_data *data)
+{
+	const unsigned int bit = BIT(data->irq - IRQ_INTC);
+
+	outl(bit, INTC_MASK);
+	outl(bit, INTC_STAT);
+}
+
+#define INTC_IRQ_TYPE(irq_, name_)				\
+	{							\
+		.irq = irq_,					\
+		.irq_chip = {					\
+			.name = name_,				\
+			.irq_unmask = intc_reverse_mask,	\
+			.irq_mask = intc_reverse_mask,		\
+			.irq_mask_ack = intc_mask_ack,		\
+		}						\
+	}
+
+static struct {
+	unsigned int irq;
+	struct irq_chip irq_chip;
+} intc_irqs[] = {
+	INTC_IRQ_TYPE(IRQ_INTC_GS,     "INTC GS"),
+	INTC_IRQ_TYPE(IRQ_INTC_SBUS,   "INTC SBUS"),
+	INTC_IRQ_TYPE(IRQ_INTC_VB_ON,  "INTC VB on"),
+	INTC_IRQ_TYPE(IRQ_INTC_VB_OFF, "INTC VB off"),
+	INTC_IRQ_TYPE(IRQ_INTC_VIF0,   "INTC VIF0"),
+	INTC_IRQ_TYPE(IRQ_INTC_VIF1,   "INTC VIF1"),
+	INTC_IRQ_TYPE(IRQ_INTC_VU0,    "INTC VU0"),
+	INTC_IRQ_TYPE(IRQ_INTC_VU1,    "INTC VU1"),
+	INTC_IRQ_TYPE(IRQ_INTC_IPU,    "INTC IPU"),
+	INTC_IRQ_TYPE(IRQ_INTC_TIMER0, "INTC timer0"),
+	INTC_IRQ_TYPE(IRQ_INTC_TIMER1, "INTC timer1"),
+	INTC_IRQ_TYPE(IRQ_INTC_TIMER2, "INTC timer2"),
+	INTC_IRQ_TYPE(IRQ_INTC_TIMER3, "INTC timer3"),
+	INTC_IRQ_TYPE(IRQ_INTC_SFIFO,  "INTC SFIFO"),
+	INTC_IRQ_TYPE(IRQ_INTC_VU0WD,  "INTC VU0WD"),
+	INTC_IRQ_TYPE(IRQ_INTC_PGPU,   "INTC PGPU"),
+};
+
+static irqreturn_t intc_cascade(int irq, void *data)
+{
+	unsigned int pending, irq_intc;
+	irqreturn_t status = IRQ_NONE;
+
+	for (pending = inl(INTC_STAT); pending; pending &= ~BIT(irq_intc)) {
+		irq_intc = __fls(pending);
+
+		if (generic_handle_irq(irq_intc + IRQ_INTC) < 0)
+			spurious_interrupt();
+		else
+			status = IRQ_HANDLED;
+	}
+
+	return status;
+}
+
+static struct irqaction cascade_intc_irqaction = {
+	.name = "INTC cascade",
+	.handler = intc_cascade,
+};
+
+void __init arch_init_irq(void)
+{
+	int err;
+	int i;
+
+	mips_cpu_irq_init();
+
+	for (i = 0; i < ARRAY_SIZE(intc_irqs); i++)
+		irq_set_chip_and_handler(intc_irqs[i].irq,
+			&intc_irqs[i].irq_chip, handle_level_irq);
+
+	/* FIXME: Is HARDIRQS_SW_RESEND needed? Are these edge types needed? */
+	irq_set_irq_type(IRQ_INTC_GS, IRQ_TYPE_EDGE_FALLING);
+	irq_set_irq_type(IRQ_INTC_SBUS, IRQ_TYPE_EDGE_FALLING);
+	irq_set_irq_type(IRQ_INTC_VB_ON, IRQ_TYPE_EDGE_RISING);
+	irq_set_irq_type(IRQ_INTC_VB_OFF, IRQ_TYPE_EDGE_FALLING);
+
+	outl(inl(INTC_MASK), INTC_MASK);
+	outl(inl(INTC_STAT), INTC_STAT);
+
+	err = setup_irq(IRQ_C0_INTC, &cascade_intc_irqaction);
+	if (err)
+		printk(KERN_ERR "irq: Failed to setup INTC (err = %d).\n", err);
+}
+
+asmlinkage void plat_irq_dispatch(void)
+{
+	const unsigned int pending = read_c0_status() & read_c0_cause();
+
+	if (!(pending & (CAUSEF_IP2 | CAUSEF_IP3 | CAUSEF_IP7)))
+		return spurious_interrupt();
+
+	if (pending & CAUSEF_IP2)
+		do_IRQ(IRQ_C0_INTC);	/* INTC interrupt */
+	if (pending & CAUSEF_IP3)
+		do_IRQ(IRQ_C0_DMAC);	/* DMAC interrupt */
+	if (pending & CAUSEF_IP7)
+		do_IRQ(IRQ_C0_IRQ7);	/* Timer interrupt */
+}
