Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Mar 2016 02:44:40 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:32256 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007714AbcCDBoigpv-U (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Mar 2016 02:44:38 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 6D83A7A8BCF21;
        Fri,  4 Mar 2016 01:44:31 +0000 (GMT)
Received: from [10.100.200.141] (10.100.200.141) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.266.1; Fri, 4 Mar 2016
 01:44:31 +0000
Date:   Fri, 4 Mar 2016 01:44:28 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Pedro Alves <palves@redhat.com>,
        Luis Machado <lgustavo@codesourcery.com>,
        <linux-mips@linux-mips.org>, <gdb@sourceware.org>
Subject: [PATCH 2/2] traps: Correct the SIGTRAP debug ABI in `do_watch' and
 `do_trap_or_bp'
In-Reply-To: <alpine.DEB.2.00.1603031303500.9427@tp.orcam.me.uk>
Message-ID: <alpine.DEB.2.00.1603031341080.9427@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1603031303500.9427@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.100.200.141]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52442
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

Follow our own rules set in <asm/siginfo.h> for SIGTRAP signals issued 
from `do_watch' and `do_trap_or_bp' by setting the signal code to 
TRAP_HWBKPT and TRAP_BRKPT respectively, for Watch exceptions and for
those Breakpoint exceptions whose originating BREAK instruction's code
does not have a special meaning.  Keep Trap exceptions unaffected as 
these are not debug events.

No existing user software is expected to examine signal codes for these
signals as SI_KERNEL has been always used here.  This change makes the 
MIPS port more like other Linux ports, which reduces the complexity and 
provides for performance improvement in GDB.

Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
---
linux-mips-sigtrap-code.diff
Index: linux-sfr-test/arch/mips/include/asm/mips-r2-to-r6-emul.h
===================================================================
--- linux-sfr-test.orig/arch/mips/include/asm/mips-r2-to-r6-emul.h	2016-03-04 00:56:07.699559000 +0000
+++ linux-sfr-test/arch/mips/include/asm/mips-r2-to-r6-emul.h	2016-03-04 00:59:49.221206000 +0000
@@ -79,7 +79,7 @@ struct r2_decoder_table {
 };
 
 
-extern void do_trap_or_bp(struct pt_regs *regs, unsigned int code,
+extern void do_trap_or_bp(struct pt_regs *regs, unsigned int code, int si_code,
 			  const char *str);
 
 #ifndef CONFIG_MIPSR2_TO_R6_EMULATOR
Index: linux-sfr-test/arch/mips/kernel/mips-r2-to-r6-emul.c
===================================================================
--- linux-sfr-test.orig/arch/mips/kernel/mips-r2-to-r6-emul.c	2016-03-04 00:56:07.701558000 +0000
+++ linux-sfr-test/arch/mips/kernel/mips-r2-to-r6-emul.c	2016-03-04 00:59:49.250211000 +0000
@@ -940,42 +940,42 @@ int mipsr2_decoder(struct pt_regs *regs,
 		switch (rt) {
 		case tgei_op:
 			if ((long)regs->regs[rs] >= MIPSInst_SIMM(inst))
-				do_trap_or_bp(regs, 0, "TGEI");
+				do_trap_or_bp(regs, 0, 0, "TGEI");
 
 			MIPS_R2_STATS(traps);
 
 			break;
 		case tgeiu_op:
 			if (regs->regs[rs] >= MIPSInst_UIMM(inst))
-				do_trap_or_bp(regs, 0, "TGEIU");
+				do_trap_or_bp(regs, 0, 0, "TGEIU");
 
 			MIPS_R2_STATS(traps);
 
 			break;
 		case tlti_op:
 			if ((long)regs->regs[rs] < MIPSInst_SIMM(inst))
-				do_trap_or_bp(regs, 0, "TLTI");
+				do_trap_or_bp(regs, 0, 0, "TLTI");
 
 			MIPS_R2_STATS(traps);
 
 			break;
 		case tltiu_op:
 			if (regs->regs[rs] < MIPSInst_UIMM(inst))
-				do_trap_or_bp(regs, 0, "TLTIU");
+				do_trap_or_bp(regs, 0, 0, "TLTIU");
 
 			MIPS_R2_STATS(traps);
 
 			break;
 		case teqi_op:
 			if (regs->regs[rs] == MIPSInst_SIMM(inst))
-				do_trap_or_bp(regs, 0, "TEQI");
+				do_trap_or_bp(regs, 0, 0, "TEQI");
 
 			MIPS_R2_STATS(traps);
 
 			break;
 		case tnei_op:
 			if (regs->regs[rs] != MIPSInst_SIMM(inst))
-				do_trap_or_bp(regs, 0, "TNEI");
+				do_trap_or_bp(regs, 0, 0, "TNEI");
 
 			MIPS_R2_STATS(traps);
 
Index: linux-sfr-test/arch/mips/kernel/traps.c
===================================================================
--- linux-sfr-test.orig/arch/mips/kernel/traps.c	2016-03-04 00:56:37.858781000 +0000
+++ linux-sfr-test/arch/mips/kernel/traps.c	2016-03-04 00:59:49.253206000 +0000
@@ -56,6 +56,7 @@
 #include <asm/pgtable.h>
 #include <asm/ptrace.h>
 #include <asm/sections.h>
+#include <asm/siginfo.h>
 #include <asm/tlbdebug.h>
 #include <asm/traps.h>
 #include <asm/uaccess.h>
@@ -871,7 +872,7 @@ asmlinkage void do_fpe(struct pt_regs *r
 	exception_exit(prev_state);
 }
 
-void do_trap_or_bp(struct pt_regs *regs, unsigned int code,
+void do_trap_or_bp(struct pt_regs *regs, unsigned int code, int si_code,
 	const char *str)
 {
 	siginfo_t info = { 0 };
@@ -928,7 +929,13 @@ void do_trap_or_bp(struct pt_regs *regs,
 	default:
 		scnprintf(b, sizeof(b), "%s instruction in kernel code", str);
 		die_if_kernel(b, regs);
-		force_sig(SIGTRAP, current);
+		if (si_code) {
+			info.si_signo = SIGTRAP;
+			info.si_code = si_code;
+			force_sig_info(SIGTRAP, &info, current);
+		} else {
+			force_sig(SIGTRAP, current);
+		}
 	}
 }
 
@@ -1012,7 +1019,7 @@ asmlinkage void do_bp(struct pt_regs *re
 		break;
 	}
 
-	do_trap_or_bp(regs, bcode, "Break");
+	do_trap_or_bp(regs, bcode, TRAP_BRKPT, "Break");
 
 out:
 	set_fs(seg);
@@ -1054,7 +1061,7 @@ asmlinkage void do_tr(struct pt_regs *re
 			tcode = (opcode >> 6) & ((1 << 10) - 1);
 	}
 
-	do_trap_or_bp(regs, tcode, "Trap");
+	do_trap_or_bp(regs, tcode, 0, "Trap");
 
 out:
 	set_fs(seg);
@@ -1505,6 +1512,7 @@ asmlinkage void do_mdmx(struct pt_regs *
  */
 asmlinkage void do_watch(struct pt_regs *regs)
 {
+	siginfo_t info = { .si_signo = SIGTRAP, .si_code = TRAP_HWBKPT };
 	enum ctx_state prev_state;
 	u32 cause;
 
@@ -1525,7 +1533,7 @@ asmlinkage void do_watch(struct pt_regs 
 	if (test_tsk_thread_flag(current, TIF_LOAD_WATCH)) {
 		mips_read_watch_registers();
 		local_irq_enable();
-		force_sig(SIGTRAP, current);
+		force_sig_info(SIGTRAP, &info, current);
 	} else {
 		mips_clear_watch_registers();
 		local_irq_enable();
