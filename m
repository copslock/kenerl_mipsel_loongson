Received:  by oss.sgi.com id <S305156AbQBOTAn>;
	Tue, 15 Feb 2000 11:00:43 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:15991 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305160AbQBOTAA>; Tue, 15 Feb 2000 11:00:00 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id LAA03337; Tue, 15 Feb 2000 11:02:52 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA31962
	for linux-list;
	Tue, 15 Feb 2000 10:46:48 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from liveoak.engr.sgi.com (liveoak.engr.sgi.com [163.154.5.24])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA69511
	for <linux@relay.engr.sgi.com>;
	Tue, 15 Feb 2000 10:46:45 -0800 (PST)
	mail_from (wje@liveoak.engr.sgi.com)
Received: (from wje@localhost)
	by liveoak.engr.sgi.com (8.9.3/8.8.7) id KAA15400
	for linux@engr.sgi.com; Tue, 15 Feb 2000 10:46:38 -0800
Date:   Tue, 15 Feb 2000 10:46:38 -0800
Message-Id: <200002151846.KAA15400@liveoak.engr.sgi.com>
X-Authentication-Warning: liveoak.engr.sgi.com: wje set sender to wje@liveoak.engr.sgi.com using -f
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
From:   geert@linux-m68k.org
To:     "Kevin D. Kissell" <kevink@mips.com>
cc:     linux@cthulhu.engr.sgi.com
Subject: Re: ioremap() broken?
In-Reply-To: <021c01bf772b$773033d0$0ceca8c0@satanas.mips.com>
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Mon, 14 Feb 2000, Kevin D. Kissell wrote:
> >in asm-mips/io.h we have:
> >
> >    extern inline void * ioremap(unsigned long offset, unsigned long size)
> >    {
> >     return (void *) KSEG1ADDR(offset);
> >    }
> >
> >    #define readb(addr) (*(volatile unsigned char *) (0xa0000000 + (unsigned
> long)(addr)))
> >
> >
> >and in asm-mips/addrspace.h:
> >
> >    #define KSEG1                   0xa0000000
> >
> >    #define KSEG1ADDR(a)            ((__typeof__(a))(((unsigned long)(a) &
> 0x1fffffff) | KSEG1))
> >
> >
> >Hence if I map physical address range 0x1fa00300-0x1fa0033f and read from it:
> >
> >     mapped = ioremap(0x1fa00300, 0x40); /* returns 0xbfa00300 */
> >     data = readb(mapped+0x20);
> >
> >then this fails miserably with
> >
> >    Unable to handle kernel paging request at virtual address 5fa00320
> >
> >
> >My questions:
> >
> > 1. Is it really necessary to add anything to the addr in the readb() et al.
> >    macros? ioremap() already takes care of that.
> 
> There is something of an "embarassment of riches" in the kernel
> code in terms of mechanism for getting at I/O resources.  I don't
> think it was ever intended that people use readb() on addresses
> that had already been massaged with ioremap().  ioremap() is
> used where the driver *expects* an memory-mapped I/O model,
> and is applied to pointers that will be used to directly reference
> the device.  readb/writeb et. al. are for drivers that think that expect
> a more peek/poke like model.  I don't think it was ever intended that
> someone apply both at once!

Yes it is! Please read Documentation/IO-mapping.txt. To access PCI memory
space, you have to use ioremap() and readb() and friends. If PCI drivers have
to work across differen architectures, this has to be fixed.

> >Furthermore I see problems with
> >
> >    #define isa_readb(a) readb(a)
> >
> >since ISA I/O space is not at 0xa0000000 but at 0xa6000000 on the NEC DDB
> >Vrc-5074. Don't we need an offset mips_io_mem_base, like is done on most other
> >non-ia32 architectures (cfr. mips_io_port_base for inb() and friends)?
> 

Oops, I screwed up my explanation and exchanged memory/I/O space. I intended to
write

    ... since ISA memory space is not at 0xa0000000 but at 0xa8000000 on the
                  ^^^^^^                                   ^^^^^^^^^^
    NEC DDB Vrc-5074.

> Isn't there an isa_slot_offset declaration?  Odd.  Even the
> i386 has a __ISA_IO_base in the definition.

We have mips_io_port_base (cfr. __ISA_IO_base), but we don't have such a thing
for ISA memory space.

> Anyway, the general problem is even worse than you think,
> since - never mind any ISA nonsense - the function that maps
> PCI memory into the CPU space is in theory independent of
> the function that maps CPU memory into the PCI space (for
> DMA or whatever).  So the following functions may be needed

I know.

> in addition to ioremap.  Note that these key off a
> platform_mem_iobus_base (the base of memory as seen
> on the I/O bus) as opposed to platform_io_mem_base
> (the base of I/O space seen as memory).  These base
> addresses, in our version anyway, are declared in
> arch/mips/kernel./setup.c and can be modified in the
> platform setup code before any I/O macros are invoked.
> 
> extern inline unsigned long virt_to_bus(volatile void * address)
> {
>         extern unsigned long  platform_mem_iobus_base;
> 
>         return (PHYSADDR(address) | platform_mem_iobus_base);
> }
> 
> extern inline void * bus_to_virt(unsigned long address)
> {
>         extern unsigned long  platform_mem_iobus_base;
> 
>         return (void *)KSEG0ADDR((address & ~platform_mem_iobus_base));
> }

These are no problem. The problem is that the values returned by ioremap()
canot be used with readb() et al.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248632 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium
