Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Oct 2016 16:35:29 +0200 (CEST)
Received: from mailapp02.imgtec.com ([217.156.133.132]:62361 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23991759AbcJQOfOJPi04 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Oct 2016 16:35:14 +0200
Received: from HHMAIL03.hh.imgtec.org (unknown [10.44.0.21])
        by Forcepoint Email with ESMTPS id 3135419F45520;
        Mon, 17 Oct 2016 15:35:04 +0100 (IST)
Received: from HHMAIL01.hh.imgtec.org (10.100.10.19) by HHMAIL03.hh.imgtec.org
 (10.44.0.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 17 Oct 2016
 15:35:07 +0100
Received: from localhost (10.100.200.11) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 17 Oct
 2016 15:35:06 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 1/4] MIPS: Remove r2_emul_return from struct thread_info
Date:   Mon, 17 Oct 2016 15:34:35 +0100
Message-ID: <20161017143438.17298-2-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161017143438.17298-1-paul.burton@imgtec.com>
References: <20161017143438.17298-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.11]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55455
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

The r2_emul_return field in struct thread_info was used in order to take
an alternate codepath when returning to userland, which (besides not
implementing certain features) effectively used the eretnc instruction
in place of eret. The difference is that eretnc doesn't clear LLBit, and
therefore doesn't cause a linked load & store sequence to fail due to
emulation like eret would.

The reason eret would usually be used to clear LLBit is so that after
context switching we ensure that a load performed by one task doesn't
influence another task. However commit 7c151d3d5d7a ("MIPS: Make use of
the ERETNC instruction on MIPS R6") which introduced the r2_emul_return
field and conditional use of eretnc also for some reason began
explicitly clearing LLBit during context switches - despite retaining
the use of eret for everything but returns from the pre-r6 instruction
emulation code.

As LLBit is cleared upon context switches anyway, simplify this by using
eretnc unconditionally for MIPSr6 kernels. This allows us to remove the
4 byte r2_emul_return boolean from struct thread_info, simplify the
return to user code in entry.S and avoid the overhead of tracking &
checking state which we don't need.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/include/asm/stackframe.h  |  4 ++++
 arch/mips/include/asm/thread_info.h |  1 -
 arch/mips/kernel/asm-offsets.c      |  1 -
 arch/mips/kernel/entry.S            | 18 ------------------
 arch/mips/kernel/traps.c            |  2 --
 5 files changed, 4 insertions(+), 22 deletions(-)

diff --git a/arch/mips/include/asm/stackframe.h b/arch/mips/include/asm/stackframe.h
index eebf395..41e6836 100644
--- a/arch/mips/include/asm/stackframe.h
+++ b/arch/mips/include/asm/stackframe.h
@@ -357,9 +357,13 @@
 
 		.macro	RESTORE_SP_AND_RET
 		LONG_L	sp, PT_R29(sp)
+#ifdef CONFIG_CPU_MIPSR6
+		eretnc
+#else
 		.set	arch=r4000
 		eret
 		.set	mips0
+#endif
 		.endm
 
 #endif
diff --git a/arch/mips/include/asm/thread_info.h b/arch/mips/include/asm/thread_info.h
index e309d8f..b439e51 100644
--- a/arch/mips/include/asm/thread_info.h
+++ b/arch/mips/include/asm/thread_info.h
@@ -27,7 +27,6 @@ struct thread_info {
 	unsigned long		tp_value;	/* thread pointer */
 	__u32			cpu;		/* current CPU */
 	int			preempt_count;	/* 0 => preemptable, <0 => BUG */
-	int			r2_emul_return; /* 1 => Returning from R2 emulator */
 	mm_segment_t		addr_limit;	/*
 						 * thread address space limit:
 						 * 0x7fffffff for user-thead
diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index fae2f94..7af10d8 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -97,7 +97,6 @@ void output_thread_info_defines(void)
 	OFFSET(TI_TP_VALUE, thread_info, tp_value);
 	OFFSET(TI_CPU, thread_info, cpu);
 	OFFSET(TI_PRE_COUNT, thread_info, preempt_count);
-	OFFSET(TI_R2_EMUL_RET, thread_info, r2_emul_return);
 	OFFSET(TI_ADDR_LIMIT, thread_info, addr_limit);
 	OFFSET(TI_REGS, thread_info, regs);
 	DEFINE(_THREAD_SIZE, THREAD_SIZE);
diff --git a/arch/mips/kernel/entry.S b/arch/mips/kernel/entry.S
index 7791840..8d83fc2 100644
--- a/arch/mips/kernel/entry.S
+++ b/arch/mips/kernel/entry.S
@@ -47,11 +47,6 @@ resume_userspace:
 	local_irq_disable		# make sure we dont miss an
 					# interrupt setting need_resched
 					# between sampling and return
-#ifdef CONFIG_MIPSR2_TO_R6_EMULATOR
-	lw	k0, TI_R2_EMUL_RET($28)
-	bnez	k0, restore_all_from_r2_emul
-#endif
-
 	LONG_L	a2, TI_FLAGS($28)	# current->work
 	andi	t0, a2, _TIF_WORK_MASK	# (ignoring syscall_trace)
 	bnez	t0, work_pending
@@ -120,19 +115,6 @@ restore_partial:		# restore partial frame
 	RESTORE_SP_AND_RET
 	.set	at
 
-#ifdef CONFIG_MIPSR2_TO_R6_EMULATOR
-restore_all_from_r2_emul:			# restore full frame
-	.set	noat
-	sw	zero, TI_R2_EMUL_RET($28)	# reset it
-	RESTORE_TEMP
-	RESTORE_AT
-	RESTORE_STATIC
-	RESTORE_SOME
-	LONG_L	sp, PT_R29(sp)
-	eretnc
-	.set	at
-#endif
-
 work_pending:
 	andi	t0, a2, _TIF_NEED_RESCHED # a2 is preloaded with TI_FLAGS
 	beqz	t0, work_notifysig
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 1f5fdee..bb7a8a1 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1098,7 +1098,6 @@ asmlinkage void do_ri(struct pt_regs *regs)
 		switch (status) {
 		case 0:
 		case SIGEMT:
-			task_thread_info(current)->r2_emul_return = 1;
 			return;
 		case SIGILL:
 			goto no_r2_instr;
@@ -1106,7 +1105,6 @@ asmlinkage void do_ri(struct pt_regs *regs)
 			process_fpemu_return(status,
 					     &current->thread.cp0_baduaddr,
 					     fcr31);
-			task_thread_info(current)->r2_emul_return = 1;
 			return;
 		}
 	}
-- 
2.10.0
