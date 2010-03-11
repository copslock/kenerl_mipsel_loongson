Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Mar 2010 19:14:34 +0100 (CET)
Received: from mail-fx0-f225.google.com ([209.85.220.225]:52427 "EHLO
        mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491808Ab0CKSO2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Mar 2010 19:14:28 +0100
Received: by fxm25 with SMTP id 25so354721fxm.27
        for <multiple recipients>; Thu, 11 Mar 2010 10:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=I5xjgi3IcUPYos9bMFdXsgiMIz+GDRcVkjj30DV/y5c=;
        b=NGUOg7jVXuO8BvEiWcYLlomGz9AvPbjnf5RjrJUy00m6SXtACMW76k+QFXu0xBOG+G
         tLdxqYTtrJy68DTsVYiZdykfHMecklFOLcEMimNvv/pOTmq31wqTWco+p6LVLw2b/9o7
         6W+2sjOlk7ag4UFx3hWe+Qcx0TkvjQd6inwnc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=a5tq4ksLjQfsBUIthDn3Yb9zx1AUfy7drgQ10WTiWl4PTKtow4FoawMI6+4srmMzKS
         RXkIxfNkyBxgHxXZ+dlBIHUcp7MQT/s+YpyT37cgALy5SWgoCeqxoAEPzTHdQ/YwwQmn
         jKJ6J8KOUOcPWf7QdlGJCrnHoPzVEocn22dPY=
Received: by 10.223.60.142 with SMTP id p14mr596730fah.47.1268331261722;
        Thu, 11 Mar 2010 10:14:21 -0800 (PST)
Received: from localhost.localdomain ([202.201.12.142])
        by mx.google.com with ESMTPS id 13sm555734fks.0.2010.03.11.10.14.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Mar 2010 10:14:20 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Steven Rostedt <srostedt@redhat.com>, linux-mips@linux-mips.org,
        David Daney <ddaney@caviumnetworks.com>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH] MIPS: tracing: Optimize the implementation
Date:   Fri, 12 Mar 2010 02:07:37 +0800
Message-Id: <8b93c417fefa4d446f801abfd718ba94fdcb1821.1268330348.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26204
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

(All of the stuff have been tested for kernel and module, including static
 function tracer, dynamic function tracer and function graph tracer.)

Changes:

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
 arch/mips/include/asm/ftrace.h |   10 ++-
 arch/mips/kernel/ftrace.c      |  201 ++++++++++++++++++++++------------------
 2 files changed, 119 insertions(+), 92 deletions(-)

diff --git a/arch/mips/include/asm/ftrace.h b/arch/mips/include/asm/ftrace.h
index ce35c9a..e58f9ff 100644
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
 
@@ -19,6 +19,12 @@
 extern void _mcount(void);
 #define mcount _mcount
 
+/*
+ * If the Instruction Pointer is in module space (0xc0000000), return ture;
+ * otherwise, it is in kernel space (0x80000000), return false.
+ */
+#define in_module(ip) (unlikely((ip) & 0x40000000))
+
 #define safe_load(load, src, dst, error)		\
 do {							\
 	asm volatile (					\
@@ -83,8 +89,8 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
 
 struct dyn_arch_ftrace {
 };
+#endif /* CONFIG_DYNAMIC_FTRACE */
 
-#endif /*  CONFIG_DYNAMIC_FTRACE */
 #endif /* __ASSEMBLY__ */
 #endif /* CONFIG_FUNCTION_TRACER */
 #endif /* _ASM_MIPS_FTRACE_H */
diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
index e9e64e0..c38e3d9 100644
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
@@ -15,15 +15,50 @@
 #include <asm/cacheflush.h>
 #include <asm/asm.h>
 #include <asm/asm-offsets.h>
+#include <asm/uasm.h>
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 
-#define JAL 0x0c000000		/* jump & link: ip --> ra, jump to target */
-#define ADDR_MASK 0x03ffffff	/*  op_code|addr : 31...26|25 ....0 */
-#define jump_insn_encode(op_code, addr) \
-	((unsigned int)((op_code) | (((addr) >> 2) & ADDR_MASK)))
+/* Before linking, the following instructions are fixed. */
+#ifdef CONFIG_CPU_LOONGSON2F
+/* insn: or at, at, zero */
+#define INSN_NOP 0x00200825
+#else
+/* insn: nop */
+#define INSN_NOP 0x00000000
+#endif
+
+/* insn: b 1f; offset = (16 >> 2) */
+#define INSN_B_1F 0x10000004
+
+/* After linking, the following instructions are fixed. */
+static unsigned int insn_jal_ftrace_caller __read_mostly;
+static unsigned int insn_lui_v1_hi16_mcount __read_mostly;
+static unsigned int insn_j_ftrace_graph_caller __read_mostly;
 
-static unsigned int ftrace_nop = 0x00000000;
+/* The following instructions are encoded in the run-time */
+/* insn: jal func; op_code|addr : 31...26|25 ....0 */
+#define jal(addr) \
+	((unsigned int)(0x0c000000 | (((addr) >> 2) & 0x03ffffff)))
+
+static inline void ftrace_dyn_arch_init_insns(void)
+{
+	u32 *buf;
+	unsigned int v1;
+
+	/* lui v1, hi16_mcount */
+	v1 = 3;
+	buf = (u32 *)&insn_lui_v1_hi16_mcount;
+	UASM_i_LA_mostly(&buf, v1, MCOUNT_ADDR);
+
+	/* jal (ftrace_caller + 8), jump over the first two instruction */
+	buf = (u32 *)&insn_jal_ftrace_caller;
+	uasm_i_jal(&buf, (FTRACE_ADDR + 8));
+
+	/* j ftrace_graph_caller */
+	buf = (u32 *)&insn_j_ftrace_graph_caller;
+	uasm_i_j(&buf, (unsigned long)ftrace_graph_caller);
+}
 
 static int ftrace_modify_code(unsigned long ip, unsigned int new_code)
 {
@@ -31,7 +66,6 @@ static int ftrace_modify_code(unsigned long ip, unsigned int new_code)
 
 	/* *(unsigned int *)ip = new_code; */
 	safe_store_code(new_code, ip, faulted);
-
 	if (unlikely(faulted))
 		return -EFAULT;
 
@@ -40,117 +74,101 @@ static int ftrace_modify_code(unsigned long ip, unsigned int new_code)
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
-	}
+	/*
+	 * We have compiled modules with -mlong-calls, but compiled kernel
+	 * without it, therefore, need to cope with them respectively.
+	 *
+	 * For module:
+	 *
+	 *	lui	v1, hi16_mcount		--> b	1f
+	 *	addiu	v1, v1, lo16_mcount
+	 *	move	at, ra
+	 *	jalr	v1
+	 *	 nop
+	 *					1f: (ip + 16)
+	 * For kernel:
+	 *
+	 *	move	at, ra
+	 *	jal	_mcount			--> nop
+	 *
+	 */
+	new = in_module(ip) ? INSN_B_1F : INSN_NOP;
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
+	new = jal((unsigned long)func);
 
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
 
 	return 0;
 }
-#endif				/* CONFIG_DYNAMIC_FTRACE */
+#endif	/* CONFIG_DYNAMIC_FTRACE */
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 
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
 
-#endif				/* !CONFIG_DYNAMIC_FTRACE */
+#endif	/* !CONFIG_DYNAMIC_FTRACE */
 
 #ifndef KBUILD_MCOUNT_RA_ADDRESS
-#define S_RA_SP	(0xafbf << 16)	/* s{d,w} ra, offset(sp) */
-#define S_R_SP	(0xafb0 << 16)  /* s{d,w} R, offset(sp) */
+#define S_RA_SP	0xafbf0000	/* s{d,w} ra, offset(sp) */
+#define S_R_SP		0xafb00000	/* s{d,w} R, offset(sp) */
 #define OFFSET_MASK	0xffff	/* stack offset range: 0 ~ PT_SIZE */
 
 unsigned long ftrace_get_parent_addr(unsigned long self_addr,
@@ -162,32 +180,32 @@ unsigned long ftrace_get_parent_addr(unsigned long self_addr,
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
+		 * store the ra on the stack.
+		 */
 		if ((code & S_R_SP) != S_R_SP)
 			return parent_addr;
-
 	} while (((code & S_RA_SP) != S_RA_SP));
 
 	sp = fp + (code & OFFSET_MASK);
@@ -211,16 +229,17 @@ unsigned long ftrace_get_parent_addr(unsigned long self_addr,
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
@@ -241,12 +260,14 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
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
@@ -272,4 +293,4 @@ out:
 	ftrace_graph_stop();
 	WARN_ON(1);
 }
-#endif				/* CONFIG_FUNCTION_GRAPH_TRACER */
+#endif	/* CONFIG_FUNCTION_GRAPH_TRACER */
-- 
1.7.0.1
