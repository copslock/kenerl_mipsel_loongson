Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id IAA397475; Fri, 22 Aug 1997 08:54:14 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id IAA22381 for linux-list; Fri, 22 Aug 1997 08:53:50 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id IAA22363 for <linux@cthulhu.engr.sgi.com>; Fri, 22 Aug 1997 08:53:46 -0700
Received: from athena.nuclecu.unam.mx (athena.nuclecu.unam.mx [132.248.29.9]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id IAA06602
	for <linux@cthulhu.engr.sgi.com>; Fri, 22 Aug 1997 08:53:35 -0700
	env-from (miguel@athena.nuclecu.unam.mx)
Received: (from miguel@localhost)
	by athena.nuclecu.unam.mx (8.8.5/8.8.5) id KAA17711;
	Fri, 22 Aug 1997 10:49:30 -0500
Date: Fri, 22 Aug 1997 10:49:30 -0500
Message-Id: <199708221549.KAA17711@athena.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: adevries@engsoc.carleton.ca
CC: linux@cthulhu.engr.sgi.com
In-reply-to: 
	<Pine.LNX.3.95.970821222908.6393A-100000@lager.engsoc.carleton.ca>
	(message from Alex deVries on Thu, 21 Aug 1997 22:43:00 -0400 (EDT))
Subject: Re: Kernel compile errors...
X-Windows: The first fully modular software disaster.
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


> I just checked out the latest kernel, and I get the following errors when
> I try to compile. Uh, what am I doing wrong?  I'm afraid MIPS assembler is
> above me.

Strange, I have been using the gcc and binutils packages put together
by Ralf for a long time, it is not the stock gcc/binutils, probably
this is your problem?

Miguel.
