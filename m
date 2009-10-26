Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Oct 2009 16:19:53 +0100 (CET)
Received: from mail-qy0-f202.google.com ([209.85.221.202]:37988 "EHLO
	mail-qy0-f202.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493128AbZJZPQT (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 26 Oct 2009 16:16:19 +0100
Received: by mail-qy0-f202.google.com with SMTP id 40so1400531qyk.22
        for <multiple recipients>; Mon, 26 Oct 2009 08:16:19 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=bOPMqIWmF6XuOn0mvGM2V84NIs/qcB5OL69StbQJTIA=;
        b=t0kmuLCUEuzSqxFJ2KfqzrpqeXwlTrkCRl7tnhgW2ERYX9uyA29dJzouSa7G/23IZd
         jtXXFZ86LhUWnriITx02huUzPKs5RoiXyVQtExLK4r6ZLWRr7+d1z97+7m1/uTtKa5/i
         orcbi5adol8XU3IrUDREBmuQ2XdSjxU+Kh1J4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=oDtdicuJmq4E1RZ6YPTveXqWSdBgB2dcoJs8MVsT44Xo7GmNP/QxAL3MD0F0b9+SxE
         XWAriSWoWY9sRVIIpW4rXphbwICoxEgVWfErNp3lppU6OKTXtvovjkkrbk6opm8IpExr
         sFCUvCsWRt1oaMKq3GgBY27AaESBfkT8xFhdc=
Received: by 10.224.101.132 with SMTP id c4mr7123558qao.377.1256570179103;
        Mon, 26 Oct 2009 08:16:19 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 21sm3876989qyk.0.2009.10.26.08.16.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Oct 2009 08:16:14 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>,
	Frederic Weisbecker <fweisbec@gmail.com>, rostedt@goodmis.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Richard Sandiford <rdsandiford@googlemail.com>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	David Daney <ddaney@caviumnetworks.com>,
	Adam Nemet <anemet@caviumnetworks.com>,
	Patrik Kluba <kpajko79@gmail.com>
Subject: [PATCH -v6 13/13] tracing: add dynamic function graph tracer for MIPS
Date:	Mon, 26 Oct 2009 23:13:30 +0800
Message-Id: <ee544ea8570821c0ff73fa155bfd8484bd6f1a74.1256569489.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <60dd7085d4df145318582d0a829887b4abf6e6c1.1256569489.git.wuzhangjin@gmail.com>
References: <cover.1256569489.git.wuzhangjin@gmail.com>
 <747deea2f18d5ccffe842df95a9dd1c86251a958.1256569489.git.wuzhangjin@gmail.com>
 <3f47087b70a965fd679b17a59521671296457df1.1256569489.git.wuzhangjin@gmail.com>
 <f290e125634d164ec65b09b24b269815f78455ab.1256569489.git.wuzhangjin@gmail.com>
 <07dc907ec62353b1aca99b2850d3b2e4b734189a.1256569489.git.wuzhangjin@gmail.com>
 <374da7039d2e1b97083edd8bcd7811356884d427.1256569489.git.wuzhangjin@gmail.com>
 <3c82af564d70be05b92687949ed134ce034bf8db.1256569489.git.wuzhangjin@gmail.com>
 <a11775df0ec9665fab5861f4fa63a3e192b9ffec.1256569489.git.wuzhangjin@gmail.com>
 <f746f813531a16bd650f9290787c66cbc0cdc34d.1256569489.git.wuzhangjin@gmail.com>
 <07e35715c3af78e3c4b537940277240ed031365a.1256569489.git.wuzhangjin@gmail.com>
 <4e022c090601c3585a8d69a54deade2a53f93e8c.1256569489.git.wuzhangjin@gmail.com>
 <bdfc54ea3c82f1d34149a5565132ff896edd4f76.1256569489.git.wuzhangjin@gmail.com>
 <60dd7085d4df145318582d0a829887b4abf6e6c1.1256569489.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1256569489.git.wuzhangjin@gmail.com>
References: <cover.1256569489.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24521
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

This patch make function graph tracer work with dynamic function tracer.

To share the source code of dynamic function tracer(MCOUNT_SAVE_REGS),
and avoid restoring the whole saved registers, we need to restore the ra
register from the stack.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/kernel/ftrace.c |   21 +++++++++++++++++++++
 arch/mips/kernel/mcount.S |   14 ++++++++++++--
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
index 4cf11f5..1c02e65 100644
--- a/arch/mips/kernel/ftrace.c
+++ b/arch/mips/kernel/ftrace.c
@@ -79,6 +79,27 @@ int __init ftrace_dyn_arch_init(void *data)
 
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
 #define S_RA    (0x2fbf << 16)	/* 32bit: afbf, 64bit: ffbf */
 #define MOV_FP_SP       0x03a0f021	/* 32bit: 0x03a0f021, 64bit: 0x03a0f02d */
 #define STACK_OFFSET_MASK	0xfff	/* stack offset range: 0 ~ PT_SIZE(304) */
diff --git a/arch/mips/kernel/mcount.S b/arch/mips/kernel/mcount.S
index a9ba888..260719d 100644
--- a/arch/mips/kernel/mcount.S
+++ b/arch/mips/kernel/mcount.S
@@ -82,6 +82,13 @@ ftrace_call:
 	nop	/* a placeholder for the call to a real tracing function */
 	nop	/* Do not touch me, I'm in the dealy slot of "jal func" */
 
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	.globl ftrace_graph_call
+ftrace_graph_call:
+	nop
+	nop
+#endif
+
 	MCOUNT_RESTORE_REGS
 	.globl ftrace_stub
 ftrace_stub:
@@ -129,10 +136,13 @@ ftrace_stub:
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
 	PTR_SUBU a1, MCOUNT_INSN_SIZE
 	move	a2, fp		/* arg3: frame pointer */
 	jal	prepare_ftrace_return
-- 
1.6.2.1
