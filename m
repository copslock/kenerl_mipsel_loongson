Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2014 11:33:39 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:43780 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011905AbaJ3KdhM0BbI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Oct 2014 11:33:37 +0100
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1Xjn2j-0001g1-0G; Thu, 30 Oct 2014 11:33:25 +0100
Date:   Thu, 30 Oct 2014 11:33:23 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Arnd Bergmann <arnd@arndb.de>
cc:     Kevin Cernekee <cernekee@gmail.com>, f.fainelli@gmail.com,
        jason@lakedaemon.net, ralf@linux-mips.org, lethal@linux-sh.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org
Subject: Re: [PATCH V2 03/15] genirq: Generic chip: Move irq_reg_{readl,writel}
 accessors into generic-chip.c
In-Reply-To: <6552163.gt4ABVyYlA@wuerfel>
Message-ID: <alpine.DEB.2.11.1410301103300.5308@nanos>
References: <1414635488-14137-1-git-send-email-cernekee@gmail.com> <1414635488-14137-4-git-send-email-cernekee@gmail.com> <alpine.DEB.2.11.1410300941290.5308@nanos> <6552163.gt4ABVyYlA@wuerfel>
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
X-archive-position: 43769
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
> On Thursday 30 October 2014 09:43:02 Thomas Gleixner wrote:
> > > diff --git a/include/linux/irq.h b/include/linux/irq.h
> > > index 03f48d9..8049e93 100644
> > > --- a/include/linux/irq.h
> > > +++ b/include/linux/irq.h
> > > @@ -639,13 +639,6 @@ void arch_teardown_hwirq(unsigned int irq);
> > >  void irq_init_desc(unsigned int irq);
> > >  #endif
> > >  
> > > -#ifndef irq_reg_writel
> > > -# define irq_reg_writel(val, addr)   writel(val, addr)
> > > -#endif
> > > -#ifndef irq_reg_readl
> > > -# define irq_reg_readl(addr)         readl(addr)
> > > -#endif
> > > -
> > 
> > Brilliant patch that.
> > 
> > # git grep -l irq_reg_readl drivers/irqchip/
> > drivers/irqchip/irq-atmel-aic.c
> > drivers/irqchip/irq-atmel-aic5.c
> > drivers/irqchip/irq-sunxi-nmi.c
> > drivers/irqchip/irq-tb10x.c
> 
> Patch 1/15 changes these all. I think it's still broken because patch 2/15
> is wrong, but it's not /that/ obviously broken.

Oops. Missed that.
