Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Aug 2017 20:28:56 +0200 (CEST)
Received: from mail-oi0-x243.google.com ([IPv6:2607:f8b0:4003:c06::243]:36123
        "EHLO mail-oi0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993302AbdHJS1xQNdNN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 10 Aug 2017 20:27:53 +0200
Received: by mail-oi0-x243.google.com with SMTP id b130so1364962oii.3;
        Thu, 10 Aug 2017 11:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RhsPNaB8P6XfywltEinWrhIYucQHEAJqleEC+RxIwjw=;
        b=ly3EEiQlpjvkMEsxwW0wyQ+WHTSUOPLgVoiYXbxQW5lCIa0MaK7EI6P5YKF4+RRuex
         j+vv8YoRbVLSv3yWrFP8T6inb+uzGAOpYub5Pq9kVVzf03sq4w2b8odPdo9FA4upcKI/
         bd4/W0ED/L8g7ufmZkpRDU54m51oSQWzZBCHbrpLfREHLMQ7HW1FtMqupvfyVx2/5fah
         VxheghsdlpfTv/Fr5a1R57VF+5LPr9/MAkPnuo9Gv0vZgcVQcwtEAPdF3OReD4cIf6dL
         fAotr2nQFqOeZXAdwDRLuH2M6uTMdD8X4QGYCuFausSK6XWIMpn4T0o2uV9ISVdgV7RC
         E7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=RhsPNaB8P6XfywltEinWrhIYucQHEAJqleEC+RxIwjw=;
        b=ay62+o6TG7sMKzTAyqnkgqOzHZWYonwrW5mO0wdZVeVulRxvCRGEQLbSw7Yi0jmrON
         Q8aOn361o9G6DBR2yIxtxdDHLj1j+gICvE2M12s+XTgrgP9anPUnexNW6EkhG1QObXdf
         aWKa43hrQYbWxYrkrnAMoLaZU2+l3G/IZnRBQNZV1+zs4fN1/GLE94MwmCMQ49tLHPAP
         wl9ODjN27kaCz2KkM7JrEswpDY475HMvf348FpWQgmrN784G2YeP1c0bi2NaZ2OPrD45
         AEbYYAsgmjL6qy+X5S1olfch7yDR9e2P6ejktuHXlmOOlVpnrDD603RKemGrjzWMa3wI
         H4zg==
X-Gm-Message-State: AHYfb5hd/EoX8oi1s8XAUXo22MD/J1mLsX7hoZi7mljJDg/Yofmdt+QP
        Dpg+DvZ/mgRtU03oOUzipQ==
X-Received: by 10.202.48.10 with SMTP id w10mr13308054oiw.212.1502389666993;
        Thu, 10 Aug 2017 11:27:46 -0700 (PDT)
Received: from serve.minyard.net ([47.184.154.34])
        by smtp.gmail.com with ESMTPSA id p65sm6775996oia.49.2017.08.10.11.27.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Aug 2017 11:27:44 -0700 (PDT)
Received: from t430.minyard.net (t430m.minyard.net [192.168.27.3])
        by serve.minyard.net (Postfix) with ESMTPA id BDEEA93F;
        Thu, 10 Aug 2017 13:27:43 -0500 (CDT)
Received: by t430.minyard.net (Postfix, from userid 1000)
        id 40441300A84; Thu, 10 Aug 2017 13:27:42 -0500 (CDT)
From:   minyard@acm.org
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     Corey Minyard <cminyard@mvista.com>
Subject: [PATCH 3/4] mips: Add DWARF unwinding to assembly
Date:   Thu, 10 Aug 2017 13:27:39 -0500
Message-Id: <1502389660-8969-4-git-send-email-minyard@acm.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1502389660-8969-1-git-send-email-minyard@acm.org>
References: <1502389660-8969-1-git-send-email-minyard@acm.org>
Return-Path: <tcminyard@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59479
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: minyard@acm.org
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

From: Corey Minyard <cminyard@mvista.com>

This will allow kdump dumps to work correclty with MIPS and
future DWARF unwinding of the stack to give accurate tracebacks.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 arch/mips/Makefile                 |   4 +
 arch/mips/include/asm/asm.h        |   3 +
 arch/mips/include/asm/stackframe.h | 231 +++++++++++++++++++++----------------
 arch/mips/kernel/genex.S           |  13 ++-
 arch/mips/mm/tlbex-fault.S         |   7 +-
 arch/mips/vdso/sigreturn.S         |  10 --
 6 files changed, 151 insertions(+), 117 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 0434362..fb0b6dc 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -286,6 +286,10 @@ ifdef CONFIG_64BIT
 bootvars-y	+= ADDR_BITS=64
 endif
 
+# This is required to get dwarf unwinding tables into .debug_frame
+# instead of .eh_frame so we don't discard them.
+KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
+
 LDFLAGS			+= -m $(ld-emul)
 
 ifdef CONFIG_MIPS
diff --git a/arch/mips/include/asm/asm.h b/arch/mips/include/asm/asm.h
index 859cf70..81fae23 100644
--- a/arch/mips/include/asm/asm.h
+++ b/arch/mips/include/asm/asm.h
@@ -55,6 +55,7 @@
 		.type	symbol, @function;		\
 		.ent	symbol, 0;			\
 symbol:		.frame	sp, 0, ra;			\
+		.cfi_startproc;				\
 		.insn
 
 /*
@@ -66,12 +67,14 @@ symbol:		.frame	sp, 0, ra;			\
 		.type	symbol, @function;		\
 		.ent	symbol, 0;			\
 symbol:		.frame	sp, framesize, rpc;		\
+		.cfi_startproc;				\
 		.insn
 
 /*
  * END - mark end of function
  */
 #define END(function)					\
+		.cfi_endproc;				\
 		.end	function;			\
 		.size	function, .-function
 
diff --git a/arch/mips/include/asm/stackframe.h b/arch/mips/include/asm/stackframe.h
index d2fb919..5d3563c 100644
--- a/arch/mips/include/asm/stackframe.h
+++ b/arch/mips/include/asm/stackframe.h
@@ -19,20 +19,43 @@
 #include <asm/asm-offsets.h>
 #include <asm/thread_info.h>
 
+/* Make the addition of cfi info a little easier. */
+	.macro cfi_rel_offset reg offset=0 docfi=0
+	.if \docfi
+	.cfi_rel_offset \reg, \offset
+	.endif
+	.endm
+
+	.macro cfi_st reg offset=0 docfi=0
+	LONG_S	\reg, \offset(sp)
+	cfi_rel_offset \reg, \offset, \docfi
+	.endm
+
+	.macro cfi_restore reg offset=0 docfi=0
+	.if \docfi
+	.cfi_restore \reg
+	.endif
+	.endm
+
+	.macro cfi_ld reg offset=0 docfi=0
+	LONG_L	\reg, \offset(sp)
+	cfi_restore \reg \offset \docfi
+	.endm
+
 #if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
 #define STATMASK 0x3f
 #else
 #define STATMASK 0x1f
 #endif
 
-		.macro	SAVE_AT
+		.macro	SAVE_AT docfi=0
 		.set	push
 		.set	noat
-		LONG_S	$1, PT_R1(sp)
+		cfi_st	$1, PT_R1, \docfi
 		.set	pop
 		.endm
 
-		.macro	SAVE_TEMP
+		.macro	SAVE_TEMP docfi=0
 #ifdef CONFIG_CPU_HAS_SMARTMIPS
 		mflhxu	v1
 		LONG_S	v1, PT_LO(sp)
@@ -44,20 +67,20 @@
 		mfhi	v1
 #endif
 #ifdef CONFIG_32BIT
-		LONG_S	$8, PT_R8(sp)
-		LONG_S	$9, PT_R9(sp)
+		cfi_st	$8, PT_R8, \docfi
+		cfi_st	$9, PT_R9, \docfi
 #endif
-		LONG_S	$10, PT_R10(sp)
-		LONG_S	$11, PT_R11(sp)
-		LONG_S	$12, PT_R12(sp)
+		cfi_st	$10, PT_R10, \docfi
+		cfi_st	$11, PT_R11, \docfi
+		cfi_st	$12, PT_R12, \docfi
 #if !defined(CONFIG_CPU_HAS_SMARTMIPS) && !defined(CONFIG_CPU_MIPSR6)
 		LONG_S	v1, PT_HI(sp)
 		mflo	v1
 #endif
-		LONG_S	$13, PT_R13(sp)
-		LONG_S	$14, PT_R14(sp)
-		LONG_S	$15, PT_R15(sp)
-		LONG_S	$24, PT_R24(sp)
+		cfi_st	$13, PT_R13, \docfi
+		cfi_st	$14, PT_R14, \docfi
+		cfi_st	$15, PT_R15, \docfi
+		cfi_st	$24, PT_R24, \docfi
 #if !defined(CONFIG_CPU_HAS_SMARTMIPS) && !defined(CONFIG_CPU_MIPSR6)
 		LONG_S	v1, PT_LO(sp)
 #endif
@@ -71,16 +94,16 @@
 #endif
 		.endm
 
-		.macro	SAVE_STATIC
-		LONG_S	$16, PT_R16(sp)
-		LONG_S	$17, PT_R17(sp)
-		LONG_S	$18, PT_R18(sp)
-		LONG_S	$19, PT_R19(sp)
-		LONG_S	$20, PT_R20(sp)
-		LONG_S	$21, PT_R21(sp)
-		LONG_S	$22, PT_R22(sp)
-		LONG_S	$23, PT_R23(sp)
-		LONG_S	$30, PT_R30(sp)
+		.macro	SAVE_STATIC docfi=0
+		cfi_st	$16, PT_R16, \docfi
+		cfi_st	$17, PT_R17, \docfi
+		cfi_st	$18, PT_R18, \docfi
+		cfi_st	$19, PT_R19, \docfi
+		cfi_st	$20, PT_R20, \docfi
+		cfi_st	$21, PT_R21, \docfi
+		cfi_st	$22, PT_R22, \docfi
+		cfi_st	$23, PT_R23, \docfi
+		cfi_st	$30, PT_R30, \docfi
 		.endm
 
 /*
@@ -168,7 +191,7 @@
 		.endm
 #endif
 
-		.macro	SAVE_SOME
+		.macro	SAVE_SOME docfi=0
 		.set	push
 		.set	noat
 		.set	reorder
@@ -203,8 +226,11 @@
 #endif
 		.set	reorder
 		 move	k0, sp
+		.if \docfi
+		.cfi_register sp, k0
+		.endif
 		/* Called from user mode, new stack. */
-		get_saved_sp
+		get_saved_sp docfi=\docfi tosp=1
 8:
 #ifdef CONFIG_CPU_DADDI_WORKAROUNDS
 		.set	at=k1
@@ -213,8 +239,12 @@
 #ifdef CONFIG_CPU_DADDI_WORKAROUNDS
 		.set	noat
 #endif
-		LONG_S	k0, PT_R29(sp)
-		LONG_S	$3, PT_R3(sp)
+		.if \docfi
+		.cfi_def_cfa sp,0
+		.endif
+		cfi_st	k0, PT_R29, \docfi
+		cfi_rel_offset  sp, PT_R29, \docfi
+		cfi_st	v1, PT_R3, \docfi
 		/*
 		 * You might think that you don't need to save $0,
 		 * but the FPU emulator and gdb remote debug stub
@@ -222,23 +252,26 @@
 		 */
 		LONG_S	$0, PT_R0(sp)
 		mfc0	v1, CP0_STATUS
-		LONG_S	$2, PT_R2(sp)
+		cfi_st	v0, PT_R2, \docfi
 		LONG_S	v1, PT_STATUS(sp)
-		LONG_S	$4, PT_R4(sp)
+		cfi_st	$4, PT_R4, \docfi
 		mfc0	v1, CP0_CAUSE
-		LONG_S	$5, PT_R5(sp)
+		cfi_st	$5, PT_R5, \docfi
 		LONG_S	v1, PT_CAUSE(sp)
-		LONG_S	$6, PT_R6(sp)
-		LONG_S	ra, PT_R31(sp)
+		cfi_st	$6, PT_R6, \docfi
+		cfi_st	ra, PT_R31, \docfi
 		MFC0	ra, CP0_EPC
-		LONG_S	$7, PT_R7(sp)
+		cfi_st	$7, PT_R7, \docfi
 #ifdef CONFIG_64BIT
-		LONG_S	$8, PT_R8(sp)
-		LONG_S	$9, PT_R9(sp)
+		cfi_st	$8, PT_R8, \docfi
+		cfi_st	$9, PT_R9, \docfi
 #endif
 		LONG_S	ra, PT_EPC(sp)
-		LONG_S	$25, PT_R25(sp)
-		LONG_S	$28, PT_R28(sp)
+		.if \docfi
+		.cfi_rel_offset ra, PT_EPC
+		.endif
+		cfi_st	$25, PT_R25, \docfi
+		cfi_st	$28, PT_R28, \docfi
 
 		/* Set thread_info if we're coming from user mode */
 		mfc0	k0, CP0_STATUS
@@ -255,21 +288,21 @@
 		.set	pop
 		.endm
 
-		.macro	SAVE_ALL
-		SAVE_SOME
-		SAVE_AT
-		SAVE_TEMP
-		SAVE_STATIC
+		.macro	SAVE_ALL docfi=0
+		SAVE_SOME \docfi
+		SAVE_AT \docfi
+		SAVE_TEMP \docfi
+		SAVE_STATIC \docfi
 		.endm
 
-		.macro	RESTORE_AT
+		.macro	RESTORE_AT docfi=0
 		.set	push
 		.set	noat
-		LONG_L	$1,  PT_R1(sp)
+		cfi_ld	$1, PT_R1, \docfi
 		.set	pop
 		.endm
 
-		.macro	RESTORE_TEMP
+		.macro	RESTORE_TEMP docfi=0
 #ifdef CONFIG_CPU_CAVIUM_OCTEON
 		/* Restore the Octeon multiplier state */
 		jal	octeon_mult_restore
@@ -288,33 +321,37 @@
 		mthi	$24
 #endif
 #ifdef CONFIG_32BIT
-		LONG_L	$8, PT_R8(sp)
-		LONG_L	$9, PT_R9(sp)
+		cfi_ld	$8, PT_R8, \docfi
+		cfi_ld	$9, PT_R9, \docfi
 #endif
-		LONG_L	$10, PT_R10(sp)
-		LONG_L	$11, PT_R11(sp)
-		LONG_L	$12, PT_R12(sp)
-		LONG_L	$13, PT_R13(sp)
-		LONG_L	$14, PT_R14(sp)
-		LONG_L	$15, PT_R15(sp)
-		LONG_L	$24, PT_R24(sp)
+		cfi_ld	$10, PT_R10, \docfi
+		cfi_ld	$11, PT_R11, \docfi
+		cfi_ld	$12, PT_R12, \docfi
+		cfi_ld	$13, PT_R13, \docfi
+		cfi_ld	$14, PT_R14, \docfi
+		cfi_ld	$15, PT_R15, \docfi
+		cfi_ld	$24, PT_R24, \docfi
 		.endm
 
-		.macro	RESTORE_STATIC
-		LONG_L	$16, PT_R16(sp)
-		LONG_L	$17, PT_R17(sp)
-		LONG_L	$18, PT_R18(sp)
-		LONG_L	$19, PT_R19(sp)
-		LONG_L	$20, PT_R20(sp)
-		LONG_L	$21, PT_R21(sp)
-		LONG_L	$22, PT_R22(sp)
-		LONG_L	$23, PT_R23(sp)
-		LONG_L	$30, PT_R30(sp)
+		.macro	RESTORE_STATIC docfi=0
+		cfi_ld	$16, PT_R16, \docfi
+		cfi_ld	$17, PT_R17, \docfi
+		cfi_ld	$18, PT_R18, \docfi
+		cfi_ld	$19, PT_R19, \docfi
+		cfi_ld	$20, PT_R20, \docfi
+		cfi_ld	$21, PT_R21, \docfi
+		cfi_ld	$22, PT_R22, \docfi
+		cfi_ld	$23, PT_R23, \docfi
+		cfi_ld	$30, PT_R30, \docfi
+		.endm
+
+		.macro	RESTORE_SP docfi=0
+		cfi_ld	sp, PT_R29, \docfi
 		.endm
 
 #if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
 
-		.macro	RESTORE_SOME
+		.macro	RESTORE_SOME docfi=0
 		.set	push
 		.set	reorder
 		.set	noat
@@ -329,30 +366,30 @@
 		and	v0, v1
 		or	v0, a0
 		mtc0	v0, CP0_STATUS
-		LONG_L	$31, PT_R31(sp)
-		LONG_L	$28, PT_R28(sp)
-		LONG_L	$25, PT_R25(sp)
-		LONG_L	$7,  PT_R7(sp)
-		LONG_L	$6,  PT_R6(sp)
-		LONG_L	$5,  PT_R5(sp)
-		LONG_L	$4,  PT_R4(sp)
-		LONG_L	$3,  PT_R3(sp)
-		LONG_L	$2,  PT_R2(sp)
+		cfi_ld	$31, PT_R31, \docfi
+		cfi_ld	$28, PT_R28, \docfi
+		cfi_ld	$25, PT_R25, \docfi
+		cfi_ld	$7,  PT_R7, \docfi
+		cfi_ld	$6,  PT_R6, \docfi
+		cfi_ld	$5,  PT_R5, \docfi
+		cfi_ld	$4,  PT_R4, \docfi
+		cfi_ld	$3,  PT_R3, \docfi
+		cfi_ld	$2,  PT_R2, \docfi
 		.set	pop
 		.endm
 
-		.macro	RESTORE_SP_AND_RET
+		.macro	RESTORE_SP_AND_RET docfi=0
 		.set	push
 		.set	noreorder
 		LONG_L	k0, PT_EPC(sp)
-		LONG_L	sp, PT_R29(sp)
+		RESTORE_SP \docfi
 		jr	k0
 		 rfe
 		.set	pop
 		.endm
 
 #else
-		.macro	RESTORE_SOME
+		.macro	RESTORE_SOME docfi=0
 		.set	push
 		.set	reorder
 		.set	noat
@@ -369,24 +406,24 @@
 		mtc0	v0, CP0_STATUS
 		LONG_L	v1, PT_EPC(sp)
 		MTC0	v1, CP0_EPC
-		LONG_L	$31, PT_R31(sp)
-		LONG_L	$28, PT_R28(sp)
-		LONG_L	$25, PT_R25(sp)
+		cfi_ld	$31, PT_R31, \docfi
+		cfi_ld	$28, PT_R28, \docfi
+		cfi_ld	$25, PT_R25, \docfi
 #ifdef CONFIG_64BIT
-		LONG_L	$8, PT_R8(sp)
-		LONG_L	$9, PT_R9(sp)
+		cfi_ld	$8, PT_R8, \docfi
+		cfi_ld	$9, PT_R9, \docfi
 #endif
-		LONG_L	$7,  PT_R7(sp)
-		LONG_L	$6,  PT_R6(sp)
-		LONG_L	$5,  PT_R5(sp)
-		LONG_L	$4,  PT_R4(sp)
-		LONG_L	$3,  PT_R3(sp)
-		LONG_L	$2,  PT_R2(sp)
+		cfi_ld	$7,  PT_R7, \docfi
+		cfi_ld	$6,  PT_R6, \docfi
+		cfi_ld	$5,  PT_R5, \docfi
+		cfi_ld	$4,  PT_R4, \docfi
+		cfi_ld	$3,  PT_R3, \docfi
+		cfi_ld	$2,  PT_R2, \docfi
 		.set	pop
 		.endm
 
-		.macro	RESTORE_SP_AND_RET
-		LONG_L	sp, PT_R29(sp)
+		.macro	RESTORE_SP_AND_RET docfi=0
+		RESTORE_SP \docfi
 #ifdef CONFIG_CPU_MIPSR6
 		eretnc
 #else
@@ -398,16 +435,12 @@
 
 #endif
 
-		.macro	RESTORE_SP
-		LONG_L	sp, PT_R29(sp)
-		.endm
-
-		.macro	RESTORE_ALL
-		RESTORE_TEMP
-		RESTORE_STATIC
-		RESTORE_AT
-		RESTORE_SOME
-		RESTORE_SP
+		.macro	RESTORE_ALL docfi=0
+		RESTORE_TEMP \docfi
+		RESTORE_STATIC \docfi
+		RESTORE_AT \docfi
+		RESTORE_SOME \docfi
+		RESTORE_SP \docfi
 		.endm
 
 /*
diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index ae810da..37b9383 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -150,6 +150,7 @@ LEAF(__r4k_wait)
 	.align	5
 BUILD_ROLLBACK_PROLOGUE handle_int
 NESTED(handle_int, PT_SIZE, sp)
+	.cfi_signal_frame
 #ifdef CONFIG_TRACE_IRQFLAGS
 	/*
 	 * Check to see if the interrupted code has just disabled
@@ -181,7 +182,7 @@ NESTED(handle_int, PT_SIZE, sp)
 1:
 	.set pop
 #endif
-	SAVE_ALL
+	SAVE_ALL docfi=1
 	CLI
 	TRACE_IRQS_OFF
 
@@ -269,8 +270,8 @@ NESTED(except_vec_ejtag_debug, 0, sp)
  */
 BUILD_ROLLBACK_PROLOGUE except_vec_vi
 NESTED(except_vec_vi, 0, sp)
-	SAVE_SOME
-	SAVE_AT
+	SAVE_SOME docfi=1
+	SAVE_AT docfi=1
 	.set	push
 	.set	noreorder
 	PTR_LA	v1, except_vec_vi_handler
@@ -396,6 +397,7 @@ NESTED(except_vec_nmi, 0, sp)
 	__FINIT
 
 NESTED(nmi_handler, PT_SIZE, sp)
+	.cfi_signal_frame
 	.set	push
 	.set	noat
 	/*
@@ -478,6 +480,7 @@ NESTED(nmi_handler, PT_SIZE, sp)
 	.macro	__BUILD_HANDLER exception handler clear verbose ext
 	.align	5
 	NESTED(handle_\exception, PT_SIZE, sp)
+	.cfi_signal_frame
 	.set	noat
 	SAVE_ALL
 	FEXPORT(handle_\exception\ext)
@@ -485,8 +488,8 @@ NESTED(nmi_handler, PT_SIZE, sp)
 	.set	at
 	__BUILD_\verbose \exception
 	move	a0, sp
-	PTR_LA	ra, ret_from_exception
-	j	do_\handler
+	jal	do_\handler
+	j	ret_from_exception
 	END(handle_\exception)
 	.endm
 
diff --git a/arch/mips/mm/tlbex-fault.S b/arch/mips/mm/tlbex-fault.S
index 318855e..77db401 100644
--- a/arch/mips/mm/tlbex-fault.S
+++ b/arch/mips/mm/tlbex-fault.S
@@ -12,14 +12,15 @@
 
 	.macro tlb_do_page_fault, write
 	NESTED(tlb_do_page_fault_\write, PT_SIZE, sp)
-	SAVE_ALL
+	.cfi_signal_frame
+	SAVE_ALL docfi=1
 	MFC0	a2, CP0_BADVADDR
 	KMODE
 	move	a0, sp
 	REG_S	a2, PT_BVADDR(sp)
 	li	a1, \write
-	PTR_LA	ra, ret_from_exception
-	j	do_page_fault
+	jal	do_page_fault
+	j	ret_from_exception
 	END(tlb_do_page_fault_\write)
 	.endm
 
diff --git a/arch/mips/vdso/sigreturn.S b/arch/mips/vdso/sigreturn.S
index 715bf59..30c6219 100644
--- a/arch/mips/vdso/sigreturn.S
+++ b/arch/mips/vdso/sigreturn.S
@@ -19,31 +19,21 @@
 	.cfi_sections	.debug_frame
 
 LEAF(__vdso_rt_sigreturn)
-	.cfi_startproc
-	.frame	sp, 0, ra
-	.mask	0x00000000, 0
-	.fmask	0x00000000, 0
 	.cfi_signal_frame
 
 	li	v0, __NR_rt_sigreturn
 	syscall
 
-	.cfi_endproc
 	END(__vdso_rt_sigreturn)
 
 #if _MIPS_SIM == _MIPS_SIM_ABI32
 
 LEAF(__vdso_sigreturn)
-	.cfi_startproc
-	.frame	sp, 0, ra
-	.mask	0x00000000, 0
-	.fmask	0x00000000, 0
 	.cfi_signal_frame
 
 	li	v0, __NR_sigreturn
 	syscall
 
-	.cfi_endproc
 	END(__vdso_sigreturn)
 
 #endif
-- 
2.7.4
