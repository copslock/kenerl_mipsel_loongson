Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id QAA1316449 for <linux-archive@neteng.engr.sgi.com>; Fri, 5 Sep 1997 16:59:44 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id QAA03699 for linux-list; Fri, 5 Sep 1997 16:59:26 -0700
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA03688 for <linux@cthulhu.engr.sgi.com>; Fri, 5 Sep 1997 16:59:24 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id QAA20430; Fri, 5 Sep 1997 16:59:22 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA03669; Fri, 5 Sep 1997 16:59:21 -0700
Received: from athena.nuclecu.unam.mx (athena.nuclecu.unam.mx [132.248.29.9]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id QAA27689; Fri, 5 Sep 1997 16:57:53 -0700
	env-from (miguel@athena.nuclecu.unam.mx)
Received: (from miguel@localhost)
	by athena.nuclecu.unam.mx (8.8.5/8.8.5) id SAA09372;
	Fri, 5 Sep 1997 18:49:45 -0500
Date: Fri, 5 Sep 1997 18:49:45 -0500
Message-Id: <199709052349.SAA09372@athena.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: alan@lxorguk.ukuu.org.uk
CC: wje@fir.engr.sgi.com, linux@fir.engr.sgi.com
In-reply-to: <m0x77Rs-0005FjC@lightning.swansea.linux.org.uk>
	(alan@lxorguk.ukuu.org.uk)
Subject: Re: [Q: Linux/SGI] IRIX executable memory map.
X-Lost: In case of doubt, make it sound convincing
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


> Better to map it first. page fault is a far more critical path to stick
> conditionals into. Even better if possible is to stick it into the userspace
> dynamic loader for irix binaries. That however means not using the irix one
> or having a "preloader" before it

Nah.  We already have an IRIX specific ELF loader, so I will just
modify my existing mmap in that place.  No need for extra hacks if a
10 line change to irixelf.c fixes it.

Cheers,
Miguel.
