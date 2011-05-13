Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 May 2011 14:40:33 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:49448 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491822Ab1EMMjz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 May 2011 14:39:55 +0200
Received: by mail-fx0-f49.google.com with SMTP id 14so2302504fxm.36
        for <linux-mips@linux-mips.org>; Fri, 13 May 2011 05:39:55 -0700 (PDT)
Received: by 10.223.145.13 with SMTP id b13mr1684082fav.65.1305290394706;
        Fri, 13 May 2011 05:39:54 -0700 (PDT)
Received: from localhost.localdomain (540371FD.catv.pool.telekom.hu [84.3.113.253])
        by mx.google.com with ESMTPS id 18sm568268fan.25.2011.05.13.05.39.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 13 May 2011 05:39:53 -0700 (PDT)
From:   Gergely Kis <gergely@homejinni.com>
To:     linux-mips@linux-mips.org
Cc:     oprofile-list@lists.sourceforge.net,
        Daniel Kalmar <kalmard@homejinni.com>,
        Gergely Kis <gergely@homejinni.com>
Subject: [PATCH 2/2] MIPS: oprofile: Add callgraph support
Date:   Fri, 13 May 2011 12:38:05 +0000
Message-Id: <1305290285-13818-3-git-send-email-gergely@homejinni.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1305290285-13818-1-git-send-email-gergely@homejinni.com>
References: <1305290285-13818-1-git-send-email-gergely@homejinni.com>
Return-Path: <gergely@homejinni.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29982
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gergely@homejinni.com
Precedence: bulk
X-list: linux-mips

From: Daniel Kalmar <kalmard@homejinni.com>

Stack unwinding is done by code examination. For kernelspace, the
already existing unwind function is utilized that uses kallsyms to
quickly find the beginning of functions. For userspace a new function
was added that examines code at and before the pc.

Signed-off-by: Daniel Kalmar <kalmard@homejinni.com>
Signed-off-by: Gergely Kis <gergely@homejinni.com>
---
 arch/mips/oprofile/Makefile    |    2 +-
 arch/mips/oprofile/backtrace.c |  173 ++++++++++++++++++++++++++++++++++++++++
 arch/mips/oprofile/common.c    |    1 +
 arch/mips/oprofile/op_impl.h   |    2 +
 4 files changed, 177 insertions(+), 1 deletions(-)
 create mode 100644 arch/mips/oprofile/backtrace.c

diff --git a/arch/mips/oprofile/Makefile b/arch/mips/oprofile/Makefile
index 4b9d704..29f2f13 100644
--- a/arch/mips/oprofile/Makefile
+++ b/arch/mips/oprofile/Makefile
@@ -8,7 +8,7 @@ DRIVER_OBJS = $(addprefix ../../../drivers/oprofile/, \
 		oprofilefs.o oprofile_stats.o \
 		timer_int.o )
 
-oprofile-y				:= $(DRIVER_OBJS) common.o
+oprofile-y				:= $(DRIVER_OBJS) common.o backtrace.o
 
 oprofile-$(CONFIG_CPU_MIPS32)		+= op_model_mipsxx.o
 oprofile-$(CONFIG_CPU_MIPS64)		+= op_model_mipsxx.o
diff --git a/arch/mips/oprofile/backtrace.c b/arch/mips/oprofile/backtrace.c
new file mode 100644
index 0000000..d508e9e
--- /dev/null
+++ b/arch/mips/oprofile/backtrace.c
@@ -0,0 +1,173 @@
+#include <linux/oprofile.h>
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <linux/uaccess.h>
+#include <asm/ptrace.h>
+#include <asm/stacktrace.h>
+#include <linux/stacktrace.h>
+#include <linux/kernel.h>
+#include <asm/sections.h>
+#include <asm/inst.h>
+
+struct stackframe {
+	unsigned long sp;
+	unsigned long pc;
+	unsigned long ra;
+};
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
+static inline int unwind_user_frame(struct stackframe *old_frame,
+				    const unsigned int max_instr_check)
+{
+	struct stackframe new_frame = *old_frame;
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
+
+static inline void do_user_backtrace(unsigned long low_addr,
+				     struct stackframe *frame,
+				     unsigned int depth) {
+	const unsigned int max_instr_check = 512;
+	const unsigned long high_addr = low_addr + THREAD_SIZE;
+
+	while (depth-- && !unwind_user_frame(frame, max_instr_check)) {
+		oprofile_add_trace(frame->ra);
+		if (frame->sp < low_addr || frame->sp > high_addr)
+			break;
+	}
+}
+
+#ifndef CONFIG_KALLSYMS
+static inline void do_kernel_backtrace(unsigned long low_addr,
+				       struct stackframe *frame,
+				       unsigned int depth) { }
+#else
+static inline void do_kernel_backtrace(unsigned long low_addr,
+				       struct stackframe *frame,
+				       unsigned int depth) {
+	while (depth-- && frame->pc) {
+		frame->pc = unwind_stack_by_address(low_addr,
+						    &(frame->sp),
+						    frame->pc,
+						    &(frame->ra));
+		oprofile_add_trace(frame->ra);
+	}
+}
+#endif
+
+void notrace op_mips_backtrace(struct pt_regs *const regs, unsigned int depth)
+{
+	struct stackframe frame = { .sp = regs->regs[29],
+				    .pc = regs->cp0_epc,
+				    .ra = regs->regs[31] };
+	const int userspace = user_mode(regs);
+	const unsigned long low_addr = ALIGN(frame.sp, THREAD_SIZE);
+
+	if (userspace)
+		do_user_backtrace(low_addr, &frame, depth);
+	else
+		do_kernel_backtrace(low_addr, &frame, depth);
+}
diff --git a/arch/mips/oprofile/common.c b/arch/mips/oprofile/common.c
index f9eb1ab..d1f2d4c 100644
--- a/arch/mips/oprofile/common.c
+++ b/arch/mips/oprofile/common.c
@@ -115,6 +115,7 @@ int __init oprofile_arch_init(struct oprofile_operations *ops)
 	ops->start		= op_mips_start;
 	ops->stop		= op_mips_stop;
 	ops->cpu_type		= lmodel->cpu_type;
+	ops->backtrace		= op_mips_backtrace;
 
 	printk(KERN_INFO "oprofile: using %s performance monitoring.\n",
 	       lmodel->cpu_type);
diff --git a/arch/mips/oprofile/op_impl.h b/arch/mips/oprofile/op_impl.h
index f04b54f..7c2da27 100644
--- a/arch/mips/oprofile/op_impl.h
+++ b/arch/mips/oprofile/op_impl.h
@@ -36,4 +36,6 @@ struct op_mips_model {
 	unsigned char num_counters;
 };
 
+void op_mips_backtrace(struct pt_regs * const regs, unsigned int depth);
+
 #endif
-- 
1.7.0.4
