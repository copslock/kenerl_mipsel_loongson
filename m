Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBIJvK603960
	for linux-mips-outgoing; Tue, 18 Dec 2001 11:57:20 -0800
Received: from neurosis.mit.edu (NEUROSIS.MIT.EDU [18.243.0.82])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBIJvDo03957;
	Tue, 18 Dec 2001 11:57:14 -0800
Received: (from jim@localhost)
	by neurosis.mit.edu (8.11.4/8.11.4) id fBIIvCJ11824;
	Tue, 18 Dec 2001 13:57:12 -0500
Date: Tue, 18 Dec 2001 13:57:12 -0500
From: Jim Paris <jim@jtan.com>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: [ppopov@mvista.com: Re: [Linux-mips-kernel]ioremap & ISA]
Message-ID: <20011218135712.B11726@neurosis.mit.edu>
Reply-To: jim@jtan.com
References: <20011217151515.A9188@neurosis.mit.edu> <20011217193432.A7115@dea.linux-mips.net> <20011218020344.A10509@neurosis.mit.edu> <20011218162506.A24659@dea.linux-mips.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011218162506.A24659@dea.linux-mips.net>; from ralf@oss.sgi.com on Tue, Dec 18, 2001 at 04:25:06PM -0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> Therefore:
> 
> 	set_io_port_base(0xb4000000);
> 	isa_slot_offset = 0xb0000000;

Yep, that's what I have.

> >    > -more /proc/iomem
> >    00000000-00ffffff : System Ram
> >      00002000-001bc6af : Kernel code
> >      001cf300-00299fff : Kernel data
> >  (this seems very wrong to me, since the kernel is most definately
> >   not in the I/O memory space; real memory, of course, but I/O memory??)
> 
> No, this makes perfect sense on a 16mb system.

How so?  See the memory map I just sent in my other mail.  Should I be
adding isa_slot_offset to calls to check/request/release_mem_region?
Or should I make a isa_{check,request,release}_mem_region that adds
this in?  In which case, doesn't that turn /proc/iomem into a general
memory map rather than an I/O memory map?

> > 4) it can use ioremap, and then read[bwl] and write[bwl] with the result
> >  - this fails with the current ioremap; neither ioremap nor read/write[bwl]
> >    take isa_slot_offset into account
> 
> And that's right because isa_slot_offset is used by the isa_{read,write}[bwl]
> functions which do not require ioremap having been called before.  You're
> (fortunately ...) using PCI and PCI drivers are required to use ioremap.

No, I'm not using PCI, but it's calling ioremap anyway.  So, yes, I
suppose I could change the driver to not call ioremap and use
isa_{read,write}[bwl] (since doing both adds KSEG1 twice).
But why shouldn't ioremap + {read,write}[bwl] also work?
If it did, I wouldn't have to touch the driver.

-jim
