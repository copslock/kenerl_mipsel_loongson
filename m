Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Sep 2014 15:32:18 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:54977 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008773AbaILNcQsVb1k (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Sep 2014 15:32:16 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id CA7E7C323501;
        Fri, 12 Sep 2014 14:32:07 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 12 Sep 2014 14:32:10 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.67) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 12 Sep 2014 14:32:09 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        <stable@vger.kernel.org>
Subject: [PATCH v3] MIPS: mcount: Adjust stack pointer for static trace in MIPS32
Date:   Fri, 12 Sep 2014 14:32:05 +0100
Message-ID: <1410528725-29794-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1410510883-7257-1-git-send-email-markos.chandras@imgtec.com>
References: <1410510883-7257-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.67]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42523
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

Cc: <stable@vger.kernel.org>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
Changes since v2:
- Also fix the case where the function graph tracer is enabled
Changes since v1:
- Also fix the case where the tracer is actually enabled
---
 arch/mips/kernel/mcount.S | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/mips/kernel/mcount.S b/arch/mips/kernel/mcount.S
index 5d25462de8a6..2d28c117831d 100644
--- a/arch/mips/kernel/mcount.S
+++ b/arch/mips/kernel/mcount.S
@@ -106,6 +106,9 @@ ftrace_graph_call:
 #endif
 
 	MCOUNT_RESTORE_REGS
+#ifdef CONFIG_32BIT
+        addiu sp, sp, 8
+#endif
 	.globl ftrace_stub
 ftrace_stub:
 	RETURN_BACK
@@ -129,7 +132,11 @@ NESTED(_mcount, PT_SIZE, ra)
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
@@ -139,6 +146,9 @@ static_trace:
 	 move	a1, AT		/* arg2: parent's return address */
 
 	MCOUNT_RESTORE_REGS
+#ifdef CONFIG_32BIT
+	addiu sp, sp, 8
+#endif
 	.globl ftrace_stub
 ftrace_stub:
 	RETURN_BACK
-- 
2.1.0
