Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 May 2004 23:25:51 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:31987 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225787AbUERWZr>;
	Tue, 18 May 2004 23:25:47 +0100
Received: from orion.mvista.com (localhost.localdomain [127.0.0.1])
	by orion.mvista.com (8.12.8/8.12.8) with ESMTP id i4IMPdx6005009;
	Tue, 18 May 2004 15:25:39 -0700
Received: (from jsun@localhost)
	by orion.mvista.com (8.12.8/8.12.8/Submit) id i4IMPd6W005007;
	Tue, 18 May 2004 15:25:39 -0700
Date: Tue, 18 May 2004 15:25:39 -0700
From: Jun Sun <jsun@mvista.com>
To: Peter Horton <pdh@colonel-panic.org>
Cc: Bob Breuer <bbreuer@righthandtech.com>, linux-mips@linux-mips.org,
	jsun@mvista.com
Subject: Re: problems on D-cache alias in 2.4.22
Message-ID: <20040518152539.D5390@mvista.com>
References: <B482D8AA59BF244F99AFE7520D74BF9609D4B3@server1.RightHand.righthandtech.com> <20040518114519.C5390@mvista.com> <20040518191019.GA11007@skeleton-jack>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040518191019.GA11007@skeleton-jack>; from pdh@colonel-panic.org on Tue, May 18, 2004 at 08:10:19PM +0100
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5080
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Tue, May 18, 2004 at 08:10:19PM +0100, Peter Horton wrote:
> On Tue, May 18, 2004 at 11:45:19AM -0700, Jun Sun wrote:
> > 
> > Like others suggested, this is not the right fix.  flush_page_to_ram()
> > is correctly nullified.  Its job should be done somewhere else
> > by other routines.
> > 
> > Here are a couple of random ideas for finding the true root cause:
> > 
> 
> We know what the true root cause is :-)
> 
> IDE PIO fills the D-cache with the read data (write allocate) as it
> copies it to the page cache.
> 
> The kernel maps the page cache page into user space ... BANG! possible
> D-cache alias.
> 
> The kernel doesn't bother flushing the page cache page from the D-cache
> as it's never accessed at it's page cache address.
> 

The kernel (or driver) should flush the page if it is mapped to user space 
and the content is modified.

> The current fix in the Cobalt patches (2.4 & 2.6) just flushes the read
> data out of the D-cache after every IDE insw()/insl(). This is the least
> intrusive fix.
> 

It should be fixed at a higher layer before we return back to userland.

If you can illustrate the call stack, I can probably take a look and
give my opinion.


Jun
