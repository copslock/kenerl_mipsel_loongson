Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Dec 2002 22:44:07 +0000 (GMT)
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([IPv6:::ffff:213.105.254.86]:12005
	"EHLO irongate.swansea.linux.org.uk") by linux-mips.org with ESMTP
	id <S8225309AbSLQWoG>; Tue, 17 Dec 2002 22:44:06 +0000
Received: from irongate.swansea.linux.org.uk (localhost [127.0.0.1])
	by irongate.swansea.linux.org.uk (8.12.5/8.12.5) with ESMTP id gBHNOClQ021585;
	Tue, 17 Dec 2002 23:24:12 GMT
Received: (from alan@localhost)
	by irongate.swansea.linux.org.uk (8.12.5/8.12.5/Submit) id gBHNOANx021583;
	Tue, 17 Dec 2002 23:24:10 GMT
X-Authentication-Warning: irongate.swansea.linux.org.uk: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: PATCH
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pete Popov <ppopov@mvista.com>
Cc: Greg Lindahl <lindahl@keyresearch.com>,
	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <1040164850.16501.18.camel@zeus.mvista.com>
References: <1039841567.25391.13.camel@adsl.pacbell.net> 
	<20021217142913.A1921@wumpus.internal.keyresearch.com> 
	<1040164850.16501.18.camel@zeus.mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 17 Dec 2002 23:24:10 +0000
Message-Id: <1040167450.20804.30.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 922
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Tue, 2002-12-17 at 22:40, Pete Popov wrote:
> It would be if there was a generic way to go about adding support for
> graphics cards that require bios support. In this case we were working
> with the manufacturer and had all the docs, but still couldn't figure
> out certain pieces needed in initializing the card.  Ultimately the "no
> bios init" patch you see is a pci bus analyzer capture, filtered through
> a perl script, dumped into a new file, and integrated as part of the
> driver.  Even if you could do that with all cards, I'm not sure it's
> legally allowed. We had the vendor's blessings in this case.

XFree86 has an emulator library for this.
