Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id PAA42325 for <linux-archive@neteng.engr.sgi.com>; Sun, 25 Jan 1998 15:48:42 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id PAA09418 for linux-list; Sun, 25 Jan 1998 15:48:05 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA09414 for <linux@cthulhu.engr.sgi.com>; Sun, 25 Jan 1998 15:48:04 -0800
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id PAA16811
	for <linux@cthulhu.engr.sgi.com>; Sun, 25 Jan 1998 15:47:54 -0800
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id SAA07216;
	Sun, 25 Jan 1998 18:48:25 -0500
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Sun, 25 Jan 1998 18:48:24 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: ralf@uni-koblenz.de
cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: Console problems...
In-Reply-To: <19980125193250.63007@uni-koblenz.de>
Message-ID: <Pine.LNX.3.95.980125184256.2472A-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Sun, 25 Jan 1998 ralf@uni-koblenz.de wrote:
> On Wed, Jan 21, 1998 at 06:49:28PM -0500, Alex deVries wrote:
> > Okay. I have a self-compiled kernel (like the vmlinux 2.1.72 kernel that
> > is on linus), and it actually boots fine for me.  The problem is that it
> > doesn't display the bootup.  The console output starts at the "INIT..."
> > line.
> > 
> > Any ideas?
> 
> Sounds like configured for serial console?

Yeah, that is the problem.  The reason I had to turn serial console on in
the first place was because of symbols being required in console.c. There
were a couple of other unpleasant dependancies there that I've fixed.
I'll upload those changes to the CVS soon.

I'm also working on fixing root device support.

Are there any plans to bring us up to 2.1.81?  I might think of taking
that on if nobody else is going to.

- Alex
