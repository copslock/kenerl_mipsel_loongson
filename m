Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6C1ZrRw000858
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 11 Jul 2002 18:35:53 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6C1Zq3K000857
	for linux-mips-outgoing; Thu, 11 Jul 2002 18:35:52 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (shaft18-f102.dialo.tiscali.de [62.246.18.102])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6C1ZhRw000840
	for <linux-mips@oss.sgi.com>; Thu, 11 Jul 2002 18:35:45 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g6C1eF117333;
	Fri, 12 Jul 2002 03:40:15 +0200
Date: Fri, 12 Jul 2002 03:40:15 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Sigcontext->sc_pc Passed to User
Message-ID: <20020712034015.C16608@dea.linux-mips.net>
References: <00b401c228ba$88b29bf0$10eca8c0@grendel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <00b401c228ba$88b29bf0$10eca8c0@grendel>; from kevink@mips.com on Thu, Jul 11, 2002 at 11:08:21AM +0200
X-Accept-Language: de,en,fr
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Jul 11, 2002 at 11:08:21AM +0200, Kevin D. Kissell wrote:

> In responding to an enquiry from one of MIPS' third-party
> software vendors, I noted something that seems a little
> broken to me in the current (and maybe all historical)
> MIPS/Linux kernels.  Please forgive me for opening
> old wounds if this has been beaten to death in the past.
> 
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
> 
> It is, of course, important that execution resume
> at the instruction following any instruction generating
> an exception/signal.  But that's not the same thing
> as saying that the sigcontext should report the resumption
> EPC instead of the faulting EPC.  There are various
> ways of dealing with this, but before going into any
> of them, I'm curious as to whether this has been 
> discussed before, and whether anyone thinks that 
> things really should be the way they are.

Our signal stackframe is almost the same as on IRIX5 which is what
some software expects.  Maybe time to checkout what IRIX does ...

  Ralf
