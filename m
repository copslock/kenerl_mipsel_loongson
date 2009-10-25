Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Oct 2009 16:21:43 +0100 (CET)
Received: from mail-px0-f187.google.com ([209.85.216.187]:59553 "EHLO
	mail-px0-f187.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492483AbZJYPSj (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 25 Oct 2009 16:18:39 +0100
Received: by pxi17 with SMTP id 17so581730pxi.21
        for <multiple recipients>; Sun, 25 Oct 2009 08:18:33 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=ctwMzDmiK3gO72s2E36UENYVjjQAFDdTA5aVbqSoJm8=;
        b=IKcUF3YGvhb0gXbOf9yQMGU/p0vGgnunVRqq7vlRR1NxDpusEV+hwk9EpbAMUvD63L
         7oAqG8xtXlSgGtb+TlT2goD43XsKC5JLhvlOsrrNCxHxAKPE6Xkk/uEUK8Mf0TT1iUYC
         bSV61tcRQ5teWx2KTGXVqL28ts4oF7XZkMX9s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=xiPa5d0iR1X4ASsZneERhV1RR3q9cNO2fyWLQmOUCelBjayImCduuwI7fRDN8jm/E+
         xCvPYM4K0+4+ffrBnwdsXh6LuaAeLj8K7Vbos9ilC1PpKWAeemXuVSnAKgRMifg4rsmA
         DyCW+UnMzI3I14XUBPlbZ5ASgVmIEAJo78VCg=
Received: by 10.114.162.5 with SMTP id k5mr20488422wae.10.1256483913206;
        Sun, 25 Oct 2009 08:18:33 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm1742515pxi.14.2009.10.25.08.18.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Oct 2009 08:18:32 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>, rostedt@goodmis.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Richard Sandiford <rdsandiford@googlemail.com>,
	David Daney <ddaney@caviumnetworks.com>,
	Adam Nemet <anemet@caviumnetworks.com>,
	Patrik Kluba <kpajko79@gmail.com>
Subject: [PATCH -v5 10/11] tracing: add function graph tracer support for MIPS
Date:	Sun, 25 Oct 2009 23:17:01 +0800
Message-Id: <ac9c325539cc056d9539c96a68743a425f9612ce.1256483735.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <6ad82af0c2ec8ef7b9f536b0a97bf65d385c3945.1256483735.git.wuzhangjin@gmail.com>
References: <cover.1256482555.git.wuzhangjin@gmail.com>
 <028867b99ec532b84963a35e7d552becc783cafc.1256483735.git.wuzhangjin@gmail.com>
 <2f73eae542c47ac5bbb9f7280e6c0271d193e90d.1256483735.git.wuzhangjin@gmail.com>
 <3e0c2d7d8b8f196a8153beb41ea7f3cbf42b3d84.1256483735.git.wuzhangjin@gmail.com>
 <54c417629e91f40b2bbb4e08cda2a4e6527824c0.1256483735.git.wuzhangjin@gmail.com>
 <29bccff04932e993ecd9f516d8b6dcf84e2ceecf.1256483735.git.wuzhangjin@gmail.com>
 <72f2270f7b6e01ca7a4cdf4ac8c21778e5d9652f.1256483735.git.wuzhangjin@gmail.com>
 <6140dd8f4e1783e5ac30977cf008bb98e4698322.1256483735.git.wuzhangjin@gmail.com>
 <49b3c441a57f4db423732f81432a3450ccb3240e.1256483735.git.wuzhangjin@gmail.com>
 <6ad82af0c2ec8ef7b9f536b0a97bf65d385c3945.1256483735.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1256483735.git.wuzhangjin@gmail.com>
References: <cover.1256483735.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24493
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

if the function is a leaf, it will no save the return address(ra):

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

as we can see, if the first instruction above "move at, ra" is "move
s8(fp), sp"(only available with -fno-omit-frame-pointer which is enabled
by CONFIG_FRAME_POINTER), it is a leaf function, so we hijack the at
register directly via putting &return_to_handler into it, otherwise, we
search the "s{d,w} ra, offset(sp)" instruction to get the stack offset,
and then the stack address. we use the above copy_process() as an
example, we at last find "ffbf00a8", 0xa8 is the stack offset, we plus
it with s8(fp), that is the stack address, we hijack the content via
writing the &return_to_handler in.

(As pajko <kpajko79@gmail.com> recommend, if we enable
 PROFILE_BEFORE_PROLOGUE in gcc/config/mips/mips.h, there will be no
 difference between non-leaf and leaf function, we hope
 PROFILE_BEFORE_PROLOGUE will be enabled by default in the future
 version of gcc, so, we can remove ftrace_get_parent_addr() directly. )

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/Kconfig         |    1 +
 arch/mips/kernel/ftrace.c |   93 +++++++++++++++++++++++++++++++++++++++++++++
 arch/mips/kernel/mcount.S |   47 ++++++++++++++++++++++-
 3 files changed, 140 insertions(+), 1 deletions(-)

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
index 0be30cf..4cf11f5 100644
--- a/arch/mips/kernel/ftrace.c
+++ b/arch/mips/kernel/ftrace.c
@@ -13,6 +13,8 @@
 #include <linux/ftrace.h>
 
 #include <asm/cacheflush.h>
+#include <asm/asm.h>
+#include <asm/asm-offsets.h>
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 
@@ -74,3 +76,94 @@ int __init ftrace_dyn_arch_init(void *data)
 	return 0;
 }
 #endif				/* CONFIG_DYNAMIC_FTRACE */
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+
+#define S_RA    (0x2fbf << 16)	/* 32bit: afbf, 64bit: ffbf */
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
+
+		/* get the code at "ip" */
+		code = *(unsigned int *)ip;
+
+		/* If we hit the "move s8(fp), sp" instruction before finding
+		 * where the ra is stored, then this is a leaf function and it
+		 * does not store the ra on the stack. */
+		if ((code & MOV_FP_SP) == MOV_FP_SP)
+			return parent_addr;
+	} while (((code & S_RA) != S_RA));
+
+	sp = fp + (code & STACK_OFFSET_MASK);
+	ra = *(unsigned long *)sp;
+
+	if (ra == parent)
+		return sp;
+
+	ftrace_graph_stop();
+	WARN_ON(1);
+	return parent_addr;
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
+	struct ftrace_graph_ent trace;
+	unsigned long return_hooker = (unsigned long)
+	    &return_to_handler;
+
+	if (unlikely(atomic_read(&current->tracing_graph_pause)))
+		return;
+
+	/* "parent" is the stack address saved the return address of the caller
+	 * of _mcount, for a leaf function not save the return address in the
+	 * stack address, so, we "emulate" one in _mcount's stack space, and
+	 * hijack it directly, but for a non-leaf function, it will save the
+	 * return address to the its stack space, so, we can not hijack the
+	 * "parent" directly, but need to find the real stack address,
+	 * ftrace_get_parent_addr() does it!
+	 */
+
+	old = *parent;
+
+	parent = (unsigned long *)ftrace_get_parent_addr(self_addr, old,
+							 (unsigned long)parent,
+							 fp);
+
+	*parent = return_hooker;
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
index 389be7b..a9ba888 100644
--- a/arch/mips/kernel/mcount.S
+++ b/arch/mips/kernel/mcount.S
@@ -99,7 +99,15 @@ NESTED(_mcount, PT_SIZE, ra)
 	PTR_L	t1, ftrace_trace_function /* Prepare t1 for (1) */
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
 
@@ -118,5 +126,42 @@ ftrace_stub:
 
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
-- 
1.6.2.1
