Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBIMrxN20478
	for linux-mips-outgoing; Tue, 18 Dec 2001 14:53:59 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBIMrio20455;
	Tue, 18 Dec 2001 14:53:48 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id WAA12320;
	Tue, 18 Dec 2001 22:53:10 +0100 (MET)
Date: Tue, 18 Dec 2001 22:53:10 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jim Paris <jim@jtan.com>
cc: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: [ppopov@mvista.com: Re: [Linux-mips-kernel]ioremap & ISA]
In-Reply-To: <20011218162806.A12456@neurosis.mit.edu>
Message-ID: <Pine.GSO.3.96.1011218223518.10322B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 18 Dec 2001, Jim Paris wrote:

> The ports are dealt with by /proc/ioports.  What about /proc/iomem?
> The ISA ports and ISA memory are seperate, and the ports work fine and
> just as I would expect them to.  But for memory, where should the
> PCMCIA driver be reserving space?  Should I 
> 1) make /proc/iomem contain addresses relative to the start of I/O memory,
>    just as /proc/ioports contains addresses relative to the start of
>    I/O port space?  This will only work if I stop letting the kernel
>    reserve the iomem resource for system memory.

 There should probably be an ISA memory space reserved somewhere in the
CPU memory space (/proc/iomem reflects memory addresses as seen by the
CPU).  You should reserve resources within it.

 There should be an ISA I/O space reserved somewhere in /proc/iomem, too,
as the I/O space is real only for CPUs defining special bus cycles for I/O
accesses (MIPS is not one of them, hence it must be done by the chipset).
The /proc/ioports reports addresses relative to that space.

> 2) make the i82365 driver use absolute addresses in /proc/iomem, by
>    adding (isa_slot_offset - KSEG1) to all *_mem_resource calls?
>    (breaks i82365 for other arches)

 Mapping between physical addresses and MIPS virtual addresses (KSEG1 is a
virtual address) should be done by bus access functions (or macros), such
as inb/outb/readl/readw/isa_readb/isa_readw, etc.  See the Alpha port for
how it should be done.  It appears to have done it particularly cleanly. 

> 3) Invent a new resource "isamem", reserve the correct absolute
>    addresses in "iomem", and the modify the i82365 driver to use 
>    "isamem" instead?  (again breaks i82365 for other arches)

 Don't do it.

> Given the current way the I/O memory is handled on MIPS, the only way
> I can get the i82365 driver working breaks it for every other arch.

 Then the MIPS I/O memory handling is broken.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
