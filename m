Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Mar 2007 22:22:34 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:51357 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021972AbXCSWWc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 19 Mar 2007 22:22:32 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l2JMKW5U016245;
	Mon, 19 Mar 2007 22:20:33 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l2JMKVVN016244;
	Mon, 19 Mar 2007 22:20:31 GMT
Date:	Mon, 19 Mar 2007 22:20:31 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: ZONE_DMA on MIPS
Message-ID: <20070319222031.GB8707@linux-mips.org>
References: <20070320.000947.88474417.anemo@mba.ocn.ne.jp> <20070319154821.GA31766@linux-mips.org> <20070320.013608.103777227.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070320.013608.103777227.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14571
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Mar 20, 2007 at 01:36:08AM +0900, Atsushi Nemoto wrote:

> On Mon, 19 Mar 2007 15:48:21 +0000, Ralf Baechle <ralf@linux-mips.org> wrote:
> > > Are there any other platforms requires special DMA zone?
> > 
> > Qemu supports more or less the full PC braind^Wheritage, including the
> > good old too-old floppy controller.  IP22 supports Indigo 2 systems
> > which have EISA support, so we only want ZONE_DMA if EISA is enabled.
> > For a bunch of other systems ZONE_DMA may be required to support b0rked
> > PCI cards that only support like 31-bit DMA addresses or even less.
> 
> Hmm... So do you think making ZONE_DMA customizable for each platform
> (or user configurable) would have some sense?

It's probably reasonable to do something like:

config GENERIC_ISA_DMA
	bool
	select ZONE_DMA

I don't think we should expose such deep technical details to the Kconfig
user.

> For these legacy(?) PCI cards, we can check if it works or not by
> pci_set_dma_mask(), at least.

The Linux approach to handling such broken cards is not very gentle.  A
card that can't live with normal allocations, will always use bounce
ZONE_NORMAL buffers.

Obviously the message to the designers of PCI cards is to get their stuff
done right and not rely on OS kludgery to fix hardware shortcomings.

And while at it, we may want to think about ZONE_DMA32.  At least the
BCM1250 needs it for configs with more than 1GB memory due to it's
sparse memory map.

  Ralf
