Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 21:24:38 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:43578 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827347AbaA0UW04nCRC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jan 2014 21:22:26 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 13/58] MIPS: lib: strlen_user: Add EVA support
Date:   Mon, 27 Jan 2014 20:19:00 +0000
Message-ID: <1390853985-14246-14-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
References: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.47]
X-SEF-Processed: 7_3_0_01192__2014_01_27_20_22_22
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39131
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

In non-EVA mode, strlen_user* aliases are used for the
strlen_kernel* symbols since the code is identical. In EVA
mode, new strlen_user* symbols are used which use the EVA
specific instructions to load values from userspace.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/kernel/mips_ksyms.c |  4 ++++
 arch/mips/lib/strlen_user.S   | 20 ++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/mips/kernel/mips_ksyms.c b/arch/mips/kernel/mips_ksyms.c
index a322db0..742ed7d 100644
--- a/arch/mips/kernel/mips_ksyms.c
+++ b/arch/mips/kernel/mips_ksyms.c
@@ -20,6 +20,8 @@ extern long __strncpy_from_user_nocheck_asm(char *__to,
 					    const char *__from, long __len);
 extern long __strncpy_from_user_asm(char *__to, const char *__from,
 				    long __len);
+extern long __strlen_kernel_nocheck_asm(const char *s);
+extern long __strlen_kernel_asm(const char *s);
 extern long __strlen_user_nocheck_asm(const char *s);
 extern long __strlen_user_asm(const char *s);
 extern long __strnlen_kernel_nocheck_asm(const char *s);
@@ -48,6 +50,8 @@ EXPORT_SYMBOL(__copy_user_inatomic);
 EXPORT_SYMBOL(__bzero);
 EXPORT_SYMBOL(__strncpy_from_user_nocheck_asm);
 EXPORT_SYMBOL(__strncpy_from_user_asm);
+EXPORT_SYMBOL(__strlen_kernel_nocheck_asm);
+EXPORT_SYMBOL(__strlen_kernel_asm);
 EXPORT_SYMBOL(__strlen_user_nocheck_asm);
 EXPORT_SYMBOL(__strlen_user_asm);
 EXPORT_SYMBOL(__strnlen_kernel_nocheck_asm);
diff --git a/arch/mips/lib/strlen_user.S b/arch/mips/lib/strlen_user.S
index 6e8bdb3..bef65c9 100644
--- a/arch/mips/lib/strlen_user.S
+++ b/arch/mips/lib/strlen_user.S
@@ -30,7 +30,11 @@ LEAF(__strlen_\func\()_asm)
 
 FEXPORT(__strlen_\func\()_nocheck_asm)
 	move		v0, a0
+.ifeqs "\func", "kernel"
 1:	EX(lbu, v1, (v0), .Lfault\@)
+.else
+1:	EX(lbue, v1, (v0), .Lfault\@)
+.endif
 	PTR_ADDIU	v0, 1
 	bnez		v1, 1b
 	PTR_SUBU	v0, a0
@@ -41,4 +45,20 @@ FEXPORT(__strlen_\func\()_nocheck_asm)
 	jr		ra
 	.endm
 
+#ifndef CONFIG_EVA
+	/* Set aliases */
+	.global __strlen_user_asm
+	.global __strlen_user_nocheck_asm
+	.set __strlen_user_asm, __strlen_kernel_asm
+	.set __strlen_user_nocheck_asm, __strlen_kernel_nocheck_asm
+#endif
+
+__BUILD_STRLEN_ASM kernel
+
+#ifdef CONFIG_EVA
+
+	.set push
+	.set eva
 __BUILD_STRLEN_ASM user
+	.set pop
+#endif
-- 
1.8.5.3
