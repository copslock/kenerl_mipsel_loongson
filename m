Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 21:24:01 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:43575 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827340AbaA0UWQy782Y (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jan 2014 21:22:16 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 11/58] MIPS: lib: strnlen_user: Add EVA support
Date:   Mon, 27 Jan 2014 20:18:58 +0000
Message-ID: <1390853985-14246-12-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
References: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.47]
X-SEF-Processed: 7_3_0_01192__2014_01_27_20_22_12
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39129
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

In non-EVA mode, a strlen_user* alias is used for the
strlen_kernel* symbols since the code is identical. In EVA
mode, a new strlen_user* symbol is used which uses the EVA
specific instructions to load values from userspace.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/kernel/mips_ksyms.c |  4 ++++
 arch/mips/lib/strnlen_user.S  | 20 ++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/mips/kernel/mips_ksyms.c b/arch/mips/kernel/mips_ksyms.c
index 6e58e97..a322db0 100644
--- a/arch/mips/kernel/mips_ksyms.c
+++ b/arch/mips/kernel/mips_ksyms.c
@@ -22,6 +22,8 @@ extern long __strncpy_from_user_asm(char *__to, const char *__from,
 				    long __len);
 extern long __strlen_user_nocheck_asm(const char *s);
 extern long __strlen_user_asm(const char *s);
+extern long __strnlen_kernel_nocheck_asm(const char *s);
+extern long __strnlen_kernel_asm(const char *s);
 extern long __strnlen_user_nocheck_asm(const char *s);
 extern long __strnlen_user_asm(const char *s);
 
@@ -48,6 +50,8 @@ EXPORT_SYMBOL(__strncpy_from_user_nocheck_asm);
 EXPORT_SYMBOL(__strncpy_from_user_asm);
 EXPORT_SYMBOL(__strlen_user_nocheck_asm);
 EXPORT_SYMBOL(__strlen_user_asm);
+EXPORT_SYMBOL(__strnlen_kernel_nocheck_asm);
+EXPORT_SYMBOL(__strnlen_kernel_asm);
 EXPORT_SYMBOL(__strnlen_user_nocheck_asm);
 EXPORT_SYMBOL(__strnlen_user_asm);
 
diff --git a/arch/mips/lib/strnlen_user.S b/arch/mips/lib/strnlen_user.S
index 4422160..f3af699 100644
--- a/arch/mips/lib/strnlen_user.S
+++ b/arch/mips/lib/strnlen_user.S
@@ -35,7 +35,11 @@ FEXPORT(__strnlen_\func\()_nocheck_asm)
 	move		v0, a0
 	PTR_ADDU	a1, a0			# stop pointer
 1:	beq		v0, a1, 1f		# limit reached?
+.ifeqs "\func", "kernel"
 	EX(lb, t0, (v0), .Lfault\@)
+.else
+	EX(lbe, t0, (v0), .Lfault\@)
+.endif
 	PTR_ADDIU	v0, 1
 	bnez		t0, 1b
 1:	PTR_SUBU	v0, a0
@@ -47,4 +51,20 @@ FEXPORT(__strnlen_\func\()_nocheck_asm)
 	jr		ra
 	.endm
 
+#ifndef CONFIG_EVA
+	/* Set aliases */
+	.global __strnlen_user_asm
+	.global __strnlen_user_nocheck_asm
+	.set __strnlen_user_asm, __strnlen_kernel_asm
+	.set __strnlen_user_nocheck_asm, __strnlen_kernel_nocheck_asm
+#endif
+
+__BUILD_STRNLEN_ASM kernel
+
+#ifdef CONFIG_EVA
+
+	.set push
+	.set eva
 __BUILD_STRNLEN_ASM user
+	.set pop
+#endif
-- 
1.8.5.3
