Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Nov 2011 16:03:59 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:37645 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904113Ab1KRPDz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Nov 2011 16:03:55 +0100
Received: by faar25 with SMTP id r25so5521146faa.36
        for <multiple recipients>; Fri, 18 Nov 2011 07:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=9+E1fJ+8y1GZnNaFSv6H6SGcxxTsEKeHQkGbTaxOQH0=;
        b=taAXyQ2CCe6C/UjtBmz7GBIfKcY92t9lqx0wWmzyOjheBBVeo4MqMq1BQU/ux2AAjc
         TwyluJbOiX5fEvw2UH8hXGzm6VVzlq+DVbA8YhC/nhNzHGYFZV71uJeH/YSVN2f76V/V
         ePEiyD9+yRw6qul7RU0SzURDsPIe16PFJEbUo=
MIME-Version: 1.0
Received: by 10.181.11.226 with SMTP id el2mr3428225wid.64.1321628630438; Fri,
 18 Nov 2011 07:03:50 -0800 (PST)
Received: by 10.216.45.11 with HTTP; Fri, 18 Nov 2011 07:03:50 -0800 (PST)
Date:   Fri, 18 Nov 2011 23:03:50 +0800
Message-ID: <CAJd=RBCmvyT2ZiaF=XsCenogZJ_Ry_M1uth7=U6PRS1=0LmZ9Q@mail.gmail.com>
Subject: [PATCH] MIPS: Add FAULT_FLAG_ALLOW_RETRY in page fault handler
From:   Hillf Danton <dhillf@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     David Daney <david.daney@cavium.com>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
X-archive-position: 31789
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dhillf@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15511

The flag, FAULT_FLAG_ALLOW_RETRY, was introduced by the patch,

	mm: retry page fault when blocking on disk transfer
	commit: d065bd810b6deb67d4897a14bfe21f8eb526ba99

for reducing mmap_sem hold times that are caused by waiting for disk
transfers when accessing file mapped VMAs. So add it now.

Signed-off-by: Hillf Danton <dhillf@gmail.com>
---

--- a/arch/mips/mm/fault.c	Fri Nov 18 22:23:40 2011
+++ b/arch/mips/mm/fault.c	Fri Nov 18 22:36:04 2011
@@ -42,6 +42,8 @@ asmlinkage void __kprobes do_page_fault(
 	const int field = sizeof(unsigned long) * 2;
 	siginfo_t info;
 	int fault;
+	unsigned int flags = FAULT_FLAG_ALLOW_RETRY |
+				(write ? FAULT_FLAG_WRITE : 0);

 #if 0
 	printk("Cpu%d[%s:%d:%0*lx:%ld:%0*lx]\n", raw_smp_processor_id(),
@@ -91,6 +93,7 @@ asmlinkage void __kprobes do_page_fault(
 	if (in_atomic() || !mm)
 		goto bad_area_nosemaphore;

+retry:
 	down_read(&mm->mmap_sem);
 	vma = find_vma(mm, address);
 	if (!vma)
@@ -144,7 +147,7 @@ good_area:
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	fault = handle_mm_fault(mm, vma, address, write ? FAULT_FLAG_WRITE : 0);
+	fault = handle_mm_fault(mm, vma, address, flags);
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
@@ -152,6 +155,12 @@ good_area:
 		else if (fault & VM_FAULT_SIGBUS)
 			goto do_sigbus;
 		BUG();
+	}
+	if (flags & FAULT_FLAG_ALLOW_RETRY) {
+		if (fault & VM_FAULT_RETRY) {
+			flags &= ~FAULT_FLAG_ALLOW_RETRY;
+			goto retry;
+		}
 	}
 	if (fault & VM_FAULT_MAJOR) {
 		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1, regs, address);
