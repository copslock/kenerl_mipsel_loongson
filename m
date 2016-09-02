Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Sep 2016 16:18:17 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:22319 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991344AbcIBOSKgypI4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Sep 2016 16:18:10 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 9F6BA450A8ED;
        Fri,  2 Sep 2016 15:17:50 +0100 (IST)
Received: from localhost (10.100.200.40) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 2 Sep
 2016 15:17:53 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Rabin Vincent <rabinv@axis.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Jerome Marchand <jmarchan@redhat.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        <linux-kernel@vger.kernel.org>,
        Jaedon Shin <jaedon.shin@gmail.com>,
        Toshi Kani <toshi.kani@hpe.com>,
        James Hogan <james.hogan@imgtec.com>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Jonas Gorski <jogo@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH] MIPS: Fix detection of unsupported highmem with cache aliases
Date:   Fri, 2 Sep 2016 15:17:31 +0100
Message-ID: <20160902141731.2160-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.40]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54998
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

The paging_init() function contains code which detects that highmem is
in use but unsupported due to dcache aliasing. However this code was
ineffective because it was being run before the caches are probed,
meaning that cpu_has_dc_aliases would always evaluate to false (unless a
platform overrides it to a compile-time constant) and the detection of
the unsupported case is never triggered. The kernel would then go on to
attempt to use highmem & either hit coherency issues or trigger the
BUG_ON in flush_kernel_dcache_page().

Fix this by running paging_init() later than cpu_cache_init(), such that
the cpu_has_dc_aliases macro will evaluate correctly & the unsupported
highmem case will be detected successfully.

This then leads to a formerly hidden issue in that
mem_init_free_highmem() will attempt to free all highmem pages, even
though we're avoiding use of them & don't have valid page structs for
them. This leads to an invalid pointer dereference & a TLB exception.
Avoid this by skipping the loop in mem_init_free_highmem() if
cpu_has_dc_aliases evaluates true.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/kernel/setup.c | 2 +-
 arch/mips/mm/init.c      | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index ef408a0..d840f02 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -757,7 +757,6 @@ static void __init arch_mem_init(char **cmdline_p)
 	device_tree_init();
 	sparse_init();
 	plat_swiotlb_setup();
-	paging_init();
 
 	dma_contiguous_reserve(PFN_PHYS(max_low_pfn));
 	/* Tell bootmem about cma reserved memblock section */
@@ -870,6 +869,7 @@ void __init setup_arch(char **cmdline_p)
 	prefill_possible_map();
 
 	cpu_cache_init();
+	paging_init();
 }
 
 unsigned long kernelsp[NR_CPUS];
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 9b58eb5..ea6d8b6 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -441,6 +441,9 @@ static inline void mem_init_free_highmem(void)
 #ifdef CONFIG_HIGHMEM
 	unsigned long tmp;
 
+	if (cpu_has_dc_aliases)
+		return;
+
 	for (tmp = highstart_pfn; tmp < highend_pfn; tmp++) {
 		struct page *page = pfn_to_page(tmp);
 
-- 
2.9.3
