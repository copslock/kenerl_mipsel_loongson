Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via SMTP id QAA53134 for <linux-archive@neteng.engr.sgi.com>; Fri, 27 Feb 1998 16:36:56 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id QAA17213 for linux-list; Fri, 27 Feb 1998 16:35:54 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA17193 for <linux@cthulhu.engr.sgi.com>; Fri, 27 Feb 1998 16:35:52 -0800
Received: from athena.nuclecu.unam.mx (athena.nuclecu.unam.mx [132.248.29.9]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id QAA04404
	for <linux@cthulhu.engr.sgi.com>; Fri, 27 Feb 1998 16:35:45 -0800
	env-from (miguel@athena.nuclecu.unam.mx)
Received: (from miguel@localhost)
	by athena.nuclecu.unam.mx (8.8.7/8.8.7) id SAA07976;
	Fri, 27 Feb 1998 18:35:29 -0600
Date: Fri, 27 Feb 1998 18:35:29 -0600
Message-Id: <199802280035.SAA07976@athena.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: grimsy@varberg.se
CC: ralf@uni-koblenz.de, linux@cthulhu.engr.sgi.com
In-reply-to: <Pine.LNX.3.96.980228002935.8121A-100000@calypso.saturn> (message
	from Ulf Carlsson on Sat, 28 Feb 1998 00:42:15 +0100 (CET))
Subject: Re: installation problem.
X-Unix: is friendly, it is just selective about who its friends are.
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


> Is it possible to use MIPS/Linux yet, or is it too buggy? How much of the
> X code is done? Are any of the SGI special devices, such as the cool
> functions on the video card supported yet? Which kernel runs
> linux.sgi.com (this one seems to be quite stable).

There is little code for the free X11 server written.  I can send my
bits to whoever wants them (they are based on what the kernel supports
for the IRIX X emulation, so we will end up supporting a scheme very
similar to what the IRIX X server has).

Miguel.
