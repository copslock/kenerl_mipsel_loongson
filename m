Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 May 2010 15:26:52 +0200 (CEST)
Received: from mail-pz0-f194.google.com ([209.85.222.194]:60015 "EHLO
        mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491990Ab0ELNYg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 May 2010 15:24:36 +0200
Received: by mail-pz0-f194.google.com with SMTP id 32so732pzk.21
        for <multiple recipients>; Wed, 12 May 2010 06:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=q+xVDy031uD62TUUOP8JUluvVK/cI3eaq6iz6mtkMXg=;
        b=ICKAMCZ/cRDcEuG8hVWy+VEUXMvPUDWGdbppFvYtLjxazyitnXnx/s7We0P5bNhNAi
         SLVIFjx9JLXmGKDa0Msa7JhLyxmAVQSpMhkkniCLOlfDEKXC3ANZ8LycD0kUWX2gEF5b
         SjWp1vW2YCDpYVJKhs9mxHS62yndlWz2bLpfQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=WChW2UqfsPyq/pSqz9mzUWOFYILAgKUdfdWGSt3LcuFRtAbsraVNzL/2JMdtJpqO2B
         +3Xnm+R+EvHgfxiMump+wBLf+aj8pdh5sh6tAsRF87vnicipTaAMmXYkrp2wlg2Gs9rN
         Wn6CwHz0qXXBeaakgWq/3Cy5Zg4ovAOHo7yQs=
Received: by 10.114.18.39 with SMTP id 39mr5875374war.69.1273670674965;
        Wed, 12 May 2010 06:24:34 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id b6sm1273475wam.21.2010.05.12.06.24.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 12 May 2010 06:24:34 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH 7/9] tracing: MIPS: Reduce the overhead of dynamic Function Tracer
Date:   Wed, 12 May 2010 21:23:15 +0800
Message-Id: <f79b894e00ef69cdfa7e3f091e9e56edd8898033.1273669419.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1273669419.git.wuzhangjin@gmail.com>
References: <cover.1273669419.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1273669419.git.wuzhangjin@gmail.com>
References: <cover.1273669419.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26688
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

With the help of uasm, this patch encodes the instructions of dynamic
Function Tracer in ftrace_dyn_arch_init() when initializing it.

As a result, we can remove the dynamic encoding of instructions in
ftrace_make_nop()/call(), ftrace_enable_ftrace_graph_caller() and remove
the macro jump_insn_encode() and at last, reduces the overhead of
dynamic Function Tracer and also make the source code looks better.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/kernel/ftrace.c |   93 +++++++++++++++++++++++---------------------
 1 files changed, 49 insertions(+), 44 deletions(-)

diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
index b1b8fec..c4042ca 100644
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
@@ -12,21 +12,46 @@
 #include <linux/init.h>
 #include <linux/ftrace.h>
 
-#include <asm/cacheflush.h>
 #include <asm/asm.h>
 #include <asm/asm-offsets.h>
+#include <asm/cacheflush.h>
+#include <asm/uasm.h>
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 
 #define JAL 0x0c000000		/* jump & link: ip --> ra, jump to target */
 #define ADDR_MASK 0x03ffffff	/*  op_code|addr : 31...26|25 ....0 */
-#define jump_insn_encode(op_code, addr) \
-	((unsigned int)((op_code) | (((addr) >> 2) & ADDR_MASK)))
 
 #define INSN_B_1F_4 0x10000004	/* b 1f; offset = 4 */
 #define INSN_B_1F_5 0x10000005	/* b 1f; offset = 5 */
 #define INSN_NOP 0x00000000	/* nop */
-#define INSN_JAL(addr)	jump_insn_encode(JAL, addr)
+#define INSN_JAL(addr)	\
+	((unsigned int)(JAL | (((addr) >> 2) & ADDR_MASK)))
+
+static unsigned int insn_jal_ftrace_caller __read_mostly;
+static unsigned int insn_lui_v1_hi16_mcount __read_mostly;
+static unsigned int insn_j_ftrace_graph_caller __maybe_unused __read_mostly;
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
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	/* j ftrace_graph_caller */
+	buf = (u32 *)&insn_j_ftrace_graph_caller;
+	uasm_i_j(&buf, (unsigned long)ftrace_graph_caller);
+#endif
+}
 
 static int ftrace_modify_code(unsigned long ip, unsigned int new_code)
 {
@@ -43,30 +68,20 @@ static int ftrace_modify_code(unsigned long ip, unsigned int new_code)
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
+	/*
+	 * We have compiled module with -mlong-calls, but compiled the kernel
+	 * without it, we need to cope with them respectively.
+	 */
 	if (ip & 0x40000000) {
-		/* record it for ftrace_make_call */
-		if (lui_v1 == 0) {
-			/* lui_v1 = *(unsigned int *)ip; */
-			safe_load_code(lui_v1, ip, faulted);
-
-			if (unlikely(faulted))
-				return -EFAULT;
-		}
-
 #if defined(KBUILD_MCOUNT_RA_ADDRESS) && defined(CONFIG_32BIT)
-		/* lui v1, hi_16bit_of_mcount        --> b 1f (0x10000005)
+		/*
+		 * lui v1, hi_16bit_of_mcount        --> b 1f (0x10000005)
 		 * addiu v1, v1, low_16bit_of_mcount
 		 * move at, ra
 		 * move $12, ra_address
@@ -76,7 +91,8 @@ int ftrace_make_nop(struct module *mod,
 		 */
 		new = INSN_B_1F_5;
 #else
-		/* lui v1, hi_16bit_of_mcount        --> b 1f (0x10000004)
+		/*
+		 * lui v1, hi_16bit_of_mcount        --> b 1f (0x10000004)
 		 * addiu v1, v1, low_16bit_of_mcount
 		 * move at, ra
 		 * jalr v1
@@ -86,36 +102,22 @@ int ftrace_make_nop(struct module *mod,
 		new = INSN_B_1F_4;
 #endif
 	} else {
-		/* record/calculate it for ftrace_make_call */
-		if (jal_mcount == 0) {
-			/* We can record it directly like this:
-			 *     jal_mcount = *(unsigned int *)ip;
-			 * Herein, jump over the first two nop instructions */
-			jal_mcount = INSN_JAL(MCOUNT_ADDR + 8);
-		}
-
-		/* move at, ra
-		 * jalr v1		--> nop
+		/*
+		 * move at, ra
+		 * jal _mcount		--> nop
 		 */
 		new = INSN_NOP;
 	}
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
-		ftrace_modify_code(addr, INSN_NOP);
-	}
 	/* ip, module: 0xc0000000, kernel: 0x80000000 */
-	new = (ip & 0x40000000) ? lui_v1 : jal_mcount;
+	new = (ip & 0x40000000) ? insn_lui_v1_hi16_mcount : insn_jal_ftrace_caller;
 
 	return ftrace_modify_code(ip, new);
 }
@@ -133,6 +135,12 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
 
 int __init ftrace_dyn_arch_init(void *data)
 {
+	/* Encode the instructions when booting */
+	ftrace_dyn_arch_init_insns();
+
+	/* Remove "b ftrace_stub" to ensure ftrace_caller() is executed */
+	ftrace_modify_code(MCOUNT_ADDR, INSN_NOP);
+
 	/* The return code is retured via data */
 	*(unsigned long *)data = 0;
 
@@ -145,15 +153,12 @@ int __init ftrace_dyn_arch_init(void *data)
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
-- 
1.7.0.4
