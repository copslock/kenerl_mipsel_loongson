Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Feb 2003 00:35:07 +0000 (GMT)
Received: from rj.SGI.COM ([IPv6:::ffff:192.82.208.96]:18879 "EHLO rj.sgi.com")
	by linux-mips.org with ESMTP id <S8225261AbTBFAfG>;
	Thu, 6 Feb 2003 00:35:06 +0000
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130])
	by rj.sgi.com (8.12.2/8.12.2/linux-outbound_gateway-1.2) with SMTP id h15MZ8G8013447;
	Wed, 5 Feb 2003 14:35:09 -0800
Received: from pureza.melbourne.sgi.com (pureza.melbourne.sgi.com [134.14.55.244]) by larry.melbourne.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id LAA11378; Thu, 6 Feb 2003 11:34:55 +1100
Received: from pureza.melbourne.sgi.com (localhost.localdomain [127.0.0.1])
	by pureza.melbourne.sgi.com (8.12.5/8.12.5) with ESMTP id h160Ys8G001289;
	Thu, 6 Feb 2003 11:34:55 +1100
Received: (from clausen@localhost)
	by pureza.melbourne.sgi.com (8.12.5/8.12.5/Submit) id h160YqpK001287;
	Thu, 6 Feb 2003 11:34:52 +1100
Date: Thu, 6 Feb 2003 11:34:52 +1100
From: Andrew Clausen <clausen@melbourne.sgi.com>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Tibor Polgar <tpolgar@freehandsystems.com>,
	Jason Ormes <jormes@wideopenwest.com>,
	linux-mips@linux-mips.org
Subject: Re: kernel boot error.
Message-ID: <20030206003452.GA1278@pureza.melbourne.sgi.com>
References: <200302041841.10507.jormes@wideopenwest.com> <20030205004345.GI27302@pureza.melbourne.sgi.com> <3E406ABC.A9D0D6F@freehandsystems.com> <20030205030625.GM27302@pureza.melbourne.sgi.com> <20030205150339.A13033@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030205150339.A13033@linux-mips.org>
User-Agent: Mutt/1.4i
Return-Path: <clausen@pureza.melbourne.sgi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1345
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clausen@melbourne.sgi.com
Precedence: bulk
X-list: linux-mips

On Wed, Feb 05, 2003 at 03:03:40PM +0100, Ralf Baechle wrote:
> > Just, the base address the card (PCI bus?) is spitting out is very odd:
> > 
> > 	eth0: SGI AceNIC Gigabit Ethernet at 0xfe7fc000, irq 8
> > 
> > The card is in slot 6, so I'd expect the base address to be 0x8900000.
> > Anyway, it dies on this:
> 
> Query the address using the usual Linux PCI bus stuff from <linux/pci.h>.
> Anything else is doomed, especially guessing ...

That stuff is returning 0xfe7fc000.  That is sane for an Intel
configuration, but totally insane for Origins, and has no chance
of working.

Cheers,
Andrew
