Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Apr 2015 00:27:52 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27025271AbbDCWYvXdwLc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Apr 2015 00:24:51 +0200
Date:   Fri, 3 Apr 2015 23:24:51 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        linux-mips@linux-mips.org
Subject: [PATCH 15/48] MIPS: Reindent R6 RI exception emulation
In-Reply-To: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.11.1504030245220.21028@eddie.linux-mips.org>
References: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46732
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

Fold a nested `if' statement for the R6 case in `do_ri' into its 
containing `if' block, removing excessive indentation causing code to 
extend beyond 79 columns.

Cc: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-mips-do-ri-r6-indent.patch
Index: linux/arch/mips/kernel/traps.c
===================================================================
--- linux.orig/arch/mips/kernel/traps.c	2015-04-02 20:27:52.799182000 +0100
+++ linux/arch/mips/kernel/traps.c	2015-04-02 20:27:53.911190000 +0100
@@ -1033,22 +1033,21 @@ asmlinkage void do_ri(struct pt_regs *re
 	 * as quickly as possible.
 	 */
 	if (mipsr2_emulation && cpu_has_mips_r6 &&
-	    likely(user_mode(regs))) {
-		if (likely(get_user(opcode, epc) >= 0)) {
-			status = mipsr2_decoder(regs, opcode);
-			switch (status) {
-			case 0:
-			case SIGEMT:
-				task_thread_info(current)->r2_emul_return = 1;
-				return;
-			case SIGILL:
-				goto no_r2_instr;
-			default:
-				process_fpemu_return(status,
-						     &current->thread.cp0_baduaddr);
-				task_thread_info(current)->r2_emul_return = 1;
-				return;
-			}
+	    likely(user_mode(regs)) &&
+	    likely(get_user(opcode, epc) >= 0)) {
+		status = mipsr2_decoder(regs, opcode);
+		switch (status) {
+		case 0:
+		case SIGEMT:
+			task_thread_info(current)->r2_emul_return = 1;
+			return;
+		case SIGILL:
+			goto no_r2_instr;
+		default:
+			process_fpemu_return(status,
+					     &current->thread.cp0_baduaddr);
+			task_thread_info(current)->r2_emul_return = 1;
+			return;
 		}
 	}
 
