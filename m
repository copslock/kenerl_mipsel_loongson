Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Dec 2002 22:37:48 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:50162 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225304AbSLQWhr>;
	Tue, 17 Dec 2002 22:37:47 +0000
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id OAA00954;
	Tue, 17 Dec 2002 14:37:33 -0800
Subject: Re: PATCH
From: Pete Popov <ppopov@mvista.com>
To: Greg Lindahl <lindahl@keyresearch.com>
Cc: linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <20021217142913.A1921@wumpus.internal.keyresearch.com>
References: <1039841567.25391.13.camel@adsl.pacbell.net> 
	<20021217142913.A1921@wumpus.internal.keyresearch.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 17 Dec 2002 14:40:50 -0800
Message-Id: <1040164850.16501.18.camel@zeus.mvista.com>
Mime-Version: 1.0
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 921
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Tue, 2002-12-17 at 14:29, Greg Lindahl wrote:
> On Fri, Dec 13, 2002 at 08:52:47PM -0800, Pete Popov wrote:
> 
> > This patch was sent to the RageXL maintainer but I don't think he was
> > interested in it. Others might find it useful on embedded systems. It
> > initializes the RageXL card when there is no system bios to initialize
> > it from the video bios.  Tested on the Pb1500; makes a really good
> > workstation.
> 
> Pete,
> 
> Is there a website with info about graphics cards on non-x86
> architectures? 

Not that I know of personally.

> Most cards require their own BIOS to be run at boot
> time. This issue ought to be of interest to lots of other communities
> than MIPS.

It would be if there was a generic way to go about adding support for
graphics cards that require bios support. In this case we were working
with the manufacturer and had all the docs, but still couldn't figure
out certain pieces needed in initializing the card.  Ultimately the "no
bios init" patch you see is a pci bus analyzer capture, filtered through
a perl script, dumped into a new file, and integrated as part of the
driver.  Even if you could do that with all cards, I'm not sure it's
legally allowed. We had the vendor's blessings in this case.

Pete
