Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id WAA19895; Wed, 29 May 1996 22:22:26 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id FAA27281 for linux-list; Thu, 30 May 1996 05:22:20 GMT
Received: from neteng.engr.sgi.com (neteng.engr.sgi.com [192.26.80.10]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id WAA27276 for <linux@cthulhu.engr.sgi.com>; Wed, 29 May 1996 22:22:19 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id WAA19892 for <lmlinux@neteng.engr.sgi.com>; Wed, 29 May 1996 22:22:19 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [150.166.76.30]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id WAA27269; Wed, 29 May 1996 22:22:17 -0700
Received: from porsta.cs.Helsinki.FI by sgi.sgi.com via ESMTP (950405.SGI.8.6.12/910110.SGI)
	 id WAA29720; Wed, 29 May 1996 22:22:14 -0700
Received: from linux.cs.Helsinki.FI (linux.cs.Helsinki.FI [128.214.48.39]) by porsta.cs.Helsinki.FI (8.6.10/8.6.9) with SMTP id IAA26571; Thu, 30 May 1996 08:22:12 +0300
Date: Thu, 30 May 1996 08:21:42 +0300 (EET DST)
From: Linus Torvalds <torvalds@cs.Helsinki.FI>
To: Neal Nuckolls <nn@lanta.engr.sgi.com>
cc: alan@cymru.net, sparclinux-cvs@caipfs.rutgers.edu,
        lmlinux@neteng.engr.sgi.com
Subject: Re: linux needs bsd networking stack
In-Reply-To: <199605292159.OAA09070@lanta.engr.sgi.com>
Message-ID: <Pine.LNX.3.91.960530080714.20038B-100000@linux.cs.Helsinki.FI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk



On Wed, 29 May 1996, Neal Nuckolls wrote:
> 
> Silicon Valley is bubbling with networking startups.
> Many of these new small companies are designing products
> based on PC motherboards and doing some sw and/or hw
> customization to turn them into networking switches,
> routers, firewalls, etc.  Rather than embedding a RTOS,
> they are choosing a free unix and usually this is FreeBSD
> since Linux networking is not the de facto BSD stack.
> The "unique" tcp/ip implementation is a liability to linux.
> Is anyone working to replace the standard linux stack
> with port derived from the 4.4BSD code?

Simple answer: it won't happen.

The _only_ advantage of the BSD stack is the de-facto standard thing, and 
quite frankly that one doesn't make much of a difference - Linux _will_ 
be the facto standard in one or two more years if everything goes right. 
Trying to port the BSD stack would be a major mistake, imho.

I used to think the BSD stack was an option that we might want to take some
day, but I don't think so any more. My main concerns were performance and
compatibility, and we've got them both. The problems we still have in
networking are not worth worrying about in this context - we'd have a lot
more problems if we tried to switch and they wouldn't be any easier to solve. 

Note that this doesn't mean we shouldn't look at parts of the BSD stack 
for interesting things (and the BSD stack has obviously been there as a 
reference). But a whole-sale BSD stack port is not going to happen.

		Linus
