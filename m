Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6G8tARw022229
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 16 Jul 2002 01:55:10 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6G8tAss022228
	for linux-mips-outgoing; Tue, 16 Jul 2002 01:55:10 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6G8t2Rw022219
	for <linux-mips@oss.sgi.com>; Tue, 16 Jul 2002 01:55:03 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id LAA21915;
	Tue, 16 Jul 2002 11:00:05 +0200 (MET DST)
Date: Tue, 16 Jul 2002 11:00:04 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Gleb O. Raiko" <raiko@niisi.msk.ru>
cc: linux-mips@oss.sgi.com
Subject: Re: mips32_flush_cache routine corrupts CP0_STATUS with gcc-2.96
In-Reply-To: <3D3292E0.40FE937B@niisi.msk.ru>
Message-ID: <Pine.GSO.3.96.1020716104018.20654A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 15 Jul 2002, Gleb O. Raiko wrote:

> A cache is filled in cachline units. There is a possibility to fill only
> part of cacheline in one cache and to store the rest of data in another
> cache on the switch. Both caches will set the valid bit on this
> cacheline, but only part of cacheline is valid. In the worst cache, this
> operation may load instructions that will be reused later, for example,
> part of the main loop of the cache invalidation (sic!) routine.

 Well, it looks possible for a CPU with cache lines wider than 32-bits
(are there any such R3k-class CPUs?), indeed.

> Unfortunately, the behaviour depends on whether miss occurs, what
> instructions are loaded, how they are aligned, and so on. It means, if
> you get crash on this kernel version, you won't get a crash on another.
> If you add debug routines, everything is OK. Other black magic tricks
> are also here. (As you may guess, I explain my real experience here.
> :-). Analyzer doesn't help, bus transactions look good.)

 How true -- I've seen such nastinesses, too. :-/  Except that I don't
have an analyzer.

> In order to avoid this, CPU shall either perform the check again or
> freeze everything on the cache swap operation. The latter doesn't look
> real. Anyway, it's a lot of additional unnatural logic. So, the
> requirement to run swapping operation uncached looks reasonable.

 Well, the simplest effective approach would be a third alternative, i.e. 
to make swapping happen only when no fill is in progress.  Trivial logic
with a single D latch on the swap signal should suffice -- I don't think
the save on omitting it is worth breaking architecture specs and
performance.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
