Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f343Uw129405
	for linux-mips-outgoing; Tue, 3 Apr 2001 20:30:58 -0700
Received: from mail.foobazco.org (snowman.foobazco.org [198.144.194.230])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f343UwM29402
	for <linux-mips@oss.sgi.com>; Tue, 3 Apr 2001 20:30:58 -0700
Received: from galt.foobazco.org (galt.foobazco.org [198.144.194.227])
	by mail.foobazco.org (Postfix) with ESMTP
	id 4B615109DD; Tue,  3 Apr 2001 20:30:56 -0700 (PDT)
Received: by galt.foobazco.org (Postfix, from userid 1014)
	id 3907D1F429; Tue,  3 Apr 2001 20:30:56 -0700 (PDT)
Date: Tue, 3 Apr 2001 20:30:56 -0700
From: Keith M Wesolowski <wesolows@foobazco.org>
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: RFC: Cleanup/detection patch
Message-ID: <20010403203055.A17365@foobazco.org>
References: <20010401235212.B9737@foobazco.org> <3ACA8A3B.8BBABB11@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3ACA8A3B.8BBABB11@mvista.com>; from jsun@mvista.com on Tue, Apr 03, 2001 at 07:43:07PM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Apr 03, 2001 at 07:43:07PM -0700, Jun Sun wrote:

> 1. Right now, our tree (at least 32-bit) does not even support multiple CPUs
> (with the same machine/board).  Take a look of
> arch/mips/mm/loadmmu.c:loadmmu(), and you will see what I mean.  The CPU
> specific ld_mmu_xxx is #ifdef'ed.  So if you enable multiple CPU, the last
> ld_mmu_xxx will win!
> 
> So a modest step forward would be fixing that first.

In the patch, the mips_cpu structure has a load_cache and load_tlb
function associated with it which are assigned during cpu_probe.  It
is now possible - I believe - to compile both andes.c and r4k* into
the kernel and have the right routines run at boot time.  No reason
this can't work for other CPUs also.

> 2. Currently all CPU specific ld_mmu_xxx stuff lump cache and TLB together. 
> That is not very good.  I have seen CPUs that can share cache but not TLB. 
> Vice versa.  Personally I like to see their separation first before a more
> dramatic scheme is in place.

The patch addresses this; look at the removal of r4xx0.c and its
replacements.  It's been split into four pieces - this may become
three later.  One for cache, one for tlb, one for copy/clear page and
miscellaneous outlined assembly (yes, in real assembly), and one for
initialization functions.  There's no reason it couldn't be further
split; for example, to do r4600/r5k style caches in a separate module.

> 3. Unfortunally not all CPUs can be fully probed at the run-time,
> specifically the external cache size and geometry.  I was thinking
> perhaps a board detection routine should be placed at the beginning
> which will supply external

The CPU-specific load_cache is responsible for this.  I'm open to the
idea of having separate cache detection for cache problems that are
*not* cpu-specific.  For example, if r10k indy with boardcache existed
that might be applicable.  But I think the load_cache should be able
to handle this.

> cache info.  In addition it will probably set prom_init() pointer -
> yes, we do have conflicting prom_init() from every board-specific
> implementation - and board_setup() pointer.  What do you think?

Namespace collisions like that must die.  For now the mips_init->init
is called at about the same place that prom_init used to be; in many
cases the equivalent will be needed to successfully probe a machine
and thus will be done by the probe function.  In either case, there's
no need for each machine to have a separate function with that name.

> Sorry for not giving you patch specific comments, but I figure if I
> don't spit it out now it will be probably never. :-)

Yep.

-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
"I should have crushed his marketing-addled skull with a fucking bat."
