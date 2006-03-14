Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Mar 2006 03:26:01 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:23819 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133900AbWCNDZv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 14 Mar 2006 03:25:51 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 98F5264D3E; Tue, 14 Mar 2006 03:34:52 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 3C86966ED3; Tue, 14 Mar 2006 03:34:39 +0000 (GMT)
Date:	Tue, 14 Mar 2006 03:34:39 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Mark E Mason <mark.e.mason@broadcom.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: BCM91x80A/B PCI DMA problems
Message-ID: <20060314033439.GP29285@deprecation.cyrius.com>
References: <7E000E7F06B05C49BDBB769ADAF44D07868120@NT-SJCA-0750.brcm.ad.broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7E000E7F06B05C49BDBB769ADAF44D07868120@NT-SJCA-0750.brcm.ad.broadcom.com>
User-Agent: Mutt/1.5.11+cvs20060126
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10807
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Mark E Mason <mark.e.mason@broadcom.com> [2006-03-13 18:31]:
> Again -- which PCI slot are you seeing this with?

The one you recommended (i.e. the one closest to the CPU), but I see
the same with the other slots.

I have done some more research today with the help of Lennert
Buytenhek, an ARM hacker.  While we were not able to pin down the
exact problem, I think we have enough information so you can look into
it and hopefully suggest a fix.

Finding 1: while it fails with > 1 GB RAM, using 512 MB or 1 GB works.

Finding 2: with > 1 GB RAM, we're getting addresses over 4 GB in
sg->dma_address.  We put some printks into arch/mips/mm/dma-coherent.c
and while everything looks okay with 1 GB of RAM, with 2 GB I get e.g.
    map page a8000000063f36c0 to addr 000000017fc68000

That's an address > 4G.  Lennert thinks that it's "most likely going
to stuff it into a 32bit address register somewhere" and: "I can't see
how it can work at all if it passes the >32bit pci address to the
device.  it should detect, hey, this is above 4G, so then allocate a
buffer below 4G, copy it into there, and pass _that_ buffer to the
device.  that's called dma bounce buffering."

Finding 3: the memory layout is weird.
memory: 000000000fe91e00 @ 0000000000000000 (usable)
memory: 000000001ffffe00 @ 0000000080000000 (usable)
memory: 000000000ffffe00 @ 00000000c0000000 (usable)
memory: 000000003ffffe00 @ 0000000140000000 (usable)

Lennert, "if the pci controller doesn't compensate for such a weird
layout, you're bound to see pci issues."

Finding 4: the host bridge has some "unassigned" memory.  Why?

0001:00:04.0 Host bridge: Broadcom Corporation: Unknown device 0014 (rev 01)
         Flags: bus master, fast devsel, latency 0, IRQ 255
         Memory at 60000000 (32-bit, prefetchable) [size=16M]
         Memory at <unassigned> (32-bit, prefetchable)
         Memory at 70000000 (32-bit, prefetchable) [size=4K]
         Memory at <unassigned> (64-bit, prefetchable)

Does this information help?  Also, we were wondering how to find out
whether a driver is okay with 64-bit dma addresses.

Thanks a lot.
-- 
Martin Michlmayr
http://www.cyrius.com/
