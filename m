Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBILxH317876
	for linux-mips-outgoing; Tue, 18 Dec 2001 13:59:17 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fBILx8o17871
	for <linux-mips@oss.sgi.com>; Tue, 18 Dec 2001 13:59:09 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fBIKwoO00941;
	Tue, 18 Dec 2001 18:58:50 -0200
Date: Tue, 18 Dec 2001 18:58:50 -0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Jim Paris <jim@jtan.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: [ppopov@mvista.com: Re: [Linux-mips-kernel]ioremap & ISA]
Message-ID: <20011218185850.A18856@dea.linux-mips.net>
References: <20011217151515.A9188@neurosis.mit.edu> <20011217193432.A7115@dea.linux-mips.net> <20011218020344.A10509@neurosis.mit.edu> <20011218162506.A24659@dea.linux-mips.net> <20011218135712.B11726@neurosis.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011218135712.B11726@neurosis.mit.edu>; from jim@jtan.com on Tue, Dec 18, 2001 at 01:57:12PM -0500
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Dec 18, 2001 at 01:57:12PM -0500, Jim Paris wrote:

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

It's a general memory map.  Basically you have an memory address space
and an I/O space.  The latter should be treated as an entirely independant
thing just like on x86 where special instructions (in / out) are necessary
to access it.  On MIPS the difference is more blurry as this I/O port
addres space is accessible through normal load / store instructions.

> > And that's right because isa_slot_offset is used by the isa_{read,write}[bwl]
> > functions which do not require ioremap having been called before.  You're
> > (fortunately ...) using PCI and PCI drivers are required to use ioremap.
> 
> No, I'm not using PCI, but it's calling ioremap anyway.  So, yes, I
> suppose I could change the driver to not call ioremap and use
> isa_{read,write}[bwl] (since doing both adds KSEG1 twice).
> But why shouldn't ioremap + {read,write}[bwl] also work?
> If it did, I wouldn't have to touch the driver.

Well, calling ioremap anyway is ok.  The whole isa_* thing was invented to
make keeping the large number of antique ISA drivers that don't have any
maintainers alive.

  Ralf
