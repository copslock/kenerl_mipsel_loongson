Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 May 2004 16:20:46 +0100 (BST)
Received: from mail.convergence.de ([IPv6:::ffff:212.84.236.4]:53459 "EHLO
	mail.convergence.de") by linux-mips.org with ESMTP
	id <S8225280AbUEPPUp>; Sun, 16 May 2004 16:20:45 +0100
Received: from pd9e7244d.dip.t-dialin.net ([217.231.36.77] helo=abc.local)
	by mail.convergence.de with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34)
	id 1BPNOx-0001Xm-7j; Sun, 16 May 2004 17:18:12 +0200
Received: from js by abc.local with local (Exim 3.35 #1 (Debian))
	id 1BPNRx-0002Vs-00; Sun, 16 May 2004 17:21:13 +0200
Date: Sun, 16 May 2004 17:21:13 +0200
From: Johannes Stezenbach <js@convergence.de>
To: Kieran Fulke <kieran@pawsoff.org>
Cc: linux-mips@linux-mips.org
Subject: Re: IRQ problem on cobalt / 2.6.6
Message-ID: <20040516152113.GA9390@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	Kieran Fulke <kieran@pawsoff.org>, linux-mips@linux-mips.org
References: <20040513183059.GA25743@getyour.pawsoff.org> <40A478B0.3070005@bitbox.co.uk> <20040516113622.GA14049@getyour.pawsoff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040516113622.GA14049@getyour.pawsoff.org>
User-Agent: Mutt/1.5.6i
Return-Path: <js@convergence.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5030
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: js@convergence.de
Precedence: bulk
X-list: linux-mips

On Sun, May 16, 2004 at 12:36:22PM +0100, Kieran Fulke wrote:
> On Fri, May 14, 2004 at 08:43:44AM +0100, Peter Horton wrote:
> 
> > Have you tried any other hardware in the slot, PCI network card perhaps ?
> > 
> > P.
> 
> yeah. adding cards like a tulip network card, linksys wmp11 wireless card. even a 
> wintv pci (analogue) card all work ;
...
> it just seems to be the DVB card that the pci code doesnt like, for some reason ..
> 
> all ideas warmly received ;)

Let me add some information from your posts to linux-dvb and from
the driver source.

I would appreciate it if someone could look it over (full source
is in linux/drivers/media/common/saa7146_core.c). The driver is
known to work on a variety of platforms, including one TX49 based
development system (last tested a few months back, though).


From your first posting:

   PCI: Setting latency timer of device 0000:00:0a.0 to 64
   irq 23: nobody cared!
   Call Trace: [snipped]
   handlers:
   [<c004b570>]
   Disabling IRQ #23
   saa7146: found saa7146 @ mem b2080800 (revision 1, irq 23) (0x13c2,0x1011).

Second try with debug enabled:

   saa7146: saa7146_register_extension(): ext:c001efb0
   saa7146: register extension 'budget_ci dvb'.
   saa7146: saa7146_init_one(): pci:83fdac00
   irq 23: nobody cared!


saa7146_init_one() does the following:
        /* disable all irqs */
	saa7146_write(dev, IER, 0);
	...
        if (request_irq(dev->pci->irq, interrupt_hw, SA_SHIRQ | SA_INTERRUPT,
                        dev->name, dev))
        {error...}
        ...
        INFO(("found saa7146 @ mem %p (revision %d, irq %d) (0x%04x,0x%04x).\n", ...));

interrupt_hw() does:
        /* read out the interrupt status register */
        isr = saa7146_read(dev, ISR);

        /* is this our interrupt? */
        if ( 0 == isr ) {
                /* nope, some other device */
                return IRQ_NONE;
        }
        ...
        return IRQ_HANDLED;


In essence, I believe something other than the saa7146 must be asserting irq 23.
Or is it possible that a bug in the PCI init stuff in saa7146_core.c can
cause this? Any hints how we could debug this would be welcome.


Johannes
