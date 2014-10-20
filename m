From: Markos Chandras <markos.chandras@imgtec.com>
Date: Mon, 20 Oct 2014 09:39:31 +0100
Subject: MIPS: ftrace: Fix a microMIPS build problem
Message-ID: <20141020083931.fEqzc6jyKKpmBziJG10QDvR55gW_c9HIkniH4olRpd8@z>

commit aedd153f5bb5b1f1d6d9142014f521ae2ec294cc upstream.

Code before the .fixup section needs to have the .insn directive.
This has no side effects on MIPS32/64 but it affects the way microMIPS
loads the address for the return label.

Fixes the following build problem:
mips-linux-gnu-ld: arch/mips/built-in.o: .fixup+0x4a0: Unsupported jump between
ISA modes; consider recompiling with interlinking enabled.
mips-linux-gnu-ld: final link failed: Bad value
Makefile:819: recipe for target 'vmlinux' failed

The fix is similar to 1658f914ff91c3bf ("MIPS: microMIPS:
Disable LL/SC and fix linker bug.")

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/8117/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/include/asm/ftrace.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/ftrace.h b/arch/mips/include/asm/ftrace.h
index ce35c9a..370ae7c 100644
--- a/arch/mips/include/asm/ftrace.h
+++ b/arch/mips/include/asm/ftrace.h
@@ -24,7 +24,7 @@ do {							\
 	asm volatile (					\
 		"1: " load " %[" STR(dst) "], 0(%[" STR(src) "])\n"\
 		"   li %[" STR(error) "], 0\n"		\
-		"2:\n"					\
+		"2: .insn\n"				\
 							\
 		".section .fixup, \"ax\"\n"		\
 		"3: li %[" STR(error) "], 1\n"		\
@@ -46,7 +46,7 @@ do {						\
 	asm volatile (				\
 		"1: " store " %[" STR(src) "], 0(%[" STR(dst) "])\n"\
 		"   li %[" STR(error) "], 0\n"	\
-		"2:\n"				\
+		"2: .insn\n"			\
 						\
 		".section .fixup, \"ax\"\n"	\
 		"3: li %[" STR(error) "], 1\n"	\
--
1.9.1
