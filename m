Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Feb 2014 15:49:51 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:13491 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6869250AbaBQOtrfBdUG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 17 Feb 2014 15:49:47 +0100
From:   Alex Smith <alex.smith@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Alex Smith <alex.smith@imgtec.com>, <linux-mips@linux-mips.org>,
        <stable@vger.kernel.org [3.13]>
Subject: [PATCH] MIPS: O32/32-bit: Fix bug which can cause incorrect system call restarts
Date:   Mon, 17 Feb 2014 14:49:17 +0000
Message-ID: <1392648557-7174-1-git-send-email-alex.smith@imgtec.com>
X-Mailer: git-send-email 1.8.5.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.76]
X-SEF-Processed: 7_3_0_01192__2014_02_17_14_49_40
Return-Path: <Alex.Smith@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39333
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex.smith@imgtec.com
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

On 32-bit/O32, pt_regs has a padding area at the beginning into which the
syscall arguments passed via the user stack are copied. 4 arguments
totalling 16 bytes are copied to offset 16 bytes into this area, however
the area is only 24 bytes long. This means the last 2 arguments overwrite
pt_regs->regs[{0,1}].

If a syscall function returns an error, handle_sys stores the original
syscall number in pt_regs->regs[0] for syscall restart. signal.c checks
whether regs[0] is non-zero, if it is it will check whether the syscall
return value is one of the ERESTART* codes to see if it must be
restarted.

Should a syscall be made that results in a non-zero value being copied
off the user stack into regs[0], and then returns a positive (non-error)
value that matches one of the ERESTART* error codes, this can be mistaken
for requiring a syscall restart.

While the possibility for this to occur has always existed, it is made
much more likely to occur by commit 46e12c07b3b9 ("MIPS: O32 / 32-bit:
Always copy 4 stack arguments."), since now every syscall will copy 4
arguments and overwrite regs[0], rather than just those with 7 or 8
arguments.

Since that commit, booting Debian under a 32-bit MIPS kernel almost
always results in a hang early in boot, due to a wait4 syscall returning
a PID that matches one of the ERESTART* codes, which then causes an
incorrect restart of the syscall.

The problem is fixed by increasing the size of the padding area so that
arguments copied off the stack will not overwrite pt_regs->regs[{0,1}].
Also removed a comment in handle_sys which is no longer relevant after
the aforementioned commit.

Signed-off-by: Alex Smith <alex.smith@imgtec.com>
Reviewed-by: Markos Chandras <markos.chandras@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: stable@vger.kernel.org [3.13]
---
 arch/mips/include/asm/ptrace.h | 2 +-
 arch/mips/kernel/scall32-o32.S | 2 --
 arch/mips/kernel/smtc-asm.S    | 4 ++--
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/asm/ptrace.h b/arch/mips/include/asm/ptrace.h
index 7bba9da..6d019ca 100644
--- a/arch/mips/include/asm/ptrace.h
+++ b/arch/mips/include/asm/ptrace.h
@@ -23,7 +23,7 @@
 struct pt_regs {
 #ifdef CONFIG_32BIT
 	/* Pad bytes for argument save space on the stack. */
-	unsigned long pad0[6];
+	unsigned long pad0[8];
 #endif
 
 	/* Saved main processor registers. */
diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index a5b14f4..4220c2d 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -66,8 +66,6 @@ NESTED(handle_sys, PT_SIZE, sp)
 
 	/*
 	 * Ok, copy the args from the luser stack to the kernel stack.
-	 * t3 is the precomputed number of instruction bytes needed to
-	 * load or store arguments 6-8.
 	 */
 
 	.set    push
diff --git a/arch/mips/kernel/smtc-asm.S b/arch/mips/kernel/smtc-asm.S
index 2866863..c4f0cd9 100644
--- a/arch/mips/kernel/smtc-asm.S
+++ b/arch/mips/kernel/smtc-asm.S
@@ -43,8 +43,8 @@ CAN WE PROVE THAT WE WON'T DO THIS IF INTS DISABLED??
  * to invoke the scheduler and return as appropriate.
  */
 
-#define PT_PADSLOT4 (PT_R0-8)
-#define PT_PADSLOT5 (PT_R0-4)
+#define PT_PADSLOT4 (PT_R0-16)
+#define PT_PADSLOT5 (PT_R0-12)
 
 	.text
 	.align 5
-- 
1.8.5.4
