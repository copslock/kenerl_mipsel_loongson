Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6CBidRw019460
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 12 Jul 2002 04:44:39 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6CBidEf019459
	for linux-mips-outgoing; Fri, 12 Jul 2002 04:44:39 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (ftp.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6CBiTRw019450;
	Fri, 12 Jul 2002 04:44:29 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g6CBmxXb015987;
	Fri, 12 Jul 2002 04:49:00 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id EAA03764;
	Fri, 12 Jul 2002 04:48:58 -0700 (PDT)
Message-ID: <008e01c2299a$3268da30$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Ralf Baechle" <ralf@oss.sgi.com>
Cc: <linux-mips@oss.sgi.com>
References: <00b401c228ba$88b29bf0$10eca8c0@grendel> <20020712034015.C16608@dea.linux-mips.net> <003301c2297a$380ed400$10eca8c0@grendel> <20020712120024.A20727@dea.linux-mips.net>
Subject: Re: Sigcontext->sc_pc Passed to User
Date: Fri, 12 Jul 2002 13:49:15 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

From: "Ralf Baechle" <ralf@oss.sgi.com>
> On Fri, Jul 12, 2002 at 10:00:27AM +0200, Kevin D. Kissell wrote:
> 
> > The IRIX team made some stunningly bad design 
> > decisions over the years, my favorite being "virtual
> > swap space" and its side effect of deliberately killing 
> > system daemons at random under load.  A signal scheme
> > such as we have now in MIPS/Linux, where a user program
> > *cannot* identify the instruction causing a signal if
> > that instruction was in the delay slot of a taken branch,
> > is broken from first principles.
> 
> Certainly you're right when you say a signal handler show know which
> instruction was causing a fault.  Ours is simply a too bad implementation
> of their interface ...
> 
> IRIX virtual swap space is simply memory overcommit.  Linux has that too
> and it's been subject to frequent religious discussions on Linux kernel.
> Non-overcommit means large amounts of memory are required when forking
> of a new process.  The standard example is a fat bloated Mozilla forking
> for printing.  Non-overcommit means you need those 50 or 100 megs of
> Mozilla process size once more and if not as physical memory then at
> least as swap space.  Deciede yourself if you're paranoid and want that
> operation to only succeed if that much memory is actually available or
> if you take the risk of the fork & exec operation failing the other way.

Whenever it's been my design responsibility, I made forks fail if
there wasn't enough backing store to handle the process.  Frankly,
there are limits to the degree to which an OS should compromise
its integrity for the sake of supporting badly concieved applications,
be they Mozilla or the SGI integrated CAD environment.  But
even if you prefer to take the "speculative" or "optimistic" model
for handling the situation, what IRIX did was insane:  When, after
having allowed too many unsupportable forks to succeed, they
detected deadlock in the swap system, they killed processes
*at random*.  Including system daemons.  At a *minimum*,
a system should only terminate processes belonging to the
user (and preferably the process group) who has been granted
speculative fork success.  Anything else is a massive "breach of
contract" for a multiuser OS.

IMHO, if someone really wanted to fix this in the OS, 
we'd get beyond the traditional Unix "fork" model.  
And if someone really wanted to avoid the problem in Mozilla or 
an IDE, one would have all subprograms launched by a tiny 
"launcher", who would recieve instructions and data via some 
form of IPC, fork itself, and exec as appropriate.

But this is getting a bit off the topic.  Is anyone aware of any
IRIX applications ported to Linux that would break if we
corrected the signal payload semantics?

            Kevin K.
