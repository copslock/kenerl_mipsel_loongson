Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id SAA1338693 for <linux-archive@neteng.engr.sgi.com>; Fri, 5 Sep 1997 18:32:11 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id SAA27581 for linux-list; Fri, 5 Sep 1997 18:31:24 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA27551; Fri, 5 Sep 1997 18:31:18 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id SAA18377; Fri, 5 Sep 1997 18:31:12 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61]) by informatik.uni-koblenz.de (8.8.6/8.6.9) with SMTP id DAA21049; Sat, 6 Sep 1997 03:31:03 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199709060131.DAA21049@informatik.uni-koblenz.de>
Received: by thoma (SMI-8.6/KO-2.0)
	id DAA07368; Sat, 6 Sep 1997 03:31:01 +0200
Subject: Re: 2.1.53 (from Linus)
To: ariel@cthulhu.engr.sgi.com
Date: Sat, 6 Sep 1997 03:31:00 +0200 (MET DST)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <199709052036.NAA29563@oz.engr.sgi.com> from "Ariel Faigon" at Sep 5, 97 01:36:12 pm
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> Just thought this would be of relevance to some:
> 
> Subject: Linux-2.1.53..
> From: Linus Torvalds <torvalds@transmeta.com>
> Date: Thu, 4 Sep 1997 17:10:27 -0700
> Message-ID: <Pine.LNX.3.95.970904170831.428J-100000@penguin.transmeta.com>
> Newsgroups: .mlist. linux-kernel linux-kernel@vger.rutgers.edu
> 
> 
> I released a 2.1.53, which fixes two major bugs in the 2.1.x series. Ingo
> Molnar found one (and hopefully _the_) reason for dcache corruption in
> d_move(), and David Miller found and fixed a TCP-related crash-inducer. 
> 
> In short, I hope 2.1.53 will finally be stable for people,

I've fixed a couple more showstoppers in the MIPS part of the kernel.
In particular the kernel was misstreating all non-R4000/R4400 CPUs
with virtual indexed caches but without a second level caches or
a cachesize other than 16kbit.  For I/O this might result in old data
being written back to the disk.

I suspect this was the source of the Inode corruption I was observing
on my R5k Indy as well as the frequent crashes on my R4600 and R4300 box.
The big brother, an R5230 eval board I'm hacking right now has been stable
over days, same for the NCR driver.  The Z8530 driver however is still
as fragile as a snowflake.

I've fixed a couple of other showstoppers as well.  I'm currently
working on cleanly integrating yet another port into the source tree.
When this and some other important debugging (new init versions die)
is done, I'll merge back all the stuff.

  Ralf
