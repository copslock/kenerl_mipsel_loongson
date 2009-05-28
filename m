Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 May 2009 21:49:46 +0100 (BST)
Received: from wa-out-1112.google.com ([209.85.146.181]:45001 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20021938AbZE1UtU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 28 May 2009 21:49:20 +0100
Received: by wa-out-1112.google.com with SMTP id n4so931493wag.0
        for <multiple recipients>; Thu, 28 May 2009 13:49:17 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=VHYjiWagLOrkG6Sytl92mNNx9CHhxunJYSFbOeG/TOA=;
        b=HMuKokv2JuTkCSxBoWjSfQqLAnuiaxoo5/fjdeBN8aqSXdELxQdXmeXwUa1sULG0mp
         M+M8rDRgRCcgASpVs4Nr9+HVQBhrxsORoNQNe5AVvvh0SIJFbJMB0SFzW5l4s57RTX6p
         9o7U1XhJ9KerZDBWcJILPdfnfILEbPL5C1ifo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=kOGGdTHXTiyJXVgNNfJFrhEQtF43avsUrQAWUzjSoxkeoQBZQQyHmHiOFWX+550tYR
         xIw/O2nXzRlxpaJj61uuBdP5kSQYSmVTkiitRkvVlfsSq02GxJjHWgDg0xOzBTpenXz+
         LDCqbdmnjULYPorQBuRmMZLc0c0FbQN5dNkJk=
Received: by 10.114.72.17 with SMTP id u17mr3422841waa.41.1243543757487;
        Thu, 28 May 2009 13:49:17 -0700 (PDT)
Received: from localhost.localdomain ([219.246.59.144])
        by mx.google.com with ESMTPS id n6sm711408wag.39.2009.05.28.13.49.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 May 2009 13:49:17 -0700 (PDT)
From:	wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:	Wu Zhangjin <wuzj@lemote.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nicholas Mc Guire <der.herr@hofr.at>
Subject: [PATCH v1 3/5] mips function graph tracer support
Date:	Fri, 29 May 2009 04:49:07 +0800
Message-Id: <99ab6b652c259579a34b3592af06f59e28d5f570.1243543471.git.wuzj@lemote.com>
X-Mailer: git-send-email 1.6.3.1
In-Reply-To: <cover.1243543471.git.wuzj@lemote.com>
References: <cover.1243543471.git.wuzj@lemote.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23039
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzj@lemote.com>

this works something like -finstrument-functions does, instead of using

                void __cyg_profile_func_enter (void *this_fn,
                                                  void *call_site);
                   void __cyg_profile_func_exit  (void *this_fn,
                                                  void *call_site);

-pg use _mcount, so some tricks are adoptive by the author of orignal function
graph tracer:

	the _mcount function will call prepare_function_return to save the
	parent_ip, ip and calltime in a tracing array, if success, the
	address of a hooker function named return_to_handler will be
	substitued to the parent_ip, so, after return from _mcount it will
	call the return_to_handler, not back to the parent_ip, but calling
	ftrace_return_to_handler to remember the rettime, and return the
	parent_ip to let return_to_handler go back to the real parent.

Signed-off-by: Wu Zhangjin <wuzj@lemote.com>
---
 arch/mips/Kconfig              |    1 +
 arch/mips/kernel/ftrace.c      |   72 ++++++++++++++++++++++++++++++++++++++++
 arch/mips/kernel/mcount.S      |   58 +++++++++++++++++++++++++++++++-
 arch/mips/kernel/vmlinux.lds.S |    1 +
 4 files changed, 131 insertions(+), 1 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 0c00536..ac1437e 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -9,6 +9,7 @@ config MIPS
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FTRACE_NMI_ENTER if DYNAMIC_FTRACE
+	select HAVE_FUNCTION_GRAPH_TRACER
 	# Horrible source of confusion.  Die, die, die ...
 	select EMBEDDED
 	select RTC_LIB
diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
index 827c128..e7f15f7 100644
--- a/arch/mips/kernel/ftrace.c
+++ b/arch/mips/kernel/ftrace.c
@@ -215,3 +215,75 @@ int __init ftrace_dyn_arch_init(void *data)
     return 0;
 }
 #endif				/* CONFIG_DYNAMIC_FTRACE */
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+
+#ifdef CONFIG_DYNAMIC_FTRACE
+
+#define JMP	0x08000000			/* jump to target directly */
+extern void ftrace_graph_call(void);
+
+int ftrace_enable_ftrace_graph_caller(void)
+{
+    unsigned long ip = (unsigned long) (&ftrace_graph_call);
+    unsigned char old[MCOUNT_INSN_SIZE], *new;
+    int ret;
+
+	/* j ftrace_stub */
+    memcpy(old, (unsigned long *) ip, MCOUNT_INSN_SIZE);
+    new = ftrace_call_replace(JMP, (unsigned long) ftrace_graph_caller);
+
+    ret = ftrace_modify_code(ip, old, new);
+
+    return ret;
+}
+
+int ftrace_disable_ftrace_graph_caller(void)
+{
+    unsigned long ip = (unsigned long) (&ftrace_graph_call);
+    unsigned char old[MCOUNT_INSN_SIZE], *new;
+    int ret;
+
+	/* j ftrace_graph_caller */
+    memcpy(old, (unsigned long *) ip, MCOUNT_INSN_SIZE);
+    new = ftrace_call_replace(JMP, (unsigned long) ftrace_stub);
+
+    ret = ftrace_modify_code(ip, old, new);
+
+    return ret;
+}
+
+#endif				/* !CONFIG_DYNAMIC_FTRACE */
+
+/*
+ * Hook the return address and push it in the stack of return addrs
+ * in current thread info.
+ */
+
+unsigned long prepare_ftrace_return(unsigned long ip,
+				    unsigned long parent_ip)
+{
+    struct ftrace_graph_ent trace;
+
+    /* Nmi's are currently unsupported */
+    if (unlikely(in_nmi()))
+		goto out;
+
+    if (unlikely(atomic_read(&current->tracing_graph_pause)))
+		goto out;
+
+    if (ftrace_push_return_trace(parent_ip, ip, &trace.depth) == -EBUSY)
+		goto out;
+
+    trace.func = ip;
+
+    /* Only trace if the calling function expects to */
+    if (!ftrace_graph_entry(&trace)) {
+		current->curr_ret_stack--;
+		goto out;
+    }
+    return (unsigned long) &return_to_handler;
+out:
+    return parent_ip;
+}
+#endif				/* CONFIG_FUNCTION_GRAPH_TRACER */
diff --git a/arch/mips/kernel/mcount.S b/arch/mips/kernel/mcount.S
index ce8a0ba..bd58f16 100644
--- a/arch/mips/kernel/mcount.S
+++ b/arch/mips/kernel/mcount.S
@@ -28,6 +28,10 @@
 	PTR_SUBU	sp, PT_SIZE
 	PTR_S	ra, PT_R31(sp)
 	PTR_S	$1, PT_R1(sp)
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	PTR_S	v0, PT_R2(sp)
+	PTR_S	v1, PT_R3(sp)
+#endif
 	PTR_S	a0, PT_R4(sp)
 	PTR_S	a1, PT_R5(sp)
 	PTR_S	a2, PT_R6(sp)
@@ -43,6 +47,10 @@
 	.macro MCOUNT_RESTORE_REGS
 	PTR_L	ra, PT_R31(sp)
 	PTR_L	$1, PT_R1(sp)
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	PTR_L	v0, PT_R2(sp)
+	PTR_L	v1, PT_R3(sp)
+#endif
 	PTR_L	a0, PT_R4(sp)
 	PTR_L	a1, PT_R5(sp)
 	PTR_L	a2, PT_R6(sp)
@@ -89,6 +97,14 @@ ftrace_call:
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
@@ -106,7 +122,15 @@ NESTED(_mcount, PT_SIZE, ra)
 	PTR_L	t1, ftrace_trace_function /* please don't use t1 later, safe? */
 	bne	t0, t1, static_trace
 	nop
-
+#ifdef	CONFIG_FUNCTION_GRAPH_TRACER
+	PTR_L	t2, ftrace_graph_return
+	bne	t0,	t2, ftrace_graph_caller
+	nop
+	PTR_LA	t0, ftrace_graph_entry_stub
+	PTR_L	t2, ftrace_graph_entry
+	bne	t0,	t2, ftrace_graph_caller
+	nop
+#endif
 	j	ftrace_stub
 	nop
 
@@ -125,5 +149,37 @@ ftrace_stub:
 
 #endif	/* ! CONFIG_DYNAMIC_FTRACE */
 
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+
+NESTED(ftrace_graph_caller, PT_SIZE, ra)
+	MCOUNT_SAVE_REGS
+
+	MCOUNT_SET_ARGS
+	jal	prepare_ftrace_return
+	nop
+
+	/* overwrite the parent as &return_to_handler: v0 -> $1(at) */
+	PTR_S	v0, PT_R1(sp)
+
+	MCOUNT_RESTORE_REGS
+	RETURN_BACK
+	END(ftrace_graph_caller)
+
+	.align	2
+	.globl	return_to_handler
+return_to_handler:
+	MCOUNT_SAVE_REGS
+
+	jal	ftrace_return_to_handler
+	nop
+
+	/* restore the real parent address: v0 -> ra */
+	PTR_S	v0, PT_R31(sp)
+
+	MCOUNT_RESTORE_REGS
+	RETURN_BACK
+
+#endif /* CONFIG_FUNCTION_GRAPH_TRACER */
+
 	.set at
 	.set reorder
diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
index 58738c8..67435e5 100644
--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -36,6 +36,7 @@ SECTIONS
 		SCHED_TEXT
 		LOCK_TEXT
 		KPROBES_TEXT
+		IRQENTRY_TEXT
 		*(.text.*)
 		*(.fixup)
 		*(.gnu.warning)
-- 
1.6.0.4
