Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Oct 2004 12:34:48 +0100 (BST)
Received: from p508B6D7E.dip.t-dialin.net ([IPv6:::ffff:80.139.109.126]:24114
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225228AbUJTLen>; Wed, 20 Oct 2004 12:34:43 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i9KBYcCE025275;
	Wed, 20 Oct 2004 13:34:38 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i9KBYcPq025274;
	Wed, 20 Oct 2004 13:34:38 +0200
Date: Wed, 20 Oct 2004 13:34:38 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Jes Sorensen <jes@wildopensource.com>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>,
	Manish Lachwani <mlachwani@mvista.com>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH]PCI on SWARM
Message-ID: <20041020113438.GC24808@linux-mips.org>
References: <416DE31E.90509@mvista.com> <20041014191754.GB30516@linux-mips.org> <Pine.LNX.4.58L.0410142305380.25607@blysk.ds.pg.gda.pl> <416EFBAB.8050600@mvista.com> <Pine.LNX.4.58L.0410142327530.25607@blysk.ds.pg.gda.pl> <20041014225553.GA13597@linux-mips.org> <Pine.LNX.4.58L.0410150311370.25607@blysk.ds.pg.gda.pl> <yq0zn2ks9em.fsf@jaguar.mkp.net> <20041018191507.GA14440@linux-mips.org> <yq0pt3erkzx.fsf@jaguar.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq0pt3erkzx.fsf@jaguar.mkp.net>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6119
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 20, 2004 at 01:56:02AM -0400, Jes Sorensen wrote:

> Ralf> On Mon, Oct 18, 2004 at 04:44:17AM -0400, Jes Sorensen wrote:
> >> Dual address cycles, ie. 64 bit addressing is fscked on the 1250
> >> from what I remember. Correct way to work around this is to stick
> >> all physical memory outside the 32 bit space into ZONE_HIGHMEM -
> >> had a patch for 2.4, but I lost it ages ago ;-(
> 
> Ralf> The Momentum Jaguar suffers from similar problems, so I've
> Ralf> implemented that for Linux 2.6 as CONFIG_LIMITED_DMA.
> 
> Wouldn't it be better to always have the highmem zone configured and
> then just fill it up with pages if you have a b0rked platform?

On these platform I enable CONFIG_HIGHMEM and because they don't support
real highmem in sense of requiring other mappings than KSEG0 for access
by the processor I replace kmap() etc. with the non-highmem variants
from <linux/highmem.h>.  Filling in page->virtual on startup and defining
WANT_PAGE_VIRTUAL makes sure the mapping overhead stays low.  An ugly
solution but probably the only one acceptable upstream and fortunately
there are now nicer variants of the architecture available that don't
need such tricks.

> The cost of this is miniscule.

I wish it was.  The kernel has this preference for ZONE_NORMAL over
ZONE_HIGHMEM but on this particular platform ZONE_HIGHMEM with it's
memory controller integrated into the CPU itself provides better performance
than ZONE_NORMAL which resides in memory controller that's separate from
the processor in an external system controller.

If further optimizations to were of interest I'd probably try to play a
bit with build_zonelists_node() ...

  Ralf
