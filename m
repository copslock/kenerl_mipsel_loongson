Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5PDnmnC021508
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 25 Jun 2002 06:49:48 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5PDnmeF021507
	for linux-mips-outgoing; Tue, 25 Jun 2002 06:49:48 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5PDnYnC021504;
	Tue, 25 Jun 2002 06:49:35 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA03117;
	Tue, 25 Jun 2002 15:53:25 +0200 (MET DST)
Date: Tue, 25 Jun 2002 15:53:25 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Carsten Langgaard <carstenl@mips.com>
cc: Ralf Baechle <ralf@oss.sgi.com>,
   "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: LTP testing
In-Reply-To: <3D186E76.63B33B0E@mips.com>
Message-ID: <Pine.GSO.3.96.1020625154306.29623G-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 25 Jun 2002, Carsten Langgaard wrote:

> The next LTP failure line is:
> pipe05      1  BROK  :  Unexpected signal 11 received.
> 
> For this one I haven't got a fix, because the failure is due to the way
> the pipe syscall is implemented for MIPS (so we need a fix in both the
> kernel and glibc).
> 
> The glibc code look like this
> SYSCALL__ (pipe, 1)
>         /* Plop in the two descriptors.  */
>         sw v0, 0(a0)
>         sw v1, 4(a0)
> 
>         /* Go out with a clean status.  */
>         move v0, zero
>         j ra
>         .end __pipe
> 
> The problem is that the code is called with $a0 = 0. So the 'sw v0,
> 0(a0)' after the syscall generates a segmentation fault.

 The test is broken and it's what should be fixed, instead -- several
Linux platforms do it this way, e.g. Alpha and IA-64.  A SIGSEGV is a
valid response for an invalid address.  Remember you test pipe(3) and not
pipe(2). 

> Why are the pipe syscall implemented this way, where we return the two
> descriptors in v0 and v1 ?

 For performance reasons.  Also it's safer to do such actions from the
userland.

> Why doesn't the kernel do these stores (this way we can do an access
> check, like i386 does) ?

 I suppose i386 does these stores in the kernel due to historical reasons. 
There is also the problem of a permanent lack of registers in i386 -- I
haven't investigated it, but it may simply be unable to afford a second
result register.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
