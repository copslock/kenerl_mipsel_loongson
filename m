Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA04781; Tue, 18 Jun 1996 10:11:30 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id RAA24241 for linux-list; Tue, 18 Jun 1996 17:11:26 GMT
Received: from yon.engr.sgi.com (yon.engr.sgi.com [150.166.61.32]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA24232; Tue, 18 Jun 1996 10:11:24 -0700
Received: (from ariel@localhost) by yon.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA14821; Tue, 18 Jun 1996 10:10:31 -0700
From: ariel@yon.engr.sgi.com (Ariel Faigon)
Message-Id: <199606181710.KAA14821@yon.engr.sgi.com>
Subject: Re: anyone know if this is true?
To: lm@neteng.engr.sgi.com (Larry McVoy)
Date: Tue, 18 Jun 1996 10:10:31 -0700 (PDT)
Cc: linux@cthulhu.engr.sgi.com, gcc@corp.sgi.com, tiemann@cygnus.com
In-Reply-To: <199606181641.JAA03609@neteng.engr.sgi.com> from "Larry McVoy" at Jun 18, 96 09:41:47 am
Reply-To: ariel@cthulhu.engr.sgi.com
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL24 ME5a]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Sadly, it *is* true.  I guess many more 6.2 pissed off customers
are waiting down the pipeline.

We can solve it by getting David Miller's development environment
packaged as freeware, (it includes a GNU linker that works)
and put it (really quick) outside the firewall for whoever
is interested.

	1) Someone with a couple of days of time needs to take this
	   and just do it. I was planning on it, but I need
	   another week or so to start.

	2) I'm afraid we'll need to add crt[1n].o as binaries
	   as these are *not* shipped with the headers and libraries
	   of 6.2

Any comments, objections from anyone (especially for step 2) ?


>
>If it isn't true, can someone send mail to Tiemann and tell him the
>facts.  Sounds like we're getting bad press.
>
>------- Forwarded Message
>
>Date:    Tue, 18 Jun 1996 05:22:52 -0700
>From:    Michael Tiemann <tiemann@cygnus.com>
>To:      lm@sgi.com
>Subject: [comp.sys.sgi.apps] gcc part II
>
>Is this not fixed in 6.2?  I upgraded my machine at home yesterday, and
>it looked suspiciously like SGI was providing headers and libraries as
>part of the std 6.2 release.
>
>    From: jon@vcnet.com (Jon Rust)
>    Subject: gcc part II
>    Newsgroups: comp.sys.sgi.apps
>    Date: Mon, 17 Jun 1996 22:25:34 -0700
>    Organization: IAVC
>    Path: cygnus.com!kithrup.com!news.Stanford.EDU!agate!howland.reston.ans.net
>!newsfeed.internetmci.com!in1.uu.net!news.vcnet.com!jon.vc.net!user
>Lines: 21
>Message-ID: <jon-1706962225340001@jon.vc.net>
>NNTP-Posting-Host: jon.vc.net
>X-Newsreader: Yet Another NewsWatcher 2.2.0b4
>
>    Before I fly off the handle, I wanna make sure this is true.
>
>    You can't build ***anything*** unless you fork over a huge wad of cash to
>    SGI for their compiler and dev enviro?
>
>    **If** this is true, it's horseshit. No wonder SGI is so far down the food
>    chain in the land of UNIX. Buying SGI could be one of the biggest mistakes
>    I've made since openning my business over 15 months ago. I wonder if my 30
>    days are up. Maybe I can ship it back. I only wish I'd bought [insert any
>    other UNIX platform here].
>
>    If it's not true, could someone plz point me in the right direction to get
>    gcc working so I can compile BIND, RADIUS, wuftpd, etc...
>
>    pissed off with no build capability,
>    jon
>
>    --------------------------------------------------------
>    Jon Rust
>    Internet Access of Ventura County
>    jon@vc.net        http://www.vc.net         805.383.3500
>
>I know that gcc is not yet 6.2-friendly, but that's much more easily
>fixed than the library/header problem.
>
>Michael
>
>------- End of Forwarded Message
>


-- 
Peace, Ariel
