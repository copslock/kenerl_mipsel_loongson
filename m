Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Jun 2013 01:09:13 +0200 (CEST)
Received: from mail-ie0-f172.google.com ([209.85.223.172]:63741 "EHLO
        mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835166Ab3FGXD5L5DPh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 8 Jun 2013 01:03:57 +0200
Received: by mail-ie0-f172.google.com with SMTP id 17so12206089iea.31
        for <multiple recipients>; Fri, 07 Jun 2013 16:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=GTTjSqkRt/Wn2dh+lHenZOrMTA8HgTfci1MJD/L/2oM=;
        b=cEIywNeGtft2JBcBDX+hSbpNrHF5B0h5uXmtATvmHnEuVvQK7sNthxGAy+UTqcGY3o
         CmuelcYr6TjZ3hM2vX3RiSjJIiLuOss+MdGT0Ni+QLo6SSPSuz4d4/57eidSo/wUCPUh
         l1es43oJIt4baxssJi9rqFQgnjY1pjXAkdqYJdn1sg5ux37/6axAuejdysqkmD/8InAL
         UcObdYaaIeB1fZcCRcsA/RcO+RluZUfH2Jl2LnADHjy0KJW6fNLdlxWSu9K91hUdTPvO
         V72KDKTN1adDuUUzQl+8Z8TjMTbf4Me3kIwLqeqLwgbFRbngACOngWnOsa3Nwj6x/q7/
         tPig==
X-Received: by 10.50.78.129 with SMTP id b1mr2235573igx.59.1370646231066;
        Fri, 07 Jun 2013 16:03:51 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id ct8sm1164870igb.7.2013.06.07.16.03.49
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 07 Jun 2013 16:03:50 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r57N3mdZ006670;
        Fri, 7 Jun 2013 16:03:48 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r57N3l7q006669;
        Fri, 7 Jun 2013 16:03:47 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, Sanjay Lal <sanjayl@kymasys.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 15/31] mips/kvm: Exception handling to leave and reenter guest mode.
Date:   Fri,  7 Jun 2013 16:03:19 -0700
Message-Id: <1370646215-6543-16-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
References: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36733
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

Currently this is a little complex, here are the facts about how it works:

o When running in Guest mode we set the high bit of CP0_XCONTEXT.  If
  this bit is clear, we don't do anything special on an exception.

o If we are in guest mode, upon an exception we:

  1) load the stack pointer from the mips_kvm_rootsp array instead of
     kernelsp.

  2) Clear GuestCtl[GM] and high bit of CP0_XCONTEXT.

  3) Restore host ASID and PGD pointer.

o Upon restarting from an exception we test the task TIF_GUESTMODE
  flag if it is clear, nothing special is done.

o If Guest mode is active for the thread we:

  1) Compare the stack pointer to mips_kvm_rootsp, if it doesn't match
     we are not reentering guest mode, so no more special processing
     is done.

  2) If reentering guest mode:

  2a) Set high bit of CP0_XCONTEXT and GuestCtl[GM].

  2b) Set Guest mode ASID and PGD pointer.

This allows a single set of exception handlers to be used for both
host and guest mode operation.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/stackframe.h | 135 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 132 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/stackframe.h b/arch/mips/include/asm/stackframe.h
index 20627b2..bf2ec48 100644
--- a/arch/mips/include/asm/stackframe.h
+++ b/arch/mips/include/asm/stackframe.h
@@ -17,6 +17,7 @@
 #include <asm/asmmacro.h>
 #include <asm/mipsregs.h>
 #include <asm/asm-offsets.h>
+#include <asm/thread_info.h>
 
 /*
  * For SMTC kernel, global IE should be left set, and interrupts
@@ -98,7 +99,9 @@
 #define CPU_ID_REG CP0_CONTEXT
 #define CPU_ID_MFC0 MFC0
 #endif
-		.macro	get_saved_sp	/* SMP variation */
+#define CPU_ID_MASK ((1 << 13) - 1)
+
+		.macro	get_saved_sp_for_save_some	/* SMP variation */
 		CPU_ID_MFC0	k0, CPU_ID_REG
 #if defined(CONFIG_32BIT) || defined(KBUILD_64BIT_SYM32)
 		lui	k1, %hi(kernelsp)
@@ -110,15 +113,49 @@
 		dsll	k1, 16
 #endif
 		LONG_SRL	k0, PTEBASE_SHIFT
+#ifdef CONFIG_KVM_MIPSVZ
+		andi	k0, CPU_ID_MASK /* high bits indicate guest mode. */
+#endif
 		LONG_ADDU	k1, k0
 		LONG_L	k1, %lo(kernelsp)(k1)
 		.endm
 
+		.macro get_saved_sp
+		CPU_ID_MFC0	k0, CPU_ID_REG
+		get_saved_sp_for_save_some
+		.endm
+
+		.macro	get_mips_kvm_rootsp	/* SMP variation */
+#if defined(CONFIG_32BIT) || defined(KBUILD_64BIT_SYM32)
+		lui	k1, %hi(mips_kvm_rootsp)
+#else
+		lui	k1, %highest(mips_kvm_rootsp)
+		daddiu	k1, %higher(mips_kvm_rootsp)
+		dsll	k1, 16
+		daddiu	k1, %hi(mips_kvm_rootsp)
+		dsll	k1, 16
+#endif
+		LONG_SRL	k0, PTEBASE_SHIFT
+		andi	k0, CPU_ID_MASK /* high bits indicate guest mode. */
+		LONG_ADDU	k1, k0
+		LONG_L	k1, %lo(mips_kvm_rootsp)(k1)
+		.endm
+
 		.macro	set_saved_sp stackp temp temp2
 		CPU_ID_MFC0	\temp, CPU_ID_REG
 		LONG_SRL	\temp, PTEBASE_SHIFT
+#ifdef CONFIG_KVM_MIPSVZ
+		andi	k0, CPU_ID_MASK /* high bits indicate guest mode. */
+#endif
 		LONG_S	\stackp, kernelsp(\temp)
 		.endm
+
+		.macro	set_mips_kvm_rootsp stackp temp
+		CPU_ID_MFC0	\temp, CPU_ID_REG
+		LONG_SRL	\temp, PTEBASE_SHIFT
+		andi	k0, CPU_ID_MASK /* high bits indicate guest mode. */
+		LONG_S	\stackp, mips_kvm_rootsp(\temp)
+		.endm
 #else
 		.macro	get_saved_sp	/* Uniprocessor variation */
 #ifdef CONFIG_CPU_JUMP_WORKAROUNDS
@@ -152,9 +189,27 @@
 		LONG_L	k1, %lo(kernelsp)(k1)
 		.endm
 
+		.macro	get_mips_kvm_rootsp	/* Uniprocessor variation */
+#if defined(CONFIG_32BIT) || defined(KBUILD_64BIT_SYM32)
+		lui	k1, %hi(mips_kvm_rootsp)
+#else
+		lui	k1, %highest(mips_kvm_rootsp)
+		daddiu	k1, %higher(mips_kvm_rootsp)
+		dsll	k1, k1, 16
+		daddiu	k1, %hi(mips_kvm_rootsp)
+		dsll	k1, k1, 16
+#endif
+		LONG_L	k1, %lo(mips_kvm_rootsp)(k1)
+		.endm
+
+
 		.macro	set_saved_sp stackp temp temp2
 		LONG_S	\stackp, kernelsp
 		.endm
+
+		.macro	set_mips_kvm_rootsp stackp temp
+		LONG_S	\stackp, mips_kvm_rootsp
+		.endm
 #endif
 
 		.macro	SAVE_SOME
@@ -164,11 +219,21 @@
 		mfc0	k0, CP0_STATUS
 		sll	k0, 3		/* extract cu0 bit */
 		.set	noreorder
+#ifdef CONFIG_KVM_MIPSVZ
+		bgez	k0, 7f
+		 CPU_ID_MFC0	k0, CPU_ID_REG
+		bgez	k0, 8f
+		 move	k1, sp
+		get_mips_kvm_rootsp
+		b	8f
+		 nop
+#else
 		bltz	k0, 8f
 		 move	k1, sp
+#endif
 		.set	reorder
 		/* Called from user mode, new stack. */
-		get_saved_sp
+7:		get_saved_sp_for_save_some
 #ifndef CONFIG_CPU_DADDI_WORKAROUNDS
 8:		move	k0, sp
 		PTR_SUBU sp, k1, PT_SIZE
@@ -227,6 +292,35 @@
 		LONG_S	$31, PT_R31(sp)
 		ori	$28, sp, _THREAD_MASK
 		xori	$28, _THREAD_MASK
+#ifdef CONFIG_KVM_MIPSVZ
+		CPU_ID_MFC0	k0, CPU_ID_REG
+		.set	noreorder
+		bgez	k0, 8f
+		/* Must clear GuestCtl0[GM] */
+		 dins	k0, zero, 63, 1
+		.set	reorder
+		dmtc0	k0, CPU_ID_REG
+		mfc0	k0, CP0_GUESTCTL0
+		ins	k0, zero, MIPS_GUESTCTL0B_GM, 1
+		mtc0	k0, CP0_GUESTCTL0
+		LONG_L	v0, TI_TASK($28)
+		lw	v1, THREAD_MM_ASID(v0)
+		dmtc0	v1, CP0_ENTRYHI
+		LONG_L	v1, TASK_MM(v0)
+		.set	noreorder
+		jal	tlbmiss_handler_setup_pgd_array
+		 LONG_L	a0, MM_PGD(v1)
+		.set	reorder
+		/*
+		 * With KVM_MIPSVZ, we must not clobber k0/k1
+		 * they were saved before they were used
+		 */
+8:
+		MFC0	k0, CP0_KSCRATCH1
+		MFC0	v1, CP0_KSCRATCH2
+		LONG_S	k0, PT_R26(sp)
+		LONG_S	v1, PT_R27(sp)
+#endif
 #ifdef CONFIG_CPU_CAVIUM_OCTEON
 		.set	mips64
 		pref	0, 0($28)	/* Prefetch the current pointer */
@@ -439,10 +533,45 @@
 		.set	mips0
 #endif /* CONFIG_MIPS_MT_SMTC */
 		LONG_L	v1, PT_EPC(sp)
+		LONG_L	$25, PT_R25(sp)
 		MTC0	v1, CP0_EPC
+#ifdef CONFIG_KVM_MIPSVZ
+	/*
+	 * Only if TIF_GUESTMODE && sp is the saved KVM sp, return to
+	 * guest mode.
+	 */
+		LONG_L	v0, TI_FLAGS($28)
+		li	k1, _TIF_GUESTMODE
+		and	v0, v0, k1
+		beqz	v0, 8f
+		CPU_ID_MFC0	k0, CPU_ID_REG
+		get_mips_kvm_rootsp
+		PTR_SUBU k1, k1, PT_SIZE
+		bne	k1, sp, 8f
+	/* Set the high order bit of CPU_ID_REG to indicate guest mode. */
+		dli	v0, 1
+		dmfc0	v1, CPU_ID_REG
+		dins	v1, v0, 63, 1
+		dmtc0	v1, CPU_ID_REG
+		/* Must set GuestCtl0[GM] */
+		mfc0	v1, CP0_GUESTCTL0
+		ins	v1, v0, MIPS_GUESTCTL0B_GM, 1
+		mtc0	v1, CP0_GUESTCTL0
+
+		LONG_L	v0, TI_TASK($28)
+		lw	v1, THREAD_GUEST_ASID(v0)
+		dmtc0	v1, CP0_ENTRYHI
+		LONG_L	v1, THREAD_VCPU(v0)
+		LONG_L	v1, KVM_VCPU_KVM(v1)
+		LONG_L	v1, KVM_ARCH_IMPL(v1)
+		.set	noreorder
+		jal	tlbmiss_handler_setup_pgd_array
+		 LONG_L	a0, KVM_MIPS_VZ_PGD(v1)
+		.set	reorder
+8:
+#endif
 		LONG_L	$31, PT_R31(sp)
 		LONG_L	$28, PT_R28(sp)
-		LONG_L	$25, PT_R25(sp)
 #ifdef CONFIG_64BIT
 		LONG_L	$8, PT_R8(sp)
 		LONG_L	$9, PT_R9(sp)
-- 
1.7.11.7
