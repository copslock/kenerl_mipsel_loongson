Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jun 2003 17:53:53 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:16370 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225289AbTFEQxv>;
	Thu, 5 Jun 2003 17:53:51 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h55GrmR02398;
	Thu, 5 Jun 2003 09:53:48 -0700
Date: Thu, 5 Jun 2003 09:53:48 -0700
From: Jun Sun <jsun@mvista.com>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Dominic Sweetman <dom@mips.com>, linux-mips@linux-mips.org,
	jsun@mvista.com
Subject: Re: [RFC] synchronized CPU count registers on SMP machines
Message-ID: <20030605095348.C25414@mvista.com>
References: <20030604153930.H19122@mvista.com> <20030604231547.GA22410@linux-mips.org> <20030604164652.J19122@mvista.com> <20030605001232.GA5626@linux-mips.org> <20030604183836.B25414@mvista.com> <16094.64161.12926.645512@doms-laptop.algor.co.uk> <20030605084852.GA25712@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030605084852.GA25712@linux-mips.org>; from ralf@linux-mips.org on Thu, Jun 05, 2003 at 10:48:52AM +0200
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2544
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Thu, Jun 05, 2003 at 10:48:52AM +0200, Ralf Baechle wrote:
> On Thu, Jun 05, 2003 at 09:09:05AM +0100, Dominic Sweetman wrote:
> 
> > A naive network synchronisation protocol - analogous to your first
> > proposal - would leave clocks differing by a network round-trip time
> > or so: but NTP does a lot better.  So in principle you should be able
> > to scale NTP to create a clock synchronised within some fraction of
> > the time taken by a CPU-to-CPU communication... but compressing the
> > essence of the NTP protocol into something which runs fast enough
> > might be interesting!
> > 
> > My 5-minutes-over-breakfast feeling is that you should be able to
> > figure out a way to get time right enough; try reading up how NTP
> > works and see whether it can be made to work?
> 
> Yes, already been thinking about that.  The essence of NTP is a software
> implementation of a phase locked loop.  The full NTP protocol is way to
> heavy of course but the subset we're talking about would be rather
> lightweight.  I'd expect the phase noise to be in the low ppb range,
> little problems with unlocking.  And it'll be usable for arbitrary
> combinations of clock frequencies.  So an approach to try.
>

OK, I think you all convinced me that it is probably not a good
idea to do the synchronized CPU count registers, at least not until
we take a look of some alternatives.
 
> Enjoy your breakfast :-)
>

What are you eating?  I probably should have that when I was thinking
about this RFC. :)

In response to some other replies:

1) yes, it is always possible to use some external system-wide
timer source, if available, to solve this problem.  However, that could
get tricky too, and I wanted to do something generic which is hopefully 
applicable to more systems.

2) at least from my perspective, I see increasing demand for high
resolution timers that has monotonicity in both kernel space and user space.

Jun
