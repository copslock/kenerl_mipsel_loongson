Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Jul 2015 23:58:18 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:36391 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010761AbbGUV6RK50E1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Jul 2015 23:58:17 +0200
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ZHfYD-0007up-44; Tue, 21 Jul 2015 23:58:13 +0200
Date:   Tue, 21 Jul 2015 23:58:01 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Florian Fainelli <fainelli@broadcom.com>
cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Kevin Cernekee <cernekee@gmail.com>,
        Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH 1/2] genirq: add chip_{suspend,resume} PM support to
 irq_chip
In-Reply-To: <55AEB91C.1020202@broadcom.com>
Message-ID: <alpine.DEB.2.11.1507212343270.18576@nanos>
References: <20150619224123.GL4917@ld-irv-0074> <1434756403-379-1-git-send-email-computersforpeace@gmail.com> <alpine.DEB.2.11.1506201605290.4107@nanos> <55AE8E5D.8020700@gmail.com> <alpine.DEB.2.11.1507212316530.18576@nanos>
 <55AEB91C.1020202@broadcom.com>
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
X-archive-position: 48375
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

On Tue, 21 Jul 2015, Florian Fainelli wrote:
> On 21/07/15 14:23, Thomas Gleixner wrote:
> > I just read back on the problem report which was mentioned in the
> > changelog:
> > 
> > "It's not a problem with patch 7, exactly, it's a problem with the
> >  irqchip driver which handles the UART interrupt mask (irq-bcm7120-l2.c).
> >  The problem is that with a trimmed down device tree (such as the one
> >  found at arch/arm/boot/dts/bcm7445-bcm97445svmb.dtb), none of the child
> >  interrupts of the 'irq0_intc' node are described -- we don't have device
> >  tree nodes for them yet -- but we still require saving and restoring the
> >  forwarding mask (see 'brcm,int-fwd-mask') in order for the UART
> >  interrupts to continue operating."
> > 
> > So you are trying to work around a flaw in the device tree by adding
> > random callbacks to the core kernel?
> 
> Not quite, you could have your interrupt controller node declared in
> Device Tree, but have no "interrupts" property referencing it because:
> 
> - the hardware is just not there, but you inherit a common Device Tree
> skleten (*.dtsi)
> - you could have Device Tree overlays which may or may not be loaded as
> a result of finding expansion boards etc...

So if no hardware is there which uses any of those interrupts, then
WHY is it a problem at all?

If it's a requirement that these registers must be restored (once, not
per irq), then I can see that it'd be nice to do that from the core.

Though that core suspend/resume function is generic chip specific. So
it does not make any sense to force it into struct irq_chip because we
have no core infrastructure to deal with it.

Thanks,

	tglx
