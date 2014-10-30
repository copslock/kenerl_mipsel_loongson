Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2014 13:40:25 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.17.10]:54924 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012281AbaJ3MkXkvHpI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Oct 2014 13:40:23 +0100
Received: from wuerfel.localnet (HSI-KBW-134-3-133-35.hsi14.kabel-badenwuerttemberg.de [134.3.133.35])
        by mrelayeu.kundenserver.de (node=mreue102) with ESMTP (Nemesis)
        id 0MUVwx-1Xamc32J4l-00RKzs; Thu, 30 Oct 2014 13:40:04 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kevin Cernekee <cernekee@gmail.com>, f.fainelli@gmail.com,
        jason@lakedaemon.net, ralf@linux-mips.org, lethal@linux-sh.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org
Subject: Re: [PATCH V2 05/15] genirq: Generic chip: Add big endian I/O accessors
Date:   Thu, 30 Oct 2014 13:40:03 +0100
Message-ID: <2056740.mEUKBXLZZT@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <alpine.DEB.2.11.1410301233500.5308@nanos>
References: <1414635488-14137-1-git-send-email-cernekee@gmail.com> <14243833.KJsSScVrGS@wuerfel> <alpine.DEB.2.11.1410301233500.5308@nanos>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V02:K0:yFkYUm65yngN2K53Vluq1YbA8bE1f+vg0Diq/E+ZOeO
 hlL09aoXpRphfkBNDzhAAT7xpZAdyrmAGyZwUoD7RYix4kBmRv
 +zh3lV9rnji60H5dzvm3GX3kVybx3AaJqXfDSw8x3u1gxixXUb
 Bv9xkec0r/lAzusyBxhrlXdceOc1nxM0k+kVO0yw2E9s134Bz5
 1VHXT7Akztmgy43DVsRVRI+wCUzXIuiKpoDmFEBwtoSMxtRdZx
 3c2LbX96RuKoczRsUaf1FH2puxMuKMp1g04twLyvK9TIufibV1
 l/H2iCZVibJNHjCRGLkFiUJ1D+dMoAqD8/jV5C8V+tQn1nhbAI
 v2oktuLCzXcMlMAV+tUc=
X-UI-Out-Filterresults: notjunk:1;
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43781
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Thursday 30 October 2014 13:30:04 Thomas Gleixner wrote:
> On Thu, 30 Oct 2014, Arnd Bergmann wrote:
> > On Wednesday 29 October 2014 19:17:58 Kevin Cernekee wrote:
> > >  static LIST_HEAD(gc_list);
> > >  static DEFINE_RAW_SPINLOCK(gc_lock);
> > >  
> > > +static int is_big_endian(struct irq_chip_generic *gc)
> > > +{
> > > +       return !!(gc->domain->gc->gc_flags & IRQ_GC_BE_IO);
> > > +}
> > > +
> > >  static void irq_reg_writel(struct irq_chip_generic *gc,
> > >                            u32 val, int reg_offset)
> > >  {
> > > -       writel(val, gc->reg_base + reg_offset);
> > > +       if (is_big_endian(gc))
> > > +               iowrite32be(val, gc->reg_base + reg_offset);
> > > +       else
> > > +               writel(val, gc->reg_base + reg_offset);
> > >  }
> > >  
> > 
> > What I had in mind was to use indirect function calls instead, like
> > 
> > #ifndef irq_reg_writel
> > static inline void irq_reg_writel_le(u32 val, void __iomem *addr)
> > {
> > 	return writel(val, addr);
> > }
> > #endif
> > 
> > #ifndef irq_reg_writel_be
> > static inline void irq_reg_writel_be(u32 val, void __iomem *addr)
> > {
> > 	return iowrite32_be(val, addr);
> > }
> > #endif
> > 
> > 
> > static inline void irq_reg_writel(struct irq_chip_generic *gc, u32 val, int reg_offset)
> > {
> >        if (IS_ENABLED(CONFIG_GENERIC_IRQ_CHIP) &&
> 
> That's inside of the generic irq chip, so CONFIG_GENERIC_IRQ_CHIP is
> always set when this is compiled.

The part that I mentioned in the other mail and omitted here is that
I'd then build the kernel/irq/generic-chip.c file when one or both of
CONFIG_GENERIC_IRQ_CHIP or CONFIG_GENERIC_IRQ_CHIP_BE is set.

The alternative would be to introduce CONFIG_GENERIC_IRQ_CHIP_LE along
with CONFIG_GENERIC_IRQ_CHIP_BE, which might be cleaner, but requires
all existing 39 'select GENERIC_IRQ_CHIP' statements to be changed to
'GENERIC_IRQ_CHIP_LE'.

Either way would work.

> >            !IS_ENABLED(CONFIG_GENERIC_IRQ_CHIP_BE))
> > 		return irq_reg_writel_le(val, gc->reg_base + reg_offset);
> > 
> >        if (IS_ENABLED(CONFIG_GENERIC_IRQ_CHIP) &&
> >            !IS_ENABLED(CONFIG_GENERIC_IRQ_CHIP_BE))
> 
> 	     s/!// ?

typo: I put the ! in the wrong line, sorry.

> > 		return irq_reg_writel_be(val, gc->reg_base + reg_offset);
> 
> I don't think the above will cover all combinations.
> 
> ..._CHIP_BE	...CHIP_LE
> N		N			; Default behaviour: readl/writel

that would not be allowed with my approach. It should probably cause
a compile-error if we introduce all three symbols.

> Y		N			; ioread/write32be
> N		Y			; Default behaviour: readl/writel
> Y		Y			; Runtime selected



> > 	return gc->writel(val, gc->reg_base + reg_offset);
> > }
> > 
> > This would take the condition out of the callers.
> 
> So you trade a conditional for an indirect call. Not sure what's more
> expensive. The indirect call is definitely a smaller text footprint,
> so we should opt for this.

It depends on the register pressure in the caller and on the pipeline
of the CPU. My guess was that indirect call is generally more efficient,
but you are right that this is not obvious, and I have no reliable data
to back up my guess.

If we do the conditional, we could also just add an extra byte swap,
instead of choosing between two function calls.

	Arnd
