Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 May 2010 15:06:37 +0200 (CEST)
Received: from mail-pz0-f173.google.com ([209.85.222.173]:51716 "EHLO
        mail-pz0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492364Ab0E0NE5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 27 May 2010 15:04:57 +0200
Received: by mail-pz0-f173.google.com with SMTP id 3so3858148pzk.26
        for <multiple recipients>; Thu, 27 May 2010 06:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=BJtgdzYnXBaqwMDD/NA/LnbS/UGjI9NEueIsqq9GRnw=;
        b=mRGHO0TdeLt2ZkZWpzL1mVwK/wKJNB+m3rWaLsNsPboVt9rzOg1gdlfZ44yB0K7+rH
         GjmvUyvbz3uQ9LTL6M9ZQmClOBlxHe+cBvDECE7Kn8z93n+mdvOee8e/2IE3gB80T/5s
         Ffg63SJIsq/uby2SM4VmCPOoTjN+4RVgC3P4Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ChV/iaE719LsPrBhB+PVl3GYiCqN0em8CI21cc3N/YL7l3EP+LjuIp/cGPW7APnlf7
         j+z3ymcb75e1KMPapg4ocF9rHoDpcxvGmc3CLX5MWl2FeUlJzkQz7S5IjoTZEYIX1Ssc
         uMBxiHx0EPwGCaE/TwyFssLXMzkHf+uaR2s5U=
Received: by 10.142.10.5 with SMTP id 5mr6508577wfj.267.1274965494437;
        Thu, 27 May 2010 06:04:54 -0700 (PDT)
Received: from localhost.localdomain ([114.84.70.124])
        by mx.google.com with ESMTPS id 21sm972927pzk.8.2010.05.27.06.04.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 27 May 2010 06:04:53 -0700 (PDT)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com, will.deacon@arm.com,
        Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Subject: [PATCH v5 05/12] MIPS/Perf-events: add callchain support
Date:   Thu, 27 May 2010 21:03:33 +0800
Message-Id: <1274965420-5091-6-git-send-email-dengcheng.zhu@gmail.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1274965420-5091-1-git-send-email-dengcheng.zhu@gmail.com>
References: <1274965420-5091-1-git-send-email-dengcheng.zhu@gmail.com>
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26874
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

This patch adds callchain support for MIPS Perf-events. For more info on
this feature, please refer to tools/perf/Documentation/perf-report.txt
and tools/perf/design.txt.

Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
---
 arch/mips/kernel/perf_event.c |   98 ++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 97 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/perf_event.c b/arch/mips/kernel/perf_event.c
index 788815f..63ea0e9 100644
--- a/arch/mips/kernel/perf_event.c
+++ b/arch/mips/kernel/perf_event.c
@@ -5,7 +5,8 @@
  *
  * This code is based on the implementation for ARM, which is in turn
  * based on the sparc64 perf event code and the x86 code. Performance
- * counter access is based on the MIPS Oprofile code.
+ * counter access is based on the MIPS Oprofile code. And the callchain
+ * support references the code of MIPS traps.c.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -501,3 +502,98 @@ handle_associated_event(struct cpu_hw_events *cpuc,
 		mipspmu->disable_event(idx);
 }
 
+/*
+ * Callchain handling code.
+ */
+static inline void
+callchain_store(struct perf_callchain_entry *entry,
+		u64 ip)
+{
+	if (entry->nr < PERF_MAX_STACK_DEPTH)
+		entry->ip[entry->nr++] = ip;
+}
+
+static void
+perf_callchain_user(struct pt_regs *regs,
+		    struct perf_callchain_entry *entry)
+{
+	unsigned long *sp;
+	unsigned long addr;
+
+	callchain_store(entry, PERF_CONTEXT_USER);
+
+	if (!user_mode(regs))
+		regs = task_pt_regs(current);
+
+	sp = (unsigned long *)(regs->regs[29] & ~3);
+
+	while (!kstack_end(sp)) {
+		unsigned long __user *p =
+			(unsigned long __user *)(unsigned long)sp++;
+		if (__get_user(addr, p)) {
+			pr_warning("Performance counter callchain "
+				"suppport: Bad stack address.\n");
+			break;
+		}
+		callchain_store(entry, addr);
+	}
+}
+
+static void
+perf_callchain_kernel(struct pt_regs *regs,
+		      struct perf_callchain_entry *entry)
+{
+	unsigned long sp = regs->regs[29];
+	unsigned long ra = regs->regs[31];
+	unsigned long pc = regs->cp0_epc;
+
+	if (unlikely(!__kernel_text_address(pc))) {
+		pr_warning("Performance counter callchain support "
+			"error.\n");
+		return;
+	}
+
+	callchain_store(entry, PERF_CONTEXT_KERNEL);
+
+	do {
+		callchain_store(entry, pc);
+		pc = unwind_stack(current, &sp, pc, &ra);
+	} while (pc);
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
+	if (!is_user)
+		perf_callchain_kernel(regs, entry);
+
+	if (current->mm)
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
