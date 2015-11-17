Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Nov 2015 19:41:19 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:34214 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006617AbbKRSlRtp0t- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Nov 2015 19:41:17 +0100
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ZymXH-0005DK-Va; Tue, 17 Nov 2015 21:07:28 +0100
Date:   Tue, 17 Nov 2015 21:06:47 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jason Cooper <jason@lakedaemon.net>
cc:     Alban Bedel <albeu@free.fr>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Alexander Couzens <lynxis@fe80.eu>,
        Joel Porquet <joel@porquet.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] MIPS: ath79: irq: Move the MISC driver to
 drivers/irqchip
In-Reply-To: <20151117200327.GA6520@io.lakedaemon.net>
Message-ID: <alpine.DEB.2.11.1511172106120.3761@nanos>
References: <1447788896-15553-1-git-send-email-albeu@free.fr> <1447788896-15553-5-git-send-email-albeu@free.fr> <20151117200327.GA6520@io.lakedaemon.net>
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
X-archive-position: 49983
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

On Tue, 17 Nov 2015, Jason Cooper wrote:
> Hi Alban,
> 
> On Tue, Nov 17, 2015 at 08:34:54PM +0100, Alban Bedel wrote:
> > The driver stays the same but the initialization changes a bit.
> > For OF boards we now get the memory map from the OF node and use
> > a linear mapping instead of the legacy mapping. For legacy boards
> > we still use a legacy mapping and just pass down all the parameters
> > from the board init code.
> > 
> > Signed-off-by: Alban Bedel <albeu@free.fr>
> > ---
> >  arch/mips/ath79/irq.c                    | 163 +++------------------------
> >  arch/mips/include/asm/mach-ath79/ath79.h |   3 +
> >  drivers/irqchip/Makefile                 |   1 +
> >  drivers/irqchip/irq-ath79-misc.c         | 182 +++++++++++++++++++++++++++++++
> >  4 files changed, 201 insertions(+), 148 deletions(-)
> >  create mode 100644 drivers/irqchip/irq-ath79-misc.c
> ...
> > diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> > index 177f78f..a8f9075 100644
> > --- a/drivers/irqchip/Makefile
> > +++ b/drivers/irqchip/Makefile
> > @@ -1,5 +1,6 @@
> >  obj-$(CONFIG_IRQCHIP)			+= irqchip.o
> >  
> > +obj-$(CONFIG_ATH79)			+= irq-ath79-misc.o
> >  obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2835.o
> >  obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2836.o
> >  obj-$(CONFIG_ARCH_EXYNOS)		+= exynos-combiner.o
> 
> CONFIG_ARCH_ATH79 ?

Nope.

arch/mips/Kconfig:config ATH79
