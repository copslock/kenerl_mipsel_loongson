Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id DAA27727; Thu, 30 May 1996 03:27:04 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA19629 for linux-list; Thu, 30 May 1996 10:27:00 GMT
Received: from neteng.engr.sgi.com (neteng.engr.sgi.com [192.26.80.10]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id DAA19624 for <linux@cthulhu.engr.sgi.com>; Thu, 30 May 1996 03:26:59 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id DAA27722; Thu, 30 May 1996 03:26:58 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [150.166.76.30]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id DAA19616; Thu, 30 May 1996 03:26:56 -0700
Received: from snowcrash.cymru.net by sgi.sgi.com via ESMTP (950405.SGI.8.6.12/910110.SGI)
	 id DAA19138; Thu, 30 May 1996 03:26:50 -0700
Received: (from alan@localhost) by snowcrash.cymru.net (8.7.1/8.7.1) id LAA24792; Thu, 30 May 1996 11:06:27 +0100
From: Alan Cox <alan@cymru.net>
Message-Id: <199605301006.LAA24792@snowcrash.cymru.net>
Subject: Re: linux needs bsd networking stack
To: lm@gate1-neteng.engr.sgi.com (Larry McVoy)
Date: Thu, 30 May 1996 11:06:25 +0100 (BST)
Cc: dm@neteng.engr.sgi.com, nn@lanta.engr.sgi.com, torvalds@cs.helsinki.fi,
        alan@cymru.net, sparclinux-cvs@caipfs.rutgers.edu,
        lmlinux@neteng.engr.sgi.com
In-Reply-To: <199605292304.QAA06115@neteng.engr.sgi.com> from "Larry McVoy" at May 29, 96 04:04:37 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> This is one of my complaints.  The BSD stack has a defined set of "objects"
> for dealing with networking; an incomplete list:
> 
> 	protocol structure for different address families

We have these.

> 	interface structure for different media types

We have these

> 	socket structure that cleanly handles different protocols

We have most of this.

> Another big plus of the BSD stack is tcp_input.c and tcp_output.c.  These
> are what most people mean when they say "BSD networking".

Yep. For 2.0 we have all the core stuff. For pre 2.1 we have stuff going beyond
what BSD is doing - Vegas flow control. If you want to work on stealing and working
stuff in talk with Pedro Roque, get pre 2.1 and take a good look.

> 	. There are layering "invariants" that affect performance: you really
> 	should allocate your send buffers from the interface driver, because
> 	it could do some interesting things that would minimize cache flushing.
> 	I think Van's prototype did this for witless cards.

We could certainly add the allocate via device at very little cost. We just start
using dev->kmalloc(). Note that you can't always win on this a packet may change
route.

> 	. Single processor design.  This is the biggest drawback, IMO.

The Linux one is semi designed for MP work. A given socket can do its own locking,
and there are only a small number of areas of overlap at the moment. Notably

Demultiplex table needs locks
Multiple processor writes in parallel/reads in parallel on datagram requires about
	10 lines of lock code.
We dont run the net_bh() in parallel although most of it we can do very easily.

> Proposal/suggestion:
> 	. Come up with a strawman proposal for the set of "objects" we think
> 	  we need in Linux.  Do this as part of the work Linus suggested to
> 	  merge the socket ops with the vfs ops.

That certainly cant be counter-productive.

> 	. Steal the TCP code outright.  Nuke the mbuf stuff, use the skbufs
> 	  or a slightly modified version thereof.

We can't steal it outright. 4.4BSD has abominable problems as is. The FreeBSD people
have the worst of them fixed but don't have stuff like Vegas and have all the 
horrible spoofing problems caused by bad timers.

> 	. Design in SMP support from the start.  This means thinking about
> 	  thousands of connections running in parallel.

So long as it still runs very fast for the 99.99% of people with a single CPU 486 PC.
Thats the primary target by market volume.

> : have 20 books analyzing the code c-statement by c-statement like the
> : bsd stuff does.  If we had that, I think this desire to use the
> : berkeley stack would not be as strong.
> Yeah, but a very reasonable point is "we don't have that".  BSD does.
> This is a big deal.  Documentation is useful.

Its coming. In fact AW should now have released an English language version of the
1.2 kernel programming book. 

Alan
