Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA22308; Fri, 30 May 1997 14:01:32 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id IAA13994 for linux-list; Fri, 30 May 1997 08:20:29 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id IAA13722 for <linux@relay.engr.SGI.COM>; Fri, 30 May 1997 08:18:25 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id IAA05371
	for <linux@relay.engr.SGI.COM>; Fri, 30 May 1997 08:18:03 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61]) by informatik.uni-koblenz.de (8.8.5/8.6.9) with SMTP id RAA23721; Fri, 30 May 1997 17:13:55 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199705301513.RAA23721@informatik.uni-koblenz.de>
Received: by thoma (SMI-8.6/KO-2.0)
	id RAA17406; Fri, 30 May 1997 17:13:53 +0200
Subject: Re: userland cometh
To: adevries@engsoc.carleton.ca (Alex deVries)
Date: Fri, 30 May 1997 17:13:52 +0200 (MET DST)
Cc: shaver@neon.ingenia.ca, ralf@mailhost.uni-koblenz.de,
        linux@cthulhu.engr.sgi.com
In-Reply-To: <Pine.LNX.3.95.970530105637.10806A-100000@lager.engsoc.carleton.ca> from "Alex deVries" at May 30, 97 11:02:49 am
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

> > Actually, I think it'll be my cohort Alex who'll be building most of
> > them.  He likes RPM in a way that's a little frightening (hi, Alex!). =)
> 
> I am, yes, sitting on the edge of my seat for Mike to get the network
> working so I can have access to the machine.  Mike's working on the
> network now to stop my endless pestering.
> 
> The priority will be getting rpm itself to compile properly, although I
> don't anticipate any huge problems.  I just need to tell it that
> Linux/mips exists, I suspect.

This and another one or two minor patches were required to make rpm
build on my machine.

> There's a large lump of joy in knowing that gcc/libc etc work properly.
> The rest is easy.

Trying to build and use a distribution will help us alot to find the bugs.

> > I can imagine.  I'm not looking to be a distribution (yet). =)
> 
> I suspect if we do a good enough job of porting the bulk of the RPMS that
> RedHat will take the effort seriously.  There'll be a lot of RPMs to port,
> though... 

Most of the changes we need to do are already covered by some other patch
files in the SRPMs.  For example many packages already contain GNU libc
patches; in some packages the GNU libc patches are disguised as Alpha
patches.  And GNU libc patches are 90% of what we need to patch.

  Ralf
