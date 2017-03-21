Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Mar 2017 15:52:43 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:17684 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993886AbdCUOwgzFZz6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Mar 2017 15:52:36 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 927FB634AD543;
        Tue, 21 Mar 2017 14:52:26 +0000 (GMT)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 21 Mar 2017 14:52:29 +0000
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Masanari Iida <standby24x7@gmail.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Jason A. Donenfeld" <jason@zx2c4.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] MIPS: IRQ Stack: Unwind IRQ stack onto task stack
Date:   Tue, 21 Mar 2017 14:52:25 +0000
Message-ID: <1490107945-21553-1-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57403
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

When the separate IRQ stack was introduced, stack unwinding only
proceeded as far as the top of the IRQ stack, leading to kernel
backtraces being less useful, lacking the trace of what was interrupted.

Fix this by providing a means for the kernel to unwind the IRQ stack
onto the interrupted task stack. The processor state is saved to the
kernel task stack on interrupt. The IRQ_STACK_START macro reserves an
unsigned long at the top of the IRQ stack where the interrupted task
stack pointer can be saved. After the active stack is switched to the
IRQ stack, save the interrupted tasks stack pointer to the reserved
location.

Fix the stack unwinding code to look for the frame being the top of the
IRQ stack and if so get the next frame from the saved location. The
existing test does not work with the separate stack since the ra is no
longer pointed at ret_from_{irq,exception}.

The test to stop unwinding the stack 32 bytes from the top of a stack
must be modified to allow unwinding to continue up to the location of
the saved task stack pointer when on the IRQ stack. The low / high marks
of the stack are set depending on whether the sp is on an irq stack or
not.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
---

 arch/mips/include/asm/irq.h    | 15 +++++++++++
 arch/mips/kernel/asm-offsets.c |  1 +
 arch/mips/kernel/genex.S       |  8 ++++--
 arch/mips/kernel/process.c     | 56 ++++++++++++++++++++++++++++--------------
 4 files changed, 60 insertions(+), 20 deletions(-)

diff --git a/arch/mips/include/asm/irq.h b/arch/mips/include/asm/irq.h
index 956db6e201d1..ddd1c918103b 100644
--- a/arch/mips/include/asm/irq.h
+++ b/arch/mips/include/asm/irq.h
@@ -18,9 +18,24 @@
 #include <irq.h>
 
 #define IRQ_STACK_SIZE			THREAD_SIZE
+#define IRQ_STACK_START			(IRQ_STACK_SIZE - sizeof(unsigned long))
 
 extern void *irq_stack[NR_CPUS];
 
+/*
+ * The highest address on the IRQ stack contains a dummy frame put down in
+ * genex.S (handle_int & except_vec_vi_handler) which is structured as follows:
+ *
+ *   top ------------
+ *       | task sp  | <- irq_stack[cpu] + IRQ_STACK_START
+ *       ------------
+ *       |          | <- First frame of IRQ context
+ *       ------------
+ *
+ * task sp holds a copy of the task stack pointer where the struct pt_regs
+ * from exception entry can be found.
+ */
+
 static inline bool on_irq_stack(int cpu, unsigned long sp)
 {
 	unsigned long low = (unsigned long)irq_stack[cpu];
diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index bb5c5d34ba81..a670c0c11875 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -102,6 +102,7 @@ void output_thread_info_defines(void)
 	DEFINE(_THREAD_SIZE, THREAD_SIZE);
 	DEFINE(_THREAD_MASK, THREAD_MASK);
 	DEFINE(_IRQ_STACK_SIZE, IRQ_STACK_SIZE);
+	DEFINE(_IRQ_STACK_START, IRQ_STACK_START);
 	BLANK();
 }
 
diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index 7ec9612cb007..68466dd4bab1 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -215,9 +215,11 @@ NESTED(handle_int, PT_SIZE, sp)
 	beq	t0, t1, 2f
 
 	/* Switch to IRQ stack */
-	li	t1, _IRQ_STACK_SIZE
+	li	t1, _IRQ_STACK_START
 	PTR_ADD sp, t0, t1
 
+	/* Save task's sp on IRQ stack so that unwinding can follow it */
+	LONG_S	s1, 0(sp)
 2:
 	jal	plat_irq_dispatch
 
@@ -325,9 +327,11 @@ NESTED(except_vec_vi_handler, 0, sp)
 	beq	t0, t1, 2f
 
 	/* Switch to IRQ stack */
-	li	t1, _IRQ_STACK_SIZE
+	li	t1, _IRQ_STACK_START
 	PTR_ADD sp, t0, t1
 
+	/* Save task's sp on IRQ stack so that unwinding can follow it */
+	LONG_S	s1, 0(sp)
 2:
 	jalr	v0
 
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index fb6b6b650719..b68e10fc453d 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -488,31 +488,52 @@ unsigned long notrace unwind_stack_by_address(unsigned long stack_page,
 					      unsigned long pc,
 					      unsigned long *ra)
 {
+	unsigned long low, high, irq_stack_high;
 	struct mips_frame_info info;
 	unsigned long size, ofs;
+	struct pt_regs *regs;
 	int leaf;
-	extern void ret_from_irq(void);
-	extern void ret_from_exception(void);
 
 	if (!stack_page)
 		return 0;
 
 	/*
-	 * If we reached the bottom of interrupt context,
-	 * return saved pc in pt_regs.
+	 * IRQ stacks start at IRQ_STACK_START
+	 * task stacks at THREAD_SIZE - 32
 	 */
-	if (pc == (unsigned long)ret_from_irq ||
-	    pc == (unsigned long)ret_from_exception) {
-		struct pt_regs *regs;
-		if (*sp >= stack_page &&
-		    *sp + sizeof(*regs) <= stack_page + THREAD_SIZE - 32) {
-			regs = (struct pt_regs *)*sp;
-			pc = regs->cp0_epc;
-			if (!user_mode(regs) && __kernel_text_address(pc)) {
-				*sp = regs->regs[29];
-				*ra = regs->regs[31];
-				return pc;
-			}
+	low = stack_page;
+	if (!preemptible() && on_irq_stack(raw_smp_processor_id(), *sp)) {
+		high = stack_page + IRQ_STACK_START;
+		irq_stack_high = high;
+	} else {
+		high = stack_page + THREAD_SIZE - 32;
+		irq_stack_high = 0;
+	}
+
+	/*
+	 * If we reached the top of the interrupt stack, start unwinding
+	 * the interrupted task stack.
+	 */
+	if (unlikely(*sp == irq_stack_high)) {
+		unsigned long task_sp = *(unsigned long *)*sp;
+
+		/*
+		 * Check that the pointer saved in the IRQ stack head points to
+		 * something within the stack of the current task
+		 */
+		if (!object_is_on_stack((void *)task_sp))
+			return 0;
+
+		/*
+		 * Follow pointer to tasks kernel stack frame where interrupted
+		 * state was saved.
+		 */
+		regs = (struct pt_regs *)task_sp;
+		pc = regs->cp0_epc;
+		if (!user_mode(regs) && __kernel_text_address(pc)) {
+			*sp = regs->regs[29];
+			*ra = regs->regs[31];
+			return pc;
 		}
 		return 0;
 	}
@@ -533,8 +554,7 @@ unsigned long notrace unwind_stack_by_address(unsigned long stack_page,
 	if (leaf < 0)
 		return 0;
 
-	if (*sp < stack_page ||
-	    *sp + info.frame_size > stack_page + THREAD_SIZE - 32)
+	if (*sp < low || *sp + info.frame_size > high)
 		return 0;
 
 	if (leaf)
-- 
2.7.4
