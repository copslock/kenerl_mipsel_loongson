Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id DAA27714; Thu, 30 May 1996 03:26:35 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA19576 for linux-list; Thu, 30 May 1996 10:26:29 GMT
Received: from neteng.engr.sgi.com (neteng.engr.sgi.com [192.26.80.10]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id DAA19571 for <linux@cthulhu.engr.sgi.com>; Thu, 30 May 1996 03:26:28 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id DAA27710; Thu, 30 May 1996 03:26:28 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [150.166.76.30]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id DAA19562; Thu, 30 May 1996 03:26:26 -0700
Received: from snowcrash.cymru.net by sgi.sgi.com via ESMTP (950405.SGI.8.6.12/910110.SGI)
	 id DAA19088; Thu, 30 May 1996 03:26:04 -0700
Received: (from alan@localhost) by snowcrash.cymru.net (8.7.1/8.7.1) id LAA24835; Thu, 30 May 1996 11:12:14 +0100
From: Alan Cox <alan@cymru.net>
Message-Id: <199605301012.LAA24835@snowcrash.cymru.net>
Subject: Re: linux needs bsd networking stack
To: nn@lanta.engr.sgi.com (Neal Nuckolls)
Date: Thu, 30 May 1996 11:12:12 +0100 (BST)
Cc: dm@neteng.engr.sgi.com, lmlinux@neteng.engr.sgi.com,
        sparclinux-cvs@caipfs.rutgers.edu, alan@cymru.net,
        torvalds@cs.helsinki.fi
In-Reply-To: <199605300036.RAA09665@lanta.engr.sgi.com> from "Neal Nuckolls" at May 29, 96 05:36:19 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> Whether the linux kernel networking implementation is better or
> worse than the BSD code isn't my point. The fact that it's not
> clearly superior, only very different, from the standard is.

Chuckle. The BSD stack doesn't even match the RFC's [ie THE STANDARD]

> work in this area I can readily grab many free BSD-based protocol
> pieceparts off the net. New routing protocols, ATM signalling, TCP
> conjestion improvements, realtime protocol stacks, etc. are all

Let me see: Routing protocols is userspace. ATM signalling we have (going in
2.1), Vegas we have in the pre 2.1 stuff. realtime - if you mean low latency
then take a look at unet.

> Actually, for the startups that I mentioned - those interested in
> shipping a commercial product - there is no choice, it's FreeBSD,
> because it comes without the GPL kiss of death.

So "We should change it for the startups" was message 1. "The startups wont
use it was message two". Do you have bullet holes in your shoes by any
chance ?

> I think that basing any improvements on a 4.4BSD-based linux stack
> would result in something more usable.  Also, as a side effect, it
> would encourage more talented networking people to participate and
> isn't this what freeware is all about?

We can't use the 4.4BSD stack so that issue is moot. Free software is also about high
technical quality. If I wanted to get paid lots of money for hacking kernels I'd go
and work for mirkosoft
