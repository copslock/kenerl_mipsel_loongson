Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Nov 2010 15:05:37 +0100 (CET)
Received: from bombadil.infradead.org ([18.85.46.34]:55843 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492018Ab0KIOFd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Nov 2010 15:05:33 +0100
Received: from hch by bombadil.infradead.org with local (Exim 4.72 #1 (Red Hat Linux))
        id 1PFopE-0004tc-1P; Tue, 09 Nov 2010 14:05:28 +0000
Date:   Tue, 9 Nov 2010 09:05:28 -0500
From:   Christoph Hellwig <hch@infradead.org>
To:     Ajeet Yadav <ajeet.yadav.77@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "xfs@oss.sgi.com" <xfs@oss.sgi.com>, linux-mips@linux-mips.org
Subject: Re: XFS mounting fails on MIPS
Message-ID: <20101109140527.GA13041@infradead.org>
References: <AANLkTi=mLwQ0N_cErHzES1ZWvOa8jQspeYwKgn9sU4Jm@mail.gmail.com>
 <20101104125052.GA22429@infradead.org>
 <AANLkTinqK-HvuHPeaTgxJOJuWMfomP2C12G=uVcqhWdn@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AANLkTinqK-HvuHPeaTgxJOJuWMfomP2C12G=uVcqhWdn@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org
        See http://www.infradead.org/rpr.html
Return-Path: <BATV+59881b75a86bc7c2a8cd+2634+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28342
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@infradead.org
Precedence: bulk
X-list: linux-mips

Hi Ajeet,

On Tue, Nov 09, 2010 at 04:43:04PM +0530, Ajeet Yadav wrote:
> True, its the same system and you were right it was cache VIPT cache problem
> the cache hold the stale value even after xlog_bread() update the buffer.
> I do not know whether its correct ways to resolve the problem, but the
> problem no longer occur.

It seems like you more less re-implemented the vmap coherency hooks
inside XFS, hardcoded to the mips implementation.

The actual helpers would looks something like:

static inline void flush_kernel_vmap_range(void *addr, int size)
{
	dma_cache_inv(addr, size);
}

static inline void invalidate_kernel_vmap_range(void *addr, int size)
{
	dma_cache_inv(addr, size);
}

For some reason the kernel also expects flush_dcache_page to be
implemented by an architecture if we want to implement these two
(it's keyed off ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE).

Can someone of the mips folks helps with this?

The testcase is easy, mounting an xfs filesystem after an unclean
shutdown on a machine with virtually indexed caches.
