Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jun 2003 18:17:53 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:20462 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8224861AbTFQRRu>;
	Tue, 17 Jun 2003 18:17:50 +0100
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id KAA22567;
	Tue, 17 Jun 2003 10:17:44 -0700
Subject: Re: wired tlb entry?
From: Pete Popov <ppopov@mvista.com>
To: Joseph Chiu <joseph@omnilux.net>
Cc: Linux MIPS mailing list <linux-mips@linux-mips.org>
In-Reply-To: <BPEELMGAINDCONKDGDNCOEFBDMAA.joseph@omnilux.net>
References: <BPEELMGAINDCONKDGDNCOEFBDMAA.joseph@omnilux.net>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1055870334.4383.198.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 17 Jun 2003 10:18:54 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2675
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Mon, 2003-06-16 at 17:36, Joseph Chiu wrote:
> Hi,
> Is there a (proper) way to add a page entry in the TLB it's always valid?
> Specifically, accesses to memory-mapped hardware (PCMCIA) causes the kernel
> to oops under heavy interrupt loading.
> It seems to me that the page entry in the TLB is getting flushed out under
> the activity; and when the ioremap'd memory region is accesses, the
> exception handling for the missing translation does not run.
> 
> I'm afraid my two days of googling hasn't turned up the right information.
> I think I just don't know the right terminology and I hope someone can at
> least point me in the right direction.
> Thanks.
> Joseph
> (I am running 2.4.18-mips)

So is this a kernel from linux-mips.org?  Are you using the 36 bit I/O
patch in that kernel, or the pseudo-address translation hack that I
removed later? What pcmcia I/O card are you using and what tests are you
running?

Pete
