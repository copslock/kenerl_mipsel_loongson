Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id AAA604882 for <linux-archive@neteng.engr.sgi.com>; Thu, 26 Feb 1998 00:30:55 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id AAA06935 for linux-list; Thu, 26 Feb 1998 00:30:22 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id AAA06919 for <linux@cthulhu.engr.sgi.com>; Thu, 26 Feb 1998 00:30:18 -0800
Received: from netscape.com (h-205-217-237-47.netscape.com [205.217.237.47]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id AAA18430
	for <linux@cthulhu.engr.sgi.com>; Thu, 26 Feb 1998 00:30:17 -0800
	env-from (shaver@netscape.com)
Received: from dredd.mcom.com (dredd.mcom.com [205.217.237.54])
	by netscape.com (8.8.5/8.8.5) with ESMTP id AAA26593
	for <linux@cthulhu.engr.sgi.com>; Thu, 26 Feb 1998 00:30:15 -0800 (PST)
Received: from netscape.com ([205.217.243.3]) by dredd.mcom.com
          (Netscape Messaging Server 3.5)  with ESMTP id AAA284C;
          Thu, 26 Feb 1998 00:30:13 -0800
Message-ID: <34F50934.7C766D2C@netscape.com>
Date: Wed, 25 Feb 1998 22:18:28 -0800
From: Mike Shaver <shaver@netscape.com>
Organization: Package Reflectors
X-Mailer: Mozilla 4.02 [en] (X11; U; IRIX 6.2 IP22)
MIME-Version: 1.0
To: Ulf Carlsson <grimsy@varberg.se>
CC: linux@cthulhu.engr.sgi.com
Subject: Re: installation problem.
References: <Pine.LNX.3.96.980226085920.2193D-100000@calypso.saturn>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ulf Carlsson wrote:
> It's also very strange that the kernel doesn't detect my scsi harddrives
> correctly (I have reported these error messages earlier). I tested fx, and
> fx detected them correctly. I get the same error with my orginal sgi
> harddrive which obviously works, since irix doesn't have any problems with
> it.

Oh...is that drive SCSI id 7?  I had problems with one of my drives
(which was happy under IRIX) until I changed the id to something other
than 7.
 
> I'll take a look in the kernel source and try to figure out what's causing
> that kernel paging error.

You want to run mips-linux-objdump to get a function+offset (or, if that
kernel was compiled -g, line number info) for the fault, and then we can
try to debug it.

Mike
