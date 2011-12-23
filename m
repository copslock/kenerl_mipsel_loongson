Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Dec 2011 12:18:00 +0100 (CET)
Received: from mail-gx0-f177.google.com ([209.85.161.177]:56502 "EHLO
        mail-gx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903609Ab1LWLRs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Dec 2011 12:17:48 +0100
Received: by ggnp4 with SMTP id p4so8403997ggn.36
        for <multiple recipients>; Fri, 23 Dec 2011 03:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=vUaEn5/471LkvG/wqPFqpTqwg+9NoFmAywjoIdE885M=;
        b=pY2dOhGntT2xtCJdJvj5Ukpgr7Uj3ID0Ny6hRPDhUKvVLghi0uXkp6XEabVKf8ZpmO
         P+mdiWTAi6Dt6P9DnzjZfKOYBIfsXS7JJ8+j15qOWdPpzpVuyNjxlNvSkwQNnE0P1JLA
         1NCOnHBi4i21jyPgyh7Rxi3mhHz0kbV9a3KkU=
Received: by 10.50.168.4 with SMTP id zs4mr13107792igb.28.1324639061909;
        Fri, 23 Dec 2011 03:17:41 -0800 (PST)
Received: from localhost.localdomain ([125.19.39.117])
        by mx.google.com with ESMTPS id lu10sm19330510igc.0.2011.12.23.03.17.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 23 Dec 2011 03:17:41 -0800 (PST)
From:   Kautuk Consul <consul.kautuk@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>, Ingo Molnar <mingo@elte.hu>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        "Mohd. Faris" <mohdfarisq2010@gmail.com>,
        Kautuk Consul <consul.kautuk@gmail.com>
Subject: [PATCH 1/1] mips: fault.c: Port OOM changes to do_page_fault
Date:   Fri, 23 Dec 2011 16:52:42 +0530
Message-Id: <1324639362-18220-1-git-send-email-consul.kautuk@gmail.com>
X-Mailer: git-send-email 1.7.6
X-archive-position: 32156
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: consul.kautuk@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 18762

From: Kautuk Consul <consul.kautuk@gmail.com>

Commit d065bd810b6deb67d4897a14bfe21f8eb526ba99
(mm: retry page fault when blocking on disk transfer) and
commit 37b23e0525d393d48a7d59f870b3bc061a30ccdb
(x86,mm: make pagefault killable)

The above commits introduced changes into the x86 pagefault handler
for making the page fault handler retryable as well as killable.

These changes reduce the mmap_sem hold time, which is crucial
during OOM killer invocation.

Port these changes to MIPS.

Without these changes, my MIPS board encounters many hang and livelock
scenarios.
After applying this patch, OOM feature performance improves according to
my testing.

Signed-off-by: Mohd. Faris <mohdfarisq2010@gmail.com>
Signed-off-by: Kautuk Consul <consul.kautuk@gmail.com>
---
 arch/mips/mm/fault.c |   36 +++++++++++++++++++++++++++++-------
 1 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
index 937cf33..aae2cb3 100644
--- a/arch/mips/mm/fault.c
+++ b/arch/mips/mm/fault.c
@@ -42,6 +42,8 @@ asmlinkage void __kprobes do_page_fault(struct pt_regs *regs, unsigned long writ
 	const int field = sizeof(unsigned long) * 2;
 	siginfo_t info;
 	int fault;
+	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE |
+						 (write ? FAULT_FLAG_WRITE : 0);
 
 #if 0
 	printk("Cpu%d[%s:%d:%0*lx:%ld:%0*lx]\n", raw_smp_processor_id(),
@@ -91,6 +93,7 @@ asmlinkage void __kprobes do_page_fault(struct pt_regs *regs, unsigned long writ
 	if (in_atomic() || !mm)
 		goto bad_area_nosemaphore;
 
+retry:
 	down_read(&mm->mmap_sem);
 	vma = find_vma(mm, address);
 	if (!vma)
@@ -144,7 +147,11 @@ good_area:
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	fault = handle_mm_fault(mm, vma, address, write ? FAULT_FLAG_WRITE : 0);
+	fault = handle_mm_fault(mm, vma, address, flags);
+
+	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
+		return;
+
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
@@ -153,12 +160,27 @@ good_area:
 			goto do_sigbus;
 		BUG();
 	}
-	if (fault & VM_FAULT_MAJOR) {
-		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1, regs, address);
-		tsk->maj_flt++;
-	} else {
-		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1, regs, address);
-		tsk->min_flt++;
+	if (flags & FAULT_FLAG_ALLOW_RETRY) {
+		if (fault & VM_FAULT_MAJOR) {
+			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1,
+						  regs, address);
+			tsk->maj_flt++;
+		} else {
+			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1,
+						  regs, address);
+			tsk->min_flt++;
+		}
+		if (fault & VM_FAULT_RETRY) {
+			flags &= ~FAULT_FLAG_ALLOW_RETRY;
+
+			/*
+			 * No need to up_read(&mm->mmap_sem) as we would
+			 * have already released it in __lock_page_or_retry
+			 * in mm/filemap.c.
+			 */
+
+			goto retry;
+		}
 	}
 
 	up_read(&mm->mmap_sem);
-- 
1.7.6
