Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6BBJ0Rw025304
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 11 Jul 2002 04:19:00 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6BBJ0g4025303
	for linux-mips-outgoing; Thu, 11 Jul 2002 04:19:00 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6BBIoRw025294;
	Thu, 11 Jul 2002 04:18:51 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA09051;
	Thu, 11 Jul 2002 13:23:37 +0200 (MET DST)
Date: Thu, 11 Jul 2002 13:23:36 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Gleb O. Raiko" <raiko@niisi.msk.ru>
cc: Carsten Langgaard <carstenl@mips.com>, Ralf Baechle <ralf@oss.sgi.com>,
   Jon Burgess <Jon_Burgess@eur.3com.com>, linux-mips@oss.sgi.com
Subject: Re: mips32_flush_cache routine corrupts CP0_STATUS with gcc-2.96
In-Reply-To: <3D2D58A6.2E5D9695@niisi.msk.ru>
Message-ID: <Pine.GSO.3.96.1020711130202.7876C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 11 Jul 2002, Gleb O. Raiko wrote:

> > But that code belongs in the R30xx specific cache routines, not in the MIPS32 cache
> > routines.
> 
> I don't wonder if other IDT CPUs also require this, including those that
> conform MIPS32.

 Well, for r3k it may seem somewhat justified as cache flushing requires
cache isolation.  But the IDT manual for their whole family of processors
claims the D-cache can function as an I-cache (when swapped; doesn't
apply when not, obviously) and cache flushing can run from KSEG0.

 See "IDT MIPS Microprocessor Family Software Reference Manual", chapter 5
"Cache Management", section "Invalidation":

 "To invalidate the cache in the R30xx:
[...]
 The invalidate routine is normally executed with its instructions
cacheable.  This sounds like a lot of trouble; but in fact shouldnt
require any extra steps to run cached. An invalidation routine in uncached
space will run 4-10 times slower."

That's right as the IsC bit only isolates the D-cache (either the real one
or the I-cache, when swapped) and not the I-cache, so no need to waste
cycles running uncached as the I-cache works normally. 

> Basically, requirement of uncached run makes hadrware logic much simpler
> and allows  to save silicon a bit.

 Why?  I see no dependency.  What's the problem with interleaving cache
fills and invalidations?

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
