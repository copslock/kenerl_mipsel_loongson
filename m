Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Aug 2007 08:28:18 +0100 (BST)
Received: from out002.atlarge.net ([129.41.63.60]:14822 "EHLO
	out002.atlarge.net") by ftp.linux-mips.org with ESMTP
	id S20021689AbXHAH2Q (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Aug 2007 08:28:16 +0100
Received: from hpmailfe-01.atlarge.net ([10.100.60.156]) by out002.atlarge.net with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 1 Aug 2007 02:27:18 -0500
Received: from localhost ([213.250.36.225]) by hpmailfe-01.atlarge.net with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 1 Aug 2007 02:27:17 -0500
Date:	Wed, 1 Aug 2007 09:28:07 +0200
From:	Domen Puncer <domen.puncer@telargo.com>
To:	Domen Puncer <domen.puncer@telargo.com>
Cc:	Russell King <rmk@arm.linux.org.uk>,
	David Brownell <david-b@pacbell.net>, linuxppc-dev@ozlabs.org,
	Christoph Hellwig <hch@lst.de>, linux-mips@linux-mips.org
Subject: Generic clk.h wrappers? [Was: Re: [PATCH 1/3] powerpc clk.h interface for platforms]
Message-ID: <20070801072807.GL4529@moe.telargo.com>
References: <20070711093113.GE4375@moe.telargo.com> <200707110856.58463.david-b@pacbell.net> <20070711161633.GA4846@lst.de> <200707111002.55119.david-b@pacbell.net> <20070711203454.GC2301@flint.arm.linux.org.uk> <20070713091203.GE11476@nd47.coderock.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070713091203.GE11476@nd47.coderock.org>
User-Agent: Mutt/1.5.12-2006-07-14
X-OriginalArrivalTime: 01 Aug 2007 07:27:17.0947 (UTC) FILETIME=[63ECB8B0:01C7D40D]
Return-Path: <domen.puncer@telargo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15970
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: domen.puncer@telargo.com
Precedence: bulk
X-list: linux-mips

On 13/07/07 11:12 +0200, Domen Puncer wrote:
> On 11/07/07 21:34 +0100, Russell King wrote:
> > On Wed, Jul 11, 2007 at 10:02:54AM -0700, David Brownell wrote:
> > > On Wednesday 11 July 2007, Christoph Hellwig wrote:
> > > > On Wed, Jul 11, 2007 at 08:56:58AM -0700, David Brownell wrote:
> > > > > > Umm, this is about the fifth almost identical implementation of
> > > > > > the clk_ functions.  Please, please put it into common code.
> > > > > > 
> > > > > > And talk to the mips folks which just got a similar comment from me.
> > > > > 
> > > > > You mean like a lib/clock.c core, rather than an opsvector?
> > > > 
> > > > I mean an ops vector and surrounding wrappers.  Every architecture
> > > > is reimplementing their own dispatch table which is rather annoying.
> > > 
> > > ARM doesn't.  :)
> > > 
> > > But then, nobody expects one kernel to support more than one
> > > vendor's ARM chips; or usually, more than one generation of
> > > that vendor's chips.  So any dispatch table is specific to
> > > a given platform, and tuned to its quirks.  Not much to share
> > > between OMAP and AT91, for example, except in some cases maybe
> > > an arm926ejs block.
> > 
> > And also the information stored within a 'struct clk' is very platform
> > dependent.  In the most basic situation, 'struct clk' may not actually
> > be a structure, but the clock rate.  All functions with the exception of
> > clk_get() and clk_get_rate() could well be no-ops, clk_get() just returns
> > the 'struct clk' representing the rate and 'clk_get_rate' returns that
> > as an integer.
> > 
> > More complex setups might want 'struct clk' to contain the address of a
> > clock enable register, the bit position to enable that clock source, the
> > clock rate, a refcount, and so on, all of which would be utterly useless
> > for a platform which had fixed rate clocks.
> 
> The patch that triggered this discussion is at the end.
> It doesn't make any assumption on struct clk, it's just a
> wrapper around functions from clk.h.
> Point of this patch was to abstract exported functions, since
> arch/powerpc/ can support multiple platfroms in one binary.

So... the thread just ended without any consensus, ACK or whatever.

Choices I see:
- have EXPORT_SYMBOL for clk.h functions in ie. lib/clock.c and have
  every implemenation fill some global struct.
- leave this patch as it is, abstraction only for arch/powerpc/.
- or I can just forget about this, and leave it for the next sucker
  who will want nicer clock handling in some driver.


	Domen
