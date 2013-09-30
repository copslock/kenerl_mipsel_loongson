Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Sep 2013 16:23:40 +0200 (CEST)
Received: from smtp24.services.sfr.fr ([93.17.128.82]:61336 "EHLO
        smtp24.services.sfr.fr" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823120Ab3I3OXeQxkAC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Sep 2013 16:23:34 +0200
Received: from filter.sfr.fr (localhost [127.0.0.1])
        by msfrf2414.sfr.fr (SMTP Server) with ESMTP id 4B62E70001F4;
        Mon, 30 Sep 2013 16:23:28 +0200 (CEST)
Received: from zohar.zauron.net (21.67.64.86.rev.sfr.net [86.64.67.21])
        by msfrf2414.sfr.fr (SMTP Server) with ESMTP id E94F47000197;
        Mon, 30 Sep 2013 16:23:27 +0200 (CEST)
X-SFR-UUID: 20130930142327955.E94F47000197@msfrf2414.sfr.fr
From:   Tanguy Bouzeloc <tanguy.bouzeloc@efixo.com>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org,
        Tanguy Bouzeloc <tanguy.bouzeloc@efixo.com>
Subject: [PATCH] MIPS: fix forced successful syscalls
Date:   Mon, 30 Sep 2013 16:22:49 +0200
Message-Id: <1380550969-9522-1-git-send-email-tanguy.bouzeloc@efixo.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Return-Path: <tanguy.bouzeloc@efixo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38065
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tanguy.bouzeloc@efixo.com
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

On mips any syscalls who return a value between -MAXERRNO (1133) and
-1, is considered as an error (the error flag is set and return value
is the positive value of the error number).

But some syscalls can return values between -MAXERRNO and -1 like
sys_time and sys_times. In this case the userspace return value is
-return value of the syscall and the error flag set.

This patch add a TIF_NOERROR thread flag which indicates that the
return value of a syscall is always correct.

All ABIs are updated (kernel 32 o32, kernel64 o32, kernel64 n32
and kernel64 n64).
---
 arch/mips/include/asm/ptrace.h      |  5 +++++
 arch/mips/include/asm/thread_info.h |  2 ++
 arch/mips/kernel/scall32-o32.S      | 14 ++++++++++++++
 arch/mips/kernel/scall64-64.S       | 14 ++++++++++++++
 arch/mips/kernel/scall64-n32.S      | 14 ++++++++++++++
 arch/mips/kernel/scall64-o32.S      | 14 ++++++++++++++
 6 files changed, 63 insertions(+)

diff --git a/arch/mips/include/asm/ptrace.h b/arch/mips/include/asm/ptrace.h
index 5e6cd09..51552f2 100644
--- a/arch/mips/include/asm/ptrace.h
+++ b/arch/mips/include/asm/ptrace.h
@@ -94,6 +94,11 @@ static inline void die_if_kernel(const char *str, struct pt_regs *regs)
 		die(str, regs);
 }
 
+#define force_successful_syscall_return()   \
+	do { \
+		set_thread_flag(TIF_NOERROR); \
+	} while(0)
+
 #define current_pt_regs()						\
 ({									\
 	unsigned long sp = (unsigned long)__builtin_frame_address(0);	\
diff --git a/arch/mips/include/asm/thread_info.h b/arch/mips/include/asm/thread_info.h
index 61215a3..6764fc1 100644
--- a/arch/mips/include/asm/thread_info.h
+++ b/arch/mips/include/asm/thread_info.h
@@ -116,6 +116,7 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_32BIT_ADDR		23	/* 32-bit address space (o32/n32) */
 #define TIF_FPUBOUND		24	/* thread bound to FPU-full CPU set */
 #define TIF_LOAD_WATCH		25	/* If set, load watch registers */
+#define TIF_NOERROR		30	/* Force successful syscall return */
 #define TIF_SYSCALL_TRACE	31	/* syscall trace active */
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
@@ -131,6 +132,7 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_32BIT_REGS		(1<<TIF_32BIT_REGS)
 #define _TIF_32BIT_ADDR		(1<<TIF_32BIT_ADDR)
 #define _TIF_FPUBOUND		(1<<TIF_FPUBOUND)
+#define _TIF_NOERROR		(1<<TIF_NOERROR)
 #define _TIF_LOAD_WATCH		(1<<TIF_LOAD_WATCH)
 
 #define _TIF_WORK_SYSCALL_ENTRY	(_TIF_NOHZ | _TIF_SYSCALL_TRACE |	\
diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index e774bb1..4ac30ac 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -58,8 +58,22 @@ stack_done:
 
 	jalr	t2			# Do The Real Thing (TM)
 
+	li	t0, 0			# no error for negative return ?
+	lw	t2, TI_FLAGS($28)
+	li	t1, _TIF_NOERROR
+	and	t2, t1
+	bnez	t2, syscall_ret_noerror
+
 	li	t0, -EMAXERRNO - 1	# error?
 	sltu	t0, t0, v0
+	b	syscall_ret_error
+
+syscall_ret_noerror:
+	li	t1, ~_TIF_NOERROR	# clear TIF_NOERROR
+	and	t2, t1
+	sw	t2, TI_FLAGS($28)
+
+syscall_ret_error:
 	sw	t0, PT_R7(sp)		# set error flag
 	beqz	t0, 1f
 
diff --git a/arch/mips/kernel/scall64-64.S b/arch/mips/kernel/scall64-64.S
index be6627e..793ba7e 100644
--- a/arch/mips/kernel/scall64-64.S
+++ b/arch/mips/kernel/scall64-64.S
@@ -61,8 +61,22 @@ NESTED(handle_sys64, PT_SIZE, sp)
 
 	jalr	t2			# Do The Real Thing (TM)
 
+	li	t0, 0			# no error for negative return ?
+	LONG_L	t2, TI_FLAGS($28)
+	li	t1, _TIF_NOERROR
+	and	t2, t1
+	bnez	t2, syscall_ret_noerror
+
 	li	t0, -EMAXERRNO - 1	# error?
 	sltu	t0, t0, v0
+	b	syscall_ret_error
+
+syscall_ret_noerror:
+	li	t1, ~_TIF_NOERROR	# clear TIF_NOERROR
+	and	t2, t1
+	LONG_S	t2, TI_FLAGS($28)
+
+syscall_ret_error:
 	sd	t0, PT_R7(sp)		# set error flag
 	beqz	t0, 1f
 
diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
index cab1507..ccac0c6 100644
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -54,8 +54,22 @@ NESTED(handle_sysn32, PT_SIZE, sp)
 
 	jalr	t2			# Do The Real Thing (TM)
 
+	li	t0, 0			# no error for negative return ?
+	LONG_L	t2, TI_FLAGS($28)
+	li	t1, _TIF_NOERROR
+	and	t2, t1
+	bnez	t2, syscall_ret_noerror
+
 	li	t0, -EMAXERRNO - 1	# error?
 	sltu	t0, t0, v0
+	b	syscall_ret_error
+
+syscall_ret_noerror:
+	li	t1, ~_TIF_NOERROR	# clear TIF_NOERROR
+	and	t2, t1
+	LONG_S	t2, TI_FLAGS($28)
+
+syscall_ret_error:
 	sd	t0, PT_R7(sp)		# set error flag
 	beqz	t0, 1f
 
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index 37605dc..b1d3d51 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -88,8 +88,22 @@ NESTED(handle_sys, PT_SIZE, sp)
 
 	jalr	t2			# Do The Real Thing (TM)
 
+	li	t0, 0			# no error for negative return ?
+	LONG_L	t2, TI_FLAGS($28)
+	li	t1, _TIF_NOERROR
+	and	t2, t1
+	bnez	t2, syscall_ret_noerror
+
 	li	t0, -EMAXERRNO - 1	# error?
 	sltu	t0, t0, v0
+	b	syscall_ret_error
+
+syscall_ret_noerror:
+	li	t1, ~_TIF_NOERROR	# clear TIF_NOERROR
+	and	t2, t1
+	LONG_S	t2, TI_FLAGS($28)
+
+syscall_ret_error:
 	sd	t0, PT_R7(sp)		# set error flag
 	beqz	t0, 1f
 
-- 
1.8.3.1
