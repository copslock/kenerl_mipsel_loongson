Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 May 2017 14:24:22 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:46788 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993978AbdECMXlPiRYi (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 3 May 2017 14:23:41 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E0137AEC0;
        Wed,  3 May 2017 12:23:40 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     stable@vger.kernel.org
Cc:     James Hogan <james.hogan@imgtec.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Jiri Slaby <jslaby@suse.cz>
Subject: [patch added to 3.12-stable] MIPS: KGDB: Use kernel context for sleeping threads
Date:   Wed,  3 May 2017 14:23:23 +0200
Message-Id: <20170503122327.12095-45-jslaby@suse.cz>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170503122327.12095-1-jslaby@suse.cz>
References: <20170503122327.12095-1-jslaby@suse.cz>
Return-Path: <jslaby@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57847
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jslaby@suse.cz
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

From: James Hogan <james.hogan@imgtec.com>

This patch has been added to the 3.12 stable tree. If you have any
objections, please let us know.

===============

commit 162b270c664dca2e0944308e92f9fcc887151a72 upstream.

KGDB is a kernel debug stub and it can't be used to debug userland as it
can only safely access kernel memory.

On MIPS however KGDB has always got the register state of sleeping
processes from the userland register context at the beginning of the
kernel stack. This is meaningless for kernel threads (which never enter
userland), and for user threads it prevents the user seeing what it is
doing while in the kernel:

(gdb) info threads
  Id   Target Id         Frame
  ...
  3    Thread 2 (kthreadd) 0x0000000000000000 in ?? ()
  2    Thread 1 (init)   0x000000007705c4b4 in ?? ()
  1    Thread -2 (shadowCPU0) 0xffffffff8012524c in arch_kgdb_breakpoint () at arch/mips/kernel/kgdb.c:201

Get the register state instead from the (partial) kernel register
context stored in the task's thread_struct for resume() to restore. All
threads now correctly appear to be in context_switch():

(gdb) info threads
  Id   Target Id         Frame
  ...
  3    Thread 2 (kthreadd) context_switch (rq=<optimized out>, cookie=..., next=<optimized out>, prev=0x0) at kernel/sched/core.c:2903
  2    Thread 1 (init)   context_switch (rq=<optimized out>, cookie=..., next=<optimized out>, prev=0x0) at kernel/sched/core.c:2903
  1    Thread -2 (shadowCPU0) 0xffffffff8012524c in arch_kgdb_breakpoint () at arch/mips/kernel/kgdb.c:201

Call clobbered registers which aren't saved and exception registers
(BadVAddr & Cause) which can't be easily determined without stack
unwinding are reported as 0. The PC is taken from the return address,
such that the state presented matches that found immediately after
returning from resume().

Fixes: 8854700115ec ("[MIPS] kgdb: add arch support for the kernel's kgdb core")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Jason Wessel <jason.wessel@windriver.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/15829/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 arch/mips/kernel/kgdb.c | 48 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 15 deletions(-)

diff --git a/arch/mips/kernel/kgdb.c b/arch/mips/kernel/kgdb.c
index fcaac2f132f0..910db386d9ef 100644
--- a/arch/mips/kernel/kgdb.c
+++ b/arch/mips/kernel/kgdb.c
@@ -236,9 +236,6 @@ static int compute_signal(int tt)
 void sleeping_thread_to_gdb_regs(unsigned long *gdb_regs, struct task_struct *p)
 {
 	int reg;
-	struct thread_info *ti = task_thread_info(p);
-	unsigned long ksp = (unsigned long)ti + THREAD_SIZE - 32;
-	struct pt_regs *regs = (struct pt_regs *)ksp - 1;
 #if (KGDB_GDB_REG_SIZE == 32)
 	u32 *ptr = (u32 *)gdb_regs;
 #else
@@ -246,25 +243,46 @@ void sleeping_thread_to_gdb_regs(unsigned long *gdb_regs, struct task_struct *p)
 #endif
 
 	for (reg = 0; reg < 16; reg++)
-		*(ptr++) = regs->regs[reg];
+		*(ptr++) = 0;
 
 	/* S0 - S7 */
-	for (reg = 16; reg < 24; reg++)
-		*(ptr++) = regs->regs[reg];
+	*(ptr++) = p->thread.reg16;
+	*(ptr++) = p->thread.reg17;
+	*(ptr++) = p->thread.reg18;
+	*(ptr++) = p->thread.reg19;
+	*(ptr++) = p->thread.reg20;
+	*(ptr++) = p->thread.reg21;
+	*(ptr++) = p->thread.reg22;
+	*(ptr++) = p->thread.reg23;
 
 	for (reg = 24; reg < 28; reg++)
 		*(ptr++) = 0;
 
 	/* GP, SP, FP, RA */
-	for (reg = 28; reg < 32; reg++)
-		*(ptr++) = regs->regs[reg];
-
-	*(ptr++) = regs->cp0_status;
-	*(ptr++) = regs->lo;
-	*(ptr++) = regs->hi;
-	*(ptr++) = regs->cp0_badvaddr;
-	*(ptr++) = regs->cp0_cause;
-	*(ptr++) = regs->cp0_epc;
+	*(ptr++) = (long)p;
+	*(ptr++) = p->thread.reg29;
+	*(ptr++) = p->thread.reg30;
+	*(ptr++) = p->thread.reg31;
+
+	*(ptr++) = p->thread.cp0_status;
+
+	/* lo, hi */
+	*(ptr++) = 0;
+	*(ptr++) = 0;
+
+	/*
+	 * BadVAddr, Cause
+	 * Ideally these would come from the last exception frame up the stack
+	 * but that requires unwinding, otherwise we can't know much for sure.
+	 */
+	*(ptr++) = 0;
+	*(ptr++) = 0;
+
+	/*
+	 * PC
+	 * use return address (RA), i.e. the moment after return from resume()
+	 */
+	*(ptr++) = p->thread.reg31;
 }
 
 void kgdb_arch_set_pc(struct pt_regs *regs, unsigned long pc)
-- 
2.12.2
