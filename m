Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5J9eNnC013782
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 19 Jun 2002 02:40:23 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5J9eN7N013781
	for linux-mips-outgoing; Wed, 19 Jun 2002 02:40:23 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (c-180-196-131.ka.dial.de.ignite.net [62.180.196.131])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5J9eGnC013775
	for <linux-mips@oss.sgi.com>; Wed, 19 Jun 2002 02:40:17 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g5J9evC22344
	for linux-mips@oss.sgi.com; Wed, 19 Jun 2002 11:40:57 +0200
Date: Wed, 19 Jun 2002 11:39:33 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: William Jhun <wjhun@ayrnetworks.com>
Cc: "linux-mips@oss.sgi.com"@ayrnetworks.com
Subject: Re: [PATCH] dma_cache_wback, pci DMA cache coherency changes
Message-ID: <20020619113933.C22048@dea.linux-mips.net>
References: <20020618100347.A1361@ayrnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020618100347.A1361@ayrnetworks.com>; from wjhun@ayrnetworks.com on Tue, Jun 18, 2002 at 10:03:47AM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jun 18, 2002 at 10:03:47AM -0700, William Jhun wrote:

> To: "linux-mips@oss.sgi.com"@ayrnetworks.com
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Your mail software is smoking funny stuff ;-)

> This is a re-hash of patches I sent out a while ago which do a more
> optimal cache-flushing for pci_map_*() and pci_dma_sync_*(). It
> basically does an invalidate for PCI_DMA_FROMDEVICE operations and a
> writeback for PCI_DMA_TODEVICE pci_map_* (or writeback/invalidate if
> PCI_DMA_BIDIRECTIONAL). This is similar to the ARM implementation.
> 
> Additionally, I filled in the _dma_cache_wback calls in the
> arch/mips/c-*.c to call *_dma_cache_wback_inv* instead of calling
> panic(). Some architectures could probably do a real writeback instead
> of just wback_inv, but this will at least allow code that can use
> writeback-only if available.
> 
> Note: I'm not familiar with a lot of these CPUs, but the change should
> be innocuous. Could someone validate/improve these?

Can you try to get rid of all these #ifdef CONFIG_NONCOHERENT_IO things?
We already had too many of them and you're adding even more ...
Basically if dma_cache_wback_inv, dma_cache_wback and dma_cache_inv are
just empty macros as they are if CONFIG_NONCOHERENT_IO is undefined
gcc should be able to optimize most of the #ifdef'd code away.

Please always cc patches you want to submit to me or I might miss them on
the list.

  Ralf
