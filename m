Received:  by oss.sgi.com id <S305169AbQBOCY6>;
	Mon, 14 Feb 2000 18:24:58 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:42034 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305156AbQBOCYv>; Mon, 14 Feb 2000 18:24:51 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id SAA02482; Mon, 14 Feb 2000 18:27:43 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id SAA82862
	for linux-list;
	Mon, 14 Feb 2000 18:11:48 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id SAA22525
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 14 Feb 2000 18:11:45 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id SAA00838
	for <linux@cthulhu.engr.sgi.com>; Mon, 14 Feb 2000 18:11:44 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-16.uni-koblenz.de (cacc-16.uni-koblenz.de [141.26.131.16])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id DAA07197;
	Tue, 15 Feb 2000 03:11:41 +0100 (MET)
Received:  by lappi.waldorf-gmbh.de id <S407895AbQBOCKs>;
	Tue, 15 Feb 2000 03:10:48 +0100
Date:   Tue, 15 Feb 2000 03:10:48 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     geert@linux-m68k.org
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: ioremap() broken?
Message-ID: <20000215031048.J828@uni-koblenz.de>
References: <200002141840.KAA13040@liveoak.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <200002141840.KAA13040@liveoak.engr.sgi.com>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Mon, Feb 14, 2000 at 10:40:12AM -0800, geert@linux-m68k.org wrote:

> in asm-mips/io.h we have:
> 
>     extern inline void * ioremap(unsigned long offset, unsigned long size)
>     {
> 	    return (void *) KSEG1ADDR(offset);
>     }
> 
>     #define readb(addr) (*(volatile unsigned char *) (0xa0000000 + (unsigned long)(addr)))
> 
> 
> and in asm-mips/addrspace.h:
> 
>     #define KSEG1                   0xa0000000
> 
>     #define KSEG1ADDR(a)            ((__typeof__(a))(((unsigned long)(a) & 0x1fffffff) | KSEG1))
> 
> 
> Hence if I map physical address range 0x1fa00300-0x1fa0033f and read from it:
> 
>      mapped = ioremap(0x1fa00300, 0x40);	/* returns 0xbfa00300 */
>      data = readb(mapped+0x20);
> 
> then this fails miserably with
> 
>     Unable to handle kernel paging request at virtual address 5fa00320
> 
> 
> My questions:
> 
>  1. Is it really necessary to add anything to the addr in the readb() et al.
>     macros? ioremap() already takes care of that.
>  
>  2. If yes, isn't it better to or (`|') instead of add ('+') 0xa0000000 in the
>     readb() et al. macros (or to use the macro KSEG1ADDR())?
> 
> 
> FYI, I'm trying to make the UART in the NEC Vrc-5074 hosty bridge work cleanly
> with serial.c. And serial.c first ioremap()s it.
> 
> 
> Furthermore I see problems with
> 
>     #define isa_readb(a) readb(a)
> 
> since ISA I/O space is not at 0xa0000000 but at 0xa6000000 on the NEC DDB
> Vrc-5074. Don't we need an offset mips_io_mem_base, like is done on most other
> non-ia32 architectures (cfr. mips_io_port_base for inb() and friends)?

This is mostly historical garbage.  Looong time ago we didn't have well
defined semantics for ioremap() and readb() etc.  As the result we had a
wild mix of drivers some of which were feeding physical addresses, others
virtual addresses as the arguments to readb - and some did a even wilder
things.  Only few of the drivers we're commonly using with the supported
platforms rely on these functions so the way they are represents something
that is made up to get those few drivers working.

Time to get those things into the shape they're suppose to be, these days
pretty much every new MIPS system is also PCI based.

(I'll try to fix the RM200 support sometime soon.  That should fix all
the (E)ISA and PCI related things in one go.)

  Ralf
