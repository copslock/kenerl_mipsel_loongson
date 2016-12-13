Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Dec 2016 11:41:13 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:53917 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992183AbcLMKlGOJYTS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Dec 2016 11:41:06 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 230FDBF28A155;
        Tue, 13 Dec 2016 10:40:58 +0000 (GMT)
Received: from WR-NOWAKOWSKI.kl.imgtec.org (10.80.2.5) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 13 Dec 2016 10:40:59 +0000
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-mips@linux-mips.org>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Victor Kamensky <victor.kamensky@linaro.org>
Subject: [PATCH] uprobes: allow for a cache flush after ixol breakpoint creation
Date:   Tue, 13 Dec 2016 11:40:57 +0100
Message-ID: <1481625657-22850-1-git-send-email-marcin.nowakowski@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56024
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcin.nowakowski@imgtec.com
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

Commit 72e6ae285a1d ('ARM: 8043/1: uprobes need icache flush after xol
write' has introduced an arch-specific method to ensure all caches are
flushed appropriately after an instruction is written to an XOL page.

However, when the XOL area is created and the out-of-line breakpoint
instruction is copied, caches are not flushed at all and stale data may
be found in icache.

Replace a simple copy_to_page() with arch_uprobe_copy_ixol() to allow
the arch to ensure all caches are updated accordingly.

This change fixes uprobes on MIPS InterAptiv (tested on Creator Ci40).

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Ingo Molnar <mingo@redhat.com>
CC: Arnaldo Carvalho de Melo <acme@kernel.org>
CC: Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC: Victor Kamensky <victor.kamensky@linaro.org>

---
 kernel/events/uprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index f9ec9ad..b5916b4 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1194,7 +1194,7 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
 	/* Reserve the 1st slot for get_trampoline_vaddr() */
 	set_bit(0, area->bitmap);
 	atomic_set(&area->slot_count, 1);
-	copy_to_page(area->pages[0], 0, &insn, UPROBE_SWBP_INSN_SIZE);
+	arch_uprobe_copy_ixol(area->pages[0], 0, &insn, UPROBE_SWBP_INSN_SIZE);
 
 	if (!xol_add_vma(mm, area))
 		return area;
-- 
2.7.4
