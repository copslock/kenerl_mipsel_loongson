Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Feb 2009 21:27:59 +0000 (GMT)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:12943 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S21103491AbZBDV15 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 4 Feb 2009 21:27:57 +0000
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n14LRmPX014214;
	Wed, 4 Feb 2009 21:27:48 GMT
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n14LRlrj014212;
	Wed, 4 Feb 2009 21:27:47 GMT
Date:	Wed, 4 Feb 2009 21:27:46 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"David VomLehn (dvomlehn)" <dvomlehn@cisco.com>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, ddaney@caviumnetworks.com,
	"Michael Sundius -X (msundius - Yoh Services LLC at Cisco)" 
	<msundius@cisco.com>, linux-mips@linux-mips.org,
	msundius@sundius.com
Subject: Re: memcpy and prefetch
Message-ID: <20090204212746.GB13138@linux-mips.org>
References: <20090128103753.GC2234@linux-mips.org> <20090129.002850.118974677.anemo@mba.ocn.ne.jp> <20090128183047.GA1691@linux-mips.org> <20090129.213613.128618730.anemo@mba.ocn.ne.jp> <20090129155854.GC29521@linux-mips.org> <FF038EB85946AA46B18DFEE6E6F8A2898237E1@xmb-rtp-218.amer.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FF038EB85946AA46B18DFEE6E6F8A2898237E1@xmb-rtp-218.amer.cisco.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21906
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jan 29, 2009 at 10:39:37PM -0500, David VomLehn (dvomlehn) wrote:

> > The idea here is that we have two issues with prefetching:
> > 
> >  o Prefetching beyond the end of the source or destination range on a
> >    in-coherent range might bring back stale values from a DMA I/O
> >    buffer resulting in data corruption.  Hardware DMA coherency will
> >    avoid this issue.
> > 
> >  o IP27 has full blown hardware coherency.  Historically 
> > CONFIG_DMA_COHERENT
> >    was not able to cope with something of the complexity of IP27, so
> >    there was a separate CONFIG_DMA_IP27 and the broken logic 
> > expression
> >    was meant to treat CONFIG_DMA_COHERENT and CONFIG_DMA_IP27 the same
> >    as for prefetching.
> > 
> >  o Prefetching beyond the end of physical memory can cause 
> > exceptions on
> >    some systems.  The Malta has this problem.
> > 
> > Thus no prefetching on Malta or non-coherent systems.

> It seems to me as though we could avoid the first and third problems
> with a memcpy that doesn't prefetch past the end of the buffer, the
> thought being that if we are reading or writing a memory region, we
> really shouldn't be doing DMA to or from that location. This would
> probably be slightly suboptimal, performance-wise, for those systems
> that do have DMA coherence. It seems as though we could have two
> mutually exclusive versions, selectable via the CONFIG_DMA_COHERENT
> flag. For those of us without DMA coherence, it would probably give our
> memcpy performance a bit of a kick in the pants over using no prefetch
> at all.

Unnecessary prefetching can come at a high cost due to memory latencies
and cache pollution.  So you want to avoid unnecessary prefetches rather
than hoping for hardware cache coherency to sorts out the mess software
left behind.

The general expectation is that prefetching will help - but depending on
the pipeline structure prefetching can be hard to exploit optimally.  For
example there are MIPS cores were the optimal sequence is something like

  load store load store load store load store

But on others it's

  load load load load store store store store

Placing prefetching instructions into loops built from such blocks can
result in very surprising result.

> If this makes sense, we might be able to sign up to do the work. Anyone
> have a good, caching-aware memcpy test?

Testing memcpy is an interesting little project.  Correctness is one
thing but a good implementation needs to do a few performance tradeoffs
which are best meassure with real world, not synthetic workloads.

  Ralf
