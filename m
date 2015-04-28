From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Date: Tue, 28 Apr 2015 12:53:35 -0700
Subject: MIPS64: R6: R2 emulation bugfix
Message-ID: <20150428195335.fUWVwN_22A6sBWFwHtc46SbA9Z0tV5XrJNSvaJ7ft7A@z>

commit 41fa29e4d8cf4150568a0fe9bb4d62229f9caed5 upstream.

Error recovery pointers for fixups was improperly set as ".word"
which is unsuitable for MIPS64.

Replaced by STR(PTR)

[ralf@linux-mips.org: Apply changes as requested in the review process.]

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Reviewed-by: James Hogan <james.hogan@imgtec.com>
Reviewed-by: Markos Chandras <markos.chandras@imgtec.com>
Fixes: b0a668fb2038 ("MIPS: kernel: mips-r2-to-r6-emul: Add R2 emulator for MIPS R6")
Cc: macro@linux-mips.org
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/9911/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/kernel/mips-r2-to-r6-emul.c | 105 +++++++++++++++++-----------------
 1 file changed, 53 insertions(+), 52 deletions(-)

diff --git a/arch/mips/kernel/mips-r2-to-r6-emul.c b/arch/mips/kernel/mips-r2-to-r6-emul.c
index f2977f0..e19fa36 100644
--- a/arch/mips/kernel/mips-r2-to-r6-emul.c
+++ b/arch/mips/kernel/mips-r2-to-r6-emul.c
@@ -27,6 +27,7 @@
 #include <asm/inst.h>
 #include <asm/mips-r2-to-r6-emul.h>
 #include <asm/local.h>
+#include <asm/mipsregs.h>
 #include <asm/ptrace.h>
 #include <asm/uaccess.h>

@@ -1250,10 +1251,10 @@ fpu_emul:
 			"	j	10b\n"
 			"	.previous\n"
 			"	.section	__ex_table,\"a\"\n"
-			"	.word	1b,8b\n"
-			"	.word	2b,8b\n"
-			"	.word	3b,8b\n"
-			"	.word	4b,8b\n"
+			STR(PTR) " 1b,8b\n"
+			STR(PTR) " 2b,8b\n"
+			STR(PTR) " 3b,8b\n"
+			STR(PTR) " 4b,8b\n"
 			"	.previous\n"
 			"	.set	pop\n"
 			: "+&r"(rt), "=&r"(rs),
@@ -1325,10 +1326,10 @@ fpu_emul:
 			"	j	10b\n"
 			"       .previous\n"
 			"	.section	__ex_table,\"a\"\n"
-			"	.word	1b,8b\n"
-			"	.word	2b,8b\n"
-			"	.word	3b,8b\n"
-			"	.word	4b,8b\n"
+			STR(PTR) " 1b,8b\n"
+			STR(PTR) " 2b,8b\n"
+			STR(PTR) " 3b,8b\n"
+			STR(PTR) " 4b,8b\n"
 			"	.previous\n"
 			"	.set	pop\n"
 			: "+&r"(rt), "=&r"(rs),
@@ -1396,10 +1397,10 @@ fpu_emul:
 			"	j	9b\n"
 			"	.previous\n"
 			"	.section        __ex_table,\"a\"\n"
-			"	.word	1b,8b\n"
-			"	.word	2b,8b\n"
-			"	.word	3b,8b\n"
-			"	.word	4b,8b\n"
+			STR(PTR) " 1b,8b\n"
+			STR(PTR) " 2b,8b\n"
+			STR(PTR) " 3b,8b\n"
+			STR(PTR) " 4b,8b\n"
 			"	.previous\n"
 			"	.set	pop\n"
 			: "+&r"(rt), "=&r"(rs),
@@ -1466,10 +1467,10 @@ fpu_emul:
 			"	j	9b\n"
 			"	.previous\n"
 			"	.section        __ex_table,\"a\"\n"
-			"	.word	1b,8b\n"
-			"	.word	2b,8b\n"
-			"	.word	3b,8b\n"
-			"	.word	4b,8b\n"
+			STR(PTR) " 1b,8b\n"
+			STR(PTR) " 2b,8b\n"
+			STR(PTR) " 3b,8b\n"
+			STR(PTR) " 4b,8b\n"
 			"	.previous\n"
 			"	.set	pop\n"
 			: "+&r"(rt), "=&r"(rs),
@@ -1581,14 +1582,14 @@ fpu_emul:
 			"	j	9b\n"
 			"	.previous\n"
 			"	.section        __ex_table,\"a\"\n"
-			"	.word	1b,8b\n"
-			"	.word	2b,8b\n"
-			"	.word	3b,8b\n"
-			"	.word	4b,8b\n"
-			"	.word	5b,8b\n"
-			"	.word	6b,8b\n"
-			"	.word	7b,8b\n"
-			"	.word	0b,8b\n"
+			STR(PTR) " 1b,8b\n"
+			STR(PTR) " 2b,8b\n"
+			STR(PTR) " 3b,8b\n"
+			STR(PTR) " 4b,8b\n"
+			STR(PTR) " 5b,8b\n"
+			STR(PTR) " 6b,8b\n"
+			STR(PTR) " 7b,8b\n"
+			STR(PTR) " 0b,8b\n"
 			"	.previous\n"
 			"	.set	pop\n"
 			: "+&r"(rt), "=&r"(rs),
@@ -1700,14 +1701,14 @@ fpu_emul:
 			"	j      9b\n"
 			"	.previous\n"
 			"	.section        __ex_table,\"a\"\n"
-			"	.word  1b,8b\n"
-			"	.word  2b,8b\n"
-			"	.word  3b,8b\n"
-			"	.word  4b,8b\n"
-			"	.word  5b,8b\n"
-			"	.word  6b,8b\n"
-			"	.word  7b,8b\n"
-			"	.word  0b,8b\n"
+			STR(PTR) " 1b,8b\n"
+			STR(PTR) " 2b,8b\n"
+			STR(PTR) " 3b,8b\n"
+			STR(PTR) " 4b,8b\n"
+			STR(PTR) " 5b,8b\n"
+			STR(PTR) " 6b,8b\n"
+			STR(PTR) " 7b,8b\n"
+			STR(PTR) " 0b,8b\n"
 			"	.previous\n"
 			"	.set    pop\n"
 			: "+&r"(rt), "=&r"(rs),
@@ -1819,14 +1820,14 @@ fpu_emul:
 			"	j	9b\n"
 			"	.previous\n"
 			"	.section        __ex_table,\"a\"\n"
-			"	.word	1b,8b\n"
-			"	.word	2b,8b\n"
-			"	.word	3b,8b\n"
-			"	.word	4b,8b\n"
-			"	.word	5b,8b\n"
-			"	.word	6b,8b\n"
-			"	.word	7b,8b\n"
-			"	.word	0b,8b\n"
+			STR(PTR) " 1b,8b\n"
+			STR(PTR) " 2b,8b\n"
+			STR(PTR) " 3b,8b\n"
+			STR(PTR) " 4b,8b\n"
+			STR(PTR) " 5b,8b\n"
+			STR(PTR) " 6b,8b\n"
+			STR(PTR) " 7b,8b\n"
+			STR(PTR) " 0b,8b\n"
 			"	.previous\n"
 			"	.set	pop\n"
 			: "+&r"(rt), "=&r"(rs),
@@ -1937,14 +1938,14 @@ fpu_emul:
 			"       j	9b\n"
 			"       .previous\n"
 			"       .section        __ex_table,\"a\"\n"
-			"       .word	1b,8b\n"
-			"       .word	2b,8b\n"
-			"       .word	3b,8b\n"
-			"       .word	4b,8b\n"
-			"       .word	5b,8b\n"
-			"       .word	6b,8b\n"
-			"       .word	7b,8b\n"
-			"       .word	0b,8b\n"
+			STR(PTR) " 1b,8b\n"
+			STR(PTR) " 2b,8b\n"
+			STR(PTR) " 3b,8b\n"
+			STR(PTR) " 4b,8b\n"
+			STR(PTR) " 5b,8b\n"
+			STR(PTR) " 6b,8b\n"
+			STR(PTR) " 7b,8b\n"
+			STR(PTR) " 0b,8b\n"
 			"       .previous\n"
 			"       .set	pop\n"
 			: "+&r"(rt), "=&r"(rs),
@@ -1999,7 +2000,7 @@ fpu_emul:
 			"j	2b\n"
 			".previous\n"
 			".section        __ex_table,\"a\"\n"
-			".word  1b, 3b\n"
+			STR(PTR) " 1b,3b\n"
 			".previous\n"
 			: "=&r"(res), "+&r"(err)
 			: "r"(vaddr), "i"(SIGSEGV)
@@ -2057,7 +2058,7 @@ fpu_emul:
 			"j	2b\n"
 			".previous\n"
 			".section        __ex_table,\"a\"\n"
-			".word	1b, 3b\n"
+			STR(PTR) " 1b,3b\n"
 			".previous\n"
 			: "+&r"(res), "+&r"(err)
 			: "r"(vaddr), "i"(SIGSEGV));
@@ -2118,7 +2119,7 @@ fpu_emul:
 			"j	2b\n"
 			".previous\n"
 			".section        __ex_table,\"a\"\n"
-			".word  1b, 3b\n"
+			STR(PTR) " 1b,3b\n"
 			".previous\n"
 			: "=&r"(res), "+&r"(err)
 			: "r"(vaddr), "i"(SIGSEGV)
@@ -2181,7 +2182,7 @@ fpu_emul:
 			"j	2b\n"
 			".previous\n"
 			".section        __ex_table,\"a\"\n"
-			".word	1b, 3b\n"
+			STR(PTR) " 1b,3b\n"
 			".previous\n"
 			: "+&r"(res), "+&r"(err)
 			: "r"(vaddr), "i"(SIGSEGV));
--
2.7.4
