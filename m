Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jan 2003 13:30:08 +0000 (GMT)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:21965 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226143AbTAJNaI>; Fri, 10 Jan 2003 13:30:08 +0000
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA25438;
	Fri, 10 Jan 2003 14:30:15 +0100 (MET)
Date: Fri, 10 Jan 2003 14:30:12 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: linux-mips@linux-mips.org
Subject: Re: [patch] R4k cache code synchronization
In-Reply-To: <20030110140326.B7699@linux-mips.org>
Message-ID: <Pine.GSO.3.96.1030110140613.23678E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1123
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 10 Jan 2003, Ralf Baechle wrote:

> The reason for the existance of flush_cache_l1 and flush_cache_l2 is the
> Origin.  An empty flush_cache_all() is sufficient on the Origin because
> it's R10000 processor doesn't suffer from cache aliases.  During bootup
> we have to flush all caches or the cache coherence logic will send crazy
> exceptions at us.  For all other occasions just a flush of the primary
> caches is sufficient which is why there is flush_cache_l1.

 So flush_cache_l1() as currently defined is sufficient for DMA coherency
on the R10000, isn't it?

> So I think we want to wrap things a bit nicer but basically we have to
> keep those cacheops for the sake of the Origin.

 The naming is grossly incorrect.  If the R10000 has such a cache
semantics, then it should use flush_cache_all() (targetting L1) for
coherency and __flush_cache_all() (targetting L2; I assume L2 operations
imply L1 ones, otherwise the function should explicitly operate on L1,
too) for a maintenance flush.  Just like it's done for the 32-bit port. 

 There was a patch attached -- what about it? 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
