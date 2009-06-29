Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Jun 2009 21:13:35 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:46680 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493357AbZF2TNZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 29 Jun 2009 21:13:25 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n5TJ8Cuf023738;
	Mon, 29 Jun 2009 20:08:12 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n5TJ8Ahk023736;
	Mon, 29 Jun 2009 20:08:10 +0100
Date:	Mon, 29 Jun 2009 20:08:10 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	KKylheku@zeugmasystems.com, aurelien@aurel32.net,
	linux-mips@linux-mips.org
Subject: Re: Broadcom Swarm support
Message-ID: <20090629190809.GC22264@linux-mips.org>
References: <20090626232432.GB3235@linux-mips.org> <20090627.225933.208964286.anemo@mba.ocn.ne.jp> <20090627154811.GA22264@linux-mips.org> <20090628.010906.115909054.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090628.010906.115909054.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23536
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Jun 28, 2009 at 01:09:06AM +0900, Atsushi Nemoto wrote:

> > The I-cache for page just being loaded is clean so no flushing needed.  It
> > is clean because when the page has been unmapped it was flushed or because
> > the CPU switched to a fresh ASID.
> 
> Then, flush_cache_range or flush_cache_page should be called then the
> page was unmmapped, right?  How about flush_cache_mm?  It does not
> flush icache currently.

If that is being called then we're either about to terminate a process or
to exec a new process.  In either case flush_tlb_cache (on VIVT I-cache)
will drop the tlb context which effectively is a full I-cache flush.

> And how about kernel __init code pages?  These pages are just freed on
> free_initmem.  Also how about code pages used by a module which is to
> be unloaded from kernel?

Init code pages won't be used to store code that will be executed at
KSEG0 or XKPHYS addresses so I-cache coherency is not of interest.

For modules the I-cache is being flushed on loading of the module, see
calls to flush_icache_range() in kernel/module.c so I-cache coherency is
not of concern on module unload.

> > The reason for this bug is that when data is being shoveled around by the
> > processor (as opposed to DMA) as on PIO block devices it'll end up sitting
> > in the D-cache so I-cache refills will grab stale data from S-cache or
> > memory.
> 
> Yes, I suppose so on this swarm case, but I'm just thinking of other
> case breaking icache coherency...

Be careful with that - you might succeed ;-)

  Ralf
