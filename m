Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Nov 2009 16:37:02 +0100 (CET)
Received: from mail-ew0-f216.google.com ([209.85.219.216]:46041 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493079AbZKIPdY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 9 Nov 2009 16:33:24 +0100
Received: by mail-ew0-f216.google.com with SMTP id 12so3364851ewy.0
        for <multiple recipients>; Mon, 09 Nov 2009 07:33:24 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=rd0FcCzgif7TpepfeUkIJvKRW1AEzPjeU0KX8Zpzoh0=;
        b=fb6TXoSwKz9vYeHQgqZMCV2437jpagf6ENVnyKE7VbR6ZG/BB+zDmK9qOtkJVrK8hx
         w4rqC0KOninKijhsUV17KAAMTCnVArz+kCtmIjB6k+Xoy0h10iWziRQyaXzjb1DU+7Je
         fYlUXHfAX3Wtnv4+M5PEy2nJEsDwirxp+fOJ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=lVtkcz7ysmvaeZDX9ySGM2aoS/ASpAIcr54s+5pIyGvkl+I+YunFLNwvvnjFMVL+U8
         HxrdSgmY/umTh5Rc8PWtUMWSZRJs8qjmXAlSfN+nni81VTq/5z2Nuv238xidqIO23XG/
         Hz4ooMw532NgnX3O4HaNxFycmHrINSbZO/3C0=
Received: by 10.216.93.78 with SMTP id k56mr2566322wef.102.1257780804299;
        Mon, 09 Nov 2009 07:33:24 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id g9sm9033556gvc.25.2009.11.09.07.33.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 07:33:23 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:	zhangfx@lemote.com, zhouqg@gmail.com,
	Wu Zhangjin <wuzhangjin@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>, rostedt@goodmis.org,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Ingo Molnar <mingo@elte.hu>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	David Daney <ddaney@caviumnetworks.com>,
	Richard Sandiford <rdsandiford@googlemail.com>,
	Patrik Kluba <kpajko79@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Michal Simek <monstr@monstr.eu>
Subject: [PATCH v7 13/17] tracing: add dynamic function graph tracer for MIPS
Date:	Mon,  9 Nov 2009 23:31:30 +0800
Message-Id: <0c463e2af521e613fd15751a9f610c74cf887292.1257779502.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <451c55dead5d6afd871de6afd14dbbcf70a0f834.1257779502.git.wuzhangjin@gmail.com>
References: <9dc81a7a9e5a292cccdf465c533a2b08d19d6021.1257779502.git.wuzhangjin@gmail.com>
 <b99c08397d9ff92ac5a72bda9131df41b702fc71.1257779502.git.wuzhangjin@gmail.com>
 <8f579e2cece16cd22358a4ec143ef6a8c462639b.1257779502.git.wuzhangjin@gmail.com>
 <cefe074f5eb3cfbc2e0bb41b0c1f61fcd0190d90.1257779502.git.wuzhangjin@gmail.com>
 <6199d7b3956b544fc65896af1062787a2e1283ce.1257779502.git.wuzhangjin@gmail.com>
 <58a7558730fbea6cd0417100c8fcd6f45668d1e3.1257779502.git.wuzhangjin@gmail.com>
 <3a9fc9ca02e8e6e9c3c28797a4c084c1f9d91f69.1257779502.git.wuzhangjin@gmail.com>
 <0cef783a71333ff96a78aaea8961e3b6b5392665.1257779502.git.wuzhangjin@gmail.com>
 <18e1d617ed824bb1c10f15216f2ed9ed3de78abd.1257779502.git.wuzhangjin@gmail.com>
 <3da916c1cb6e05445438826f98a91111f43ff6cd.1257779502.git.wuzhangjin@gmail.com>
 <d4aa4cdb9b4c25e7a683c923bdeabed847bd8010.1257779502.git.wuzhangjin@gmail.com>
 <451c55dead5d6afd871de6afd14dbbcf70a0f834.1257779502.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1257779502.git.wuzhangjin@gmail.com>
References: <cover.1257779502.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24785
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
index 50ba128..af3ceed 100644
--- a/arch/mips/kernel/ftrace.c
+++ b/arch/mips/kernel/ftrace.c
@@ -92,6 +92,27 @@ int __init ftrace_dyn_arch_init(void *data)
 
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
