Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4VJL0X00984
	for linux-mips-outgoing; Thu, 31 May 2001 12:21:00 -0700
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f4VJKgh00954
	for <linux-mips@oss.sgi.com>; Thu, 31 May 2001 12:20:42 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA00913
	for <linux-mips@oss.sgi.com>; Thu, 31 May 2001 12:20:41 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f4VJDr014020;
	Thu, 31 May 2001 12:13:53 -0700
Message-ID: <3B1697BE.3F3765A2@mvista.com>
Date: Thu, 31 May 2001 12:13:02 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Jaeger <aj@suse.de>
CC: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com, Ralf Baechle <ralf@uni-koblenz.de>
Subject: Re: [patch] RFC: A sys__test_and_set() implementation, 2nd iteration
References: <Pine.GSO.3.96.1010530190118.9456D-100000@delta.ds2.pg.gda.pl> <m3ofsaau2d.fsf@D139.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Andreas Jaeger wrote:
> 
> "Maciej W. Rozycki" <macro@ds2.pg.gda.pl> writes:
> 
> > Hi,
> >
> >  Here is the second version of the sys__test_and_set() syscall suite.  A
> > glibc patch is included this time as well.
> >
> >  There are two small changes to the sys__test_and_set() implementation:
> >
> > 1. verify_area() is now called for the ll/sc version as well.  Otherwise
> > one could pass a KSEG address and gain unauthorized access.
> >
> > 2. The fuction now returns immediately without performing a write access
> > if the value stored in the memory wouldn't change.  This is to avoid the
> > need of a potentially costful sc operation; for consistency, this is also
> > done for the non-ll/sc version.
> >
> >  The glibc patch should be fairly obvious.  There is no inline version of
> > the _test_and_set() function for MIPS I anymore -- while previously it
> > saved an extra stack frame just to call sysmips(), this would be pointless
> > now (well, not quite as long as we fallback to sysmips(), actually, but
> > that is a temporary compatibility bit that will soon get removed, I hope).
> > Note that while sys__test_and_set() never returns an error, there might
> > one happen if someone tries to execute the syscall running a kernel that
> > does not support it.  Hence we fall back to sysmips().
> >
> >  The official entry point is _test_and_set().  There is also the
> > ___test_and_set() entry point defined, mostly for completeness for MIPS
> > II+ systems, to be sure all syscalls actually have their wrappers
> > exported.  Not to be used under normal circumstances, though.
> >
> >  Andreas, what do you think: Should we fall back to sysmips() as in the
> > following patch (at a considerable performance hit -- without the fallback
> > the entire ___test_and_set() wrapper is seven instructions long) or just
> > require a specific minimum kernel version bail out at the compile time if
> > no __NR__test_and_set is defined?  Granted, pthreads don't run for
> > MIPS/Linux for a long time, so it's possible the user base is not that
> > large such an abrupt switch would be impossible.  Especially as sysmips()
> > seems to be continuously in flux for the last few months.  I assume the
> > switch to the new syscall would be mandatory for glibc 2.3 in any case.
> 
> Do it the following way:
> - Define in sysdeps/unix/sysv/linux/kernel-features a new macro, e.g.
>   __ASSUME_TEST_AND_SET with the appropriate guards
> - Do *both* implementations like this:
> #include <kernel-features.h>
> #if __ASSUME_TEST_AND_SET
> fast code without fallback
> #else
> slow code that first tries kernel call and then falls back to sysmips
> #endif
> 
> This way you get the fast one if you configure glibc with
> --enable-kernel=2.4.6 if we assume that 2.4.6 is the first kernel with
> those features.
> 
> Check other places in glibc for details how this can be done.
> 

This might be an overkill - the slow code on a newer kernel costs about 1 or 2
cycle longer per call.


> >  I'm open to constructive feedback.  An open question is whether returning
> > the result in v1 is clean.  I believe it is -- I haven't been convinced
> > that storing the result in a memory location passed as the third argument
> > is cleaner.  Certainly it's not faster and v1 is still dedicated to be a
> > result register.  It's used by sys_pipe() this way, for example.

On a second thought I feel stronger using $v1 is not a good idea - what if the
return path of syscall suddenly needs to modify $v1?  Also we have generic
syscall routine in glibc, what if someday that routine starts to check $v1 as
well?

I understand the chances of these "what if" are low (and perhaps sys_pipe() is
already this way), but I am still convinced we should the right thing. 
(Whoever invented MIPS_ATOMIC_SET might have been thinking it should never
need to return an error code!)

I don't see any "dirtiness" in using the third argument.  The slowdown in
performance should be negligible under the context of the whole system call.

A syscall is invented to be here and stay.  I personally feel more comfortable
to play a little safer rather than a littel faster.

Jun
