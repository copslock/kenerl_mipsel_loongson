Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 May 2015 16:21:00 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27012391AbbELOU5y8zYn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 May 2015 16:20:57 +0200
Date:   Tue, 12 May 2015 15:20:57 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Martin <paul.martin@codethink.co.uk>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>
cc:     Markos Chandras <Markos.Chandras@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>, linux-mips@linux-mips.org
Subject: [PATCH v2] MIPS: Fix a preemption issue with thread's FPU defaults
Message-ID: <alpine.LFD.2.11.1505121432540.1538@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47345
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

Fix "BUG: using smp_processor_id() in preemptible" reported in accesses 
to thread's FPU defaults: the value to initialise FSCR to at program 
startup, the FCSR r/w mask and the contents of FIR in full FPU 
emulation, removing a regression introduced with 9b26616c [MIPS: Respect 
the ISA level in FCSR handling] and f6843626 [MIPS: math-emu: Set FIR 
feature flags for full emulation].

Use `boot_cpu_data' to obtain the data from, following the approach that 
`cpu_has_*' macros take and avoiding the call to `smp_processor_id' made 
in the reference to `current_cpu_data'.  The contents of FSCR have to be 
consistent across processors in an SMP system, the settings there must 
not change as a thread is migrated across processors.  And the contents 
of FIR are guaranteed to be consistent in FPU emulation, by definition.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
Changes from v1:

- also fix PTRACE_SETFPREGS (thanks, Paul!).

Paul, Ezequiel --

 Can you verify this change addresses the problems you saw?

[Ralf, this is another 4.1 material, please push it to Linus ASAP, once 
this has been confirmed to DTRT.]

 Thanks,

  Maciej

linux-mips-emu-fcsr-isa-fix.diff
Index: linux-org-test/arch/mips/include/asm/elf.h
===================================================================
--- linux-org-test.orig/arch/mips/include/asm/elf.h	2015-05-06 23:20:51.946503000 +0100
+++ linux-org-test/arch/mips/include/asm/elf.h	2015-05-12 14:37:14.169350000 +0100
@@ -304,7 +304,7 @@ do {									\
 									\
 	current->thread.abi = &mips_abi;				\
 									\
-	current->thread.fpu.fcr31 = current_cpu_data.fpu_csr31;		\
+	current->thread.fpu.fcr31 = boot_cpu_data.fpu_csr31;		\
 } while (0)
 
 #endif /* CONFIG_32BIT */
@@ -366,7 +366,7 @@ do {									\
 	else								\
 		current->thread.abi = &mips_abi;			\
 									\
-	current->thread.fpu.fcr31 = current_cpu_data.fpu_csr31;		\
+	current->thread.fpu.fcr31 = boot_cpu_data.fpu_csr31;		\
 									\
 	p = personality(current->personality);				\
 	if (p != PER_LINUX32 && p != PER_LINUX)				\
Index: linux-org-test/arch/mips/kernel/ptrace.c
===================================================================
--- linux-org-test.orig/arch/mips/kernel/ptrace.c	2015-04-28 14:52:04.000000000 +0100
+++ linux-org-test/arch/mips/kernel/ptrace.c	2015-05-12 15:12:03.511002000 +0100
@@ -176,7 +176,7 @@ int ptrace_setfpregs(struct task_struct 
 
 	__get_user(value, data + 64);
 	fcr31 = child->thread.fpu.fcr31;
-	mask = current_cpu_data.fpu_msk31;
+	mask = boot_cpu_data.fpu_msk31;
 	child->thread.fpu.fcr31 = (value & ~mask) | (fcr31 & mask);
 
 	/* FIR may not be written.  */
Index: linux-org-test/arch/mips/math-emu/cp1emu.c
===================================================================
--- linux-org-test.orig/arch/mips/math-emu/cp1emu.c	2015-04-28 14:52:04.000000000 +0100
+++ linux-org-test/arch/mips/math-emu/cp1emu.c	2015-05-12 14:41:06.308256000 +0100
@@ -889,7 +889,7 @@ static inline void cop1_cfc(struct pt_re
 		break;
 
 	case FPCREG_RID:
-		value = current_cpu_data.fpu_id;
+		value = boot_cpu_data.fpu_id;
 		break;
 
 	default:
@@ -921,7 +921,7 @@ static inline void cop1_ctc(struct pt_re
 			 (void *)xcp->cp0_epc, MIPSInst_RT(ir), value);
 
 		/* Preserve read-only bits.  */
-		mask = current_cpu_data.fpu_msk31;
+		mask = boot_cpu_data.fpu_msk31;
 		fcr31 = (value & ~mask) | (fcr31 & mask);
 		break;
 
