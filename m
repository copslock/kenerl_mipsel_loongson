Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jan 2009 15:59:28 +0000 (GMT)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:34436 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S21103497AbZA2P7Z (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 29 Jan 2009 15:59:25 +0000
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n0TFwuw9032204;
	Thu, 29 Jan 2009 15:58:56 GMT
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n0TFwsbo032201;
	Thu, 29 Jan 2009 15:58:54 GMT
Date:	Thu, 29 Jan 2009 15:58:54 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	ddaney@caviumnetworks.com, msundius@cisco.com,
	linux-mips@linux-mips.org, dvomlehn@cisco.com, msundius@sundius.com
Subject: Re: memcpy and prefetch
Message-ID: <20090129155854.GC29521@linux-mips.org>
References: <20090128103753.GC2234@linux-mips.org> <20090129.002850.118974677.anemo@mba.ocn.ne.jp> <20090128183047.GA1691@linux-mips.org> <20090129.213613.128618730.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090129.213613.128618730.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21874
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jan 29, 2009 at 09:36:13PM +0900, Atsushi Nemoto wrote:

> On Wed, 28 Jan 2009 18:30:47 +0000, Ralf Baechle <ralf@linux-mips.org> wrote:
> > --- a/arch/mips/lib/memcpy.S
> > +++ b/arch/mips/lib/memcpy.S
> > @@ -21,7 +21,7 @@
> >   * end of memory on some systems.  It's also a seriously bad idea on non
> >   * dma-coherent systems.
> >   */
> > -#if !defined(CONFIG_DMA_COHERENT) || !defined(CONFIG_DMA_IP27)
> > +#ifdef CONFIG_DMA_NONCOHERENT
> >  #undef CONFIG_CPU_HAS_PREFETCH
> >  #endif
> >  #ifdef CONFIG_MIPS_MALTA
> 
> This makes IP27 (and all other coherent platforms) use prefetch.  Is
> prefetch OK for all of them?
> 
> I suppose memcpy_fromio() should not use PREFETCH, at least.

The idea here is that we have two issues with prefetching:

 o Prefetching beyond the end of the source or destination range on a
   in-coherent range might bring back stale values from a DMA I/O
   buffer resulting in data corruption.  Hardware DMA coherency will
   avoid this issue.

 o IP27 has full blown hardware coherency.  Historically CONFIG_DMA_COHERENT
   was not able to cope with something of the complexity of IP27, so
   there was a separate CONFIG_DMA_IP27 and the broken logic expression
   was meant to treat CONFIG_DMA_COHERENT and CONFIG_DMA_IP27 the same
   as for prefetching.

 o Prefetching beyond the end of physical memory can cause exceptions on
   some systems.  The Malta has this problem.

Thus no prefetching on Malta or non-coherent systems.

  Ralf
