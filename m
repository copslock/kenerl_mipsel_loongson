Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f51CiUK15339
	for linux-mips-outgoing; Fri, 1 Jun 2001 05:44:30 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f51Cegh15045
	for <linux-mips@oss.sgi.com>; Fri, 1 Jun 2001 05:44:20 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA29071;
	Fri, 1 Jun 2001 13:55:12 +0200 (MET DST)
Date: Fri, 1 Jun 2001 13:55:12 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
cc: Andreas Jaeger <aj@suse.de>, linux-mips@fnet.fr, linux-mips@oss.sgi.com,
   Ralf Baechle <ralf@uni-koblenz.de>
Subject: Re: [patch] RFC: A sys__test_and_set() implementation, 2nd iteration
In-Reply-To: <3B1697BE.3F3765A2@mvista.com>
Message-ID: <Pine.GSO.3.96.1010601133253.26484A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 31 May 2001, Jun Sun wrote:

> > This way you get the fast one if you configure glibc with
> > --enable-kernel=2.4.6 if we assume that 2.4.6 is the first kernel with
> > those features.
> >
> > Check other places in glibc for details how this can be done.
> 
> This might be an overkill - the slow code on a newer kernel costs about 1 or 2
> cycle longer per call.

 Do you realize how often the call is invoked!?  There is a number of
memory stores involved in the slow implementation -- with write-trough
cache it really sucks, even more than memory accesses in general. 

> On a second thought I feel stronger using $v1 is not a good idea - what if the
> return path of syscall suddenly needs to modify $v1?  Also we have generic
> syscall routine in glibc, what if someday that routine starts to check $v1 as
> well?

 We are safe here.  V1 is a result register so its semantics must be
preserved if at all possible.  Then there is the pipe() syscall that
already makes use of v1 as a result register for a long time, so we are
really, really safe. 

 There are t* registers available for the syscall handler if an additional
register is needed.  The coding conventions are there for a reason, aren't
they? 

> I understand the chances of these "what if" are low (and perhaps sys_pipe() is
> already this way), but I am still convinced we should the right thing. 
> (Whoever invented MIPS_ATOMIC_SET might have been thinking it should never
> need to return an error code!)

 Nope -- the problem lies elsewhere.  It is sysmips() that was invented to
return an error code and MIPS_ATOMIC_SET violating it from the day #1.  It
was plain broken since the beginning.  I suppose it ws just an ad hoc hack
written once someone realized the operation is necessary.  Just like the
whole sysmips() syscall. 

> I don't see any "dirtiness" in using the third argument.  The slowdown in
> performance should be negligible under the context of the whole system call.

 I do believe good performance is the main goal here.  The syscall is as
clean as possible -- it would still be possible to make it yet faster if
dirty hacks were added.

> A syscall is invented to be here and stay.  I personally feel more comfortable
> to play a little safer rather than a littel faster.

 Cycles sum up, unfortunately.  A strace of `ls -la' on my /usr/lib
directory shows about 4500 syscall invocations of which about 4000 are
invocations of _test_and_set()!

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
