Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id QAA918762 for <linux-archive@neteng.engr.sgi.com>; Fri, 9 Jan 1998 16:29:14 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id QAA12233 for linux-list; Fri, 9 Jan 1998 16:24:05 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA12225 for <linux@cthulhu.engr.sgi.com>; Fri, 9 Jan 1998 16:24:00 -0800
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id QAA03204
	for <linux@cthulhu.engr.sgi.com>; Fri, 9 Jan 1998 16:23:55 -0800
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id TAA14964
	for <linux@cthulhu.engr.sgi.com>; Fri, 9 Jan 1998 19:25:50 -0500
Date: Fri, 9 Jan 1998 19:25:50 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: RedHat 5.0 RPMs for SGI...
In-Reply-To: <34B6836E.1F366317@detroit.sgi.com>
Message-ID: <Pine.LNX.3.95.980109192020.14617A-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Fri, 9 Jan 1998, Eric Kimminau wrote:
> Alex deVries wrote:
> > Some odd problems I'm encountering:
> > - the bare system which runs nothing consumes 20MB of RAM.  I'm using
> > Ralf's 2.1.67 kernel.  Perhaps I'm reading it wrong, but 'free' gives me
> > 20MB used, 16MB which is unaccounted for.  Does this mean the kernel is
> > using 16MB? Wow. It explains the 'memory exhausted' problems I get.
> 
> Linux always reports all of your memory used. At least it always has on
> my PC at home.

I had a closer look at it, and indeed, all the memory is accounted for.
But, what I'm totally unused to is things taking up so much.  I've got
64MB in there now (although it's detected as 60248kB, it's missing 4MB).

Now I've got just the bare bones required to do anything productive:
bdflush, inetd and a couple of shells.  There goes half my memory.

For example, 'su' takes up 4.5MB.  This seems like an awful lot to me,
compared to the Intel equivalent of 1MB. I know the binaries are going to
be larger because of the RISC thing, but really that large?

Is this normal?

- Alex
