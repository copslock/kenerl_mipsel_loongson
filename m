Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id JAA241790 for <linux-archive@neteng.engr.sgi.com>; Thu, 4 Dec 1997 09:05:34 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id JAA17178 for linux-list; Thu, 4 Dec 1997 09:04:25 -0800
Received: from xtp.engr.sgi.com (xtp.engr.sgi.com [150.166.75.34]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id JAA17165 for <linux@cthulhu.engr.sgi.com>; Thu, 4 Dec 1997 09:04:23 -0800
Received: by xtp.engr.sgi.com (950413.SGI.8.6.12/911001.SGI)
	 id JAA08163; Thu, 4 Dec 1997 09:03:53 -0800
From: "Greg Chesson" <greg@xtp.engr.sgi.com>
Message-Id: <9712040903.ZM8161@xtp.engr.sgi.com>
Date: Thu, 4 Dec 1997 09:03:53 -0800
In-Reply-To: "David Chatterton" <chatz@omen.melbourne.sgi.com>
        "Re: Linux on the O2" (Dec  4,  5:08pm)
References: <Pine.SGI.3.96.971204001929.20475A-100000@barramunda> 
	<9712041708.ZM8190@omen.melbourne.sgi.com>
X-Mailer: Z-Mail (3.2.3 08feb96 MediaMail)
To: "David Chatterton" <chatz@omen.melbourne.sgi.com>,
        Lige Hensley <ligeh@carpediem.com>, Chris Carlson <cwcarlson@home.com>
Subject: Re: Linux on the O2
Cc: linux@cthulhu.engr.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

I've been reading the O2 thread with great interest.

It seems to me that a "vanilla" port of Linux on the O2 is quite feasible.
Several writers have agreed.

But full support in Linux for extremem platform-dependent multimedia
hardware is problematic.  This has also been mentioned by several writers,
some of whom developed the OS code.  The problems are twofold: it would
be a non-trivial task even with full documentation to provide complete
support for O2 hardware since the job would require as much new invention
as it would require porting, and second- full disclosure
of the inner workings is viewed as too much of a giveaway to present
and future competitors.

Makes me wonder whether the Indy port of Linux could be ratcheted into
a vanilla port for the O2, and then perhaps SGI could produce binary
loadable drivers for the missing bits.

g
