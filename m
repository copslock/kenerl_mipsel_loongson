Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Mar 2018 11:45:51 +0100 (CET)
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:57520 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994666AbeCRKpnl7Nv9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Mar 2018 11:45:43 +0100
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 4E2573F635;
        Sun, 18 Mar 2018 11:45:35 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vUON0PnYKP27; Sun, 18 Mar 2018 11:45:31 +0100 (CET)
Received: from localhost.localdomain (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 142A33F4D9;
        Sun, 18 Mar 2018 11:45:24 +0100 (CET)
Date:   Sun, 18 Mar 2018 11:45:22 +0100
From:   Fredrik Noring <noring@nocrew.org>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-mips@linux-mips.org,
        =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>
Subject: Re: [RFC] MIPS: PS2: Interrupt request (IRQ) support
Message-ID: <20180318104521.GB2364@localhost.localdomain>
References: <20170927172107.GB2631@localhost.localdomain>
 <alpine.DEB.2.00.1709272208300.16752@tp.orcam.me.uk>
 <20170930065654.GA7714@localhost.localdomain>
 <alpine.DEB.2.00.1709301305400.12020@tp.orcam.me.uk>
 <20171029172016.GA2600@localhost.localdomain>
 <alpine.DEB.2.00.1711102209440.10088@tp.orcam.me.uk>
 <20171111160422.GA2332@localhost.localdomain>
 <20180129202715.GA4817@localhost.localdomain>
 <alpine.DEB.2.00.1801312259410.4191@tp.orcam.me.uk>
 <20180303122657.GC24991@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180303122657.GC24991@localhost.localdomain>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <noring@nocrew.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63025
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

Hi Maciej and Thomas,

Thomas: Please have a look at the first questions below, regarding
irq_data->mask and irq_chip->irq_calc_mask. Are they supposed to be usable?

> +static volatile unsigned long intc_mask = 0;	/* FIXME: Why volatile? */
> +
> +static inline void intc_enable_irq(struct irq_data *data)
> +{
> +	if (!(intc_mask & (1 << data->irq))) {
> +		intc_mask |= (1 << data->irq);
> +		outl(1 << data->irq, INTC_MASK);
> +	}
> +}

The intc_mask variable can be removed, since INTC_MASK is readable, although
perhaps there are performance reasons to not read the register directly?

I also noticed that struct irq_data contains a mask field, which allows
simplifications to

static inline void intc_enable_irq(struct irq_data *data)
{
	if (!(inl(INTC_MASK) & data->mask))
		outl(data->mask, INTC_MASK);
}

provided the following patch is applied to kernel/irq/irqdesc.c:

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -109,6 +109,7 @@ static void desc_set_defaults(unsigned int irq, struct irq_desc *desc, int node,
 	desc->irq_common_data.msi_desc = NULL;
 
 	desc->irq_data.common = &desc->irq_common_data;
+	desc->irq_data.mask = 1 << irq; /* FIXME: What about irq_calc_mask? */
 	desc->irq_data.irq = irq;
 	desc->irq_data.chip = &no_irq_chip;
 	desc->irq_data.chip_data = NULL;

Perhaps the mask field ought to be assigned "1 << irq_data->hwirq" instead,
unless irq_calc_mask is provided. The mask documentation is not entirely
clear on the use and any restrictions, and it does not seem to be used all
that much.

The mask field and irq_calc_mask were introduced by Thomas Gleixner in
commits 966dc736b819 "genirq: Generic chip: Cache per irq bit mask" and
d0051816e619 "genirq: irqchip: Add a mask calculation function" in 2013.

> +static inline void dmac_enable_irq(struct irq_data *data)
> +{
> +	const unsigned int dmac_irq_nr = data->irq - IRQ_DMAC;

This is perhaps a case where the difference between data->irq and
data->hwirq would be relevant to compute data->mask?

> +/* Graphics Synthesizer */
> +
> +static volatile unsigned long gs_mask = 0;	/* FIXME: Why volatile? */

The interrupt mask for the Graphics Synthesizer is only writable, and does
not toggle bits, so it appears a register copy somehow must be maintained by
the kernel.

> +void ps2_setup_gs_imr(void)
> +{
> +	outl(0xff00, GS_IMR);
> +	outl((~gs_mask & 0x7f) << 8, GS_IMR);
> +}

It is not entirely clear why GS_IMR needs to be fully masked (interrupts
disabled) before set to its proper value.

The GS User's Manual (p. 95) mentions that SIGMSK must be toggled when data
is written to the SIGNAL register, but does that apply here? And why not
only the SIGNAL bit zero then?

> +static inline unsigned long sbus_enter_irq(void)
> +{
> +	unsigned long istat = 0;
> +
> +	if (inl(SBUS_SMFLG) & (1 << 8)) {
> +		outl(1 << 8, SBUS_SMFLG);
> +		switch (ps2_pcic_type) {
> +		case 1:
> +			if (inw(SBUS_PCIC_CSC1) & 0x0080) {
> +				outw(0xffff, SBUS_PCIC_CSC1);
> +				istat |= 1 << (IRQ_SBUS_PCIC - IRQ_SBUS);
> +			}
> +			break;
> +		case 2:
> +			if (inw(SBUS_PCIC_CSC1) & 0x0080) {
> +				outw(0xffff, SBUS_PCIC_CSC1);
> +				istat |= 1 << (IRQ_SBUS_PCIC - IRQ_SBUS);
> +			}
> +			break;
> +		case 3:
> +			istat |= 1 << (IRQ_SBUS_PCIC - IRQ_SBUS);
> +			break;
> +		}
> +	}

It's unclear what these registers actually do.

> +	if (inl(SBUS_SMFLG) & (1 << 10)) {
> +		outl(1 << 10, SBUS_SMFLG);
> +		istat |= 1 << (IRQ_SBUS_USB - IRQ_SBUS);
> +	}

This is needed to support USB in the initial patch submission.

> +static inline void sbus_enable_irq(struct irq_data *data)
> +{
> +	unsigned int sbus_irq_nr = data->irq - IRQ_SBUS;
> +
> +	sbus_mask |= (1 << sbus_irq_nr);
> +
> +	switch (data->irq) {
> +	case IRQ_SBUS_PCIC:
> +		switch (ps2_pcic_type) {
> +		case 1:
> +			outw(0xff7f, SBUS_PCIC_IMR1);
> +			break;
> +		case 2:
> +			outw(0, SBUS_PCIC_TIMR);
> +			break;
> +		case 3:
> +			outw(0, SBUS_PCIC3_TIMR);
> +			break;
> +		}
> +		break;
> +	case IRQ_SBUS_USB:
> +		break;

Something needs to be done to mask and unmask USB interrupts, but it's not
entirely clear in what way. As Alan Stern notes in

https://marc.info/?l=linux-usb&m=152106073613807&w=2

disabling interrupts by setting OHCI_INTR_MIE in the OHCI registers isn't
the recommended method.

> +static struct irq_chip sbus_irq_type = {
> +	.name		= "I/O processor",

Are solidus and space allowed in names?

> +static struct irqaction cascade_intc_irqaction = {
> +	.handler = intc_cascade,
> +	.name = "INTC cascade",
> +};

I'm not sure how a cascade is supposed to work here.

> +	for (i = 0; i < MIPS_CPU_IRQ_BASE; i++) {
> +		struct irq_chip *handler =
> +			i < IRQ_DMAC ? &intc_irq_type :
> +			i < IRQ_GS   ? &dmac_irq_type :
> +			i < IRQ_SBUS ?   &gs_irq_type :
> +				       &sbus_irq_type ;
> +
> +		irq_set_chip_and_handler(i, handler, handle_level_irq);
> +	}

I'm considering unrolling this loop into four separate loops.

Fredrik
