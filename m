Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id TAA1115337 for <linux-archive@neteng.engr.sgi.com>; Thu, 4 Sep 1997 19:54:10 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id TAA07587 for linux-list; Thu, 4 Sep 1997 19:52:43 -0700
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id TAA07581 for <linux@cthulhu.engr.sgi.com>; Thu, 4 Sep 1997 19:52:42 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id TAA07029 for <linux@fir.engr.sgi.com>; Thu, 4 Sep 1997 19:52:40 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id TAA07574 for <linux@fir.engr.sgi.com>; Thu, 4 Sep 1997 19:52:39 -0700
Received: from athena.nuclecu.unam.mx (athena.nuclecu.unam.mx [132.248.29.9]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id TAA24464
	for <linux@fir.engr.sgi.com>; Thu, 4 Sep 1997 19:52:37 -0700
	env-from (miguel@athena.nuclecu.unam.mx)
Received: (from miguel@localhost)
	by athena.nuclecu.unam.mx (8.8.5/8.8.5) id VAA03103;
	Thu, 4 Sep 1997 21:45:31 -0500
Date: Thu, 4 Sep 1997 21:45:31 -0500
Message-Id: <199709050245.VAA03103@athena.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: linux@fir.engr.sgi.com
Subject: [Q: Linux/SGI] IRIX executable memory map.
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Hello guys,

    Ok, it seems our irix_elfmap routine is just fine, I just found
out with a simple test case that the code is trying to access memory
from the location at 0x200000 which is making my IRIX executables
crash (this one is crashing inside usinit ()).

    Is there something magic about 0x20000 on IRIX that I should be
aware of? 

    This 0x20000 location is quite strange to me, since this is not a
region of memory that happens to be part of the executable according
to gdb (look at exhibit [1]).  So, if it does not come from here, the
obvious guess is that this memory region comes from mmaping something:
either /dev/zero, or from the sys_sgi (ELFMAP) system call, but
neither par nor strace show any trace of a virual mapping taking place
in this region (exhibit [2] shows this).

     The exact location of the crash is shown on my third dump [3].

Best wishes,
Miguel.

Exhibit [1]: Local exec file image, from gdb.
        Entry point: 0x400870
        0x00400134 - 0x00400147 is .interp
        0x004001c8 - 0x004001e0 is .reginfo
        0x004001e0 - 0x004002d8 is .dynamic
        0x004002d8 - 0x004002ec is .liblist
        0x0040050c - 0x0040070c is .dynsym
        0x004002ec - 0x00400401 is .dynstr
        0x00400404 - 0x0040050c is .hash
        0x0040072c - 0x0040082c is .msym
        0x0040082c - 0x00400870 is .MIPS.stubs
        0x00400870 - 0x00400a00 is .text
        0x00400a00 - 0x00400a20 is .init
        0x10001000 - 0x10001010 is .rodata
        0x10001010 - 0x10001048 is .got
        0x10001048 - 0x10001054 is .bss

Exhibit [2]: par output from running simple test program:
    2mS    usinit( 5349): execve(./usinit, 0x7fff2f64, 0x7fff2f6c) OK
    5mS    usinit( 5349): open(/lib/rld, O_RDONLY, 04) = 3
    5mS    usinit( 5349): read(3, <7f 45 4c 46 01 02 01 00 00 00 00>...,512) = 512 
    5mS    usinit( 5349): elfmap(3, 0x7fff2d58, 2) = 0xfb60000
    6mS    usinit( 5349): close(3) OK
    6mS    usinit( 5349): getpagesize() = 4096
    6mS    usinit( 5349): open(/dev/zero, O_RDONLY, 01757022324) = 3
    7mS    usinit( 5349): mmap(0xfbc4000, 16384, PROT_WRITE|PROT_READ,
			       MAP_PRIVATE, 3, 0) = 0xfbc4000
    7mS    usinit( 5349): close(3) OK
    9mS    usinit( 5349): syssgi(SGI_USE_FP_BCOPY, 0, 0x1dc,
				0xffffffff, 0x7fff2d70, 0xfb8eee8) = 0
    9mS    usinit( 5349): open(/dev/zero, O_RDONLY, 01757022324) = 3
    9mS    usinit( 5349): mmap(0xfbc8000, 32768, PROT_WRITE|PROT_READ,
				MAP_PRIVATE, 3, 0) = 0xfbc8000
    9mS    usinit( 5349): close(3) OK
    9mS    usinit( 5349): syssgi(SGI_TOSSTSAVE) OK
    9mS    usinit( 5349): write(2, "Test\n", 5) = 5
The IRIX program crashes here when running on Linux. 
   10mS    usinit( 5349): sysmp(MP_NPROCS) = 1
   10mS    usinit( 5349): open(tm, O_RDWR, 016) = 3
   10mS    usinit( 5349): fcntl(3, F_SETFD, 1) OK
   10mS    usinit( 5349): fcntl(3, F_SETLKW, type=F_WRLCK
				whence=SEEK_SET start=0 len=1) OK
   10mS    usinit( 5349): syssgi(SGI_USE_FP_BCOPY, 0x1000, 0x7fff1d5c,
				0xffffffff, 0x10001008, 0x7fff2fc0) = 0
   11mS    usinit( 5349): read(3, <de ad ba be 00 00 00 05 00 44 05 50
	00 44 05 a0>..., 4096) = 4096
[more system calls deleted]


Exhibit [3]:

The culprit piece of code, taken from the IRIX libc:

0xfa52a10 <_usinit+44>: lui $t6,0x20
0xfa52a14 <_usinit+48>: lw $t7,3584($t6)        <- This one is the culprit

This is loading something from 0x200e00
