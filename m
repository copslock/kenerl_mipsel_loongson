Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f342lux27887
	for linux-mips-outgoing; Tue, 3 Apr 2001 19:47:56 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f342ltM27884
	for <linux-mips@oss.sgi.com>; Tue, 3 Apr 2001 19:47:55 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f342i4011835;
	Tue, 3 Apr 2001 19:44:04 -0700
Message-ID: <3ACA8A3B.8BBABB11@mvista.com>
Date: Tue, 03 Apr 2001 19:43:07 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith M Wesolowski <wesolows@foobazco.org>
CC: linux-mips@oss.sgi.com
Subject: Re: RFC: Cleanup/detection patch
References: <20010401235212.B9737@foobazco.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Keith M Wesolowski wrote:
> 
> I have posted an initial copy of my patch for machine detection,
> namespace cleanup, and promlib abstraction at
> http://foobazco.org/~wesolows/mips64-machine.diff.  This is against
> 2.4.2 CURRENT oss.  It currently passes my regression testsuite which
> unfortunately does not include an ip27 boot test.
> 

Keith,  I am interested in this stuff, but I have not got time around to look
into it.  

Here are some of my thoughts on this issues.  Maybe you can clarify them here.

1. Right now, our tree (at least 32-bit) does not even support multiple CPUs
(with the same machine/board).  Take a look of
arch/mips/mm/loadmmu.c:loadmmu(), and you will see what I mean.  The CPU
specific ld_mmu_xxx is #ifdef'ed.  So if you enable multiple CPU, the last
ld_mmu_xxx will win!

So a modest step forward would be fixing that first.

2. Currently all CPU specific ld_mmu_xxx stuff lump cache and TLB together. 
That is not very good.  I have seen CPUs that can share cache but not TLB. 
Vice versa.  Personally I like to see their separation first before a more
dramatic scheme is in place.

3. Unfortunally not all CPUs can be fully probed at the run-time, specifically
the external cache size and geometry.  I was thinking perhaps a board
detection routine should be placed at the beginning which will supply external
cache info.  In addition it will probably set prom_init() pointer - yes, we do
have conflicting prom_init() from every board-specific implementation - and
board_setup() pointer.  What do you think?

Sorry for not giving you patch specific comments, but I figure if I don't spit
it out now it will be probably never. :-)

Jun
