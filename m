Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id NAA07675; Tue, 5 Aug 1997 13:38:39 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id MAA14662 for linux-list; Tue, 5 Aug 1997 12:20:35 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA14632 for <linux@cthulhu.engr.sgi.com>; Tue, 5 Aug 1997 12:20:31 -0700
Received: from athena.nuclecu.unam.mx (athena.nuclecu.unam.mx [132.248.29.9]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id MAA22371
	for <linux@cthulhu.engr.sgi.com>; Tue, 5 Aug 1997 12:20:29 -0700
	env-from (miguel@athena.nuclecu.unam.mx)
Received: (from miguel@localhost)
	by athena.nuclecu.unam.mx (8.8.5/8.8.5) id OAA29577;
	Tue, 5 Aug 1997 14:19:27 -0500
Date: Tue, 5 Aug 1997 14:19:27 -0500
Message-Id: <199708051919.OAA29577@athena.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: schaefer@dsai.com
CC: linux@cthulhu.engr.sgi.com
In-reply-to: <9708050920.ZM6923@ratbert.daic.dsai.com> (schaefer@dsai.com)
Subject: Re: Kernel instructions...
X-Mexico: Este es un pais de orates, un pais amateur.
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


> 	  Are there any further instructions on how to install the Linux kernel
> after it's been compiled?  I know IRIX will automatically install unix.new on
> bootup, is there some method like that to use?  Is there a reason MILO is
> included on the ftp site?

Just copy your kernel to an EFS/XFS accessible partition and then when
booting your Indy, go to the mainteinance mode, from there go to the
monitor and type:

	boot /vmlinux

Miguel.
