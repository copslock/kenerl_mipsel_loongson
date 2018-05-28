Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 May 2018 13:05:01 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:44640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994847AbeE1LE1duBA0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 28 May 2018 13:04:27 +0200
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDED3208A1;
        Mon, 28 May 2018 11:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1527505461;
        bh=qQkynfUDaG95ACkPXoJ1XkeGvGFZ2nYgkdBrxIH+h7A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rsOE7KHwjVMvPFmVrYrVtuZhbnjBRHAWuV/U00gW1phlWVL2LgXx7wB+xc1MPr8XC
         LJFZyb0l6oE0UO8dUpZge+SS0dR450oKVQNTy96nsdha2Y9F/9K+mRo538NgYQu9zD
         ePvNR2LAO2RQlM6yMK3aqha6b7MYMsmwvWPh+SlA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, NeilBrown <neil@brown.name>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>
Subject: [PATCH 4.16 003/272] MIPS: c-r4k: Fix data corruption related to cache coherence
Date:   Mon, 28 May 2018 12:00:36 +0200
Message-Id: <20180528100240.501786137@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <SRS0=WbIs=IP=linuxfoundation.org=gregkh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64111
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: NeilBrown <neil@brown.name>

commit 55a2aa08b3af519a9693f99cdf7fa6d8b62d9f65 upstream.

When DMA will be performed to a MIPS32 1004K CPS, the L1-cache for the
range needs to be flushed and invalidated first.
The code currently takes one of two approaches.
1/ If the range is less than the size of the dcache, then HIT type
   requests flush/invalidate cache lines for the particular addresses.
   HIT-type requests a globalised by the CPS so this is safe on SMP.

2/ If the range is larger than the size of dcache, then INDEX type
   requests flush/invalidate the whole cache. INDEX type requests affect
   the local cache only. CPS does not propagate them in any way. So this
   invalidation is not safe on SMP CPS systems.

Data corruption due to '2' can quite easily be demonstrated by
repeatedly "echo 3 > /proc/sys/vm/drop_caches" and then sha1sum a file
that is several times the size of available memory. Dropping caches
means that large contiguous extents (large than dcache) are more likely.

This was not a problem before Linux-4.8 because option 2 was never used
if CONFIG_MIPS_CPS was defined. The commit which removed that apparently
didn't appreciate the full consequence of the change.

We could, in theory, globalize the INDEX based flush by sending an IPI
to other cores. These cache invalidation routines can be called with
interrupts disabled and synchronous IPI require interrupts to be
enabled. Asynchronous IPI may not trigger writeback soon enough. So we
cannot use IPI in practice.

We can already test if IPI would be needed for an INDEX operation with
r4k_op_needs_ipi(R4K_INDEX). If this is true then we mustn't try the
INDEX approach as we cannot use IPI. If this is false (e.g. when there
is only one core and hence one L1 cache) then it is safe to use the
INDEX approach without IPI.

This patch avoids options 2 if r4k_op_needs_ipi(R4K_INDEX), and so
eliminates the corruption.

Fixes: c00ab4896ed5 ("MIPS: Remove cpu_has_safe_index_cacheops")
Signed-off-by: NeilBrown <neil@brown.name>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 4.8+
Patchwork: https://patchwork.linux-mips.org/patch/19259/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/mm/c-r4k.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -851,9 +851,12 @@ static void r4k_dma_cache_wback_inv(unsi
 	/*
 	 * Either no secondary cache or the available caches don't have the
 	 * subset property so we have to flush the primary caches
-	 * explicitly
+	 * explicitly.
+	 * If we would need IPI to perform an INDEX-type operation, then
+	 * we have to use the HIT-type alternative as IPI cannot be used
+	 * here due to interrupts possibly being disabled.
 	 */
-	if (size >= dcache_size) {
+	if (!r4k_op_needs_ipi(R4K_INDEX) && size >= dcache_size) {
 		r4k_blast_dcache();
 	} else {
 		R4600_HIT_CACHEOP_WAR_IMPL;
@@ -890,7 +893,7 @@ static void r4k_dma_cache_inv(unsigned l
 		return;
 	}
 
-	if (size >= dcache_size) {
+	if (!r4k_op_needs_ipi(R4K_INDEX) && size >= dcache_size) {
 		r4k_blast_dcache();
 	} else {
 		R4600_HIT_CACHEOP_WAR_IMPL;
