Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBIJPUR26947
	for linux-mips-outgoing; Tue, 18 Dec 2001 11:25:30 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fBIJPKo26944
	for <linux-mips@oss.sgi.com>; Tue, 18 Dec 2001 11:25:22 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fBIIP6927232;
	Tue, 18 Dec 2001 16:25:06 -0200
Date: Tue, 18 Dec 2001 16:25:06 -0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Jim Paris <jim@jtan.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: [ppopov@mvista.com: Re: [Linux-mips-kernel]ioremap & ISA]
Message-ID: <20011218162506.A24659@dea.linux-mips.net>
References: <20011217151515.A9188@neurosis.mit.edu> <20011217193432.A7115@dea.linux-mips.net> <20011218020344.A10509@neurosis.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011218020344.A10509@neurosis.mit.edu>; from jim@jtan.com on Tue, Dec 18, 2001 at 02:03:44AM -0500
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Dec 18, 2001 at 02:03:44AM -0500, Jim Paris wrote:
> Date: Tue, 18 Dec 2001 02:03:44 -0500
> From: Jim Paris <jim@jtan.com>
> To: Ralf Baechle <ralf@oss.sgi.com>
> Cc: linux-mips@oss.sgi.com
> Subject: Re: [ppopov@mvista.com: Re: [Linux-mips-kernel]ioremap & ISA]
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

Therefore:

	set_io_port_base(0xb4000000);
	isa_slot_offset = 0xb0000000;

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

No, this makes perfect sense on a 16mb system.

> 4) it can use ioremap, and then read[bwl] and write[bwl] with the result
>  - this fails with the current ioremap; neither ioremap nor read/write[bwl]
>    take isa_slot_offset into account

And that's right because isa_slot_offset is used by the isa_{read,write}[bwl]
functions which do not require ioremap having been called before.  You're
(fortunately ...) using PCI and PCI drivers are required to use ioremap.
I assume that your PCMCIA bridge is at a physical address < 0x20000000, is
that right?  If so, what ioremap returns is trivial, it's just 0x80000000
 + the argument to ioremap().  Verify that.  Also note that read[wl] and
write[wl] do byteorder swapping on the data if your system is big endian
and CONFIG_SWAP_IO_SPACE is set.

  Ralf
