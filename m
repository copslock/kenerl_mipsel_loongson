Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 21:25:15 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:43580 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827279AbaA0UWk32WPC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jan 2014 21:22:40 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 15/58] MIPS: lib: strncpy_user: Add EVA support
Date:   Mon, 27 Jan 2014 20:19:02 +0000
Message-ID: <1390853985-14246-16-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
References: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.47]
X-SEF-Processed: 7_3_0_01192__2014_01_27_20_22_35
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39133
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

In non-EVA mode, strncpy_from_user* aliases are used for the
strncpy_from_kernel* symbols since the code is identical. In EVA
mode, new strcpy_from_user* symbols are used which use the EVA
specific instructions to load values from userspace.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/kernel/mips_ksyms.c |  6 ++++++
 arch/mips/lib/strncpy_user.S  | 19 +++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/mips/kernel/mips_ksyms.c b/arch/mips/kernel/mips_ksyms.c
index 742ed7d..675bd05 100644
--- a/arch/mips/kernel/mips_ksyms.c
+++ b/arch/mips/kernel/mips_ksyms.c
@@ -16,6 +16,10 @@
 #include <asm/ftrace.h>
 
 extern void *__bzero(void *__s, size_t __count);
+extern long __strncpy_from_kernel_nocheck_asm(char *__to,
+					      const char *__from, long __len);
+extern long __strncpy_from_kernel_asm(char *__to, const char *__from,
+				      long __len);
 extern long __strncpy_from_user_nocheck_asm(char *__to,
 					    const char *__from, long __len);
 extern long __strncpy_from_user_asm(char *__to, const char *__from,
@@ -48,6 +52,8 @@ EXPORT_SYMBOL(copy_page);
 EXPORT_SYMBOL(__copy_user);
 EXPORT_SYMBOL(__copy_user_inatomic);
 EXPORT_SYMBOL(__bzero);
+EXPORT_SYMBOL(__strncpy_from_kernel_nocheck_asm);
+EXPORT_SYMBOL(__strncpy_from_kernel_asm);
 EXPORT_SYMBOL(__strncpy_from_user_nocheck_asm);
 EXPORT_SYMBOL(__strncpy_from_user_asm);
 EXPORT_SYMBOL(__strlen_kernel_nocheck_asm);
diff --git a/arch/mips/lib/strncpy_user.S b/arch/mips/lib/strncpy_user.S
index 51b38ab..d3301cd 100644
--- a/arch/mips/lib/strncpy_user.S
+++ b/arch/mips/lib/strncpy_user.S
@@ -38,7 +38,11 @@ FEXPORT(__strncpy_from_\func\()_nocheck_asm)
 	.set		noreorder
 	move		t0, zero
 	move		v1, a1
+.ifeqs "\func","kernel"
 1:	EX(lbu, v0, (v1), .Lfault\@)
+.else
+1:	EX(lbue, v0, (v1), .Lfault\@)
+.endif
 	PTR_ADDIU	v1, 1
 	R10KCBARRIER(0(ra))
 	beqz		v0, 2f
@@ -63,4 +67,19 @@ FEXPORT(__strncpy_from_\func\()_nocheck_asm)
 
 	.endm
 
+#ifndef CONFIG_EVA
+	/* Set aliases */
+	.global __strncpy_from_user_asm
+	.global __strncpy_from_user_nocheck_asm
+	.set __strncpy_from_user_asm, __strncpy_from_kernel_asm
+	.set __strncpy_from_user_nocheck_asm, __strncpy_from_kernel_nocheck_asm
+#endif
+
+__BUILD_STRNCPY_ASM kernel
+
+#ifdef CONFIG_EVA
+	.set push
+	.set eva
 __BUILD_STRNCPY_ASM user
+	.set pop
+#endif
-- 
1.8.5.3
