Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Dec 2017 11:03:41 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:57471 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994632AbdLLKA5f4JkC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Dec 2017 11:00:57 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx28.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 12 Dec 2017 10:00:51 +0000
Received: from mredfearn-linux.mipstec.com (10.150.130.83) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Tue, 12 Dec 2017 01:59:59 -0800
From:   Matt Redfearn <matt.redfearn@mips.com>
To:     Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>
CC:     <linux-mips@linux-mips.org>
Subject: [RFC PATCH 12/16] MIPS: Keep a copy of each CPU's current_thread
Date:   Tue, 12 Dec 2017 09:57:58 +0000
Message-ID: <1513072682-1371-13-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1513072682-1371-1-git-send-email-matt.redfearn@mips.com>
References: <1513072682-1371-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1513072838-637138-2170-866389-9
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
X-archive-position: 61442
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

In preparation for CONFIG_THREAD_INFO_IN_TASK, where the thread_info is
no longer located at the bottom of the kernel's stack, keep a copy of
each CPU's current thread. Initialise it to the init thread on each CPU,
switch it on context switch, and restore it on entry to kernel space.

Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
---

 arch/mips/include/asm/stackframe.h  | 50 ++++++++++++++++++++++++++++++++++---
 arch/mips/include/asm/thread_info.h |  3 +++
 arch/mips/kernel/genex.S            |  8 +++---
 arch/mips/kernel/head.S             |  2 ++
 arch/mips/kernel/octeon_switch.S    |  3 ++-
 arch/mips/kernel/r2300_switch.S     |  3 ++-
 arch/mips/kernel/r4k_switch.S       |  3 ++-
 arch/mips/kernel/setup.c            |  1 +
 arch/mips/kernel/smp.c              |  1 +
 9 files changed, 63 insertions(+), 11 deletions(-)

diff --git a/arch/mips/include/asm/stackframe.h b/arch/mips/include/asm/stackframe.h
index bdcd4088d764..d83d148fec28 100644
--- a/arch/mips/include/asm/stackframe.h
+++ b/arch/mips/include/asm/stackframe.h
@@ -95,8 +95,7 @@
 #endif
 
 		/* Set thread_info if we're coming from user mode */
-		ori	$28, sp, _THREAD_MASK
-		xori	$28, _THREAD_MASK
+		get_saved_ti $28, v1
 #ifdef CONFIG_CPU_CAVIUM_OCTEON
 		.set	push
 		.set	mips64
@@ -165,13 +164,58 @@
 		.endm
 
 /*
+ * get_saved_ti returns the thread_info for the current CPU by looking in the
+ * thread_info_ptr array for it. It clobbers k0 and returns the value in k1.
+ */
+#ifdef CONFIG_SMP
+		/* SMP variation */
+		.macro	get_saved_ti out temp
+		ASM_CPUID_MFC0	\temp, ASM_SMP_CPUID_REG
+#if defined(CONFIG_32BIT) || defined(KBUILD_64BIT_SYM32)
+		lui		\out, %hi(thread_info_ptr)
+#else
+		lui		\out, %highest(thread_info_ptr)
+		daddiu		\out, %higher(thread_info_ptr)
+		dsll		\out, 16
+		daddiu		\out, %hi(thread_info_ptr)
+		dsll		\out, 16
+#endif
+		LONG_SRL	\temp, SMP_CPUID_PTRSHIFT
+		LONG_ADDU	\out, \temp
+		LONG_L		\out, %lo(thread_info_ptr)(\out)
+		.endm
+
+		.macro	set_saved_ti ti temp
+		ASM_CPUID_MFC0	\temp, ASM_SMP_CPUID_REG
+		LONG_SRL	\temp, SMP_CPUID_PTRSHIFT
+		LONG_S		\ti, thread_info_ptr(\temp)
+		.endm
+#else /* !CONFIG_SMP */
+		.macro	get_saved_ti out temp	/* Uniprocessor variation */
+#if defined(CONFIG_32BIT) || defined(KBUILD_64BIT_SYM32)
+		lui		\out, %hi(thread_info_ptr)
+#else
+		lui		\out, %highest(thread_info_ptr)
+		daddiu		\out, %higher(thread_info_ptr)
+		dsll		\out, \out, 16
+		daddiu		\out, %hi(thread_info_ptr)
+		dsll		\out, \out, 16
+#endif
+		LONG_L		\out, %lo(thread_info_ptr)(\out)
+		.endm
+
+		.macro		set_saved_ti ti temp
+		LONG_S		\ti, thread_info_ptr
+		.endm
+#endif
+
+/*
  * get_saved_sp returns the SP for the current CPU by looking in the
  * kernelsp array for it.  If tosp is set, it stores the current sp in
  * k0 and loads the new value in sp.  If not, it clobbers k0 and
  * stores the new value in k1, leaving sp unaffected.
  */
 #ifdef CONFIG_SMP
-
 		/* SMP variation */
 		.macro	get_saved_sp docfi=0 tosp=0
 		ASM_CPUID_MFC0	k0, ASM_SMP_CPUID_REG
diff --git a/arch/mips/include/asm/thread_info.h b/arch/mips/include/asm/thread_info.h
index 5e8927f99a76..b8cc81055d57 100644
--- a/arch/mips/include/asm/thread_info.h
+++ b/arch/mips/include/asm/thread_info.h
@@ -55,6 +55,9 @@ struct thread_info {
 /* How to get the thread information struct from C.  */
 register struct thread_info *__current_thread_info __asm__("$28");
 
+/* thread_info pointer for each CPU */
+extern unsigned long thread_info_ptr[NR_CPUS];
+
 static inline struct thread_info *current_thread_info(void)
 {
 	return __current_thread_info;
diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index 37b9383eacd3..9f7347211ab4 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -581,12 +581,10 @@ docheck:
 
 isrdhwr:
 	/* The insn is rdhwr.  No need to check CAUSE.BD here. */
-	get_saved_sp	/* k1 := current_thread_info */
+	get_saved_ti	k1, k0
 	.set	noreorder
 	MFC0	k0, CP0_EPC
 #if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
-	ori	k1, _THREAD_MASK
-	xori	k1, _THREAD_MASK
 	LONG_L	v1, TI_TP_VALUE(k1)
 	LONG_ADDIU	k0, 4
 	jr	k0
@@ -601,8 +599,8 @@ isrdhwr:
 #endif
 	MTC0	k0, CP0_EPC
 	/* I hope three instructions between MTC0 and ERET are enough... */
-	ori	k1, _THREAD_MASK
-	xori	k1, _THREAD_MASK
+	nop
+	nop
 	LONG_L	v1, TI_TP_VALUE(k1)
 	.set	arch=r4000
 	eret
diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S
index 0fcb3e048ece..c74f2e1f4b08 100644
--- a/arch/mips/kernel/head.S
+++ b/arch/mips/kernel/head.S
@@ -135,6 +135,7 @@ dtb_found:
 	PTR_LI		sp, _THREAD_SIZE - 32 - PT_SIZE
 	PTR_ADDU	sp, $28
 	back_to_back_c0_hazard
+	set_saved_ti	$28, t0
 	set_saved_sp	sp, t0, t1
 	PTR_SUBU	sp, 4 * SZREG		# init stack pointer
 
@@ -146,6 +147,7 @@ dtb_found:
 	PTR_ADDU	$28, v0
 	PTR_ADDU	sp, v0
 
+	set_saved_ti	$28, t0
 	set_saved_sp	sp, t0, t1
 
 	/*
diff --git a/arch/mips/kernel/octeon_switch.S b/arch/mips/kernel/octeon_switch.S
index e42113fe2762..b0ef486ad6c1 100644
--- a/arch/mips/kernel/octeon_switch.S
+++ b/arch/mips/kernel/octeon_switch.S
@@ -69,10 +69,11 @@
 
 	/*
 	 * The order of restoring the registers takes care of the race
-	 * updating $28, $29 and kernelsp without disabling ints.
+	 * updating $28, $29 and saved_ti without disabling ints.
 	 */
 	move	$28, a2
 	cpu_restore_nonscratch a1
+	set_saved_ti	$28, t0
 
 	PTR_ADDU	t0, $28, _THREAD_SIZE - 32
 	set_saved_sp	t0, t1, t2
diff --git a/arch/mips/kernel/r2300_switch.S b/arch/mips/kernel/r2300_switch.S
index 665897139f30..6e6c012dfc5e 100644
--- a/arch/mips/kernel/r2300_switch.S
+++ b/arch/mips/kernel/r2300_switch.S
@@ -44,10 +44,11 @@ LEAF(resume)
 
 	/*
 	 * The order of restoring the registers takes care of the race
-	 * updating $28, $29 and kernelsp without disabling ints.
+	 * updating $28, $29 and saved_ti without disabling ints.
 	 */
 	move	$28, a2
 	cpu_restore_nonscratch a1
+	set_saved_ti	$28, t0
 
 	addiu	t1, $28, _THREAD_SIZE - 32
 	sw	t1, kernelsp
diff --git a/arch/mips/kernel/r4k_switch.S b/arch/mips/kernel/r4k_switch.S
index 17cf9341c1cf..5afbbc1b4bd3 100644
--- a/arch/mips/kernel/r4k_switch.S
+++ b/arch/mips/kernel/r4k_switch.S
@@ -39,10 +39,11 @@
 
 	/*
 	 * The order of restoring the registers takes care of the race
-	 * updating $28, $29 and kernelsp without disabling ints.
+	 * updating $28, $29 and saved_ti without disabling ints.
 	 */
 	move	$28, a2
 	cpu_restore_nonscratch a1
+	set_saved_ti	$28, t0
 
 	PTR_ADDU	t0, $28, _THREAD_SIZE - 32
 	set_saved_sp	t0, t1, t2
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 702c678de116..d7078589a077 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -1025,6 +1025,7 @@ void __init setup_arch(char **cmdline_p)
 }
 
 unsigned long kernelsp[NR_CPUS];
+unsigned long thread_info_ptr[NR_CPUS];
 unsigned long fw_arg0, fw_arg1, fw_arg2, fw_arg3;
 
 #ifdef CONFIG_USE_OF
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index defec7499ccd..b93e6748f38d 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -458,6 +458,7 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
 {
 	int err;
 
+	thread_info_ptr[cpu] = (unsigned long)task_thread_info(tidle);
 	err = mp_ops->boot_secondary(cpu, tidle);
 	if (err)
 		return err;
-- 
2.7.4
