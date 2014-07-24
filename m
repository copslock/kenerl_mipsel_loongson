Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Jul 2014 13:10:54 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:58150 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6842568AbaGXLKWF0Pd0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Jul 2014 13:10:22 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id D2538267655A3
        for <linux-mips@linux-mips.org>; Thu, 24 Jul 2014 12:10:12 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 24 Jul 2014 12:10:15 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.158) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 24 Jul 2014 12:10:14 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 2/2] MIPS: scall64-o32: Fix indirect syscall detection
Date:   Thu, 24 Jul 2014 12:10:02 +0100
Message-ID: <1406200202-10104-3-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.0.2
In-Reply-To: <1406200202-10104-1-git-send-email-markos.chandras@imgtec.com>
References: <1406200202-10104-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.158]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41563
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

commit 4c21b8fd8f146a22e1eaf92833a32e51f560e82a
"MIPS: seccomp: Handle indirect system calls (o32)"

added indirect syscall detection for O32 processes running on MIPS64
but it did not work as expected. The reason is the the scall64-o32
implementation differs compared to scall32-o32. In the former, the v0
(syscall number) register contains the absolute syscall number
(4000 + X) whereas in the latter it contains the relative syscall
number (X). Fix the code to avoid doing an extra addition, and load
the v0 register directly to the first argument for syscall_trace_enter.
Moreover, set the .reorder assembler option in order to have better
control on this part of the assembly code.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/kernel/scall64-o32.S | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index f1343ccd7ed7..7f5feb25ae04 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -113,15 +113,19 @@ trace_a_syscall:
 	move	s0, t2			# Save syscall pointer
 	move	a0, sp
 	/*
-	 * syscall number is in v0 unless we called syscall(__NR_###)
+	 * absolute syscall number is in v0 unless we called syscall(__NR_###)
 	 * where the real syscall number is in a0
 	 * note: NR_syscall is the first O32 syscall but the macro is
 	 * only defined when compiling with -mabi=32 (CONFIG_32BIT)
 	 * therefore __NR_O32_Linux is used (4000)
 	 */
-	addiu	a1, v0,  __NR_O32_Linux
-	bnez	v0, 1f /* __NR_syscall at offset 0 */
-	lw	a1, PT_R4(sp)
+	.set	push
+	.set	reorder
+	subu	t1, v0,  __NR_O32_Linux
+	move	a1, v0
+	bnez	t1, 1f /* __NR_syscall at offset 0 */
+	lw	a1, PT_R4(sp) /* Arg1 for __NR_syscall case */
+	.set	pop
 
 1:	jal	syscall_trace_enter
 
-- 
2.0.2
