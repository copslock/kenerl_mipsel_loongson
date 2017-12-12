Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Dec 2017 11:04:09 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:34969 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993086AbdLLKBJU6mVC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Dec 2017 11:01:09 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx28.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 12 Dec 2017 10:00:55 +0000
Received: from mredfearn-linux.mipstec.com (10.150.130.83) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Tue, 12 Dec 2017 02:00:01 -0800
From:   Matt Redfearn <matt.redfearn@mips.com>
To:     Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>
CC:     <linux-mips@linux-mips.org>
Subject: [RFC PATCH 14/16] MIPS: Determine kernel thread stack from task_struct
Date:   Tue, 12 Dec 2017 09:58:00 +0000
Message-ID: <1513072682-1371-15-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1513072682-1371-1-git-send-email-matt.redfearn@mips.com>
References: <1513072682-1371-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1513072838-637138-2170-866389-10
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.187894
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Matt.Redfearn@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61443
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@mips.com
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

The current thread info can now be found from the thread_info_ptr. That
can be used to find the task struct (indeed, a later patch will embed
the thread_info in the task struct so these are one and the same). The
kernel stack may then be determined from the value in the task struct.
Replace the get_saved_sp macro with one which operates this way.

Saving of the kernel SP on context switch etc is no longer necessary,
so remove it.

Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
---

 arch/mips/include/asm/stackframe.h | 77 ++++++++++++--------------------------
 arch/mips/kernel/head.S            |  2 -
 arch/mips/kernel/octeon_switch.S   |  3 --
 arch/mips/kernel/r2300_switch.S    |  3 --
 arch/mips/kernel/r4k_switch.S      |  2 -
 arch/mips/kernel/setup.c           |  1 -
 6 files changed, 23 insertions(+), 65 deletions(-)

diff --git a/arch/mips/include/asm/stackframe.h b/arch/mips/include/asm/stackframe.h
index d83d148fec28..2ba65600a8d9 100644
--- a/arch/mips/include/asm/stackframe.h
+++ b/arch/mips/include/asm/stackframe.h
@@ -210,69 +210,37 @@
 #endif
 
 /*
- * get_saved_sp returns the SP for the current CPU by looking in the
- * kernelsp array for it.  If tosp is set, it stores the current sp in
- * k0 and loads the new value in sp.  If not, it clobbers k0 and
- * stores the new value in k1, leaving sp unaffected.
+ * get_saved_sp returns the SP for the current CPU by finding the current
+ * thread_info, using get_saved_ti, finding the task_stack, and adding
+ * the kernel stack size to it.
+ * It stores the current sp in k0 and loads the new value in sp. The value
+ * in k1 is clobbered.
  */
-#ifdef CONFIG_SMP
-		/* SMP variation */
-		.macro	get_saved_sp docfi=0 tosp=0
-		ASM_CPUID_MFC0	k0, ASM_SMP_CPUID_REG
-#if defined(CONFIG_32BIT) || defined(KBUILD_64BIT_SYM32)
-		lui	k1, %hi(kernelsp)
-#else
-		lui	k1, %highest(kernelsp)
-		daddiu	k1, %higher(kernelsp)
-		dsll	k1, 16
-		daddiu	k1, %hi(kernelsp)
-		dsll	k1, 16
-#endif
-		LONG_SRL	k0, SMP_CPUID_PTRSHIFT
-		LONG_ADDU	k1, k0
-		.if \tosp
+		.macro	get_saved_sp docfi=0
+		/* Get current thread info into k1 */
+		get_saved_ti	k1, k0
+		/* Get task struct into k1 */
+		LONG_L		k1, TI_TASK(k1)
+		/* Get the stack into k1 */
+		LONG_L		k1, TASK_STACK(k1)
+		/* Get starting stack location */
+		.set	at=k0
+		PTR_ADDU	k1, k1, _THREAD_SIZE - 32
+		.set	noat
+
+		/* Save current SP to k0 */
 		move	k0, sp
 		.if \docfi
 		.cfi_register sp, k0
 		.endif
-		LONG_L	sp, %lo(kernelsp)(k1)
-		.else
-		LONG_L	k1, %lo(kernelsp)(k1)
-		.endif
-		.endm
 
-		.macro	set_saved_sp stackp temp temp2
-		ASM_CPUID_MFC0	\temp, ASM_SMP_CPUID_REG
-		LONG_SRL	\temp, SMP_CPUID_PTRSHIFT
-		LONG_S	\stackp, kernelsp(\temp)
-		.endm
-#else /* !CONFIG_SMP */
-		/* Uniprocessor variation */
-		.macro	get_saved_sp docfi=0 tosp=0
-#if defined(CONFIG_32BIT) || defined(KBUILD_64BIT_SYM32)
-		lui	k1, %hi(kernelsp)
-#else
-		lui	k1, %highest(kernelsp)
-		daddiu	k1, %higher(kernelsp)
-		dsll	k1, k1, 16
-		daddiu	k1, %hi(kernelsp)
-		dsll	k1, k1, 16
-#endif
-		.if \tosp
-		move	k0, sp
+		/* Activate new stack */
+		move	sp, k1
 		.if \docfi
-		.cfi_register sp, k0
-		.endif
-		LONG_L	sp, %lo(kernelsp)(k1)
-		.else
-		LONG_L	k1, %lo(kernelsp)(k1)
+		.cfi_register k1, sp
 		.endif
-		.endm
 
-		.macro	set_saved_sp stackp temp temp2
-		LONG_S	\stackp, kernelsp
 		.endm
-#endif
 
 		.macro	SAVE_SOME docfi=0
 		.set	push
@@ -287,8 +255,9 @@
 		.cfi_register sp, k0
 		.endif
 		.set	reorder
+
 		/* Called from user mode, new stack. */
-		get_saved_sp docfi=\docfi tosp=1
+		get_saved_sp docfi=\docfi
 8:
 #ifdef CONFIG_CPU_DADDI_WORKAROUNDS
 		.set	at=k1
diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S
index c74f2e1f4b08..5a7e0dac8ada 100644
--- a/arch/mips/kernel/head.S
+++ b/arch/mips/kernel/head.S
@@ -136,7 +136,6 @@ dtb_found:
 	PTR_ADDU	sp, $28
 	back_to_back_c0_hazard
 	set_saved_ti	$28, t0
-	set_saved_sp	sp, t0, t1
 	PTR_SUBU	sp, 4 * SZREG		# init stack pointer
 
 #ifdef CONFIG_RELOCATABLE
@@ -148,7 +147,6 @@ dtb_found:
 	PTR_ADDU	sp, v0
 
 	set_saved_ti	$28, t0
-	set_saved_sp	sp, t0, t1
 
 	/*
 	 * Find start_kernel in relocated image and jump there
diff --git a/arch/mips/kernel/octeon_switch.S b/arch/mips/kernel/octeon_switch.S
index b0ef486ad6c1..8f2d80b9b8a4 100644
--- a/arch/mips/kernel/octeon_switch.S
+++ b/arch/mips/kernel/octeon_switch.S
@@ -75,9 +75,6 @@
 	cpu_restore_nonscratch a1
 	set_saved_ti	$28, t0
 
-	PTR_ADDU	t0, $28, _THREAD_SIZE - 32
-	set_saved_sp	t0, t1, t2
-
 	mfc0	t1, CP0_STATUS		/* Do we really need this? */
 	li	a3, 0xff01
 	and	t1, a3
diff --git a/arch/mips/kernel/r2300_switch.S b/arch/mips/kernel/r2300_switch.S
index 6e6c012dfc5e..db8186ed9b24 100644
--- a/arch/mips/kernel/r2300_switch.S
+++ b/arch/mips/kernel/r2300_switch.S
@@ -50,9 +50,6 @@ LEAF(resume)
 	cpu_restore_nonscratch a1
 	set_saved_ti	$28, t0
 
-	addiu	t1, $28, _THREAD_SIZE - 32
-	sw	t1, kernelsp
-
 	mfc0	t1, CP0_STATUS		/* Do we really need this? */
 	li	a3, 0xff01
 	and	t1, a3
diff --git a/arch/mips/kernel/r4k_switch.S b/arch/mips/kernel/r4k_switch.S
index 5afbbc1b4bd3..6428904a34c7 100644
--- a/arch/mips/kernel/r4k_switch.S
+++ b/arch/mips/kernel/r4k_switch.S
@@ -45,8 +45,6 @@
 	cpu_restore_nonscratch a1
 	set_saved_ti	$28, t0
 
-	PTR_ADDU	t0, $28, _THREAD_SIZE - 32
-	set_saved_sp	t0, t1, t2
 	mfc0	t1, CP0_STATUS		/* Do we really need this? */
 	li	a3, 0xff01
 	and	t1, a3
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index d7078589a077..53fbd5faff41 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -1024,7 +1024,6 @@ void __init setup_arch(char **cmdline_p)
 	paging_init();
 }
 
-unsigned long kernelsp[NR_CPUS];
 unsigned long thread_info_ptr[NR_CPUS];
 unsigned long fw_arg0, fw_arg1, fw_arg2, fw_arg3;
 
-- 
2.7.4
