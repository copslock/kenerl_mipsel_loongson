Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 May 2004 15:06:11 +0100 (BST)
Received: from p508B5AFA.dip.t-dialin.net ([IPv6:::ffff:80.139.90.250]:53075
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225576AbUEJOGK>; Mon, 10 May 2004 15:06:10 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i4AE68xT026864;
	Mon, 10 May 2004 16:06:08 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i4AE66sq026863;
	Mon, 10 May 2004 16:06:06 +0200
Date: Mon, 10 May 2004 16:06:06 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: geert@linux-m68k.org, jsun@mvista.com, linux-mips@linux-mips.org
Subject: Re: semaphore woes in 2.6, 32bit
Message-ID: <20040510140606.GA9312@linux-mips.org>
References: <20040509125750.GA19225@linux-mips.org> <20040509.225637.92590265.anemo@mba.ocn.ne.jp> <20040509164835.GA28011@linux-mips.org> <20040510.222845.78701815.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040510.222845.78701815.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4958
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, May 10, 2004 at 10:28:45PM +0900, Atsushi Nemoto wrote:

> >> Hmm, many drivers use kmalloc and pci_map_single for DMA buffer.
> >> So ARCH_KMALLOC_MINALIGN should be L1_CACHE_BYTES for non-coherent
> >> system?
> 
> ralf> No, those drivers are simply broken.  dma_get_cache_alignment()
> ralf> gives the mimimum alignment and width for DMA mappings and that
> ralf> value is larger than kmalloc alignment in almost all cases.
> 
> I see.  Thank you for pointing out it.  I must learn 2.6 DMA API
> quickly ...

This also applies to the 2.4 PCI DMA API.

  Ralf
