Received:  by oss.sgi.com id <S42205AbQFVHjC>;
	Thu, 22 Jun 2000 00:39:02 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:43835 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42190AbQFVHik>; Thu, 22 Jun 2000 00:38:40 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id AAA08031
	for <linux-mips@oss.sgi.com>; Thu, 22 Jun 2000 00:43:46 -0700 (PDT)
	mail_from (Geert.Uytterhoeven@sonycom.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id AAA08919
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 22 Jun 2000 00:38:05 -0700 (PDT)
	mail_from (Geert.Uytterhoeven@sonycom.com)
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id AAA00452
	for <linux@cthulhu.engr.sgi.com>; Thu, 22 Jun 2000 00:38:01 -0700 (PDT)
	mail_from (Geert.Uytterhoeven@sonycom.com)
Received: from dandelion.sonytel.be (dandelion.sonytel.be [193.74.243.153])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id IAA22816;
	Thu, 22 Jun 2000 08:45:47 +0200 (MET DST)
Date:   Thu, 22 Jun 2000 08:45:47 +0200 (MET DST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Richard Henderson <rth@twiddle.net>
cc:     Linux kernel <linux-kernel@vger.rutgers.edu>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
        Linux/MIPS Development <linux@cthulhu.engr.sgi.com>
Subject: Re: Proposal: non-PC ISA bus support
In-Reply-To: <20000621165744.C28857@twiddle.net>
Message-ID: <Pine.GSO.4.10.10006220828350.27193-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, 21 Jun 2000, Richard Henderson wrote:
> On Tue, Jun 20, 2000 at 01:21:10PM +0200, Geert Uytterhoeven wrote:
> >1. ISA I/O space is memory mapped on many platforms (e.g. PPC and MIPS). To
> >   access it from user space, you cannot plainly use inb() and friends like on
> >   PC, but you have to mmap() the correct region of /dev/mem first. This
> >   region depends on the machine type and currently there's no simple way to
> >   find out from user space.
> 
> You may wish to examine the pciconfig_iobase syscall used on Alpha.
> It can be used to solve the multiple independant pci bus problem
> as well as the ISA base address problem.

Thanks! I'll take a look at it...

> >2. ISA memory is not located at physical address 0 on many platforms (e.g. PPC
> >   and some MIPS boxes). This means you cannot e.g. use
> >   request_mem_region(0xa0000, 65536) to request the legacy VGA region.
> 
> This can be fiddled.  Basicly, you pretend that 0 is the base address,
> then use ioremap to shift everything up into place.  This assumes that

But with ioremap() you cannot specify where it has to be mapped, right? So
you're still stuck with an offset.

Besides, request_mem_region(0xa0000, 65536) will fail on my box anyway because
I already have some memory resources requested at address 0.

> the ISA bus is contained within exactly one PCI hose.

Which is not the case on some boxes :-(

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
