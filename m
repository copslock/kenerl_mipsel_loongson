Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Sep 2014 14:34:56 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36459 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008729AbaIKMeS5gotW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Sep 2014 14:34:18 +0200
Received: from deadeye.wl.decadent.org.uk ([192.168.4.249] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <ben@decadent.org.uk>)
        id 1XS3ZZ-0006K0-W0; Thu, 11 Sep 2014 13:34:02 +0100
Received: from ben by deadeye with local (Exim 4.84)
        (envelope-from <ben@decadent.org.uk>)
        id 1XS3ZT-0004Kq-33; Thu, 11 Sep 2014 13:33:55 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Markos Chandras" <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, "Ralf Baechle" <ralf@linux-mips.org>
Date:   Thu, 11 Sep 2014 13:32:13 +0100
Message-ID: <lsq.1410438733.135526433@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 097/131] MIPS: Fix accessing to per-cpu data when
 flushing the cache
In-Reply-To: <lsq.1410438733.176537304@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.249
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42517
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.2.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Ralf Baechle <ralf@linux-mips.org>

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/mm/c-r4k.c | 5 +++++
 1 file changed, 5 insertions(+)

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
@@ -599,6 +600,7 @@ static void r4k_dma_cache_wback_inv(unsi
 	/* Catch bad driver code */
 	BUG_ON(size == 0);
 
+	preempt_disable();
 	if (cpu_has_inclusive_pcaches) {
 		if (size >= scache_size)
 			r4k_blast_scache();
@@ -619,6 +621,7 @@ static void r4k_dma_cache_wback_inv(unsi
 		R4600_HIT_CACHEOP_WAR_IMPL;
 		blast_dcache_range(addr, addr + size);
 	}
+	preempt_enable();
 
 	bc_wback_inv(addr, size);
 	__sync();
@@ -629,6 +632,7 @@ static void r4k_dma_cache_inv(unsigned l
 	/* Catch bad driver code */
 	BUG_ON(size == 0);
 
+	preempt_disable();
 	if (cpu_has_inclusive_pcaches) {
 		if (size >= scache_size)
 			r4k_blast_scache();
@@ -653,6 +657,7 @@ static void r4k_dma_cache_inv(unsigned l
 		R4600_HIT_CACHEOP_WAR_IMPL;
 		blast_inv_dcache_range(addr, addr + size);
 	}
+	preempt_enable();
 
 	bc_inv(addr, size);
 	__sync();
