Received:  by oss.sgi.com id <S305166AbQBNW0w>;
	Mon, 14 Feb 2000 14:26:52 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:57718 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305156AbQBNW0p>;
	Mon, 14 Feb 2000 14:26:45 -0800
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id OAA15045; Mon, 14 Feb 2000 14:22:15 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id OAA78409; Mon, 14 Feb 2000 14:26:14 -0800 (PST)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA00903
	for linux-list;
	Mon, 14 Feb 2000 12:36:55 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA89678
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 14 Feb 2000 12:36:48 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from mx.mips.com (mx.mips.com [206.31.31.226]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA07574
	for <linux@cthulhu.engr.sgi.com>; Mon, 14 Feb 2000 12:36:47 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from newman.mips.com (newman [206.31.31.8])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id MAA18487;
	Mon, 14 Feb 2000 12:36:39 -0800 (PST)
Received: from satanas (satanas [192.168.236.12])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id MAA22564;
	Mon, 14 Feb 2000 12:36:36 -0800 (PST)
Message-ID: <021c01bf772b$773033d0$0ceca8c0@satanas.mips.com>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     <geert@linux-m68k.org>, <linux@cthulhu.engr.sgi.com>
Subject: Re: ioremap() broken?
Date:   Mon, 14 Feb 2000 21:38:29 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 4.72.3110.5
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3110.3
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

>in asm-mips/io.h we have:
>
>    extern inline void * ioremap(unsigned long offset, unsigned long size)
>    {
>     return (void *) KSEG1ADDR(offset);
>    }
>
>    #define readb(addr) (*(volatile unsigned char *) (0xa0000000 + (unsigned
long)(addr)))
>
>
>and in asm-mips/addrspace.h:
>
>    #define KSEG1                   0xa0000000
>
>    #define KSEG1ADDR(a)            ((__typeof__(a))(((unsigned long)(a) &
0x1fffffff) | KSEG1))
>
>
>Hence if I map physical address range 0x1fa00300-0x1fa0033f and read from it:
>
>     mapped = ioremap(0x1fa00300, 0x40); /* returns 0xbfa00300 */
>     data = readb(mapped+0x20);
>
>then this fails miserably with
>
>    Unable to handle kernel paging request at virtual address 5fa00320
>
>
>My questions:
>
> 1. Is it really necessary to add anything to the addr in the readb() et al.
>    macros? ioremap() already takes care of that.

There is something of an "embarassment of riches" in the kernel
code in terms of mechanism for getting at I/O resources.  I don't
think it was ever intended that people use readb() on addresses
that had already been massaged with ioremap().  ioremap() is
used where the driver *expects* an memory-mapped I/O model,
and is applied to pointers that will be used to directly reference
the device.  readb/writeb et. al. are for drivers that think that expect
a more peek/poke like model.  I don't think it was ever intended that
someone apply both at once!

Furthermore, there are some platforms where a further transformation
is necessary to get from a PCI-relative memory-mapped I/O address
to a CPU address on the MIPS platform, thus in our io.h we have:

extern inline void * ioremap(unsigned long offset, unsigned long size)
{
        extern unsigned long platform_io_mem_base;
        return (void *) KSEG1ADDR(offset | platform_io_mem_base);
}


> 2. If yes, isn't it better to or (`|') instead of add ('+') 0xa0000000 in the
>    readb() et al. macros (or to use the macro KSEG1ADDR())?


One could make that argument.  Others might say that addition is
an more mnemonic operation for adding a base displacement.
The results will be, one hopes, the same.   But it's a fair question
as to why KSEG1ADDR isn't used in preference indeed, it is in
the MIPS 2.2.12 distribution.

>FYI, I'm trying to make the UART in the NEC Vrc-5074 hosty bridge work cleanly
>with serial.c. And serial.c first ioremap()s it.

The ioremap/readb stuff is only in the latest versions of serial.c,
(newer that I run with, anyway), and yes, you are right, it's broken.

>Furthermore I see problems with
>
>    #define isa_readb(a) readb(a)
>
>since ISA I/O space is not at 0xa0000000 but at 0xa6000000 on the NEC DDB
>Vrc-5074. Don't we need an offset mips_io_mem_base, like is done on most other
>non-ia32 architectures (cfr. mips_io_port_base for inb() and friends)?

Isn't there an isa_slot_offset declaration?  Odd.  Even the
i386 has a __ISA_IO_base in the definition.

Anyway, the general problem is even worse than you think,
since - never mind any ISA nonsense - the function that maps
PCI memory into the CPU space is in theory independent of
the function that maps CPU memory into the PCI space (for
DMA or whatever).  So the following functions may be needed
in addition to ioremap.  Note that these key off a
platform_mem_iobus_base (the base of memory as seen
on the I/O bus) as opposed to platform_io_mem_base
(the base of I/O space seen as memory).  These base
addresses, in our version anyway, are declared in
arch/mips/kernel./setup.c and can be modified in the
platform setup code before any I/O macros are invoked.

extern inline unsigned long virt_to_bus(volatile void * address)
{
        extern unsigned long  platform_mem_iobus_base;

        return (PHYSADDR(address) | platform_mem_iobus_base);
}

extern inline void * bus_to_virt(unsigned long address)
{
        extern unsigned long  platform_mem_iobus_base;

        return (void *)KSEG0ADDR((address & ~platform_mem_iobus_base));
}


So, while we didn't put in the isa support, we did do a certain
amount at MIPS to make arbitrary PCI platforms work with MIPS.
You can snarf it from http://www.paralogos.com/mipslinux/ and
see what I mean.

And yes, one of these days, somebody needs to merge it into
the SGI 2.3.x tree...

            Regards,

            Kevin K.
