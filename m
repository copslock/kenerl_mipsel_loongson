Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Nov 2014 23:39:46 +0100 (CET)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49040 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012430AbaKAWj2IGALC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 1 Nov 2014 23:39:28 +0100
Received: from deadeye.wl.decadent.org.uk ([192.168.4.249] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <ben@decadent.org.uk>)
        id 1XkhKO-0004ll-5T; Sat, 01 Nov 2014 22:39:24 +0000
Received: from ben by deadeye with local (Exim 4.84)
        (envelope-from <ben@decadent.org.uk>)
        id 1XkhKH-00015u-Py; Sat, 01 Nov 2014 22:39:17 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Ralf Baechle" <ralf@linux-mips.org>,
        linux-mips@linux-mips.org,
        "Markos Chandras" <markos.chandras@imgtec.com>
Date:   Sat, 01 Nov 2014 22:28:03 +0000
Message-ID: <lsq.1414880883.28269400@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 071/102] MIPS: mcount: Adjust stack pointer for static
 trace in MIPS32
In-Reply-To: <lsq.1414880882.522510247@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.249
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43820
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.2.64-rc1 review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/kernel/mcount.S | 12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/arch/mips/kernel/mcount.S
+++ b/arch/mips/kernel/mcount.S
@@ -119,7 +119,11 @@ NESTED(_mcount, PT_SIZE, ra)
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
@@ -129,6 +133,9 @@ static_trace:
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
 
