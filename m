Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4V6s7N31969
	for linux-mips-outgoing; Wed, 30 May 2001 23:54:07 -0700
Received: from Cantor.suse.de (ns.suse.de [213.95.15.193])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f4V6s1h31964
	for <linux-mips@oss.sgi.com>; Wed, 30 May 2001 23:54:01 -0700
Received: from Hermes.suse.de (Hermes.suse.de [213.95.15.136])
	by Cantor.suse.de (Postfix) with ESMTP
	id 105C61E10F; Thu, 31 May 2001 08:53:55 +0200 (MEST)
X-Authentication-Warning: D139.suse.de: aj set sender to aj@suse.de using -f
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com,
   Ralf Baechle <ralf@uni-koblenz.de>, Jun Sun <jsun@mvista.com>
Subject: Re: [patch] RFC: A sys__test_and_set() implementation, 2nd iteration
References: <Pine.GSO.3.96.1010530190118.9456D-100000@delta.ds2.pg.gda.pl>
From: Andreas Jaeger <aj@suse.de>
Date: 31 May 2001 08:52:58 +0200
In-Reply-To: <Pine.GSO.3.96.1010530190118.9456D-100000@delta.ds2.pg.gda.pl> ("Maciej W. Rozycki"'s message of "Wed, 30 May 2001 19:58:43 +0200 (MET DST)")
Message-ID: <m3ofsaau2d.fsf@D139.suse.de>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Maciej W. Rozycki" <macro@ds2.pg.gda.pl> writes:

> Hi,
> 
>  Here is the second version of the sys__test_and_set() syscall suite.  A
> glibc patch is included this time as well.
> 
>  There are two small changes to the sys__test_and_set() implementation:
> 
> 1. verify_area() is now called for the ll/sc version as well.  Otherwise
> one could pass a KSEG address and gain unauthorized access.
> 
> 2. The fuction now returns immediately without performing a write access
> if the value stored in the memory wouldn't change.  This is to avoid the
> need of a potentially costful sc operation; for consistency, this is also
> done for the non-ll/sc version. 
> 
>  The glibc patch should be fairly obvious.  There is no inline version of
> the _test_and_set() function for MIPS I anymore -- while previously it
> saved an extra stack frame just to call sysmips(), this would be pointless
> now (well, not quite as long as we fallback to sysmips(), actually, but
> that is a temporary compatibility bit that will soon get removed, I hope).
> Note that while sys__test_and_set() never returns an error, there might
> one happen if someone tries to execute the syscall running a kernel that
> does not support it.  Hence we fall back to sysmips(). 
> 
>  The official entry point is _test_and_set().  There is also the
> ___test_and_set() entry point defined, mostly for completeness for MIPS
> II+ systems, to be sure all syscalls actually have their wrappers
> exported.  Not to be used under normal circumstances, though.
> 
>  Andreas, what do you think: Should we fall back to sysmips() as in the
> following patch (at a considerable performance hit -- without the fallback
> the entire ___test_and_set() wrapper is seven instructions long) or just
> require a specific minimum kernel version bail out at the compile time if
> no __NR__test_and_set is defined?  Granted, pthreads don't run for
> MIPS/Linux for a long time, so it's possible the user base is not that
> large such an abrupt switch would be impossible.  Especially as sysmips() 
> seems to be continuously in flux for the last few months.  I assume the
> switch to the new syscall would be mandatory for glibc 2.3 in any case. 

Do it the following way:
- Define in sysdeps/unix/sysv/linux/kernel-features a new macro, e.g.
  __ASSUME_TEST_AND_SET with the appropriate guards
- Do *both* implementations like this:
#include <kernel-features.h>
#if __ASSUME_TEST_AND_SET
fast code without fallback
#else
slow code that first tries kernel call and then falls back to sysmips
#endif

This way you get the fast one if you configure glibc with
--enable-kernel=2.4.6 if we assume that 2.4.6 is the first kernel with
those features. 

Check other places in glibc for details how this can be done.

Thanks,
Andreas

>  I'm open to constructive feedback.  An open question is whether returning
> the result in v1 is clean.  I believe it is -- I haven't been convinced
> that storing the result in a memory location passed as the third argument
> is cleaner.  Certainly it's not faster and v1 is still dedicated to be a
> result register.  It's used by sys_pipe() this way, for example. 
> 
>   Maciej

-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
