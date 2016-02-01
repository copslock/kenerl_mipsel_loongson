Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Feb 2016 14:51:41 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:53529 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011936AbcBANvHi2Foo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Feb 2016 14:51:07 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 522064B37C6B9;
        Mon,  1 Feb 2016 13:50:59 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Mon, 1 Feb 2016 13:51:01 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Mon, 1 Feb 2016 13:51:00 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>, Paul Burton <paul.burton@imgtec.com>,
        "James Hogan" <james.hogan@imgtec.com>
Subject: [PATCH 2/2] MIPS: Fix FPU disable with preemption
Date:   Mon, 1 Feb 2016 13:50:37 +0000
Message-ID: <1454334637-3860-3-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1454334637-3860-1-git-send-email-james.hogan@imgtec.com>
References: <1454334637-3860-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51587
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

The FPU should not be left enabled after a task context switch. This
isn't usually a problem as the FPU enable bit is updated before
returning to userland, however it can potentially mask kernel bugs, and
in fact KVM assumes it won't happen and won't clear the FPU enable bit
before returning to the guest, which allows the guest to use stale FPU
context.

Interrupts and exceptions save and restore most bits of the CP0 Status
register which contains the FPU enable bit (CU1). When the kernel needs
to enable or disable the FPU (for example due to attempted FPU use by
userland, or the scheduler being invoked) both the actual Status
register and the saved value in the userland context are updated.

However this doesn't work correctly with full kernel preemption enabled,
since the FPU enable bit can be cleared from within an interrupt when
the scheduler is invoked, and only the userland context is updated, not
the interrupt context.

For example:
1) Enter kernel with FPU already enabled, TIF_USEDFPU=1, Status.CU1=1
   saved.
2) Take a timer interrupt while in kernel mode, Status.CU1=1 saved.
3) Timer interrupt invokes scheduler to preempt the task, which clears
   TIF_USEDFPU, disables the FPU in Status register (Status.CU1=0), and
   the value stored in user context from step (1), but not the interrupt
   context from step (2).
4) When the process is scheduled back in again Status.CU1=0.
5) The interrupt context from step (2) is restored, which sets
   Status.CU1=1. So from user context point of view, preemption has
   re-enabled FPU!
6) If the scheduler is invoked again (via preemption or voluntarily)
   before returning to userland, TIF_USEDFPU=0 so the FPU is not
   disabled before the task context switch.
7) The next task resumes from the context switch with FPU enabled!

The restoring of the Status register on return from interrupt/exception
is already selective about which bits to restore, leaving the interrupt
mask bits alone so enabling/disabling of CPU interrupt lines can
persist. Extend this to also leave both the CU1 bit (FPU enable) and the
FR bit (which specifies the FPU mode and gets changed with CU1). This
prevents a stale Status value being restored in step (5) above and
persisting through subsequent context switches.

Also switch to the use of definitions from asm/mipsregs.h while we're at
it.

Since this change also affects the restoration of Status register on the
path back to userland, it increases the sensitivity of the kernel to the
problem of the FPU being left enabled, allowing it to propagate to
userland, therefore a warning is also added to lose_fpu_inatomic() to
point out any future reoccurances before they do any damage.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Reviewed-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/fpu.h        | 4 ++++
 arch/mips/include/asm/stackframe.h | 4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/fpu.h b/arch/mips/include/asm/fpu.h
index 9cbf383b8834..f06f97bd62df 100644
--- a/arch/mips/include/asm/fpu.h
+++ b/arch/mips/include/asm/fpu.h
@@ -179,6 +179,10 @@ static inline void lose_fpu_inatomic(int save, struct task_struct *tsk)
 		if (save)
 			_save_fp(tsk);
 		__disable_fpu();
+	} else {
+		/* FPU should not have been left enabled with no owner */
+		WARN(read_c0_status() & ST0_CU1,
+		     "Orphaned FPU left enabled");
 	}
 	KSTK_STATUS(tsk) &= ~ST0_CU1;
 	clear_tsk_thread_flag(tsk, TIF_USEDFPU);
diff --git a/arch/mips/include/asm/stackframe.h b/arch/mips/include/asm/stackframe.h
index a71da576883c..eebf39549606 100644
--- a/arch/mips/include/asm/stackframe.h
+++ b/arch/mips/include/asm/stackframe.h
@@ -289,7 +289,7 @@
 		.set	reorder
 		.set	noat
 		mfc0	a0, CP0_STATUS
-		li	v1, 0xff00
+		li	v1, ST0_CU1 | ST0_IM
 		ori	a0, STATMASK
 		xori	a0, STATMASK
 		mtc0	a0, CP0_STATUS
@@ -330,7 +330,7 @@
 		ori	a0, STATMASK
 		xori	a0, STATMASK
 		mtc0	a0, CP0_STATUS
-		li	v1, 0xff00
+		li	v1, ST0_CU1 | ST0_FR | ST0_IM
 		and	a0, v1
 		LONG_L	v0, PT_STATUS(sp)
 		nor	v1, $0, v1
-- 
2.4.10
