Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA03273; Wed, 29 May 1996 15:50:30 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id WAA13722 for linux-list; Wed, 29 May 1996 22:50:25 GMT
Received: from neteng.engr.sgi.com (neteng.engr.sgi.com [192.26.80.10]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA13701 for <linux@cthulhu.engr.sgi.com>; Wed, 29 May 1996 15:50:24 -0700
Received: (from dm@localhost) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id PAA03268; Wed, 29 May 1996 15:50:23 -0700
Date: Wed, 29 May 1996 15:50:23 -0700
Message-Id: <199605292250.PAA03268@neteng.engr.sgi.com>
From: "David S. Miller" <dm@neteng.engr.sgi.com>
To: nn@lanta.engr.sgi.com
CC: torvalds@cs.helsinki.fi, alan@cymru.net, sparclinux-cvs@caipfs.rutgers.edu,
        lmlinux@neteng.engr.sgi.com
In-reply-to: <199605292159.OAA09070@lanta.engr.sgi.com> (nn@lanta)
Subject: Re: linux needs bsd networking stack
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

   Date: Wed, 29 May 1996 14:59:58 -0700
   From: nn@lanta (Neal Nuckolls)

   The "unique" tcp/ip implementation is a liability to linux.

It could also be one of it's greatest assets, and I think this will
turn out to be the case.

   Is anyone working to replace the standard linux stack
   with port derived from the 4.4BSD code?

I will for now only briefly mention why I think this is not very
desirable.

A couple of weeks ago, Larry was babbling to me "oh the stack is
sloowww, I can't push nearly as much over 100mb/s ether as freebsd
can, etc."  I said, "thats peculiar" so I did some investigation and
told Linus about it.  Turned out to be a driver bug and after that was
fixed the over the wire numbers are unparalleled.

The Berkeley stack is dead, but it has one redeeming quality which
Linux's stack does desperately need.

It has a well defined architecture, I will agree with lm when he
mentions that it is a jungle of code to sift through in certain
respects.  It need a mallet to smooth certain aspects and interfaces
out.

In the end I think it is best to work on hacking the existing (and
upcoming) Linux networking code to have these qualities instead of
stuffing the bsd stack into linux (this has been done before a long
long time ago btw, before linux had any networking, a man by the name
of Charles Hedrick back at Rutgers did it in a few nights).

I think the feeling that the linux stack is "hard to follow" or "has
very little architecture" has a lot to do with the fact that we don't
have 20 books analyzing the code c-statement by c-statement like the
bsd stuff does.  If we had that, I think this desire to use the
berkeley stack would not be as strong.

I dislike the berkeley stack, but I am biased in my opinion.  I am
biased because of the attitude expressed by the people actively
working on that code set in the free software world these days, I am
also biased because I tend to hack Linux almost exlusively.  But, even
barring that I believe that some of the elements of the bsd stack will
end up being completely flawed when plugged into linux, obvious things
like mbufs and other things come to mind right now.  It would require
a bit of engineering and greatly upset a large community who has put
their entire heart and soul into the Linux networking code.  I believe
at the very least that the Linux networking stack is superior
performance wise without any question, and as everyone knows I have
numbers to prove it ;-)

Later,
David S. Miller
dm@sgi.com
