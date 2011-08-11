Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Aug 2011 02:37:20 +0200 (CEST)
Received: from gandharva.secretlabs.de ([78.46.147.237]:14397 "EHLO
        gandharva.secretlabs.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491864Ab1HKAgl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Aug 2011 02:36:41 +0200
Received: from localhost.localdomain (unknown [1.202.86.226])
        by gandharva.secretlabs.de (Postfix) with ESMTPSA id CA8B91B10C17;
        Thu, 11 Aug 2011 00:47:38 +0000 (UTC)
From:   Holger Hans Peter Freyther <zecke@selfish.org>
To:     linux-mips@linux-mips.org
Cc:     Holger Hans Peter Freyther <zecke@selfish.org>,
        Holger Freyther <holger@moiji-mobile.com>
Subject: [PATCH 2/2] MIPS: Implement perf_callchain_user using unwind_user_frame
Date:   Thu, 11 Aug 2011 02:36:06 +0200
Message-Id: <1313022966-28152-3-git-send-email-zecke@selfish.org>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1313022966-28152-1-git-send-email-zecke@selfish.org>
References: <1313022966-28152-1-git-send-email-zecke@selfish.org>
X-archive-position: 30850
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zecke@selfish.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 8021

Implement perf_callchain_user using the unwind_user_frame
method, allow up to PAGE_SIZE / 4 instructions to be checked.

Signed-off-by: Holger Freyther <holger@moiji-mobile.com>
---
 arch/mips/kernel/perf_event.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/perf_event.c b/arch/mips/kernel/perf_event.c
index 0aee944..7ea4d3c 100644
--- a/arch/mips/kernel/perf_event.c
+++ b/arch/mips/kernel/perf_event.c
@@ -540,6 +540,20 @@ handle_associated_event(struct cpu_hw_events *cpuc,
 void perf_callchain_user(struct perf_callchain_entry *entry,
 		    struct pt_regs *regs)
 {
+	struct user_stackframe frame = { .sp = regs->regs[29],
+				    .pc = regs->cp0_epc,
+				    .ra = regs->regs[31] };
+	const unsigned long low_addr = ALIGN(frame.sp, THREAD_SIZE);
+	const unsigned int max_instr_check = PAGE_SIZE / 4;
+	const unsigned long high_addr = low_addr + THREAD_SIZE;
+
+
+	while (entry->nr < PERF_MAX_STACK_DEPTH &&
+			!unwind_user_frame(&frame, max_instr_check)) {
+		perf_callchain_store(entry, frame.ra);
+		if (frame.sp < low_addr || frame.sp > high_addr)
+			break;
+	}
 }
 
 static void save_raw_perf_callchain(struct perf_callchain_entry *entry,
-- 
1.7.4.1
