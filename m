Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 14 Nov 2009 07:39:15 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:41548 "EHLO
	mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492347AbZKNGgC (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 14 Nov 2009 07:36:02 +0100
Received: by mail-pw0-f45.google.com with SMTP id 15so2475092pwi.24
        for <multiple recipients>; Fri, 13 Nov 2009 22:36:01 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=i80T7E21+dRqUUbO3Mkm9yLIAm36xcJvQLwlRtc2fvE=;
        b=fb4z0IehhdevsrUZyj7XuKVmSyM0Z4VcG/5GG9cJyfruFI5pBs9FCuGk9HcoXZZ1/F
         hftdBRAbEAq8328ZXkCHvNWp+IgPN5Lfq9Rp2kGpUFBKuS73llGs6eTtBXwIj82+4Utl
         n9ichPtBKDLSJHTo6DdT4Xh9W2cjAqOV3yJVk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ZwIaebvKCXEwYmgEhviDbvlarm6B+AqWrZp6CckqIDOOpuOSu8ENxQKvpfOjW+jvlU
         WnfCYGWO5BV3D/D7oxEekFPZQQdLxJje9eD6aiIrwpICqNq0UlWQ0ABXufCNhROQ/PcF
         fh9T8ftiAC+4/osIobgdAK1vIOJc4/zLekU18=
Received: by 10.115.26.2 with SMTP id d2mr9216778waj.14.1258180561660;
        Fri, 13 Nov 2009 22:36:01 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 20sm2668108pzk.5.2009.11.13.22.35.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 13 Nov 2009 22:36:01 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	rostedt@goodmis.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Ingo Molnar <mingo@elte.hu>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	David Daney <ddaney@caviumnetworks.com>,
	Richard Sandiford <rdsandiford@googlemail.com>,
	Patrik Kluba <kpajko79@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Michal Simek <monstr@monstr.eu>,
	"Maciej W . Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	zhangfx@lemote.com, zhouqg@gmail.com
Subject: [PATCH v8 13/16] tracing: add dynamic function graph tracer for MIPS
Date:	Sat, 14 Nov 2009 14:33:28 +0800
Message-Id: <af765bca2a5f969f13de1b9f61744e6523d1afe8.1258177321.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <8a7987bba58526a0e156f531dba31d9a65d3d744.1258177321.git.wuzhangjin@gmail.com>
References: <9dc81a7a9e5a292cccdf465c533a2b08d19d6021.1258177321.git.wuzhangjin@gmail.com>
 <b99c08397d9ff92ac5a72bda9131df41b702fc71.1258177321.git.wuzhangjin@gmail.com>
 <8f579e2cece16cd22358a4ec143ef6a8c462639b.1258177321.git.wuzhangjin@gmail.com>
 <ea337742d3ca7eec2825416041a6d4fa917d5cc4.1258177321.git.wuzhangjin@gmail.com>
 <7c7568247ad6cc109ec20387cfc3ca258d1d430f.1258177321.git.wuzhangjin@gmail.com>
 <3fcaffcfb3c8c8cd3015151ed5b7480ccaecde0f.1258177321.git.wuzhangjin@gmail.com>
 <48676d84140dbafd46e530611766121e18abc4ef.1258177321.git.wuzhangjin@gmail.com>
 <99ebd8fcb19e4cccd702fca966405ffc45f8540b.1258177321.git.wuzhangjin@gmail.com>
 <c1fe0d6822e98bc0ffd2dfee7a579fbbe21430e0.1258177321.git.wuzhangjin@gmail.com>
 <f3a54cef2de00885ee75a930b243083a716370bd.1258177321.git.wuzhangjin@gmail.com>
 <b98ca1b2048aeab8aac82ec8723ac729c2cd4b54.1258177321.git.wuzhangjin@gmail.com>
 <8a7987bba58526a0e156f531dba31d9a65d3d744.1258177321.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1258177321.git.wuzhangjin@gmail.com>
References: <cover.1258177321.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24904
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
