Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Jun 2012 01:46:57 +0200 (CEST)
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:22578 "EHLO
        mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903464Ab2FOXqw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 16 Jun 2012 01:46:52 +0200
Received: from 10.103.77.188.dynamic.jazztel.es ([188.77.103.10] helo=mail.viric.name)
        by mho-01-ewr.mailhop.org with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.72)
        (envelope-from <viric@mail.viric.name>)
        id 1SfgE0-000LYj-N5; Fri, 15 Jun 2012 23:46:45 +0000
Received: by mail.viric.name (Postfix, from userid 1000)
        id 6938B58FE7C; Sat, 16 Jun 2012 01:46:41 +0200 (CEST)
X-Mail-Handler: MailHop Outbound by DynDNS
X-Originating-IP: 188.77.103.10
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/mailhop/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1/raSs0tJukk/zE9EeFP+sm
From:   Lluis Batlle i Rossell <viric@viric.name>
Date:   Sat, 16 Jun 2012 00:22:53 +0200
Subject: [PATCH] MIPS: Add emulation for fpureg-mem unaligned access
To:     linux-mips@linux-mips.org
Cc:     loongson-dev@googlegroups.com
Message-Id: <20120615234641.6938B58FE7C@mail.viric.name>
X-archive-position: 33669
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: viric@viric.name
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

Reusing most of the code from lw,ld,sw,sd emulation,
I add the emulation for lwc1,ldc1,swc1,sdc1.

This avoids the direct SIGBUS sent to userspace processes that have
misaligned memory accesses.

I've tested the change in Loongson2F, with an own test program, and
WebKit 1.4.0, as both were killed by sigbus without this patch.

Signed-off: Lluis Batlle i Rossell <viric@viric.name>
---
 arch/mips/kernel/unaligned.c |   43 +++++++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/arch/mips/kernel/unaligned.c b/arch/mips/kernel/unaligned.c
index 9c58bdf..4531e6c 100644
--- a/arch/mips/kernel/unaligned.c
+++ b/arch/mips/kernel/unaligned.c
@@ -85,6 +85,7 @@
 #include <asm/cop2.h>
 #include <asm/inst.h>
 #include <asm/uaccess.h>
+#include <asm/fpu.h>
 
 #define STR(x)  __STR(x)
 #define __STR(x)  #x
@@ -108,6 +109,7 @@ static void emulate_load_store_insn(struct pt_regs *regs,
 	union mips_instruction insn;
 	unsigned long value;
 	unsigned int res;
+	fpureg_t *fpuregs;
 
 	perf_sw_event(PERF_COUNT_SW_EMULATION_FAULTS, 1, regs, 0);
 
@@ -183,6 +185,7 @@ static void emulate_load_store_insn(struct pt_regs *regs,
 		break;
 
 	case lw_op:
+	case lwc1_op:
 		if (!access_ok(VERIFY_READ, addr, 4))
 			goto sigbus;
 
@@ -209,7 +212,12 @@ static void emulate_load_store_insn(struct pt_regs *regs,
 		if (res)
 			goto fault;
 		compute_return_epc(regs);
-		regs->regs[insn.i_format.rt] = value;
+		if (insn.i_format.opcode == lw_op) {
+			regs->regs[insn.i_format.rt] = value;
+		} else {
+			fpuregs = get_fpu_regs(current);
+			fpuregs[insn.i_format.rt] = value;
+		}
 		break;
 
 	case lhu_op:
@@ -291,6 +299,7 @@ static void emulate_load_store_insn(struct pt_regs *regs,
 		goto sigill;
 
 	case ld_op:
+	case ldc1_op:
 #ifdef CONFIG_64BIT
 		/*
 		 * A 32-bit kernel might be running on a 64-bit processor.  But
@@ -325,7 +334,12 @@ static void emulate_load_store_insn(struct pt_regs *regs,
 		if (res)
 			goto fault;
 		compute_return_epc(regs);
-		regs->regs[insn.i_format.rt] = value;
+		if (insn.i_format.opcode == ld_op) {
+			regs->regs[insn.i_format.rt] = value;
+		} else {
+			fpuregs = get_fpu_regs(current);
+			fpuregs[insn.i_format.rt] = value;
+		}
 		break;
 #endif /* CONFIG_64BIT */
 
@@ -370,10 +384,16 @@ static void emulate_load_store_insn(struct pt_regs *regs,
 		break;
 
 	case sw_op:
+	case swc1_op:
 		if (!access_ok(VERIFY_WRITE, addr, 4))
 			goto sigbus;
 
-		value = regs->regs[insn.i_format.rt];
+		if (insn.i_format.opcode == sw_op) {
+			value = regs->regs[insn.i_format.rt];
+		} else {
+			fpuregs = get_fpu_regs(current);
+			value = fpuregs[insn.i_format.rt];
+		}
 		__asm__ __volatile__ (
 #ifdef __BIG_ENDIAN
 			"1:\tswl\t%1,(%2)\n"
@@ -401,6 +421,7 @@ static void emulate_load_store_insn(struct pt_regs *regs,
 		break;
 
 	case sd_op:
+	case sdc1_op:
 #ifdef CONFIG_64BIT
 		/*
 		 * A 32-bit kernel might be running on a 64-bit processor.  But
@@ -412,7 +433,12 @@ static void emulate_load_store_insn(struct pt_regs *regs,
 		if (!access_ok(VERIFY_WRITE, addr, 8))
 			goto sigbus;
 
-		value = regs->regs[insn.i_format.rt];
+		if (insn.i_format.opcode == sd_op) {
+			value = regs->regs[insn.i_format.rt];
+		} else {
+			fpuregs = get_fpu_regs(current);
+			value = fpuregs[insn.i_format.rt];
+		}
 		__asm__ __volatile__ (
 #ifdef __BIG_ENDIAN
 			"1:\tsdl\t%1,(%2)\n"
@@ -443,15 +469,6 @@ static void emulate_load_store_insn(struct pt_regs *regs,
 		/* Cannot handle 64-bit instructions in 32-bit kernel */
 		goto sigill;
 
-	case lwc1_op:
-	case ldc1_op:
-	case swc1_op:
-	case sdc1_op:
-		/*
-		 * I herewith declare: this does not happen.  So send SIGBUS.
-		 */
-		goto sigbus;
-
 	/*
 	 * COP2 is available to implementor for application specific use.
 	 * It's up to applications to register a notifier chain and do
-- 
1.7.9.5
