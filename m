Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Jan 2008 11:39:47 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:14762 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28577108AbYAJLjp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 10 Jan 2008 11:39:45 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m0ABdWhW005904;
	Thu, 10 Jan 2008 11:39:32 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m0ABdV5Q005903;
	Thu, 10 Jan 2008 11:39:31 GMT
Date:	Thu, 10 Jan 2008 11:39:31 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Jon Dufresne <jon.dufresne@infinitevideocorporation.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Linux mips and DMA
Message-ID: <20080110113931.GA4774@linux-mips.org>
References: <1199905038.3572.8.camel@microwave.infinitevideocorporation.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1199905038.3572.8.camel@microwave.infinitevideocorporation.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17966
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jan 09, 2008 at 01:57:17PM -0500, Jon Dufresne wrote:

> I am in the process of porting a known working linux driver for a pci
> device from an x86 machine to a mips machine. This is my first time
> developing a driver under mips (but not the first time with x86) so I am
> learning some of the differences and gotchas that exist when porting a
> driver like this.
> 
> My most recent problem exists when setting up dma between the host and
> the device. I am using the following two websites as guides for doing
> this:
> 
> https://lwn.net/Articles/28230/
> https://lwn.net/Articles/28092/

The articles are fairly old and the APIs and their documentation are
occasionally changing.  I suggest you use Documentation/DMA-mapping.txt
as the primary documentation - though as usual Jonathan Corbet's article
is very well written.

> In addition I am using LDD.
> 
> To create the dma memory area I am using the function
> "pci_alloc_consistent". When I pass the "dma_handle" (as I understand it
> the host's physical address of the dma memory), to the pci device, the
> device in the x86 box correctly access this memory, not so in the mips
> box.
> 
> Not sure if this is helpful, but the fuction returns the following
> addresses on the mips when I use it:
> 
> dma_handle=0x026f0000 size=0x00010000 cpu_addr=0xa26f0000
> 
> Does this physical address seem abnormally low? It is well outside the
> range of the PCI BARs which exist around 0x20000000.

There is no relation to the PCI bars whatsoever.  pci_alloc_consistent
works on a memory that is RAM range.  0xa26f0000 is an uncached address
in KSEG1 and 0x026f0000 the equivalent physical address.

All these numbers look sane which suggest your problem may be elsewhere.

One potencial problem might be that bus addresses as used on the PCI bus
and physical addresses as use by the CPU are not identical.  The
return value of pci_alloc_consistent shows that your kernel is setup
to assume that both addresses are identical.  Which is true on most
x86 and MIPS platforms but not all.

Note you may not touch a cached mapping of this range for example
0x826f0000 in KSEG0 or any other cached mapping you may have created or
data corruption will happen.

> Anything I should know about using pci_alloc_consistent on a mips?

MIPS hardware is different so pci_alloc_consistent is implemented
differently.  For correct use however this should not matter.  Any bugs
you may find porting to MIPS were already bugs on x86.

(Or in pci_alloc_consistent but I'm optimistic ;-)

  Ralf
