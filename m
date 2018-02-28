Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Feb 2018 17:20:59 +0100 (CET)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53918 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992781AbeB1QUrUk4rz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Feb 2018 17:20:47 +0100
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1er3Ys-0006XU-UB; Wed, 28 Feb 2018 15:22:31 +0000
Received: from ben by deadeye with local (Exim 4.90_1)
        (envelope-from <ben@decadent.org.uk>)
        id 1er3Yg-000058-D0; Wed, 28 Feb 2018 15:22:18 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, linux-mips@linux-mips.org,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        "Ralf Baechle" <ralf@linux-mips.org>
Date:   Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.170473068@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 103/254] MIPS: ptrace: Prevent writes to read-only
 FCSR bits
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62754
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

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Maciej W. Rozycki" <macro@imgtec.com>

commit abf378be49f38c4d3e23581d3df3fa9f1b1b11d2 upstream.

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
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/13239/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
[bwh: Backported to 3.16: There is no mips_set_personality_nan(), so make
 init_fp_ctx() copy the initial value of FCSR31]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -57,8 +57,7 @@ static void init_fp_ctx(struct task_stru
 	/* Begin with data registers set to all 1s... */
 	memset(&target->thread.fpu.fpr, ~0, sizeof(target->thread.fpu.fpr));
 
-	/* ...and FCSR zeroed */
-	target->thread.fpu.fcr31 = 0;
+	target->thread.fpu.fcr31 = boot_cpu_data.fpu_csr31;
 
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
 
@@ -739,7 +749,7 @@ long arch_ptrace(struct task_struct *chi
 			break;
 #endif
 		case FPC_CSR:
-			child->thread.fpu.fcr31 = data & ~FPU_CSR_ALL_X;
+			ptrace_setfcr31(child, data);
 			break;
 		case DSP_BASE ... DSP_BASE + 5: {
 			dspreg_t *dregs;
