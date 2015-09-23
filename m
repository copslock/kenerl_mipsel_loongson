Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Sep 2015 10:08:11 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:23419 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007449AbbIWIIJvxCcQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Sep 2015 10:08:09 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 298B5548D7C31
        for <linux-mips@linux-mips.org>; Wed, 23 Sep 2015 09:08:01 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 23 Sep 2015 09:08:02 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.88) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 23 Sep 2015 09:08:02 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
Subject: [PATCH] MIPS: kernel: scall: Always run the seccomp syscall filters
Date:   Wed, 23 Sep 2015 09:07:57 +0100
Message-ID: <1442995677-20591-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.5.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.88]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49337
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

The MIPS syscall handler code used to return -ENOSYS on invalid
syscalls. Whilst this is expected, it caused problems for seccomp
filters because the said filters never had the chance to run since
the code returned -ENOSYS before triggering them. This caused
problems on the chromium testsuite for filters looking for invalid
syscalls. This has now changed and the seccomp filters are always
run even if the syscall is invalid. We return -ENOSYS once we
return from the seccomp filters. Moreover, similar codepath have
been merged in the process which simplifies somewhat the overall
syscall code.

Cc: <stable@vger.kernel.org> # v3.15+
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/kernel/scall32-o32.S | 39 ++++++++++++++++-----------------------
 arch/mips/kernel/scall64-64.S  | 38 ++++++++++++++++----------------------
 arch/mips/kernel/scall64-n32.S | 19 +++++--------------
 arch/mips/kernel/scall64-o32.S | 19 +++++--------------
 4 files changed, 42 insertions(+), 73 deletions(-)

diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index 4cc13508d967..aa2df3e8dba2 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -36,16 +36,8 @@ NESTED(handle_sys, PT_SIZE, sp)
 	lw	t1, PT_EPC(sp)		# skip syscall on return
 
 	subu	v0, v0, __NR_O32_Linux	# check syscall number
-	sltiu	t0, v0, __NR_O32_Linux_syscalls + 1
 	addiu	t1, 4			# skip to next instruction
 	sw	t1, PT_EPC(sp)
-	beqz	t0, illegal_syscall
-
-	sll	t0, v0, 2
-	la	t1, sys_call_table
-	addu	t1, t0
-	lw	t2, (t1)		# syscall routine
-	beqz	t2, illegal_syscall
 
 	sw	a3, PT_R26(sp)		# save a3 for syscall restarting
 
@@ -96,6 +88,16 @@ loads_done:
 	li	t1, _TIF_WORK_SYSCALL_ENTRY
 	and	t0, t1
 	bnez	t0, syscall_trace_entry # -> yes
+syscall_common:
+	sltiu	t0, v0, __NR_O32_Linux_syscalls + 1
+	beqz	t0, illegal_syscall
+
+	sll	t0, v0, 2
+	la	t1, sys_call_table
+	addu	t1, t0
+	lw	t2, (t1)		# syscall routine
+
+	beqz	t2, illegal_syscall
 
 	jalr	t2			# Do The Real Thing (TM)
 
@@ -116,7 +118,7 @@ o32_syscall_exit:
 
 syscall_trace_entry:
 	SAVE_STATIC
-	move	s0, t2
+	move	s0, v0
 	move	a0, sp
 
 	/*
@@ -129,27 +131,18 @@ syscall_trace_entry:
 
 1:	jal	syscall_trace_enter
 
-	bltz	v0, 2f			# seccomp failed? Skip syscall
+	bltz	v0, 1f			# seccomp failed? Skip syscall
+
+	move	v0, s0			# restore syscall
 
-	move	t0, s0
 	RESTORE_STATIC
 	lw	a0, PT_R4(sp)		# Restore argument registers
 	lw	a1, PT_R5(sp)
 	lw	a2, PT_R6(sp)
 	lw	a3, PT_R7(sp)
-	jalr	t0
-
-	li	t0, -EMAXERRNO - 1	# error?
-	sltu	t0, t0, v0
-	sw	t0, PT_R7(sp)		# set error flag
-	beqz	t0, 1f
-
-	lw	t1, PT_R2(sp)		# syscall number
-	negu	v0			# error
-	sw	t1, PT_R0(sp)		# save it for syscall restarting
-1:	sw	v0, PT_R2(sp)		# result
+	j	syscall_common
 
-2:	j	syscall_exit
+1:	j	syscall_exit
 
 /* ------------------------------------------------------------------------ */
 
diff --git a/arch/mips/kernel/scall64-64.S b/arch/mips/kernel/scall64-64.S
index a6f6b762c47a..59e754e6241e 100644
--- a/arch/mips/kernel/scall64-64.S
+++ b/arch/mips/kernel/scall64-64.S
@@ -39,18 +39,11 @@ NESTED(handle_sys64, PT_SIZE, sp)
 	.set	at
 #endif
 
-	dsubu	t0, v0, __NR_64_Linux	# check syscall number
-	sltiu	t0, t0, __NR_64_Linux_syscalls + 1
 #if !defined(CONFIG_MIPS32_O32) && !defined(CONFIG_MIPS32_N32)
 	ld	t1, PT_EPC(sp)		# skip syscall on return
 	daddiu	t1, 4			# skip to next instruction
 	sd	t1, PT_EPC(sp)
 #endif
-	beqz	t0, illegal_syscall
-
-	dsll	t0, v0, 3		# offset into table
-	ld	t2, (sys_call_table - (__NR_64_Linux * 8))(t0)
-					# syscall routine
 
 	sd	a3, PT_R26(sp)		# save a3 for syscall restarting
 
@@ -59,6 +52,17 @@ NESTED(handle_sys64, PT_SIZE, sp)
 	and	t0, t1, t0
 	bnez	t0, syscall_trace_entry
 
+syscall_common:
+	dsubu	t2, v0, __NR_64_Linux
+	sltiu   t0, t2, __NR_64_Linux_syscalls + 1
+	beqz	t0, illegal_syscall
+
+	dsll	t0, t2, 3		# offset into table
+	dla	t2, sys_call_table
+	daddu	t2, t0
+	ld	t2, (t0)		# syscall routine
+	beqz	t2, illegal_syscall
+
 	jalr	t2			# Do The Real Thing (TM)
 
 	li	t0, -EMAXERRNO - 1	# error?
@@ -78,14 +82,14 @@ n64_syscall_exit:
 
 syscall_trace_entry:
 	SAVE_STATIC
-	move	s0, t2
+	move	s0, v0
 	move	a0, sp
 	move	a1, v0
 	jal	syscall_trace_enter
 
-	bltz	v0, 2f			# seccomp failed? Skip syscall
+	bltz	v0, 1f			# seccomp failed? Skip syscall
 
-	move	t0, s0
+	move	v0, s0
 	RESTORE_STATIC
 	ld	a0, PT_R4(sp)		# Restore argument registers
 	ld	a1, PT_R5(sp)
@@ -93,19 +97,9 @@ syscall_trace_entry:
 	ld	a3, PT_R7(sp)
 	ld	a4, PT_R8(sp)
 	ld	a5, PT_R9(sp)
-	jalr	t0
-
-	li	t0, -EMAXERRNO - 1	# error?
-	sltu	t0, t0, v0
-	sd	t0, PT_R7(sp)		# set error flag
-	beqz	t0, 1f
-
-	ld	t1, PT_R2(sp)		# syscall number
-	dnegu	v0			# error
-	sd	t1, PT_R0(sp)		# save it for syscall restarting
-1:	sd	v0, PT_R2(sp)		# result
+	j	syscall_common
 
-2:	j	syscall_exit
+1:	j	syscall_exit
 
 illegal_syscall:
 	/* This also isn't a 64-bit syscall, throw an error.  */
diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
index 4b2010654c46..8680b92fb6aa 100644
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -52,6 +52,7 @@ NESTED(handle_sysn32, PT_SIZE, sp)
 	and	t0, t1, t0
 	bnez	t0, n32_syscall_trace_entry
 
+syscall_common:
 	jalr	t2			# Do The Real Thing (TM)
 
 	li	t0, -EMAXERRNO - 1	# error?
@@ -75,9 +76,9 @@ n32_syscall_trace_entry:
 	move	a1, v0
 	jal	syscall_trace_enter
 
-	bltz	v0, 2f			# seccomp failed? Skip syscall
+	bltz	v0, 1f			# seccomp failed? Skip syscall
 
-	move	t0, s0
+	move	t2, s0
 	RESTORE_STATIC
 	ld	a0, PT_R4(sp)		# Restore argument registers
 	ld	a1, PT_R5(sp)
@@ -85,19 +86,9 @@ n32_syscall_trace_entry:
 	ld	a3, PT_R7(sp)
 	ld	a4, PT_R8(sp)
 	ld	a5, PT_R9(sp)
-	jalr	t0
+	j	syscall_common
 
-	li	t0, -EMAXERRNO - 1	# error?
-	sltu	t0, t0, v0
-	sd	t0, PT_R7(sp)		# set error flag
-	beqz	t0, 1f
-
-	ld	t1, PT_R2(sp)		# syscall number
-	dnegu	v0			# error
-	sd	t1, PT_R0(sp)		# save it for syscall restarting
-1:	sd	v0, PT_R2(sp)		# result
-
-2:	j	syscall_exit
+1:	j	syscall_exit
 
 not_n32_scall:
 	/* This is not an n32 compatibility syscall, pass it on to
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index f543ff4feef9..0fe902ec01ff 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -87,6 +87,7 @@ loads_done:
 	and	t0, t1, t0
 	bnez	t0, trace_a_syscall
 
+syscall_common:
 	jalr	t2			# Do The Real Thing (TM)
 
 	li	t0, -EMAXERRNO - 1	# error?
@@ -130,9 +131,9 @@ trace_a_syscall:
 
 1:	jal	syscall_trace_enter
 
-	bltz	v0, 2f			# seccomp failed? Skip syscall
+	bltz	v0, 1f			# seccomp failed? Skip syscall
 
-	move	t0, s0
+	move	t2, s0
 	RESTORE_STATIC
 	ld	a0, PT_R4(sp)		# Restore argument registers
 	ld	a1, PT_R5(sp)
@@ -142,19 +143,9 @@ trace_a_syscall:
 	ld	a5, PT_R9(sp)
 	ld	a6, PT_R10(sp)
 	ld	a7, PT_R11(sp)		# For indirect syscalls
-	jalr	t0
+	j	syscall_common
 
-	li	t0, -EMAXERRNO - 1	# error?
-	sltu	t0, t0, v0
-	sd	t0, PT_R7(sp)		# set error flag
-	beqz	t0, 1f
-
-	ld	t1, PT_R2(sp)		# syscall number
-	dnegu	v0			# error
-	sd	t1, PT_R0(sp)		# save it for syscall restarting
-1:	sd	v0, PT_R2(sp)		# result
-
-2:	j	syscall_exit
+1:	j	syscall_exit
 
 /* ------------------------------------------------------------------------ */
 
-- 
2.5.2
