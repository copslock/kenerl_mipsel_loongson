Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2014 20:10:14 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:39909 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011693AbaJ2TKNUvM2Q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2014 20:10:13 +0100
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1XjYdF-0003UW-0M; Wed, 29 Oct 2014 20:10:09 +0100
Date:   Wed, 29 Oct 2014 20:10:07 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Kevin Cernekee <cernekee@gmail.com>
cc:     Arnd Bergmann <arnd@arndb.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Jonas Gorski <jogo@openwrt.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: [PATCH 01/11] irqchip: Allow irq_reg_{readl,writel} to use
 __raw_{readl_writel}
In-Reply-To: <CAJiQ=7BcVH52-PCo40dSEoNHjT1Pg8X88uq-KZ6tQPKYWaM94A@mail.gmail.com>
Message-ID: <alpine.DEB.2.11.1410292007080.5308@nanos>
References: <1414555138-6500-1-git-send-email-cernekee@gmail.com> <11255905.1JsQYcArO7@wuerfel> <CAJiQ=7BcVH52-PCo40dSEoNHjT1Pg8X88uq-KZ6tQPKYWaM94A@mail.gmail.com>
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
X-archive-position: 43720
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

On Wed, 29 Oct 2014, Kevin Cernekee wrote:
> Thomas:
> > How does that work with multi arch kernels?
> 
> I am assuming this question refers to e.g. CONFIG_ARCH_MULTIPLATFORM
> 
> If GENERIC_IRQ_CHIP is being used, the current implementation of
> generic-chip.c will have to pick one global definition of
> irq_reg_{readl,writel} for all supported SoCs.
> 
> One possibility is that individual irqchip drivers requiring special
> accessors can pass in their own function pointers, similar to this:
> 
> struct sdhci_ops {
> #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
> u32 (*read_l)(struct sdhci_host *host, int reg);
> u16 (*read_w)(struct sdhci_host *host, int reg);
> u8 (*read_b)(struct sdhci_host *host, int reg);
> void (*write_l)(struct sdhci_host *host, u32 val, int reg);
> void (*write_w)(struct sdhci_host *host, u16 val, int reg);
> void (*write_b)(struct sdhci_host *host, u8 val, int reg);
> #endif
> 
> and fall back to readl/writel if none are supplied.  It would be nice
> if this provided common definitions for the __raw_ and maybe the BE
> variants too.
> 
> Or, we could add IRQ_GC_NATIVE_IO and/or IRQ_GC_BE_IO to enum irq_gc_flags.

I definitely prefer to have these options in the generic chip
implementation so we avoid that driver writers duplicate code in
creative and wrong ways.

Thanks,

	tglx
