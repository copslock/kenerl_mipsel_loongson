Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBI83pa23027
	for linux-mips-outgoing; Tue, 18 Dec 2001 00:03:51 -0800
Received: from neurosis.mit.edu (NEUROSIS.MIT.EDU [18.243.0.82])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBI83jo23023;
	Tue, 18 Dec 2001 00:03:45 -0800
Received: (from jim@localhost)
	by neurosis.mit.edu (8.11.4/8.11.4) id fBI73i110551;
	Tue, 18 Dec 2001 02:03:44 -0500
Date: Tue, 18 Dec 2001 02:03:44 -0500
From: Jim Paris <jim@jtan.com>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: [ppopov@mvista.com: Re: [Linux-mips-kernel]ioremap & ISA]
Message-ID: <20011218020344.A10509@neurosis.mit.edu>
Reply-To: jim@jtan.com
References: <20011217151515.A9188@neurosis.mit.edu> <20011217193432.A7115@dea.linux-mips.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011217193432.A7115@dea.linux-mips.net>; from ralf@oss.sgi.com on Mon, Dec 17, 2001 at 07:34:32PM -0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> ISA, the good old stonage PC bus system with all it's limitations that also
> infected some MIPS systems.

Let me restate my problem differently, and perhaps a bit more clearly
(as I see it):

My system (Vadem Clio 1000, vr4111) has a VG-469 (i82365) PCMCIA
controller with IO port space at 0x14000000, and IO memory space
at 0x10000000.

The i82365 driver makes the following (reasonable?) expectations:

1) it can use check/request/release_region on I/O ports
 - this works fine.
2) it can use in[bwl] and out[bwl] with absolute port numbers
 - this also works fine.  
3) it can use check/request/release_mem_region on I/O memory
 - this fails, because the iomem resource map contains the kernel:
   > -more /proc/iomem
   00000000-00ffffff : System Ram
     00002000-001bc6af : Kernel code
     001cf300-00299fff : Kernel data
 (this seems very wrong to me, since the kernel is most definately
  not in the I/O memory space; real memory, of course, but I/O memory??)
4) it can use ioremap, and then read[bwl] and write[bwl] with the result
 - this fails with the current ioremap; neither ioremap nor read/write[bwl]
   take isa_slot_offset into account

Am I misunderstanding how this stuff is supposed to work?  Is the
i82365 driver doing anything wrong?

(The i82365 driver also makes the incorrect assumption that PCMCIA IRQs
directly correspond to system IRQs, but this is definately a problem
with the driver and I've fixed that.)

-jim
