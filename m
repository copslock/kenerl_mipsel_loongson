Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id TAA00597; Wed, 9 Apr 1997 19:22:13 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id TAA18269 for linux-list; Wed, 9 Apr 1997 19:21:08 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id TAA18255 for <linux@relay.engr.SGI.COM>; Wed, 9 Apr 1997 19:21:01 -0700
Received: from athena.nuclecu.unam.mx (athena.nuclecu.unam.mx [132.248.29.9]) by sgi.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id TAA19610 for <linux@relay.engr.SGI.COM>; Wed, 9 Apr 1997 19:20:59 -0700
Received: (from miguel@localhost)
	by athena.nuclecu.unam.mx (8.8.5/8.8.5) id CAA22863;
	Thu, 10 Apr 1997 02:18:59 -0500
Date: Thu, 10 Apr 1997 02:18:59 -0500
Message-Id: <199704100718.CAA22863@athena.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: shaver@neon.ingenia.ca
CC: linux@cthulhu.engr.sgi.com
In-reply-to: <199704100211.WAA16857@neon.ingenia.ca> (message from Mike Shaver
	on Wed, 9 Apr 1997 22:11:01 -0400 (EDT))
Subject: Re: all in the family
X-Windows: Form follows malfunction.
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


> Anyone know if the emulation is up to hosting the Linux/Indy
> cross-compiler?

Why do you need the emulation for on Linux/SPARC?   You just need to
run configure on Linux/SPARC with the proper --target option and you
will get your native cross-compiler in a second.

You need to configure both binutils and gcc like this.


> In related news, we'll then have Linux running on 5 architectures in
> the same room (Intel, Alpha, SPARC, ELKS, Indy).  Maybe I'll steal the
> PowerMac too... =)

:-)

Miguel.
