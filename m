Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jul 2007 21:38:56 +0100 (BST)
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:34777 "EHLO
	caramon.arm.linux.org.uk") by ftp.linux-mips.org with ESMTP
	id S20021808AbXGKUiy (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Jul 2007 21:38:54 +0100
Received: from flint.arm.linux.org.uk ([2002:d993:5cf9:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.62)
	(envelope-from <rmk@arm.linux.org.uk>)
	id 1I8itl-0003Z8-Hg; Wed, 11 Jul 2007 21:34:58 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.62)
	(envelope-from <rmk@flint.arm.linux.org.uk>)
	id 1I8itj-0002hs-Gr; Wed, 11 Jul 2007 21:34:55 +0100
Date:	Wed, 11 Jul 2007 21:34:54 +0100
From:	Russell King <rmk@arm.linux.org.uk>
To:	David Brownell <david-b@pacbell.net>
Cc:	Christoph Hellwig <hch@lst.de>,
	Domen Puncer <domen.puncer@telargo.com>,
	linuxppc-dev@ozlabs.org, Sylvain Munaut <tnt@246tnt.com>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 1/3] powerpc clk.h interface for platforms
Message-ID: <20070711203454.GC2301@flint.arm.linux.org.uk>
References: <20070711093113.GE4375@moe.telargo.com> <200707110856.58463.david-b@pacbell.net> <20070711161633.GA4846@lst.de> <200707111002.55119.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200707111002.55119.david-b@pacbell.net>
User-Agent: Mutt/1.4.2.1i
Return-Path: <rmk+linux-mips=linux-mips.org@arm.linux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15715
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rmk@arm.linux.org.uk
Precedence: bulk
X-list: linux-mips

On Wed, Jul 11, 2007 at 10:02:54AM -0700, David Brownell wrote:
> On Wednesday 11 July 2007, Christoph Hellwig wrote:
> > On Wed, Jul 11, 2007 at 08:56:58AM -0700, David Brownell wrote:
> > > > Umm, this is about the fifth almost identical implementation of
> > > > the clk_ functions.  Please, please put it into common code.
> > > > 
> > > > And talk to the mips folks which just got a similar comment from me.
> > > 
> > > You mean like a lib/clock.c core, rather than an opsvector?
> > 
> > I mean an ops vector and surrounding wrappers.  Every architecture
> > is reimplementing their own dispatch table which is rather annoying.
> 
> ARM doesn't.  :)
> 
> But then, nobody expects one kernel to support more than one
> vendor's ARM chips; or usually, more than one generation of
> that vendor's chips.  So any dispatch table is specific to
> a given platform, and tuned to its quirks.  Not much to share
> between OMAP and AT91, for example, except in some cases maybe
> an arm926ejs block.

And also the information stored within a 'struct clk' is very platform
dependent.  In the most basic situation, 'struct clk' may not actually
be a structure, but the clock rate.  All functions with the exception of
clk_get() and clk_get_rate() could well be no-ops, clk_get() just returns
the 'struct clk' representing the rate and 'clk_get_rate' returns that
as an integer.

More complex setups might want 'struct clk' to contain the address of a
clock enable register, the bit position to enable that clock source, the
clock rate, a refcount, and so on, all of which would be utterly useless
for a platform which had fixed rate clocks.

> I've not seen a solid proposal for such a thing, and it's not
> clear to me how that would play with with older code (e.g. any
> of the ARM implementations).

If people are implementing their own incompatible changes without reference
to the API they're invalid implementations as far as I'm concerned.  If
they can't bothered to lift a finger to even _talk_ to me about their
requirements they just don't have any say concerning any future
developments IMO.

IOW, talk to me and I'll talk back.  Ignore me and I'll ignore them.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
