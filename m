Received:  by oss.sgi.com id <S553702AbQLKWQ7>;
	Mon, 11 Dec 2000 14:16:59 -0800
Received: from hybrid-024-221-181-223.ca.sprintbbd.net ([24.221.181.223]:58609
        "EHLO hermes.mvista.com") by oss.sgi.com with ESMTP
	id <S553650AbQLKWQl>; Mon, 11 Dec 2000 14:16:41 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id eBBNCIS29713;
	Mon, 11 Dec 2000 15:12:18 -0800
Message-ID: <3A35C2CE.2CF718D6@mvista.com>
Date:   Mon, 11 Dec 2000 22:16:46 -0800
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC:     Guido Guenther <guido.guenther@gmx.net>, linux-mips@oss.sgi.com
Subject: Re: Should /dev/kmem support above 0x80000000 area?
References: <Pine.GSO.3.96.1001211192843.18945O-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

"Maciej W. Rozycki" wrote:
> 
> On Mon, 11 Dec 2000, Jun Sun wrote:
> 
> > I am surprised.  I thought /dev/mem is for accessing SYSTEM RAM.  (do a 'man'
> 
>  You access the memory space.  Whatever is found at the address you
> specify, be it RAM, an MMIO area or unoccupied space.  You may receive a
> bus error in the latter case (depending on a system configuration).
> 
> > on /dev/mem)  It is also confirmed by the code in drivers/char/mem.c.  If you
> > want to access anything beyond 'high_memory", nothing is read.
> 
>  Yep, you may only use read()/write() for system RAM.  For other areas you
> have to mmap() the interesting part of /dev/mem and then access it
> directly (which is easier and better anyway, as you may control the width
> of bus transfers -- not all MMIO devices support all widths).
> 

I see.  It is funny that you cannot read/write memory beyond high_memory
through /dev/mem, but you can re-map it and then read/write through the
remapped region.

How do you control the width of bus transfers?  If you have direct access to
the device memory, the userland "drivers" should be able to deal with the bus
access width correctly.

> > That reason I want to fix /dev/kmem is that in some cases before a driver is
> > written people want to play with the hardware directly from the userland
> > (especially for demo purpose. :-0)  Very useful for embedded systems.
> 
>  I'm not sure how to use /dev/kmem for this purpose -- it's kernel's
> *virtual* memory...
>

kseg0 and kseg1 are part of kernel virtual memory space.  If we implement
/dev/kmem correctly, one should be able to directly read/write those area by
specifying 0x80000000 or 0xa0000000 offsets through /dev/kmem.

Jun
