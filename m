Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id FAA3020967 for <linux-archive@neteng.engr>; Sun, 5 Apr 1998 05:47:26 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id FAA8060599
	for linux-list;
	Sun, 5 Apr 1998 05:45:56 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id FAA7987772
	for <linux@engr.sgi.com>;
	Sun, 5 Apr 1998 05:45:54 -0700 (PDT)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id FAA07220
	for <linux@engr.sgi.com>; Sun, 5 Apr 1998 05:45:53 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-26.uni-koblenz.de [141.26.249.26])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id OAA11320
	for <linux@engr.sgi.com>; Sun, 5 Apr 1998 14:45:50 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id OAA04471;
	Sun, 5 Apr 1998 14:42:34 +0200
Message-ID: <19980405144233.16881@uni-koblenz.de>
Date: Sun, 5 Apr 1998 14:42:33 +0200
To: linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com,
        linux-mips@vger.rutgers.edu
Subject: Re: Lmbench results for Linux/MIPS 2.1.90
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
Date: Sun, 5 Apr 1998 14:34:10 +0200
In-Reply-To: <199804051115.MAA00275@gladsmuir.algor.co.uk>; from Dominic Sweetman on Sun, Apr 05, 1998 at 12:15:22PM +0100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sun, Apr 05, 1998 at 12:15:22PM +0100, Dominic Sweetman wrote:

> ralf@uni-koblenz.de (ralf@uni-koblenz.de) writes:
> 
> > I'm thinking about changing the calling sequence of syscalls as well.
> > When we get more than four arguments passed, we have to dig them out of
> > the userstack.
> 
> Someone else mentioned n32/64; these new SGI standards pass up to 8
> arguments in registers.
> 
> Making syscalls different from all other function calls would be kind
> of a kludge.

Syscalls already are different from other calls.  Linux handles them exactly
the same as RISC/os or IRIX.  Four arguments passed in a0 - a3, the syscall
number in v0 and the result is being returned in v0 and an error flag in a3.
Some syscalls even cannot be reasonably be called from a user context, for
example clone(2), ptrace(2), sigreturn(2); they do require special wrappers
due to the nature of what they're doing.

The problem with the argument passing convention is the case when we have
more than 4 arguments.  In that special case we need to get the additional
arguments from the userstack.  Which again - especially for Linux 2.0 was
_very_ expensive because the user stackpointer had to be verified - user might
try to fool the kernel like ``li sp, -1, syscall''.  Still the special
handling for stackargs produces a certain overhead and passing all arguments
in registers would solve that.  The newer calling conventions are essentially
nothing else than I was suggesting above; they are using temporary registers
$t4 - $t7 as the additional argument registers $ta0 - $ta3.

I don't consider the fact that this would introduce another calling
convention for syscall arguments to be very relevant, let alone kludgy.  In
fact things would look nicer that way, no more stack arguments (no syscall has
more than 6 args) and the argument passing convention would allow for the
same syscall handler to be user for all user programs - no matter wether
they are 32 bit or future n32 and 64 bit code.  Only the binary compatibility
for IRIX would need some special treatment.  Even better, the whole matter can
be dealt with in a matter that is invisible to users - as long as no static
linked code is involved.  And it can be done slowly such that nothing of
importance breaks.

  Ralf
