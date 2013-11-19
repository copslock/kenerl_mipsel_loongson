Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Nov 2013 18:33:02 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:2613 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817266Ab3KSRcRpU2EL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 19 Nov 2013 18:32:17 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 4/6] mips: clean up resume declaration
Date:   Tue, 19 Nov 2013 17:30:37 +0000
Message-ID: <1384882239-17965-5-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1384882239-17965-1-git-send-email-paul.burton@imgtec.com>
References: <1384882239-17965-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.152.22]
X-SEF-Processed: 7_3_0_01192__2013_11_19_17_32_12
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38552
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

This patch cleans up the declaration of the resume function by replacing
void pointers with their correct types. The irrelevant & incorrect
comment preceeding the resume function is replaced by one documenting
its function.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Reviewed-by: Qais Yousef <qais.yousef@imgtec.com>
---
 arch/mips/include/asm/switch_to.h | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/switch_to.h b/arch/mips/include/asm/switch_to.h
index eb0af15..278d45a 100644
--- a/arch/mips/include/asm/switch_to.h
+++ b/arch/mips/include/asm/switch_to.h
@@ -19,11 +19,19 @@
 
 struct task_struct;
 
-/*
- * switch_to(n) should switch tasks to task nr n, first
- * checking that n isn't the current task, in which case it does nothing.
+/**
+ * resume - resume execution of a task
+ * @prev:	The task previously executed.
+ * @next:	The task to begin executing.
+ * @next_ti:	task_thread_info(next).
+ * @usedfpu:	Non-zero if prev's FP context should be saved.
+ *
+ * This function is used whilst scheduling to save the context of prev & load
+ * the context of next. Returns prev.
  */
-extern asmlinkage void *resume(void *last, void *next, void *next_ti, u32 __usedfpu);
+extern asmlinkage struct task_struct *resume(struct task_struct *prev,
+		struct task_struct *next, struct thread_info *next_ti,
+		u32 usedfpu);
 
 extern unsigned int ll_bit;
 extern struct task_struct *ll_task;
-- 
1.8.4.2
