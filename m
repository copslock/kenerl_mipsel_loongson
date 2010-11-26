Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Nov 2010 04:06:22 +0100 (CET)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:51858 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492143Ab0KZDET (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Nov 2010 04:04:19 +0100
Received: by yxm34 with SMTP id 34so788183yxm.36
        for <multiple recipients>; Thu, 25 Nov 2010 19:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=HEop/i91j5ZPtb3ir4v6pAPbTBWkSSE2V7ugFibL6Ug=;
        b=RpVAVpb9rimV3HwERfN5wLQEtvy64677rpwLeWpCZ4leh3skxkOintwPOpOCOFGxRc
         3ep5UfoZjenDJR5Lp4tZhMuIJnQf2GSu2prvNRMpqZCNN3sCvugnDZodplgRGJGAfc7u
         te97k+zgZWzLwNOdsGQezXAEvaQCDRygVnDcY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=OFvuhl1TVulokkZsDTEa7EE6k1aUqHQ6zNZ940NXbE+fpZ7nrqVvUsUCmJwICj9Jd8
         l6+Ol5U5LgcKiF8h42uz970s97k3zBwcU60DP8uTAqV8gocFt7E9PJP5O3TwnziWr5L8
         8dUuO6yeeLjZ2D8GAmqaypj2ZSTDUn0IeBOpw=
Received: by 10.90.4.26 with SMTP id 26mr3692286agd.84.1290740652577;
        Thu, 25 Nov 2010 19:04:12 -0800 (PST)
Received: from localhost.localdomain ([210.13.118.102])
        by mx.google.com with ESMTPS id 43sm933046yhl.37.2010.11.25.19.04.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Nov 2010 19:04:11 -0800 (PST)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     ralf@linux-mips.org, a.p.zijlstra@chello.nl, fweisbec@gmail.com,
        will.deacon@arm.com
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        wuzhangjin@gmail.com, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, dengcheng.zhu@gmail.com
Subject: [PATCH v2 4/5] MIPS/Perf-events: Work with the new callchain interface
Date:   Fri, 26 Nov 2010 11:05:06 +0800
Message-Id: <1290740707-32586-5-git-send-email-dengcheng.zhu@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1290740707-32586-1-git-send-email-dengcheng.zhu@gmail.com>
References: <1290740707-32586-1-git-send-email-dengcheng.zhu@gmail.com>
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28535
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

This is the MIPS part of the following commits by Frederic Weisbecker:

f72c1a931e311bb7780fee19e41a89ac42cab50e
        perf: Factorize callchain context handling
56962b4449af34070bb1994621ef4f0265eed4d8
        perf: Generalize some arch callchain code
70791ce9ba68a5921c9905ef05d23f62a90bc10c
        perf: Generalize callchain_store()
c1a65932fd7216fdc9a0db8bbffe1d47842f862c
        perf: Drop unappropriate tests on arch callchains

Reported-by: Wu Zhangjin <wuzhangjin@gmail.com>
Acked-by: Frederic Weisbecker <fweisbec@gmail.com>
Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
---
 arch/mips/kernel/perf_event.c |   63 ++++-------------------------------------
 1 files changed, 6 insertions(+), 57 deletions(-)

diff --git a/arch/mips/kernel/perf_event.c b/arch/mips/kernel/perf_event.c
index 3d55761..8f7d2f8 100644
--- a/arch/mips/kernel/perf_event.c
+++ b/arch/mips/kernel/perf_event.c
@@ -534,21 +534,13 @@ handle_associated_event(struct cpu_hw_events *cpuc,
 #include "perf_event_mipsxx.c"
 
 /* Callchain handling code. */
-static inline void
-callchain_store(struct perf_callchain_entry *entry,
-		u64 ip)
-{
-	if (entry->nr < PERF_MAX_STACK_DEPTH)
-		entry->ip[entry->nr++] = ip;
-}
 
 /*
  * Leave userspace callchain empty for now. When we find a way to trace
  * the user stack callchains, we add here.
  */
-static void
-perf_callchain_user(struct pt_regs *regs,
-		    struct perf_callchain_entry *entry)
+void perf_callchain_user(struct perf_callchain_entry *entry,
+		    struct pt_regs *regs)
 {
 }
 
@@ -561,23 +553,21 @@ static void save_raw_perf_callchain(struct perf_callchain_entry *entry,
 	while (!kstack_end(sp)) {
 		addr = *sp++;
 		if (__kernel_text_address(addr)) {
-			callchain_store(entry, addr);
+			perf_callchain_store(entry, addr);
 			if (entry->nr >= PERF_MAX_STACK_DEPTH)
 				break;
 		}
 	}
 }
 
-static void
-perf_callchain_kernel(struct pt_regs *regs,
-		      struct perf_callchain_entry *entry)
+void perf_callchain_kernel(struct perf_callchain_entry *entry,
+		      struct pt_regs *regs)
 {
 	unsigned long sp = regs->regs[29];
 #ifdef CONFIG_KALLSYMS
 	unsigned long ra = regs->regs[31];
 	unsigned long pc = regs->cp0_epc;
 
-	callchain_store(entry, PERF_CONTEXT_KERNEL);
 	if (raw_show_trace || !__kernel_text_address(pc)) {
 		unsigned long stack_page =
 			(unsigned long)task_stack_page(current);
@@ -587,53 +577,12 @@ perf_callchain_kernel(struct pt_regs *regs,
 		return;
 	}
 	do {
-		callchain_store(entry, pc);
+		perf_callchain_store(entry, pc);
 		if (entry->nr >= PERF_MAX_STACK_DEPTH)
 			break;
 		pc = unwind_stack(current, &sp, pc, &ra);
 	} while (pc);
 #else
-	callchain_store(entry, PERF_CONTEXT_KERNEL);
 	save_raw_perf_callchain(entry, sp);
 #endif
 }
-
-static void
-perf_do_callchain(struct pt_regs *regs,
-		  struct perf_callchain_entry *entry)
-{
-	int is_user;
-
-	if (!regs)
-		return;
-
-	is_user = user_mode(regs);
-
-	if (!current || !current->pid)
-		return;
-
-	if (is_user && current->state != TASK_RUNNING)
-		return;
-
-	if (!is_user) {
-		perf_callchain_kernel(regs, entry);
-		if (current->mm)
-			regs = task_pt_regs(current);
-		else
-			regs = NULL;
-	}
-	if (regs)
-		perf_callchain_user(regs, entry);
-}
-
-static DEFINE_PER_CPU(struct perf_callchain_entry, pmc_irq_entry);
-
-struct perf_callchain_entry *
-perf_callchain(struct pt_regs *regs)
-{
-	struct perf_callchain_entry *entry = &__get_cpu_var(pmc_irq_entry);
-
-	entry->nr = 0;
-	perf_do_callchain(regs, entry);
-	return entry;
-}
-- 
1.7.1
