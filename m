Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA16394; Wed, 29 May 1996 17:36:27 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id AAA03431 for linux-list; Thu, 30 May 1996 00:36:21 GMT
Received: from neteng.engr.sgi.com (neteng.engr.sgi.com [192.26.80.10]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA03420 for <linux@cthulhu.engr.sgi.com>; Wed, 29 May 1996 17:36:20 -0700
Received: from lanta.engr.sgi.com (lanta.engr.sgi.com [192.26.75.15]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA16390; Wed, 29 May 1996 17:36:20 -0700
Received: by lanta.engr.sgi.com (940816.SGI.8.6.9/911001.SGI)
	 id RAA09665; Wed, 29 May 1996 17:36:19 -0700
Date: Wed, 29 May 1996 17:36:19 -0700
From: nn@lanta.engr.sgi.com (Neal Nuckolls)
Message-Id: <199605300036.RAA09665@lanta.engr.sgi.com>
To: dm@neteng.engr.sgi.com
Subject: Re: linux needs bsd networking stack
Cc: lmlinux@neteng.engr.sgi.com, sparclinux-cvs@caipfs.rutgers.edu,
        alan@cymru.net, torvalds@cs.helsinki.fi
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


>> The "unique" tcp/ip implementation is a liability to linux.
>
> It could also be one of it's greatest assets, and I think this will
> turn out to be the case.

Whether the linux kernel networking implementation is better or
worse than the BSD code isn't my point. The fact that it's not
clearly superior, only very different, from the standard is.

Most unix and internet R&D community protocol development has
been and continues to be within a BSD environment which means that
BSD-based kernel networking code is prevalent. If I'm doing some
work in this area I can readily grab many free BSD-based protocol
pieceparts off the net. New routing protocols, ATM signalling, TCP
conjestion improvements, realtime protocol stacks, etc. are all
developed in a BSD kernel networking environment.  Have been for
years. That's not likely to change. There are hundreds of people
out there that really know BSD networking. This availability of
people and code makes it the standard.

Actually, for the startups that I mentioned - those interested in
shipping a commercial product - there is no choice, it's FreeBSD,
because it comes without the GPL kiss of death.

> In the end I think it is best to work on hacking the existing (and
> upcoming) Linux networking code to have these qualities instead of
> stuffing the bsd stack into linux

I think that basing any improvements on a 4.4BSD-based linux stack
would result in something more usable.  Also, as a side effect, it
would encourage more talented networking people to participate and
isn't this what freeware is all about?

neal
