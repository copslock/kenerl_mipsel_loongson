Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4AM2cS16159
	for linux-mips-outgoing; Thu, 10 May 2001 15:02:38 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4AM2cF16156
	for <linux-mips@oss.sgi.com>; Thu, 10 May 2001 15:02:38 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f4AM24030912;
	Thu, 10 May 2001 15:02:04 -0700
Message-ID: <3AFB0FF6.D84A491E@mvista.com>
Date: Thu, 10 May 2001 15:02:30 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith M Wesolowski <wesolows@foobazco.org>
CC: Pete Popov <ppopov@mvista.com>, Wayne Gowcher <wgowcher@yahoo.com>,
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
> 
> Repeat after me until done: BAR values have nothing to do with CPU
> addresses.  If your PCI bus happens to map PCI memory location 0 onto
> physical address 0, then they are the same.  That's almost certainly
> not the case.  Otherwise, an address in a BAR is the *PCI bus
> address*, NOT a CPU physical address.
> 

Keith,

What you said is right in theory.  However not correct in practice.

Most drivers read BAR address (in PCI memory space) and do ioremap() to get
(usually uncached) virtual address to access the PCI memory region.  On mips,
the default ioremap() essentially does 1 to 1 mapping from PCI meory space to
physical address space and then further maps it into KSEG1.

That pretty much mandates each MIPS port must maintain 1:1 mapping between the
PCI memory space and CPU physical space - unless you enjoy the fun of hacking
with PCI fixups.


> A simple example: a PCI bridge exists in a system.  It is wired into
> the CPU address bus such that it responds to 0x18000000-0x19ffffff
> physical.  On the other side of the bridge, it maps
> 0x00000000-0x7fffffff bus addresses onto physical memory (for DMA),
> and 0x80000000-0xffffffff onto PCI memory space (for PIO).  The bridge
> translates addresses such that:
> 
> bus_address_for_BARs == 0x80000000 + (cpu_physical_address - 0x18000000)
> bus_address_for_DMA == cpu_physical_address
> 
> and, of course,
> 
> cpu_virtual_address_for_pointers == KSEG[01]ADDR (cpu_physical_address)
> 
> In the example above, the PCI bus is mapped into CPU memory such that
> it can be accessed via ksegX, which is normal.  If it were mapped at,
> for example, 0x40000000, that would not be the case and you would need
> a TLB entry.  Note that for mips64, you can use KPHYS to access any
> physical address; ie it need not be below 0x20000000.
> 
> --
> Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
> ------(( Project Foobazco Coordinator and Network Administrator ))------
>         "Nothing motivates a man more than to see his boss put
>          in an honest day's work." -- The fortune file
