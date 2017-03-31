Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Mar 2017 18:10:57 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:54685 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992155AbdCaQK23qSio (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 31 Mar 2017 18:10:28 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 902F8F41ABC5D;
        Fri, 31 Mar 2017 17:10:18 +0100 (IST)
Received: from LDT-J-COWGILL.le.imgtec.org (10.150.130.85) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 31 Mar 2017 17:10:22 +0100
From:   James Cowgill <James.Cowgill@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     <James.Cowgill@imgtec.com>
Subject: [PATCH 1/2] MIPS: opt into HAVE_COPY_THREAD_TLS
Date:   Fri, 31 Mar 2017 17:09:58 +0100
Message-ID: <20170331160959.3192-2-James.Cowgill@imgtec.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170331160959.3192-1-James.Cowgill@imgtec.com>
References: <20170331160959.3192-1-James.Cowgill@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.85]
Return-Path: <James.Cowgill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57516
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: James.Cowgill@imgtec.com
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

This the mips version of commit c1bd55f922a2d ("x86: opt into
HAVE_COPY_THREAD_TLS, for both 32-bit and 64-bit").

Simply use the tls system call argument instead of extracting the tls
argument by magic from the pt_regs structure.

See commit 3033f14ab78c3 ("clone: support passing tls argument via C
rather than pt_regs magic") for more background.

Signed-off-by: James Cowgill <James.Cowgill@imgtec.com>
---
 arch/mips/Kconfig          | 1 +
 arch/mips/kernel/process.c | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index a008a9f03072..7baddfa0e229 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -69,6 +69,7 @@ config MIPS
 	select HAVE_EXIT_THREAD
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_ARCH_HARDENED_USERCOPY
+	select HAVE_COPY_THREAD_TLS
 
 menu "Machine selection"
 
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index fb6b6b650719..2b8066806bc4 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -114,8 +114,8 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 /*
  * Copy architecture-specific thread state
  */
-int copy_thread(unsigned long clone_flags, unsigned long usp,
-	unsigned long kthread_arg, struct task_struct *p)
+int copy_thread_tls(unsigned long clone_flags, unsigned long usp,
+	unsigned long kthread_arg, struct task_struct *p, unsigned long tls)
 {
 	struct thread_info *ti = task_thread_info(p);
 	struct pt_regs *childregs, *regs = current_pt_regs();
@@ -176,7 +176,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	atomic_set(&p->thread.bd_emu_frame, BD_EMUFRAME_NONE);
 
 	if (clone_flags & CLONE_SETTLS)
-		ti->tp_value = regs->regs[7];
+		ti->tp_value = tls;
 
 	return 0;
 }
-- 
2.11.0
