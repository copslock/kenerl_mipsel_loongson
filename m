Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jun 2003 00:44:35 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:20726 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225263AbTFDXoX>;
	Thu, 5 Jun 2003 00:44:23 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h54NiLc24415;
	Wed, 4 Jun 2003 16:44:21 -0700
Date: Wed, 4 Jun 2003 16:44:20 -0700
From: Jun Sun <jsun@mvista.com>
To: Michael Uhler <uhler@mips.com>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: [RFC] synchronized CPU count registers on SMP machines
Message-ID: <20030604164420.I19122@mvista.com>
References: <20030604153930.H19122@mvista.com> <002701c32aeb$e4743cd0$08c0a8c0@MIPS.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <002701c32aeb$e4743cd0$08c0a8c0@MIPS.COM>; from uhler@mips.com on Wed, Jun 04, 2003 at 03:51:49PM -0700
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2526
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Wed, Jun 04, 2003 at 03:51:49PM -0700, Michael Uhler wrote:
<snip>
> > 
> > Apparently, this scheme won't work if any of the following 
> > conditions are true:
> > 
> > 1) clocks on different CPUs don't have the same frequency
> > 2) clocks on different CPUs drift to each other
> 
> Depending on the precise system configuration (including whether the
> CPUs are on different SOCs, different boards, where the PLLs are, and
> what the ultimate clock source is), I'd guess that drift is pretty
> likely on almost all systems unless the clocks are intentionally driven
> by some sort of synchronize source.
>

Yes, if there are physically multiple boards, it is likely to have
drifting clocks.

I don't suppose the count synchronization code will work for
all SMP systems.  I hope to get an idea whether it is worth the effort
for the systems that it does work.

For example, it will work on Broadcom's BCM91250 chip and probably a
couple of coming ones.

To give an idea of my original motivation on this RFC, I found out
it is pretty _hard_ just to get a micro-second resolution gettimeofday()
on a SMP system.  And apparently this is an issue on other arches
as well.  I think i386 uses synchronized TSCs, which is the same
idea as what we are talking about here.

> The biggest problem here is latency on the spinlocks and observation of
> the flag state changing.  Depending on the memory architecture, the
> point at which each CPU will see the change could be very different
> (consider a NUMA mesh architecture in which the data movement can take
> different paths).  As such, you could see on order of memory latency
> different in the clocks.
>

If it is a few clocks in difference, it should be acceptable.

Basically, imagine a spin lock protected read_count routine:

unsigned read_count() 
{
	spin_lock(&count_lock);
	count = read_c0_count();
	spin_unlock(&count_lock);
	return count;
}

and imagine there are randomly calls to this function by different
CPUs, the calls are serialized due to the spinlock.  As long as
the return values are monotonically increasing, we are fine.

Thanks for the reply.  And congrads on your new post. :)

Jun
