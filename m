Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Dec 2002 22:48:22 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:30198 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225311AbSLQWsV>;
	Tue, 17 Dec 2002 22:48:21 +0000
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id OAA01396;
	Tue, 17 Dec 2002 14:47:56 -0800
Subject: Re: PATCH
From: Pete Popov <ppopov@mvista.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg Lindahl <lindahl@keyresearch.com>,
	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <1040167450.20804.30.camel@irongate.swansea.linux.org.uk>
References: <1039841567.25391.13.camel@adsl.pacbell.net> 
	<20021217142913.A1921@wumpus.internal.keyresearch.com> 
	<1040164850.16501.18.camel@zeus.mvista.com> 
	<1040167450.20804.30.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 17 Dec 2002 14:51:14 -0800
Message-Id: <1040165474.16482.22.camel@zeus.mvista.com>
Mime-Version: 1.0
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 923
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Tue, 2002-12-17 at 15:24, Alan Cox wrote:
> On Tue, 2002-12-17 at 22:40, Pete Popov wrote:
> > It would be if there was a generic way to go about adding support for
> > graphics cards that require bios support. In this case we were working
> > with the manufacturer and had all the docs, but still couldn't figure
> > out certain pieces needed in initializing the card.  Ultimately the "no
> > bios init" patch you see is a pci bus analyzer capture, filtered through
> > a perl script, dumped into a new file, and integrated as part of the
> > driver.  Even if you could do that with all cards, I'm not sure it's
> > legally allowed. We had the vendor's blessings in this case.
> 
> XFree86 has an emulator library for this.

Thanks; I didn't know that.

One of the problems with these graphics cards is that they are end of
life before you finish writing the driver. I still have a few RageXL
cards in the office, but you can't even buy them in the store anymore.

Pete
