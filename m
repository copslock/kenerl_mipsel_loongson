Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBJAYVG05057
	for linux-mips-outgoing; Wed, 19 Dec 2001 02:34:31 -0800
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBJAYNo05051;
	Wed, 19 Dec 2001 02:34:23 -0800
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.27])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id KAA12248;
	Wed, 19 Dec 2001 10:34:05 +0100 (MET)
Date: Wed, 19 Dec 2001 10:34:04 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jim Paris <jim@jtan.com>
cc: Ralf Baechle <ralf@oss.sgi.com>,
   Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: Re: [ppopov@mvista.com: Re: [Linux-mips-kernel]ioremap & ISA]
In-Reply-To: <20011218135712.B11726@neurosis.mit.edu>
Message-ID: <Pine.GSO.4.21.0112191031050.28694-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 18 Dec 2001, Jim Paris wrote:
> > Therefore:
> > 
> > 	set_io_port_base(0xb4000000);
> > 	isa_slot_offset = 0xb0000000;
> 
> Yep, that's what I have.
> 
> > >    > -more /proc/iomem
> > >    00000000-00ffffff : System Ram
> > >      00002000-001bc6af : Kernel code
> > >      001cf300-00299fff : Kernel data
> > >  (this seems very wrong to me, since the kernel is most definately
> > >   not in the I/O memory space; real memory, of course, but I/O memory??)
> > 
> > No, this makes perfect sense on a 16mb system.
> 
> How so?  See the memory map I just sent in my other mail.  Should I be
> adding isa_slot_offset to calls to check/request/release_mem_region?
> Or should I make a isa_{check,request,release}_mem_region that adds
> this in?  In which case, doesn't that turn /proc/iomem into a general
> memory map rather than an I/O memory map?

IMHO you should create isa_{check,request,release}_mem_region().

I said it many times before on linux-kernel, but it doesn't help :-(
I'm facing the same problem on PPC, where ISA memory space is not at address 0.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
