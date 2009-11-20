Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Nov 2009 13:37:40 +0100 (CET)
Received: from mail-px0-f173.google.com ([209.85.216.173]:65394 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1494104AbZKTMfu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 20 Nov 2009 13:35:50 +0100
Received: by mail-px0-f173.google.com with SMTP id 3so2384627pxi.22
        for <multiple recipients>; Fri, 20 Nov 2009 04:35:49 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=i80T7E21+dRqUUbO3Mkm9yLIAm36xcJvQLwlRtc2fvE=;
        b=FDZg5+ex64fUUgaBYyrPCMYbd6vOqzeUBQXJ7YNCPo5hnJ/n8qxrgB9LYNXtNr802B
         l1x+qfDaly3Lk5tsKCJF0DY6zaJmy2K2FYyanyx2BUrt64K2UQRY9f551uNSS//AYDHs
         Ykm3HkSQdRpMD4xCZ/LWGSwYYV2K9FGqX7fAk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=xY1poa0DUINwFN988gtWff8G+Es/tyWhi2nLqlte8/032wyO7fYWVxs0lNz7qkX7O4
         M3KygJwadH5hiMq/sH3z0lNVjBEVfTZv8r30qnVWCOTzrYH5pWqSBXoim9+KE2gqpwRt
         b7+bfmyutzh8jSDkAzdFzNvAQVvdYKfFeCg5M=
Received: by 10.114.7.9 with SMTP id 9mr1950214wag.71.1258720549541;
        Fri, 20 Nov 2009 04:35:49 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm931632pzk.2.2009.11.20.04.35.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Nov 2009 04:35:48 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>, rostedt@goodmis.org
Cc:	Nicholas Mc Guire <der.herr@hofr.at>, zhangfx@lemote.com,
	Wu Zhangjin <wuzhangjin@gmail.com>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH v9 07/10] tracing: add dynamic function graph tracer for MIPS
Date:	Fri, 20 Nov 2009 20:34:35 +0800
Message-Id: <c08257b0ef370f6e04ff9719bf7499bae28c70f4.1258719323.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <2276758e661b2b2362432851003df1d7c99d6cc0.1258719323.git.wuzhangjin@gmail.com>
References: <adf867c5a6864fa196c667d3f09a6a694f3903c5.1258719323.git.wuzhangjin@gmail.com>
 <51e30436a435480f1f0dec146a82f2b250900690.1258719323.git.wuzhangjin@gmail.com>
 <267c0824194b659b46fc038ba43492df30369fec.1258719323.git.wuzhangjin@gmail.com>
 <6a25a6132d64830bbd7339fe8b3841a51d02ac6d.1258719323.git.wuzhangjin@gmail.com>
 <2ffd3ecb5f0c96b43150968ce270dee71f6afdb8.1258719323.git.wuzhangjin@gmail.com>
 <2276758e661b2b2362432851003df1d7c99d6cc0.1258719323.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1258719323.git.wuzhangjin@gmail.com>
References: <cover.1258719323.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24998
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

This patch make function graph tracer work with dynamic function tracer.

To share the source code of dynamic function tracer(MCOUNT_SAVE_REGS),
and avoid restoring the whole saved registers, we need to restore the ra
register from the stack.

(NOTE: This not work with 32bit! need to ensure why!)

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/kernel/ftrace.c |   21 +++++++++++++++++++++
 arch/mips/kernel/mcount.S |   14 ++++++++++++--
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
index 65a3f8a..e981a49 100644
--- a/arch/mips/kernel/ftrace.c
+++ b/arch/mips/kernel/ftrace.c
@@ -115,6 +115,27 @@ int __init ftrace_dyn_arch_init(void *data)
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 
+#ifdef CONFIG_DYNAMIC_FTRACE
+
+extern void ftrace_graph_call(void);
+#define JMP	0x08000000	/* jump to target directly */
+#define CALL_FTRACE_GRAPH_CALLER \
+	jump_insn_encode(JMP, (unsigned long)(&ftrace_graph_caller))
+#define FTRACE_GRAPH_CALL_IP	((unsigned long)(&ftrace_graph_call))
+
+int ftrace_enable_ftrace_graph_caller(void)
+{
+	return ftrace_modify_code(FTRACE_GRAPH_CALL_IP,
+				  CALL_FTRACE_GRAPH_CALLER);
+}
+
+int ftrace_disable_ftrace_graph_caller(void)
+{
+	return ftrace_modify_code(FTRACE_GRAPH_CALL_IP, ftrace_nop);
+}
+
+#endif				/* !CONFIG_DYNAMIC_FTRACE */
+
 #define S_RA_SP	(0xafbf << 16)	/* s{d,w} ra, offset(sp) */
 #define S_R_SP	(0xafb0 << 16)  /* s{d,w} R, offset(sp) */
 #define OFFSET_MASK	0xffff	/* stack offset range: 0 ~ PT_SIZE */
diff --git a/arch/mips/kernel/mcount.S b/arch/mips/kernel/mcount.S
index b50e38d..98d4690 100644
--- a/arch/mips/kernel/mcount.S
+++ b/arch/mips/kernel/mcount.S
@@ -77,6 +77,13 @@ ftrace_call:
 	nop	/* a placeholder for the call to a real tracing function */
 	 move	a1, AT		/* arg2: the caller's next ip, parent */
 
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	.globl ftrace_graph_call
+ftrace_graph_call:
+	nop
+	 nop
+#endif
+
 	MCOUNT_RESTORE_REGS
 	.globl ftrace_stub
 ftrace_stub:
@@ -124,10 +131,13 @@ ftrace_stub:
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 
 NESTED(ftrace_graph_caller, PT_SIZE, ra)
+#ifdef CONFIG_DYNAMIC_FTRACE
+	PTR_L	a1, PT_R31(sp)	/* load the original ra from the stack */
+#else
 	MCOUNT_SAVE_REGS
-
-	PTR_LA	a0, PT_R1(sp)	/* arg1: &AT -> a0 */
 	move	a1, ra		/* arg2: next ip, selfaddr */
+#endif
+	PTR_LA	a0, PT_R1(sp)	/* arg1: &AT -> a0 */
 	jal	prepare_ftrace_return
 	 move	a2, fp		/* arg3: frame pointer */
 
-- 
1.6.2.1
