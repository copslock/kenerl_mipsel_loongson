Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Mar 2018 20:15:50 +0100 (CET)
Received: from Galois.linutronix.de ([IPv6:2a01:7a0:2:106d:700::1]:54074 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992121AbeCSTPnEsFLb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Mar 2018 20:15:43 +0100
Received: from p4fea5f09.dip0.t-ipconnect.de ([79.234.95.9] helo=nanos.glx-home)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ey0Fy-00086G-1K; Mon, 19 Mar 2018 20:15:42 +0100
Date:   Mon, 19 Mar 2018 20:15:41 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Fredrik Noring <noring@nocrew.org>
cc:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        linux-mips@linux-mips.org,
        =?ISO-8859-15?Q?J=FCrgen_Urban?= <JuergenUrban@gmx.de>
Subject: Re: [RFC] MIPS: PS2: Interrupt request (IRQ) support
In-Reply-To: <20180318104521.GB2364@localhost.localdomain>
Message-ID: <alpine.DEB.2.21.1803192009500.1520@nanos.tec.linutronix.de>
References: <20170927172107.GB2631@localhost.localdomain> <alpine.DEB.2.00.1709272208300.16752@tp.orcam.me.uk> <20170930065654.GA7714@localhost.localdomain> <alpine.DEB.2.00.1709301305400.12020@tp.orcam.me.uk> <20171029172016.GA2600@localhost.localdomain>
 <alpine.DEB.2.00.1711102209440.10088@tp.orcam.me.uk> <20171111160422.GA2332@localhost.localdomain> <20180129202715.GA4817@localhost.localdomain> <alpine.DEB.2.00.1801312259410.4191@tp.orcam.me.uk> <20180303122657.GC24991@localhost.localdomain>
 <20180318104521.GB2364@localhost.localdomain>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63064
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
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

On Sun, 18 Mar 2018, Fredrik Noring wrote:

> Hi Maciej and Thomas,
> 
> Thomas: Please have a look at the first questions below, regarding
> irq_data->mask and irq_chip->irq_calc_mask. Are they supposed to be usable?
> 
> > +static volatile unsigned long intc_mask = 0;	/* FIXME: Why volatile? */
> > +
> > +static inline void intc_enable_irq(struct irq_data *data)
> > +{
> > +	if (!(intc_mask & (1 << data->irq))) {
> > +		intc_mask |= (1 << data->irq);
> > +		outl(1 << data->irq, INTC_MASK);
> > +	}
> > +}
> 
> The intc_mask variable can be removed, since INTC_MASK is readable, although
> perhaps there are performance reasons to not read the register directly?
> 
> I also noticed that struct irq_data contains a mask field, which allows
> simplifications to
> 
> static inline void intc_enable_irq(struct irq_data *data)
> {
> 	if (!(inl(INTC_MASK) & data->mask))
> 		outl(data->mask, INTC_MASK);

That's a pointless exercise. The core code already knows whether an
interrupt is masked or not and makes the calls conditionally.

> }
> 
> provided the following patch is applied to kernel/irq/irqdesc.c:
> 
> diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
> --- a/kernel/irq/irqdesc.c
> +++ b/kernel/irq/irqdesc.c
> @@ -109,6 +109,7 @@ static void desc_set_defaults(unsigned int irq, struct irq_desc *desc, int node,
>  	desc->irq_common_data.msi_desc = NULL;
>  
>  	desc->irq_data.common = &desc->irq_common_data;
> +	desc->irq_data.mask = 1 << irq; /* FIXME: What about irq_calc_mask? */
> 
> Perhaps the mask field ought to be assigned "1 << irq_data->hwirq" instead,
> unless irq_calc_mask is provided. The mask documentation is not entirely
> clear on the use and any restrictions, and it does not seem to be used all
> that much.

Neither works. @irq is the virtual Linux interrupt number and there is no
guarantee that it maps 1:1 to a hardware irq number. Also this falls apart
when @irq >= 32 because the mask field is 32bit....

> The mask field and irq_calc_mask were introduced by Thomas Gleixner in
> commits 966dc736b819 "genirq: Generic chip: Cache per irq bit mask" and
> d0051816e619 "genirq: irqchip: Add a mask calculation function" in 2013.

Yes, The generic irq chip uses this. I havent seen the full irqchip patch
so I can't tell whether this driver could/should use the generic chip.

Thanks,

	tglx
