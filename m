Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA06150; Wed, 29 May 1996 16:04:45 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id XAA16762 for linux-list; Wed, 29 May 1996 23:04:40 GMT
Received: from neteng.engr.sgi.com (neteng.engr.sgi.com [192.26.80.10]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA16744 for <linux@cthulhu.engr.sgi.com>; Wed, 29 May 1996 16:04:38 -0700
Received: from localhost (lm@localhost) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via SMTP id QAA06115; Wed, 29 May 1996 16:04:37 -0700
Message-Id: <199605292304.QAA06115@neteng.engr.sgi.com>
To: dm@neteng.engr.sgi.com
From: lm@gate1-neteng.engr.sgi.com (Larry McVoy)
cc: nn@lanta.engr.sgi.com, torvalds@cs.helsinki.fi, alan@cymru.net,
        sparclinux-cvs@caipfs.rutgers.edu, lmlinux@neteng.engr.sgi.com
Subject: Re: linux needs bsd networking stack 
Date: Wed, 29 May 1996 16:04:37 -0700
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

:    The "unique" tcp/ip implementation is a liability to linux.
: 
: It could also be one of it's greatest assets, and I think this will
: turn out to be the case.
: 
:    Is anyone working to replace the standard linux stack
:    with port derived from the 4.4BSD code?
: 
: A couple of weeks ago, Larry was babbling to me "oh the stack is
: sloowww, I can't push nearly as much over 100mb/s ether as freebsd
: can, etc."  I said, "thats peculiar" so I did some investigation and
: told Linus about it.  Turned out to be a driver bug and after that was
: fixed the over the wire numbers are unparalleled.

That's not quite true, I think the BSD numbers are still better, I'll
have full lmbench apples to apples runs on the same hardware at the 
end of this week.

: It [bsd] has a well defined architecture, I will agree with lm when he
: mentions that it is a jungle of code to sift through in certain
: respects.  

This is one of my complaints.  The BSD stack has a defined set of "objects"
for dealing with networking; an incomplete list:

	protocol structure for different address families
	interface structure for different media types
	socket structure that cleanly handles different protocols

Another big plus of the BSD stack is tcp_input.c and tcp_output.c.  These
are what most people mean when they say "BSD networking".

Downsides of BSD:

	. I don't particlularly like mbufs; I agree with Linus & Alan that
	they are overkill.  

	. There are layering "invariants" that affect performance: you really
	should allocate your send buffers from the interface driver, because
	it could do some interesting things that would minimize cache flushing.
	I think Van's prototype did this for witless cards.

	. Single processor design.  This is the biggest drawback, IMO.

Proposal/suggestion:

	. Come up with a strawman proposal for the set of "objects" we think
	  we need in Linux.  Do this as part of the work Linus suggested to
	  merge the socket ops with the vfs ops.

	. Steal the TCP code outright.  Nuke the mbuf stuff, use the skbufs
	  or a slightly modified version thereof.

	. Design in SMP support from the start.  This means thinking about
	  thousands of connections running in parallel.

: I think the feeling that the linux stack is "hard to follow" or "has
: very little architecture" has a lot to do with the fact that we don't
: have 20 books analyzing the code c-statement by c-statement like the
: bsd stuff does.  If we had that, I think this desire to use the
: berkeley stack would not be as strong.

Yeah, but a very reasonable point is "we don't have that".  BSD does.
This is a big deal.  Documentation is useful.
