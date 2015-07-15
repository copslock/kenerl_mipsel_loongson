Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jul 2015 17:18:35 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:26946 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011195AbbGOPR5qOSjK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Jul 2015 17:17:57 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 7E13858F1A0A6;
        Wed, 15 Jul 2015 16:17:48 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 15 Jul 2015 16:17:50 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 15 Jul 2015 16:17:50 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>
Subject: [PATCH 2/6] MIPS: Refactor dumping of TLB registers for r3k/r4k
Date:   Wed, 15 Jul 2015 16:17:43 +0100
Message-ID: <1436973467-3877-3-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.3.6
In-Reply-To: <1436973467-3877-1-git-send-email-james.hogan@imgtec.com>
References: <1436973467-3877-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48309
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

The TLB registers are dumped in a couble of places:
 - sysrq_tlbdump_single() - when dumping TLB state.
 - do_mcheck() - in response to a machine check error.

The main TLB registers also differ between r3k and r4k, but r4k appears
to be assumed.

Refactor this code into a dump_tlb_regs() function, implemented for both
r3k and r4k, and used by both of the above functions.

Fixes: d1e9a4f54735 ("MIPS: Add SysRq operation to dump TLBs on all CPUs")
Suggested-by: Maciej W. Rozycki <macro@linux-mips.org>
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Maciej W. Rozycki <macro@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/tlbdebug.h |  1 +
 arch/mips/kernel/sysrq.c         | 14 +-------------
 arch/mips/kernel/traps.c         | 16 ++--------------
 arch/mips/lib/dump_tlb.c         | 18 ++++++++++++++++++
 arch/mips/lib/r3k_dump_tlb.c     | 11 +++++++++++
 arch/mips/mm/tlb-r3k.c           |  2 +-
 6 files changed, 34 insertions(+), 28 deletions(-)

diff --git a/arch/mips/include/asm/tlbdebug.h b/arch/mips/include/asm/tlbdebug.h
index bb8f5c29c3d9..3a25a8780ac7 100644
--- a/arch/mips/include/asm/tlbdebug.h
+++ b/arch/mips/include/asm/tlbdebug.h
@@ -11,6 +11,7 @@
 /*
  * TLB debugging functions:
  */
+extern void dump_tlb_regs(void);
 extern void dump_tlb_all(void);
 
 #endif /* __ASM_TLBDEBUG_H */
diff --git a/arch/mips/kernel/sysrq.c b/arch/mips/kernel/sysrq.c
index 5b539f5fc9d9..5f055393092d 100644
--- a/arch/mips/kernel/sysrq.c
+++ b/arch/mips/kernel/sysrq.c
@@ -21,24 +21,12 @@ static DEFINE_SPINLOCK(show_lock);
 
 static void sysrq_tlbdump_single(void *dummy)
 {
-	const int field = 2 * sizeof(unsigned long);
 	unsigned long flags;
 
 	spin_lock_irqsave(&show_lock, flags);
 
 	pr_info("CPU%d:\n", smp_processor_id());
-	pr_info("Index	: %0x\n", read_c0_index());
-	pr_info("Pagemask: %0x\n", read_c0_pagemask());
-	pr_info("EntryHi : %0*lx\n", field, read_c0_entryhi());
-	pr_info("EntryLo0: %0*lx\n", field, read_c0_entrylo0());
-	pr_info("EntryLo1: %0*lx\n", field, read_c0_entrylo1());
-	pr_info("Wired   : %0x\n", read_c0_wired());
-	pr_info("Pagegrain: %0x\n", read_c0_pagegrain());
-	if (cpu_has_htw) {
-		pr_info("PWField : %0*lx\n", field, read_c0_pwfield());
-		pr_info("PWSize  : %0*lx\n", field, read_c0_pwsize());
-		pr_info("PWCtl   : %0x\n", read_c0_pwctl());
-	}
+	dump_tlb_regs();
 	pr_info("\n");
 	dump_tlb_all();
 	pr_info("\n");
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index e207a43b5f8f..3e8b7cd17fb6 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1516,7 +1516,6 @@ asmlinkage void do_watch(struct pt_regs *regs)
 
 asmlinkage void do_mcheck(struct pt_regs *regs)
 {
-	const int field = 2 * sizeof(unsigned long);
 	int multi_match = regs->cp0_status & ST0_TS;
 	enum ctx_state prev_state;
 
@@ -1524,19 +1523,8 @@ asmlinkage void do_mcheck(struct pt_regs *regs)
 	show_regs(regs);
 
 	if (multi_match) {
-		pr_err("Index	: %0x\n", read_c0_index());
-		pr_err("Pagemask: %0x\n", read_c0_pagemask());
-		pr_err("EntryHi : %0*lx\n", field, read_c0_entryhi());
-		pr_err("EntryLo0: %0*lx\n", field, read_c0_entrylo0());
-		pr_err("EntryLo1: %0*lx\n", field, read_c0_entrylo1());
-		pr_err("Wired   : %0x\n", read_c0_wired());
-		pr_err("Pagegrain: %0x\n", read_c0_pagegrain());
-		if (cpu_has_htw) {
-			pr_err("PWField : %0*lx\n", field, read_c0_pwfield());
-			pr_err("PWSize  : %0*lx\n", field, read_c0_pwsize());
-			pr_err("PWCtl   : %0x\n", read_c0_pwctl());
-		}
-		pr_err("\n");
+		dump_tlb_regs();
+		pr_info("\n");
 		dump_tlb_all();
 	}
 
diff --git a/arch/mips/lib/dump_tlb.c b/arch/mips/lib/dump_tlb.c
index 167f35634709..519ededbf9a4 100644
--- a/arch/mips/lib/dump_tlb.c
+++ b/arch/mips/lib/dump_tlb.c
@@ -13,6 +13,24 @@
 #include <asm/pgtable.h>
 #include <asm/tlbdebug.h>
 
+void dump_tlb_regs(void)
+{
+	const int field = 2 * sizeof(unsigned long);
+
+	pr_info("Index    : %0x\n", read_c0_index());
+	pr_info("PageMask : %0x\n", read_c0_pagemask());
+	pr_info("EntryHi  : %0*lx\n", field, read_c0_entryhi());
+	pr_info("EntryLo0 : %0*lx\n", field, read_c0_entrylo0());
+	pr_info("EntryLo1 : %0*lx\n", field, read_c0_entrylo1());
+	pr_info("Wired    : %0x\n", read_c0_wired());
+	pr_info("PageGrain: %0x\n", read_c0_pagegrain());
+	if (cpu_has_htw) {
+		pr_info("PWField  : %0*lx\n", field, read_c0_pwfield());
+		pr_info("PWSize   : %0*lx\n", field, read_c0_pwsize());
+		pr_info("PWCtl    : %0x\n", read_c0_pwctl());
+	}
+}
+
 static inline const char *msk2str(unsigned int mask)
 {
 	switch (mask) {
diff --git a/arch/mips/lib/r3k_dump_tlb.c b/arch/mips/lib/r3k_dump_tlb.c
index 8e0d3cff8ae4..cfcbb5218b59 100644
--- a/arch/mips/lib/r3k_dump_tlb.c
+++ b/arch/mips/lib/r3k_dump_tlb.c
@@ -14,6 +14,17 @@
 #include <asm/pgtable.h>
 #include <asm/tlbdebug.h>
 
+extern int r3k_have_wired_reg;
+
+void dump_tlb_regs(void)
+{
+	pr_info("Index    : %0x\n", read_c0_index());
+	pr_info("EntryHi  : %0lx\n", read_c0_entryhi());
+	pr_info("EntryLo  : %0lx\n", read_c0_entrylo0());
+	if (r3k_have_wired_reg)
+		pr_info("Wired    : %0x\n", read_c0_wired());
+}
+
 static void dump_tlb(int first, int last)
 {
 	int	i;
diff --git a/arch/mips/mm/tlb-r3k.c b/arch/mips/mm/tlb-r3k.c
index 2b75b8f880ed..b4f366f7c0f5 100644
--- a/arch/mips/mm/tlb-r3k.c
+++ b/arch/mips/mm/tlb-r3k.c
@@ -36,7 +36,7 @@ extern void build_tlb_refill_handler(void);
 		"nop\n\t"		\
 		".set	pop\n\t")
 
-static int r3k_have_wired_reg;			/* Should be in cpu_data? */
+int r3k_have_wired_reg;			/* Should be in cpu_data? */
 
 /* TLB operations. */
 static void local_flush_tlb_from(int entry)
-- 
2.3.6
