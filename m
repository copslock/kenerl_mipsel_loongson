Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jul 2014 17:48:46 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:45548 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6860081AbaGKPrYBxLfw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Jul 2014 17:47:24 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id E6203D25F98CA
        for <linux-mips@linux-mips.org>; Fri, 11 Jul 2014 16:47:08 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 11 Jul 2014 16:47:12 +0100
Received: from pburton-laptop.home (192.168.79.172) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 11 Jul
 2014 16:47:11 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 11/13] MIPS: consistently clear MSA flags when starting & copying threads
Date:   Fri, 11 Jul 2014 16:47:05 +0100
Message-ID: <1405093625-5280-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.0.1
In-Reply-To: <1405093479-5123-1-git-send-email-paul.burton@imgtec.com>
References: <1405093479-5123-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.79.172]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41146
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

The TIF_MSA_CTX_LIVE flag (indicating that a task has MSA context which
needs to be preserved) was being cleared in start_thread, but the
TIF_USEDMSA flag (indicating that a task has used MSA in this timeslice)
was not. In copy_thread neither flag was cleared, but both need to be.
Without clearing these flags the kernel will proceed to attempt to save
MSA context when the task is context switched out, and if the task had
not used MSA in the meantime then it will fail because MSA or the FPU
are disabled. The end result is typically:

  do_cpu invoked from kernel context![#1]:
  CPU: 0 PID: 99 Comm: sh Not tainted 3.16.0-rc4-00025-g6dc9476-dirty #88
  task: 8f23dc60 ti: 8f1d8000 task.ti: 8f1d8000
  ...
  Call Trace:
  [<8010edbc>] resume+0x5c/0x280
  [<80481e0c>] __schedule+0x370/0x800
  [<80104838>] work_resched+0x8/0x2c

Fix by consistently clearing both flags in both functions.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/kernel/process.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 0a1ec0f..8e0e7d6 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -66,6 +66,7 @@ void start_thread(struct pt_regs * regs, unsigned long pc, unsigned long sp)
 	clear_used_math();
 	clear_fpu_owner();
 	init_dsp();
+	clear_thread_flag(TIF_USEDMSA);
 	clear_thread_flag(TIF_MSA_CTX_LIVE);
 	disable_msa();
 	regs->cp0_epc = pc;
@@ -141,6 +142,8 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	childregs->cp0_status &= ~(ST0_CU2|ST0_CU1);
 
 	clear_tsk_thread_flag(p, TIF_USEDFPU);
+	clear_tsk_thread_flag(p, TIF_USEDMSA);
+	clear_tsk_thread_flag(p, TIF_MSA_CTX_LIVE);
 
 #ifdef CONFIG_MIPS_MT_FPAFF
 	clear_tsk_thread_flag(p, TIF_FPUBOUND);
-- 
2.0.1
