Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id AAA53005 for <linux-archive@neteng.engr.sgi.com>; Fri, 27 Nov 1998 00:15:52 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id AAA22023
	for linux-list;
	Fri, 27 Nov 1998 00:15:11 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id AAA32956
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 27 Nov 1998 00:15:08 -0800 (PST)
	mail_from (torbjorn.gannholm@fra.se)
Received: from x.fra.se (x.fra.se [193.12.220.1]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id AAA07132
	for <linux@cthulhu.engr.sgi.com>; Fri, 27 Nov 1998 00:15:05 -0800 (PST)
	mail_from (torbjorn.gannholm@fra.se)
Received: from fra.se by x.fra.se via ESMTP (940816.SGI.8.6.9/940406.SGI.AUTO)
	 id JAA04177; Fri, 27 Nov 1998 09:21:20 +0100
Message-ID: <365E60FE.F12615EC@fra.se>
Date: Fri, 27 Nov 1998 09:21:19 +0100
From: "Torbjörn Gannholm" <torbjorn.gannholm@fra.se>
X-Mailer: Mozilla 4.05 [en] (X11; I; IRIX 5.3 IP12)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "linux@cthulhu.engr.sgi.com" <linux@cthulhu.engr.sgi.com>
Subject: Re: GNU/Hurd
References: <m0zj1Bg-0007U2C@the-village.bc.nu>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Alan Cox wrote:

> > A possible minus is the message-passing between the servers which might
> > be time-consuming.
>
> "Yesterdays technology, next week" to quote an OSI saying

Possibly, but maybe Unix and Linux also are yesterdays technology in some sense,
but cooperative development is the future (and a small bit of the present) and I
think it's sad that science is held back because of money and prestige
(Although, mind you, I don't mind paying for software and giving credit where
it's due, but I want to know what it does and be able to change it if I think I
can do something better).

>
>
> > Still, my feeling is that this could be a real winner on flexibility and
> > performance. Any comments?
>
> If you want a pre-emptible OS core its not HURD. Being pre-emptible without
> deadlocks or other interesting suprises is a very very hard problem. Consider
> things like disk sorting algorithms when you have 40 blocks for a low pri
> process queued up with 2 for a real time one.

 Actually, for the most part I couldn't care less about preemptible or
real-time. I just want to get maximum cream out of my system (scaled to a
zillion cpus), and I want it to run until I kill it. Maybe I'm being boring, but
to watch video I use a TV, to listen to music I use a HiFi, reality is a lot
more interesting than virtual, and to run a nuclear power station I have
dedicated machines. And if I did want to use my computer for any of this I could
probably load the appropriate mechanisms if they existed and everything else is
nicely designed.

IMHO, maybe preemptibility is a fix rather than a solution and the solution lies
in another dimension.

But still, why wouldn't some implementation of HURD (or mach) be able to be
preemptible?

--
/Torbjörn

This message is a personal message from Torbjörn Gannholm
and does not necessarily represent the opinion of my employer.
