Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA00207; Fri, 13 Jun 1997 18:06:13 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id SAA08495 for linux-list; Fri, 13 Jun 1997 18:05:07 -0700
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA08453; Fri, 13 Jun 1997 18:04:59 -0700
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id SAA00318; Fri, 13 Jun 1997 18:04:55 -0700
Date: Fri, 13 Jun 1997 18:04:55 -0700
Message-Id: <199706140104.SAA00318@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Ralf Baechle <ralf@Julia.DE>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: Kernel load address
In-Reply-To: <199706140029.CAA08292@kernel.panic.julia.de>
References: <199706140029.CAA08292@kernel.panic.julia.de>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ralf Baechle writes:
 > Hi,
 > 
 > on SGI we load the kernel to the address 0x88069000.  See arch/mips/Makefile.
 > Is there any special reason for that address?

      Indy memory (unlike memory on many other SGI systems) starts
as physical address 0x08000000, so this is a little above the beginning
of memory.  (0x88000000 is the K0SEG address for the start of memory.)
The first 512 KB of memory is also mapped at physical address 0, so
that the exception vectors can be addresses.  Production IRIX kernels
are linked at 0x88002000.  Debug IRIX kernels are linked at about
0x88069000 to leave room for symmon, the IRIX resident kernel debugger.
