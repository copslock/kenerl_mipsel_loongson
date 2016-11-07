Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Nov 2016 12:17:48 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:63543 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991986AbcKGLQhovLSd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Nov 2016 12:16:37 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id F23F9EE3B955F;
        Mon,  7 Nov 2016 11:16:28 +0000 (GMT)
Received: from localhost (10.100.200.221) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 7 Nov
 2016 11:16:30 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 08/10] MIPS: Export string functions alongside their definitions
Date:   Mon, 7 Nov 2016 11:14:14 +0000
Message-ID: <20161107111417.11486-9-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161107111417.11486-1-paul.burton@imgtec.com>
References: <20161107111417.11486-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.221]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55691
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Now that EXPORT_SYMBOL can be used from assembly source, move the
EXPORT_SYMBOL invocations for the strlen*, strnlen* & strncpy* functions
to be alongside their definitions.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/kernel/mips_ksyms.c | 24 ------------------------
 arch/mips/lib/strlen_user.S   |  2 ++
 arch/mips/lib/strncpy_user.S  |  5 +++++
 arch/mips/lib/strnlen_user.S  |  3 +++
 4 files changed, 10 insertions(+), 24 deletions(-)

diff --git a/arch/mips/kernel/mips_ksyms.c b/arch/mips/kernel/mips_ksyms.c
index 3ba65d7..dd65676 100644
--- a/arch/mips/kernel/mips_ksyms.c
+++ b/arch/mips/kernel/mips_ksyms.c
@@ -19,20 +19,6 @@
 
 extern void *__bzero_kernel(void *__s, size_t __count);
 extern void *__bzero(void *__s, size_t __count);
-extern long __strncpy_from_kernel_nocheck_asm(char *__to,
-					      const char *__from, long __len);
-extern long __strncpy_from_kernel_asm(char *__to, const char *__from,
-				      long __len);
-extern long __strncpy_from_user_nocheck_asm(char *__to,
-					    const char *__from, long __len);
-extern long __strncpy_from_user_asm(char *__to, const char *__from,
-				    long __len);
-extern long __strlen_kernel_asm(const char *s);
-extern long __strlen_user_asm(const char *s);
-extern long __strnlen_kernel_nocheck_asm(const char *s);
-extern long __strnlen_kernel_asm(const char *s);
-extern long __strnlen_user_nocheck_asm(const char *s);
-extern long __strnlen_user_asm(const char *s);
 
 /*
  * String functions
@@ -60,13 +46,3 @@ EXPORT_SYMBOL(__copy_user_inatomic_eva);
 EXPORT_SYMBOL(__bzero_kernel);
 #endif
 EXPORT_SYMBOL(__bzero);
-EXPORT_SYMBOL(__strncpy_from_kernel_nocheck_asm);
-EXPORT_SYMBOL(__strncpy_from_kernel_asm);
-EXPORT_SYMBOL(__strncpy_from_user_nocheck_asm);
-EXPORT_SYMBOL(__strncpy_from_user_asm);
-EXPORT_SYMBOL(__strlen_kernel_asm);
-EXPORT_SYMBOL(__strlen_user_asm);
-EXPORT_SYMBOL(__strnlen_kernel_nocheck_asm);
-EXPORT_SYMBOL(__strnlen_kernel_asm);
-EXPORT_SYMBOL(__strnlen_user_nocheck_asm);
-EXPORT_SYMBOL(__strnlen_user_asm);
diff --git a/arch/mips/lib/strlen_user.S b/arch/mips/lib/strlen_user.S
index 929bbac..c9cb7e6 100644
--- a/arch/mips/lib/strlen_user.S
+++ b/arch/mips/lib/strlen_user.S
@@ -9,6 +9,7 @@
  */
 #include <asm/asm.h>
 #include <asm/asm-offsets.h>
+#include <asm/export.h>
 #include <asm/regdef.h>
 
 #define EX(insn,reg,addr,handler)			\
@@ -24,6 +25,7 @@
  */
 	.macro __BUILD_STRLEN_ASM func
 LEAF(__strlen_\func\()_asm)
+EXPORT_SYMBOL(__strlen_\func\()_asm)
 	LONG_L		v0, TI_ADDR_LIMIT($28)	# pointer ok?
 	and		v0, a0
 	bnez		v0, .Lfault\@
diff --git a/arch/mips/lib/strncpy_user.S b/arch/mips/lib/strncpy_user.S
index 3c32baf..af745b1 100644
--- a/arch/mips/lib/strncpy_user.S
+++ b/arch/mips/lib/strncpy_user.S
@@ -9,6 +9,7 @@
 #include <linux/errno.h>
 #include <asm/asm.h>
 #include <asm/asm-offsets.h>
+#include <asm/export.h>
 #include <asm/regdef.h>
 
 #define EX(insn,reg,addr,handler)			\
@@ -30,11 +31,13 @@
 
 	.macro __BUILD_STRNCPY_ASM func
 LEAF(__strncpy_from_\func\()_asm)
+EXPORT_SYMBOL(__strncpy_from_\func\()_asm)
 	LONG_L		v0, TI_ADDR_LIMIT($28)	# pointer ok?
 	and		v0, a1
 	bnez		v0, .Lfault\@
 
 FEXPORT(__strncpy_from_\func\()_nocheck_asm)
+EXPORT_SYMBOL(__strncpy_from_\func\()_nocheck_asm)
 	move		t0, zero
 	move		v1, a1
 .ifeqs "\func","kernel"
@@ -72,6 +75,8 @@ FEXPORT(__strncpy_from_\func\()_nocheck_asm)
 	.global __strncpy_from_user_nocheck_asm
 	.set __strncpy_from_user_asm, __strncpy_from_kernel_asm
 	.set __strncpy_from_user_nocheck_asm, __strncpy_from_kernel_nocheck_asm
+	EXPORT_SYMBOL(__strncpy_from_user_asm)
+	EXPORT_SYMBOL(__strncpy_from_user_nocheck_asm)
 #endif
 
 __BUILD_STRNCPY_ASM kernel
diff --git a/arch/mips/lib/strnlen_user.S b/arch/mips/lib/strnlen_user.S
index 77e6494..3ac3816 100644
--- a/arch/mips/lib/strnlen_user.S
+++ b/arch/mips/lib/strnlen_user.S
@@ -8,6 +8,7 @@
  */
 #include <asm/asm.h>
 #include <asm/asm-offsets.h>
+#include <asm/export.h>
 #include <asm/regdef.h>
 
 #define EX(insn,reg,addr,handler)			\
@@ -27,11 +28,13 @@
  */
 	.macro __BUILD_STRNLEN_ASM func
 LEAF(__strnlen_\func\()_asm)
+EXPORT_SYMBOL(__strnlen_\func\()_asm)
 	LONG_L		v0, TI_ADDR_LIMIT($28)	# pointer ok?
 	and		v0, a0
 	bnez		v0, .Lfault\@
 
 FEXPORT(__strnlen_\func\()_nocheck_asm)
+EXPORT_SYMBOL(__strnlen_\func\()_nocheck_asm)
 	move		v0, a0
 	PTR_ADDU	a1, a0			# stop pointer
 1:
-- 
2.10.2
