Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6BFsIRw006844
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 11 Jul 2002 08:54:18 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6BFsIGo006843
	for linux-mips-outgoing; Thu, 11 Jul 2002 08:54:18 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6BFsCRw006834
	for <linux-mips@oss.sgi.com>; Thu, 11 Jul 2002 08:54:12 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA14333;
	Thu, 11 Jul 2002 17:59:15 +0200 (MET DST)
Date: Thu, 11 Jul 2002 17:59:15 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Gleb O. Raiko" <raiko@niisi.msk.ru>
cc: linux-mips@oss.sgi.com
Subject: Re: mips32_flush_cache routine corrupts CP0_STATUS with gcc-2.96
In-Reply-To: <3D2DA3D5.66664759@niisi.msk.ru>
Message-ID: <Pine.GSO.3.96.1020711173440.7876G-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 11 Jul 2002, Gleb O. Raiko wrote:

> Have to check the cacheline at given address again. D-cache may have the
> valid bit set for the cacheline at the same address. Address means
> location in a cache, not memory. Check at address requires one extra
> tick as opposed to checking the bit.

 Well, you issue an instruction word read from the cache.  The answer is
either a hit, providing a word at the data bus at the same time (so you
can't get a hit from one cache and data from the other) or a miss with no
valid data -- you have to stall in this case, waiting for a refill.  Then
when data from the main memory arrives, it is latched in the cache (it
doesn't really matter, which one now -- if it's the wrong one, then
another refill will happen next time the memory address is dereferenced)
and provided to the CPU at the same time. 

> Please, note that CPU isn't a monolitic program, but rather a set of
> functional blocks, so "proper implementation" may require additional
> signals on wires and delays.

 Some kind of synchronization is needed as everywhere in the CPU, as it's
mostly a synchronous circuit.  As long as the state at clock edges is
consistent, there is no problem with cache swapping.  That's what I mean
by a "proper implementation".

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
