Received:  by oss.sgi.com id <S42374AbQFVHnL>;
	Thu, 22 Jun 2000 00:43:11 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:55867 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42190AbQFVHnG>; Thu, 22 Jun 2000 00:43:06 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id AAA00101
	for <linux-mips@oss.sgi.com>; Thu, 22 Jun 2000 00:48:17 -0700 (PDT)
	mail_from (Geert.Uytterhoeven@sonycom.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id AAA72640
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 22 Jun 2000 00:42:36 -0700 (PDT)
	mail_from (Geert.Uytterhoeven@sonycom.com)
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id AAA09636
	for <linux@cthulhu.engr.sgi.com>; Thu, 22 Jun 2000 00:42:32 -0700 (PDT)
	mail_from (Geert.Uytterhoeven@sonycom.com)
Received: from dandelion.sonytel.be (dandelion.sonytel.be [193.74.243.153])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id JAA24403;
	Thu, 22 Jun 2000 09:41:58 +0200 (MET DST)
Date:   Thu, 22 Jun 2000 09:41:58 +0200 (MET DST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Richard Henderson <rth@twiddle.net>
cc:     Linux kernel <linux-kernel@vger.rutgers.edu>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
        Linux/MIPS Development <linux@cthulhu.engr.sgi.com>
Subject: Re: Proposal: non-PC ISA bus support
In-Reply-To: <20000622001916.A29550@twiddle.net>
Message-ID: <Pine.GSO.4.10.10006220938260.27193-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, 22 Jun 2000, Richard Henderson wrote:
> On Thu, Jun 22, 2000 at 08:45:47AM +0200, Geert Uytterhoeven wrote:
> > But with ioremap() you cannot specify where it has to be mapped, right? So
> > you're still stuck with an offset.
> 
> Huh?  Who cares where it's mapped.  "Some unused space."
> A pointer is a pointer.
> 
> In my case there is a direct correlation between the "base address"
> and the "ioremaped address" -- the addition of a constant.  That's
> the win for using 64-bit pointers.  ;-)

I think we're talking about something different. I don't care about the pointer
nor the ioremap() neither (we explicitly map it in MMU_init()).

The problem is that drivers assume ISA memory space is at 0 and use e.g.

    request_mem_region(0xa0000, 65536)
    
to request the legacy VGA region, while it should be

    request_mem_region(isa_mem_base+0xa0000, 65536)

for compatibility with anything besides ia32.

> > > the ISA bus is contained within exactly one PCI hose.
> > 
> > Which is not the case on some boxes :-(
> 
> The only machines I knew about that had this were the DEC NUMA
> machines.  What does your bus configuration look like?

There are multiple legacy ISA regions on some PowerMacs, which have multiple
PCI buses and such.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
