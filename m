Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6BDaZRw030907
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 11 Jul 2002 06:36:35 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6BDaZKL030906
	for linux-mips-outgoing; Thu, 11 Jul 2002 06:36:35 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6BDaQRw030897
	for <linux-mips@oss.sgi.com>; Thu, 11 Jul 2002 06:36:27 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA11724;
	Thu, 11 Jul 2002 15:41:25 +0200 (MET DST)
Date: Thu, 11 Jul 2002 15:41:25 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Gleb O. Raiko" <raiko@niisi.msk.ru>
cc: linux-mips@oss.sgi.com
Subject: Re: mips32_flush_cache routine corrupts CP0_STATUS with gcc-2.96
In-Reply-To: <3D2D83FF.A2FAAB38@niisi.msk.ru>
Message-ID: <Pine.GSO.3.96.1020711152156.7876E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 11 Jul 2002, Gleb O. Raiko wrote:

> Aha, you also stepped on this rake. :-) The problem with IDT manuals
> that they frequently contradict itself. You're right, SW manual allows
> cached flushes, but hardware manuals for the family prohibit this and
> state that flashes must be uncahed.
> (a hw manual on family, the same chapter, the same section :-) )

 Wonderful...  Add their non-existent support to that.  I'm afraid I'll
have to ignore problem reports which involve their processors. :-(

> >  Why?  I see no dependency.  What's the problem with interleaving cache
> > fills and invalidations?
> 
> There're two possible optimization:
> 1. (Requires only the instruction that swaps caches must run uncached)
> 	CPU may skip implementation of double check of cache hit on loads.
> 	Scenario: mtc0 with cache swapping with ensuring next instructions are
> in cache
> 	(pipelining here!); swap occurs; must check again the instructions are
> in 
> 	the cache because the same cacheline in the data cache may have valid
> bit set
> 	and CPU will get data instead of code.

 I can't really see a problem here for proper implementations.  The CPU
may have fetched a few instructions beyond the mtc0 doing a cache swap.
It's OK since we didn't modify the code.  As long as the swap doesn't
complete, the CPU is using the real I-cache.  Once it's completed, it uses
the D-cache.  Since the new cache is used in the normal mode of operation,
now tag matches and line replacements occur here as if it was the real
I-cache.  No need to do any extra checks at any stage. 

> 2. (Requires the whole routine must run uncached)
> 	CPU may skip check of cache hit on loads from an isolated cache. 

 But the other cache isn't isolated -- IsC only works on the cache that
plays the role of the D-cache. 

> i don't know what optimization IDT made, perhaps, number 3. But, 1. is
> really worth to implement.

 It's possible they broke something, simply. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
