Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA05545; Fri, 13 Jun 1997 18:54:50 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id SAA15515 for linux-list; Fri, 13 Jun 1997 18:54:26 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA15500; Fri, 13 Jun 1997 18:54:24 -0700
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id SAA20113; Fri, 13 Jun 1997 18:54:22 -0700
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
          by lager.engsoc.carleton.ca (8.8.5/8.8.4) with SMTP
	  id TAA20275; Fri, 13 Jun 1997 19:51:37 -0400
Date: Fri, 13 Jun 1997 19:51:37 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Ralf Baechle <ralf@Julia.DE>
cc: lm@neteng.engr.sgi.com, ralf@mailhost.uni-koblenz.de,
        shaver@neon.ingenia.ca, linux@cthulhu.engr.sgi.com
Subject: Re: Userland loader / run time loader
In-Reply-To: <199706132329.BAA06504@kernel.panic.julia.de>
Message-ID: <Pine.LNX.3.95.970613194626.15021G-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Sat, 14 Jun 1997, Ralf Baechle wrote:
> Alex wrote:
> > As written on this list earlier, we don't have bi-endian support.  So,
> > which one is it we're going to support to begin with? How is it that Ralf
> > is able to execute LSB binaries?
> > Am I missing something big?
> 
> {\grin[evil] Because I've got four types of MIPS boxes running Linux at
> home and to two more I've got access.}

To address the needs of us lowly folk who have fewer than 2 MIPS boxes[1],
which endian are we going to be supporting first?  It would be _very_
pleasant to be able to run all these binaries that Ralf has prepared. 

Also, exactly how difficult is it to alternate the kernel between big and
little endian? 

This is getting cooler by the minute...

[1] In my case, 0, but access network access to 1.

- Alex
