Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id SAA1041382; Fri, 25 Jul 1997 18:11:06 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id SAA15366 for linux-list; Fri, 25 Jul 1997 18:10:39 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA15349 for <linux@cthulhu.engr.sgi.com>; Fri, 25 Jul 1997 18:10:35 -0700
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id SAA15312
	for <linux@cthulhu.engr.sgi.com>; Fri, 25 Jul 1997 18:10:34 -0700
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
          by lager.engsoc.carleton.ca (8.8.5/8.8.4) with SMTP
	  id VAA15877 for <linux@cthulhu.engr.sgi.com>; Fri, 25 Jul 1997 21:10:16 -0400
Date: Fri, 25 Jul 1997 21:10:15 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
cc: linux@cthulhu.engr.sgi.com
Subject: Kernel compile problems...
In-Reply-To: <199707251916.OAA11145@athena.nuclecu.unam.mx>
Message-ID: <Pine.LNX.3.95.970725210238.19871Q-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


I cvs'd out the kernel this evening, and I tried compiling it.

The compiling tools I'm using are the same ones in the crossdev directory
on linus.linux.sgi.com (and I've converted _those_ to RPM's, for your
installation convenience).

I got the following problems with compiling it:

- in scripts/mkdep.c, in the mmap() function, references MAP_AUTOGROW,
which is unknown.  I just removed it out for my compile.

- in Ariel's instructiosn on how to cross compile a kernel, it says to use 
make CROSS_COMPILE=mips-linux CONFIG_SHELL=/usr/freeware/bin/bash

But, the compile then can't find mips-linuxgcc .  Apparantly, using:
make CROSS_COMPILE=mips-linux- CONFIG_SHELL=/usr/freeware/bin/bash
                            ^^^
works.

(I'd like to absorb this in to the HOWTO, incidentally).

- I get the following compile error:

make[3]: Entering directory `/usr/src/adevries/linux/drivers/sgi/char'
make all_targets
make[4]: Entering directory `/usr/src/adevries/linux/drivers/sgi/char'
mips-linux-gcc -D__KERNEL__ -I/usr/src/adevries/linux/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer -G 0 -mno-abicalls -fno-pic
-mcpu=r4600 -mips2 -pipe  -c -o graphics.o graphics.c
graphics.c:33: asm/rrm.h: No such file or directory
graphics.c: In function `sgi_graphics_ioctl':
graphics.c:56: `RRM_BASE' undeclared (first use this function)
graphics.c:56: (Each undeclared identifier is reported only once
graphics.c:56: for each function it appears in.)
graphics.c:56: `RRM_CMD_LIMIT' undeclared (first use this function)
graphics.c:57: warning: implicit declaration of function `rrm_command'
graphics.c: In function `sgi_graphics_close':
graphics.c:151: warning: implicit declaration of function `rrm_close'
graphics.c: In function `sgi_graphics_nopage':
graphics.c:168: structure has no member named `vm_inode'
graphics.c: In function `sgi_graphics_mmap':
graphics.c:225: structure has no member named `vm_inode'
graphics.c:226: warning: passing arg 2 of `atomic_add' from incompatible
pointer type
graphics.c: In function `gfx_init':
graphics.c:282: warning: implicit declaration of function `prom_halt'
make[4]: *** [graphics.o] Error 1
make[4]: Leaving directory `/usr/src/adevries/linux/drivers/sgi/char'
make[3]: *** [first_rule] Error 2
make[3]: Leaving directory `/usr/src/adevries/linux/drivers/sgi/char'
make[2]: *** [sub_dirs] Error 2
make[2]: Leaving directory `/usr/src/adevries/linux/drivers/sgi'
make[1]: *** [sub_dirs] Error 2
make[1]: Leaving directory `/usr/src/adevries/linux/drivers'
make: *** [linuxsubdirs] Error 2
lager 9:07pm {2}

- Alex

      Alex deVries              Success is realizing 
  System Administrator          attainable dreams.
   The EngSoc Project     
