Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id JAA272322 for <linux-archive@neteng.engr.sgi.com>; Fri, 2 Jan 1998 09:57:27 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id JAA03447 for linux-list; Fri, 2 Jan 1998 09:56:51 -0800
Received: from oz.engr.sgi.com (oz.engr.sgi.com [150.166.61.27]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id JAA03441; Fri, 2 Jan 1998 09:56:49 -0800
Received: (from ariel@localhost) by oz.engr.sgi.com (971110.SGI.8.8.8/970903.SGI.AUTOCF) id JAA36833; Fri, 2 Jan 1998 09:56:49 -0800 (PST)
From: ariel@oz.engr.sgi.com (Ariel Faigon)
Message-Id: <199801021756.JAA36833@oz.engr.sgi.com>
Subject: Re: Please help - need a 4600 no L2 cache kernel asap
To: mike@mdhill.interlog.com (Michael Hill)
Date: Fri, 2 Jan 1998 09:56:49 -0800 (PST)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <9801021008.ZM4428@mdhill.interlog.com> from "Michael Hill" at Jan 2, 98 10:08:13 am
Reply-To: ariel@cthulhu.engr.sgi.com (Ariel Faigon)
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL24 ME5a]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Important change to the SGI/Linux FTP site:

I just moved the CVS source tree hierarchy so it can be
accessed via ftp:

	ftp://ftp.linux.sgi.com/cvs/

There's also a link from the web site to this (software page)
	http://www.linux.sgi.com/software.html

This should enable anyone to compile a good kernel from scratch.

Whoever has a stable kernel that works on a L2-cache-less 4600
please share.  I'll gladly give this person ssh access to linus.


-- 
Peace, Ariel


:
:Ralf discovered and corrected this in his kernel source after several of us had
:problems with his last publicly-available Indy kernel binary (8 December).
: Since then no kernel binary or source has been posted to ftp.linux.sgi.com
:(except linux-magnum-971229.tar.gz on 29 December).  Maybe the fix is part of
:what Ralf wanted help with before Christmas.
:
:On Dec 21,  5:45pm, Ralf Baechle wrote:
:> Subject: Mergeback
:> Hi,
:>
:> can anybody else work a bit on merging things back to Linus for the
:> next couple of days?  I wont have very much time :-(
:>
:>   Ralf
:>-- End of excerpt from Ralf Baechle
:
:On Jan 2,  6:59am, Andrew O'Brien wrote:
:> Subject: Re: Please help - need a 4600 no L2 cache kernel asap
