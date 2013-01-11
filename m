Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jan 2013 15:35:39 +0100 (CET)
Received: from mms1.broadcom.com ([216.31.210.17]:2826 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823016Ab3AKOekBeDEs (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 11 Jan 2013 15:34:40 +0100
Received: from [10.9.208.26] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Fri, 11 Jan 2013 06:31:58 -0800
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHCAS05.corp.ad.broadcom.com (10.9.208.26) with Microsoft SMTP
 Server id 14.1.355.2; Fri, 11 Jan 2013 06:33:53 -0800
Received: from stbsrv-and-2.and.broadcom.com (
 stbsrv-and-2.and.broadcom.com [10.32.128.96]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 9C28040FE6; Fri, 11
 Jan 2013 06:33:52 -0800 (PST)
From:   "Al Cooper" <alcooperx@gmail.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
cc:     "Al Cooper" <alcooperx@gmail.com>
Subject: [PATCH] mips: function tracer: Fix broken function tracing
Date:   Fri, 11 Jan 2013 09:33:30 -0500
Message-ID: <1357914810-20656-1-git-send-email-alcooperx@gmail.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <y>
References: <y>
MIME-Version: 1.0
X-WSS-ID: 7CEEFDD41ZS4162332-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 35402
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alcooperx@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Function tracing is currently broken for all 32 bit MIPS platforms.
When tracing is enabled, the kernel immediately hangs on boot.
This is a result of commit b732d439cb43336cd6d7e804ecb2c81193ef63b0
that changes the kernel/trace/Kconfig file so that is no longer
forces FRAME_POINTER when FUNCTION_TRACING is enabled.

MIPS frame pointers are generally considered to be useless because
they cannot be used to unwind the stack. Unfortunately the MIPS
function tracing code has bugs that are masked by the use of frame
pointers. This commit fixes the bugs so that MIPS frame pointers do
not need to be enabled.

The bugs are a result of the odd calling sequence used to call the trace
routine. This calling sequence is inserted into every tracable function
when the tracing CONFIG option is enabled. This sequence is generated
for 32bit MIPS platforms by the compiler via the "-pg" flag.
Part of the sequence is "addiu sp,sp,-8" in the delay slot after every
call to the trace routine "_mcount" (some legacy thing where 2 arguments
used to be pushed on the stack). The _mcount routine is expected to
adjust the sp by +8 before returning.

One of the bugs is that when tracing is disabled for a function, the
"jalr _mcount" instruction is replaced with a nop, but the
"addiu sp,sp,-8" is still executed and the stack pointer is left
trashed. When frame pointers are enabled the problem is masked
because any access to the stack is done through the frame
pointer and the stack pointer is restored from the frame pointer when
the function returns. This patch uses a branch likely instruction
"bltzl zero, f1" instead of "nop" to disable the call because this
instruction will not execute the "addiu sp,sp,-8" instruction in
the delay slot. The other possible solution would be to nop out both
the jalr and the "addiu sp,sp,-8", but this would need to be interrupt
and SMP safe and would be much more intrusive.

A few other bugs were fixed where the _mcount routine itself did not
always fix the sp on return.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 arch/mips/kernel/ftrace.c |    9 ++++++++-
 arch/mips/kernel/mcount.S |   14 ++++++++++----
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
index 6a2d758..f761130 100644
--- a/arch/mips/kernel/ftrace.c
+++ b/arch/mips/kernel/ftrace.c
@@ -46,6 +46,13 @@ static inline int in_kernel_space(unsigned long ip)
 #define JUMP_RANGE_MASK ((1UL << 28) - 1)
 
 #define INSN_NOP 0x00000000	/* nop */
+
+/*
+ * This branch likely instruction is used to nop the call to _mcount
+ * and skip the stack adjust instruction in the delay slot.
+ */
+#define INSN_NOP_SKIP 0x04020001	/* bltzl zero, f1 */
+
 #define INSN_JAL(addr)	\
 	((unsigned int)(JAL | (((addr) >> 2) & ADDR_MASK)))
 
@@ -130,7 +137,7 @@ int ftrace_make_nop(struct module *mod,
 	 * If ip is in kernel space, no long call, otherwise, long call is
 	 * needed.
 	 */
-	new = in_kernel_space(ip) ? INSN_NOP : INSN_B_1F;
+	new = in_kernel_space(ip) ? INSN_NOP_SKIP : INSN_B_1F;
 
 	return ftrace_modify_code(ip, new);
 }
diff --git a/arch/mips/kernel/mcount.S b/arch/mips/kernel/mcount.S
index 4c968e7..78ac3cc 100644
--- a/arch/mips/kernel/mcount.S
+++ b/arch/mips/kernel/mcount.S
@@ -68,10 +68,10 @@
 NESTED(ftrace_caller, PT_SIZE, ra)
 	.globl _mcount
 _mcount:
-	b	ftrace_stub
+	b	ftrace_stub_restore_sp
 	 nop
 	lw	t1, function_trace_stop
-	bnez	t1, ftrace_stub
+	bnez	t1, ftrace_stub_restore_sp
 	 nop
 
 	MCOUNT_SAVE_REGS
@@ -96,13 +96,16 @@ ftrace_graph_call:
 	.globl ftrace_stub
 ftrace_stub:
 	RETURN_BACK
+ftrace_stub_restore_sp:
+	PTR_ADDIU	sp, 8
+	RETURN_BACK
 	END(ftrace_caller)
 
 #else	/* ! CONFIG_DYNAMIC_FTRACE */
 
 NESTED(_mcount, PT_SIZE, ra)
 	lw	t1, function_trace_stop
-	bnez	t1, ftrace_stub
+	bnez	t1, ftrace_stub_restore_sp
 	 nop
 	PTR_LA	t1, ftrace_stub
 	PTR_L	t2, ftrace_trace_function /* Prepare t2 for (1) */
@@ -118,7 +121,7 @@ NESTED(_mcount, PT_SIZE, ra)
 	bne	t1, t3, ftrace_graph_caller
 	 nop
 #endif
-	b	ftrace_stub
+	b	ftrace_stub_restore_sp
 	 nop
 
 static_trace:
@@ -132,6 +135,9 @@ static_trace:
 	.globl ftrace_stub
 ftrace_stub:
 	RETURN_BACK
+ftrace_stub_restore_sp:
+	PTR_ADDIU	sp, 8
+	RETURN_BACK
 	END(_mcount)
 
 #endif	/* ! CONFIG_DYNAMIC_FTRACE */
-- 
1.7.6
