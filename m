Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id OAA01250 for <linux-archive@neteng.engr.sgi.com>; Tue, 2 Dec 1997 14:14:27 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id OAA04174 for linux-list; Tue, 2 Dec 1997 14:10:30 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA04141 for <linux@cthulhu.engr.sgi.com>; Tue, 2 Dec 1997 14:10:20 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id OAA10594
	for <linux@cthulhu.engr.sgi.com>; Tue, 2 Dec 1997 14:10:18 -0800
	env-from (ralf@mailhost.uni-koblenz.de)
Received: from grass (ralf@grass.uni-koblenz.de [141.26.4.65])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with SMTP id XAA02026;
	Tue, 2 Dec 1997 23:10:16 +0100 (MET)
Received: by grass (SMI-8.6/KO-2.0)
	id XAA00792; Tue, 2 Dec 1997 23:10:10 +0100
Message-ID: <19971202231009.32146@grass.uni-koblenz.de>
Date: Tue, 2 Dec 1997 23:10:09 +0100
From: Ralf Baechle <ralf@uni-koblenz.de>
To: cypher <cypher@vertigo.cs.indiana.edu>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: Linux on the O2
References: <Pine.LNX.3.95.971202161948.10955B-100000@vertigo.cs.indiana.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.84e
In-Reply-To: <Pine.LNX.3.95.971202161948.10955B-100000@vertigo.cs.indiana.edu>; from cypher on Tue, Dec 02, 1997 at 04:50:40PM -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Dec 02, 1997 at 04:50:40PM -0500, cypher wrote:

> I've been looking for some information to start working on an O2 port and
> have basically gotten the response that managmement at SGI is not willing
> to release hardware specs for the O2 (a mistake IMHO). Don't get me wrong
> I think it's great that they allowed the Indy hardware specs to go out the
> door, even if in a limitied fashion. 

Yes, I think the way we will have to go is to demonstrate success of the Linux
port to the Indy.  If Linux on the Indy is a success then future projects
will be alot easier.

> (I ran into the same problem with a Nintendo, but don't you agree that the
>  64 would make a great little "Network Computer"?)

The 4mb RAM or so that the N64 has are almost rediculous in context of a
real operating system ...

> Certain organizations within the school, who run anything from O2s to
> Octanes, to a Cave/Reallity Enginge, and an Origin 2000 (ok that
> probably gave away who I was talking about) are considering Linux on
> high-end Intel boxes as a inexpensive replacement for a $6000 dollar O2
> running IRIX. I think this is partly due to the added cost of OS licenses
> and various other software packages they have to pay for. It would be
> ashamed if SGI lost a share of it's hardware sales (even if it is
> the only in workstation market) market becasue some freeware wasn't
> available to run on it. 

The sad thing is many people see NT as the solution of this problem ...

> I realize that SGI has a vested interest in seeing IRIX succeed, and IRIX
> is probably (it hurts to say this) better than Linux when running 128 (or
> soon 4096) CPUs. Linux however, is great lightweight OS for workstations
> especially. There's even more value added to am SGI running Linux that can
> be introduced into an evironment where multiple high-preformance platform
> type are desired (ie, Sparcs, Ultras, Alphas, SGIs. HPs, etc.) but a
> single operating platform is needed. 

Indeed, you're right and the ambiguousity of the aim IRIX has to solve is
what makes the chance for Linux.

> This makes perfect sense to me, but I don't know if I'm explaining
> everything in the most effecient manner. I'd be _extremely_ happy to
> discuss this with someone, especially people from SGI that have some sort
> of influence on getting us the specs we need.

Actually aside of the Linux developers like me there are also SGI engineers
interested in Linux as well as some ties on this list, so posting here was
a right thing to do.

I can well imagine that way can be found under which an O2 port could become
reality.  It's probably most important that customers (== $$$) ask for Linux
for their boxes and that word has to spread upto the higher managment.

> Right now I am basically in position (not officially supported by the
> university of course, but there not telling me not to do it either, if you
> know what I mean) where I've been given and Indy and an O2 to work on
> porting Linux while on the clock.

I suggest to work on the Indy.  There is Indy code that just needs a bit of
polishing and debugging, but essentially we're relativly close.  Working for
the O2 would mean that you'll aside of a bigger technical task you'll also
have to solve a political problem.

  Ralf
