Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Sep 2013 12:44:35 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:45995 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6827678Ab3IQKodkbt72 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 Sep 2013 12:44:33 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id r8HAiW6U025496;
        Tue, 17 Sep 2013 12:44:32 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id r8HAiVKU025495;
        Tue, 17 Sep 2013 12:44:31 +0200
Date:   Tue, 17 Sep 2013 12:44:31 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Markos Chandras <markos.chandras@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Fix accessing to per-cpu data when flushing the
 cache
Message-ID: <20130917104431.GB22468@linux-mips.org>
References: <1379411005-20829-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1379411005-20829-1-git-send-email-markos.chandras@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37827
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Tue, Sep 17, 2013 at 10:43:25AM +0100, Markos Chandras wrote:

> The cache flushing code uses the current_cpu_data macro which
> may cause problems in preemptive kernels because it relies on
> smp_processor_id() to get the current cpu number. Per cpu-data
> needs to be protected so we disable preemption around the flush
> caching code. We enable it back when we are about to return.
> 
> Fixes the following problem:
> 
> BUG: using smp_processor_id() in preemptible [00000000] code: kjournald/1761
> caller is blast_dcache32+0x30/0x254

Just what I feared - these messages popping out from all over the tree.

I'd prefer if we change the caller otherwise depending on the platform
a single cache flush might involve several preempt_disable/-enable
invocations.  Something like below.

And it also keeps the header file more usable outside the core kernel
which Florian's recent zboot a little easier.

However maybe we'd be even better off to just switch to boot_cpu_data.
That should be fine since r4k_dma_cache_* are only being used on
uniprocessor systems anyway.

  Ralf

 arch/mips/mm/c-r4k.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 3ff2f74..73ca8c5 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -12,6 +12,7 @@
 #include <linux/highmem.h>
 #include <linux/kernel.h>
 #include <linux/linkage.h>
+#include <linux/preempt.h>
 #include <linux/sched.h>
 #include <linux/smp.h>
 #include <linux/mm.h>
@@ -602,6 +603,7 @@ static void r4k_dma_cache_wback_inv(unsigned long addr, unsigned long size)
 	/* Catch bad driver code */
 	BUG_ON(size == 0);
 
+	preempt_disable();
 	if (cpu_has_inclusive_pcaches) {
 		if (size >= scache_size)
 			r4k_blast_scache();
@@ -622,6 +624,7 @@ static void r4k_dma_cache_wback_inv(unsigned long addr, unsigned long size)
 		R4600_HIT_CACHEOP_WAR_IMPL;
 		blast_dcache_range(addr, addr + size);
 	}
+	preempt_enable();
 
 	bc_wback_inv(addr, size);
 	__sync();
@@ -632,6 +635,7 @@ static void r4k_dma_cache_inv(unsigned long addr, unsigned long size)
 	/* Catch bad driver code */
 	BUG_ON(size == 0);
 
+	preempt_disable();
 	if (cpu_has_inclusive_pcaches) {
 		if (size >= scache_size)
 			r4k_blast_scache();
@@ -656,6 +660,7 @@ static void r4k_dma_cache_inv(unsigned long addr, unsigned long size)
 		R4600_HIT_CACHEOP_WAR_IMPL;
 		blast_inv_dcache_range(addr, addr + size);
 	}
+	preempt_enable();
 
 	bc_inv(addr, size);
 	__sync();
