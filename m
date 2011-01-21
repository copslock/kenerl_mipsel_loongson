Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Jan 2011 09:21:37 +0100 (CET)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:57964 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491803Ab1AUIUJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Jan 2011 09:20:09 +0100
Received: by mail-iy0-f177.google.com with SMTP id 21so1442488iyj.36
        for <multiple recipients>; Fri, 21 Jan 2011 00:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=4zOodzoyImQPCDZ6HgLsDYUAGQDisT3h5wpkcak6rYs=;
        b=xkbboMUf87TRZnlkxOdUehksB94iw3A1nnM3vYCuy30P9aWR1drf/1aYLqbsLva5EA
         WfhjaXF14VHSbRvaUykypc5KkR50bKWZePm1/9klgYNaPBdQ4Rk8b4N752woym3v4w9F
         MK0fb1g/yB5aMIlpj78LYjmyL+o2eUTOvQWGA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=CakSayb/2ZqE8gK0igpFcHNF10kzdyrOTTdsbhEhhNK7C6kjyD78jRYsJfGrHDE6u3
         MsLVtO2RmQzv/pvrnalmwk+tdclg92YIcJO0ugIMNDnGw5CqwwLwqnUrOYpymMk80jxG
         pwv0JJpfCDTpiQ4Mp+GzfAytnz8lVjjJFgKjw=
Received: by 10.42.174.138 with SMTP id v10mr382668icz.91.1295598008245;
        Fri, 21 Jan 2011 00:20:08 -0800 (PST)
Received: from localhost.localdomain ([210.13.118.102])
        by mx.google.com with ESMTPS id he5sm6836460icb.22.2011.01.21.00.20.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 21 Jan 2011 00:20:07 -0800 (PST)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     ralf@linux-mips.org, a.p.zijlstra@chello.nl, fweisbec@gmail.com,
        will.deacon@arm.com
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        wuzhangjin@gmail.com, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, dengcheng.zhu@gmail.com, matt@console-pimps.org,
        sshtylyov@mvista.com, ddaney@caviumnetworks.com
Subject: [PATCH v4 4/5] MIPS/Perf-events: Work with the new callchain interface
Date:   Fri, 21 Jan 2011 16:19:20 +0800
Message-Id: <1295597961-7565-5-git-send-email-dengcheng.zhu@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1295597961-7565-1-git-send-email-dengcheng.zhu@gmail.com>
References: <1295597961-7565-1-git-send-email-dengcheng.zhu@gmail.com>
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29003
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

This is the MIPS part of the following commits by Frederic Weisbecker:

- f72c1a931e311bb7780fee19e41a89ac42cab50e
    perf: Factorize callchain context handling

    Store the kernel and user contexts from the generic layer instead
    of archs, this gathers some repetitive code.

- 56962b4449af34070bb1994621ef4f0265eed4d8
    perf: Generalize some arch callchain code

    - Most archs use one callchain buffer per cpu, except x86 that needs
      to deal with NMIs. Provide a default perf_callchain_buffer()
      implementation that x86 overrides.

    - Centralize all the kernel/user regs handling and invoke new arch
      handlers from there: perf_callchain_user() / perf_callchain_kernel()
      That avoid all the user_mode(), current->mm checks and so...

    - Invert some parameters in perf_callchain_*() helpers: entry to the
      left, regs to the right, following the traditional (dst, src).

- 70791ce9ba68a5921c9905ef05d23f62a90bc10c
    perf: Generalize callchain_store()

    callchain_store() is the same on every archs, inline it in
    perf_event.h and rename it to perf_callchain_store() to avoid
    any collision.

    This removes repetitive code.

- c1a65932fd7216fdc9a0db8bbffe1d47842f862c
    perf: Drop unappropriate tests on arch callchains

    Drop the TASK_RUNNING test on user tasks for callchains as
    this check doesn't seem to make any sense.

    Also remove the tests for !current that is not supposed to
    happen and current->pid as this should be handled at the
    generic level, with exclude_idle attribute.

Changes:
v4 - v3:
o None
v3 - v2:
o Keep all mentioned commits in the form of number + title + original
summary + (MIPS specific info when needed).
v2 - v1:
o None

Reported-by: Wu Zhangjin <wuzhangjin@gmail.com>
Acked-by: Frederic Weisbecker <fweisbec@gmail.com>
Acked-by: David Daney <ddaney@caviumnetworks.com>
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
