Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4TL6pnC029218
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 29 May 2002 14:06:51 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4TL6p6f029217
	for linux-mips-outgoing; Wed, 29 May 2002 14:06:51 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4TL6inC029214
	for <linux-mips@oss.sgi.com>; Wed, 29 May 2002 14:06:44 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g4TL7xP01136;
	Wed, 29 May 2002 14:07:59 -0700
Date: Wed, 29 May 2002 14:07:59 -0700
From: Ralf Baechle <ralf@oss.sgi.com>
To: Justin Carlson <justinca@cs.cmu.edu>
Cc: linux-mips@oss.sgi.com
Subject: Re: __flush_cache_all() miscellany
Message-ID: <20020529140759.A888@dea.linux-mips.net>
References: <1022691053.7644.16.camel@ldt-sj3-022.sj.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1022691053.7644.16.camel@ldt-sj3-022.sj.broadcom.com>; from justinca@cs.cmu.edu on Wed, May 29, 2002 at 09:50:52AM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, May 29, 2002 at 09:50:52AM -0700, Justin Carlson wrote:

> Looking at the cache routines, I've noticed that there's been a
> relatively recent introduction of a __flush_cache_all() routine. 
> Looking at oss.sgi.com's cvs logs, I see this comment:
> 
> >Introduce __flush_cache_all() which flushes the cache no matter if
> >this operation is necessary from the mm point of view or not.
> 
> Some questions:
> 
> Which caches does this apply to?  It looks like the current
> implementations assume L1 only.

The operation got introduced for the R10000 where we only need to flush
the caches during initialization or the (unlikely on Origin) case of

> Would anyone have a problem with renaming this function?  To me, at
> least, it's rather confusing to have all of:

No.  You may have noticed that I already introduced a bunch of local_*()
functions for the TLB stuff for the same reason - the old functions had
poor names.  The common Linux conventions to use extra underscores for a
more basic version of a function (like get_user vs __get_user etc.) is
frequently not expressive enough.

> flush_cache_all()
> _flush_cache_all()
> __flush_cache_all()
> ___flush_cache_all()

Odd number of underscores means it's a pointer ;)

> defined, especially when the latter two mean something significantly
> different from the former two.  I'd prefer calling the new one
> {_}force_flush_l1_caches() or somesuch.

Ok.

> In a related note, one of the few places this routine is called is the
> kgdb stub routines (in arch/mips/kernel/gdb-stub.c):
> 
> void set_async_breakpoint(unsigned int epc)
> {
> 	int cpu = smp_processor_id();
> 
> 	async_bp[cpu].addr = epc;
> 	async_bp[cpu].val  = *(unsigned *)epc;
> 	*(unsigned *)epc = BP;
> 	__flush_cache_all();
> }
> 
> Shouldn't that be a flush_icache_range() call anyways?

Yes.

  Ralf
