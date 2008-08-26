Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Aug 2008 00:11:17 +0100 (BST)
Received: from ditditdahdahdah-dahditditditdit.dl5rb.org.uk ([217.169.26.26]:36038
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20022360AbYHZXLP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 27 Aug 2008 00:11:15 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m7QNB4AL018688;
	Wed, 27 Aug 2008 00:11:05 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m7QNB4Ln018686;
	Wed, 27 Aug 2008 00:11:04 +0100
Date:	Wed, 27 Aug 2008 00:11:04 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	David Daney <ddaney@avtrex.com>,
	MIPS Linux List <linux-mips@linux-mips.org>
Subject: Re: What's up with cpu_is_noncoherent_r10000() ?
Message-ID: <20080826231104.GA18323@linux-mips.org>
References: <48B2DF15.5030903@avtrex.com> <20080825184600.GA8993@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080825184600.GA8993@alpha.franken.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20371
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Aug 25, 2008 at 08:46:01PM +0200, Thomas Bogendoerfer wrote:

> On Mon, Aug 25, 2008 at 09:34:29AM -0700, David Daney wrote:
> > What is the reasoning for only doing the cache operation on  R10K based 
> > systems?
> 
> non coherent R10k need after DMA operations to get rid of remains
> of load/store speculations. Other CPUs don't pollute the cache
> after it got flushed.
> 
> But this optimization is wrong, we need to do the flush for
> every non coherent device otherwise polling a descriptor via
> a cached mapping can't work. And this exactly what E100 does.

When polling the buffer basically changes ownership between CPU and device
and buffer all the time, so a drivers needs to do a
dma_sync_*_for_cpu call before looking at the buffer, then 
dma_sync_*_for_device to return the buffer to the device.  So to polling
loop will work fine as long as one of the two calls does the flush operation.
In fact we're even doing double flushes for the case of non-coherent
R10000s ...

  Ralf
