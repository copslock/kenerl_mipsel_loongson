Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2014 08:46:13 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.17.10]:56933 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011823AbaJ2HqLV10z1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2014 08:46:11 +0100
Received: from wuerfel.localnet (HSI-KBW-134-3-133-35.hsi14.kabel-badenwuerttemberg.de [134.3.133.35])
        by mrelayeu.kundenserver.de (node=mreue103) with ESMTP (Nemesis)
        id 0LhTpQ-1YMrYf0iX2-00ma7g; Wed, 29 Oct 2014 08:46:01 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     f.fainelli@gmail.com, tglx@linutronix.de, jason@lakedaemon.net,
        ralf@linux-mips.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mbizon@freebox.fr, jogo@openwrt.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 05/11] irqchip: bcm7120-l2: Make sure all register accesses use base+offset
Date:   Wed, 29 Oct 2014 08:46 +0100
Message-ID: <12783106.5y3em8Tzu2@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <1414555138-6500-5-git-send-email-cernekee@gmail.com>
References: <1414555138-6500-1-git-send-email-cernekee@gmail.com> <1414555138-6500-5-git-send-email-cernekee@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V02:K0:iJmATDtC+RZYzaMnjS9D9GNQdihMM/Qqu4SWe78VahR
 m+q/m288dkX5ptTOrLe2B1i/agrqAgRGBcb3unA0EfRhHb9CDD
 YDFnkR6HGCziFBzTAmC09bPvst56e/hPMY8KFQTrRYNF+s5sHU
 LDrZ6Fh2OK/Rs66+fwnPHwh7ih0M0aJBkwEkSy5uIY9ScvCo/B
 0VqXBChIeRUkraWAXwJiUL6s5XToLFPKgv15PNzXJRD8sKf/6w
 WAW1QboijI1x6wrcJ7vGtz/IHT5gU/BRjNeJ8iOCSQSUJsGIdX
 iwSQO2ELsz84uJHw3Fjzsq7Xkok9LShwV2tdwwUJA4YpEGXSob
 alhI7jwhZvylXyZwq+g8=
X-UI-Out-Filterresults: notjunk:1;
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43686
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

On Tuesday 28 October 2014 20:58:52 Kevin Cernekee wrote:
> 
>         irq_gc_lock(gc);
>         /* Save the current mask and the interrupt forward mask */
> -       b->saved_mask = __raw_readl(b->base) | b->irq_fwd_mask;
> +       b->saved_mask = __raw_readl(b->base + IRQEN) | b->irq_fwd_mask;
>         if (b->can_wake) {
>                 reg = b->saved_mask | gc->wake_active;
> -               __raw_writel(reg, b->base);
> +               __raw_writel(reg, b->base + IRQEN);
>         }
>         irq_gc_unlock(gc);
>  }
> @@ -81,7 +81,7 @@ static void bcm7120_l2_intc_resume(struct irq_data *d)
>  
>         /* Restore the saved mask */
>         irq_gc_lock(gc);
> -       __raw_writel(b->saved_mask, b->base);
> +       __raw_writel(b->saved_mask, b->base + IRQEN);
>         irq_gc_unlock(gc);
> 

You should really change this one too, to use fixed-endian accessors.
__raw_writel can't safely be used in drivers, and it will break
big-endian kernels running on ARM BRCMSTB.

	Arnd
