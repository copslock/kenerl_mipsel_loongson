Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Feb 2003 03:07:02 +0000 (GMT)
Received: from rj.SGI.COM ([IPv6:::ffff:192.82.208.96]:31364 "EHLO rj.sgi.com")
	by linux-mips.org with ESMTP id <S8225240AbTBEDHB>;
	Wed, 5 Feb 2003 03:07:01 +0000
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130])
	by rj.sgi.com (8.12.2/8.12.2/linux-outbound_gateway-1.2) with SMTP id h15175G8011675;
	Tue, 4 Feb 2003 17:07:05 -0800
Received: from pureza.melbourne.sgi.com (pureza.melbourne.sgi.com [134.14.55.244]) by larry.melbourne.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id OAA29989; Wed, 5 Feb 2003 14:06:53 +1100
Received: from pureza.melbourne.sgi.com (localhost.localdomain [127.0.0.1])
	by pureza.melbourne.sgi.com (8.12.5/8.12.5) with ESMTP id h1536QMd029181;
	Wed, 5 Feb 2003 14:06:27 +1100
Received: (from clausen@localhost)
	by pureza.melbourne.sgi.com (8.12.5/8.12.5/Submit) id h1536PAh029179;
	Wed, 5 Feb 2003 14:06:25 +1100
Date: Wed, 5 Feb 2003 14:06:25 +1100
From: Andrew Clausen <clausen@melbourne.sgi.com>
To: Tibor Polgar <tpolgar@freehandsystems.com>
Cc: Jason Ormes <jormes@wideopenwest.com>, linux-mips@linux-mips.org
Subject: Re: kernel boot error.
Message-ID: <20030205030625.GM27302@pureza.melbourne.sgi.com>
References: <200302041841.10507.jormes@wideopenwest.com> <20030205004345.GI27302@pureza.melbourne.sgi.com> <3E406ABC.A9D0D6F@freehandsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E406ABC.A9D0D6F@freehandsystems.com>
User-Agent: Mutt/1.4i
Return-Path: <clausen@pureza.melbourne.sgi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1327
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clausen@melbourne.sgi.com
Precedence: bulk
X-list: linux-mips

On Tue, Feb 04, 2003 at 05:37:00PM -0800, Tibor Polgar wrote:
> > I'm getting exactly the same problem.  What machine are you using?
> > I'm using an ip27 (origin 200), and an acenic network card.
> > 
> > It seems that there all kinds of PCI hacks in the ip27 support,
> > and I'm currently trying to figure out how to get this card working...
> 
> My buddy and I used to work at Alteon with my buddy doing most of the original
> NIC firmware coding.  I don't remember who did the SGI driver side coding.  
> The linux driver was done by Jes Sorensen using our OpenDriver kit. Let me
> know if we can help in any way.   Is the Origin an SGI machine?

Yep.  It's sitting in an SGI machine room.

>   If so, i do
> recall we had to do some special casing to get the card to work correctly. 

Yeah, that would be right.  Have you had a look at pci_fixup_ioc3()?
(That's the network card that seems to come with the Origin 200).  I
bet it's something similar.

Just, the base address the card (PCI bus?) is spitting out is very odd:

	eth0: SGI AceNIC Gigabit Ethernet at 0xfe7fc000, irq 8

The card is in slot 6, so I'd expect the base address to be 0x8900000.
Anyway, it dies on this:

	writel(HW_RESET | (HW_RESET << 24), &regs->HostCtrl);

	with:
		&regs->HostCtrl=9200000008900040
	or
		&regs->HostCtrl=92000000fe7fc040
	(depending on the base address... I hard coded in a more
	sane one, but it still crashes)

Cheers,
Andrew
