Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3MEtZqf031429
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 22 Apr 2002 07:55:35 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3MEtZEU031428
	for linux-mips-outgoing; Mon, 22 Apr 2002 07:55:35 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3MEtUqf031421
	for <linux-mips@oss.sgi.com>; Mon, 22 Apr 2002 07:55:30 -0700
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.26])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id QAA14605;
	Mon, 22 Apr 2002 16:55:08 +0200 (MET DST)
Date: Mon, 22 Apr 2002 16:55:07 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: Wayne Gowcher <wgowcher@yahoo.com>, Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Re: Equivalent of ioperm / iopl in linux mips ?
In-Reply-To: <Pine.GSO.3.96.1020422132125.7706C-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.GSO.4.21.0204221654140.17279-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 22 Apr 2002, Maciej W. Rozycki wrote:
> On Sat, 20 Apr 2002, Geert Uytterhoeven wrote:
> > > Does anyone know how to implement ioperm / iopl type
> > > functionality on a mips system. Any example code would
> > > be appreciated.
> > 
> > Like on most architectures that use memory mapped I/O: mmap() the relevant
> > portion of /dev/mem and read/write to/from the mapped area.
> 
>  Hmm, I admit I haven't looked at this matter, but aren't
> in/out/ioperm/iopl implemented as library functions in glibc like for
> other architectures doing MMIO?  E.g. Alpha does this an it makes porting

Perhaps. Note that you still need some /proc magic to find out the correct
address to map. Or you can use /dev/ports.

> programs like XFree86 and SVGATextMode much more straightforward and less
> processor-specific.  That makes sense as they are not processor specific
> but rather bus-specific.  If we don't do that, we should.  For platforms
> without an (E)ISA or a PCI bus ioperm/iopl would simply return an error.

Yes indeed.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
