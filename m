Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jun 2013 13:02:30 +0200 (CEST)
Received: from mail-ie0-f178.google.com ([209.85.223.178]:55944 "EHLO
        mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835130Ab3FGXDyeasL3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 8 Jun 2013 01:03:54 +0200
Received: by mail-ie0-f178.google.com with SMTP id at1so8072706iec.37
        for <multiple recipients>; Fri, 07 Jun 2013 16:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=F0b5IBHU2Dijs04+it2448hEcQwE6u6ivoUw61DR2dc=;
        b=EjYKNwjPcX+C9YTQkrH69zB1m08SK8NpPWKyTNb+YRFAX0scmtN2RLslPfJSbFZmhP
         x9LUco9wC72moGd6CYTZl+B2bh637o2eCmxMuKthpKB89hel+7u4ORrxOkK3lSeS/xKI
         k584oUdUhmava0tOizY1kR0LbvvZRRaOR1oLPEybzMdEapSGZCBNrfH1405Srd7MDZHG
         I8/r7ypY2d+jz1ne5hw98pO27hm7dhSrJVDz/QRWZUPr2yKT8jeb0GV8+B++QuZ7v+94
         AYZAbIPBP+enagqajKsd9dI3LzsWi5ZX7IIJBevrdmTwTpSHcl8mOxj1sDfu4mvM5IPc
         sG2g==
X-Received: by 10.43.146.3 with SMTP id jw3mr334053icc.39.1370646228217;
        Fri, 07 Jun 2013 16:03:48 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id e9sm145441igl.9.2013.06.07.16.03.46
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 07 Jun 2013 16:03:47 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r57N3jJJ006642;
        Fri, 7 Jun 2013 16:03:45 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r57N3jFl006641;
        Fri, 7 Jun 2013 16:03:45 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, Sanjay Lal <sanjayl@kymasys.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 08/31] mips/kvm: Fix code formatting in arch/mips/kvm/kvm_locore.S
Date:   Fri,  7 Jun 2013 16:03:12 -0700
Message-Id: <1370646215-6543-9-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
References: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36794
X-Approved-By: ralf@linux-mips.org
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

It was a completely inconsistent mix of spaces and tabs.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/kvm/kvm_locore.S | 921 +++++++++++++++++++++++----------------------
 1 file changed, 464 insertions(+), 457 deletions(-)

diff --git a/arch/mips/kvm/kvm_locore.S b/arch/mips/kvm/kvm_locore.S
index 7a33ee7..7c2933a 100644
--- a/arch/mips/kvm/kvm_locore.S
+++ b/arch/mips/kvm/kvm_locore.S
@@ -1,13 +1,13 @@
 /*
-* This file is subject to the terms and conditions of the GNU General Public
-* License.  See the file "COPYING" in the main directory of this archive
-* for more details.
-*
-* Main entry point for the guest, exception handling.
-*
-* Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
-* Authors: Sanjay Lal <sanjayl@kymasys.com>
-*/
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Main entry point for the guest, exception handling.
+ *
+ * Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
+ * Authors: Sanjay Lal <sanjayl@kymasys.com>
+ */
 
 #include <asm/asm.h>
 #include <asm/asmmacro.h>
@@ -57,172 +57,177 @@
  */
 
 FEXPORT(__kvm_mips_vcpu_run)
-    .set    push
-    .set    noreorder
-    .set    noat
-
-    /* k0/k1 not being used in host kernel context */
-	addiu  		k1,sp, -PT_SIZE
-    LONG_S	    $0, PT_R0(k1)
-    LONG_S     	$1, PT_R1(k1)
-    LONG_S     	$2, PT_R2(k1)
-    LONG_S     	$3, PT_R3(k1)
-
-    LONG_S     	$4, PT_R4(k1)
-    LONG_S     	$5, PT_R5(k1)
-    LONG_S     	$6, PT_R6(k1)
-    LONG_S     	$7, PT_R7(k1)
-
-    LONG_S     	$8,  PT_R8(k1)
-    LONG_S     	$9,  PT_R9(k1)
-    LONG_S     	$10, PT_R10(k1)
-    LONG_S     	$11, PT_R11(k1)
-    LONG_S     	$12, PT_R12(k1)
-    LONG_S     	$13, PT_R13(k1)
-    LONG_S     	$14, PT_R14(k1)
-    LONG_S     	$15, PT_R15(k1)
-    LONG_S     	$16, PT_R16(k1)
-    LONG_S     	$17, PT_R17(k1)
-
-    LONG_S     	$18, PT_R18(k1)
-    LONG_S     	$19, PT_R19(k1)
-    LONG_S     	$20, PT_R20(k1)
-    LONG_S     	$21, PT_R21(k1)
-    LONG_S     	$22, PT_R22(k1)
-    LONG_S     	$23, PT_R23(k1)
-    LONG_S     	$24, PT_R24(k1)
-    LONG_S     	$25, PT_R25(k1)
+	.set	push
+	.set	noreorder
+	.set	noat
+
+	/* k0/k1 not being used in host kernel context */
+	addiu	k1, sp, -PT_SIZE
+	LONG_S	$0, PT_R0(k1)
+	LONG_S	$1, PT_R1(k1)
+	LONG_S	$2, PT_R2(k1)
+	LONG_S	$3, PT_R3(k1)
+
+	LONG_S	$4, PT_R4(k1)
+	LONG_S	$5, PT_R5(k1)
+	LONG_S	$6, PT_R6(k1)
+	LONG_S	$7, PT_R7(k1)
+
+	LONG_S	$8,  PT_R8(k1)
+	LONG_S	$9,  PT_R9(k1)
+	LONG_S	$10, PT_R10(k1)
+	LONG_S	$11, PT_R11(k1)
+	LONG_S	$12, PT_R12(k1)
+	LONG_S	$13, PT_R13(k1)
+	LONG_S	$14, PT_R14(k1)
+	LONG_S	$15, PT_R15(k1)
+	LONG_S	$16, PT_R16(k1)
+	LONG_S	$17, PT_R17(k1)
+
+	LONG_S	$18, PT_R18(k1)
+	LONG_S	$19, PT_R19(k1)
+	LONG_S	$20, PT_R20(k1)
+	LONG_S	$21, PT_R21(k1)
+	LONG_S	$22, PT_R22(k1)
+	LONG_S	$23, PT_R23(k1)
+	LONG_S	$24, PT_R24(k1)
+	LONG_S	$25, PT_R25(k1)
 
 	/* XXXKYMA k0/k1 not saved, not being used if we got here through an ioctl() */
 
-    LONG_S     	$28, PT_R28(k1)
-    LONG_S     	$29, PT_R29(k1)
-    LONG_S     	$30, PT_R30(k1)
-    LONG_S     	$31, PT_R31(k1)
+	LONG_S	$28, PT_R28(k1)
+	LONG_S	$29, PT_R29(k1)
+	LONG_S	$30, PT_R30(k1)
+	LONG_S	$31, PT_R31(k1)
 
-    /* Save hi/lo */
-	mflo		v0
-	LONG_S		v0, PT_LO(k1)
-	mfhi   		v1
-	LONG_S		v1, PT_HI(k1)
+	/* Save hi/lo */
+	mflo	v0
+	LONG_S	v0, PT_LO(k1)
+	mfhi	v1
+	LONG_S	v1, PT_HI(k1)
 
 	/* Save host status */
-	mfc0		v0, CP0_STATUS
-	LONG_S		v0, PT_STATUS(k1)
+	mfc0	v0, CP0_STATUS
+	LONG_S	v0, PT_STATUS(k1)
 
 	/* Save host ASID, shove it into the BVADDR location */
-	mfc0 		v1,CP0_ENTRYHI
-	andi		v1, 0xff
-	LONG_S		v1, PT_HOST_ASID(k1)
+	mfc0	v1, CP0_ENTRYHI
+	andi	v1, 0xff
+	LONG_S	v1, PT_HOST_ASID(k1)
 
-    /* Save DDATA_LO, will be used to store pointer to vcpu */
-    mfc0        v1, CP0_DDATA_LO
-    LONG_S      v1, PT_HOST_USERLOCAL(k1)
+	/* Save DDATA_LO, will be used to store pointer to vcpu */
+	mfc0	v1, CP0_DDATA_LO
+	LONG_S	v1, PT_HOST_USERLOCAL(k1)
 
-    /* DDATA_LO has pointer to vcpu */
-    mtc0        a1,CP0_DDATA_LO
+	/* DDATA_LO has pointer to vcpu */
+	mtc0	a1, CP0_DDATA_LO
 
-    /* Offset into vcpu->arch */
-	addiu		k1, a1, VCPU_HOST_ARCH
+	/* Offset into vcpu->arch */
+	addiu	k1, a1, VCPU_HOST_ARCH
 
-    /* Save the host stack to VCPU, used for exception processing when we exit from the Guest */
-    LONG_S      sp, VCPU_HOST_STACK(k1)
+	/*
+	 * Save the host stack to VCPU, used for exception processing
+	 * when we exit from the Guest
+	 */
+	LONG_S	sp, VCPU_HOST_STACK(k1)
 
-    /* Save the kernel gp as well */
-    LONG_S      gp, VCPU_HOST_GP(k1)
+	/* Save the kernel gp as well */
+	LONG_S	gp, VCPU_HOST_GP(k1)
 
 	/* Setup status register for running the guest in UM, interrupts are disabled */
-	li			k0,(ST0_EXL | KSU_USER| ST0_BEV)
-	mtc0		k0,CP0_STATUS
-    ehb
-
-    /* load up the new EBASE */
-    LONG_L      k0, VCPU_GUEST_EBASE(k1)
-    mtc0        k0,CP0_EBASE
-
-    /* Now that the new EBASE has been loaded, unset BEV, set interrupt mask as it was
-     * but make sure that timer interrupts are enabled
-     */
-    li          k0,(ST0_EXL | KSU_USER | ST0_IE)
-    andi        v0, v0, ST0_IM
-    or          k0, k0, v0
-    mtc0        k0,CP0_STATUS
-    ehb
+	li	k0, (ST0_EXL | KSU_USER| ST0_BEV)
+	mtc0	k0, CP0_STATUS
+	ehb
+
+	/* load up the new EBASE */
+	LONG_L	k0, VCPU_GUEST_EBASE(k1)
+	mtc0	k0, CP0_EBASE
+
+	/*
+	 * Now that the new EBASE has been loaded, unset BEV, set
+	 * interrupt mask as it was but make sure that timer interrupts
+	 * are enabled
+	 */
+	li	k0, (ST0_EXL | KSU_USER | ST0_IE)
+	andi	v0, v0, ST0_IM
+	or	k0, k0, v0
+	mtc0	k0, CP0_STATUS
+	ehb
 
 
 	/* Set Guest EPC */
-	LONG_L		t0, KVM_VCPU_ARCH_EPC(k1)
-	mtc0		t0, CP0_EPC
+	LONG_L	t0, KVM_VCPU_ARCH_EPC(k1)
+	mtc0	t0, CP0_EPC
 
 FEXPORT(__kvm_mips_load_asid)
-    /* Set the ASID for the Guest Kernel */
-    sll         t0, t0, 1                       /* with kseg0 @ 0x40000000, kernel */
-                                                /* addresses shift to 0x80000000 */
-    bltz        t0, 1f                          /* If kernel */
-	addiu       t1, k1, VCPU_GUEST_KERNEL_ASID  /* (BD)  */
-    addiu       t1, k1, VCPU_GUEST_USER_ASID    /* else user */
+	/* Set the ASID for the Guest Kernel */
+	sll	t0, t0, 1	/* with kseg0 @ 0x40000000, kernel */
+			        /* addresses shift to 0x80000000 */
+	bltz	t0, 1f		/* If kernel */
+	 addiu	t1, k1, VCPU_GUEST_KERNEL_ASID  /* (BD)  */
+	addiu	t1, k1, VCPU_GUEST_USER_ASID    /* else user */
 1:
-    /* t1: contains the base of the ASID array, need to get the cpu id  */
-    LONG_L      t2, TI_CPU($28)             /* smp_processor_id */
-    sll         t2, t2, 2                   /* x4 */
-    addu        t3, t1, t2
-    LONG_L      k0, (t3)
-    andi        k0, k0, 0xff
-	mtc0		k0,CP0_ENTRYHI
-    ehb
-
-    /* Disable RDHWR access */
-    mtc0    zero,  CP0_HWRENA
-
-    /* Now load up the Guest Context from VCPU */
-    LONG_L     	$1, KVM_VCPU_ARCH_R1(k1)
-    LONG_L     	$2, KVM_VCPU_ARCH_R2(k1)
-    LONG_L     	$3, KVM_VCPU_ARCH_R3(k1)
-
-    LONG_L     	$4, KVM_VCPU_ARCH_R4(k1)
-    LONG_L     	$5, KVM_VCPU_ARCH_R5(k1)
-    LONG_L     	$6, KVM_VCPU_ARCH_R6(k1)
-    LONG_L     	$7, KVM_VCPU_ARCH_R7(k1)
-
-    LONG_L     	$8,  KVM_VCPU_ARCH_R8(k1)
-    LONG_L     	$9,  KVM_VCPU_ARCH_R9(k1)
-    LONG_L     	$10, KVM_VCPU_ARCH_R10(k1)
-    LONG_L     	$11, KVM_VCPU_ARCH_R11(k1)
-    LONG_L     	$12, KVM_VCPU_ARCH_R12(k1)
-    LONG_L     	$13, KVM_VCPU_ARCH_R13(k1)
-    LONG_L     	$14, KVM_VCPU_ARCH_R14(k1)
-    LONG_L     	$15, KVM_VCPU_ARCH_R15(k1)
-    LONG_L     	$16, KVM_VCPU_ARCH_R16(k1)
-    LONG_L     	$17, KVM_VCPU_ARCH_R17(k1)
-    LONG_L     	$18, KVM_VCPU_ARCH_R18(k1)
-    LONG_L     	$19, KVM_VCPU_ARCH_R19(k1)
-    LONG_L     	$20, KVM_VCPU_ARCH_R20(k1)
-    LONG_L     	$21, KVM_VCPU_ARCH_R21(k1)
-    LONG_L     	$22, KVM_VCPU_ARCH_R22(k1)
-    LONG_L     	$23, KVM_VCPU_ARCH_R23(k1)
-    LONG_L     	$24, KVM_VCPU_ARCH_R24(k1)
-    LONG_L     	$25, KVM_VCPU_ARCH_R25(k1)
-
-    /* k0/k1 loaded up later */
-
-    LONG_L     	$28, KVM_VCPU_ARCH_R28(k1)
-    LONG_L     	$29, KVM_VCPU_ARCH_R29(k1)
-    LONG_L     	$30, KVM_VCPU_ARCH_R30(k1)
-    LONG_L     	$31, KVM_VCPU_ARCH_R31(k1)
-
-    /* Restore hi/lo */
-	LONG_L		k0, KVM_VCPU_ARCH_LO(k1)
-	mtlo		k0
-
-	LONG_L		k0, KVM_VCPU_ARCH_HI(k1)
-	mthi   		k0
+	     /* t1: contains the base of the ASID array, need to get the cpu id  */
+	LONG_L	t2, TI_CPU($28)             /* smp_processor_id */
+	sll	t2, t2, 2                   /* x4 */
+	addu	t3, t1, t2
+	LONG_L	k0, (t3)
+	andi	k0, k0, 0xff
+	mtc0	k0, CP0_ENTRYHI
+	ehb
+
+	/* Disable RDHWR access */
+	mtc0	zero, CP0_HWRENA
+
+	/* Now load up the Guest Context from VCPU */
+	LONG_L	$1, KVM_VCPU_ARCH_R1(k1)
+	LONG_L	$2, KVM_VCPU_ARCH_R2(k1)
+	LONG_L	$3, KVM_VCPU_ARCH_R3(k1)
+
+	LONG_L	$4, KVM_VCPU_ARCH_R4(k1)
+	LONG_L	$5, KVM_VCPU_ARCH_R5(k1)
+	LONG_L	$6, KVM_VCPU_ARCH_R6(k1)
+	LONG_L	$7, KVM_VCPU_ARCH_R7(k1)
+
+	LONG_L	$8, KVM_VCPU_ARCH_R8(k1)
+	LONG_L	$9, KVM_VCPU_ARCH_R9(k1)
+	LONG_L	$10, KVM_VCPU_ARCH_R10(k1)
+	LONG_L	$11, KVM_VCPU_ARCH_R11(k1)
+	LONG_L	$12, KVM_VCPU_ARCH_R12(k1)
+	LONG_L	$13, KVM_VCPU_ARCH_R13(k1)
+	LONG_L	$14, KVM_VCPU_ARCH_R14(k1)
+	LONG_L	$15, KVM_VCPU_ARCH_R15(k1)
+	LONG_L	$16, KVM_VCPU_ARCH_R16(k1)
+	LONG_L	$17, KVM_VCPU_ARCH_R17(k1)
+	LONG_L	$18, KVM_VCPU_ARCH_R18(k1)
+	LONG_L	$19, KVM_VCPU_ARCH_R19(k1)
+	LONG_L	$20, KVM_VCPU_ARCH_R20(k1)
+	LONG_L	$21, KVM_VCPU_ARCH_R21(k1)
+	LONG_L	$22, KVM_VCPU_ARCH_R22(k1)
+	LONG_L	$23, KVM_VCPU_ARCH_R23(k1)
+	LONG_L	$24, KVM_VCPU_ARCH_R24(k1)
+	LONG_L	$25, KVM_VCPU_ARCH_R25(k1)
+
+	/* k0/k1 loaded up later */
+
+	LONG_L	$28, KVM_VCPU_ARCH_R28(k1)
+	LONG_L	$29, KVM_VCPU_ARCH_R29(k1)
+	LONG_L	$30, KVM_VCPU_ARCH_R30(k1)
+	LONG_L	$31, KVM_VCPU_ARCH_R31(k1)
+
+	/* Restore hi/lo */
+	LONG_L	k0, KVM_VCPU_ARCH_LO(k1)
+	mtlo	k0
+
+	LONG_L	k0, KVM_VCPU_ARCH_HI(k1)
+	mthi	k0
 
 FEXPORT(__kvm_mips_load_k0k1)
 	/* Restore the guest's k0/k1 registers */
-    LONG_L     	k0, KVM_VCPU_ARCH_R26(k1)
-    LONG_L     	k1, KVM_VCPU_ARCH_R27(k1)
+	LONG_L	k0, KVM_VCPU_ARCH_R26(k1)
+	LONG_L	k1, KVM_VCPU_ARCH_R27(k1)
 
-    /* Jump to guest */
+	/* Jump to guest */
 	eret
 	.set	pop
 
@@ -230,19 +235,19 @@ VECTOR(MIPSX(exception), unknown)
 /*
  * Find out what mode we came from and jump to the proper handler.
  */
-    .set    push
+	.set	push
 	.set	noat
-    .set    noreorder
-    mtc0    k0, CP0_ERROREPC    #01: Save guest k0
-    ehb                         #02:
-
-    mfc0    k0, CP0_EBASE       #02: Get EBASE
-    srl     k0, k0, 10          #03: Get rid of CPUNum
-    sll     k0, k0, 10          #04
-    LONG_S  k1, 0x3000(k0)      #05: Save k1 @ offset 0x3000
-    addiu   k0, k0, 0x2000      #06: Exception handler is installed @ offset 0x2000
-	j	k0				        #07: jump to the function
-	nop				        	#08: branch delay slot
+	.set	noreorder
+	mtc0	k0, CP0_ERROREPC	#01: Save guest k0
+	ehb				#02:
+
+	mfc0	k0, CP0_EBASE		#02: Get EBASE
+	srl	k0, k0, 10		#03: Get rid of CPUNum
+	sll	k0, k0, 10		#04
+	LONG_S	k1, 0x3000(k0)		#05: Save k1 @ offset 0x3000
+	addiu	k0, k0, 0x2000		#06: Exception handler is installed @ offset 0x2000
+	j	k0			#07: jump to the function
+	 nop				#08: branch delay slot
 	.set	push
 VECTOR_END(MIPSX(exceptionEnd))
 .end MIPSX(exception)
@@ -253,327 +258,330 @@ VECTOR_END(MIPSX(exceptionEnd))
  *
  */
 NESTED (MIPSX(GuestException), CALLFRAME_SIZ, ra)
-    .set    push
-    .set    noat
-    .set    noreorder
-
-    /* Get the VCPU pointer from DDTATA_LO */
-    mfc0        k1, CP0_DDATA_LO
-	addiu		k1, k1, VCPU_HOST_ARCH
-
-    /* Start saving Guest context to VCPU */
-    LONG_S  $0, KVM_VCPU_ARCH_R0(k1)
-    LONG_S  $1, KVM_VCPU_ARCH_R1(k1)
-    LONG_S  $2, KVM_VCPU_ARCH_R2(k1)
-    LONG_S  $3, KVM_VCPU_ARCH_R3(k1)
-    LONG_S  $4, KVM_VCPU_ARCH_R4(k1)
-    LONG_S  $5, KVM_VCPU_ARCH_R5(k1)
-    LONG_S  $6, KVM_VCPU_ARCH_R6(k1)
-    LONG_S  $7, KVM_VCPU_ARCH_R7(k1)
-    LONG_S  $8, KVM_VCPU_ARCH_R8(k1)
-    LONG_S  $9, KVM_VCPU_ARCH_R9(k1)
-    LONG_S  $10, KVM_VCPU_ARCH_R10(k1)
-    LONG_S  $11, KVM_VCPU_ARCH_R11(k1)
-    LONG_S  $12, KVM_VCPU_ARCH_R12(k1)
-    LONG_S  $13, KVM_VCPU_ARCH_R13(k1)
-    LONG_S  $14, KVM_VCPU_ARCH_R14(k1)
-    LONG_S  $15, KVM_VCPU_ARCH_R15(k1)
-    LONG_S  $16, KVM_VCPU_ARCH_R16(k1)
-    LONG_S  $17, KVM_VCPU_ARCH_R17(k1)
-    LONG_S  $18, KVM_VCPU_ARCH_R18(k1)
-    LONG_S  $19, KVM_VCPU_ARCH_R19(k1)
-    LONG_S  $20, KVM_VCPU_ARCH_R20(k1)
-    LONG_S  $21, KVM_VCPU_ARCH_R21(k1)
-    LONG_S  $22, KVM_VCPU_ARCH_R22(k1)
-    LONG_S  $23, KVM_VCPU_ARCH_R23(k1)
-    LONG_S  $24, KVM_VCPU_ARCH_R24(k1)
-    LONG_S  $25, KVM_VCPU_ARCH_R25(k1)
-
-    /* Guest k0/k1 saved later */
-
-    LONG_S  $28, KVM_VCPU_ARCH_R28(k1)
-    LONG_S  $29, KVM_VCPU_ARCH_R29(k1)
-    LONG_S  $30, KVM_VCPU_ARCH_R30(k1)
-    LONG_S  $31, KVM_VCPU_ARCH_R31(k1)
-
-    /* We need to save hi/lo and restore them on
-     * the way out
-     */
-    mfhi    t0
-    LONG_S  t0, KVM_VCPU_ARCH_HI(k1)
-
-    mflo    t0
-    LONG_S  t0, KVM_VCPU_ARCH_LO(k1)
-
-    /* Finally save guest k0/k1 to VCPU */
-    mfc0    t0, CP0_ERROREPC
-    LONG_S  t0, KVM_VCPU_ARCH_R26(k1)
-
-    /* Get GUEST k1 and save it in VCPU */
+	.set	push
+	.set	noat
+	.set	noreorder
+
+	/* Get the VCPU pointer from DDTATA_LO */
+	mfc0	k1, CP0_DDATA_LO
+	addiu	k1, k1, VCPU_HOST_ARCH
+
+	/* Start saving Guest context to VCPU */
+	LONG_S	$0, KVM_VCPU_ARCH_R0(k1)
+	LONG_S	$1, KVM_VCPU_ARCH_R1(k1)
+	LONG_S	$2, KVM_VCPU_ARCH_R2(k1)
+	LONG_S	$3, KVM_VCPU_ARCH_R3(k1)
+	LONG_S	$4, KVM_VCPU_ARCH_R4(k1)
+	LONG_S	$5, KVM_VCPU_ARCH_R5(k1)
+	LONG_S	$6, KVM_VCPU_ARCH_R6(k1)
+	LONG_S	$7, KVM_VCPU_ARCH_R7(k1)
+	LONG_S	$8, KVM_VCPU_ARCH_R8(k1)
+	LONG_S	$9, KVM_VCPU_ARCH_R9(k1)
+	LONG_S	$10, KVM_VCPU_ARCH_R10(k1)
+	LONG_S	$11, KVM_VCPU_ARCH_R11(k1)
+	LONG_S	$12, KVM_VCPU_ARCH_R12(k1)
+	LONG_S	$13, KVM_VCPU_ARCH_R13(k1)
+	LONG_S	$14, KVM_VCPU_ARCH_R14(k1)
+	LONG_S	$15, KVM_VCPU_ARCH_R15(k1)
+	LONG_S	$16, KVM_VCPU_ARCH_R16(k1)
+	LONG_S	$17, KVM_VCPU_ARCH_R17(k1)
+	LONG_S	$18, KVM_VCPU_ARCH_R18(k1)
+	LONG_S	$19, KVM_VCPU_ARCH_R19(k1)
+	LONG_S	$20, KVM_VCPU_ARCH_R20(k1)
+	LONG_S	$21, KVM_VCPU_ARCH_R21(k1)
+	LONG_S	$22, KVM_VCPU_ARCH_R22(k1)
+	LONG_S	$23, KVM_VCPU_ARCH_R23(k1)
+	LONG_S	$24, KVM_VCPU_ARCH_R24(k1)
+	LONG_S	$25, KVM_VCPU_ARCH_R25(k1)
+
+	/* Guest k0/k1 saved later */
+
+	LONG_S	$28, KVM_VCPU_ARCH_R28(k1)
+	LONG_S	$29, KVM_VCPU_ARCH_R29(k1)
+	LONG_S	$30, KVM_VCPU_ARCH_R30(k1)
+	LONG_S	$31, KVM_VCPU_ARCH_R31(k1)
+
+	/* We need to save hi/lo and restore them on
+	 * the way out
+	 */
+	mfhi	t0
+	LONG_S	t0, KVM_VCPU_ARCH_HI(k1)
+
+	mflo	t0
+	LONG_S	t0, KVM_VCPU_ARCH_LO(k1)
+
+	/* Finally save guest k0/k1 to VCPU */
+	mfc0	t0, CP0_ERROREPC
+	LONG_S	t0, KVM_VCPU_ARCH_R26(k1)
+
+	/* Get GUEST k1 and save it in VCPU */
 	PTR_LI	t1, ~0x2ff
-    mfc0    t0, CP0_EBASE
-    and     t0, t0, t1
-    LONG_L  t0, 0x3000(t0)
-    LONG_S  t0, KVM_VCPU_ARCH_R27(k1)
-
-    /* Now that context has been saved, we can use other registers */
+	mfc0	t0, CP0_EBASE
+	and	t0, t0, t1
+	LONG_L	t0, 0x3000(t0)
+	LONG_S	t0, KVM_VCPU_ARCH_R27(k1)
 
-    /* Restore vcpu */
-    mfc0        a1, CP0_DDATA_LO
-    move        s1, a1
+	/* Now that context has been saved, we can use other registers */
 
-   /* Restore run (vcpu->run) */
-    LONG_L      a0, VCPU_RUN(a1)
-    /* Save pointer to run in s0, will be saved by the compiler */
-    move        s0, a0
+	/* Restore vcpu */
+	mfc0	a1, CP0_DDATA_LO
+	move	s1, a1
 
+	/* Restore run (vcpu->run) */
+	LONG_L	a0, VCPU_RUN(a1)
+	/* Save pointer to run in s0, will be saved by the compiler */
+	move	s0, a0
 
-    /* Save Host level EPC, BadVaddr and Cause to VCPU, useful to process the exception */
-    mfc0    k0,CP0_EPC
-    LONG_S  k0, KVM_VCPU_ARCH_EPC(k1)
+	/* Save Host level EPC, BadVaddr and Cause to VCPU, useful to
+	 * process the exception */
+	mfc0	k0,CP0_EPC
+	LONG_S	k0, KVM_VCPU_ARCH_EPC(k1)
 
-    mfc0    k0, CP0_BADVADDR
-    LONG_S  k0, VCPU_HOST_CP0_BADVADDR(k1)
+	mfc0	k0, CP0_BADVADDR
+	LONG_S	k0, VCPU_HOST_CP0_BADVADDR(k1)
 
-    mfc0    k0, CP0_CAUSE
-    LONG_S  k0, VCPU_HOST_CP0_CAUSE(k1)
+	mfc0	k0, CP0_CAUSE
+	LONG_S	k0, VCPU_HOST_CP0_CAUSE(k1)
 
-    mfc0    k0, CP0_ENTRYHI
-    LONG_S  k0, VCPU_HOST_ENTRYHI(k1)
+	mfc0	k0, CP0_ENTRYHI
+	LONG_S	k0, VCPU_HOST_ENTRYHI(k1)
 
-    /* Now restore the host state just enough to run the handlers */
+	/* Now restore the host state just enough to run the handlers */
 
-    /* Swtich EBASE to the one used by Linux */
-    /* load up the host EBASE */
-    mfc0        v0, CP0_STATUS
+	/* Swtich EBASE to the one used by Linux */
+	/* load up the host EBASE */
+	mfc0	v0, CP0_STATUS
 
-    .set at
-	or          k0, v0, ST0_BEV
-    .set noat
+	.set	at
+	or	k0, v0, ST0_BEV
+	.set	noat
 
-    mtc0        k0, CP0_STATUS
-    ehb
+	mtc0	k0, CP0_STATUS
+	ehb
 
-    LONG_L      k0, VCPU_HOST_EBASE(k1)
-    mtc0        k0,CP0_EBASE
+	LONG_L	k0, VCPU_HOST_EBASE(k1)
+	mtc0	k0,CP0_EBASE
 
 
-    /* Now that the new EBASE has been loaded, unset BEV and KSU_USER */
-    .set at
-	and         v0, v0, ~(ST0_EXL | KSU_USER | ST0_IE)
-    or          v0, v0, ST0_CU0
-    .set noat
-    mtc0        v0, CP0_STATUS
-    ehb
+	/* Now that the new EBASE has been loaded, unset BEV and KSU_USER */
+	.set	at
+	and	v0, v0, ~(ST0_EXL | KSU_USER | ST0_IE)
+	or	v0, v0, ST0_CU0
+	.set	noat
+	mtc0	v0, CP0_STATUS
+	ehb
 
-    /* Load up host GP */
-    LONG_L  gp, VCPU_HOST_GP(k1)
+	/* Load up host GP */
+	LONG_L	gp, VCPU_HOST_GP(k1)
 
-    /* Need a stack before we can jump to "C" */
-    LONG_L  sp, VCPU_HOST_STACK(k1)
+	/* Need a stack before we can jump to "C" */
+	LONG_L	sp, VCPU_HOST_STACK(k1)
 
-    /* Saved host state */
-    addiu   sp,sp, -PT_SIZE
+	/* Saved host state */
+	addiu	sp,sp, -PT_SIZE
 
-    /* XXXKYMA do we need to load the host ASID, maybe not because the
-     * kernel entries are marked GLOBAL, need to verify
-     */
+	/* XXXKYMA do we need to load the host ASID, maybe not because the
+	 * kernel entries are marked GLOBAL, need to verify
+	 */
 
-    /* Restore host DDATA_LO */
-    LONG_L      k0, PT_HOST_USERLOCAL(sp)
-    mtc0        k0, CP0_DDATA_LO
+	/* Restore host DDATA_LO */
+	LONG_L	k0, PT_HOST_USERLOCAL(sp)
+	mtc0	k0, CP0_DDATA_LO
 
-    /* Restore RDHWR access */
+	/* Restore RDHWR access */
 	PTR_LI	k0, 0x2000000F
-    mtc0    k0,  CP0_HWRENA
+	mtc0	k0, CP0_HWRENA
 
-    /* Jump to handler */
+	/* Jump to handler */
 FEXPORT(__kvm_mips_jump_to_handler)
-    /* XXXKYMA: not sure if this is safe, how large is the stack?? */
-    /* Now jump to the kvm_mips_handle_exit() to see if we can deal with this in the kernel */
+	/* XXXKYMA: not sure if this is safe, how large is the stack??
+	 * Now jump to the kvm_mips_handle_exit() to see if we can deal
+	 * with this in the kernel */
 	PTR_LA	t9, kvm_mips_handle_exit
-    jalr.hb     t9
-    addiu       sp,sp, -CALLFRAME_SIZ           /* BD Slot */
-
-    /* Return from handler Make sure interrupts are disabled */
-    di
-    ehb
-
-    /* XXXKYMA: k0/k1 could have been blown away if we processed an exception
-     * while we were handling the exception from the guest, reload k1
-     */
-    move        k1, s1
-	addiu		k1, k1, VCPU_HOST_ARCH
-
-    /* Check return value, should tell us if we are returning to the host (handle I/O etc)
-     * or resuming the guest
-     */
-    andi        t0, v0, RESUME_HOST
-    bnez        t0, __kvm_mips_return_to_host
-    nop
+	jalr.hb	t9
+	 addiu	sp,sp, -CALLFRAME_SIZ           /* BD Slot */
+
+	/* Return from handler Make sure interrupts are disabled */
+	di
+	ehb
+
+	/* XXXKYMA: k0/k1 could have been blown away if we processed
+	 * an exception while we were handling the exception from the
+	 * guest, reload k1
+	 */
+
+	move	k1, s1
+	addiu	k1, k1, VCPU_HOST_ARCH
+
+	/* Check return value, should tell us if we are returning to the
+	 * host (handle I/O etc)or resuming the guest
+	 */
+	andi	t0, v0, RESUME_HOST
+	bnez	t0, __kvm_mips_return_to_host
+	 nop
 
 __kvm_mips_return_to_guest:
-    /* Put the saved pointer to vcpu (s1) back into the DDATA_LO Register */
-    mtc0        s1, CP0_DDATA_LO
-
-    /* Load up the Guest EBASE to minimize the window where BEV is set */
-    LONG_L      t0, VCPU_GUEST_EBASE(k1)
-
-    /* Switch EBASE back to the one used by KVM */
-    mfc0        v1, CP0_STATUS
-    .set at
-	or          k0, v1, ST0_BEV
-    .set noat
-    mtc0        k0, CP0_STATUS
-    ehb
-    mtc0        t0,CP0_EBASE
-
-    /* Setup status register for running guest in UM */
-    .set at
-    or     v1, v1, (ST0_EXL | KSU_USER | ST0_IE)
-    and     v1, v1, ~ST0_CU0
-    .set noat
-    mtc0    v1, CP0_STATUS
-    ehb
+   	 /* Put the saved pointer to vcpu (s1) back into the DDATA_LO Register */
+	mtc0	s1, CP0_DDATA_LO
+
+	/* Load up the Guest EBASE to minimize the window where BEV is set */
+	LONG_L	t0, VCPU_GUEST_EBASE(k1)
 
+	/* Switch EBASE back to the one used by KVM */
+	mfc0	v1, CP0_STATUS
+	.set	at
+	or	k0, v1, ST0_BEV
+	.set	noat
+	mtc0	k0, CP0_STATUS
+	ehb
+	mtc0	t0, CP0_EBASE
+
+	/* Setup status register for running guest in UM */
+	.set	at
+	or	v1, v1, (ST0_EXL | KSU_USER | ST0_IE)
+	and	v1, v1, ~ST0_CU0
+	.set	noat
+	mtc0	v1, CP0_STATUS
+	ehb
 
 	/* Set Guest EPC */
-	LONG_L		t0, KVM_VCPU_ARCH_EPC(k1)
-	mtc0		t0, CP0_EPC
-
-    /* Set the ASID for the Guest Kernel */
-    sll         t0, t0, 1                       /* with kseg0 @ 0x40000000, kernel */
-                                                /* addresses shift to 0x80000000 */
-    bltz        t0, 1f                          /* If kernel */
-	addiu       t1, k1, VCPU_GUEST_KERNEL_ASID  /* (BD)  */
-    addiu       t1, k1, VCPU_GUEST_USER_ASID    /* else user */
+	LONG_L	t0, KVM_VCPU_ARCH_EPC(k1)
+	mtc0	t0, CP0_EPC
+
+	/* Set the ASID for the Guest Kernel */
+	sll	t0, t0, 1	/* with kseg0 @ 0x40000000, kernel */
+				/* addresses shift to 0x80000000 */
+	bltz	t0, 1f		/* If kernel */
+	 addiu	t1, k1, VCPU_GUEST_KERNEL_ASID  /* (BD)  */
+	addiu	t1, k1, VCPU_GUEST_USER_ASID    /* else user */
 1:
-    /* t1: contains the base of the ASID array, need to get the cpu id  */
-    LONG_L      t2, TI_CPU($28)             /* smp_processor_id */
-    sll         t2, t2, 2                   /* x4 */
-    addu        t3, t1, t2
-    LONG_L      k0, (t3)
-    andi        k0, k0, 0xff
-	mtc0		k0,CP0_ENTRYHI
-    ehb
-
-    /* Disable RDHWR access */
-    mtc0    zero,  CP0_HWRENA
+	/* t1: contains the base of the ASID array, need to get the cpu id  */
+	LONG_L	t2, TI_CPU($28)		/* smp_processor_id */
+	sll	t2, t2, 2		/* x4 */
+	addu	t3, t1, t2
+	LONG_L	k0, (t3)
+	andi	k0, k0, 0xff
+	mtc0	k0,CP0_ENTRYHI
+	ehb
+
+	/* Disable RDHWR access */
+	mtc0    zero,  CP0_HWRENA
 
     /* load the guest context from VCPU and return */
-    LONG_L  $0, KVM_VCPU_ARCH_R0(k1)
-    LONG_L  $1, KVM_VCPU_ARCH_R1(k1)
-    LONG_L  $2, KVM_VCPU_ARCH_R2(k1)
-    LONG_L  $3, KVM_VCPU_ARCH_R3(k1)
-    LONG_L  $4, KVM_VCPU_ARCH_R4(k1)
-    LONG_L  $5, KVM_VCPU_ARCH_R5(k1)
-    LONG_L  $6, KVM_VCPU_ARCH_R6(k1)
-    LONG_L  $7, KVM_VCPU_ARCH_R7(k1)
-    LONG_L  $8, KVM_VCPU_ARCH_R8(k1)
-    LONG_L  $9, KVM_VCPU_ARCH_R9(k1)
-    LONG_L  $10, KVM_VCPU_ARCH_R10(k1)
-    LONG_L  $11, KVM_VCPU_ARCH_R11(k1)
-    LONG_L  $12, KVM_VCPU_ARCH_R12(k1)
-    LONG_L  $13, KVM_VCPU_ARCH_R13(k1)
-    LONG_L  $14, KVM_VCPU_ARCH_R14(k1)
-    LONG_L  $15, KVM_VCPU_ARCH_R15(k1)
-    LONG_L  $16, KVM_VCPU_ARCH_R16(k1)
-    LONG_L  $17, KVM_VCPU_ARCH_R17(k1)
-    LONG_L  $18, KVM_VCPU_ARCH_R18(k1)
-    LONG_L  $19, KVM_VCPU_ARCH_R19(k1)
-    LONG_L  $20, KVM_VCPU_ARCH_R20(k1)
-    LONG_L  $21, KVM_VCPU_ARCH_R21(k1)
-    LONG_L  $22, KVM_VCPU_ARCH_R22(k1)
-    LONG_L  $23, KVM_VCPU_ARCH_R23(k1)
-    LONG_L  $24, KVM_VCPU_ARCH_R24(k1)
-    LONG_L  $25, KVM_VCPU_ARCH_R25(k1)
-
-    /* $/k1 loaded later */
-    LONG_L  $28, KVM_VCPU_ARCH_R28(k1)
-    LONG_L  $29, KVM_VCPU_ARCH_R29(k1)
-    LONG_L  $30, KVM_VCPU_ARCH_R30(k1)
-    LONG_L  $31, KVM_VCPU_ARCH_R31(k1)
+	LONG_L	$0, KVM_VCPU_ARCH_R0(k1)
+	LONG_L	$1, KVM_VCPU_ARCH_R1(k1)
+	LONG_L	$2, KVM_VCPU_ARCH_R2(k1)
+	LONG_L	$3, KVM_VCPU_ARCH_R3(k1)
+	LONG_L	$4, KVM_VCPU_ARCH_R4(k1)
+	LONG_L	$5, KVM_VCPU_ARCH_R5(k1)
+	LONG_L	$6, KVM_VCPU_ARCH_R6(k1)
+	LONG_L	$7, KVM_VCPU_ARCH_R7(k1)
+	LONG_L	$8, KVM_VCPU_ARCH_R8(k1)
+	LONG_L	$9, KVM_VCPU_ARCH_R9(k1)
+	LONG_L	$10, KVM_VCPU_ARCH_R10(k1)
+	LONG_L	$11, KVM_VCPU_ARCH_R11(k1)
+	LONG_L	$12, KVM_VCPU_ARCH_R12(k1)
+	LONG_L	$13, KVM_VCPU_ARCH_R13(k1)
+	LONG_L	$14, KVM_VCPU_ARCH_R14(k1)
+	LONG_L	$15, KVM_VCPU_ARCH_R15(k1)
+	LONG_L	$16, KVM_VCPU_ARCH_R16(k1)
+	LONG_L	$17, KVM_VCPU_ARCH_R17(k1)
+	LONG_L	$18, KVM_VCPU_ARCH_R18(k1)
+	LONG_L	$19, KVM_VCPU_ARCH_R19(k1)
+	LONG_L	$20, KVM_VCPU_ARCH_R20(k1)
+	LONG_L	$21, KVM_VCPU_ARCH_R21(k1)
+	LONG_L	$22, KVM_VCPU_ARCH_R22(k1)
+	LONG_L	$23, KVM_VCPU_ARCH_R23(k1)
+	LONG_L	$24, KVM_VCPU_ARCH_R24(k1)
+	LONG_L	$25, KVM_VCPU_ARCH_R25(k1)
+
+	/* $/k1 loaded later */
+	LONG_L	$28, KVM_VCPU_ARCH_R28(k1)
+	LONG_L	$29, KVM_VCPU_ARCH_R29(k1)
+	LONG_L	$30, KVM_VCPU_ARCH_R30(k1)
+	LONG_L	$31, KVM_VCPU_ARCH_R31(k1)
 
 FEXPORT(__kvm_mips_skip_guest_restore)
-    LONG_L  k0, KVM_VCPU_ARCH_HI(k1)
-    mthi    k0
+	LONG_L	k0, KVM_VCPU_ARCH_HI(k1)
+	mthi	k0
 
-    LONG_L  k0, KVM_VCPU_ARCH_LO(k1)
-    mtlo    k0
+	LONG_L	k0, KVM_VCPU_ARCH_LO(k1)
+	mtlo	k0
 
-    LONG_L  k0, KVM_VCPU_ARCH_R26(k1)
-    LONG_L  k1, KVM_VCPU_ARCH_R27(k1)
+	LONG_L	k0, KVM_VCPU_ARCH_R26(k1)
+	LONG_L	k1, KVM_VCPU_ARCH_R27(k1)
 
-    eret
+	eret
 
 __kvm_mips_return_to_host:
-    /* EBASE is already pointing to Linux */
-    LONG_L  k1, VCPU_HOST_STACK(k1)
-	addiu  	k1,k1, -PT_SIZE
-
-    /* Restore host DDATA_LO */
-    LONG_L      k0, PT_HOST_USERLOCAL(k1)
-    mtc0        k0, CP0_DDATA_LO
-
-    /* Restore host ASID */
-    LONG_L      k0, PT_HOST_ASID(sp)
-    andi        k0, 0xff
-    mtc0        k0,CP0_ENTRYHI
-    ehb
-
-    /* Load context saved on the host stack */
-    LONG_L  $0, PT_R0(k1)
-    LONG_L  $1, PT_R1(k1)
-
-    /* r2/v0 is the return code, shift it down by 2 (arithmetic) to recover the err code  */
-    sra     k0, v0, 2
-    move    $2, k0
-
-    LONG_L  $3, PT_R3(k1)
-    LONG_L  $4, PT_R4(k1)
-    LONG_L  $5, PT_R5(k1)
-    LONG_L  $6, PT_R6(k1)
-    LONG_L  $7, PT_R7(k1)
-    LONG_L  $8, PT_R8(k1)
-    LONG_L  $9, PT_R9(k1)
-    LONG_L  $10, PT_R10(k1)
-    LONG_L  $11, PT_R11(k1)
-    LONG_L  $12, PT_R12(k1)
-    LONG_L  $13, PT_R13(k1)
-    LONG_L  $14, PT_R14(k1)
-    LONG_L  $15, PT_R15(k1)
-    LONG_L  $16, PT_R16(k1)
-    LONG_L  $17, PT_R17(k1)
-    LONG_L  $18, PT_R18(k1)
-    LONG_L  $19, PT_R19(k1)
-    LONG_L  $20, PT_R20(k1)
-    LONG_L  $21, PT_R21(k1)
-    LONG_L  $22, PT_R22(k1)
-    LONG_L  $23, PT_R23(k1)
-    LONG_L  $24, PT_R24(k1)
-    LONG_L  $25, PT_R25(k1)
-
-    /* Host k0/k1 were not saved */
-
-    LONG_L  $28, PT_R28(k1)
-    LONG_L  $29, PT_R29(k1)
-    LONG_L  $30, PT_R30(k1)
-
-    LONG_L  k0, PT_HI(k1)
-    mthi    k0
-
-    LONG_L  k0, PT_LO(k1)
-    mtlo    k0
-
-    /* Restore RDHWR access */
+	/* EBASE is already pointing to Linux */
+	LONG_L	k1, VCPU_HOST_STACK(k1)
+	addiu	k1,k1, -PT_SIZE
+
+	/* Restore host DDATA_LO */
+	LONG_L	k0, PT_HOST_USERLOCAL(k1)
+	mtc0	k0, CP0_DDATA_LO
+
+	/* Restore host ASID */
+	LONG_L	k0, PT_HOST_ASID(sp)
+	andi	k0, 0xff
+	mtc0	k0,CP0_ENTRYHI
+	ehb
+
+	/* Load context saved on the host stack */
+	LONG_L	$0, PT_R0(k1)
+	LONG_L	$1, PT_R1(k1)
+
+	/* r2/v0 is the return code, shift it down by 2 (arithmetic)
+	 * to recover the err code  */
+	sra	k0, v0, 2
+	move	$2, k0
+
+	LONG_L	$3, PT_R3(k1)
+	LONG_L	$4, PT_R4(k1)
+	LONG_L	$5, PT_R5(k1)
+	LONG_L	$6, PT_R6(k1)
+	LONG_L	$7, PT_R7(k1)
+	LONG_L	$8, PT_R8(k1)
+	LONG_L	$9, PT_R9(k1)
+	LONG_L	$10, PT_R10(k1)
+	LONG_L	$11, PT_R11(k1)
+	LONG_L	$12, PT_R12(k1)
+	LONG_L	$13, PT_R13(k1)
+	LONG_L	$14, PT_R14(k1)
+	LONG_L	$15, PT_R15(k1)
+	LONG_L	$16, PT_R16(k1)
+	LONG_L	$17, PT_R17(k1)
+	LONG_L	$18, PT_R18(k1)
+	LONG_L	$19, PT_R19(k1)
+	LONG_L	$20, PT_R20(k1)
+	LONG_L	$21, PT_R21(k1)
+	LONG_L	$22, PT_R22(k1)
+	LONG_L	$23, PT_R23(k1)
+	LONG_L	$24, PT_R24(k1)
+	LONG_L	$25, PT_R25(k1)
+
+	/* Host k0/k1 were not saved */
+
+	LONG_L	$28, PT_R28(k1)
+	LONG_L	$29, PT_R29(k1)
+	LONG_L	$30, PT_R30(k1)
+
+	LONG_L	k0, PT_HI(k1)
+	mthi	k0
+
+	LONG_L	k0, PT_LO(k1)
+	mtlo	k0
+
+	/* Restore RDHWR access */
 	PTR_LI	k0, 0x2000000F
-    mtc0    k0,  CP0_HWRENA
+	mtc0	k0,  CP0_HWRENA
 
 
-    /* Restore RA, which is the address we will return to */
-    LONG_L  ra, PT_R31(k1)
-    j       ra
-    nop
+	/* Restore RA, which is the address we will return to */
+	LONG_L  ra, PT_R31(k1)
+	j       ra
+	 nop
 
     .set    pop
 VECTOR_END(MIPSX(GuestExceptionEnd))
@@ -627,24 +635,23 @@ MIPSX(exceptions):
 
 #define HW_SYNCI_Step       $1
 LEAF(MIPSX(SyncICache))
-    .set    push
+	.set	push
 	.set	mips32r2
-    beq     a1, zero, 20f
-    nop
-    addu    a1, a0, a1
-    rdhwr   v0, HW_SYNCI_Step
-    beq     v0, zero, 20f
-    nop
-
+	beq	a1, zero, 20f
+	 nop
+	addu	a1, a0, a1
+	rdhwr	v0, HW_SYNCI_Step
+	beq	v0, zero, 20f
+	 nop
 10:
-    synci   0(a0)
-    addu    a0, a0, v0
-    sltu    v1, a0, a1
-    bne     v1, zero, 10b
-    nop
-    sync
+	synci	0(a0)
+	addu	a0, a0, v0
+	sltu	v1, a0, a1
+	bne	v1, zero, 10b
+	 nop
+	sync
 20:
-    jr.hb   ra
-    nop
-    .set pop
+	jr.hb	ra
+	 nop
+	.set	pop
 END(MIPSX(SyncICache))
-- 
1.7.11.7
