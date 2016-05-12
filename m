Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 May 2016 11:19:26 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:63191 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27029236AbcELJTWrIDZT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 May 2016 11:19:22 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id EA77F7FB8C90;
        Thu, 12 May 2016 10:19:13 +0100 (IST)
Received: from [10.20.78.171] (10.20.78.171) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.266.1; Thu, 12 May 2016
 10:19:15 +0100
Date:   Thu, 12 May 2016 10:19:08 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>
Subject: [PATCH 2/2] MIPS: ptrace: Prevent writes to read-only FCSR bits
In-Reply-To: <alpine.DEB.2.00.1605120014000.6794@tp.orcam.me.uk>
Message-ID: <alpine.DEB.2.00.1605121010290.6794@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1605120014000.6794@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.171]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53398
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

Correct the cases missed with commit 9b26616c8d9d ("MIPS: Respect the 
ISA level in FCSR handling") and prevent writes to read-only FCSR bits 
there.

This in particular applies to FP context initialisation where any IEEE
754-2008 bits preset by `mips_set_personality_nan' are cleared before 
the relevant ptrace(2) call takes effect and the PTRACE_POKEUSR request
addressing FPC_CSR where no masking of read-only FCSR bits is done.

Remove the FCSR clearing from FP context initialisation then and unify
PTRACE_POKEUSR/FPC_CSR and PTRACE_SETFPREGS handling, by factoring out
code from `ptrace_setfpregs' and calling it from both places.

This mostly matters to soft float configurations where the emulator can 
be switched this way to a mode which should not be accessible and cannot 
be set with the CTC1 instruction.  With hard float configurations any 
effect is transient anyway as read-only bits will retain their values at 
the time the FP context is restored.

Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
Cc: stable@vger.kernel.org # v4.0+
---
Hi,

 It's a bit involving to verify PTRACE_POKEUSR/FPC_CSR handling these days 
as the request is considered legacy these days with the usual suspects, 
that is GDB and gdbserver having switched to PTRACE_SETFPREGS instead.  I 
think this change can be considered correct though by virtue of sharing 
the same code between the two requests.

 Please apply then.

  Maciej

linux-mips-ptrace-fcsr-set.diff
Index: linux-sfr-test/arch/mips/kernel/ptrace.c
===================================================================
--- linux-sfr-test.orig/arch/mips/kernel/ptrace.c	2016-05-12 02:33:36.379981000 +0100
+++ linux-sfr-test/arch/mips/kernel/ptrace.c	2016-05-12 04:18:46.529982000 +0100
@@ -57,8 +57,7 @@ static void init_fp_ctx(struct task_stru
 	/* Begin with data registers set to all 1s... */
 	memset(&target->thread.fpu.fpr, ~0, sizeof(target->thread.fpu.fpr));
 
-	/* ...and FCSR zeroed */
-	target->thread.fpu.fcr31 = 0;
+	/* FCSR has been preset by `mips_set_personality_nan'.  */
 
 	/*
 	 * Record that the target has "used" math, such that the context
@@ -80,6 +79,22 @@ void ptrace_disable(struct task_struct *
 }
 
 /*
+ * Poke at FCSR according to its mask.  Don't set the cause bits as
+ * this is currently not handled correctly in FP context restoration
+ * and will cause an oops if a corresponding enable bit is set.
+ */
+static void ptrace_setfcr31(struct task_struct *child, u32 value)
+{
+	u32 fcr31;
+	u32 mask;
+
+	value &= ~FPU_CSR_ALL_X;
+	fcr31 = child->thread.fpu.fcr31;
+	mask = boot_cpu_data.fpu_msk31;
+	child->thread.fpu.fcr31 = (value & ~mask) | (fcr31 & mask);
+}
+
+/*
  * Read a general register set.	 We always use the 64-bit format, even
  * for 32-bit kernels and for 32-bit processes on a 64-bit kernel.
  * Registers are sign extended to fill the available space.
@@ -159,9 +174,7 @@ int ptrace_setfpregs(struct task_struct 
 {
 	union fpureg *fregs;
 	u64 fpr_val;
-	u32 fcr31;
 	u32 value;
-	u32 mask;
 	int i;
 
 	if (!access_ok(VERIFY_READ, data, 33 * 8))
@@ -176,10 +189,7 @@ int ptrace_setfpregs(struct task_struct 
 	}
 
 	__get_user(value, data + 64);
-	value &= ~FPU_CSR_ALL_X;
-	fcr31 = child->thread.fpu.fcr31;
-	mask = boot_cpu_data.fpu_msk31;
-	child->thread.fpu.fcr31 = (value & ~mask) | (fcr31 & mask);
+	ptrace_setfcr31(child, value);
 
 	/* FIR may not be written.  */
 
@@ -807,7 +817,7 @@ long arch_ptrace(struct task_struct *chi
 			break;
 #endif
 		case FPC_CSR:
-			child->thread.fpu.fcr31 = data & ~FPU_CSR_ALL_X;
+			ptrace_setfcr31(child, data);
 			break;
 		case DSP_BASE ... DSP_BASE + 5: {
 			dspreg_t *dregs;
