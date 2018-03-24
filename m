Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Mar 2018 17:58:02 +0100 (CET)
Received: from orthanc.universe-factory.net ([104.238.176.138]:57180 "EHLO
        orthanc.universe-factory.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990425AbeCXQ5z1Z9pE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 24 Mar 2018 17:57:55 +0100
Received: from localhost.localdomain (unknown [IPv6:2001:19f0:6c01:100::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by orthanc.universe-factory.net (Postfix) with ESMTPSA id E324D1F516;
        Sat, 24 Mar 2018 17:57:54 +0100 (CET)
From:   Matthias Schiffer <mschiffer@universe-factory.net>
To:     ralf@linux-mips.org, rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        mschiffer@universe-factory.net
Subject: [PATCH] mips: ftrace: fix static function graph tracing
Date:   Sat, 24 Mar 2018 17:57:49 +0100
Message-Id: <7dc2bb7f712c1e3cfeaafaefe3a3f97668dee549.1521909650.git.mschiffer@universe-factory.net>
X-Mailer: git-send-email 2.16.2
Return-Path: <mschiffer@universe-factory.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63214
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mschiffer@universe-factory.net
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

ftrace_graph_caller was never run after calling ftrace_trace_function,
breaking the function graph tracer. Fix this, bringing it in line with the
x86 implementation.

While we're at it, also streamline the control flow of _mcount a bit to
reduce the number of branches.

This issue was reported before:
https://www.linux-mips.org/archives/linux-mips/2014-11/msg00295.html

Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
---

Caveats: I've only tested this on 32bit; it would be great if someone with
MIPS64 hardware or a working emulator setup could give it a spin. My test
device runs on kernel 4.9.y, but I don't expect any problems applying the
fix to newer kernels, given that this code is basically unchanged since
2014.

I'm not sure what the correct Fixes: line would be. I did not bother to
bisect the issue and could not find the commit introducing it by inspecting
the log (assuming the tracer worked at some point).


 arch/mips/kernel/mcount.S | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/arch/mips/kernel/mcount.S b/arch/mips/kernel/mcount.S
index f2ee7e1e3342..cff52b283e03 100644
--- a/arch/mips/kernel/mcount.S
+++ b/arch/mips/kernel/mcount.S
@@ -119,10 +119,20 @@ NESTED(_mcount, PT_SIZE, ra)
 EXPORT_SYMBOL(_mcount)
 	PTR_LA	t1, ftrace_stub
 	PTR_L	t2, ftrace_trace_function /* Prepare t2 for (1) */
-	bne	t1, t2, static_trace
+	beq	t1, t2, fgraph_trace
 	 nop
 
+	MCOUNT_SAVE_REGS
+
+	move	a0, ra		/* arg1: self return address */
+	jalr	t2		/* (1) call *ftrace_trace_function */
+	 move	a1, AT		/* arg2: parent's return address */
+
+	MCOUNT_RESTORE_REGS
+
+fgraph_trace:
 #ifdef	CONFIG_FUNCTION_GRAPH_TRACER
+	PTR_LA	t1, ftrace_stub
 	PTR_L	t3, ftrace_graph_return
 	bne	t1, t3, ftrace_graph_caller
 	 nop
@@ -131,24 +141,11 @@ EXPORT_SYMBOL(_mcount)
 	bne	t1, t3, ftrace_graph_caller
 	 nop
 #endif
-	b	ftrace_stub
-#ifdef CONFIG_32BIT
-	 addiu sp, sp, 8
-#else
-	 nop
-#endif
 
-static_trace:
-	MCOUNT_SAVE_REGS
-
-	move	a0, ra		/* arg1: self return address */
-	jalr	t2		/* (1) call *ftrace_trace_function */
-	 move	a1, AT		/* arg2: parent's return address */
-
-	MCOUNT_RESTORE_REGS
 #ifdef CONFIG_32BIT
 	addiu sp, sp, 8
 #endif
+
 	.globl ftrace_stub
 ftrace_stub:
 	RETURN_BACK
-- 
2.16.2
