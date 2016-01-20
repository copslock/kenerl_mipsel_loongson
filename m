Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jan 2016 20:46:43 +0100 (CET)
Received: from smtp6-g21.free.fr ([212.27.42.6]:12206 "EHLO smtp6-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010675AbcATTqg1rfdt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 20 Jan 2016 20:46:36 +0100
Received: from tock (unknown [78.54.185.83])
        (Authenticated sender: albeu)
        by smtp6-g21.free.fr (Postfix) with ESMTPSA id BFF40822A8;
        Wed, 20 Jan 2016 20:45:06 +0100 (CET)
Date:   Wed, 20 Jan 2016 20:46:20 +0100
From:   Alban <albeu@free.fr>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Aban Bedel <albeu@free.fr>, <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Alexander Couzens <lynxis@fe80.eu>,
        Joel Porquet <joel@porquet.org>,
        "Andrew Bresticker" <abrestic@chromium.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/6] MIPS: ath79: irq: Move the CPU IRQ driver to
 drivers/irqchip
Message-ID: <20160120204620.714636eb@tock>
In-Reply-To: <20160120124948.6917859f@sofa.wild-wind.fr.eu.org>
References: <1447788896-15553-1-git-send-email-albeu@free.fr>
        <1447788896-15553-7-git-send-email-albeu@free.fr>
        <20160120124948.6917859f@sofa.wild-wind.fr.eu.org>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51260
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

On Wed, 20 Jan 2016 12:49:48 +0000
Marc Zyngier <marc.zyngier@arm.com> wrote:

> On Tue, 17 Nov 2015 20:34:56 +0100
> Alban Bedel <albeu@free.fr> wrote:
> 
> > Signed-off-by: Alban Bedel <albeu@free.fr>
> > ---
> >  arch/mips/ath79/irq.c                    | 81
> > ++------------------------ arch/mips/include/asm/mach-ath79/ath79.h
> > |  1 + drivers/irqchip/Makefile                 |  1 +
> >  drivers/irqchip/irq-ath79-cpu.c          | 97
> > ++++++++++++++++++++++++++++++++ 4 files changed, 105
> > insertions(+), 75 deletions(-) create mode 100644
> > drivers/irqchip/irq-ath79-cpu.c
> >
 
 [...]

> > +asmlinkage void plat_irq_dispatch(void)
> > +{
> > +	unsigned long pending;
> > +	int irq;
> > +
> > +	pending = read_c0_status() & read_c0_cause() & ST0_IM;
> > +
> > +	if (!pending) {
> > +		spurious_interrupt();
> > +		return;
> > +	}
> > +
> > +	pending >>= CAUSEB_IP;
> > +	while (pending) {
> > +		irq = fls(pending) - 1;
> > +		if (irq < ARRAY_SIZE(irq_wb_chan) && irq_wb_chan[irq] != -1)
> > +			ath79_ddr_wb_flush(irq_wb_chan[irq]);
> > +		do_IRQ(MIPS_CPU_IRQ_BASE + irq);
> 
> I'm rather unfamiliar with the MIPS IRQ handling, but I'm vaguely
> surprised by the lack of domain. How do you unsure that the IRQ space
> used here doesn't clash with the one created in your "misc" irqchip?

This driver extend the irq-mips-cpu driver which take care of setting up
a legacy domain starting from MIPS_CPU_IRQ_BASE for these interrupts. I
don't find this very nice either, but this patch is about moving the
code out of arch/mips, so I tried to minimize unrelated changes.

Alban
