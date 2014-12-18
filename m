Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2014 16:30:05 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:41632 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009216AbaLRPNk0fF8k (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Dec 2014 16:13:40 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 056F75D7A191B
        for <linux-mips@linux-mips.org>; Thu, 18 Dec 2014 15:13:31 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 18 Dec 2014 15:13:34 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.125) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 18 Dec 2014 15:13:32 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH RFC 64/67] MIPS: Make use of the ERETNC instruction on MIPS R6
Date:   Thu, 18 Dec 2014 15:10:13 +0000
Message-ID: <1418915416-3196-65-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.2.0
In-Reply-To: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com>
References: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.125]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44799
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

The ERETNC instruction, introduced in MIPS R5, is similar to the ERET
one, except it does not clear the LLB bit in the LLADDR register.
This feature is necessary to safely emulate R2 LL/SC instructions.
However, on context switches, we need to clear the LLAddr/LLB bit
in order to make sure that an SC instruction from the new thread
will never succeed if it happens to interrupt an LL operation on the
same address from the previous thread.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/switch_to.h   |  9 ++++++---
 arch/mips/include/asm/thread_info.h |  2 +-
 arch/mips/kernel/asm-offsets.c      |  1 +
 arch/mips/kernel/entry.S            | 18 ++++++++++++++++++
 arch/mips/kernel/traps.c            |  2 ++
 5 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/switch_to.h b/arch/mips/include/asm/switch_to.h
index b928b6f898cd..e92d6c4b5ed1 100644
--- a/arch/mips/include/asm/switch_to.h
+++ b/arch/mips/include/asm/switch_to.h
@@ -75,9 +75,12 @@ do {									\
 #endif
 
 #define __clear_software_ll_bit()					\
-do {									\
-	if (!__builtin_constant_p(cpu_has_llsc) || !cpu_has_llsc)	\
-		ll_bit = 0;						\
+do {	if (cpu_has_rw_llb) {						\
+		write_c0_lladdr(0);					\
+	} else {							\
+		if (!__builtin_constant_p(cpu_has_llsc) || !cpu_has_llsc)\
+			ll_bit = 0;					\
+	}								\
 } while (0)
 
 #define switch_to(prev, next, last)					\
diff --git a/arch/mips/include/asm/thread_info.h b/arch/mips/include/asm/thread_info.h
index 7de865805deb..ffdfb5b06e8b 100644
--- a/arch/mips/include/asm/thread_info.h
+++ b/arch/mips/include/asm/thread_info.h
@@ -28,7 +28,7 @@ struct thread_info {
 	unsigned long		tp_value;	/* thread pointer */
 	__u32			cpu;		/* current CPU */
 	int			preempt_count;	/* 0 => preemptable, <0 => BUG */
-
+	int			r2_emul_return; /* 1 => Returning from R2 emulator */
 	mm_segment_t		addr_limit;	/*
 						 * thread address space limit:
 						 * 0x7fffffff for user-thead
diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index b1d84bd4efb3..7b6c11aa1cae 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -97,6 +97,7 @@ void output_thread_info_defines(void)
 	OFFSET(TI_TP_VALUE, thread_info, tp_value);
 	OFFSET(TI_CPU, thread_info, cpu);
 	OFFSET(TI_PRE_COUNT, thread_info, preempt_count);
+	OFFSET(TI_R2_EMUL_RET, thread_info, r2_emul_return);
 	OFFSET(TI_ADDR_LIMIT, thread_info, addr_limit);
 	OFFSET(TI_RESTART_BLOCK, thread_info, restart_block);
 	OFFSET(TI_REGS, thread_info, regs);
diff --git a/arch/mips/kernel/entry.S b/arch/mips/kernel/entry.S
index d5ab21c3fd12..af41ba6db960 100644
--- a/arch/mips/kernel/entry.S
+++ b/arch/mips/kernel/entry.S
@@ -46,6 +46,11 @@ resume_userspace:
 	local_irq_disable		# make sure we dont miss an
 					# interrupt setting need_resched
 					# between sampling and return
+#ifdef CONFIG_MIPSR2_TO_R6_EMULATOR
+	lw	k0, TI_R2_EMUL_RET($28)
+	bnez	k0, restore_all_from_r2_emul
+#endif
+
 	LONG_L	a2, TI_FLAGS($28)	# current->work
 	andi	t0, a2, _TIF_WORK_MASK	# (ignoring syscall_trace)
 	bnez	t0, work_pending
@@ -114,6 +119,19 @@ restore_partial:		# restore partial frame
 	RESTORE_SP_AND_RET
 	.set	at
 
+#ifdef CONFIG_MIPSR2_TO_R6_EMULATOR
+restore_all_from_r2_emul:			# restore full frame
+	.set	noat
+	sw	zero, TI_R2_EMUL_RET($28)	# reset it
+	RESTORE_TEMP
+	RESTORE_AT
+	RESTORE_STATIC
+	RESTORE_SOME
+	LONG_L	sp, PT_R29(sp)
+	eretnc
+	.set	at
+#endif
+
 work_pending:
 	andi	t0, a2, _TIF_NEED_RESCHED # a2 is preloaded with TI_FLAGS
 	beqz	t0, work_notifysig
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index da0836574918..a0c4716c3c69 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -995,12 +995,14 @@ asmlinkage void do_ri(struct pt_regs *regs)
 			switch (status) {
 			case 0:
 			case SIGEMT:
+				task_thread_info(current)->r2_emul_return = 1;
 				return;
 			case SIGILL:
 				goto no_r2_instr;
 			default:
 				process_fpemu_return(status,
 						     &current->thread.cp0_baduaddr);
+				task_thread_info(current)->r2_emul_return = 1;
 				return;
 			}
 		}
-- 
2.2.0
