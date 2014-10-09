Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Oct 2014 23:06:37 +0200 (CEST)
Received: from youngberry.canonical.com ([91.189.89.112]:42465 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011000AbaJIVGgd0pDq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Oct 2014 23:06:36 +0200
Received: from c-76-102-4-12.hsd1.ca.comcast.net ([76.102.4.12] helo=fourier)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.71)
        (envelope-from <kamal@canonical.com>)
        id 1XcKrz-000481-Ku; Thu, 09 Oct 2014 21:03:31 +0000
Received: from kamal by fourier with local (Exim 4.82)
        (envelope-from <kamal@whence.com>)
        id 1XcKrx-0007Ek-Sl; Thu, 09 Oct 2014 14:03:29 -0700
From:   Kamal Mostafa <kamal@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Kamal Mostafa <kamal@canonical.com>
Subject: [PATCH 3.13 142/163] MIPS: mcount: Adjust stack pointer for static trace in MIPS32
Date:   Thu,  9 Oct 2014 14:02:47 -0700
Message-Id: <1412888588-26755-143-git-send-email-kamal@canonical.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1412888588-26755-1-git-send-email-kamal@canonical.com>
References: <1412888588-26755-1-git-send-email-kamal@canonical.com>
X-Extended-Stable: 3.13
Return-Path: <kamal@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43171
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kamal@canonical.com
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

3.13.11.9 -stable review patch.  If anyone has any objections, please let me know.

------------------

From: Markos Chandras <markos.chandras@imgtec.com>

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
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/kernel/mcount.S | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/mips/kernel/mcount.S b/arch/mips/kernel/mcount.S
index 539b629..8f89ff4 100644
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
1.9.1
