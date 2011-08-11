Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Aug 2011 02:36:58 +0200 (CEST)
Received: from gandharva.secretlabs.de ([78.46.147.237]:10068 "EHLO
        gandharva.secretlabs.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491870Ab1HKAgd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Aug 2011 02:36:33 +0200
Received: from localhost.localdomain (unknown [1.202.86.226])
        by gandharva.secretlabs.de (Postfix) with ESMTPSA id 191871B10C16;
        Thu, 11 Aug 2011 00:47:30 +0000 (UTC)
From:   Holger Hans Peter Freyther <zecke@selfish.org>
To:     linux-mips@linux-mips.org
Cc:     Holger Hans Peter Freyther <zecke@selfish.org>,
        Holger Freyther <holger@moiji-mobile.com>
Subject: [PATCH 1/2] MIPS: Move userspace stack unwinding into kernel/user_backtrace.c
Date:   Thu, 11 Aug 2011 02:36:05 +0200
Message-Id: <1313022966-28152-2-git-send-email-zecke@selfish.org>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1313022966-28152-1-git-send-email-zecke@selfish.org>
References: <1313022966-28152-1-git-send-email-zecke@selfish.org>
X-archive-position: 30849
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zecke@selfish.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 8020

Move the OProfile userspace stack unwinding into
arch/mips/kernel/user_backtrace.c to be shared with the perf
callchain implementation.

Rename struct stackframe to user_stackframe, add a GPLv2 header
to the source with the original author of the code.

Always export the unwind_user_frame symbol to make it easy to
use the OProfile module on an already built kernel.

Signed-off-by: Holger Freyther <holger@moiji-mobile.com>
---
 arch/mips/include/asm/stacktrace.h |   10 +++
 arch/mips/kernel/Makefile          |    3 +-
 arch/mips/kernel/user_backtrace.c  |  129 ++++++++++++++++++++++++++++++++++
 arch/mips/oprofile/backtrace.c     |  133 ++----------------------------------
 4 files changed, 146 insertions(+), 129 deletions(-)
 create mode 100644 arch/mips/kernel/user_backtrace.c

diff --git a/arch/mips/include/asm/stacktrace.h b/arch/mips/include/asm/stacktrace.h
index 780ee2c..f713da1 100644
--- a/arch/mips/include/asm/stacktrace.h
+++ b/arch/mips/include/asm/stacktrace.h
@@ -49,4 +49,14 @@ static __always_inline void prepare_frametrace(struct pt_regs *regs)
 		: : "memory");
 }
 
+struct user_stackframe {
+	unsigned long sp;
+	unsigned long pc;
+	unsigned long ra;
+};
+
+int unwind_user_frame(struct user_stackframe *old_frame,
+			const unsigned int max_instr_check);
+
+
 #endif /* _ASM_STACKTRACE_H */
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 83bba33..ce82fbf 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -6,7 +6,8 @@ extra-y		:= head.o init_task.o vmlinux.lds
 
 obj-y		+= cpu-probe.o branch.o entry.o genex.o irq.o process.o \
 		   ptrace.o reset.o setup.o signal.o syscall.o \
-		   time.o topology.o traps.o unaligned.o watch.o vdso.o
+		   time.o topology.o traps.o unaligned.o watch.o vdso.o \
+		   user_backtrace.o
 
 ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_ftrace.o = -pg
diff --git a/arch/mips/kernel/user_backtrace.c b/arch/mips/kernel/user_backtrace.c
new file mode 100644
index 0000000..cc1a8be
--- /dev/null
+++ b/arch/mips/kernel/user_backtrace.c
@@ -0,0 +1,129 @@
+/*
+ * Copyright (C) 2011  Daniel Kalmar
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License..
+ */
+
+#include <linux/uaccess.h>
+#include <linux/module.h>
+
+#include <asm/stacktrace.h>
+#include <asm/sections.h>
+#include <asm/inst.h>
+
+static inline int get_mem(unsigned long addr, unsigned long *result)
+{
+	unsigned long *address = (unsigned long *) addr;
+	if (!access_ok(VERIFY_READ, addr, sizeof(unsigned long)))
+		return -1;
+	if (__copy_from_user_inatomic(result, address, sizeof(unsigned long)))
+		return -3;
+	return 0;
+}
+
+/*
+ * These two instruction helpers were taken from process.c
+ */
+static inline int is_ra_save_ins(union mips_instruction *ip)
+{
+	/* sw / sd $ra, offset($sp) */
+	return (ip->i_format.opcode == sw_op || ip->i_format.opcode == sd_op)
+		&& ip->i_format.rs == 29 && ip->i_format.rt == 31;
+}
+
+static inline int is_sp_move_ins(union mips_instruction *ip)
+{
+	/* addiu/daddiu sp,sp,-imm */
+	if (ip->i_format.rs != 29 || ip->i_format.rt != 29)
+		return 0;
+	if (ip->i_format.opcode == addiu_op || ip->i_format.opcode == daddiu_op)
+		return 1;
+	return 0;
+}
+
+/*
+ * Looks for specific instructions that mark the end of a function.
+ * This usually means we ran into the code area of the previous function.
+ */
+static inline int is_end_of_function_marker(union mips_instruction *ip)
+{
+	/* jr ra */
+	if (ip->r_format.func == jr_op && ip->r_format.rs == 31)
+		return 1;
+	/* lui gp */
+	if (ip->i_format.opcode == lui_op && ip->i_format.rt == 28)
+		return 1;
+	return 0;
+}
+
+/*
+ * TODO for userspace stack unwinding:
+ * - handle cases where the stack is adjusted inside a function
+ *     (generally doesn't happen)
+ * - find optimal value for max_instr_check
+ * - try to find a way to handle leaf functions
+ */
+
+int unwind_user_frame(struct user_stackframe *old_frame,
+	    	const unsigned int max_instr_check)
+{
+	struct user_stackframe new_frame = *old_frame;
+	off_t ra_offset = 0;
+	size_t stack_size = 0;
+	unsigned long addr;
+
+	if (old_frame->pc == 0 || old_frame->sp == 0 || old_frame->ra == 0)
+		return -9;
+
+	for (addr = new_frame.pc; (addr + max_instr_check > new_frame.pc)
+		&& (!ra_offset || !stack_size); --addr) {
+		union mips_instruction ip;
+
+		if (get_mem(addr, (unsigned long *) &ip))
+			return -11;
+
+		if (is_sp_move_ins(&ip)) {
+			int stack_adjustment = ip.i_format.simmediate;
+			if (stack_adjustment > 0)
+				/* This marks the end of the previous function,
+				   which means we overran. */
+				break;
+			stack_size = (unsigned) stack_adjustment;
+		} else if (is_ra_save_ins(&ip)) {
+			int ra_slot = ip.i_format.simmediate;
+			if (ra_slot < 0)
+				/* This shouldn't happen. */
+				break;
+			ra_offset = ra_slot;
+		} else if (is_end_of_function_marker(&ip))
+			break;
+	}
+
+	if (!ra_offset || !stack_size)
+		return -1;
+
+	if (ra_offset) {
+		new_frame.ra = old_frame->sp + ra_offset;
+		if (get_mem(new_frame.ra, &(new_frame.ra)))
+			return -13;
+	}
+
+	if (stack_size) {
+		new_frame.sp = old_frame->sp + stack_size;
+		if (get_mem(new_frame.sp, &(new_frame.sp)))
+			return -14;
+	}
+
+	if (new_frame.sp > old_frame->sp)
+		return -2;
+
+	new_frame.pc = old_frame->ra;
+	*old_frame = new_frame;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(unwind_user_frame);
+
diff --git a/arch/mips/oprofile/backtrace.c b/arch/mips/oprofile/backtrace.c
index 6854ed5..265d26c 100644
--- a/arch/mips/oprofile/backtrace.c
+++ b/arch/mips/oprofile/backtrace.c
@@ -1,134 +1,11 @@
 #include <linux/oprofile.h>
 #include <linux/sched.h>
-#include <linux/mm.h>
-#include <linux/uaccess.h>
+
 #include <asm/ptrace.h>
 #include <asm/stacktrace.h>
-#include <linux/stacktrace.h>
-#include <linux/kernel.h>
-#include <asm/sections.h>
-#include <asm/inst.h>
-
-struct stackframe {
-	unsigned long sp;
-	unsigned long pc;
-	unsigned long ra;
-};
-
-static inline int get_mem(unsigned long addr, unsigned long *result)
-{
-	unsigned long *address = (unsigned long *) addr;
-	if (!access_ok(VERIFY_READ, addr, sizeof(unsigned long)))
-		return -1;
-	if (__copy_from_user_inatomic(result, address, sizeof(unsigned long)))
-		return -3;
-	return 0;
-}
-
-/*
- * These two instruction helpers were taken from process.c
- */
-static inline int is_ra_save_ins(union mips_instruction *ip)
-{
-	/* sw / sd $ra, offset($sp) */
-	return (ip->i_format.opcode == sw_op || ip->i_format.opcode == sd_op)
-		&& ip->i_format.rs == 29 && ip->i_format.rt == 31;
-}
-
-static inline int is_sp_move_ins(union mips_instruction *ip)
-{
-	/* addiu/daddiu sp,sp,-imm */
-	if (ip->i_format.rs != 29 || ip->i_format.rt != 29)
-		return 0;
-	if (ip->i_format.opcode == addiu_op || ip->i_format.opcode == daddiu_op)
-		return 1;
-	return 0;
-}
-
-/*
- * Looks for specific instructions that mark the end of a function.
- * This usually means we ran into the code area of the previous function.
- */
-static inline int is_end_of_function_marker(union mips_instruction *ip)
-{
-	/* jr ra */
-	if (ip->r_format.func == jr_op && ip->r_format.rs == 31)
-		return 1;
-	/* lui gp */
-	if (ip->i_format.opcode == lui_op && ip->i_format.rt == 28)
-		return 1;
-	return 0;
-}
-
-/*
- * TODO for userspace stack unwinding:
- * - handle cases where the stack is adjusted inside a function
- *     (generally doesn't happen)
- * - find optimal value for max_instr_check
- * - try to find a way to handle leaf functions
- */
-
-static inline int unwind_user_frame(struct stackframe *old_frame,
-				    const unsigned int max_instr_check)
-{
-	struct stackframe new_frame = *old_frame;
-	off_t ra_offset = 0;
-	size_t stack_size = 0;
-	unsigned long addr;
-
-	if (old_frame->pc == 0 || old_frame->sp == 0 || old_frame->ra == 0)
-		return -9;
-
-	for (addr = new_frame.pc; (addr + max_instr_check > new_frame.pc)
-		&& (!ra_offset || !stack_size); --addr) {
-		union mips_instruction ip;
-
-		if (get_mem(addr, (unsigned long *) &ip))
-			return -11;
-
-		if (is_sp_move_ins(&ip)) {
-			int stack_adjustment = ip.i_format.simmediate;
-			if (stack_adjustment > 0)
-				/* This marks the end of the previous function,
-				   which means we overran. */
-				break;
-			stack_size = (unsigned) stack_adjustment;
-		} else if (is_ra_save_ins(&ip)) {
-			int ra_slot = ip.i_format.simmediate;
-			if (ra_slot < 0)
-				/* This shouldn't happen. */
-				break;
-			ra_offset = ra_slot;
-		} else if (is_end_of_function_marker(&ip))
-			break;
-	}
-
-	if (!ra_offset || !stack_size)
-		return -1;
-
-	if (ra_offset) {
-		new_frame.ra = old_frame->sp + ra_offset;
-		if (get_mem(new_frame.ra, &(new_frame.ra)))
-			return -13;
-	}
-
-	if (stack_size) {
-		new_frame.sp = old_frame->sp + stack_size;
-		if (get_mem(new_frame.sp, &(new_frame.sp)))
-			return -14;
-	}
-
-	if (new_frame.sp > old_frame->sp)
-		return -2;
-
-	new_frame.pc = old_frame->ra;
-	*old_frame = new_frame;
-
-	return 0;
-}
 
 static inline void do_user_backtrace(unsigned long low_addr,
-				     struct stackframe *frame,
+				     struct user_stackframe *frame,
 				     unsigned int depth)
 {
 	const unsigned int max_instr_check = 512;
@@ -143,11 +20,11 @@ static inline void do_user_backtrace(unsigned long low_addr,
 
 #ifndef CONFIG_KALLSYMS
 static inline void do_kernel_backtrace(unsigned long low_addr,
-				       struct stackframe *frame,
+				       struct user_stackframe *frame,
 				       unsigned int depth) { }
 #else
 static inline void do_kernel_backtrace(unsigned long low_addr,
-				       struct stackframe *frame,
+				       struct user_stackframe *frame,
 				       unsigned int depth)
 {
 	while (depth-- && frame->pc) {
@@ -162,7 +39,7 @@ static inline void do_kernel_backtrace(unsigned long low_addr,
 
 void notrace op_mips_backtrace(struct pt_regs *const regs, unsigned int depth)
 {
-	struct stackframe frame = { .sp = regs->regs[29],
+	struct user_stackframe frame = { .sp = regs->regs[29],
 				    .pc = regs->cp0_epc,
 				    .ra = regs->regs[31] };
 	const int userspace = user_mode(regs);
-- 
1.7.4.1
