Received:  by oss.sgi.com id <S305166AbQBNSut>;
	Mon, 14 Feb 2000 10:50:49 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:23145 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305156AbQBNSug>; Mon, 14 Feb 2000 10:50:36 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id KAA08240; Mon, 14 Feb 2000 10:53:19 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA50295
	for linux-list;
	Mon, 14 Feb 2000 10:40:38 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from liveoak.engr.sgi.com (liveoak.engr.sgi.com [163.154.5.24])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA32691
	for <linux@relay.engr.sgi.com>;
	Mon, 14 Feb 2000 10:40:36 -0800 (PST)
	mail_from (wje@liveoak.engr.sgi.com)
Received: (from wje@localhost)
	by liveoak.engr.sgi.com (8.9.3/8.8.7) id KAA13040
	for linux@engr.sgi.com; Mon, 14 Feb 2000 10:40:12 -0800
Date:   Mon, 14 Feb 2000 10:40:12 -0800
Message-Id: <200002141840.KAA13040@liveoak.engr.sgi.com>
X-Authentication-Warning: liveoak.engr.sgi.com: wje set sender to wje@liveoak.engr.sgi.com using -f
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
From:   geert@linux-m68k.org
To:     linux@cthulhu.engr.sgi.com
Subject: ioremap() broken?
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


in asm-mips/io.h we have:

    extern inline void * ioremap(unsigned long offset, unsigned long size)
    {
	    return (void *) KSEG1ADDR(offset);
    }

    #define readb(addr) (*(volatile unsigned char *) (0xa0000000 + (unsigned long)(addr)))


and in asm-mips/addrspace.h:

    #define KSEG1                   0xa0000000

    #define KSEG1ADDR(a)            ((__typeof__(a))(((unsigned long)(a) & 0x1fffffff) | KSEG1))


Hence if I map physical address range 0x1fa00300-0x1fa0033f and read from it:

     mapped = ioremap(0x1fa00300, 0x40);	/* returns 0xbfa00300 */
     data = readb(mapped+0x20);

then this fails miserably with

    Unable to handle kernel paging request at virtual address 5fa00320


My questions:

 1. Is it really necessary to add anything to the addr in the readb() et al.
    macros? ioremap() already takes care of that.
 
 2. If yes, isn't it better to or (`|') instead of add ('+') 0xa0000000 in the
    readb() et al. macros (or to use the macro KSEG1ADDR())?


FYI, I'm trying to make the UART in the NEC Vrc-5074 hosty bridge work cleanly
with serial.c. And serial.c first ioremap()s it.


Furthermore I see problems with

    #define isa_readb(a) readb(a)

since ISA I/O space is not at 0xa0000000 but at 0xa6000000 on the NEC DDB
Vrc-5074. Don't we need an offset mips_io_mem_base, like is done on most other
non-ia32 architectures (cfr. mips_io_port_base for inb() and friends)?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248632 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium
