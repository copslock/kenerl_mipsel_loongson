Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id GAA00754; Fri, 20 Jun 1997 06:40:03 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id GAA08988 for linux-list; Fri, 20 Jun 1997 06:38:39 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id GAA08978; Fri, 20 Jun 1997 06:38:33 -0700
Received: from shire.ontko.com (shire.ontko.com [199.164.165.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id GAA04405; Fri, 20 Jun 1997 06:38:30 -0700
	env-from (todds@ontko.com)
Received: from localhost (todds@localhost)
	by shire.ontko.com (8.8.5/8.8.5) with SMTP id IAA15376;
	Fri, 20 Jun 1997 08:42:47 -0500
Date: Fri, 20 Jun 1997 08:42:47 -0500 (EST)
From: Todd Shrider <todds@ontko.com>
To: William Fisher <fisher@hollywood.engr.sgi.com>
cc: Larry McVoy <lm@neteng.engr.sgi.com>, sca@refugee.engr.sgi.com,
        carlson@heaven.newport.sgi.com, linux@cthulhu.engr.sgi.com
Subject: Re: Getting X on Linux/SGI
In-Reply-To: <199706200855.BAA14655@hollywood.engr.sgi.com>
Message-ID: <Pine.LNX.3.95q.970620082252.15269C-100000@shire.ontko.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk



My take on things:

On Fri, 20 Jun 1997, William Fisher wrote:

> 	If the demand for Linux on MIPS chips is comming from the "embedded"
> 	systems then things sure have changed since the early days of
> 	MIPS Computer Systems. The embedded market in 1992-1996 was
> 	NOT asking us for Linux, since it was very sensitive to running
> 	small real-time kernels. In fact nearly all of the original
> 	chips vendors who licensed the chips used the PROM code, remote
> 	dbx, compilers, etc. which were sold/licensed to the chip vendors
> 	for resell to the embedded customers.

OK, point taken, but I think that the definition of an embeded system HAS
changed draticly from five years ago. Then you were thinking chips in
cars, elevators, etc, etc, etc. Probably, at the time, the most kerenl
heavy processes were running on chips in smart houses and there weren't a
whole hell of a lot of those.

Today, at least when I think of embeded systems, I think of small game
machines, set-top-boxes, real smart-house systems, etc. Systems that
aren't performing one or two tasks, but that are doing multiples of things
that can be very different and somewhat unreleated (except maybe in an
abstract sense). If you take an "ideal" set-top-box you think of something
that can hook up to the network, via cable or phone or whatever, browse
the web, ineract with the tv video feeds, receive and send mail (even if
only operating as a pop-client), browse news feeds, maybe even run
someting like Point-Cast as your "TV Screen Saver". 

When I think of systems, runnig chips like the 4300i, that can do things
like this, I think a pared down Linux is a very justified choice to run
them with. I'd rather it than Windows CE! If your still thinking of Linux
as a traditional Unix, you may still ask why, but if you think of it a
simplistic behind the scenes consumer app, than I think that also resolves
alot of problems.

> 	I would like to see Linux on the low end of the SGI workstations
> 	for two reasons; One as an existance proof that a lightweigth
> 	Unix can be shown to run very fast on our hardware and secondly
> 	for sale to either universities or other research labs that want
> 	source code and want to hack. I don't think it will sell that many
> 	machines but it can't hurt.

I'd disagree and point you to Digital. At ALE Maddog was talking about a
trip through Southern America where half-way digital actually advised him
to stop pitching Digital Unix and start talking about Linux. I admit that
right away it probably won't be precieved as the OS of choice right away,
even Alpha Linux is still not quite the pretty picture the Intel Linux is,
but with time it will gain support from the die hard fans (those people
who run Linux at home and SGI/IRIX at work). Then the OS get stable and
you find a way to run all those wonderful Irix apps on it (see EM86). Then
major companies start looking at it, and you get calls (like digital has
reported) where people make orders ($$$) and ask you to have Linux over
Irix. 

Look at it this way. Linux has a lot of support in the college community.
In five years a majority of these kids will be in industry, do you think
there gonna want Irix on there SGIs? 

> 	I personally believe that the popularity of Linux on ALPHA is
> 	pushed by the Digital Semiconductor Division and they will do
> 	anything to sell chips and Digital systems. I think it is
> 	similar behavior that you see in both IBM's Semiconductor Division
> 	and at the Motorola's Semiconductor Division with the PowerPC.
> 	That being they have no particular religion on any software or
> 	OS, anything that moves chips is alright with them.

I bought a system to runn it on, having never talked to anyone at digital.
You gotta love the 500mHz!!! And isn't that the way it should be? If you
let the users define what runs on the chips your going to have much
happier users.

Oh well, just my thoughts... Cheers!

---
Todd M. Shrider         Oops, My brain just hit a bad sector!
todds@ontko.com         http://www.ontko.com/~todds
