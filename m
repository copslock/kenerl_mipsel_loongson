Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 May 2003 12:22:53 +0100 (BST)
Received: from p508B77C3.dip.t-dialin.net ([IPv6:::ffff:80.139.119.195]:48085
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225073AbTE0LWv>; Tue, 27 May 2003 12:22:51 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h4RBMgbY025029;
	Tue, 27 May 2003 04:22:44 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h4RBMcAq025028;
	Tue, 27 May 2003 13:22:38 +0200
Date: Tue, 27 May 2003 13:22:37 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, wgowcher@yahoo.com,
	linux-mips@linux-mips.org
Subject: Re: pci_alloc_consistent usage
Message-ID: <20030527112237.GA24905@linux-mips.org>
References: <20030523215935.71373.qmail@web11901.mail.yahoo.com> <20030527091740.GA23296@linux-mips.org> <20030527.190749.39150100.nemoto@toshiba-tops.co.jp> <20030527115322.A7124@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030527115322.A7124@infradead.org>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2460
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, May 27, 2003 at 11:53:22AM +0100, Christoph Hellwig wrote:

> > ralf> Use the value returned by pci_alloc_consistent in *dma_handle
> > ralf> instead of trying to do any conversions with of
> > ralf> pci_alloc_consistent's return value.
> > 
> > How about virt_to_page()?
> > 
> > Currently, many sound drivers (including ALSA) pass a
> > pci_alloc_consistent's return value to virt_to_page.
> 
> You are not allow to do so.  Any driver doing this is broken.

That however is exactly what's documented in DMA-mapping.txt:

[...]
portably refer to any piece of memory.  If you have a cpu pointer
(which may be validly DMA'd too) you may easily obtain the page
and offset using something like this:
                                                                                
        struct page *page = virt_to_page(ptr);
        unsigned long offset = ((unsigned long)ptr & ~PAGE_MASK);
[...]

While it's officially documented I still don't like it.  A double
conversion such as page_address(virt_to_page(ptr)) would accidently
turn a pointer of an uncached mapping into one to a cached area for the
same object - that will almost certainly not work as expected on a
non-coherent machine.

  Ralf
