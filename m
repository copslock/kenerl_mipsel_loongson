Received:  by oss.sgi.com id <S42382AbQFVJSN>;
	Thu, 22 Jun 2000 02:18:13 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:60493 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42380AbQFVJRt>;
	Thu, 22 Jun 2000 02:17:49 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id CAA23723
	for <linux-mips@oss.sgi.com>; Thu, 22 Jun 2000 02:12:51 -0700 (PDT)
	mail_from (Geert.Uytterhoeven@sonycom.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id CAA58536 for <linux-mips@oss.sgi.com>; Thu, 22 Jun 2000 02:17:17 -0700 (PDT)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id CAA84674
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 22 Jun 2000 02:15:29 -0700 (PDT)
	mail_from (Geert.Uytterhoeven@sonycom.com)
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id CAA09747
	for <linux@cthulhu.engr.sgi.com>; Thu, 22 Jun 2000 02:15:27 -0700 (PDT)
	mail_from (Geert.Uytterhoeven@sonycom.com)
Received: from dandelion.sonytel.be (dandelion.sonytel.be [193.74.243.153])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id LAA27611;
	Thu, 22 Jun 2000 11:15:31 +0200 (MET DST)
Date:   Thu, 22 Jun 2000 11:15:31 +0200 (MET DST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Richard Henderson <rth@twiddle.net>
cc:     Linux kernel <linux-kernel@vger.rutgers.edu>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
        Linux/MIPS Development <linux@cthulhu.engr.sgi.com>
Subject: Re: Proposal: non-PC ISA bus support
In-Reply-To: <20000622015903.A29666@twiddle.net>
Message-ID: <Pine.GSO.4.10.10006221114030.27193-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, 22 Jun 2000, Richard Henderson wrote:

> On Thu, Jun 22, 2000 at 09:41:58AM +0200, Geert Uytterhoeven wrote:
> > The problem is that drivers assume ISA memory space is at 0 and use e.g.
> > 
> >     request_mem_region(0xa0000, 65536)
> >     
> > to request the legacy VGA region, while it should be
> > 
> >     request_mem_region(isa_mem_base+0xa0000, 65536)
> > 
> > for compatibility with anything besides ia32.
> 
> Well, yes and no.  Again, what I'm saying is that one way
> to handle this is to *pretend* isa_mem_base==0, and that
> the entire ISA region is contiguous.  Certainly that's good
> enough for region allocations.  And if the damage is undone
> by ioremap, then the effect is not visible.

That works only if there's nothing else at address 0 that keeps the resource
busy.

> I'm not disagreeing that it would make sense to make this
> all a bit more explicit with proper interfaces.  However,
> I don't see that happening any time real soon.

Hence my proposal for isa_request_mem_region(). It allows platform specific
code to take care of both the base address and the sparsity (if needed).

> > > What does your bus configuration look like?
> > 
> > There are multiple legacy ISA regions on some PowerMacs, which
> > have multiple PCI buses and such.
> 
> I guessed that.  I was hoping to get specifics.

Benjamin Herrenschmidt <bh40@calva.net> can tell you more about it.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
