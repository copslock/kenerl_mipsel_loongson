Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Jan 2008 14:32:00 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:13490 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28577396AbYAJOb5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 10 Jan 2008 14:31:57 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m0AEVh37013485;
	Thu, 10 Jan 2008 14:31:43 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m0AEVgww013484;
	Thu, 10 Jan 2008 14:31:42 GMT
Date:	Thu, 10 Jan 2008 14:31:42 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Jon Dufresne <jon.dufresne@infinitevideocorporation.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Linux mips and DMA
Message-ID: <20080110143142.GA13210@linux-mips.org>
References: <1199905038.3572.8.camel@microwave.infinitevideocorporation.com> <20080110113931.GA4774@linux-mips.org> <1199971818.4344.5.camel@microwave.infinitevideocorporation.com> <20080110134634.GA12060@linux-mips.org> <1199974344.4344.16.camel@microwave.infinitevideocorporation.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1199974344.4344.16.camel@microwave.infinitevideocorporation.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17971
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jan 10, 2008 at 09:12:23AM -0500, Jon Dufresne wrote:

> > Hardware coherency for DMA is the exception for low-end embedded MIPS
> > systems andgiven the CPU address your's is no exception from that.
> > 
> > If your system was supporting hardware coherency for DMA I/O you would
> > have obtained a cachable CPU address like:
> > 
> >   dma_handle=0x026f0000 size=0x00010000 cpu_addr=0x826f0000
> >                                                   ^^^
> > 
> > A 0x8??????? would be in KSEG0 so cachable.
> 
> I do have a an embedded system. Are you saying that, in all likelyhood,
> I do not have coherency? If I understand you correctly, this is a bad
> thing right? Will I need to take extra care to work around this issue.
> 
> So are you saying I would prefer a cpu_addr in the 0x8******* range?

No. because you don't seem to have hw coherency.

> If it is true that I don't have hardware coherency should I still be
> using the pci_*_consistent api? Or should I switch to the
> dma_*_noncoherent api? Also what extra steps do I need to take to get
> this to work with a non-coherent system?

What you were doing seemed to be the right thing.  The API is supposed
to do the necessary address conversion and cache flushes for the driver.
That is the unchanged driver should work on any architecture.

The dma_* API is a generalization of the slightly older pci_* API.  You
can use either one for a PCI device.

In fact on MIPS the pci_* functions are just wrappers around their dma_*
equivalents.

> I am reading Documentation/DMA-API.txt which has some discussion about
> non-coherent systems to see if I can get a handle on this.
> 
> 
> > What hardware are you using anyway?
> 
> I am using the MDS-810 platform supplied by Momentum Data Systems which
> contains a Phillips/Nexperia pnx8950 chip. That chip contains a MIPS32
> core. http://www.mds.com/products/product.asp?prod=MDS-810

According to the current kernel code the PNX8550 non-coheren (aka software
coherency).

  Ralf
