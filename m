Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id PAA14016 for <linux-archive@neteng.engr.sgi.com>; Tue, 2 Dec 1997 15:49:49 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id PAA06993 for linux-list; Tue, 2 Dec 1997 15:45:56 -0800
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA06851; Tue, 2 Dec 1997 15:45:39 -0800
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id PAA05569; Tue, 2 Dec 1997 15:45:27 -0800
Date: Tue, 2 Dec 1997 15:45:27 -0800
Message-Id: <199712022345.PAA05569@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Christian Reisch <creisch@cthulhu.engr.sgi.com>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: Linux on the O2
In-Reply-To: <34849AA8.F21FFE4E@engr.sgi.com>
References: <Pine.LNX.3.95.971202161948.10955B-100000@vertigo.cs.indiana.edu>
	<19971202231009.32146@grass.uni-koblenz.de>
	<199712022233.OAA05434@fir.engr.sgi.com>
	<34849AA8.F21FFE4E@engr.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Christian Reisch writes:
 > William J. Earl wrote:
 >       O2 is also a bigger technical problem, even with specifications in
 > hand.
 > > The drivers are actually easier than for Indy, but really exploiting the
 > > O2 capabilities in graphics and digital media required a lot of enhancements
 > > to the memory management, since O2 is a UMA system.  You could do a dumb
 > > port, with a fixed frame buffer size, but then most of the O2 is wasted.
 > 
 > 	Actually I suspect the exact opposite would happen and hence
 > management's fear.  There are ALOT more people in the linux community 
 > than we have working at SGI.  It is very concievable that if the specs
 > were
 > available linux on O2 would massively out perform irix on the O2.  This
 > would
 > be a major embarrassment to the company.  Compare and contrast as Unixes
 > Solaris X86 and Linux on a given x86 box or Digital Unix and linux on an
 > alpha.

       Many of us who want to see Linux on SGI systems expect that Linux
will be substantially faster on a number of primitive functions, especially
on uniprocessor systems.  We think of this as a nice club to persuade people
that low-level performance (a cache miss here and 100 instructions there)
really matters.  

       What I was talking about in regard to O2 was exploiting the
hardware functionality, such as the ability to use 100 MB of memory
for Photoshop, and then switch in seconds to using 100 MB of memory
for texture mapping, including real-time texture mapping of live
video.  Some of this is fairly generic library work, but some of it
requires fundamental changes to the operating system memory management
(assuming you do not impose a fixed partitioning of memory).

 > 	Quality wise free software always beats proprietary software (if for
 > no other reason than it has to make fewer concesions to release
 > schedules
 > and politics) often embarassingly so.

       That is not always the case.  It is the case for GNU and Linux
software, due to the constraints imposed on the development and release
process, which tend to keep untested changes out of the main tree.
