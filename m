Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Mar 2017 18:11:20 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:64991 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993302AbdCaQK3NCLOo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 31 Mar 2017 18:10:29 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 31782A5E0F71F;
        Fri, 31 Mar 2017 17:10:19 +0100 (IST)
Received: from LDT-J-COWGILL.le.imgtec.org (10.150.130.85) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 31 Mar 2017 17:10:22 +0100
From:   James Cowgill <James.Cowgill@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     <James.Cowgill@imgtec.com>
Subject: [PATCH 2/2] MIPS: Remove pt_regs adjustments in indirect syscall handler
Date:   Fri, 31 Mar 2017 17:09:59 +0100
Message-ID: <20170331160959.3192-3-James.Cowgill@imgtec.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170331160959.3192-1-James.Cowgill@imgtec.com>
References: <20170331160959.3192-1-James.Cowgill@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.85]
Return-Path: <James.Cowgill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57517
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: James.Cowgill@imgtec.com
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

If a restartable syscall is called using the indirect o32 syscall
handler - eg: syscall(__NR_waitid, ...), then it is possible for the
incorrect arguments to be passed to the syscall after it has been
restarted. This is because the syscall handler tries to shift all the
registers down one place in pt_regs so that when the syscall is restarted,
the "real" syscall is called instead. Unfortunately it only shifts the
arguments passed in registers, not the arguments on the user stack. This
causes the 4th argument to be duplicated when the syscall is restarted.

Fix by removing all the pt_regs shifting so that the indirect syscall
handler is called again when the syscall is restarted. The comment "some
syscalls like execve get their arguments from struct pt_regs" is long
out of date so this should now be safe.

Signed-off-by: James Cowgill <James.Cowgill@imgtec.com>
---
 arch/mips/kernel/scall32-o32.S | 11 -----------
 arch/mips/kernel/scall64-o32.S |  6 ------
 2 files changed, 17 deletions(-)

diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index c29d397eee86..d8d6336c4cc5 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -190,12 +190,6 @@ illegal_syscall:
 	sll	t1, t0, 2
 	beqz	v0, einval
 	lw	t2, sys_call_table(t1)		# syscall routine
-	sw	a0, PT_R2(sp)			# call routine directly on restart
-
-	/* Some syscalls like execve get their arguments from struct pt_regs
-	   and claim zero arguments in the syscall table. Thus we have to
-	   assume the worst case and shuffle around all potential arguments.
-	   If you want performance, don't use indirect syscalls. */
 
 	move	a0, a1				# shift argument registers
 	move	a1, a2
@@ -207,11 +201,6 @@ illegal_syscall:
 	sw	t4, 16(sp)
 	sw	t5, 20(sp)
 	sw	t6, 24(sp)
-	sw	a0, PT_R4(sp)			# .. and push back a0 - a3, some
-	sw	a1, PT_R5(sp)			# syscalls expect them there
-	sw	a2, PT_R6(sp)
-	sw	a3, PT_R7(sp)
-	sw	a3, PT_R26(sp)			# update a3 for syscall restarting
 	jr	t2
 	/* Unreached */
 
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index 5a47042dd25f..6fd8ecca89e7 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -198,7 +198,6 @@ LEAF(sys32_syscall)
 	dsll	t1, t0, 3
 	beqz	v0, einval
 	ld	t2, sys32_call_table(t1)		# syscall routine
-	sd	a0, PT_R2(sp)		# call routine directly on restart
 
 	move	a0, a1			# shift argument registers
 	move	a1, a2
@@ -207,11 +206,6 @@ LEAF(sys32_syscall)
 	move	a4, a5
 	move	a5, a6
 	move	a6, a7
-	sd	a0, PT_R4(sp)		# ... and push back a0 - a3, some
-	sd	a1, PT_R5(sp)		# syscalls expect them there
-	sd	a2, PT_R6(sp)
-	sd	a3, PT_R7(sp)
-	sd	a3, PT_R26(sp)		# update a3 for syscall restarting
 	jr	t2
 	/* Unreached */
 
-- 
2.11.0
