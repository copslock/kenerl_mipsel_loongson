Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6BDCsRw030136
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 11 Jul 2002 06:12:54 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6BDCsJp030135
	for linux-mips-outgoing; Thu, 11 Jul 2002 06:12:54 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6BDCiRw030124
	for <linux-mips@oss.sgi.com>; Thu, 11 Jul 2002 06:12:45 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA11339;
	Thu, 11 Jul 2002 15:17:47 +0200 (MET DST)
Date: Thu, 11 Jul 2002 15:17:47 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Kevin D. Kissell" <kevink@mips.com>
cc: linux-mips@oss.sgi.com
Subject: Re: Sigcontext->sc_pc Passed to User
In-Reply-To: <00b401c228ba$88b29bf0$10eca8c0@grendel>
Message-ID: <Pine.GSO.3.96.1020711132652.7876D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 11 Jul 2002, Kevin D. Kissell wrote:

> In responding to an enquiry from one of MIPS' third-party
> software vendors, I noted something that seems a little
> broken to me in the current (and maybe all historical)
> MIPS/Linux kernels.  Please forgive me for opening
> old wounds if this has been beaten to death in the past.

 :-/

> When a user catches a signal, such as SIGBUS, the
> signal "payload" includes a pointer to a sigcontext
> structure on the stack, containing the state of the
> CPU when the exception associated with the signal
> occurred.  But not exactly.  We seem to consistently
> call compute_return_epc() before send_sig() or
> force_sig().  This results in the user being passed
> an indication of the faulting PC that is one instruction
> past the true location.  That would be no problem,
> except that the faulting instruction may have been 
> in a branch delay slot, such that there is no practical
> and reliable way for the signal handler to determine
> which instruction failed on the basis of the sigcontext
> data.

 That needs to be done globally, once and forever for all kinds of signals
passed to a program.  I have partial fixes that I am using privately
already, but a complete solution is on my to-do list. 

> It is, of course, important that execution resume
> at the instruction following any instruction generating
> an exception/signal.  But that's not the same thing
> as saying that the sigcontext should report the resumption
> EPC instead of the faulting EPC.  There are various
> ways of dealing with this, but before going into any
> of them, I'm curious as to whether this has been 
> discussed before, and whether anyone thinks that 
> things really should be the way they are.

 I believe the resumption should happen with EPC unmodified.  A handler
may set EPC differently if it wants (possibly with longjmp() or by
interpreting code at EPC and modifying EPC appropriately).  For the three
signal handling possibilities, I'd do that as follows (assuming SIGBUS,
SIGSEGV, etc. lethal signals): 

- SIG_IGN: return to EPC with no action.  A program will loop
  indefinitely, but if that's what a user wants...

- SIG_DFL: kill.

- HANDLER: call a handler with the signal context unmodified and let the
  user code decide what to do.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
