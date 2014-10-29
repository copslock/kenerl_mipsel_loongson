Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2014 08:57:25 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.17.24]:60887 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011870AbaJ2H5YIPuwG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2014 08:57:24 +0100
Received: from wuerfel.localnet (HSI-KBW-134-3-133-35.hsi14.kabel-badenwuerttemberg.de [134.3.133.35])
        by mrelayeu.kundenserver.de (node=mreue103) with ESMTP (Nemesis)
        id 0Ltm1V-1YB7YZ03r3-011ErV; Wed, 29 Oct 2014 08:56:54 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     f.fainelli@gmail.com, tglx@linutronix.de, jason@lakedaemon.net,
        ralf@linux-mips.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mbizon@freebox.fr, jogo@openwrt.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 05/11] irqchip: bcm7120-l2: Make sure all register accesses use base+offset
Date:   Wed, 29 Oct 2014 08:56:53 +0100
Message-ID: <7342931.OfYK3ZveFa@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <12783106.5y3em8Tzu2@wuerfel>
References: <1414555138-6500-1-git-send-email-cernekee@gmail.com> <1414555138-6500-5-git-send-email-cernekee@gmail.com> <12783106.5y3em8Tzu2@wuerfel>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V02:K0:KTiWV1Vkr4fPFmZ4ckFXE3onk3r3DbM3LrS7mU7awOF
 FugUk8J0JFrpr0yDpkty2hJ+Tfnma5vMTHMXQsM9zsG6Sq5/gN
 r/jS9jqDRXWWfTQayr20phTMEeM68zQ3SzX3LVgL4NeDrCIria
 g/EdOupEwz93zn2/+Z5jl4kyhMj4MG4jrYUkcLgafVv8ri1G4M
 xgCq3gnrLCPKvZDuJ0u8pHMNCpQGDKy8pFRhJGyFV9MTULu2v0
 jGlzbGdqnpND5lwoXv7ERY8UygeYN0r8VbGbwAGxtHynfOmZWh
 d6gpYxvn3iudUizSzM6HYdLnpBSH6jdlhq0xqkYD4sF7JLBxMr
 rdVToDzb7FM/J5719GRk=
X-UI-Out-Filterresults: notjunk:1;
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43692
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

On Wednesday 29 October 2014 08:46:00 Arnd Bergmann wrote:
> On Tuesday 28 October 2014 20:58:52 Kevin Cernekee wrote:
> > 
> >         irq_gc_lock(gc);
> >         /* Save the current mask and the interrupt forward mask */
> > -       b->saved_mask = __raw_readl(b->base) | b->irq_fwd_mask;
> > +       b->saved_mask = __raw_readl(b->base + IRQEN) | b->irq_fwd_mask;
> >         if (b->can_wake) {
> >                 reg = b->saved_mask | gc->wake_active;
> > -               __raw_writel(reg, b->base);
> > +               __raw_writel(reg, b->base + IRQEN);
> >         }
> >         irq_gc_unlock(gc);
> >  }
> > @@ -81,7 +81,7 @@ static void bcm7120_l2_intc_resume(struct irq_data *d)
> >  
> >         /* Restore the saved mask */
> >         irq_gc_lock(gc);
> > -       __raw_writel(b->saved_mask, b->base);
> > +       __raw_writel(b->saved_mask, b->base + IRQEN);
> >         irq_gc_unlock(gc);
> > 
> 
> You should really change this one too, to use fixed-endian accessors.
> __raw_writel can't safely be used in drivers, and it will break
> big-endian kernels running on ARM BRCMSTB.

As you already fix this in patch 6, please disregard my comment above,
your patch looks ok.

Acked-by: Arnd Bergmann <arnd@arndb.de>
