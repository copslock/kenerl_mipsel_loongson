Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id TAA336581 for <linux-archive@neteng.engr.sgi.com>; Thu, 4 Dec 1997 19:07:43 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id TAA26900 for linux-list; Thu, 4 Dec 1997 19:05:48 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id TAA26839; Thu, 4 Dec 1997 19:05:19 -0800
Received: from dm.cobaltmicro.com ([209.19.61.51]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id TAA29458; Thu, 4 Dec 1997 19:05:14 -0800
	env-from (davem@dm.cobaltmicro.com)
Received: (from davem@localhost)
	by dm.cobaltmicro.com (8.8.7/8.8.7) id SAA09513;
	Thu, 4 Dec 1997 18:59:51 -0800
Date: Thu, 4 Dec 1997 18:59:51 -0800
Message-Id: <199712050259.SAA09513@dm.cobaltmicro.com>
From: "David S. Miller" <davem@dm.cobaltmicro.com>
To: rminnich@Sarnoff.COM
CC: alan@lxorguk.ukuu.org.uk, greg@xtp.engr.sgi.com,
        adevries@engsoc.carleton.ca, ralf@uni-koblenz.de,
        linux@cthulhu.engr.sgi.com, rpm-list@redhat.com
In-reply-to: <Pine.SUN.3.91.971204213811.11147A-100000@terra>
	(rminnich@Sarnoff.COM)
Subject: Re: A question about architecture and byte order with RPMs
References:  <Pine.SUN.3.91.971204213811.11147A-100000@terra>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

   Date: Thu, 4 Dec 1997 21:39:14 -0500 (EST)
   From: "Ron G. Minnich" <rminnich@Sarnoff.COM>

   On Thu, 4 Dec 1997, Alan Cox wrote:
   > Yeuch ;). Can't you get your guys to put that in the MMU so you can have
   > a little endian or big endian page ? I can see how you'd make lcc generate
   > such output but not offhand gcc

   If it's in the compiler:
   1) htonx and ntohx are history
   2) xdr is history

   not a bad deal in my book. Put it in the MMU? 2^yeuch. :-)

Some architectures (I believe both PPC and UltraSPARC) provide three
mechanisms to specify endiannes for load and store operations.

1) In processor status register, a "everything foo-endian" bit
   exists, there is also a "trap foo-endian" bit which states
   which endianness exception handlers run with.

2) Load and Store instructions can specify "endianness attributes"
   so for example on Sparc-V9 you can say

   lda	  [%addr_reg] ASI_PL, %dest_reg

   ASI means "Address Space Identifier" and PL means "Primary address
   space Little-endian".

3) Per-page MMU endianness attribute bits.  Those who casually
   disassemble the solaris kernel now and again will notice that the
   SLAB allocator in UltraSPARC kernels provides two sets of
   interfaces for allocation, one gives you little endian chunks the
   other gives you big-endian chunks.  They implement this by frobbing
   the PTE bits in the kernel mappings for these SLABs.

In the age of PCI, these three mechanism are super handy for
Big-Endian systems.  You get the best of both worlds, of interest
namely is:

1) No byte swapping for IP networking header processing.

2) Direct access to legacy PCI cards, in the correct PCI
   (ie. little endian) byte order, at zero cost.

3) Support for arbitrary endianness filesystem layouts, in
   core, again at zero cost.

Later,
David S. Miller
davem@dm.cobaltmicro.com
