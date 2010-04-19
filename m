Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Apr 2010 12:16:07 +0200 (CEST)
Received: from mail-pv0-f177.google.com ([74.125.83.177]:51302 "EHLO
        mail-pv0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491166Ab0DSKQA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Apr 2010 12:16:00 +0200
Received: by pvc30 with SMTP id 30so2947493pvc.36
        for <multiple recipients>; Mon, 19 Apr 2010 03:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=5Ak2sHhCfigDK1FTCrIaTmkDBitnR4QY6dpHbeeFefc=;
        b=frZSg3Jb4aCxzqT3OgLAR9De5tfmoM9LG+EjT8DSrA3w6ewT1fMKiCBbQ0J7UUVQRu
         sfu6k33Tcy4i6+9lm/h/f96RemCkmZpNVlT/Hmuhgiq9WAEjV+EbS/C3d0+cD9JxRhpu
         T42Gx3TNd6K7F9F0yHESXisPKeYYTT79Pg2gU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=RYTzuANfF+pXOeSZbdRwXaQkPw+suciYmKPpIlpbtVVqbUs4SfwZvZVLOxqARGCKnH
         Bd30nfy2k3ckStc6vZW/DT99QQLx7UY6oevIzhSICLYqSQO+GAJQprU2/EIuEl8sEgkJ
         2C/oyxXycW9Tyw6RONZ0EsiCHTNtPqDPJfRUY=
Received: by 10.115.132.40 with SMTP id j40mr3695498wan.21.1271671676364;
        Mon, 19 Apr 2010 03:07:56 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id 20sm5379819pzk.15.2010.04.19.03.07.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 19 Apr 2010 03:07:55 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-mips@linux-mips.org,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH v6] MIPS: tracing: adds misc cleanups and fixups
Date:   Mon, 19 Apr 2010 18:07:46 +0800
Message-Id: <89d59a54efbe4fb9e75e16638d5acec162624a40.1271671588.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26429
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

Changes:

v5 -> v6:

  + Fixup of the static function graph tracer with -mmcount-ra-address

   The last patch have broken the static function graph tracer with
   -mmcount-ra-address via passing a wrong argument (a0), this patch
   fixes it.

  + Cleanup of comments in mcount.S.

v4 -> v5:

  * All of the these changes have been tested in 32bit & 64bit kernel
  with gcc 4.4 & 4.5, including kernel & module Ftrace support.

  + Fixup of the module support broken by the change of v1->v2.

    As the source code(and also the objdump result of the kernel image)
    of -mmcount-ra-address shows, the change of v1->v2 is wrong and has
    broken the module support:

    For 64bit kernel with -mmcount-ra-address, the return address saving
    operation is put in the delay slot of the jump instruction(calling
    site of _mcount), so, the offset of "b 1f" is the same to the
    -mno-mcount-ra-address: 16.

    but for 32bit kernel, since there is already an instruction put in
    the delay slot, the return address operation must be put before the
    jump instruciton, so, the offset is bigger than the one with
    -mno-mcount-ra-address: 16+4=20.

  + Fixup of the 32bit support with gcc 4.5

    As the doc[1] of gcc-4.5 shows, the -mmcount-ra-address uses the $12
    to transfer the stack offset of the return address to the _mcount
    function. in 64bit kernel, $12 is t0, but in 32bit kernel, it is t4,
    so, we need to use $12 instead of t0 here to cover the 64bit and
    32bit support.

    [1] Gcc doc: MIPS Options
    http://gcc.gnu.org/onlinedocs/gcc/MIPS-Options.html

  + Cleanup of mcount.S

    o merges two continuous "#ifdef CONFIG_64BIT".
    o removes the instruction "move    a0, t0" via using a0 directly.
    o share the common "PTR_LA  a0, PT_R1(sp)"

v3 -> v4:

  + Fixup of 'undefined ftrace_graph_caller'

    ftrace_graph_caller variable is only needed by
    CONFIG_FUNCTION_GRAPH_TRACER, so, wrap it with #ifdef.

v2 -> v3:

  + Fixes the buidling error of the changes from v2.

v1 -> v2:

  + Fixes the support of -mmcount-ra-address

    The offset of "b 1f" instruction should be 20 for leaf-function and
    24 for non-leaf function when -mmcount-ra-address is enabled. This
    patch adds a new get_insn_b_1f() function to get the different "b
    1f" instruction.

  (only test without -mmcount-ra-address.)

v1:

  + Reduce the runtime overhead

    o Uses macros instead of variables for the fixed instructions to
    reduce memory access

    o Moves the Initilization of the instructions which will be fixed
    after linking from ftrace_make_nop/ftrace_make_call to
    ftrace_dyn_arch_init() and encodes the instructions through
    uasm(arch/mips/include/asm/uasm.h).

    o A common macro in_module() is defined to determine which space the
    instruction pointer stays in and several related conditional
    statements are converted to conditional operator(? :) statement.

  + Cleanup the whole stuff

    Lots of comments/macros have been cleaned up to let it look better.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/include/asm/ftrace.h |   12 ++-
 arch/mips/kernel/ftrace.c      |  217 +++++++++++++++++++++++-----------------
 arch/mips/kernel/mcount.S      |   47 +++++----
 3 files changed, 160 insertions(+), 116 deletions(-)

diff --git a/arch/mips/include/asm/ftrace.h b/arch/mips/include/asm/ftrace.h
index ce35c9a..29d71c0 100644
--- a/arch/mips/include/asm/ftrace.h
+++ b/arch/mips/include/asm/ftrace.h
@@ -3,7 +3,7 @@
  * License.  See the file "COPYING" in the main directory of this archive for
  * more details.
  *
- * Copyright (C) 2009 DSLab, Lanzhou University, China
+ * Copyright (C) 2009, 2010 DSLab, Lanzhou University, China
  * Author: Wu Zhangjin <wuzhangjin@gmail.com>
  */
 
@@ -19,6 +19,14 @@
 extern void _mcount(void);
 #define mcount _mcount
 
+/*
+ * If the Instruction Pointer is in module space (0xc0000000), return true;
+ * otherwise, it is in kernel space (0x80000000), return false.
+ *
+ * FIXME: This may not work in some cases.
+ */
+#define in_module(ip) (unlikely((ip) & 0x40000000))
+
 #define safe_load(load, src, dst, error)		\
 do {							\
 	asm volatile (					\
@@ -83,8 +91,8 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
 
 struct dyn_arch_ftrace {
 };
-
 #endif /*  CONFIG_DYNAMIC_FTRACE */
+
 #endif /* __ASSEMBLY__ */
 #endif /* CONFIG_FUNCTION_TRACER */
 #endif /* _ASM_MIPS_FTRACE_H */
diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
index e9e64e0..d01ab52 100644
--- a/arch/mips/kernel/ftrace.c
+++ b/arch/mips/kernel/ftrace.c
@@ -2,7 +2,7 @@
  * Code for replacing ftrace calls with jumps.
  *
  * Copyright (C) 2007-2008 Steven Rostedt <srostedt@redhat.com>
- * Copyright (C) 2009 DSLab, Lanzhou University, China
+ * Copyright (C) 2009, 2010 DSLab, Lanzhou University, China
  * Author: Wu Zhangjin <wuzhangjin@gmail.com>
  *
  * Thanks goes to Steven Rostedt for writing the original x86 version.
@@ -15,15 +15,51 @@
 #include <asm/cacheflush.h>
 #include <asm/asm.h>
 #include <asm/asm-offsets.h>
+#include <asm/uasm.h>
+
+#define INSN_S_R_SP	0xafb00000	/* s{d,w} R, offset(sp) */
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 
-#define JAL 0x0c000000		/* jump & link: ip --> ra, jump to target */
-#define ADDR_MASK 0x03ffffff	/*  op_code|addr : 31...26|25 ....0 */
-#define jump_insn_encode(op_code, addr) \
-	((unsigned int)((op_code) | (((addr) >> 2) & ADDR_MASK)))
+/* Before linking, the following instructions are fixed. */
+#ifdef CONFIG_CPU_LOONGSON2F
+#define INSN_NOP 0x00200825	/* or at, at, zero */
+#else
+#define INSN_NOP 0x00000000	/* nop */
+#endif
+#define INSN_B_1F_16 0x10000004	/* b 1f; offset = (16 >> 2) */
+#define INSN_B_1F_20 0x10000005	/* b 1f; offset = (20 >> 2) */
+
+/* After linking, the following instructions are fixed. */
+static unsigned int insn_jal_ftrace_caller __read_mostly;
+static unsigned int insn_lui_v1_hi16_mcount __read_mostly;
+static unsigned int insn_j_ftrace_graph_caller __maybe_unused __read_mostly;
+
+/* The following instructions are encoded in the run-time */
+/* insn: jal func; op_code|addr : 31...26|25 ....0 */
+#define INSN_JAL(addr) \
+	((unsigned int)(0x0c000000 | (((addr) >> 2) & 0x03ffffff)))
+
+static inline void ftrace_dyn_arch_init_insns(void)
+{
+	u32 *buf;
+	unsigned int v1;
 
-static unsigned int ftrace_nop = 0x00000000;
+	/* lui v1, hi16_mcount */
+	v1 = 3;
+	buf = (u32 *)&insn_lui_v1_hi16_mcount;
+	UASM_i_LA_mostly(&buf, v1, MCOUNT_ADDR);
+
+	/* jal (ftrace_caller + 8), jump over the first two instruction */
+	buf = (u32 *)&insn_jal_ftrace_caller;
+	uasm_i_jal(&buf, (FTRACE_ADDR + 8));
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	/* j ftrace_graph_caller */
+	buf = (u32 *)&insn_j_ftrace_graph_caller;
+	uasm_i_j(&buf, (unsigned long)ftrace_graph_caller);
+#endif
+}
 
 static int ftrace_modify_code(unsigned long ip, unsigned int new_code)
 {
@@ -31,7 +67,6 @@ static int ftrace_modify_code(unsigned long ip, unsigned int new_code)
 
 	/* *(unsigned int *)ip = new_code; */
 	safe_store_code(new_code, ip, faulted);
-
 	if (unlikely(faulted))
 		return -EFAULT;
 
@@ -40,84 +75,82 @@ static int ftrace_modify_code(unsigned long ip, unsigned int new_code)
 	return 0;
 }
 
-static int lui_v1;
-static int jal_mcount;
-
 int ftrace_make_nop(struct module *mod,
 		    struct dyn_ftrace *rec, unsigned long addr)
 {
 	unsigned int new;
-	int faulted;
 	unsigned long ip = rec->ip;
 
-	/* We have compiled module with -mlong-calls, but compiled the kernel
-	 * without it, we need to cope with them respectively. */
-	if (ip & 0x40000000) {
-		/* record it for ftrace_make_call */
-		if (lui_v1 == 0) {
-			/* lui_v1 = *(unsigned int *)ip; */
-			safe_load_code(lui_v1, ip, faulted);
-
-			if (unlikely(faulted))
-				return -EFAULT;
-		}
-
-		/* lui v1, hi_16bit_of_mcount        --> b 1f (0x10000004)
-		 * addiu v1, v1, low_16bit_of_mcount
-		 * move at, ra
-		 * jalr v1
-		 * nop
-		 * 				     1f: (ip + 12)
-		 */
-		new = 0x10000004;
-	} else {
-		/* record/calculate it for ftrace_make_call */
-		if (jal_mcount == 0) {
-			/* We can record it directly like this:
-			 *     jal_mcount = *(unsigned int *)ip;
-			 * Herein, jump over the first two nop instructions */
-			jal_mcount = jump_insn_encode(JAL, (MCOUNT_ADDR + 8));
-		}
-
-		/* move at, ra
-		 * jalr v1		--> nop
-		 */
-		new = ftrace_nop;
+	/*
+	 * We have compiled modules with -mlong-calls, but compiled kernel
+	 * without it, therefore, need to cope with them respectively.
+	 *
+	 * For module:
+	 *
+	 *	lui	v1, hi16_mcount		--> b	1f
+	 *	addiu	v1, v1, lo16_mcount
+	 *	move at, ra
+	 *	jalr v1
+	 *	 nop
+	 *					1f: (ip + 16)
+	 * For kernel:
+	 *
+	 *	move	at, ra
+	 *	jal	_mcount			--> nop
+	 *
+	 * And with the -mmcount-ra-address option, the offset may be 20 for
+	 * leaf fuction and 24 for non-leaf function.
+	 */
+
+	if (!in_module(ip))
+		new = INSN_NOP;
+	else {
+#if defined(KBUILD_MCOUNT_RA_ADDRESS) && defined(CONFIG_32BIT)
+		new = INSN_B_1F_20;
+#else
+		new = INSN_B_1F_16;
+#endif
 	}
+
 	return ftrace_modify_code(ip, new);
 }
 
-static int modified;	/* initialized as 0 by default */
-
 int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 {
 	unsigned int new;
 	unsigned long ip = rec->ip;
 
-	/* We just need to remove the "b ftrace_stub" at the fist time! */
-	if (modified == 0) {
-		modified = 1;
-		ftrace_modify_code(addr, ftrace_nop);
-	}
-	/* ip, module: 0xc0000000, kernel: 0x80000000 */
-	new = (ip & 0x40000000) ? lui_v1 : jal_mcount;
+	new = in_module(ip) ? insn_lui_v1_hi16_mcount : insn_jal_ftrace_caller;
 
 	return ftrace_modify_code(ip, new);
 }
 
-#define FTRACE_CALL_IP ((unsigned long)(&ftrace_call))
-
 int ftrace_update_ftrace_func(ftrace_func_t func)
 {
 	unsigned int new;
 
-	new = jump_insn_encode(JAL, (unsigned long)func);
+	new = INSN_JAL((unsigned long)func);
 
-	return ftrace_modify_code(FTRACE_CALL_IP, new);
+	return ftrace_modify_code((unsigned long)(&ftrace_call), new);
 }
 
 int __init ftrace_dyn_arch_init(void *data)
 {
+	ftrace_dyn_arch_init_insns();
+
+	/*
+	 * We are safe to remove the "b ftrace_stub" for the current
+	 * ftrace_caller() is almost empty (only the stack operations), and
+	 * most importantly, the calling to mcount will be disabled later in
+	 * ftrace_init(), then there is no 'big' overhead. And in the future,
+	 * we are hoping the function_trace_stop is initialized as 1 then we
+	 * can eventually remove that 'useless' "b ftrace_stub" and the
+	 * following nop. Currently, although we can call ftrace_stop() to set
+	 * function_trace_stop as 1, but it will change the behavior of the
+	 * Function Tracer.
+	 */
+	ftrace_modify_code(MCOUNT_ADDR, INSN_NOP);
+
 	/* The return code is retured via data */
 	*(unsigned long *)data = 0;
 
@@ -128,30 +161,24 @@ int __init ftrace_dyn_arch_init(void *data)
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 
 #ifdef CONFIG_DYNAMIC_FTRACE
-
 extern void ftrace_graph_call(void);
-#define JMP	0x08000000	/* jump to target directly */
-#define CALL_FTRACE_GRAPH_CALLER \
-	jump_insn_encode(JMP, (unsigned long)(&ftrace_graph_caller))
 #define FTRACE_GRAPH_CALL_IP	((unsigned long)(&ftrace_graph_call))
 
 int ftrace_enable_ftrace_graph_caller(void)
 {
 	return ftrace_modify_code(FTRACE_GRAPH_CALL_IP,
-				  CALL_FTRACE_GRAPH_CALLER);
+			insn_j_ftrace_graph_caller);
 }
 
 int ftrace_disable_ftrace_graph_caller(void)
 {
-	return ftrace_modify_code(FTRACE_GRAPH_CALL_IP, ftrace_nop);
+	return ftrace_modify_code(FTRACE_GRAPH_CALL_IP, INSN_NOP);
 }
-
 #endif				/* !CONFIG_DYNAMIC_FTRACE */
 
 #ifndef KBUILD_MCOUNT_RA_ADDRESS
-#define S_RA_SP	(0xafbf << 16)	/* s{d,w} ra, offset(sp) */
-#define S_R_SP	(0xafb0 << 16)  /* s{d,w} R, offset(sp) */
-#define OFFSET_MASK	0xffff	/* stack offset range: 0 ~ PT_SIZE */
+#define INSN_S_RA_SP	0xafbf0000	/* s{d,w} ra, offset(sp) */
+#define STACK_OFFSET_MASK	0xffff	/* stack offset range: 0 ~ PT_SIZE */
 
 unsigned long ftrace_get_parent_addr(unsigned long self_addr,
 				     unsigned long parent,
@@ -162,35 +189,35 @@ unsigned long ftrace_get_parent_addr(unsigned long self_addr,
 	unsigned int code;
 	int faulted;
 
-	/* in module or kernel? */
-	if (self_addr & 0x40000000) {
-		/* module: move to the instruction "lui v1, HI_16BIT_OF_MCOUNT" */
-		ip = self_addr - 20;
-	} else {
-		/* kernel: move to the instruction "move ra, at" */
-		ip = self_addr - 12;
-	}
+	/*
+	 * For module, move the ip from calling site of mcount to the
+	 * instruction "lui v1, hi_16bit_of_mcount"(offset is 20), but for
+	 * kernel, move to the instruction "move ra, at"(offset is 12)
+	 */
+	ip = self_addr - (in_module(self_addr) ? 20 : 12);
 
-	/* search the text until finding the non-store instruction or "s{d,w}
-	 * ra, offset(sp)" instruction */
+	/*
+	 * search the text until finding the non-store instruction or "s{d,w}
+	 * ra, offset(sp)" instruction
+	 */
 	do {
 		ip -= 4;
 
 		/* get the code at "ip": code = *(unsigned int *)ip; */
 		safe_load_code(code, ip, faulted);
-
 		if (unlikely(faulted))
 			return 0;
 
-		/* If we hit the non-store instruction before finding where the
+		/*
+		 * If we hit the non-store instruction before finding where the
 		 * ra is stored, then this is a leaf function and it does not
-		 * store the ra on the stack. */
-		if ((code & S_R_SP) != S_R_SP)
+		 * store the ra on the stack.
+		 */
+		if ((code & INSN_S_R_SP) != INSN_S_R_SP)
 			return parent_addr;
+	} while (((code & INSN_S_RA_SP) != INSN_S_RA_SP));
 
-	} while (((code & S_RA_SP) != S_RA_SP));
-
-	sp = fp + (code & OFFSET_MASK);
+	sp = fp + (code & STACK_OFFSET_MASK);
 
 	/* ra = *(unsigned long *)sp; */
 	safe_load_stack(ra, sp, faulted);
@@ -201,8 +228,7 @@ unsigned long ftrace_get_parent_addr(unsigned long self_addr,
 		return sp;
 	return 0;
 }
-
-#endif
+#endif	/* !KBUILD_MCOUNT_RA_ADDRESS */
 
 /*
  * Hook the return address and push it in the stack of return addrs
@@ -211,16 +237,17 @@ unsigned long ftrace_get_parent_addr(unsigned long self_addr,
 void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
 			   unsigned long fp)
 {
+	int faulted;
 	unsigned long old;
 	struct ftrace_graph_ent trace;
 	unsigned long return_hooker = (unsigned long)
 	    &return_to_handler;
-	int faulted;
 
 	if (unlikely(atomic_read(&current->tracing_graph_pause)))
 		return;
 
-	/* "parent" is the stack address saved the return address of the caller
+	/*
+	 * "parent" is the stack address saved the return address of the caller
 	 * of _mcount.
 	 *
 	 * if the gcc < 4.5, a leaf function does not save the return address
@@ -241,12 +268,14 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
 	if (unlikely(faulted))
 		goto out;
 #ifndef KBUILD_MCOUNT_RA_ADDRESS
-	parent = (unsigned long *)ftrace_get_parent_addr(self_addr, old,
-							 (unsigned long)parent,
-							 fp);
-	/* If fails when getting the stack address of the non-leaf function's
-	 * ra, stop function graph tracer and return */
-	if (parent == 0)
+	parent = (unsigned long *)ftrace_get_parent_addr(
+			self_addr, old, (unsigned long)parent, fp);
+
+	/*
+	 * If fails on getting the stack address of the non-leaf function's ra,
+	 * stop function graph tracer and return
+	 */
+	if (unlikely(parent == 0))
 		goto out;
 #endif
 	/* *parent = return_hooker; */
diff --git a/arch/mips/kernel/mcount.S b/arch/mips/kernel/mcount.S
index 6851fc9..9ba0374 100644
--- a/arch/mips/kernel/mcount.S
+++ b/arch/mips/kernel/mcount.S
@@ -6,6 +6,7 @@
  * more details.
  *
  * Copyright (C) 2009 Lemote Inc. & DSLab, Lanzhou University, China
+ * Copyright (C) 2010 DSLab, Lanzhou University, China
  * Author: Wu Zhangjin <wuzhangjin@gmail.com>
  */
 
@@ -45,8 +46,6 @@
 	PTR_L	a5, PT_R9(sp)
 	PTR_L	a6, PT_R10(sp)
 	PTR_L	a7, PT_R11(sp)
-#endif
-#ifdef CONFIG_64BIT
 	PTR_ADDIU	sp, PT_SIZE
 #else
 	PTR_ADDIU	sp, (PT_SIZE + 8)
@@ -71,14 +70,14 @@ _mcount:
 
 	MCOUNT_SAVE_REGS
 #ifdef KBUILD_MCOUNT_RA_ADDRESS
-	PTR_S	t0, PT_R12(sp)	/* t0 saved the location of the return address(at) by -mmcount-ra-address */
+	PTR_S	$12, PT_R12(sp)	/* save location of parent's return address */
 #endif
 
-	move	a0, ra		/* arg1: next ip, selfaddr */
+	move	a0, ra		/* arg1: self return address */
 	.globl ftrace_call
 ftrace_call:
 	nop	/* a placeholder for the call to a real tracing function */
-	 move	a1, AT		/* arg2: the caller's next ip, parent */
+	 move	a1, AT		/* arg2: parent's return address */
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	.globl ftrace_graph_call
@@ -119,9 +118,9 @@ NESTED(_mcount, PT_SIZE, ra)
 static_trace:
 	MCOUNT_SAVE_REGS
 
-	move	a0, ra		/* arg1: next ip, selfaddr */
+	move	a0, ra		/* arg1: self return address */
 	jalr	t2		/* (1) call *ftrace_trace_function */
-	 move	a1, AT		/* arg2: the caller's next ip, parent */
+	 move	a1, AT		/* arg2: parent's return address */
 
 	MCOUNT_RESTORE_REGS
 	.globl ftrace_stub
@@ -134,28 +133,36 @@ ftrace_stub:
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 
 NESTED(ftrace_graph_caller, PT_SIZE, ra)
-#ifdef CONFIG_DYNAMIC_FTRACE
-	PTR_L	a1, PT_R31(sp)	/* load the original ra from the stack */
-#ifdef KBUILD_MCOUNT_RA_ADDRESS
-	PTR_L	t0, PT_R12(sp)	/* load the original t0 from the stack */
-#endif
-#else
+#ifndef CONFIG_DYNAMIC_FTRACE
 	MCOUNT_SAVE_REGS
-	move	a1, ra		/* arg2: next ip, selfaddr */
 #endif
 
+	/* arg1: Get the location of the parent's return address */
 #ifdef KBUILD_MCOUNT_RA_ADDRESS
-	bnez	t0, 1f		/* non-leaf func: t0 saved the location of the return address */
+#ifdef CONFIG_DYNAMIC_FTRACE
+	PTR_L	a0, PT_R12(sp)
+#else
+	move	a0, $12
+#endif
+	bnez	a0, 1f		/* arg1: non-leaf func: stored in $12 */
 	 nop
-	PTR_LA	t0, PT_R1(sp)	/* leaf func: get the location of at(old ra) from our own stack */
-1:	move	a0, t0		/* arg1: the location of the return address */
+#endif
+	PTR_LA	a0, PT_R1(sp)	/* leaf func: the location in current stack */
+
+1:
+	/* arg2: Get self return address */
+#ifdef CONFIG_DYNAMIC_FTRACE
+	PTR_L	a1, PT_R31(sp)
 #else
-	PTR_LA	a0, PT_R1(sp)	/* arg1: &AT -> a0 */
+	move	a1, ra
 #endif
+
 	jal	prepare_ftrace_return
+
+	/* arg3: Get frame pointer of current stack */
 #ifdef CONFIG_FRAME_POINTER
-	 move	a2, fp		/* arg3: frame pointer */
-#else
+	 move	a2, fp
+#else /* ! CONFIG_FRAME_POINTER */
 #ifdef CONFIG_64BIT
 	 PTR_LA	a2, PT_SIZE(sp)
 #else
-- 
1.7.0
