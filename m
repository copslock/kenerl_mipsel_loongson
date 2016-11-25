Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Nov 2016 19:47:35 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:7103 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991894AbcKYSrKxAGNI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 Nov 2016 19:47:10 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id BD9D15E46D5EF;
        Fri, 25 Nov 2016 18:46:59 +0000 (GMT)
Received: from localhost (10.100.200.171) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 25 Nov
 2016 18:47:03 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 2/3] MIPS: Don't writeback when cache-invalidating DMA buffers
Date:   Fri, 25 Nov 2016 18:46:10 +0000
Message-ID: <20161125184611.28396-3-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161125184611.28396-1-paul.burton@imgtec.com>
References: <20161125184611.28396-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.171]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55894
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

The DMA API should not be used to map memory which isn't cache-line
aligned. To quote Documentation/DMA-API.txt:

  Warnings:  Memory coherency operates at a granularity called the cache
  line width.  In order for memory mapped by this API to operate
  correctly, the mapped region must begin exactly on a cache line
  boundary and end exactly on one (to prevent two separately mapped
  regions from sharing a single cache line).  Since the cache line size
  may not be known at compile time, the API will not enforce this
  requirement.  Therefore, it is recommended that driver writers who
  don't take special care to determine the cache line size at run time
  only map virtual regions that begin and end on page boundaries (which
  are guaranteed also to be cache line boundaries).

The MIPS L2 cache code has until now attempted to work around unaligned
cache maintenance by writing back the first & last lines of a region to
be invalidated. This is problematic however, because if we access either
line after our initial invalidate call & before the DMA completes we'll
cause the cache line to become valid & thus see stale data unless we go
on to perform a second invalidate on systems where
cpu_needs_post_dma_flush() == 1. In such systems we still have problems
because if we wrote to either cache line causing it to become dirty then
the writeback of it would clobber the data that was written to memory by
the device performing DMA.

Fix this by removing the bogus writebacks in the L2 cache invalidate
code when the region is aligned. If cache invalidation functions are
invoked on a region which is not cacheline-aligned then produce a
warning and proceed to perform the writebacks despite them being
technically incorrect, in an attempt to both allow broken drivers to
continue to "work" whilst being annoying enough to cause people to fix
them. Ideally at some point we'd remove the writebacks entirely, but at
least leaving them for now will let broken drivers stand a chance of
continuing to work as we find & fix anything that begins emitting
warnings over the next cycle or two.

In an ideal world we would also check that the size of the memory region
we're performing cache maintenance upon is aligned, however this
generates a great deal of noise from drivers which kmalloc a region of
memory & then map some subset of it using the dma_map_* APIs. These
callers will work fine due to kmalloc providing suitably aligned memory,
but because they don't know that kmalloc may have padded out the region
they requested they don't tell the DMA API the actual size of the region
& we instead see the size that they requested. This leads to all sorts
of noise from many many drivers & subsystems so settle for only checking
the base address of the region.

A further limitation is that we'd ideally check the alignment for
writeback & invalidate operations, since DMA buffers that we write to &
devices read from ought to be cache-line aligned too in order to satisfy
the documented requirements of the DMA API. However there is a fair
amount of code which violates this alignment requirement, most notably
core networking code which seems to routinely map unaligned regions via
skb_frag_dma_map(). Since this would be rather invasive to change and
the writebacks aren't harmful/lossy, we ignore the writeback case for
now too.

Although this fixes a bug introduced way back in v2.6.29 by commit
a8ca8b64e3fd ("MIPS: Avoid destructive invalidation on partial
cachelines."), which has since been undone, and commit 96983ffefce4
("MIPS: MIPSxx SC: Avoid destructive invalidation on partial L2
cachelines.") which hasn't, I have not marked this for stable since it
can trigger large numbers of warnings in systems which have not fixed up
their drivers to correctly align buffers, and presumably the bulk of
systems in the wild haven't hit this problem.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/mm/c-r4k.c   |  7 +++++++
 arch/mips/mm/sc-mips.c | 36 ++++++++++++++++++++++++++++++++++--
 2 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 20c4c5f..0642a27 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -879,6 +879,11 @@ static void r4k_dma_cache_inv(unsigned long addr, unsigned long size)
 
 	preempt_disable();
 	if (cpu_has_inclusive_pcaches) {
+		unsigned int slsize = cpu_scache_line_size();
+
+		if (slsize)
+			WARN_ON(addr % slsize);
+
 		if (size >= scache_size)
 			r4k_blast_scache();
 		else {
@@ -897,6 +902,8 @@ static void r4k_dma_cache_inv(unsigned long addr, unsigned long size)
 		return;
 	}
 
+	WARN_ON(addr % cpu_dcache_line_size());
+
 	if (size >= dcache_size) {
 		r4k_blast_dcache();
 	} else {
diff --git a/arch/mips/mm/sc-mips.c b/arch/mips/mm/sc-mips.c
index 286a4d5..1847610 100644
--- a/arch/mips/mm/sc-mips.c
+++ b/arch/mips/mm/sc-mips.c
@@ -36,8 +36,40 @@ static void mips_sc_inv(unsigned long addr, unsigned long size)
 	unsigned long lsize = cpu_scache_line_size();
 	unsigned long almask = ~(lsize - 1);
 
-	cache_op(Hit_Writeback_Inv_SD, addr & almask);
-	cache_op(Hit_Writeback_Inv_SD, (addr + size - 1) & almask);
+	if (WARN_ON(addr % lsize)) {
+		/*
+		 * This is dangerous. The first or last cache line here may be
+		 * overlapping other data which is not in the region being
+		 * written to by DMA. Writing back here may therefore seem to
+		 * make sense in order to avoid discarding data that we may
+		 * have written to those cache lines, however doing so does not
+		 * fix problems which may arise if either:
+		 *
+		 * - We read the data that shares cache lines with the memory
+		 *   region being DMA'd to whilst the DMA occurs. This would
+		 *   result in the cache line being brought into cache & us
+		 *   seeing a potentially stale view of memory that was written
+		 *   to via DMA.
+		 *
+		 * - We write to the data that shares cache lines with the
+		 *   memory region being DMA'd to whilst the DMA occurs. On
+		 *   systems where this may occur we need to invalidate in
+		 *   caches the region written to by DMA after the DMA
+		 *   completes, as well as before it starts. When we do this
+		 *   second invalidate we may discard any data currently dirty
+		 *   in the first or last cache lines - essentially the problem
+		 *   these writebacks intended to avoid.
+		 *
+		 * The only correct solution to this is for memory regions
+		 * being used for DMA to be cacheline-aligned, as described by
+		 * Documentation/DMA-API.txt. With any luck the warning
+		 * generated above will be enough to cause people to fix any
+		 * drivers which do not do so.
+		 */
+		cache_op(Hit_Writeback_Inv_SD, addr & almask);
+		cache_op(Hit_Writeback_Inv_SD, (addr + size - 1) & almask);
+	}
+
 	blast_inv_scache_range(addr, addr + size);
 }
 
-- 
2.10.2
