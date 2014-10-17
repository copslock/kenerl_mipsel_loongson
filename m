Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Oct 2014 10:12:14 +0200 (CEST)
Received: from cantor2.suse.de ([195.135.220.15]:57536 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010871AbaJQIL4r2rzN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Oct 2014 10:11:56 +0200
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7D51FADD1;
        Fri, 17 Oct 2014 08:11:56 +0000 (UTC)
Received: from ku by ip4-83-240-18-248.cust.nbox.cz with local (Exim 4.83)
        (envelope-from <jslaby@suse.cz>)
        id 1Xf2df-0000DQ-Bh; Fri, 17 Oct 2014 10:11:55 +0200
From:   Jiri Slaby <jslaby@suse.cz>
To:     stable@vger.kernel.org
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 3.12 077/197] MIPS: mcount: Adjust stack pointer for static trace in MIPS32
Date:   Fri, 17 Oct 2014 10:09:53 +0200
Message-Id: <2eca54d0920a9beff88cbbdc58176559ac7644a5.1413533329.git.jslaby@suse.cz>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <7d97f39bc813aa9f11fe03d602885f81de07007c.1413533329.git.jslaby@suse.cz>
References: <7d97f39bc813aa9f11fe03d602885f81de07007c.1413533329.git.jslaby@suse.cz>
In-Reply-To: <cover.1413533329.git.jslaby@suse.cz>
References: <cover.1413533329.git.jslaby@suse.cz>
Return-Path: <jslaby@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43323
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jslaby@suse.cz
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

From: Markos Chandras <markos.chandras@imgtec.com>

3.12-stable review patch.  If anyone has any objections, please let me know.

===============

commit 8a574cfa2652545eb95595d38ac2a0bb501af0ae upstream.

Every mcount() call in the MIPS 32-bit kernel is done as follows:

[...]
move at, ra
jal _mcount
addiu sp, sp, -8
[...]

but upon returning from the mcount() function, the stack pointer
is not adjusted properly. This is explained in details in 58b69401c797
(MIPS: Function tracer: Fix broken function tracing).

Commit ad8c396936e3 ("MIPS: Unbreak function tracer for 64-bit kernel.)
fixed the stack manipulation for 64-bit but it didn't fix it completely
for MIPS32.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/7792/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 arch/mips/kernel/mcount.S | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/mips/kernel/mcount.S b/arch/mips/kernel/mcount.S
index 539b6294b613..8f89ff4ed524 100644
--- a/arch/mips/kernel/mcount.S
+++ b/arch/mips/kernel/mcount.S
@@ -123,7 +123,11 @@ NESTED(_mcount, PT_SIZE, ra)
 	 nop
 #endif
 	b	ftrace_stub
+#ifdef CONFIG_32BIT
+	 addiu sp, sp, 8
+#else
 	 nop
+#endif
 
 static_trace:
 	MCOUNT_SAVE_REGS
@@ -133,6 +137,9 @@ static_trace:
 	 move	a1, AT		/* arg2: parent's return address */
 
 	MCOUNT_RESTORE_REGS
+#ifdef CONFIG_32BIT
+	addiu sp, sp, 8
+#endif
 	.globl ftrace_stub
 ftrace_stub:
 	RETURN_BACK
@@ -177,6 +184,11 @@ NESTED(ftrace_graph_caller, PT_SIZE, ra)
 	jal	prepare_ftrace_return
 	 nop
 	MCOUNT_RESTORE_REGS
+#ifndef CONFIG_DYNAMIC_FTRACE
+#ifdef CONFIG_32BIT
+	addiu sp, sp, 8
+#endif
+#endif
 	RETURN_BACK
 	END(ftrace_graph_caller)
 
-- 
2.1.1
