Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBI6j7119334
	for linux-mips-outgoing; Mon, 17 Dec 2001 22:45:07 -0800
Received: from neurosis.mit.edu (NEUROSIS.MIT.EDU [18.243.0.82])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBI6j2o19331;
	Mon, 17 Dec 2001 22:45:03 -0800
Received: (from jim@localhost)
	by neurosis.mit.edu (8.11.4/8.11.4) id fBI5j0b10425;
	Tue, 18 Dec 2001 00:45:00 -0500
Date: Tue, 18 Dec 2001 00:45:00 -0500
From: Jim Paris <jim@jtan.com>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: [ppopov@mvista.com: Re: [Linux-mips-kernel]ioremap & ISA]
Message-ID: <20011218004500.A10405@neurosis.mit.edu>
Reply-To: jim@jtan.com
References: <20011217151515.A9188@neurosis.mit.edu> <20011217193432.A7115@dea.linux-mips.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011217193432.A7115@dea.linux-mips.net>; from ralf@oss.sgi.com on Mon, Dec 17, 2001 at 07:34:32PM -0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> Is your PCMCIA bridge really behind an ISA bus?
> 
> What is an address less than 16mb in your case?  Most MIPS systems have
> memory at that physical address so maybe you're not talking about
> physical addresses?

My PCMCIA controller is a VG-469, handled by i82365.c.  Its memory
space is at physical address 0x10000000-0x10FFFFFF.  By "address less
than 16mb" I meant from i82365.c's point of view; it's passing that to
ioremap and needs read[bwl] and write[bwl] to work on the result.
When ioremap adds 0x10000000, things are (mostly) happy, but is that
the wrong way to do it?

> > of the correct values.  I'm guessing this is something miscompiling --
> > I'm using the latest binutils plus gcc-3.0.2 -- has anyone see these
> 
> Try something older instead.

That fixed those problems.

-jim
