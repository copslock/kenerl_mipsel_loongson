Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jan 2017 08:45:26 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:1432 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991964AbdAMHo5xxOPz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Jan 2017 08:44:57 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 969ADB89A8099;
        Fri, 13 Jan 2017 07:44:49 +0000 (GMT)
Received: from WR-NOWAKOWSKI.kl.imgtec.org (10.80.2.5) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 13 Jan 2017 07:44:51 +0000
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>
Subject: [PATCH 2/2] MIPS: ptrace: disable watchpoints if hit in kernel mode
Date:   Fri, 13 Jan 2017 08:44:47 +0100
Message-ID: <1484293487-5770-2-git-send-email-marcin.nowakowski@imgtec.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1484293487-5770-1-git-send-email-marcin.nowakowski@imgtec.com>
References: <1484293487-5770-1-git-send-email-marcin.nowakowski@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56287
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcin.nowakowski@imgtec.com
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

If a watchpoint is hit when in kernel mode it is possible for the system
to end up in an infinite loop processing the watchpoint. This can happen
if a user sets a watchpoint in the kernel addess space (which is
possible in certain EVA configurations) or if a user sets a watchpoint
in a user area accessed directly by the kernel (eg. a user buffer
accessed via a syscall).

To prevent the infinite loop ensure that the watchpoint was hit in
userspace, and clear the watchpoint registers otherwise.

As this change could mean that a watchpoint is not hit when it should be
(when returning to the interrupted traced task on exception exit), the
resume_userspace path needs to be extended to conditionally restore the
watchpoint configuration. If a task switch occurs when returning to
userspace, the watchpoints will be restored in a typical way in the
switch_to() handler.

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
---
 arch/mips/kernel/entry.S | 9 ++++++++-
 arch/mips/kernel/traps.c | 2 +-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/entry.S b/arch/mips/kernel/entry.S
index ef69a64..b15a9a9 100644
--- a/arch/mips/kernel/entry.S
+++ b/arch/mips/kernel/entry.S
@@ -55,7 +55,14 @@ resume_userspace:
 	LONG_L	a2, TI_FLAGS($28)	# current->work
 	andi	t0, a2, _TIF_WORK_MASK	# (ignoring syscall_trace)
 	bnez	t0, work_pending
-	j	restore_all
+#ifdef CONFIG_HARDWARE_WATCHPOINTS
+	li	t0, _TIF_LOAD_WATCH
+	and	t0, a2, t0
+	beqz	t0, 1f
+	PTR_L	a0, TI_TASK($28)
+	jal	mips_install_watch_registers
+#endif
+1:	j	restore_all
 
 #ifdef CONFIG_PREEMPT
 resume_kernel:
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index b86ce85..d92169e 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1527,7 +1527,7 @@ asmlinkage void do_watch(struct pt_regs *regs)
 	 * their values and send SIGTRAP.  Otherwise another thread
 	 * left the registers set, clear them and continue.
 	 */
-	if (test_tsk_thread_flag(current, TIF_LOAD_WATCH)) {
+	if (user_mode(regs) && test_tsk_thread_flag(current, TIF_LOAD_WATCH)) {
 		mips_read_watch_registers();
 		local_irq_enable();
 		force_sig_info(SIGTRAP, &info, current);
-- 
2.7.4
