Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4ALIpe15075
	for linux-mips-outgoing; Thu, 10 May 2001 14:18:51 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4ALInF15072
	for <linux-mips@oss.sgi.com>; Thu, 10 May 2001 14:18:49 -0700
Received: from mvista.com (IDENT:ppopov@zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f4ALI9028100;
	Thu, 10 May 2001 14:18:09 -0700
Message-ID: <3AFB04FF.353198C6@mvista.com>
Date: Thu, 10 May 2001 14:15:43 -0700
From: Pete Popov <ppopov@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en, bg
MIME-Version: 1.0
To: Keith M Wesolowski <wesolows@foobazco.org>
CC: Wayne Gowcher <wgowcher@yahoo.com>,
   Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, linux-mips@oss.sgi.com
Subject: Re: Configuration of PCI Video card on a BIOS-less board
References: <20010510175339.83183.qmail@web11904.mail.yahoo.com> <3AFADA29.674BA111@mvista.com> <20010510131431.A27228@foobazco.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Keith M Wesolowski wrote:
> 
> On Thu, May 10, 2001 at 11:12:57AM -0700, Pete Popov wrote:
> 
> > I'm not clear on how this works with the good driver. If you write to
> > 0xC000 0000, that's a mips virtual address in the kseg2 region, which is
> > a mapped region.  So what physical address you put on the bus when you
> > write to 0xC000 0000 depends on the tlb entry you've setup.  If 0xC000
> > 0000 is truly a PCI memory physical address, then you need to setup a

> Repeat after me until done: BAR values have nothing to do with CPU
> addresses.  If your PCI bus happens to map PCI memory location 0 onto
> physical address 0, then they are the same.  That's almost certainly
> not the case.  Otherwise, an address in a BAR is the *PCI bus
> address*, NOT a CPU physical address.

Wayne's email indicated, if I understood it correctly, that he is trying
to access the card's registers by writing to 0xC000 0000, after he has
written 0xC000 0000 to the BAR. That address cannot be an address that
the host to pci controller understands as PCI memory address because it
overlaps with kseg2. So if 0xC000 0000 is the correct address to write
in the BAR, then he needs to access the card's registers through the PCI
mem region that looks something like your example below.  But if his
memory map is 1:1, then 0xC000 0000 is the wrong value to write to that
register.

> A simple example: a PCI bridge exists in a system.  It is wired into
> the CPU address bus such that it responds to 0x18000000-0x19ffffff
> physical.  On the other side of the bridge, it maps
> 0x00000000-0x7fffffff bus addresses onto physical memory (for DMA),
> and 0x80000000-0xffffffff onto PCI memory space (for PIO).  The bridge
> translates addresses such that:

> bus_address_for_BARs == 0x80000000 + (cpu_physical_address - 0x18000000)
> bus_address_for_DMA == cpu_physical_address

> and, of course,

> cpu_virtual_address_for_pointers == KSEG[01]ADDR (cpu_physical_address)

> In the example above, the PCI bus is mapped into CPU memory such that
> it can be accessed via ksegX, which is normal.  If it were mapped at,
> for example, 0x40000000, that would not be the case and you would need
> a TLB entry.  Note that for mips64, you can use KPHYS to access any
> physical address; ie it need not be below 0x20000000.
