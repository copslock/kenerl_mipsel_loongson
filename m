Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBINTH321530
	for linux-mips-outgoing; Tue, 18 Dec 2001 15:29:17 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fBINT7o21527
	for <linux-mips@oss.sgi.com>; Tue, 18 Dec 2001 15:29:08 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fBIMSUj16742;
	Tue, 18 Dec 2001 20:28:30 -0200
Date: Tue, 18 Dec 2001 20:28:30 -0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Jun Sun <jsun@mvista.com>
Cc: Jim Paris <jim@jtan.com>, linux-mips@oss.sgi.com
Subject: Re: [ppopov@mvista.com: Re: [Linux-mips-kernel]ioremap & ISA]
Message-ID: <20011218202830.B18856@dea.linux-mips.net>
References: <20011217151515.A9188@neurosis.mit.edu> <20011217193432.A7115@dea.linux-mips.net> <20011218020344.A10509@neurosis.mit.edu> <20011218162506.A24659@dea.linux-mips.net> <3C1F9608.E4E32E18@mvista.com> <20011218173118.C28080@dea.linux-mips.net> <3C1F9AD2.1269192E@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C1F9AD2.1269192E@mvista.com>; from jsun@mvista.com on Tue, Dec 18, 2001 at 11:36:50AM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Dec 18, 2001 at 11:36:50AM -0800, Jun Sun wrote:

> > > I see.  So isa_slot_offset is for isa_read/isa_write, although I still don't
> > > see what kind of drivers would use isa_read/isa_write.
> > 
> > Dumb answer - ISA drivers.
> 
> (Hmm, do you mean "dumb question"? :-0)  

Somewhere I heared there are only dumb answers, no dumb questions :-)

> I was thinking most ISA dirvers should simply use inb/outb to access ioports.
> Don't really any ISA devices have their own memory space.  But, anyway, who
> can still remember those dark ages?

Isa_slot_offset is related to memory mapped I/O, in and out are not
memory mapped I/O.

  Ralf
