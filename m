Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBHMYqw04087
	for linux-mips-outgoing; Mon, 17 Dec 2001 14:34:52 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fBHMYjo04083
	for <linux-mips@oss.sgi.com>; Mon, 17 Dec 2001 14:34:46 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fBHLYWL04540;
	Mon, 17 Dec 2001 19:34:32 -0200
Date: Mon, 17 Dec 2001 19:34:32 -0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Jim Paris <jim@jtan.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: [ppopov@mvista.com: Re: [Linux-mips-kernel]ioremap & ISA]
Message-ID: <20011217193432.A7115@dea.linux-mips.net>
References: <20011217151515.A9188@neurosis.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011217151515.A9188@neurosis.mit.edu>; from jim@jtan.com on Mon, Dec 17, 2001 at 03:15:15PM -0500
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Dec 17, 2001 at 03:15:15PM -0500, Jim Paris wrote:

> > What would be considered an ISA address -- the standard PC definition? 
> > I don't think that would work on most mips boards.

ISA, the good old stonage PC bus system with all it's limitations that also
infected some MIPS systems.

> > I'm not sure what isa_slot_offset is meant to do at all.  Shoot Ralf an
> > email, perhaps he has a clear explanation (and then let us know :-)). 

It points to the virtual address at which memory address 0 of the ISA
bus is accessible.  There is a wealth of old ISA drivers that don't know
about the wonders of ioremap so that's why there is isa_slot_offset as
a killer solution for all ISA crapola.

> If I make ioremap use isa_slot_offset for addresses under 16MB, then
> PCMCIA works for me.  I don't see any other way to get isa_slot_offset
> in there without hacking PCMCIA in ways that break other arches.

Is your PCMCIA bridge really behind an ISA bus?

What is an address less than 16mb in your case?  Most MIPS systems have
memory at that physical address so maybe you're not talking about
physical addresses?

> On a somewhat related note, I've noticed that if I include IDE disk
> support in my kernel (CONFIG_BLK_DEV_IDEDISK, ide-disk.o), then stuff
> breaks; most noticibly, the PCMCIA IRQ scan returns the negative (!)
> of the correct values.  I'm guessing this is something miscompiling --
> I'm using the latest binutils plus gcc-3.0.2 -- has anyone see these

Try something older instead.

  Ralf
