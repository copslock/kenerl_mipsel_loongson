Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id FAA609217 for <linux-archive@neteng.engr.sgi.com>; Sat, 29 Nov 1997 05:29:17 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id FAA27963 for linux-list; Sat, 29 Nov 1997 05:24:29 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id FAA27958 for <linux@cthulhu.engr.sgi.com>; Sat, 29 Nov 1997 05:24:23 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id FAA05532
	for <linux@cthulhu.engr.sgi.com>; Sat, 29 Nov 1997 05:24:22 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (ralf@pmport-30.uni-koblenz.de [141.26.249.30])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id OAA04397
	for <linux@cthulhu.engr.sgi.com>; Sat, 29 Nov 1997 14:24:20 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id OAA19417;
	Sat, 29 Nov 1997 14:20:52 +0100
Message-ID: <19971129142051.36299@uni-koblenz.de>
Date: Sat, 29 Nov 1997 14:20:51 +0100
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: Bintuils
References: <19971129054928.36122@uni-koblenz.de> <Pine.LNX.3.95.971129004253.21890A-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
In-Reply-To: <Pine.LNX.3.95.971129004253.21890A-100000@lager.engsoc.carleton.ca>; from Alex deVries on Sat, Nov 29, 1997 at 12:49:33AM -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sat, Nov 29, 1997 at 12:49:33AM -0500, Alex deVries wrote:

> On Sat, 29 Nov 1997 ralf@uni-koblenz.de wrote:
> > On Fri, Nov 28, 1997 at 10:51:47PM -0500, Alex deVries wrote:
> > > libc and glibc binary RPMs would be appreciated. How about gcc and
> > > binutils for big endian as well?
> > I'll upload them rsn.  Just give some more days.  My next upload will
> > probably again be 100mb or so, that takes a while to compile.  Also I
> 
> Cool!  Now that things are working a bit better on my box, I'm a little
> more eager to get things running smoothly.

I just started rebuilding libc.  Boy, I didn't know that the last published
version of libc was that buggy.  *grin innocent*

> > > Does anyone have an editor?  It's a bit of a pain to have to FTP things
> > > over to my i386 box, change, and re-FTP.
> > I'm pretty shure that I put a tarball with Elvis and several rpms with
> > other editors on Linus.
> 
> Uh, could you let me know where?  I couldn't find either. The only RPMs
> are ed(no, please, don't make me)  and the broken version of joe.

Also to be released: Eeekmacs 19.34 tty and X version.

> I've had SRPMs of RedHat 5.0 (Hurricane) for a couple of days, so when I
> get my build system running well, it'll churn out the upgraded RPMs.
> Having compiled a few things this evening, I can tell you it'll take a
> long time.  The 4600 isn't as fast as I'd thought.

I can't get rid of the feeling that performancewise something is very wrong 
with the Indy code.  My R4600 box feels faster than the R5000 Indy.

  Ralf
