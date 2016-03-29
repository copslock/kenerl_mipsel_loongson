Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Mar 2016 10:36:37 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:55829 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27025085AbcC2If6GO1yk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Mar 2016 10:35:58 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id B5F8B782E51E7;
        Tue, 29 Mar 2016 09:35:49 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Tue, 29 Mar 2016 09:35:51 +0100
Received: from mredfearn-linux.kl.imgtec.org (192.168.154.116) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Tue, 29 Mar 2016 09:35:50 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     <IMG-MIPSLinuxKerneldevelopers@imgtec.com>
CC:     Matt Redfearn <matt.redfearn@imgtec.com>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        Eric B Munson <emunson@akamai.com>,
        "James Hogan" <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Andrew Morton" <akpm@linux-foundation.org>
Subject: [PATCH v2 3/6] MIPS: scall: Handle seccomp filters which redirect syscalls
Date:   Tue, 29 Mar 2016 09:35:31 +0100
Message-ID: <1459240534-8658-4-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1459240534-8658-1-git-send-email-matt.redfearn@imgtec.com>
References: <1459240534-8658-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.116]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52723
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

Commit d218af78492a ("MIPS: scall: Always run the seccomp syscall
filters") modified the syscall code to always call the seccomp filters,
but missed the case where a filter may redirect the syscall, as
revealed by the seccomp_bpf self test.

The syscall path now restores the syscall from the stack after the
filter rather than saving it locally. Syscall number checking and
syscall function table lookup is done after the filter may have run such
that redirected syscalls are also checked, and executed.

The regular path of syscall number checking and pointer lookup is also
made more consistent between ABIs with scall64-64.S being the reference.

With this patch in place, the seccomp_bpf self test now passes
TRACE_syscall.syscall_redirected and TRACE_syscall.syscall_dropped on
all MIPS ABIs.

Fixes: d218af78492a ("MIPS: scall: Always run the seccomp syscall filters")
Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
Cc: linux-mips@linux-mips.org
---

Changes in v2: None

 arch/mips/kernel/scall32-o32.S | 11 +++++------
 arch/mips/kernel/scall64-64.S  |  3 +--
 arch/mips/kernel/scall64-n32.S | 14 +++++++++-----
 arch/mips/kernel/scall64-o32.S | 14 +++++++++-----
 4 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index a56317444bda..6c1b5e085f2d 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -35,7 +35,6 @@ NESTED(handle_sys, PT_SIZE, sp)
 
 	lw	t1, PT_EPC(sp)		# skip syscall on return
 
-	subu	v0, v0, __NR_O32_Linux	# check syscall number
 	addiu	t1, 4			# skip to next instruction
 	sw	t1, PT_EPC(sp)
 
@@ -89,6 +88,7 @@ loads_done:
 	and	t0, t1
 	bnez	t0, syscall_trace_entry # -> yes
 syscall_common:
+	subu	v0, v0, __NR_O32_Linux	# check syscall number
 	sltiu	t0, v0, __NR_O32_Linux_syscalls + 1
 	beqz	t0, illegal_syscall
 
@@ -118,24 +118,23 @@ o32_syscall_exit:
 
 syscall_trace_entry:
 	SAVE_STATIC
-	move	s0, v0
 	move	a0, sp
 
 	/*
 	 * syscall number is in v0 unless we called syscall(__NR_###)
 	 * where the real syscall number is in a0
 	 */
-	addiu	a1, v0,  __NR_O32_Linux
-	bnez	v0, 1f /* __NR_syscall at offset 0 */
+	move	a1, v0
+	subu	t2, v0,  __NR_O32_Linux
+	bnez	t2, 1f /* __NR_syscall at offset 0 */
 	lw	a1, PT_R4(sp)
 
 1:	jal	syscall_trace_enter
 
 	bltz	v0, 1f			# seccomp failed? Skip syscall
 
-	move	v0, s0			# restore syscall
-
 	RESTORE_STATIC
+	lw	v0, PT_R2(sp)		# Restore syscall (maybe modified)
 	lw	a0, PT_R4(sp)		# Restore argument registers
 	lw	a1, PT_R5(sp)
 	lw	a2, PT_R6(sp)
diff --git a/arch/mips/kernel/scall64-64.S b/arch/mips/kernel/scall64-64.S
index 2b2dc14610d0..ede49e35d6a6 100644
--- a/arch/mips/kernel/scall64-64.S
+++ b/arch/mips/kernel/scall64-64.S
@@ -82,15 +82,14 @@ n64_syscall_exit:
 
 syscall_trace_entry:
 	SAVE_STATIC
-	move	s0, v0
 	move	a0, sp
 	move	a1, v0
 	jal	syscall_trace_enter
 
 	bltz	v0, 1f			# seccomp failed? Skip syscall
 
-	move	v0, s0
 	RESTORE_STATIC
+	ld	v0, PT_R2(sp)		# Restore syscall (maybe modified)
 	ld	a0, PT_R4(sp)		# Restore argument registers
 	ld	a1, PT_R5(sp)
 	ld	a2, PT_R6(sp)
diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
index 2bf5c8593d91..f75a6e19b902 100644
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -42,9 +42,6 @@ NESTED(handle_sysn32, PT_SIZE, sp)
 #endif
 	beqz	t0, not_n32_scall
 
-	dsll	t0, v0, 3		# offset into table
-	ld	t2, (sysn32_call_table - (__NR_N32_Linux * 8))(t0)
-
 	sd	a3, PT_R26(sp)		# save a3 for syscall restarting
 
 	li	t1, _TIF_WORK_SYSCALL_ENTRY
@@ -53,6 +50,9 @@ NESTED(handle_sysn32, PT_SIZE, sp)
 	bnez	t0, n32_syscall_trace_entry
 
 syscall_common:
+	dsll	t0, v0, 3		# offset into table
+	ld	t2, (sysn32_call_table - (__NR_N32_Linux * 8))(t0)
+
 	jalr	t2			# Do The Real Thing (TM)
 
 	li	t0, -EMAXERRNO - 1	# error?
@@ -71,21 +71,25 @@ syscall_common:
 
 n32_syscall_trace_entry:
 	SAVE_STATIC
-	move	s0, t2
 	move	a0, sp
 	move	a1, v0
 	jal	syscall_trace_enter
 
 	bltz	v0, 1f			# seccomp failed? Skip syscall
 
-	move	t2, s0
 	RESTORE_STATIC
+	ld	v0, PT_R2(sp)		# Restore syscall (maybe modified)
 	ld	a0, PT_R4(sp)		# Restore argument registers
 	ld	a1, PT_R5(sp)
 	ld	a2, PT_R6(sp)
 	ld	a3, PT_R7(sp)
 	ld	a4, PT_R8(sp)
 	ld	a5, PT_R9(sp)
+
+	dsubu	t2, v0, __NR_N32_Linux	# check (new) syscall number
+	sltiu   t0, t2, __NR_N32_Linux_syscalls + 1
+	beqz	t0, not_n32_scall
+
 	j	syscall_common
 
 1:	j	syscall_exit
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index c5b759e584c7..db224e7b995c 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -52,9 +52,6 @@ NESTED(handle_sys, PT_SIZE, sp)
 	sll	a2, a2, 0
 	sll	a3, a3, 0
 
-	dsll	t0, v0, 3		# offset into table
-	ld	t2, (sys32_call_table - (__NR_O32_Linux * 8))(t0)
-
 	sd	a3, PT_R26(sp)		# save a3 for syscall restarting
 
 	/*
@@ -88,6 +85,9 @@ loads_done:
 	bnez	t0, trace_a_syscall
 
 syscall_common:
+	dsll	t0, v0, 3		# offset into table
+	ld	t2, (sys32_call_table - (__NR_O32_Linux * 8))(t0)
+
 	jalr	t2			# Do The Real Thing (TM)
 
 	li	t0, -EMAXERRNO - 1	# error?
@@ -112,7 +112,6 @@ trace_a_syscall:
 	sd	a6, PT_R10(sp)
 	sd	a7, PT_R11(sp)		# For indirect syscalls
 
-	move	s0, t2			# Save syscall pointer
 	move	a0, sp
 	/*
 	 * absolute syscall number is in v0 unless we called syscall(__NR_###)
@@ -133,8 +132,8 @@ trace_a_syscall:
 
 	bltz	v0, 1f			# seccomp failed? Skip syscall
 
-	move	t2, s0
 	RESTORE_STATIC
+	ld	v0, PT_R2(sp)		# Restore syscall (maybe modified)
 	ld	a0, PT_R4(sp)		# Restore argument registers
 	ld	a1, PT_R5(sp)
 	ld	a2, PT_R6(sp)
@@ -143,6 +142,11 @@ trace_a_syscall:
 	ld	a5, PT_R9(sp)
 	ld	a6, PT_R10(sp)
 	ld	a7, PT_R11(sp)		# For indirect syscalls
+
+	dsubu	t0, v0, __NR_O32_Linux	# check (new) syscall number
+	sltiu	t0, t0, __NR_O32_Linux_syscalls + 1
+	beqz	t0, not_o32_scall
+
 	j	syscall_common
 
 1:	j	syscall_exit
-- 
2.5.0
