Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Dec 2002 11:14:49 +0000 (GMT)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:47359 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225218AbSLLLOt>; Thu, 12 Dec 2002 11:14:49 +0000
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id MAA18978;
	Thu, 12 Dec 2002 12:15:01 +0100 (MET)
Date: Thu, 12 Dec 2002 12:15:01 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Daniel Jacobowitz <dan@debian.org>
cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: watch exception only for kseg0 addresses..?
In-Reply-To: <20021211180135.GB14768@nevyn.them.org>
Message-ID: <Pine.GSO.3.96.1021212112807.17917A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 881
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 11 Dec 2002, Daniel Jacobowitz wrote:

> >  The watchpoints would always be interfaced the same way, regardless of
> > the underlying implementation, of course.  For the IWatch/DWatch, I'd
> > assign their numbers somehow (e.g. IWatch is watchpoint #0 and DWatch is
> > #1, following the sequence used for their CP0 register numbers).  A user
> > such as GDB would have to determine the capabilities of all watchpoints as
> > I described and would discover that watchpoint #0 only accepts instruction
> > fetch events and watchpoint #1 only accepts data read/write ones.
> > 
> >  This way we can accept an arbitrary underlying implementation.
> 
> This is what I don't like.  Setting each individual watchpoint to
> determine their capabilities, when the kernel could just _report_ said
> capabilities.  It's a difference in philosophy I suppose.  I also have

 I'm not much fond of the idea of putting such things into the kernel,
especially as this means either storing additional, rarely used data in
the kernel or querying it each time a relevant ptrace() call happens.
Essentially the kernel needs to perform the same steps that a user program
would do, except it doesn't know what the results will be used for.

 Then, what do you expect to be queried by the kernel?  You certainly want
the number of watchpoints, and the AND-mask, the OR-mask and the event
trigger capabilities for each of them.  The latter implies both which
events are supported and which events imply (or exclude?) others.  This is
a lot of data, hard to express abstractly, possibly only partially needed
by different programs.  Why shouldn't each program be able to query
whatever it is interested in? 

 Besides, it's more kernel code and you probably know that a bug in the
kernel is less forgiving than one in the userland.

> some concerns about making the probing indistinguishable from setting a

 I consider it a strength of the interface -- this way watchpoints behave
exactly as probed by user software.  Anyway why do you need these
activities to be distinguishable?  When you are writing a program, you
certainly know what your code is meant to do.  You may comment it if
unobvious.

> watchpoint; if MIPS37 or MPIS256 has a substantially different
> watchpoint layout, we'll have to give it a whole new set of ptrace ops,
> which defeats the point of abstracting it.

 What can you expect to be added?  New events are trivial -- they are
added to the "access" member.  Old software ignores them (modulo bugs) as
it doesn't try to blindly activate them.  What remains is an address and a
mask.  They're generic, generic enough, not to be processor-specific, be
it MIPS or anything else -- how can they change?  They can only extend and
if they don't fit in 64 bits anymore, we need a new interface anyway.  We
may bump the version number then (but we'll need a new Linux port first). 

> If we write up decent documentation for what a userspace implementation
> has to do to probe the current implementations, I guess I'm satisfied.

 s/has/may/ -- otherwise I can't see a problem here. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
