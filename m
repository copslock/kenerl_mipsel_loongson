Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id DAA3002526 for <linux-archive@neteng.engr.sgi.com>; Sun, 5 Apr 1998 03:47:13 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id DAA8037939
	for linux-list;
	Sun, 5 Apr 1998 03:46:40 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id DAA6975697;
	Sun, 5 Apr 1998 03:46:32 -0700 (PDT)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id DAA23532; Sun, 5 Apr 1998 03:46:30 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-10.uni-koblenz.de [141.26.249.10])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id MAA08153;
	Sun, 5 Apr 1998 12:46:28 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id MAA03920;
	Sun, 5 Apr 1998 12:06:02 +0200
Message-ID: <19980405120602.27673@uni-koblenz.de>
Date: Sun, 5 Apr 1998 12:06:02 +0200
To: "William J. Earl" <wje@fir.engr.sgi.com>
Cc: linux-mips@fnet.fr, linux-mips@vger.rutgers.edu,
        linux@cthulhu.engr.sgi.com
Subject: Re: Lmbench results for Linux/MIPS 2.1.90
References: <19980322075452.09681@uni-koblenz.de> <199803230530.VAA12819@fir.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <199803230530.VAA12819@fir.engr.sgi.com>; from William J. Earl on Sun, Mar 22, 1998 at 09:30:05PM -0800
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sun, Mar 22, 1998 at 09:30:05PM -0800, William J. Earl wrote:

>  > I'm thinking about not saving the temporary registers on syscall entry;
>  > I'm just not shure if this would break the semantics of ptrace(2).
> ...
> 
>       UMIPS-BSD (4.3 BSD on the MIPS M/1000) did not save the temporary
> registers on syscall().  It did, of course, save them on interrupts,
> so preemption left the registers valid.  I don't see why saving the
> registers on syscall should affect ptrace(), since the ptrace()
> caller is acting on another process, which will have saved all its
> registers if preempted.  That change ought to let the R5000 beat
> the Pentium, despite the Indy's miserable memory latency.

That's implemented now.  I'm also pulling another trick.  Why the hell
should be save all the s-registers during system calls?  The MIPS calling
sequence guarantees to us that they will not be destroyed.  Whoops,
another 150us or so.  It's what brought us down to 861ns, faster than
big bad Pentium from Borg.  All that it takes is adding some extra code;
sys_fork(), sys_clone() and do_signal expect the s-registers to be in
the stackframe, so I save them only in these routines.

I'm thinking about changing the calling sequence of syscalls as well.
When we get more than four arguments passed, we have to dig them out of
the userstack.  While this is fast on Linux we still need time for the
safety checks.  The t registers which are being clobbered anyway would
be sooo nice to pass them.

(Hey people, remember I told ya static linking is evil?  That change would
fry all your binaries ...  still time to relink :-)

  Ralf
