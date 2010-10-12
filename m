Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Oct 2010 13:37:11 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:61828 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491012Ab0JLLf1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Oct 2010 13:35:27 +0200
Received: by pzk30 with SMTP id 30so1428050pzk.36
        for <multiple recipients>; Tue, 12 Oct 2010 04:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=0PjoXg1Ma/JXFeJj4c58onyL/wwS7msEfNPrDVu3y7E=;
        b=vQVOm+ZK01fzLnyBQb/qId0emmVfpcdE6g+VUeX8pr4kLC9z0brtTgeKGVX6cC78wU
         RLa1Pw9K9ijX1YkxfmrV5FDxCMyD2ZeTIEd8kXQ2JVbb0FjCcOFpMPKM4EoyS9zbV0xb
         Ln0ENfLXk+e3xgMNMABEpMiZ1jfCYrkQgbMIY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Q2a70n+Lk4DP98HCchVHq9T7EYhkJ+1mzdL00p4URIlM+JBextcsnWNRlhbzJzGMID
         +K3dRxJwRqCUh9l27Cl93CcZgdwol/nKvIfasz7WVmDUhMGdeDJkwwPpLmwO8fK+khN4
         zm0+toNJ7J/ic3RP8qwswtU4YSKWXHhseV+gU=
Received: by 10.114.136.19 with SMTP id j19mr8378040wad.170.1286883314055;
        Tue, 12 Oct 2010 04:35:14 -0700 (PDT)
Received: from localhost.localdomain ([210.13.118.102])
        by mx.google.com with ESMTPS id p6sm10434885wal.19.2010.10.12.04.35.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 12 Oct 2010 04:35:12 -0700 (PDT)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com,
        ddaney@caviumnetworks.com, matt@console-pimps.org,
        dengcheng.zhu@gmail.com
Subject: [PATCH v8 4/5] MIPS/Perf-events: add callchain support
Date:   Tue, 12 Oct 2010 19:37:23 +0800
Message-Id: <1286883444-31913-5-git-send-email-dengcheng.zhu@gmail.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1286883444-31913-1-git-send-email-dengcheng.zhu@gmail.com>
References: <1286883444-31913-1-git-send-email-dengcheng.zhu@gmail.com>
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28049
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

This patch adds callchain support for MIPS Perf-events. For more info on
this feature, please refer to tools/perf/Documentation/perf-report.txt
and tools/perf/design.txt.

Currently userspace callchain data is not recorded, because we do not have
a safe way to do this.

Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Acked-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/kernel/perf_event.c |  108 ++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 107 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/perf_event.c b/arch/mips/kernel/perf_event.c
index eefdf60..95c833e 100644
--- a/arch/mips/kernel/perf_event.c
+++ b/arch/mips/kernel/perf_event.c
@@ -6,7 +6,8 @@
  *
  * This code is based on the implementation for ARM, which is in turn
  * based on the sparc64 perf event code and the x86 code. Performance
- * counter access is based on the MIPS Oprofile code.
+ * counter access is based on the MIPS Oprofile code. And the callchain
+ * support references the code of MIPS stacktrace.c.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -486,3 +487,108 @@ handle_associated_event(struct cpu_hw_events *cpuc,
 	if (perf_event_overflow(event, 0, data, regs))
 		mipspmu->disable_event(idx);
 }
+
+/* Callchain handling code. */
+static inline void
+callchain_store(struct perf_callchain_entry *entry,
+		u64 ip)
+{
+	if (entry->nr < PERF_MAX_STACK_DEPTH)
+		entry->ip[entry->nr++] = ip;
+}
+
+/*
+ * Leave userspace callchain empty for now. When we find a way to trace
+ * the user stack callchains, we add here.
+ */
+static void
+perf_callchain_user(struct pt_regs *regs,
+		    struct perf_callchain_entry *entry)
+{
+}
+
+static void save_raw_perf_callchain(struct perf_callchain_entry *entry,
+	unsigned long reg29)
+{
+	unsigned long *sp = (unsigned long *)reg29;
+	unsigned long addr;
+
+	while (!kstack_end(sp)) {
+		addr = *sp++;
+		if (__kernel_text_address(addr)) {
+			callchain_store(entry, addr);
+			if (entry->nr >= PERF_MAX_STACK_DEPTH)
+				break;
+		}
+	}
+}
+
+static void
+perf_callchain_kernel(struct pt_regs *regs,
+		      struct perf_callchain_entry *entry)
+{
+	unsigned long sp = regs->regs[29];
+#ifdef CONFIG_KALLSYMS
+	unsigned long ra = regs->regs[31];
+	unsigned long pc = regs->cp0_epc;
+
+	callchain_store(entry, PERF_CONTEXT_KERNEL);
+	if (raw_show_trace || !__kernel_text_address(pc)) {
+		unsigned long stack_page =
+			(unsigned long)task_stack_page(current);
+		if (stack_page && sp >= stack_page &&
+		    sp <= stack_page + THREAD_SIZE - 32)
+			save_raw_perf_callchain(entry, sp);
+		return;
+	}
+	do {
+		callchain_store(entry, pc);
+		if (entry->nr >= PERF_MAX_STACK_DEPTH)
+			break;
+		pc = unwind_stack(current, &sp, pc, &ra);
+	} while (pc);
+#else
+	callchain_store(entry, PERF_CONTEXT_KERNEL);
+	save_raw_perf_callchain(entry, sp);
+#endif
+}
+
+static void
+perf_do_callchain(struct pt_regs *regs,
+		  struct perf_callchain_entry *entry)
+{
+	int is_user;
+
+	if (!regs)
+		return;
+
+	is_user = user_mode(regs);
+
+	if (!current || !current->pid)
+		return;
+
+	if (is_user && current->state != TASK_RUNNING)
+		return;
+
+	if (!is_user) {
+		perf_callchain_kernel(regs, entry);
+		if (current->mm)
+			regs = task_pt_regs(current);
+		else
+			regs = NULL;
+	}
+	if (regs)
+		perf_callchain_user(regs, entry);
+}
+
+static DEFINE_PER_CPU(struct perf_callchain_entry, pmc_irq_entry);
+
+struct perf_callchain_entry *
+perf_callchain(struct pt_regs *regs)
+{
+	struct perf_callchain_entry *entry = &__get_cpu_var(pmc_irq_entry);
+
+	entry->nr = 0;
+	perf_do_callchain(regs, entry);
+	return entry;
+}
-- 
1.7.0.4
