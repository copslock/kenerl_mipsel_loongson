Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Sep 2013 11:43:39 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:13480 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822664Ab3IQJnhYBTns (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 Sep 2013 11:43:37 +0200
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH] MIPS: Fix accessing to per-cpu data when flushing the cache
Date:   Tue, 17 Sep 2013 10:43:25 +0100
Message-ID: <1379411005-20829-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.3.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.31]
X-SEF-Processed: 7_3_0_01192__2013_09_17_10_43_31
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37826
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

The cache flushing code uses the current_cpu_data macro which
may cause problems in preemptive kernels because it relies on
smp_processor_id() to get the current cpu number. Per cpu-data
needs to be protected so we disable preemption around the flush
caching code. We enable it back when we are about to return.

Fixes the following problem:

BUG: using smp_processor_id() in preemptible [00000000] code: kjournald/1761
caller is blast_dcache32+0x30/0x254
Call Trace:
[<8047f02c>] dump_stack+0x8/0x34
[<802e7e40>] debug_smp_processor_id+0xe0/0xf0
[<80114d94>] blast_dcache32+0x30/0x254
[<80118484>] r4k_dma_cache_wback_inv+0x200/0x288
[<80110ff0>] mips_dma_map_sg+0x108/0x180
[<80355098>] ide_dma_prepare+0xf0/0x1b8
[<8034eaa4>] do_rw_taskfile+0x1e8/0x33c
[<8035951c>] ide_do_rw_disk+0x298/0x3e4
[<8034a3c4>] do_ide_request+0x2e0/0x704
[<802bb0dc>] __blk_run_queue+0x44/0x64
[<802be000>] queue_unplugged.isra.36+0x1c/0x54
[<802beb94>] blk_flush_plug_list+0x18c/0x24c
[<802bec6c>] blk_finish_plug+0x18/0x48
[<8026554c>] journal_commit_transaction+0x3b8/0x151c
[<80269648>] kjournald+0xec/0x238
[<8014ac00>] kthread+0xb8/0xc0
[<8010268c>] ret_from_kernel_thread+0x14/0x1c

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
This patch is for the upstream-sfr/mips-for-linux-next tree
---
 arch/mips/include/asm/r4kcache.h | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/arch/mips/include/asm/r4kcache.h b/arch/mips/include/asm/r4kcache.h
index a0b2650..8f1a6a1 100644
--- a/arch/mips/include/asm/r4kcache.h
+++ b/arch/mips/include/asm/r4kcache.h
@@ -344,18 +344,21 @@ static inline void invalidate_tcache_page(unsigned long addr)
 static inline void blast_##pfx##cache##lsize(void)			\
 {									\
 	unsigned long start = INDEX_BASE;				\
-	unsigned long end = start + current_cpu_data.desc.waysize;	\
-	unsigned long ws_inc = 1UL << current_cpu_data.desc.waybit;	\
-	unsigned long ws_end = current_cpu_data.desc.ways <<		\
-			       current_cpu_data.desc.waybit;		\
-	unsigned long ws, addr;						\
+	unsigned long end, ws_inc, ws_end, ws, addr;			\
 									\
 	__##pfx##flush_prologue						\
+	preempt_disable();						\
+									\
+	end = start + current_cpu_data.desc.waysize;			\
+	ws_inc = 1UL << current_cpu_data.desc.waybit;			\
+	ws_end = current_cpu_data.desc.ways <<				\
+		 current_cpu_data.desc.waybit;				\
 									\
 	for (ws = 0; ws < ws_end; ws += ws_inc)				\
 		for (addr = start; addr < end; addr += lsize * 32)	\
 			cache##lsize##_unroll32(addr|ws, indexop);	\
 									\
+	preempt_enable();						\
 	__##pfx##flush_epilogue						\
 }									\
 									\
@@ -376,20 +379,23 @@ static inline void blast_##pfx##cache##lsize##_page(unsigned long page) \
 									\
 static inline void blast_##pfx##cache##lsize##_page_indexed(unsigned long page) \
 {									\
-	unsigned long indexmask = current_cpu_data.desc.waysize - 1;	\
-	unsigned long start = INDEX_BASE + (page & indexmask);		\
-	unsigned long end = start + PAGE_SIZE;				\
-	unsigned long ws_inc = 1UL << current_cpu_data.desc.waybit;	\
-	unsigned long ws_end = current_cpu_data.desc.ways <<		\
-			       current_cpu_data.desc.waybit;		\
-	unsigned long ws, addr;						\
+	unsigned long indexmask, end, start, ws_inc, ws_end, ws, addr;	\
 									\
 	__##pfx##flush_prologue						\
+	preempt_disable();						\
+									\
+	indexmask = current_cpu_data.desc.waysize - 1;			\
+	start = INDEX_BASE + (page & indexmask);			\
+	end = start + PAGE_SIZE;					\
+	ws_inc = 1UL << current_cpu_data.desc.waybit;			\
+	ws_end = current_cpu_data.desc.ways <<				\
+		 current_cpu_data.desc.waybit;				\
 									\
 	for (ws = 0; ws < ws_end; ws += ws_inc)				\
 		for (addr = start; addr < end; addr += lsize * 32)	\
 			cache##lsize##_unroll32(addr|ws, indexop);	\
 									\
+	preempt_enable();						\
 	__##pfx##flush_epilogue						\
 }
 
-- 
1.8.3.2
