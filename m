Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2014 13:30:16 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:44653 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012281AbaJ3MaPaHiKs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Oct 2014 13:30:15 +0100
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1Xjord-00038v-St; Thu, 30 Oct 2014 13:30:06 +0100
Date:   Thu, 30 Oct 2014 13:30:04 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Arnd Bergmann <arnd@arndb.de>
cc:     Kevin Cernekee <cernekee@gmail.com>, f.fainelli@gmail.com,
        jason@lakedaemon.net, ralf@linux-mips.org, lethal@linux-sh.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org
Subject: Re: [PATCH V2 05/15] genirq: Generic chip: Add big endian I/O
 accessors
In-Reply-To: <14243833.KJsSScVrGS@wuerfel>
Message-ID: <alpine.DEB.2.11.1410301233500.5308@nanos>
References: <1414635488-14137-1-git-send-email-cernekee@gmail.com> <1414635488-14137-6-git-send-email-cernekee@gmail.com> <14243833.KJsSScVrGS@wuerfel>
User-Agent: Alpine 2.11 (DEB 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43780
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

On Thu, 30 Oct 2014, Arnd Bergmann wrote:
> On Wednesday 29 October 2014 19:17:58 Kevin Cernekee wrote:
> >  static LIST_HEAD(gc_list);
> >  static DEFINE_RAW_SPINLOCK(gc_lock);
> >  
> > +static int is_big_endian(struct irq_chip_generic *gc)
> > +{
> > +       return !!(gc->domain->gc->gc_flags & IRQ_GC_BE_IO);
> > +}
> > +
> >  static void irq_reg_writel(struct irq_chip_generic *gc,
> >                            u32 val, int reg_offset)
> >  {
> > -       writel(val, gc->reg_base + reg_offset);
> > +       if (is_big_endian(gc))
> > +               iowrite32be(val, gc->reg_base + reg_offset);
> > +       else
> > +               writel(val, gc->reg_base + reg_offset);
> >  }
> >  
> 
> What I had in mind was to use indirect function calls instead, like
> 
> #ifndef irq_reg_writel
> static inline void irq_reg_writel_le(u32 val, void __iomem *addr)
> {
> 	return writel(val, addr);
> }
> #endif
> 
> #ifndef irq_reg_writel_be
> static inline void irq_reg_writel_be(u32 val, void __iomem *addr)
> {
> 	return iowrite32_be(val, addr);
> }
> #endif
> 
> 
> static inline void irq_reg_writel(struct irq_chip_generic *gc, u32 val, int reg_offset)
> {
>        if (IS_ENABLED(CONFIG_GENERIC_IRQ_CHIP) &&

That's inside of the generic irq chip, so CONFIG_GENERIC_IRQ_CHIP is
always set when this is compiled.

>            !IS_ENABLED(CONFIG_GENERIC_IRQ_CHIP_BE))
> 		return irq_reg_writel_le(val, gc->reg_base + reg_offset);
> 
>        if (IS_ENABLED(CONFIG_GENERIC_IRQ_CHIP) &&
>            !IS_ENABLED(CONFIG_GENERIC_IRQ_CHIP_BE))

	     s/!// ?

> 		return irq_reg_writel_be(val, gc->reg_base + reg_offset);

I don't think the above will cover all combinations.

..._CHIP_BE	...CHIP_LE
N		N			; Default behaviour: readl/writel
Y		N			; ioread/write32be
N		Y			; Default behaviour: readl/writel
Y		Y			; Runtime selected

> 	return gc->writel(val, gc->reg_base + reg_offset);
> }
> 
> This would take the condition out of the callers.

So you trade a conditional for an indirect call. Not sure what's more
expensive. The indirect call is definitely a smaller text footprint,
so we should opt for this.

Thanks,

	tglx
