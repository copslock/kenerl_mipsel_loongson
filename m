Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Mar 2012 10:39:33 +0100 (CET)
Received: from relay1.mentorg.com ([192.94.38.131]:56829 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903738Ab1LLVHv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Dec 2011 22:07:51 +0100
Received: from svr-orw-fem-01.mgc.mentorg.com ([147.34.98.93])
        by relay1.mentorg.com with esmtp 
        id 1RaD6B-0003aM-Tt from Maciej_Rozycki@mentor.com ; Mon, 12 Dec 2011 13:07:47 -0800
Received: from SVR-IES-FEM-01.mgc.mentorg.com ([137.202.0.104]) by svr-orw-fem-01.mgc.mentorg.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 12 Dec 2011 13:07:47 -0800
Received: from [172.30.7.78] (137.202.0.76) by SVR-IES-FEM-01.mgc.mentorg.com
 (137.202.0.104) with Microsoft SMTP Server id 14.1.289.1; Mon, 12 Dec 2011
 21:07:44 +0000
Date:   Mon, 12 Dec 2011 21:07:35 +0000
From:   "Maciej W. Rozycki" <macro@codesourcery.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        <linux-mips@linux-mips.org>
Subject: [PATCH] Handle COP3 Unusable exception as COP1X for FP emulation
Message-ID: <alpine.DEB.1.10.1112122022010.5354@tp.orcam.me.uk>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-OriginalArrivalTime: 12 Dec 2011 21:07:47.0246 (UTC) FILETIME=[19551CE0:01CCB912]
X-archive-position: 32620
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@codesourcery.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>


 Our FP emulator is hardcoded for the MIPS IV FP instruction set and does 
not match the FP ISA with the general ISA.  However for the few MIPS IV FP 
instructions that use the COP1X major opcode it relies on the Coprocessor 
Unusable exception to be delivered as a COP1 rather than COP3 exception.  
This includes indexed transfer (LDXC1, etc.) and FP multiply-accumulate 
(MADD.D, etc.) instructions.

 All the MIPS I and MIPS II processors and some newer chips that do not 
implement the FPU use the COP3 exception however.  Therefore I believe the 
kernel should follow and redirect any COP3 Unusable traps to the emulator 
unless an actual FPU part or core is present.

 This is a change that implements it.  Any minor opcode encodings that are 
not recognised as valid FP instructions are rejected by the emulator and 
will result in a SIGILL signal being delivered as they currently do.  We 
do not support vendor-specific coprocessor 3 implementations supported 
with MIPS I and MIPS II ISA processors; we never set CP0.Status.CU3.

 If matching between the CPU and the FPU ISA is considered required one 
day, this can still be done in the emulator itself.  I think the CpU 
exception dispatcher is not the right place to do this anyway, as there 
are further differences between MIPS I, MIPS II, MIPS III, MIPS IV and 
MIPS32 FP ISAs.

 Corresponding explanation of this implementation is included within the 
change itself.

Signed-off-by: Maciej W. Rozycki <macro@codesourcery.com>
---
Ralf,

 Please apply at your earliest convenience and backport as you see fit, 
unless you have any questions or comments.  Feedback from anyone else is 
welcome as well.

  Maciej

patch-3.2.0-rc4-do-cpu-cop3-1
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index c6fc6a0..b86eb3d 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1066,6 +1066,24 @@ asmlinkage void do_cpu(struct pt_regs *regs)
 
 		return;
 
+	case 3:
+		/*
+		 * Old (MIPS I and MIPS II) processors will set this code
+		 * for COP1X opcode instructions that replaced the original
+		 * COP3 space.  We don't limit COP1 space instructions in
+		 * the emulator according to the CPU ISA, so we want to
+		 * treat COP1X instructions consistently regardless of which
+		 * code the CPU chose.  Therefore we redirect this trap to
+		 * the FP emulator too.
+		 *
+		 * Then some newer FPU-less processors use this code
+		 * erroneously too, so they are covered by this choice
+		 * as well.
+		 */
+		if (raw_cpu_has_fpu)
+			break;
+		/* Fall through.  */
+
 	case 1:
 		if (used_math())	/* Using the FPU again.  */
 			own_fpu(1);
@@ -1089,9 +1107,6 @@ asmlinkage void do_cpu(struct pt_regs *regs)
 	case 2:
 		raw_notifier_call_chain(&cu2_chain, CU2_EXCEPTION, regs);
 		return;
-
-	case 3:
-		break;
 	}
 
 	force_sig(SIGILL, current);
