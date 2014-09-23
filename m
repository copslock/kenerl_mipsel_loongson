Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Sep 2014 04:41:11 +0200 (CEST)
Received: from mail.kernel.org ([198.145.19.201]:32985 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008114AbaIWCksqABAq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 23 Sep 2014 04:40:48 +0200
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id ABBC12015E;
        Tue, 23 Sep 2014 02:40:41 +0000 (UTC)
Received: from localhost.localdomain (unknown [183.247.163.231])
        (using TLSv1.1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E66772018E;
        Tue, 23 Sep 2014 02:40:38 +0000 (UTC)
From:   Zefan Li <lizf@kernel.org>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, Zefan Li <lizefan@huawei.com>
Subject: [PATCH 3.4 36/45] MIPS: Fix accessing to per-cpu data when flushing the cache
Date:   Tue, 23 Sep 2014 10:31:38 +0800
Message-Id: <1411439507-30391-36-git-send-email-lizf@kernel.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1411439259-30224-1-git-send-email-lizf@kernel.org>
References: <1411439259-30224-1-git-send-email-lizf@kernel.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <lizf@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42737
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lizf@kernel.org
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

From: Ralf Baechle <ralf@linux-mips.org>

3.4.104-rc1 review patch.  If anyone has any objections, please let me know.

------------------

commit ff522058bd717506b2fa066fa564657f2b86477e upstream.

This fixes the following issue

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

Caches in most systems are identical - but not always, so we can't avoid
the use of smp_call_function() by just looking at the boot CPU's data,
have to fiddle with preemption instead.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Cc: Markos Chandras <markos.chandras@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/5835
Signed-off-by: Zefan Li <lizefan@huawei.com>
---
 arch/mips/mm/c-r4k.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index bda8eb2..fdd6042 100644
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
@@ -598,6 +599,7 @@ static void r4k_dma_cache_wback_inv(unsigned long addr, unsigned long size)
 	/* Catch bad driver code */
 	BUG_ON(size == 0);
 
+	preempt_disable();
 	if (cpu_has_inclusive_pcaches) {
 		if (size >= scache_size)
 			r4k_blast_scache();
@@ -618,6 +620,7 @@ static void r4k_dma_cache_wback_inv(unsigned long addr, unsigned long size)
 		R4600_HIT_CACHEOP_WAR_IMPL;
 		blast_dcache_range(addr, addr + size);
 	}
+	preempt_enable();
 
 	bc_wback_inv(addr, size);
 	__sync();
@@ -628,6 +631,7 @@ static void r4k_dma_cache_inv(unsigned long addr, unsigned long size)
 	/* Catch bad driver code */
 	BUG_ON(size == 0);
 
+	preempt_disable();
 	if (cpu_has_inclusive_pcaches) {
 		if (size >= scache_size)
 			r4k_blast_scache();
@@ -663,6 +667,7 @@ static void r4k_dma_cache_inv(unsigned long addr, unsigned long size)
 		cache_op(Hit_Writeback_Inv_D, (addr + size - 1)  & almask);
 		blast_inv_dcache_range(addr, addr + size);
 	}
+	preempt_enable();
 
 	bc_inv(addr, size);
 	__sync();
-- 
1.7.9.5
