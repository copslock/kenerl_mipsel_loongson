Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4TJmTnC027439
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 29 May 2002 12:48:29 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4TJmToQ027438
	for linux-mips-outgoing; Wed, 29 May 2002 12:48:29 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4TJmInC027435;
	Wed, 29 May 2002 12:48:18 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id VAA26634;
	Wed, 29 May 2002 21:50:11 +0200 (MET DST)
Date: Wed, 29 May 2002 21:50:10 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Justin Carlson <justinca@cs.cmu.edu>
cc: linux-mips@oss.sgi.com, ralf@oss.sgi.com
Subject: Re: __flush_cache_all() miscellany
In-Reply-To: <1022700389.7644.155.camel@ldt-sj3-022.sj.broadcom.com>
Message-ID: <Pine.GSO.3.96.1020529213719.17584J-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On 29 May 2002, Justin Carlson wrote:

> Here's a patch against cvs that does the rename.  Unless anyone has
> objections, Ralf, could  you apply this?

 That looks fine to me.  I'd keep the leading double underscore, though --
it acts as a warning sign the function is internal and low-level and thus
it should not be used without an appropriate justification.

> While doing this, I've noticed that the whole mips tree is horribly
> inconsistent in terms of the cache flushing syscalls (sys_cacheflush and
> sys_sysmips->CACHE_FLUSH).  

 Ugh, it's not the only place of inconsistency...

> Here's what the different ports appear to flush given one of these
> syscall:
> 
> andes:  l1 and l2
> lexra:  l1 icache
> mips32: l1 icache/dcache
> r3k:    l1 icache
> r4k:    l1 icache/dcache
> r5432:  l1 icache/dcache
> r5900:  l1 icache/dcache
> rm7k:   l1 icache/dcache
> sb1:    l1 icache/dcache
> sr7100: l1 and l2
> tx39:   l1 icache
> tx49:   li icache/dcache
> 
> Some of these are blatantly wrong with respect to the cacheflush
> syscall; it defines flags for flushing the icache, dcache, or both.  In
> the latter two cases, the lexra, r3k, and tx39 are not doing what was
> requested.  I doubt this matters for any significant userspace app, but
> it would be nice to at least be consistent.

 Well, at least r3k uses WT for dcache, so it really doesn't matter unless
what you want to achieve is to hit performance.  I suspect this is also
the case for the others that ignore dcache flushes.  The L1 vs L2 issue
should be investigated where applicable. 

 This reminds me to check ld.so (and libdl) for missing sys_cacheflush()
invocations as well...

> As for the sysmips system call, I've  not been able to dig up the
> semantics.  (Actually, I don't really see why we have both ways of
> flushing the cache at all...some historical cruft?).  Anyone have a
> helpful pointer to docs on the subject?

 It's compatibility crap, like the whole sysmips() stuff, I am afraid. 
Use sys_cacheflush() normally. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
