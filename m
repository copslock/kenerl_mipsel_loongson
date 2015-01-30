Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jan 2015 13:11:48 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:21685 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012311AbbA3MLnIMoJE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Jan 2015 13:11:43 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 4E17D28912731
        for <linux-mips@linux-mips.org>; Fri, 30 Jan 2015 12:11:35 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 30 Jan 2015 12:11:37 +0000
Received: from localhost (192.168.159.167) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 30 Jan
 2015 12:11:36 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v2 06/10] MIPS: ensure FCSR cause bits are clear after invoking FPU emulator
Date:   Fri, 30 Jan 2015 12:09:35 +0000
Message-ID: <1422619779-9940-7-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <1422619779-9940-1-git-send-email-paul.burton@imgtec.com>
References: <1422619779-9940-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.167]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45568
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

When running the emulator to handle an instruction that raised an FP
unimplemented operation exception, the FCSR cause bits were being
cleared. This is done to ensure that the kernel does not take an FP
exception when later restoring FP context to registers. However, this
was not being done when the emulator is invoked in response to a
coprocessor unusable exception. This happens in 2 cases:

  - There is no FPU present in the system. In this case things were
    OK, since the FP context is never restored to hardware registers
    and thus no FP exception may be raised when restoring FCSR.

  - The FPU could not be configured to the mode required by the task.
    In this case it would be possible for the emulator to set cause
    bits which are later restored to hardware if the task migrates
    to a CPU whose associated FPU does support its mode requirements,
    or if the tasks FP mode requirements change.

Consistently clear the cause bits after invoking the emulator, by moving
the clearing to process_fpemu_return and ensuring this is always called
before the tasks FP context is restored. This will make it easier to
catch further paths invoking the emulator in future, as will be
introduced in further patches.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
Changes in v2:
  - Rebase atop v3.19-rc6.
---
 arch/mips/kernel/traps.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index d5fbfb5..2efb41d 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -700,6 +700,13 @@ asmlinkage void do_ov(struct pt_regs *regs)
 
 int process_fpemu_return(int sig, void __user *fault_addr)
 {
+	/*
+	 * We can't allow the emulated instruction to leave any of the cause
+	 * bits set in FCSR. If they were then the kernel would take an FP
+	 * exception when restoring FP context.
+	 */
+	current->thread.fpu.fcr31 &= ~FPU_CSR_ALL_X;
+
 	if (sig == SIGSEGV || sig == SIGBUS) {
 		struct siginfo si = {0};
 		si.si_addr = fault_addr;
@@ -803,18 +810,12 @@ asmlinkage void do_fpe(struct pt_regs *regs, unsigned long fcr31)
 		sig = fpu_emulator_cop1Handler(regs, &current->thread.fpu, 1,
 					       &fault_addr);
 
-		/*
-		 * We can't allow the emulated instruction to leave any of
-		 * the cause bit set in $fcr31.
-		 */
-		current->thread.fpu.fcr31 &= ~FPU_CSR_ALL_X;
+		/* If something went wrong, signal */
+		process_fpemu_return(sig, fault_addr);
 
 		/* Restore the hardware register state */
 		own_fpu(1);	/* Using the FPU again.	 */
 
-		/* If something went wrong, signal */
-		process_fpemu_return(sig, fault_addr);
-
 		goto out;
 	} else if (fcr31 & FPU_CSR_INV_X)
 		info.si_code = FPE_FLTINV;
-- 
2.2.2
