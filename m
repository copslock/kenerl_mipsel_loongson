Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 May 2004 18:21:01 +0100 (BST)
Received: from mail.convergence.de ([IPv6:::ffff:212.84.236.4]:10967 "EHLO
	mail.convergence.de") by linux-mips.org with ESMTP
	id <S8225319AbUEPRVA>; Sun, 16 May 2004 18:21:00 +0100
Received: from pd9e7244d.dip.t-dialin.net ([217.231.36.77] helo=abc.local)
	by mail.convergence.de with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34)
	id 1BPPHO-0005RF-UT; Sun, 16 May 2004 19:18:29 +0200
Received: from js by abc.local with local (Exim 3.35 #1 (Debian))
	id 1BPPKZ-0002ZC-00; Sun, 16 May 2004 19:21:43 +0200
Date: Sun, 16 May 2004 19:21:43 +0200
From: Johannes Stezenbach <js@convergence.de>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Kieran Fulke <kieran@pawsoff.org>, linux-mips@linux-mips.org
Subject: Re: IRQ problem on cobalt / 2.6.6
Message-ID: <20040516172143.GA9753@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Kieran Fulke <kieran@pawsoff.org>, linux-mips@linux-mips.org
References: <20040513183059.GA25743@getyour.pawsoff.org> <40A478B0.3070005@bitbox.co.uk> <20040516113622.GA14049@getyour.pawsoff.org> <20040516152113.GA9390@convergence.de> <20040516170445.GA4793@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040516170445.GA4793@linux-mips.org>
User-Agent: Mutt/1.5.6i
Return-Path: <js@convergence.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5033
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: js@convergence.de
Precedence: bulk
X-list: linux-mips

On Sun, May 16, 2004 at 07:04:45PM +0200, Ralf Baechle wrote:
> On Sun, May 16, 2004 at 05:21:13PM +0200, Johannes Stezenbach wrote:
> 
> > In essence, I believe something other than the saa7146 must be asserting
> > irq 23.  Or is it possible that a bug in the PCI init stuff in
> > saa7146_core.c can
> > cause this? Any hints how we could debug this would be welcome.
> 
> arch/mips/cobalt/irq.c:cobalt_irq() looks pretty suspect.  It connects
> CAUSEF_IP7 and interrupt 23 - but the CPU's builtin count / compare
> interrupt already uses this bit.
> 
> Sharing the timer interrupt with something else isn't impossible but seems
> a less than bright thing to do.  Somebody with production hw to test
> should compare this interrupt dispatch function with old working code
> from 2.2 or 2.4 ...

Sorry if I snipped too much from Kieran's mail. He reported
a tulip network card works in the same PCI slot, and it uses
irq 23, too.

But this one from Kieran's mail looks dubious:

> > cat /proc/interrupts
> >            CPU0
> >   2:          0          XT-PIC  cascade
> >  14:      27636          XT-PIC  ide0
> >  18:     435142            MIPS  timer
> >  19:        696            MIPS  eth0
> >  20:          7            MIPS  eth2
> >  21:        302            MIPS  serial
> >  22:          0            MIPS  cascade
> >  23:     100002            MIPS  eth1

100002 is just where note_interrupt() disables an unhandled irq, so
maybe Kieran's report that the tulip card works was wrong?


Johannes
