Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id JAA35831 for <linux-archive@neteng.engr.sgi.com>; Mon, 6 Apr 1998 09:37:31 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id JAA8462252
	for linux-list;
	Mon, 6 Apr 1998 09:35:55 -0700 (PDT)
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id JAA8369741
	for <linux@engr.sgi.com>;
	Mon, 6 Apr 1998 09:35:51 -0700 (PDT)
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id JAA08082; Mon, 6 Apr 1998 09:35:12 -0700
Date: Mon, 6 Apr 1998 09:35:12 -0700
Message-Id: <199804061635.JAA08082@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: ralf@uni-koblenz.de
Cc: linux-mips@fnet.fr, linux-mips@vger.rutgers.edu,
        linux@cthulhu.engr.sgi.com
Subject: Re: Lmbench results for Linux/MIPS 2.1.90
In-Reply-To: <19980405120602.27673@uni-koblenz.de>
References: <19980322075452.09681@uni-koblenz.de>
	<199803230530.VAA12819@fir.engr.sgi.com>
	<19980405120602.27673@uni-koblenz.de>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

ralf@uni-koblenz.de writes:
...
 > That's implemented now.  I'm also pulling another trick.  Why the hell
 > should be save all the s-registers during system calls?  The MIPS calling
 > sequence guarantees to us that they will not be destroyed.  Whoops,
 > another 150us or so.  It's what brought us down to 861ns, faster than
 > big bad Pentium from Borg.  All that it takes is adding some extra code;
 > sys_fork(), sys_clone() and do_signal expect the s-registers to be in
 > the stackframe, so I save them only in these routines.

     Yes, UMIPS-BSD (but not IRIX or RISC/os) did that too.  The 861 ns.
also means that you are not getting any cache misses at all, which is very
nice.  (Some systems seem to think a system call without a cache miss
is a day without sunshine.  :-) )

 > I'm thinking about changing the calling sequence of syscalls as well.
 > When we get more than four arguments passed, we have to dig them out of
 > the userstack.  While this is fast on Linux we still need time for the
 > safety checks.  The t registers which are being clobbered anyway would
 > be sooo nice to pass them.
 > 
 > (Hey people, remember I told ya static linking is evil?  That change would
 > fry all your binaries ...  still time to relink :-)

      You could or some suitable higher-order bit into the system call number
to distinguish the two cases (and mask it off in syscall before indexing
the system call table).  Since you have the system call number in a register,
that should be pretty cheap to check.

     Instead of changing the calling sequence, perhaps you could
do the fetching in a special assembly subroutine, and have the trap
handler notice if $epc is in the routine at the instruction which fetches
from the user space.  If so, it could change $epc to some recovery address
in the assembly routine, which would return the fault indication.
(There would probably be multiple load instructions in a fully
unrolled routine, but that would just be more locations to accept 
as valid exception points.)  This takes cycles out of the normal
path, at the cost of cycles in the trap path (for kernel traps only,
and then only for cases which are going to turn into EFAULT anyway).


	
