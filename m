Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id TAA23263; Mon, 14 Apr 1997 19:19:15 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id TAA09271 for linux-list; Mon, 14 Apr 1997 19:18:23 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id TAA09255; Mon, 14 Apr 1997 19:18:20 -0700
Received: from caipfs.rutgers.edu (caipfs.rutgers.edu [128.6.91.100]) by sgi.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id TAA17502; Mon, 14 Apr 1997 19:18:16 -0700
Received: from jenolan.caipgeneral (jenolan.rutgers.edu [128.6.111.5])
	by caipfs.rutgers.edu (8.8.5/8.8.5) with SMTP id WAA08888;
	Mon, 14 Apr 1997 22:14:29 -0400 (EDT)
Received: by jenolan.caipgeneral (SMI-8.6/SMI-SVR4)
	id WAA00944; Mon, 14 Apr 1997 22:13:11 -0400
Date: Mon, 14 Apr 1997 22:13:11 -0400
Message-Id: <199704150213.WAA00944@jenolan.caipgeneral>
From: "David S. Miller" <davem@jenolan.rutgers.edu>
To: ariel@sgi.com
CC: mikemac@titian.engr.sgi.com, linux@cthulhu.engr.sgi.com
In-reply-to: <199704141835.LAA13936@yon.engr.sgi.com> (ariel@yon.engr.sgi.com)
Subject: Re: How big is the Linux/MIPS kernel?
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


There was a bug in the linker/assembler/gcc that I don't recall if I
fixed for the kernel build tools.  What it would do is leave the
symbol information for all local compiler generated symbols in the
kernel image (the problem was gcc was generating local symbols using
one convention and the linker/assembler were expecting them to be in
another format, so they just got left in the symbol table).

This would cut down the size of the Linux kernel quite a bit.  I know
I fixed it in the userland gcc because this bug prevented some
important programs (lat_ctx ;-) from compiling due to ELF symbol table
overflows.

---------------------------------------------////
Yow! 11.26 MB/s remote host TCP bandwidth & ////
199 usec remote TCP latency over 100Mb/s   ////
ethernet.  Beat that!                     ////
-----------------------------------------////__________  o
David S. Miller, davem@caip.rutgers.edu /_____________/ / // /_/ ><
