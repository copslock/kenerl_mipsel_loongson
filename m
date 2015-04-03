Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Apr 2015 00:35:13 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27025305AbbDCW1KdY20n (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Apr 2015 00:27:10 +0200
Date:   Fri, 3 Apr 2015 23:27:10 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH 40/48] MIPS: Always clear FCSR cause bits after emulation
In-Reply-To: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.11.1504032015180.21028@eddie.linux-mips.org>
References: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46757
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

Clear any FCSR cause bits recorded in the saved FPU context after 
emulation in all cases rather than in `do_fpe' only, so that any 
unmasked IEEE 754 exception left from emulation does not cause a fatal 
kernel-mode FPE hardware exception with the CTC1 instruction used by the 
kernel to subsequently restore FCSR hardware from the saved FPU context.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-mips-fpe-emu-fcsr-cause.diff
Index: linux/arch/mips/kernel/mips-r2-to-r6-emul.c
===================================================================
--- linux.orig/arch/mips/kernel/mips-r2-to-r6-emul.c	2015-04-02 20:27:53.338178000 +0100
+++ linux/arch/mips/kernel/mips-r2-to-r6-emul.c	2015-04-02 20:27:58.241225000 +0100
@@ -1170,6 +1170,12 @@ int mipsr2_decoder(struct pt_regs *regs,
 					       &fault_addr);
 
 		/*
+		 * We can't allow the emulated instruction to leave any of
+		 * the cause bits set in $fcr31.
+		 */
+		current->thread.fpu.fcr31 &= ~FPU_CSR_ALL_X;
+
+		/*
 		 * this is a tricky issue - lose_fpu() uses LL/SC atomics
 		 * if FPU is owned and effectively cancels user level LL/SC.
 		 * So, it could be logical to don't restore FPU ownership here.
Index: linux/arch/mips/kernel/traps.c
===================================================================
--- linux.orig/arch/mips/kernel/traps.c	2015-04-02 20:27:58.065226000 +0100
+++ linux/arch/mips/kernel/traps.c	2015-04-02 20:27:58.244233000 +0100
@@ -761,6 +761,12 @@ static int simulate_fp(struct pt_regs *r
 	sig = fpu_emulator_cop1Handler(regs, &current->thread.fpu, 1,
 				       &fault_addr);
 
+	/*
+	 * We can't allow the emulated instruction to leave any of
+	 * the cause bits set in $fcr31.
+	 */
+	current->thread.fpu.fcr31 &= ~FPU_CSR_ALL_X;
+
 	/* If something went wrong, signal */
 	process_fpemu_return(sig, fault_addr);
 
@@ -807,7 +813,7 @@ asmlinkage void do_fpe(struct pt_regs *r
 
 		/*
 		 * We can't allow the emulated instruction to leave any of
-		 * the cause bit set in $fcr31.
+		 * the cause bits set in $fcr31.
 		 */
 		current->thread.fpu.fcr31 &= ~FPU_CSR_ALL_X;
 
@@ -1384,6 +1390,13 @@ asmlinkage void do_cpu(struct pt_regs *r
 			sig = fpu_emulator_cop1Handler(regs,
 						       &current->thread.fpu,
 						       0, &fault_addr);
+
+			/*
+			 * We can't allow the emulated instruction to leave
+			 * any of the cause bits set in $fcr31.
+			 */
+			current->thread.fpu.fcr31 &= ~FPU_CSR_ALL_X;
+
 			if (!process_fpemu_return(sig, fault_addr) && !err)
 				mt_ase_fp_affinity();
 		}
