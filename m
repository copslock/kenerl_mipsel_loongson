Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id EAA91760 for <linux-archive@neteng.engr.sgi.com>; Thu, 26 Nov 1998 04:14:56 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id EAA01677
	for linux-list;
	Thu, 26 Nov 1998 04:13:00 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id EAA66955
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 26 Nov 1998 04:12:55 -0800 (PST)
	mail_from (alan@lxorguk.ukuu.org.uk)
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id EAA07168
	for <linux@cthulhu.engr.sgi.com>; Thu, 26 Nov 1998 04:12:48 -0800 (PST)
	mail_from (alan@lxorguk.ukuu.org.uk)
Received: from the-village.bc.nu (lightning.swansea.uk.linux.org [194.168.151.1]) by snowcrash.cymru.net (8.8.7/8.7.1) with SMTP id MAA13547; Thu, 26 Nov 1998 12:12:11 GMT
Received: by the-village.bc.nu (Smail3.1.29.1 #2)
	id m0zj1Bg-0007U2C; Thu, 26 Nov 98 13:10 GMT
Message-Id: <m0zj1Bg-0007U2C@the-village.bc.nu>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: GNU/Hurd
To: torbjorn.gannholm@fra.se (Torbjörn Gannholm)
Date: Thu, 26 Nov 1998 13:10:23 +0000 (GMT)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <365D0C17.73AB1509@fra.se> from "Torbjörn Gannholm" at Nov 26, 98 09:06:48 am
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> A possible minus is the message-passing between the servers which might
> be time-consuming.

"Yesterdays technology, next week" to quote an OSI saying

> Still, my feeling is that this could be a real winner on flexibility and
> performance. Any comments?

If you want a pre-emptible OS core its not HURD. Being pre-emptible without
deadlocks or other interesting suprises is a very very hard problem. Consider
things like disk sorting algorithms when you have 40 blocks for a low pri
process queued up with 2 for a real time one.
