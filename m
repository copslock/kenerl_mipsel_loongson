Received:  by oss.sgi.com id <S42381AbQFVI7x>;
	Thu, 22 Jun 2000 01:59:53 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:26687 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42380AbQFVI7j>; Thu, 22 Jun 2000 01:59:39 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id CAA09587
	for <linux-mips@oss.sgi.com>; Thu, 22 Jun 2000 02:04:45 -0700 (PDT)
	mail_from (rth@piglet.twiddle.net)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id BAA54218
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 22 Jun 2000 01:59:03 -0700 (PDT)
	mail_from (rth@piglet.twiddle.net)
Received: from piglet.twiddle.net (piglet.twiddle.net [207.104.6.26]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id BAA05369
	for <linux@cthulhu.engr.sgi.com>; Thu, 22 Jun 2000 01:59:01 -0700 (PDT)
	mail_from (rth@piglet.twiddle.net)
Received: (from rth@localhost)
	by piglet.twiddle.net (8.9.3/8.9.3) id BAA29673;
	Thu, 22 Jun 2000 01:59:03 -0700
Date:   Thu, 22 Jun 2000 01:59:03 -0700
From:   Richard Henderson <rth@twiddle.net>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux kernel <linux-kernel@vger.rutgers.edu>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
        Linux/MIPS Development <linux@cthulhu.engr.sgi.com>
Subject: Re: Proposal: non-PC ISA bus support
Message-ID: <20000622015903.A29666@twiddle.net>
References: <20000622001916.A29550@twiddle.net> <Pine.GSO.4.10.10006220938260.27193-100000@dandelion.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <Pine.GSO.4.10.10006220938260.27193-100000@dandelion.sonytel.be>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, Jun 22, 2000 at 09:41:58AM +0200, Geert Uytterhoeven wrote:
> The problem is that drivers assume ISA memory space is at 0 and use e.g.
> 
>     request_mem_region(0xa0000, 65536)
>     
> to request the legacy VGA region, while it should be
> 
>     request_mem_region(isa_mem_base+0xa0000, 65536)
> 
> for compatibility with anything besides ia32.

Well, yes and no.  Again, what I'm saying is that one way
to handle this is to *pretend* isa_mem_base==0, and that
the entire ISA region is contiguous.  Certainly that's good
enough for region allocations.  And if the damage is undone
by ioremap, then the effect is not visible.

I'm not disagreeing that it would make sense to make this
all a bit more explicit with proper interfaces.  However,
I don't see that happening any time real soon.

> > What does your bus configuration look like?
> 
> There are multiple legacy ISA regions on some PowerMacs, which
> have multiple PCI buses and such.

I guessed that.  I was hoping to get specifics.


r~
