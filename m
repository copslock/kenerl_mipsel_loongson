Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4TKwdnC029062
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 29 May 2002 13:58:39 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4TKwdkp029061
	for linux-mips-outgoing; Wed, 29 May 2002 13:58:39 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4TKwTnC029041;
	Wed, 29 May 2002 13:58:29 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id XAA28092;
	Wed, 29 May 2002 23:00:21 +0200 (MET DST)
Date: Wed, 29 May 2002 23:00:21 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Justin Carlson <justinca@cs.cmu.edu>
cc: linux-mips@oss.sgi.com, ralf@oss.sgi.com
Subject: Re: __flush_cache_all() miscellany
In-Reply-To: <1022703646.7643.175.camel@ldt-sj3-022.sj.broadcom.com>
Message-ID: <Pine.GSO.3.96.1020529222325.17584N-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On 29 May 2002, Justin Carlson wrote:

> Are the general semantics of the thing just broken, then?  We already
> ignore the arguments to sys_cacheflush; would redefining the syscall to
> mean "flush the caches in such a way that I won't get stale instructions
> from this address range" actually break any current programs? 
> (Evidently not, if several ports are already doing it that way)...

 You mean removing the DCACHE operation?  The overlying _flush_cache() 
library function is specified by the MIPS ABI supplement, so we shouldn't
really redefine it.  Also a reasonable use for it may exist -- a userland
program touching hardware directly (say X11) may want to use cached
accesses for performance reasons (e.g. because cache can do prefetches on
reads).

 I guess the intent for the ICACHE operation is to assure ICACHE vs DCACHE
coherency and the intent for the DCACHE operation is to assure DCACHE vs
RAM coherency.  If the operations do not work in this way for a given
backend, then there is a bug in it. 

> More to the point, does __flush_cache_all() serve any useful purpose at
> all, or can it just be replaced with appropriate invocations of
> flush_icache_range()?   Other than internal use for the individual port
> cache routines, it's *only* used in the syscalls and the gdb stub. 

 It does serve a useful purpose.  Or at least it should.  This reminds me
of adding flushing of WB caches at a system shutdown.  The function should
remain at least for this purpose. 

 If there are places you are absolutely sure flush_icache_range() would
suffice, feel free to replace the call.  There are not many
__flush_cache_all() invocations.

> I'd like to hear the rationale for __flush_cache_all() from the original
> author; it appears to have shown up in CVS a little more than a year
> ago, but I don't know who sent the patch to Ralf.  Ralf, do you
> remember?

 I converted a few flush_cache_all() invocations to __flush_cache_all() 
where appropriate late last year, but the function is a bit older.  I
think you might dig the linux-kernel list archives for a discussion on the
semantics of flush_cache_all() (it's a nop for many MIPS CPUs) and
friends.  The short description in Documentation/cachetlb.txt is a bit
insufficient, I'm afraid. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
