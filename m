Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Apr 2012 04:44:27 +0200 (CEST)
Received: from mail-qc0-f177.google.com ([209.85.216.177]:65345 "EHLO
        mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903568Ab2DJCoL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 10 Apr 2012 04:44:11 +0200
Received: by qcsu28 with SMTP id u28so3234513qcs.36
        for <multiple recipients>; Mon, 09 Apr 2012 19:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=BzlELVHAa2lhbXWx+HHeTCyJ/JoN74utLOSXczBOU94=;
        b=fXd/iJo3cwk/uugFNi5cUfSGoskonE3406OPnubvikB9hh3wjGKXYTmA8smI66003+
         wrPTAfyb7lu26N4Tqts3VYz2kkGxxznMAxX1bqZXq/9Y2G3MbkxUGMkAWxznWeFJbAoy
         bSrJthMQE6a9XIzCoHCBI2n732X4da6p2uIy+lsPRH+4g97mofyGYC3iosP+4t7rtdwe
         1jGyeDQJt3MfPmMERvQ7YY/eAaax/fiuuQGNaDBV/MpMU26bObNX3e4a1ArZphx5F0R3
         07M5pE+AcqieDAPfGhWEMHZBzUgkdXZp9a99o+8nsK9cN9cknxf8y9zc3vKz/BisjW6M
         KfQg==
MIME-Version: 1.0
Received: by 10.229.136.203 with SMTP id s11mr3743456qct.106.1334025845114;
 Mon, 09 Apr 2012 19:44:05 -0700 (PDT)
Received: by 10.224.125.69 with HTTP; Mon, 9 Apr 2012 19:44:05 -0700 (PDT)
In-Reply-To: <1333987989-1178-1-git-send-email-sjhill@mips.com>
References: <1333987989-1178-1-git-send-email-sjhill@mips.com>
Date:   Mon, 9 Apr 2012 19:44:05 -0700
Message-ID: <CAJiQ=7AjtSB8KQ9+edUOvW+70nAWzh6c8B26ehnEpuud6QeMJA@mail.gmail.com>
Subject: Re: [PATCH] Revert "MIPS: cache: Provide cache flush operations for XFS"
From:   Kevin Cernekee <cernekee@gmail.com>
To:     "Steven J. Hill" <sjhill@mips.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        Leonid Yegoshin <yegoshin@mips.com>
Content-Type: text/plain; charset=UTF-8
X-archive-position: 32916
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Mon, Apr 9, 2012 at 9:13 AM, Steven J. Hill <sjhill@mips.com> wrote:
> This reverts commit d759e6bf49a41edd66de7c6480b34cceb88ee29a.

It may be clearer to say "refactors" instead of "reverts," as this
patch reimplements the same feature in a different way.

If the change was completely reverting the MIPS *_kernel_vmap_range
functions, that would make me very uneasy as XFS will not run reliably
on my systems without them.

Also, the commit hash is d9cdc901af0f92da7f90c750d8c187f5500be067 in
Linus' tree.

> The
> flush_kernel_vmap_range() and invalidate_kernel_vmap_range() are DMA
> cache flushing operations and should be done via _dma_cache_wback_inv()
> and _dma_cache_inv().

I think there is some ambiguity here.

Documentation/cachetlb.txt says:

"Since kernel I/O goes via physical pages, the I/O subsystem assumes
that the user mapping and kernel offset mapping are the only aliases.
This isn't true for vmap aliases, so anything in the kernel trying to
do I/O to vmap areas must manually manage coherency.  It must do this
by flushing the vmap range before doing I/O and invalidating it after
the I/O returns."

"The design is to make this area safe to perform I/O on."

This appears to support your statement.

However, actual usage suggests that the *_kernel_vmap_range functions
are used way up at the filesystem layer just to get the data out of
the "wrong colored" D$ lines on systems with cache aliases:

		if (xfs_buf_is_vmapped(bp)) {
			flush_kernel_vmap_range(bp->b_addr,
						xfs_buf_vmap_len(bp));
		}
		submit_bio(rw, bio);

Then eventually, something like dma_map_sg() is called from a lower
level driver (ala ata_sg_setup()), to perform the full L1+L2
cacheflush on each page involved in the transaction.

I would also note that on ARM these operations turn into NOPs on VIPT
non-aliasing CPUs, even if their caches are noncoherent:

static inline void flush_kernel_vmap_range(void *addr, int size)
{
	if ((cache_is_vivt() || cache_is_vipt_aliasing()))
	  __cpuc_flush_dcache_area(addr, (size_t)size);
}

I suspect that reimplementing the *_kernel_vmap_range functions using
_dma_cache_* would result in a double L2 flush on the same memory
regions on systems with cache aliases, and an unnecessary L1+L2 flush
on systems without aliases.

I don't see any way that the *_kernel_vmap_range functions could be
called in lieu of the dma_map_* functions, as they are missing
critical elements such as "returning the mapped PA" and calls to the
plat_* functions.  So, any memory getting flushed through
*_kernel_vmap_range will still need to use dma_map_* for DMA.

Is there a reason why Ralf's original approach was not workable?
