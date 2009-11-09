Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Nov 2009 16:38:18 +0100 (CET)
Received: from mail-ew0-f216.google.com ([209.85.219.216]:46041 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493137AbZKIPdr (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 9 Nov 2009 16:33:47 +0100
Received: by mail-ew0-f216.google.com with SMTP id 12so3364851ewy.0
        for <multiple recipients>; Mon, 09 Nov 2009 07:33:47 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=v1p0scho38s04JkrU1nUTABzSbbUCHnS5eBc+3ZxufM=;
        b=UpgzTkcFLL/Olr9knWoD/CnobGXuo4uNjaizArCPEjMS9rNX01hg981W17XKTGQclQ
         I+hnwF5c4zba/KoQDdgUDE9RxyCwm1q9EHxSvsZJo8Ja0Q2MGxCU0BXFzBb/qpFG1Sjl
         9qO1ZRu3BYA3WZtx0MaGG6N6l+GMgtf/o+6DU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=QzwBJA+T/+vn7qQa69Utlt9GnLHbsuWQ2AHEIHEzr23Ci8hWF8AiG/mfouQj1Nv8Pg
         BT3lWyT+Lof7dX9XPLGtzJOlZGipiJGzitiXYQOp2thfygoMzsmA8jsFn0cU5k2QCmdC
         /T7iXzjCzPEfnrJuGou2KhswV/mLLpH4kBQCM=
Received: by 10.216.86.135 with SMTP id w7mr2560807wee.176.1257780827432;
        Mon, 09 Nov 2009 07:33:47 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id g9sm9033556gvc.25.2009.11.09.07.33.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 07:33:46 -0800 (PST)
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
Subject: [PATCH v7 16/17] tracing: reserve $12(t0) for mcount-ra-address of gcc 4.5
Date:	Mon,  9 Nov 2009 23:31:33 +0800
Message-Id: <ceef672f082971118c472d1c079d49762ae43b38.1257779502.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <406a8e5e3117737e401bb2bba84ad9b17f99857d.1257779502.git.wuzhangjin@gmail.com>
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
 <0c463e2af521e613fd15751a9f610c74cf887292.1257779502.git.wuzhangjin@gmail.com>
 <695747bff7cddb97d6f43c05c4cf05eb269e402d.1257779502.git.wuzhangjin@gmail.com>
 <406a8e5e3117737e401bb2bba84ad9b17f99857d.1257779502.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1257779502.git.wuzhangjin@gmail.com>
References: <cover.1257779502.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24788
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
