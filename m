Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Nov 2009 13:38:31 +0100 (CET)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:43306 "EHLO
	mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1494107AbZKTMgM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 20 Nov 2009 13:36:12 +0100
Received: by pzk35 with SMTP id 35so2380904pzk.22
        for <multiple recipients>; Fri, 20 Nov 2009 04:36:04 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=v1p0scho38s04JkrU1nUTABzSbbUCHnS5eBc+3ZxufM=;
        b=FJXp6JIBoP4i1/m8bMY4b42O0KTbQc/c7uhVVmxnPpOwEBfhN34OFJ4v5F1a2JyA/U
         RwudBx0RgnyGIPXnCXAERZGUIoIs8T0nNmR06AnhGnE8LyRX7Akoq0lSP0k800N5GFwz
         AqOBD0Us9QQac0pLSSMh+xD0X1B7f21hb+BaM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=WoSgjgTS5Jron125QJF+BZYP5DsYVJDgn7IWtOGh7/IeIq7crmO5bd096N0Vte4ntx
         dA0zAHPTuN0ym/PLNN0O5a211zJ3NiZ6URUTCFMJJz71otQpgXb+e0SVHXHG0i2TFBWy
         FPUJzz1naplJazExnRezHew1OmWtAwNMqViRU=
Received: by 10.114.86.5 with SMTP id j5mr1986160wab.0.1258720564053;
        Fri, 20 Nov 2009 04:36:04 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm931632pzk.2.2009.11.20.04.35.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Nov 2009 04:36:03 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>, rostedt@goodmis.org
Cc:	Nicholas Mc Guire <der.herr@hofr.at>, zhangfx@lemote.com,
	Wu Zhangjin <wuzhangjin@gmail.com>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH v9 09/10] tracing: reserve $12(t0) for mcount-ra-address of gcc 4.5
Date:	Fri, 20 Nov 2009 20:34:37 +0800
Message-Id: <76ddc2b8164e0e2f239ddd81ef1ef6a241540004.1258719323.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <16e57c64d806acc5fc3440370aa0ff97a5db7dc3.1258719323.git.wuzhangjin@gmail.com>
References: <adf867c5a6864fa196c667d3f09a6a694f3903c5.1258719323.git.wuzhangjin@gmail.com>
 <51e30436a435480f1f0dec146a82f2b250900690.1258719323.git.wuzhangjin@gmail.com>
 <267c0824194b659b46fc038ba43492df30369fec.1258719323.git.wuzhangjin@gmail.com>
 <6a25a6132d64830bbd7339fe8b3841a51d02ac6d.1258719323.git.wuzhangjin@gmail.com>
 <2ffd3ecb5f0c96b43150968ce270dee71f6afdb8.1258719323.git.wuzhangjin@gmail.com>
 <2276758e661b2b2362432851003df1d7c99d6cc0.1258719323.git.wuzhangjin@gmail.com>
 <c08257b0ef370f6e04ff9719bf7499bae28c70f4.1258719323.git.wuzhangjin@gmail.com>
 <16e57c64d806acc5fc3440370aa0ff97a5db7dc3.1258719323.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1258719323.git.wuzhangjin@gmail.com>
References: <cover.1258719323.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25000
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

A new option -mmcount-ra-address for gcc 4.5 have been sent by David
Daney <ddaney@caviumnetworks.com> in the thread "MIPS: Add option to
pass return address location to _mcount", which help to record the
location of the return address(ra) for the function graph tracer of MIPS
to hijack the return address easier and safer. that option used the
$12(t0) register by default, so, we reserve it for it, and use t1,t2,t3
instead of t0,t1,t2.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/kernel/mcount.S |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/mips/kernel/mcount.S b/arch/mips/kernel/mcount.S
index bdfef2c..522e91c 100644
--- a/arch/mips/kernel/mcount.S
+++ b/arch/mips/kernel/mcount.S
@@ -65,8 +65,8 @@ NESTED(ftrace_caller, PT_SIZE, ra)
 _mcount:
 	b	ftrace_stub
 	 nop
-	lw	t0, function_trace_stop
-	bnez	t0, ftrace_stub
+	lw	t1, function_trace_stop
+	bnez	t1, ftrace_stub
 	 nop
 
 	MCOUNT_SAVE_REGS
@@ -93,21 +93,21 @@ ftrace_stub:
 #else	/* ! CONFIG_DYNAMIC_FTRACE */
 
 NESTED(_mcount, PT_SIZE, ra)
-	lw	t0, function_trace_stop
-	bnez	t0, ftrace_stub
+	lw	t1, function_trace_stop
+	bnez	t1, ftrace_stub
 	 nop
-	PTR_LA	t0, ftrace_stub
-	PTR_L	t1, ftrace_trace_function /* Prepare t1 for (1) */
-	bne	t0, t1, static_trace
+	PTR_LA	t1, ftrace_stub
+	PTR_L	t2, ftrace_trace_function /* Prepare t2 for (1) */
+	bne	t1, t2, static_trace
 	 nop
 
 #ifdef	CONFIG_FUNCTION_GRAPH_TRACER
-	PTR_L	t2, ftrace_graph_return
-	bne	t0, t2, ftrace_graph_caller
+	PTR_L	t3, ftrace_graph_return
+	bne	t1, t3, ftrace_graph_caller
 	 nop
-	PTR_LA	t0, ftrace_graph_entry_stub
-	PTR_L	t2, ftrace_graph_entry
-	bne	t0, t2, ftrace_graph_caller
+	PTR_LA	t1, ftrace_graph_entry_stub
+	PTR_L	t3, ftrace_graph_entry
+	bne	t1, t3, ftrace_graph_caller
 	 nop
 #endif
 	b	ftrace_stub
@@ -117,7 +117,7 @@ static_trace:
 	MCOUNT_SAVE_REGS
 
 	move	a0, ra		/* arg1: next ip, selfaddr */
-	jalr	t1	/* (1) call *ftrace_trace_function */
+	jalr	t2		/* (1) call *ftrace_trace_function */
 	 move	a1, AT		/* arg2: the caller's next ip, parent */
 
 	MCOUNT_RESTORE_REGS
-- 
1.6.2.1
