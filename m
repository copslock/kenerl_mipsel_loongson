Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA85274 for <linux-archive@neteng.engr.sgi.com>; Thu, 5 Nov 1998 12:53:50 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA63215
	for linux-list;
	Thu, 5 Nov 1998 12:53:06 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from oz.engr.sgi.com (oz.engr.sgi.com [150.166.42.13])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA60312
	for <linux@engr.sgi.com>;
	Thu, 5 Nov 1998 12:53:05 -0800 (PST)
	mail_from (ariel@oz.engr.sgi.com)
Received: (from ariel@localhost) by oz.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) id MAA55262 for linux@engr.sgi.com; Thu, 5 Nov 1998 12:53:05 -0800 (PST)
From: ariel@oz.engr.sgi.com (Ariel Faigon)
Message-Id: <199811052053.MAA55262@oz.engr.sgi.com>
Subject: Halloween doc II
To: linux@cthulhu.engr.sgi.com (SGI/Linux mailing list)
Date: Thu, 5 Nov 1998 12:53:04 -0800 (PST)
Reply-To: ariel@cthulhu.engr.sgi.com (Ariel Faigon)
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL25]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

A second "what is Linux and how to combat it" document
just came out the Microsoft leak factory:

        http://www.opensource.org/halloween2.html

It is a followup doc to the infamous "Halloween Doc"
(now renamed "Halloween I").   It was leaked by an MS
employee as a reaction to the recent publicity for
Halloween-I.  It adds the threat of Linux as a client
and gives a very positive evaluation of Linux (coming
from within MS, this is telling).

It concludes again, with the sinister suggestions to
"de-commoditize" open protocols, plus (surprise) ways
to attack Linux via litigation (if you can't beat them
on merit, there are always the nukes, Bill).

		---
There's specific interest to this community: David Miller
and Miguel de Icaza are both mentioned and their SPARC
comparison docs are linked from this document.  No doubt,
the MS guys did a great research job.

There's a lot the Linux community learn from this document.
Just read the "what's missing in Linux compared to NT"
part and make sure it is implemented. It doesn't appear
too hard.  Some points which are definitely geared towards
the non sophisticated users include:

	1) Automounting a floppy/CD when it is inserted
	   (BTW: IRIX mediad has been doing this for quite a while)

	2) Simpler installation: e.g. rather than asking 30
	   questions, provide a menu like:
		1) Express install: don't ask me anything,
		   just go ahead and fill my disk.
		2) Pick and chose: let me select
		...

	3) XFree86 installation: don't ask me what chipset I have
	   and what's the scan rates etc.  Instead have an internal
	   mapping table between well known brand names (e.g. ATI Mach64)
	   and the details of the card.  People usually know the latter
	   (what's written on the box, but rarely the former)

	4) Simpler Network config:  DHCP client installed by default
	   Again saving complex questions to the simple user

	5) Of course, a coherent consistent GUI to manage everything
	   from HW devices to access to files etc.  Those who need
	   the simplicity, will never be willing to do command line
	   stuff.

	6) Development tools like VB/VC++ :-)

Someone forward this to Red Hat / Gnome and the XFree86 teams ...

-- 
Peace, Ariel
