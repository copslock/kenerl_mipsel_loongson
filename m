Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3MFY4qf031895
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 22 Apr 2002 08:34:04 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3MFY4sK031894
	for linux-mips-outgoing; Mon, 22 Apr 2002 08:34:04 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3MFXvqf031888
	for <linux-mips@oss.sgi.com>; Mon, 22 Apr 2002 08:33:58 -0700
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.27])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id RAA17722;
	Mon, 22 Apr 2002 17:33:31 +0200 (MET DST)
Date: Mon, 22 Apr 2002 17:33:30 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: Wayne Gowcher <wgowcher@yahoo.com>, Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Re: Equivalent of ioperm / iopl in linux mips ?
In-Reply-To: <Pine.GSO.3.96.1020422170125.7706H-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.GSO.4.21.0204221733070.17279-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 22 Apr 2002, Maciej W. Rozycki wrote:
> On Mon, 22 Apr 2002, Geert Uytterhoeven wrote:
> > >  Hmm, I admit I haven't looked at this matter, but aren't
> > > in/out/ioperm/iopl implemented as library functions in glibc like for
> > > other architectures doing MMIO?  E.g. Alpha does this an it makes porting
> > 
> > Perhaps. Note that you still need some /proc magic to find out the correct
> > address to map. Or you can use /dev/ports.
> 
>  Well, for Alpha ioperm/iopl functions check the system type in
> /proc/cpuinfo (we seem to have enough information there as well) and
> failing this they check a result of readlink of /etc/alpha_systype.  Then
> an appropriate region of /dev/mem is mmapped with per-page permissions set
> up as requested if ioperm is used (with a worse granularity, though) and
> subsequent in/out function invocations access the area as appropriate. 
> See sysdeps/unix/sysv/linux/alpha/ioperm.c in glibc for details -- it's a
> pretty clever solution with good performance and only a few trade-offs.

I think PPC has syscalls to find the I/O bases, too.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
