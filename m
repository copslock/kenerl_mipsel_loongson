Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Oct 2017 10:59:19 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:53226 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994798AbdJFI6zLjPxo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Oct 2017 10:58:55 +0200
Received: from localhost (LFbn-1-12253-150.w90-92.abo.wanadoo.fr [90.92.67.150])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 501E1723;
        Fri,  6 Oct 2017 08:58:48 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matt Redfearn <matt.redfearn@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Masanari Iida <standby24x7@gmail.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Jason A. Donenfeld" <jason@zx2c4.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.4 36/50] MIPS: IRQ Stack: Unwind IRQ stack onto task stack
Date:   Fri,  6 Oct 2017 10:53:24 +0200
Message-Id: <20171006083711.033827562@linuxfoundation.org>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171006083705.157012217@linuxfoundation.org>
References: <20171006083705.157012217@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60307
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matt Redfearn <matt.redfearn@imgtec.com>


[ Upstream commit db8466c581cca1a08b505f1319c3ecd246f16fa8 ]

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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc: Masanari Iida <standby24x7@gmail.com>
Cc: Chris Metcalf <cmetcalf@mellanox.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jason A. Donenfeld <jason@zx2c4.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/15788/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/include/asm/irq.h    |   15 ++++++++++
 arch/mips/kernel/asm-offsets.c |    1 
 arch/mips/kernel/genex.S       |    8 ++++-
 arch/mips/kernel/process.c     |   56 +++++++++++++++++++++++++++--------------
 4 files changed, 60 insertions(+), 20 deletions(-)

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
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -102,6 +102,7 @@ void output_thread_info_defines(void)
 	DEFINE(_THREAD_SIZE, THREAD_SIZE);
 	DEFINE(_THREAD_MASK, THREAD_MASK);
 	DEFINE(_IRQ_STACK_SIZE, IRQ_STACK_SIZE);
+	DEFINE(_IRQ_STACK_START, IRQ_STACK_START);
 	BLANK();
 }
 
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -216,9 +216,11 @@ NESTED(handle_int, PT_SIZE, sp)
 	beq	t0, t1, 2f
 
 	/* Switch to IRQ stack */
-	li	t1, _IRQ_STACK_SIZE
+	li	t1, _IRQ_STACK_START
 	PTR_ADD sp, t0, t1
 
+	/* Save task's sp on IRQ stack so that unwinding can follow it */
+	LONG_S	s1, 0(sp)
 2:
 	jal	plat_irq_dispatch
 
@@ -326,9 +328,11 @@ NESTED(except_vec_vi_handler, 0, sp)
 	beq	t0, t1, 2f
 
 	/* Switch to IRQ stack */
-	li	t1, _IRQ_STACK_SIZE
+	li	t1, _IRQ_STACK_START
 	PTR_ADD sp, t0, t1
 
+	/* Save task's sp on IRQ stack so that unwinding can follow it */
+	LONG_S	s1, 0(sp)
 2:
 	jalr	v0
 
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -483,31 +483,52 @@ unsigned long notrace unwind_stack_by_ad
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
@@ -528,8 +549,7 @@ unsigned long notrace unwind_stack_by_ad
 	if (leaf < 0)
 		return 0;
 
-	if (*sp < stack_page ||
-	    *sp + info.frame_size > stack_page + THREAD_SIZE - 32)
+	if (*sp < low || *sp + info.frame_size > high)
 		return 0;
 
 	if (leaf)
