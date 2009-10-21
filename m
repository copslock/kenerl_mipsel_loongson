Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Oct 2009 16:38:46 +0200 (CEST)
Received: from mail-bw0-f221.google.com ([209.85.218.221]:41500 "EHLO
	mail-bw0-f221.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493653AbZJUOfy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 21 Oct 2009 16:35:54 +0200
Received: by mail-bw0-f221.google.com with SMTP id 21so243449bwz.24
        for <multiple recipients>; Wed, 21 Oct 2009 07:35:54 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=ku3w5CZd7rdWWfZGvJUAnH0fm13VpxJ9A+EKK2pROdo=;
        b=qGA0hsczukb2TXEGOzZ97KFfnh1ojqsdk1zeM1ekK4faPmGpo6n0oLrCfrM0p/BnYs
         c++aPfxSzPDTW+2p7SguUXVQRjUiOq5HRmI1gc8OM0/fFFEq5guyGxG86RhQ/sY75gHi
         qMp9Gm1hcMNs0abj7lDSF8mH+cHYXYDVMBAEk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=w306H7Jj2X6AGEgilBOr3gcIg9oBcPT+8++6hHPZlOb0Ic0HLRr+AJr/T/KkrX5eIt
         H6FbYt2YGNcB2o62YdjpS4QPvBn7Z5+HQ82cgZc+WCi8c9zoDObEZE2ZsDxD8uCUPGMe
         a1+Al0wKxxmf72szX437m6vUhtS/vjtp6zMN8=
Received: by 10.204.154.69 with SMTP id n5mr3019713bkw.43.1256135754097;
        Wed, 21 Oct 2009 07:35:54 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 1sm303459fkt.11.2009.10.21.07.35.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 21 Oct 2009 07:35:53 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH -v4 9/9] tracing: add function graph tracer support for MIPS
Date:	Wed, 21 Oct 2009 22:35:03 +0800
Message-Id: <53bdfdd95ec4fa00d4cc505bb5972cf21243a14d.1256135456.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <a6f2959a69b6a77dd32cc36a5c8202f97d524f1e.1256135456.git.wuzhangjin@gmail.com>
References: <028867b99ec532b84963a35e7d552becc783cafc.1256135456.git.wuzhangjin@gmail.com>
 <2f73eae542c47ac5bbb9f7280e6c0271d193e90d.1256135456.git.wuzhangjin@gmail.com>
 <3f0d3515f74a58f4cfd11e61b62a129fdc21e3a7.1256135456.git.wuzhangjin@gmail.com>
 <ea8aa927fbd184b54941e4c2ae0be8ea0b4f6b8a.1256135456.git.wuzhangjin@gmail.com>
 <96110ea5dd4d3d54eb97d0bb708a5bd81c7a50b5.1256135456.git.wuzhangjin@gmail.com>
 <5dda13e8e3a9c9dba4bb7179183941bda502604f.1256135456.git.wuzhangjin@gmail.com>
 <af3ec1b5cd06b6f6a461c9fa7d09a51fabccb08d.1256135456.git.wuzhangjin@gmail.com>
 <a6f2959a69b6a77dd32cc36a5c8202f97d524f1e.1256135456.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1256135456.git.wuzhangjin@gmail.com>
References: <cover.1256135456.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24412
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

The implementation of function graph tracer for MIPS is a little
different from X86.

in MIPS, gcc(with -pg) only transfer the caller's return address(at) and
the _mcount's return address(ra) to us.

move at, ra
jal _mcount

in the function is a leaf, it will no save the return address(ra):

ffffffff80101298 <au1k_wait>:
ffffffff80101298:       67bdfff0        daddiu  sp,sp,-16
ffffffff8010129c:       ffbe0008        sd      s8,8(sp)
ffffffff801012a0:       03a0f02d        move    s8,sp
ffffffff801012a4:       03e0082d        move    at,ra
ffffffff801012a8:       0c042930        jal     ffffffff8010a4c0 <_mcount>
ffffffff801012ac:       00020021        nop

so, we can hijack it directly in _mcount, but if the function is non-leaf, the
return address is saved in the stack.

ffffffff80133030 <copy_process>:
ffffffff80133030:       67bdff50        daddiu  sp,sp,-176
ffffffff80133034:       ffbe00a0        sd      s8,160(sp)
ffffffff80133038:       03a0f02d        move    s8,sp
ffffffff8013303c:       ffbf00a8        sd      ra,168(sp)
ffffffff80133040:       ffb70098        sd      s7,152(sp)
ffffffff80133044:       ffb60090        sd      s6,144(sp)
ffffffff80133048:       ffb50088        sd      s5,136(sp)
ffffffff8013304c:       ffb40080        sd      s4,128(sp)
ffffffff80133050:       ffb30078        sd      s3,120(sp)
ffffffff80133054:       ffb20070        sd      s2,112(sp)
ffffffff80133058:       ffb10068        sd      s1,104(sp)
ffffffff8013305c:       ffb00060        sd      s0,96(sp)
ffffffff80133060:       03e0082d        move    at,ra
ffffffff80133064:       0c042930        jal     ffffffff8010a4c0 <_mcount>
ffffffff80133068:       00020021        nop

but we can not get the exact stack address(which saved ra) directly in
_mcount, we need to search the content of at register in the stack space
or search the "s{d,w} ra, offset(sp)" instruction in the text. 'Cause we
can not prove there is only a match in the stack space, so, we search
the text instead.

as we can see, if the first instruction above "move at, ra" is "move s8,
sp"(move fp, sp), it is a leaf function, so we hijack the at register
directly via put &return_to_handler into it, and otherwise, we search
the "s{d,w} ra, offset(sp)" instruction to get the stack offset, and
then the stack address. we use the above copy_process() as an example,
we at last find "ffbf00a8", 0xa8 is the stack offset, we plus it with
s8(fp), that is the stack address, we hijack the content via writing the
&return_to_handler in.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/Kconfig              |    1 +
 arch/mips/kernel/ftrace.c      |  192 ++++++++++++++++++++++++++++++++++++++++
 arch/mips/kernel/mcount.S      |   55 +++++++++++-
 arch/mips/kernel/vmlinux.lds.S |    1 +
 4 files changed, 248 insertions(+), 1 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 147fbbc..de690fd 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -8,6 +8,7 @@ config MIPS
 	select HAVE_FUNCTION_TRACE_MCOUNT_TEST
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_FTRACE_MCOUNT_RECORD
+	select HAVE_FUNCTION_GRAPH_TRACER
 	# Horrible source of confusion.  Die, die, die ...
 	select EMBEDDED
 	select RTC_LIB if !LEMOTE_FULOONG2E
diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
index 1e44865..fddee5b 100644
--- a/arch/mips/kernel/ftrace.c
+++ b/arch/mips/kernel/ftrace.c
@@ -13,6 +13,8 @@
 #include <linux/ftrace.h>
 
 #include <asm/cacheflush.h>
+#include <asm/asm.h>
+#include <asm/asm-offsets.h>
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 
@@ -105,3 +107,193 @@ int __init ftrace_dyn_arch_init(void *data)
 	return 0;
 }
 #endif				/* CONFIG_DYNAMIC_FTRACE */
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+
+#ifdef CONFIG_DYNAMIC_FTRACE
+
+#define JMP	0x08000000	/* jump to target directly */
+extern void ftrace_graph_call(void);
+
+int ftrace_enable_ftrace_graph_caller(void)
+{
+	unsigned long ip = (unsigned long)(&ftrace_graph_call);
+	unsigned char old[MCOUNT_INSN_SIZE], *new;
+	int ret;
+
+	/* j ftrace_stub */
+	memcpy(old, (unsigned long *)ip, MCOUNT_INSN_SIZE);
+	new = ftrace_call_replace(JMP, (unsigned long)ftrace_graph_caller);
+
+	ret = ftrace_modify_code(ip, old, new);
+
+	return ret;
+}
+
+int ftrace_disable_ftrace_graph_caller(void)
+{
+	unsigned long ip = (unsigned long)(&ftrace_graph_call);
+	unsigned char old[MCOUNT_INSN_SIZE], *new;
+	int ret;
+
+	/* j ftrace_graph_caller */
+	memcpy(old, (unsigned long *)ip, MCOUNT_INSN_SIZE);
+	new = ftrace_call_replace(JMP, (unsigned long)ftrace_stub);
+
+	ret = ftrace_modify_code(ip, old, new);
+
+	return ret;
+}
+
+#endif				/* !CONFIG_DYNAMIC_FTRACE */
+
+#define S_RA    (0x2fbf << 16)	/* 32bit: afbf, 64bit: ffbf */
+/* This is only available when enabled -fno-omit-frame-pointer with CONFIG_FRAME_POINTER=y */
+#define MOV_FP_SP       0x03a0f021	/* 32bit: 0x03a0f021, 64bit: 0x03a0f02d */
+#define STACK_OFFSET_MASK	0xfff	/* stack offset range: 0 ~ PT_SIZE(304) */
+
+unsigned long ftrace_get_parent_addr(unsigned long self_addr,
+				     unsigned long parent,
+				     unsigned long parent_addr,
+				     unsigned long fp)
+{
+	unsigned long sp, ip, ra;
+	unsigned int code;
+
+	/* move to the instruction "move ra, at" */
+	ip = self_addr - 8;
+
+	/* search the text until finding the "move s8, sp" instruction or
+	 * "s{d,w} ra, offset(sp)" instruction */
+	do {
+		ip -= 4;
+		/* read the text we want to match */
+		if (probe_kernel_read(&code, (void *)ip, 4)) {
+			WARN_ON(1);
+			panic("read the text failure\n");
+		}
+
+		/* if the first instruction above "move at, ra" is "move
+		 * s8(fp), sp", means the function is a leaf */
+		if ((code & MOV_FP_SP) == MOV_FP_SP)
+			return parent_addr;
+	} while (((code & S_RA) != S_RA));
+
+	sp = fp + (code & STACK_OFFSET_MASK);
+	ra = *(unsigned long *)sp;
+
+	if (ra == parent)
+		return sp;
+	else
+		panic
+		    ("failed on getting stack address of ra\n: addr: 0x%lx, code: 0x%x\n",
+		     ip, code);
+}
+
+/*
+ * Hook the return address and push it in the stack of return addrs
+ * in current thread info.
+ */
+void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
+			   unsigned long fp)
+{
+	unsigned long old;
+	int faulted;
+	struct ftrace_graph_ent trace;
+	unsigned long return_hooker = (unsigned long)
+	    &return_to_handler;
+
+	/*
+	 * Protect against fault, even if it shouldn't
+	 * happen. This tool is too much intrusive to
+	 * ignore such a protection.
+	 *
+	 * old = *parent;
+	 */
+	asm volatile (
+		"1: " STR(PTR_L) " %[old], 0(%[parent])\n"
+		"   li %[faulted], 0\n"
+		"2:\n"
+
+		".section .fixup, \"ax\"\n"
+		"3: li %[faulted], 1\n"
+		"   j 2b\n"
+		".previous\n"
+
+		".section\t__ex_table,\"a\"\n\t"
+		STR(PTR) "\t1b, 3b\n\t"
+		".previous\n"
+
+		: [old] "=&r" (old), [faulted] "=r" (faulted)
+		: [parent] "r" (parent)
+		: "memory"
+	);
+
+	if (unlikely(faulted)) {
+		ftrace_graph_stop();
+		WARN_ON(1);
+		return;
+	}
+
+	/* The argument *parent only work for leaf function, we need to check
+	 * whether the function is leaf, if not, we need to get the real stack
+	 * address which stored it.
+	 *
+	 * and here, we must stop tracing before calling probe_kernel_read().
+	 * after calling it, restart tracing. otherwise, it will hang there.*/
+	tracing_stop();
+	parent =
+	    (unsigned long *)ftrace_get_parent_addr(self_addr, old,
+						    (unsigned long)parent, fp);
+	tracing_start();
+
+	if (unlikely(atomic_read(&current->tracing_graph_pause)))
+		return;
+
+	/*
+	 * Protect against fault, even if it shouldn't
+	 * happen. This tool is too much intrusive to
+	 * ignore such a protection.
+	 *
+	 * *parent = return_hooker;
+	 */
+	asm volatile (
+		"1: " STR(PTR_S) " %[return_hooker], 0(%[parent])\n"
+		"   li %[faulted], 0\n"
+		"2:\n"
+
+		".section .fixup, \"ax\"\n"
+		"3: li %[faulted], 1\n"
+		"   j 2b\n"
+		".previous\n"
+
+		".section\t__ex_table,\"a\"\n\t"
+		STR(PTR) "\t1b, 3b\n\t"
+		".previous\n"
+
+		: [faulted] "=r" (faulted)
+		: [parent] "r" (parent), [return_hooker] "r" (return_hooker)
+		: "memory"
+	);
+
+	if (unlikely(faulted)) {
+		ftrace_graph_stop();
+		WARN_ON(1);
+		return;
+	}
+
+	if (ftrace_push_return_trace(old, self_addr, &trace.depth, fp) ==
+	    -EBUSY) {
+		*parent = old;
+		return;
+	}
+
+	trace.func = self_addr;
+
+	/* Only trace if the calling function expects to */
+	if (!ftrace_graph_entry(&trace)) {
+		current->curr_ret_stack--;
+		*parent = old;
+	}
+}
+#endif				/* CONFIG_FUNCTION_GRAPH_TRACER */
diff --git a/arch/mips/kernel/mcount.S b/arch/mips/kernel/mcount.S
index 30637e6..356e81c 100644
--- a/arch/mips/kernel/mcount.S
+++ b/arch/mips/kernel/mcount.S
@@ -89,6 +89,14 @@ ftrace_call:
 	nop
 
 	MCOUNT_RESTORE_REGS
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	.globl ftrace_graph_call
+ftrace_graph_call:
+	j	ftrace_stub
+	nop
+#endif
+
 	.globl ftrace_stub
 ftrace_stub:
 	RETURN_BACK
@@ -106,7 +114,15 @@ NESTED(_mcount, PT_SIZE, ra)
 	PTR_L	t1, ftrace_trace_function /* please don't use t1 later, safe? */
 	bne	t0, t1, static_trace
 	nop
-
+#ifdef	CONFIG_FUNCTION_GRAPH_TRACER
+	PTR_L	t2, ftrace_graph_return
+	bne	t0, t2, ftrace_graph_caller
+	nop
+	PTR_LA	t0, ftrace_graph_entry_stub
+	PTR_L	t2, ftrace_graph_entry
+	bne	t0, t2, ftrace_graph_caller
+	nop
+#endif
 	j	ftrace_stub
 	nop
 
@@ -125,5 +141,42 @@ ftrace_stub:
 
 #endif	/* ! CONFIG_DYNAMIC_FTRACE */
 
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+
+NESTED(ftrace_graph_caller, PT_SIZE, ra)
+	MCOUNT_SAVE_REGS
+
+	PTR_LA	a0, PT_R1(sp)	/* arg1: &AT -> a0 */
+	move	a1, ra		/* arg2: next ip, selfaddr */
+	PTR_SUBU a1, MCOUNT_INSN_SIZE
+	move	a2, fp		/* arg3: frame pointer */
+	jal	prepare_ftrace_return
+	nop
+
+	MCOUNT_RESTORE_REGS
+	RETURN_BACK
+	END(ftrace_graph_caller)
+
+	.align	2
+	.globl	return_to_handler
+return_to_handler:
+	PTR_SUBU	sp, PT_SIZE
+	PTR_S	v0, PT_R2(sp)
+	PTR_S	v1, PT_R3(sp)
+
+	jal	ftrace_return_to_handler
+	nop
+
+	/* restore the real parent address: v0 -> ra */
+	move	ra, v0
+
+	PTR_L	v0, PT_R2(sp)
+	PTR_L	v1, PT_R3(sp)
+	PTR_ADDIU	sp, PT_SIZE
+
+	jr	ra
+	nop
+#endif /* CONFIG_FUNCTION_GRAPH_TRACER */
+
 	.set at
 	.set reorder
diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
index 162b299..f25df73 100644
--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -46,6 +46,7 @@ SECTIONS
 		SCHED_TEXT
 		LOCK_TEXT
 		KPROBES_TEXT
+		IRQENTRY_TEXT
 		*(.text.*)
 		*(.fixup)
 		*(.gnu.warning)
-- 
1.6.2.1
