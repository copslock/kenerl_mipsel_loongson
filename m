Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id UAA12420; Fri, 13 Jun 1997 20:36:51 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id UAA29448 for linux-list; Fri, 13 Jun 1997 20:36:32 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id UAA29406; Fri, 13 Jun 1997 20:36:16 -0700
Received: from athena.nuclecu.unam.mx (athena.nuclecu.unam.mx [132.248.29.9]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id UAA09233; Fri, 13 Jun 1997 20:36:14 -0700
	env-from (miguel@athena.nuclecu.unam.mx)
Received: (from miguel@localhost)
	by athena.nuclecu.unam.mx (8.8.5/8.8.5) id WAA17152;
	Fri, 13 Jun 1997 22:12:09 -0500
Date: Fri, 13 Jun 1997 22:12:09 -0500
Message-Id: <199706140312.WAA17152@athena.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: adevries@engsoc.carleton.ca
CC: ralf@Julia.DE, lm@neteng.engr.sgi.com, ralf@mailhost.uni-koblenz.de,
        shaver@neon.ingenia.ca, linux@cthulhu.engr.sgi.com
In-reply-to: 
	<Pine.LNX.3.95.970613194626.15021G-100000@lager.engsoc.carleton.ca>
	(message from Alex deVries on Fri, 13 Jun 1997 19:51:37 -0400 (EDT))
Subject: Re: Userland loader / run time loader
X-Windows: The problem for your problem.
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


> To address the needs of us lowly folk who have fewer than 2 MIPS boxes[1],
> which endian are we going to be supporting first?  It would be _very_
> pleasant to be able to run all these binaries that Ralf has prepared. 

Some time ago, someone mentioned that making the kernel support both
big endian and little endian binaries in RISC/os consumed too much of
their time. 

The time we will spend trying to get this bloating hack into the
kernel could be easily spent on some more productive things.  

I will put together a root file system and a bunch of rpms soonish
(ie, that is, as soon as I boot my Indy into Linux).

Miguel.
