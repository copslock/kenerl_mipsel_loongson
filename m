Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id TAA1108904; Fri, 25 Jul 1997 19:47:56 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id TAA01867 for linux-list; Fri, 25 Jul 1997 19:47:36 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id TAA01859 for <linux@cthulhu.engr.sgi.com>; Fri, 25 Jul 1997 19:47:31 -0700
Received: from athena.nuclecu.unam.mx (athena.nuclecu.unam.mx [132.248.29.9]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id TAA01455
	for <linux@cthulhu.engr.sgi.com>; Fri, 25 Jul 1997 19:47:30 -0700
	env-from (miguel@athena.nuclecu.unam.mx)
Received: (from miguel@localhost)
	by athena.nuclecu.unam.mx (8.8.5/8.8.5) id VAA14779;
	Fri, 25 Jul 1997 21:45:56 -0500
Date: Fri, 25 Jul 1997 21:45:56 -0500
Message-Id: <199707260245.VAA14779@athena.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: adevries@engsoc.carleton.ca
CC: linux@cthulhu.engr.sgi.com
In-reply-to: 
	<Pine.LNX.3.95.970725210238.19871Q-100000@lager.engsoc.carleton.ca>
	(message from Alex deVries on Fri, 25 Jul 1997 21:10:15 -0400 (EDT))
Subject: Re: Kernel compile problems...
X-Windows: Sometimes you fill a vacuum and it still sucks.
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


> (I'd like to absorb this in to the HOWTO, incidentally).
> 
> - I get the following compile error:
> 
> make[3]: Entering directory `/usr/src/adevries/linux/drivers/sgi/char'
> make all_targets
> make[4]: Entering directory `/usr/src/adevries/linux/drivers/sgi/char'
> mips-linux-gcc -D__KERNEL__ -I/usr/src/adevries/linux/include -Wall
> -Wstrict-prototypes -O2 -fomit-frame-pointer -G 0 -mno-abicalls -fno-pic
> -mcpu=r4600 -mips2 -pipe  -c -o graphics.o graphics.c
> graphics.c:33: asm/rrm.h: No such file or directory
> graphics.c: In function `sgi_graphics_ioctl':

Ok.  This is my fault, do not compile this module and you should be
fine.  I will try to commit all of my changes tomorrow (with my shmiq
code :-).

Miguel.
