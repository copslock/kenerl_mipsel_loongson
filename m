Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6CFPNRw006716
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 12 Jul 2002 08:25:23 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6CFPNAP006715
	for linux-mips-outgoing; Fri, 12 Jul 2002 08:25:23 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (shaft16-f41.dialo.tiscali.de [62.246.16.41])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6CFPDRw006706
	for <linux-mips@oss.sgi.com>; Fri, 12 Jul 2002 08:25:14 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g6CFTkM19542;
	Fri, 12 Jul 2002 17:29:46 +0200
Date: Fri, 12 Jul 2002 17:29:46 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Sigcontext->sc_pc Passed to User
Message-ID: <20020712172946.B18691@dea.linux-mips.net>
References: <00b401c228ba$88b29bf0$10eca8c0@grendel> <20020712034015.C16608@dea.linux-mips.net> <003301c2297a$380ed400$10eca8c0@grendel> <20020712120024.A20727@dea.linux-mips.net> <008e01c2299a$3268da30$10eca8c0@grendel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <008e01c2299a$3268da30$10eca8c0@grendel>; from kevink@mips.com on Fri, Jul 12, 2002 at 01:49:15PM +0200
X-Accept-Language: de,en,fr
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Jul 12, 2002 at 01:49:15PM +0200, Kevin D. Kissell wrote:

> Whenever it's been my design responsibility, I made forks fail if
> there wasn't enough backing store to handle the process.  Frankly,
> there are limits to the degree to which an OS should compromise
> its integrity for the sake of supporting badly concieved applications,
> be they Mozilla or the SGI integrated CAD environment.  But
> even if you prefer to take the "speculative" or "optimistic" model
> for handling the situation, what IRIX did was insane:  When, after
> having allowed too many unsupportable forks to succeed, they
> detected deadlock in the swap system, they killed processes
> *at random*.  Including system daemons.  At a *minimum*,
> a system should only terminate processes belonging to the
> user (and preferably the process group) who has been granted
> speculative fork success.  Anything else is a massive "breach of
> contract" for a multiuser OS.

See linux/mm/oom_kill.c:oom_kill() ...

> IMHO, if someone really wanted to fix this in the OS, 
> we'd get beyond the traditional Unix "fork" model.  
> And if someone really wanted to avoid the problem in Mozilla or 
> an IDE, one would have all subprograms launched by a tiny 
> "launcher", who would recieve instructions and data via some 
> form of IPC, fork itself, and exec as appropriate.

That or more Linux specific a clone/vfork & exec approach.

> But this is getting a bit off the topic.  Is anyone aware of any
> IRIX applications ported to Linux that would break if we
> corrected the signal payload semantics?

As I said we even missimplemented the IRIX semantics.  In IRIX the
sc_pc field of the frame is pointing to the instruction that was causing
the signal while we try to skip over it - with all the side effects that
we're just discussing.  I tried that for both trap and break instructions.

So I suggest we simply remove the compute_return_epc() calls from do_bp
and do_trap.  I haven't tested this but I'd assume this would also be
the behaviour that gdb is expecting.  So that would follow the example
given by Linux/i386 and IRIX and should your ISV's problem.  What more could
we ask for.

I still have to look over the other exceptions that may call
compute_return_epc() but it seems we should do the same thing for all
of them and not call compute_return_epc if we're going to send a signal.

  Ralf
