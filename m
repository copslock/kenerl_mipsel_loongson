Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Aug 2017 20:29:21 +0200 (CEST)
Received: from mail-oi0-x241.google.com ([IPv6:2607:f8b0:4003:c06::241]:34642
        "EHLO mail-oi0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993893AbdHJS1yrBp6N (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 10 Aug 2017 20:27:54 +0200
Received: by mail-oi0-x241.google.com with SMTP id v11so1373375oif.1;
        Thu, 10 Aug 2017 11:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Lcl/3a1TLLfk79ZdZ9GDoQFnIqOpdxkFlbB6eIiqzL8=;
        b=CZgYpbXWg59XFQmltrS0m9/CB+TdXpMbjVRRYh3SMs4DqevUxzczWOB1VGKhKBiqq6
         H/mvPj2SOEzfpgHLHnVHj714sMIVMEjVQZia4FYfVW0Bxs+UcgUqc8boa4btTgRjS2EH
         WLHqAcKYCFUFUH9f8ljuVEWYBhpTsdW492yVIq5z8jCtxF25viNu65BKS7TiS+DaRpZ7
         VqY5qW67FyRNGcrqU7FCaYAOnSp4S0zb6Tg4ddqoi5XIYtOfvgJyDBMY2MkFFRoHiHJK
         mM71pXKdc2GItqKQ4AmeOZam6VpQRkoQk4KSxsueAYK114di6WyCwAiHZPqrcZAU8yQQ
         vF/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=Lcl/3a1TLLfk79ZdZ9GDoQFnIqOpdxkFlbB6eIiqzL8=;
        b=TBKenBp11/LEmBTOIjGfxF00KwH4t5EwjfhNryvf8W2dR19OKdFzrRvPwvLivWRCPu
         fF9c6ZqaF7yA+zwWDrMp8PnX3PhF6A6h0PqfE5Pa0EL2p+/0THRALz3yJ3T01Pv1Bfqa
         HAYXPk9CvIDmIDN3S3OPNYWQoha7B7e37Oo088dYD38nlR+pnaDd/07TtSDMkNTHJ8+m
         tHjo7TApFMgbVW/0w6VZ1x5m1gzgPmMLLJGLk2IUoeKFyZqmRJztb3sqfvzsA13/4wVs
         wnUbdacIFCI2QjyqhS240lP3xSZBauQGl+OuB7jfjcHMcR3KK7ys1i1d33XPnAhy/huT
         ZyYQ==
X-Gm-Message-State: AHYfb5iB7lT+cq64sXvht8m2UEg2zx6D03LBSj0UrT91w/my5R2EGnIw
        pUm+DNVGwKljqUWgmf9bJg==
X-Received: by 10.202.79.6 with SMTP id d6mr14876354oib.6.1502389668632;
        Thu, 10 Aug 2017 11:27:48 -0700 (PDT)
Received: from serve.minyard.net ([47.184.154.34])
        by smtp.gmail.com with ESMTPSA id v186sm7094673oie.44.2017.08.10.11.27.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Aug 2017 11:27:47 -0700 (PDT)
Received: from t430.minyard.net (t430m.minyard.net [192.168.27.3])
        by serve.minyard.net (Postfix) with ESMTPA id 807688F4;
        Thu, 10 Aug 2017 13:27:43 -0500 (CDT)
Received: by t430.minyard.net (Postfix, from userid 1000)
        id 0F60D30004C; Thu, 10 Aug 2017 13:27:42 -0500 (CDT)
From:   minyard@acm.org
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     Corey Minyard <cminyard@mvista.com>
Subject: [PATCH 2/4] mips: Make SAVE_SOME more standard
Date:   Thu, 10 Aug 2017 13:27:38 -0500
Message-Id: <1502389660-8969-3-git-send-email-minyard@acm.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1502389660-8969-1-git-send-email-minyard@acm.org>
References: <1502389660-8969-1-git-send-email-minyard@acm.org>
Return-Path: <tcminyard@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59480
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

Modify the SAVE_SOME macro to look more like a standard
function, doing the arithmetic for the frame on the SP
register instead of copying it from K1, and by saving
the stored EPC from the RA.  This lets the get_frame_info()
function process this function like any other.  It also
remove an instruction or two from the kernel entry,
making it more efficient.

unwind_stack_by_address() has special handling for
the top of the interrupt stack, but without this change
unwinding will still fail if you get an interrupt while
handling an interrupt and try to do a traceback from
the second interrupt.

This change modifies the get_saved_sp macro to
optionally store the fetched value right into sp and store the
old SP value into K0.  Then it's just a matter of subtracting
the frame from SP and storing the old SP from K0.

This required changing the DADDI workaround a bit, since K0
holds the SP, we had to use K1 for AT.  But it eliminated
some of the special handling for the DADDI workaround.

Saving the RA register was moved up to before fetching the
CP0_EPC register, so the CP0_EPC register could be stored
into RA and the saved.  This lets the traceback code know
where RA is actually stored.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 arch/mips/include/asm/stackframe.h | 51 +++++++++++++++++++++++++++-----------
 1 file changed, 37 insertions(+), 14 deletions(-)

diff --git a/arch/mips/include/asm/stackframe.h b/arch/mips/include/asm/stackframe.h
index eaa5a4d..d2fb919 100644
--- a/arch/mips/include/asm/stackframe.h
+++ b/arch/mips/include/asm/stackframe.h
@@ -83,8 +83,16 @@
 		LONG_S	$30, PT_R30(sp)
 		.endm
 
+/*
+ * get_saved_sp returns the SP for the current CPU by looking in the
+ * kernelsp array for it.  If tosp is set, it stores the current sp in
+ * k0 and loads the new value in sp.  If not, it clobbers k0 and
+ * stores the new value in k1, leaving sp unaffected.
+ */
 #ifdef CONFIG_SMP
-		.macro	get_saved_sp	/* SMP variation */
+
+		/* SMP variation */
+		.macro	get_saved_sp docfi=0 tosp=0
 		ASM_CPUID_MFC0	k0, ASM_SMP_CPUID_REG
 #if defined(CONFIG_32BIT) || defined(KBUILD_64BIT_SYM32)
 		lui	k1, %hi(kernelsp)
@@ -97,7 +105,15 @@
 #endif
 		LONG_SRL	k0, SMP_CPUID_PTRSHIFT
 		LONG_ADDU	k1, k0
+		.if \tosp
+		move	k0, sp
+		.if \docfi
+		.cfi_register sp, k0
+		.endif
+		LONG_L	sp, %lo(kernelsp)(k1)
+		.else
 		LONG_L	k1, %lo(kernelsp)(k1)
+		.endif
 		.endm
 
 		.macro	set_saved_sp stackp temp temp2
@@ -106,7 +122,8 @@
 		LONG_S	\stackp, kernelsp(\temp)
 		.endm
 #else /* !CONFIG_SMP */
-		.macro	get_saved_sp	/* Uniprocessor variation */
+		/* Uniprocessor variation */
+		.macro	get_saved_sp docfi=0 tosp=0
 #ifdef CONFIG_CPU_JUMP_WORKAROUNDS
 		/*
 		 * Clear BTB (branch target buffer), forbid RAS (return address
@@ -135,7 +152,15 @@
 		daddiu	k1, %hi(kernelsp)
 		dsll	k1, k1, 16
 #endif
+		.if \tosp
+		move	k0, sp
+		.if \docfi
+		.cfi_register sp, k0
+		.endif
+		LONG_L	sp, %lo(kernelsp)(k1)
+		.else
 		LONG_L	k1, %lo(kernelsp)(k1)
+		.endif
 		.endm
 
 		.macro	set_saved_sp stackp temp temp2
@@ -151,7 +176,6 @@
 		sll	k0, 3		/* extract cu0 bit */
 		.set	noreorder
 		bltz	k0, 8f
-		 move	k1, sp
 #ifdef CONFIG_EVA
 		/*
 		 * Flush interAptiv's Return Prediction Stack (RPS) by writing
@@ -178,17 +202,16 @@
 		MTC0	k0, CP0_ENTRYHI
 #endif
 		.set	reorder
+		 move	k0, sp
 		/* Called from user mode, new stack. */
 		get_saved_sp
-#ifndef CONFIG_CPU_DADDI_WORKAROUNDS
-8:		move	k0, sp
-		PTR_SUBU sp, k1, PT_SIZE
-#else
-		.set	at=k0
-8:		PTR_SUBU k1, PT_SIZE
+8:
+#ifdef CONFIG_CPU_DADDI_WORKAROUNDS
+		.set	at=k1
+#endif
+		PTR_SUBU sp, PT_SIZE
+#ifdef CONFIG_CPU_DADDI_WORKAROUNDS
 		.set	noat
-		move	k0, sp
-		move	sp, k1
 #endif
 		LONG_S	k0, PT_R29(sp)
 		LONG_S	$3, PT_R3(sp)
@@ -206,16 +229,16 @@
 		LONG_S	$5, PT_R5(sp)
 		LONG_S	v1, PT_CAUSE(sp)
 		LONG_S	$6, PT_R6(sp)
-		MFC0	v1, CP0_EPC
+		LONG_S	ra, PT_R31(sp)
+		MFC0	ra, CP0_EPC
 		LONG_S	$7, PT_R7(sp)
 #ifdef CONFIG_64BIT
 		LONG_S	$8, PT_R8(sp)
 		LONG_S	$9, PT_R9(sp)
 #endif
-		LONG_S	v1, PT_EPC(sp)
+		LONG_S	ra, PT_EPC(sp)
 		LONG_S	$25, PT_R25(sp)
 		LONG_S	$28, PT_R28(sp)
-		LONG_S	$31, PT_R31(sp)
 
 		/* Set thread_info if we're coming from user mode */
 		mfc0	k0, CP0_STATUS
-- 
2.7.4
