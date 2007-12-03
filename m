Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Dec 2007 19:24:56 +0000 (GMT)
Received: from mail.onstor.com ([66.201.51.107]:23200 "EHLO mail.onstor.com")
	by ftp.linux-mips.org with ESMTP id S20030164AbXLCTYr (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 3 Dec 2007 19:24:47 +0000
Received: from onstor-exch02.onstor.net ([66.201.51.106]) by mail.onstor.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 3 Dec 2007 11:24:19 -0800
Received: from ripper.onstor.net ([10.0.0.42]) by onstor-exch02.onstor.net with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 3 Dec 2007 11:24:19 -0800
Date:	Mon, 3 Dec 2007 11:24:18 -0800
From:	Andrew Sharp <andy.sharp@onstor.com>
To:	Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	akpm@linux-foundation.org, wim@iguana.be
Subject: Re: [PATCH] Add support for SB1 hardware watchdog.
Message-ID: <20071203112418.26b94838@ripper.onstor.net>
In-Reply-To: <20071203183419.3213d551@the-village.bc.nu>
References: <20071203181658.GA26631@onstor.com>
	<20071203183419.3213d551@the-village.bc.nu>
Organization: Onstor
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Dec 2007 19:24:19.0003 (UTC) FILETIME=[19B1E8B0:01C835E2]
Return-Path: <andy.sharp@onstor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17678
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andy.sharp@onstor.com
Precedence: bulk
X-list: linux-mips

On Mon, 3 Dec 2007 18:34:19 +0000 Alan Cox <alan@lxorguk.ukuu.org.uk>
wrote:

> > +	  on such processors; this driver supports only the first
> > one,
> > +	  because currently Linux only supports exporting one
> > watchdog
> > +	  to userspace.
> 
> Yep. Perhaps that should change.

I thought about that just a little; I'm just not sure what it would
mean to have multiple watchdog devices.

> > + * wdog is the iomem address of the cfg register
> > + */
> > + void
> > +sbwdog_set(char __iomem *wdog, unsigned long t)
> > +{
> > +	__raw_writeb(0, wdog - 0x10);
> > +	__raw_writeq(t & 0x7fffffUL, wdog);
> > +}
> 
> What guarantees you don't get a pair of these calls at once or
> interleaving ?

Not much, I suppose, except that opening the device file is exclusive.
A thread could fork (or dup) after that and get crazy in a theoretical
scenario ... are you suggesting this be serialized?

> 
> 
> > +		 * return the bits from the config register
> > +		 */
> > +		ret = put_user(__raw_readb(user_dog), p);
> 
> Should return the translated status bits ?

Don't need this really.  I see a few more things that need cleaning
up so I will do that and submit another patch.  And with changing of
the directory up a level, I also forgot the makefile change.

> 
> 
> Alan
