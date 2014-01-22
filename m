Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Jan 2014 15:43:26 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:24638 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6870556AbaAVOl4waju8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 22 Jan 2014 15:41:56 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 6/8] MIPS: kernel: scalls: Skip the syscall if denied by the seccomp filter
Date:   Wed, 22 Jan 2014 14:40:02 +0000
Message-ID: <1390401604-11830-7-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1390401604-11830-1-git-send-email-markos.chandras@imgtec.com>
References: <1390401604-11830-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.47]
X-SEF-Processed: 7_3_0_01192__2014_01_22_14_40_39
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39057
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

Reviewed-by: Paul Burton <paul.burton@imgtec.com>
Reviewed-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/kernel/scall32-o32.S | 4 +++-
 arch/mips/kernel/scall64-64.S  | 4 +++-
 arch/mips/kernel/scall64-n32.S | 4 +++-
 arch/mips/kernel/scall64-o32.S | 4 +++-
 4 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index e8e541b..ce6a1cc 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -120,6 +120,8 @@ syscall_trace_entry:
 	move	a0, sp
 	jal	syscall_trace_enter
 
+	bltz	v0, 2f			# seccomp failed? Skip syscall
+
 	move	t0, s0
 	RESTORE_STATIC
 	lw	a0, PT_R4(sp)		# Restore argument registers
@@ -138,7 +140,7 @@ syscall_trace_entry:
 	sw	t1, PT_R0(sp)		# save it for syscall restarting
 1:	sw	v0, PT_R2(sp)		# result
 
-	j	syscall_exit
+2:	j	syscall_exit
 
 /* ------------------------------------------------------------------------ */
 
diff --git a/arch/mips/kernel/scall64-64.S b/arch/mips/kernel/scall64-64.S
index 57e3742..88372a1 100644
--- a/arch/mips/kernel/scall64-64.S
+++ b/arch/mips/kernel/scall64-64.S
@@ -82,6 +82,8 @@ syscall_trace_entry:
 	move	a0, sp
 	jal	syscall_trace_enter
 
+	bltz	v0, 2f			# seccomp failed? Skip syscall
+
 	move	t0, s0
 	RESTORE_STATIC
 	ld	a0, PT_R4(sp)		# Restore argument registers
@@ -102,7 +104,7 @@ syscall_trace_entry:
 	sd	t1, PT_R0(sp)		# save it for syscall restarting
 1:	sd	v0, PT_R2(sp)		# result
 
-	j	syscall_exit
+2:	j	syscall_exit
 
 illegal_syscall:
 	/* This also isn't a 64-bit syscall, throw an error.  */
diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
index 2f48f59..d79d880 100644
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -74,6 +74,8 @@ n32_syscall_trace_entry:
 	move	a0, sp
 	jal	syscall_trace_enter
 
+	bltz	v0, 2f			# seccomp failed? Skip syscall
+
 	move	t0, s0
 	RESTORE_STATIC
 	ld	a0, PT_R4(sp)		# Restore argument registers
@@ -94,7 +96,7 @@ n32_syscall_trace_entry:
 	sd	t1, PT_R0(sp)		# save it for syscall restarting
 1:	sd	v0, PT_R2(sp)		# result
 
-	j	syscall_exit
+2:	j	syscall_exit
 
 not_n32_scall:
 	/* This is not an n32 compatibility syscall, pass it on to
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index f1acdb4..375a72b 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -114,6 +114,8 @@ trace_a_syscall:
 	move	a0, sp
 	jal	syscall_trace_enter
 
+	bltz	v0, 2f			# seccomp failed? Skip syscall
+
 	move	t0, s0
 	RESTORE_STATIC
 	ld	a0, PT_R4(sp)		# Restore argument registers
@@ -136,7 +138,7 @@ trace_a_syscall:
 	sd	t1, PT_R0(sp)		# save it for syscall restarting
 1:	sd	v0, PT_R2(sp)		# result
 
-	j	syscall_exit
+2:	j	syscall_exit
 
 /* ------------------------------------------------------------------------ */
 
-- 
1.8.5.3
