Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id NAA403979 for <linux-archive@neteng.engr.sgi.com>; Wed, 29 Oct 1997 13:55:46 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id NAA03472 for linux-list; Wed, 29 Oct 1997 13:54:22 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA03414; Wed, 29 Oct 1997 13:54:12 -0800
Received: from athena.nuclecu.unam.mx (athena.nuclecu.unam.mx [132.248.29.9]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id NAA26291; Wed, 29 Oct 1997 13:54:05 -0800
	env-from (miguel@athena.nuclecu.unam.mx)
Received: (from miguel@localhost)
	by athena.nuclecu.unam.mx (8.8.5/8.8.5) id PAA15807;
	Wed, 29 Oct 1997 15:50:29 -0600
Date: Wed, 29 Oct 1997 15:50:29 -0600
Message-Id: <199710292150.PAA15807@athena.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: alan@lxorguk.ukuu.org.uk
CC: ariel@cthulhu.engr.sgi.com, mgix@nothingreal.com,
        linux@cthulhu.engr.sgi.com
In-reply-to: <m0xQcdN-0005G0C@lightning.swansea.linux.org.uk>
	(alan@lxorguk.ukuu.org.uk)
Subject: Re: Step by step of my experience
X-FileLength: are infinite where infinity is set to 255 characters
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


> Im being bitten by a couple of kernel bugs tho
> 
> 	  1.	vmalloc keeps failing on the unix GC (annoying noise)

The fix for this is commited in the cvs tree.

> 	  2.	SIGCLD isnt getting given to init for some reason
> 		  when scripts terminate (breaks redhat init scripting)
> 		  [ note init isnt ignoring the signal... ]

The latest SysV init works around this problem.  Or at least fixes all
the problems for me.

Cheers,
Miguel.
