Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 May 2004 19:45:22 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:56312 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225777AbUERSpV>;
	Tue, 18 May 2004 19:45:21 +0100
Received: from orion.mvista.com (localhost.localdomain [127.0.0.1])
	by orion.mvista.com (8.12.8/8.12.8) with ESMTP id i4IIjJx6013363;
	Tue, 18 May 2004 11:45:19 -0700
Received: (from jsun@localhost)
	by orion.mvista.com (8.12.8/8.12.8/Submit) id i4IIjJTW013361;
	Tue, 18 May 2004 11:45:19 -0700
Date: Tue, 18 May 2004 11:45:19 -0700
From: Jun Sun <jsun@mvista.com>
To: Bob Breuer <bbreuer@righthandtech.com>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: problems on D-cache alias in 2.4.22
Message-ID: <20040518114519.C5390@mvista.com>
References: <B482D8AA59BF244F99AFE7520D74BF9609D4B3@server1.RightHand.righthandtech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <B482D8AA59BF244F99AFE7520D74BF9609D4B3@server1.RightHand.righthandtech.com>; from bbreuer@righthandtech.com on Tue, May 18, 2004 at 01:17:38PM -0500
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5065
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Tue, May 18, 2004 at 01:17:38PM -0500, Bob Breuer wrote:
> 
> > -----Original Message-----
> > From: linux-mips-bounce@linux-mips.org
> > [mailto:linux-mips-bounce@linux-mips.org]On Behalf Of Peter Horton
> > Sent: Friday, May 14, 2004 2:53 AM
> > To: wuming
> > Cc: linux-mips@linux-mips.org
> > Subject: Re: problems on D-cache alias in 2.4.22
> > 
> > 
> > wuming wrote:
> > 
> ...
> > > at last, when I replaced flush_page_to_ram( ) with 
> > flush_dcache_page( ),
> > > the internal compiler error disappeared.
> > >
> ...
> > 
> > This is probably just hiding your problem. flush_page_to_ram() is not 
> > used anymore.
> > 
> > P.
> > 
> > 
> 
> Changing that same place also fixes my problem.  

<snip>

Like others suggested, this is not the right fix.  flush_page_to_ram()
is correctly nullified.  Its job should be done somewhere else
by other routines.

Here are a couple of random ideas for finding the true root cause:

. If a page is shared by multiple user processes, make sure either the CPU
  does not have d-cache alaising problem (i.e., cache way size is 4KB or less)
  or their virtual addresses lie on the "same color strip" of the d-cache.
  In other words, they would be cached in the same cache way.

. If a page is modified by kernel and accessed by user land, make sure a 
  flush_dcache_page() is called right after the modifying.

. If a page is modified by userland and accessed by kernel, I _think_ currently
  kernel would still do a flush_dcache_page() call.  However, this won't
  work on MIPS because the cache at user virtual addresses are not flushed.
  Either try to flush with user virtual address, or do a flush_cache_all(). *ick*

BTW, I _think_ the last problem stilled exists in 2.6.  We probably need
to use the reverse maping info to fix it.

Jun
