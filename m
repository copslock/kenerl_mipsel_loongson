Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA16610; Wed, 28 May 1997 16:03:36 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id QAA16568 for linux-list; Wed, 28 May 1997 16:02:36 -0700
Received: from yon.engr.sgi.com (yon.engr.sgi.com [150.166.61.32]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA16531 for <linux@cthulhu.engr.sgi.com>; Wed, 28 May 1997 16:02:27 -0700
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130]) by yon.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA12605 for <linux@yon.engr.sgi.com>; Wed, 28 May 1997 16:02:14 -0700
Received: from omen.melbourne.sgi.com (omen.melbourne.sgi.com [134.14.55.139]) by larry.melbourne.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id JAA17587; Thu, 29 May 1997 09:02:02 +1000
Received: (from chatz@localhost) by omen.melbourne.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id JAA19530; Thu, 29 May 1997 09:01:48 +1000
From: "David Chatterton" <chatz@omen.melbourne.sgi.com>
Message-Id: <9705290901.ZM19528@omen.melbourne.sgi.com>
Date: Thu, 29 May 1997 09:01:47 -0500
In-Reply-To: Larry McVoy <lm@neteng.engr.sgi.com>
        "nifty tools on Linux/IRIX" (May 28, 12:24pm)
References: <199705281924.MAA09260@neteng.engr.sgi.com>
X-Mailer: Z-Mail (3.2.3 08feb96 MediaMail)
To: Larry McVoy <lm@neteng.engr.sgi.com>, linux@yon.engr.sgi.com,
        miguel@nuclecu.unam.mx, shaver@neon.ingenia.ca
Subject: Re: nifty tools on Linux/IRIX
Cc: ptg@melbourne.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On May 28, 12:24pm, Larry McVoy wrote:
| Subject: nifty tools on Linux/IRIX
| Miguel asked about cool tools.  Talk to Ken, he's the man.
|

Miguel,

Hi! I work for Ken on the Performance Co-Pilot. Our only external pages are:

	http://www.sgi.com/Products/hardware/challenge/CoPilot/CoPilot.html
	http://reality.sgi.com/chatz

The first is the marketing page to the real world, the second is my home page
which has some snapshots. Our next release will include support for little
endian machines, so we have been testing this under linux (of course :).

Here is a quick summary of how it all works. We have a daemon on each host you
want to monitor. Attached to this daemon (dlopen, pipe, socket etc.) are agents
that collect performance metrics from a particular domain (kernel, web server,
database). Our client tools connect to the daemon (socket) and request metrics.
The daemon requests the metrics from the appropriate agent and forwards the
values back to the clients. One client is a logger which generates archives
that all the other clients can replay, as if they were connected live to a
daemon process. The whole protocol is very light weight, much lighter than
SNMP, so the daemon and agents rarely show up in top.

Performance Co-Pilot has only been released for IRIX, but bits have been built
under linux before, and as several of us have linux boxes at home, this will
probably continue. We have talked about making some linux binaries freely
available and other similar options, but nothing definate yet. I guess we need
to know that such an investment of our time is going to be worthwhile, and that
this fits in with our medium-long terms plans for the product. We also have to
consider Java, NT (*sigh*) etc., and determine how SGI can start releasing
software for other platforms.

We are all (quiet) supporters of the linux on SGI project, keep up the good
work!

David

-- 
David Chatterton                            (61-3) 9882 8211 (Tel)
R&D Software Engineer		            (61-3) 9882 8030 (Fax)
Performance Tools Group               http://reality.sgi.com/chatz
Silicon Graphics Pty.Ltd., 357 Camberwell Rd, Melbourne, Australia
