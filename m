Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBIJAbP26348
	for linux-mips-outgoing; Tue, 18 Dec 2001 11:10:37 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBIJATo26344;
	Tue, 18 Dec 2001 11:10:29 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id fBIIAGB12489;
	Tue, 18 Dec 2001 10:10:17 -0800
Message-ID: <3C1F868C.492E155B@mvista.com>
Date: Tue, 18 Dec 2001 10:10:20 -0800
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: jim@jtan.com
CC: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: [ppopov@mvista.com: Re: [Linux-mips-kernel]ioremap & ISA]
References: <20011217151515.A9188@neurosis.mit.edu> <20011217193432.A7115@dea.linux-mips.net> <20011218020344.A10509@neurosis.mit.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Jim Paris wrote:
> 
> > ISA, the good old stonage PC bus system with all it's limitations that also
> > infected some MIPS systems.
> 
> Let me restate my problem differently, and perhaps a bit more clearly
> (as I see it):
> 
> My system (Vadem Clio 1000, vr4111) has a VG-469 (i82365) PCMCIA
> controller with IO port space at 0x14000000, and IO memory space
> at 0x10000000.
> 
> The i82365 driver makes the following (reasonable?) expectations:
> 
> 1) it can use check/request/release_region on I/O ports
>  - this works fine.
> 2) it can use in[bwl] and out[bwl] with absolute port numbers
>  - this also works fine.
> 3) it can use check/request/release_mem_region on I/O memory
>  - this fails, because the iomem resource map contains the kernel:
>    > -more /proc/iomem
>    00000000-00ffffff : System Ram
>      00002000-001bc6af : Kernel code
>      001cf300-00299fff : Kernel data
>  (this seems very wrong to me, since the kernel is most definately
>   not in the I/O memory space; real memory, of course, but I/O memory??)
> 4) it can use ioremap, and then read[bwl] and write[bwl] with the result
>  - this fails with the current ioremap; neither ioremap nor read/write[bwl]
>    take isa_slot_offset into account
> 
> Am I misunderstanding how this stuff is supposed to work?  Is the
> i82365 driver doing anything wrong?
> 

It seems like i82365.c implies a PCI device.  If this is true, then things do
make sense here.

Just setting iomem_resource.end to 0xffffffff should get you by resource range
problem.

It has nothing to isa_slot_offset here.  I don't know about the history of
isa_slot_offset, but it appears to be faint effort to allow the access to what
is called "ISA memory" space on PC.  This region, if it ever exists, should
never be a separate region on a MIPS machine.  It should just be the beginning
part of PCI Memory space.

Ralf, we should just delete isa_slot_offset to avoid any further confusions.

> (The i82365 driver also makes the incorrect assumption that PCMCIA IRQs
> directly correspond to system IRQs, but this is definately a problem
> with the driver and I've fixed that.)

My understanding is that PCMCIA does it own IRQ re-mapping (somewhat similar
to P2P bridge IRQ re-mapping).

Jun
