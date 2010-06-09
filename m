Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Jun 2010 06:36:40 +0200 (CEST)
Received: from mail-pv0-f177.google.com ([74.125.83.177]:36773 "EHLO
        mail-pv0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491058Ab0FIEf1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Jun 2010 06:35:27 +0200
Received: by mail-pv0-f177.google.com with SMTP id 11so2082996pvg.36
        for <multiple recipients>; Tue, 08 Jun 2010 21:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ZGUdCdbcDhL8lWfrGTthcGDpMawbAGT8zB1t4+R/JPI=;
        b=kpHR5NfK83Ydyo83ZCBO/uSvhxUal/3QeJA0+85ZjylZ6OYeYlWlnhdltCz2CK2UJk
         izqbQT6shu1X3XzX5JND6MNbHVly34EuCu74sMB/kDCg72h1WV/5Y3AWapJU8XUdler5
         62LYDW05atG0X/mXW9zAXH7aHSp8z4ljfMrSQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=SalCyj5uVp9azCAXPT58QZqfAtCUhYYhbEdVGChDnCg5fBGNUmTPxBiyljPY1aAe5p
         vrBrDeFznzsoWMLnZdxP+5DGZkLT9FrS86F3ZgiWKHWEXQ3by0PycoJnqa3MAUtwfK/o
         4kItC0zty+1m2Rrc7MUU9488QMKnj89TtiHVY=
Received: by 10.143.20.39 with SMTP id x39mr5724597wfi.236.1276058126767;
        Tue, 08 Jun 2010 21:35:26 -0700 (PDT)
Received: from localhost.localdomain ([210.13.118.102])
        by mx.google.com with ESMTPS id 22sm4483464pzk.9.2010.06.08.21.35.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 08 Jun 2010 21:35:26 -0700 (PDT)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com,
        Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Subject: [PATCH v6 5/7] MIPS/Perf-events: add callchain support
Date:   Wed,  9 Jun 2010 12:35:28 +0800
Message-Id: <1276058130-25851-6-git-send-email-dengcheng.zhu@gmail.com>
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1276058130-25851-1-git-send-email-dengcheng.zhu@gmail.com>
References: <1276058130-25851-1-git-send-email-dengcheng.zhu@gmail.com>
X-archive-position: 27095
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 6106

This patch adds callchain support for MIPS Perf-events. For more info on
this feature, please refer to tools/perf/Documentation/perf-report.txt
and tools/perf/design.txt.

Currently userspace callchain data is not recorded, because we do not have
a safe way to do this.

Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
---
 arch/mips/kernel/perf_event.c |  108 ++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 107 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/perf_event.c b/arch/mips/kernel/perf_event.c
index 51e31e2..7e371ae 100644
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
@@ -508,3 +509,108 @@ handle_associated_event(struct cpu_hw_events *cpuc,
 		mipspmu->disable_event(idx);
 }
 
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
+
-- 
1.6.3.3
