Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6CIvhRw011395
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 12 Jul 2002 11:57:43 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6CIvhhi011394
	for linux-mips-outgoing; Fri, 12 Jul 2002 11:57:43 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6CIvZRw011385
	for <linux-mips@oss.sgi.com>; Fri, 12 Jul 2002 11:57:36 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id VAA11662;
	Fri, 12 Jul 2002 21:02:42 +0200 (MET DST)
Date: Fri, 12 Jul 2002 21:02:41 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Gleb O. Raiko" <raiko@niisi.msk.ru>
cc: linux-mips@oss.sgi.com
Subject: Re: mips32_flush_cache routine corrupts CP0_STATUS with gcc-2.96
In-Reply-To: <3D2EAEF2.C06AFD05@niisi.msk.ru>
Message-ID: <Pine.GSO.3.96.1020712204324.7646H-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 12 Jul 2002, Gleb O. Raiko wrote:

> >  Well, you issue an instruction word read from the cache.  The answer is
> > either a hit, providing a word at the data bus at the same time (so you
> > can't get a hit from one cache and data from the other) or a miss with no
> > valid data -- you have to stall in this case, waiting for a refill.  
> 
> Let it be miss and stall.
> 
> >Then
> > when data from the main memory arrives, it is latched in the cache (it
> > doesn't really matter, which one now -- if it's the wrong one, then
> > another refill will happen next time the memory address is dereferenced)
> > and provided to the CPU at the same time.
> 
> At this time, CPU continues the execution of previous stalled

 We don't care of previous instructions.  The pipeline is stalled at the
intruction word fetch stage.  Previously fetched instructions continue
being processed until they leave the pipeline. 

> instruction. CPU knows the stalled instruction is in I-cache, but,
> unfortunately, caches have been swapped already. The same cacheline in
> the D-cache was valid bit set. CPU get data instead of code.

 Well, I certainly understand what you mean, from the beginning, actually,
but I still can't see why this would happen for a real implementation. 
When a cache miss happens an instruction word is read directly from the
main memory to the pipeline and a cache fill happens "accidentally".

 What you describe, would require a CPU to query a cache status somehow
during a fill (what if another fill is in progress? -- a cache controller
may perform a fill of additional lines itself as it happens in certain
implementations) and then issue a second read when the fill completes. 
That looks weird to me -- why would you design it this way? 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
