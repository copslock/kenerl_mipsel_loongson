Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4AKFbw13097
	for linux-mips-outgoing; Thu, 10 May 2001 13:15:37 -0700
Received: from mail.foobazco.org (snowman.foobazco.org [198.144.194.230])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4AKFaF13094
	for <linux-mips@oss.sgi.com>; Thu, 10 May 2001 13:15:36 -0700
Received: by mail.foobazco.org (Postfix, from userid 1014)
	id 689B9F1A9; Thu, 10 May 2001 13:14:31 -0700 (PDT)
Date: Thu, 10 May 2001 13:14:31 -0700
From: Keith M Wesolowski <wesolows@foobazco.org>
To: Pete Popov <ppopov@mvista.com>
Cc: Wayne Gowcher <wgowcher@yahoo.com>,
   Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, linux-mips@oss.sgi.com
Subject: Re: Configuration of PCI Video card on a BIOS-less board
Message-ID: <20010510131431.A27228@foobazco.org>
References: <20010510175339.83183.qmail@web11904.mail.yahoo.com> <3AFADA29.674BA111@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AFADA29.674BA111@mvista.com>; from ppopov@mvista.com on Thu, May 10, 2001 at 11:12:57AM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, May 10, 2001 at 11:12:57AM -0700, Pete Popov wrote:

> I'm not clear on how this works with the good driver. If you write to
> 0xC000 0000, that's a mips virtual address in the kseg2 region, which is
> a mapped region.  So what physical address you put on the bus when you
> write to 0xC000 0000 depends on the tlb entry you've setup.  If 0xC000
> 0000 is truly a PCI memory physical address, then you need to setup a

Repeat after me until done: BAR values have nothing to do with CPU
addresses.  If your PCI bus happens to map PCI memory location 0 onto
physical address 0, then they are the same.  That's almost certainly
not the case.  Otherwise, an address in a BAR is the *PCI bus
address*, NOT a CPU physical address.

A simple example: a PCI bridge exists in a system.  It is wired into
the CPU address bus such that it responds to 0x18000000-0x19ffffff
physical.  On the other side of the bridge, it maps
0x00000000-0x7fffffff bus addresses onto physical memory (for DMA),
and 0x80000000-0xffffffff onto PCI memory space (for PIO).  The bridge
translates addresses such that:

bus_address_for_BARs == 0x80000000 + (cpu_physical_address - 0x18000000)
bus_address_for_DMA == cpu_physical_address

and, of course,

cpu_virtual_address_for_pointers == KSEG[01]ADDR (cpu_physical_address)

In the example above, the PCI bus is mapped into CPU memory such that
it can be accessed via ksegX, which is normal.  If it were mapped at,
for example, 0x40000000, that would not be the case and you would need
a TLB entry.  Note that for mips64, you can use KPHYS to access any
physical address; ie it need not be below 0x20000000.

-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
	"Nothing motivates a man more than to see his boss put
	 in an honest day's work." -- The fortune file
