Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Jun 2013 01:06:47 +0200 (CEST)
Received: from mail-ie0-f182.google.com ([209.85.223.182]:36999 "EHLO
        mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835149Ab3FGXDylGL0Q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 8 Jun 2013 01:03:54 +0200
Received: by mail-ie0-f182.google.com with SMTP id 9so12059237iec.41
        for <multiple recipients>; Fri, 07 Jun 2013 16:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=CT5fVng6RrrwVTNac2z65sQPHHkwjr9bJ2apBDH3Bt8=;
        b=jPNxXvgtLgXUvGkYR/CskqHTdv6/QnOitgE0OwdZ3754cyOdEFattWFGjF5QAgCyJ5
         JOzcC7in8tjbr64/UBJ1udqmwwZsv2Jkc57MdIrLHgxqCl+LeyJKDR3s/dYfmAFFpByY
         PtCZnNO3HsdxNqO1m8b/ahuEbdEC56S+FMkFyGEU1fxGZm38VypnaYaF0ErYumAj0T4K
         5AbYCQS8M4Cf18LqW8ybl6DNMzpbFSvo5yO8vs+qQ42i1PXxiXe1Wq6i5MnpWX/OuF/e
         8FxxrwbltK3yG6sSyUPZER0yz2LHFECh2h9zUhc+O4AgnKHQCwxqHIJUHPevjMx2zGNG
         ka6g==
X-Received: by 10.50.82.102 with SMTP id h6mr449999igy.23.1370646228380;
        Fri, 07 Jun 2013 16:03:48 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id nt6sm135880igb.10.2013.06.07.16.03.46
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 07 Jun 2013 16:03:47 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r57N3ja4006638;
        Fri, 7 Jun 2013 16:03:45 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r57N3jT0006637;
        Fri, 7 Jun 2013 16:03:45 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, Sanjay Lal <sanjayl@kymasys.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 07/31] mips/kvm: Rename VCPU_registername to KVM_VCPU_ARCH_registername
Date:   Fri,  7 Jun 2013 16:03:11 -0700
Message-Id: <1370646215-6543-8-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
References: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36726
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

This makes it follow the pattern where the structure name is the
symbol name prefix.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/kernel/asm-offsets.c |  68 +++++++-------
 arch/mips/kvm/kvm_locore.S     | 206 ++++++++++++++++++++---------------------
 2 files changed, 137 insertions(+), 137 deletions(-)

diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index 22bf8f5..a0aa12c 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -351,40 +351,40 @@ void output_kvm_defines(void)
 
 	OFFSET(VCPU_GUEST_INST, kvm_vcpu_arch, guest_inst);
 
-	OFFSET(VCPU_R0, kvm_vcpu_arch, gprs[0]);
-	OFFSET(VCPU_R1, kvm_vcpu_arch, gprs[1]);
-	OFFSET(VCPU_R2, kvm_vcpu_arch, gprs[2]);
-	OFFSET(VCPU_R3, kvm_vcpu_arch, gprs[3]);
-	OFFSET(VCPU_R4, kvm_vcpu_arch, gprs[4]);
-	OFFSET(VCPU_R5, kvm_vcpu_arch, gprs[5]);
-	OFFSET(VCPU_R6, kvm_vcpu_arch, gprs[6]);
-	OFFSET(VCPU_R7, kvm_vcpu_arch, gprs[7]);
-	OFFSET(VCPU_R8, kvm_vcpu_arch, gprs[8]);
-	OFFSET(VCPU_R9, kvm_vcpu_arch, gprs[9]);
-	OFFSET(VCPU_R10, kvm_vcpu_arch, gprs[10]);
-	OFFSET(VCPU_R11, kvm_vcpu_arch, gprs[11]);
-	OFFSET(VCPU_R12, kvm_vcpu_arch, gprs[12]);
-	OFFSET(VCPU_R13, kvm_vcpu_arch, gprs[13]);
-	OFFSET(VCPU_R14, kvm_vcpu_arch, gprs[14]);
-	OFFSET(VCPU_R15, kvm_vcpu_arch, gprs[15]);
-	OFFSET(VCPU_R16, kvm_vcpu_arch, gprs[16]);
-	OFFSET(VCPU_R17, kvm_vcpu_arch, gprs[17]);
-	OFFSET(VCPU_R18, kvm_vcpu_arch, gprs[18]);
-	OFFSET(VCPU_R19, kvm_vcpu_arch, gprs[19]);
-	OFFSET(VCPU_R20, kvm_vcpu_arch, gprs[20]);
-	OFFSET(VCPU_R21, kvm_vcpu_arch, gprs[21]);
-	OFFSET(VCPU_R22, kvm_vcpu_arch, gprs[22]);
-	OFFSET(VCPU_R23, kvm_vcpu_arch, gprs[23]);
-	OFFSET(VCPU_R24, kvm_vcpu_arch, gprs[24]);
-	OFFSET(VCPU_R25, kvm_vcpu_arch, gprs[25]);
-	OFFSET(VCPU_R26, kvm_vcpu_arch, gprs[26]);
-	OFFSET(VCPU_R27, kvm_vcpu_arch, gprs[27]);
-	OFFSET(VCPU_R28, kvm_vcpu_arch, gprs[28]);
-	OFFSET(VCPU_R29, kvm_vcpu_arch, gprs[29]);
-	OFFSET(VCPU_R30, kvm_vcpu_arch, gprs[30]);
-	OFFSET(VCPU_R31, kvm_vcpu_arch, gprs[31]);
-	OFFSET(VCPU_LO, kvm_vcpu_arch, lo);
-	OFFSET(VCPU_HI, kvm_vcpu_arch, hi);
+	OFFSET(KVM_VCPU_ARCH_R0, kvm_vcpu_arch, gprs[0]);
+	OFFSET(KVM_VCPU_ARCH_R1, kvm_vcpu_arch, gprs[1]);
+	OFFSET(KVM_VCPU_ARCH_R2, kvm_vcpu_arch, gprs[2]);
+	OFFSET(KVM_VCPU_ARCH_R3, kvm_vcpu_arch, gprs[3]);
+	OFFSET(KVM_VCPU_ARCH_R4, kvm_vcpu_arch, gprs[4]);
+	OFFSET(KVM_VCPU_ARCH_R5, kvm_vcpu_arch, gprs[5]);
+	OFFSET(KVM_VCPU_ARCH_R6, kvm_vcpu_arch, gprs[6]);
+	OFFSET(KVM_VCPU_ARCH_R7, kvm_vcpu_arch, gprs[7]);
+	OFFSET(KVM_VCPU_ARCH_R8, kvm_vcpu_arch, gprs[8]);
+	OFFSET(KVM_VCPU_ARCH_R9, kvm_vcpu_arch, gprs[9]);
+	OFFSET(KVM_VCPU_ARCH_R10, kvm_vcpu_arch, gprs[10]);
+	OFFSET(KVM_VCPU_ARCH_R11, kvm_vcpu_arch, gprs[11]);
+	OFFSET(KVM_VCPU_ARCH_R12, kvm_vcpu_arch, gprs[12]);
+	OFFSET(KVM_VCPU_ARCH_R13, kvm_vcpu_arch, gprs[13]);
+	OFFSET(KVM_VCPU_ARCH_R14, kvm_vcpu_arch, gprs[14]);
+	OFFSET(KVM_VCPU_ARCH_R15, kvm_vcpu_arch, gprs[15]);
+	OFFSET(KVM_VCPU_ARCH_R16, kvm_vcpu_arch, gprs[16]);
+	OFFSET(KVM_VCPU_ARCH_R17, kvm_vcpu_arch, gprs[17]);
+	OFFSET(KVM_VCPU_ARCH_R18, kvm_vcpu_arch, gprs[18]);
+	OFFSET(KVM_VCPU_ARCH_R19, kvm_vcpu_arch, gprs[19]);
+	OFFSET(KVM_VCPU_ARCH_R20, kvm_vcpu_arch, gprs[20]);
+	OFFSET(KVM_VCPU_ARCH_R21, kvm_vcpu_arch, gprs[21]);
+	OFFSET(KVM_VCPU_ARCH_R22, kvm_vcpu_arch, gprs[22]);
+	OFFSET(KVM_VCPU_ARCH_R23, kvm_vcpu_arch, gprs[23]);
+	OFFSET(KVM_VCPU_ARCH_R24, kvm_vcpu_arch, gprs[24]);
+	OFFSET(KVM_VCPU_ARCH_R25, kvm_vcpu_arch, gprs[25]);
+	OFFSET(KVM_VCPU_ARCH_R26, kvm_vcpu_arch, gprs[26]);
+	OFFSET(KVM_VCPU_ARCH_R27, kvm_vcpu_arch, gprs[27]);
+	OFFSET(KVM_VCPU_ARCH_R28, kvm_vcpu_arch, gprs[28]);
+	OFFSET(KVM_VCPU_ARCH_R29, kvm_vcpu_arch, gprs[29]);
+	OFFSET(KVM_VCPU_ARCH_R30, kvm_vcpu_arch, gprs[30]);
+	OFFSET(KVM_VCPU_ARCH_R31, kvm_vcpu_arch, gprs[31]);
+	OFFSET(KVM_VCPU_ARCH_LO, kvm_vcpu_arch, lo);
+	OFFSET(KVM_VCPU_ARCH_HI, kvm_vcpu_arch, hi);
 	OFFSET(KVM_VCPU_ARCH_EPC, kvm_vcpu_arch, epc);
 	OFFSET(VCPU_COP0, kvm_vcpu_arch, cop0);
 	OFFSET(VCPU_GUEST_KERNEL_ASID, kvm_vcpu_arch, guest_kernel_asid);
diff --git a/arch/mips/kvm/kvm_locore.S b/arch/mips/kvm/kvm_locore.S
index a434bbe..7a33ee7 100644
--- a/arch/mips/kvm/kvm_locore.S
+++ b/arch/mips/kvm/kvm_locore.S
@@ -175,52 +175,52 @@ FEXPORT(__kvm_mips_load_asid)
     mtc0    zero,  CP0_HWRENA
 
     /* Now load up the Guest Context from VCPU */
-    LONG_L     	$1, VCPU_R1(k1)
-    LONG_L     	$2, VCPU_R2(k1)
-    LONG_L     	$3, VCPU_R3(k1)
-
-    LONG_L     	$4, VCPU_R4(k1)
-    LONG_L     	$5, VCPU_R5(k1)
-    LONG_L     	$6, VCPU_R6(k1)
-    LONG_L     	$7, VCPU_R7(k1)
-
-    LONG_L     	$8,  VCPU_R8(k1)
-    LONG_L     	$9,  VCPU_R9(k1)
-    LONG_L     	$10, VCPU_R10(k1)
-    LONG_L     	$11, VCPU_R11(k1)
-    LONG_L     	$12, VCPU_R12(k1)
-    LONG_L     	$13, VCPU_R13(k1)
-    LONG_L     	$14, VCPU_R14(k1)
-    LONG_L     	$15, VCPU_R15(k1)
-    LONG_L     	$16, VCPU_R16(k1)
-    LONG_L     	$17, VCPU_R17(k1)
-    LONG_L     	$18, VCPU_R18(k1)
-    LONG_L     	$19, VCPU_R19(k1)
-    LONG_L     	$20, VCPU_R20(k1)
-    LONG_L     	$21, VCPU_R21(k1)
-    LONG_L     	$22, VCPU_R22(k1)
-    LONG_L     	$23, VCPU_R23(k1)
-    LONG_L     	$24, VCPU_R24(k1)
-    LONG_L     	$25, VCPU_R25(k1)
+    LONG_L     	$1, KVM_VCPU_ARCH_R1(k1)
+    LONG_L     	$2, KVM_VCPU_ARCH_R2(k1)
+    LONG_L     	$3, KVM_VCPU_ARCH_R3(k1)
+
+    LONG_L     	$4, KVM_VCPU_ARCH_R4(k1)
+    LONG_L     	$5, KVM_VCPU_ARCH_R5(k1)
+    LONG_L     	$6, KVM_VCPU_ARCH_R6(k1)
+    LONG_L     	$7, KVM_VCPU_ARCH_R7(k1)
+
+    LONG_L     	$8,  KVM_VCPU_ARCH_R8(k1)
+    LONG_L     	$9,  KVM_VCPU_ARCH_R9(k1)
+    LONG_L     	$10, KVM_VCPU_ARCH_R10(k1)
+    LONG_L     	$11, KVM_VCPU_ARCH_R11(k1)
+    LONG_L     	$12, KVM_VCPU_ARCH_R12(k1)
+    LONG_L     	$13, KVM_VCPU_ARCH_R13(k1)
+    LONG_L     	$14, KVM_VCPU_ARCH_R14(k1)
+    LONG_L     	$15, KVM_VCPU_ARCH_R15(k1)
+    LONG_L     	$16, KVM_VCPU_ARCH_R16(k1)
+    LONG_L     	$17, KVM_VCPU_ARCH_R17(k1)
+    LONG_L     	$18, KVM_VCPU_ARCH_R18(k1)
+    LONG_L     	$19, KVM_VCPU_ARCH_R19(k1)
+    LONG_L     	$20, KVM_VCPU_ARCH_R20(k1)
+    LONG_L     	$21, KVM_VCPU_ARCH_R21(k1)
+    LONG_L     	$22, KVM_VCPU_ARCH_R22(k1)
+    LONG_L     	$23, KVM_VCPU_ARCH_R23(k1)
+    LONG_L     	$24, KVM_VCPU_ARCH_R24(k1)
+    LONG_L     	$25, KVM_VCPU_ARCH_R25(k1)
 
     /* k0/k1 loaded up later */
 
-    LONG_L     	$28, VCPU_R28(k1)
-    LONG_L     	$29, VCPU_R29(k1)
-    LONG_L     	$30, VCPU_R30(k1)
-    LONG_L     	$31, VCPU_R31(k1)
+    LONG_L     	$28, KVM_VCPU_ARCH_R28(k1)
+    LONG_L     	$29, KVM_VCPU_ARCH_R29(k1)
+    LONG_L     	$30, KVM_VCPU_ARCH_R30(k1)
+    LONG_L     	$31, KVM_VCPU_ARCH_R31(k1)
 
     /* Restore hi/lo */
-	LONG_L		k0, VCPU_LO(k1)
+	LONG_L		k0, KVM_VCPU_ARCH_LO(k1)
 	mtlo		k0
 
-	LONG_L		k0, VCPU_HI(k1)
+	LONG_L		k0, KVM_VCPU_ARCH_HI(k1)
 	mthi   		k0
 
 FEXPORT(__kvm_mips_load_k0k1)
 	/* Restore the guest's k0/k1 registers */
-    LONG_L     	k0, VCPU_R26(k1)
-    LONG_L     	k1, VCPU_R27(k1)
+    LONG_L     	k0, KVM_VCPU_ARCH_R26(k1)
+    LONG_L     	k1, KVM_VCPU_ARCH_R27(k1)
 
     /* Jump to guest */
 	eret
@@ -262,59 +262,59 @@ NESTED (MIPSX(GuestException), CALLFRAME_SIZ, ra)
 	addiu		k1, k1, VCPU_HOST_ARCH
 
     /* Start saving Guest context to VCPU */
-    LONG_S  $0, VCPU_R0(k1)
-    LONG_S  $1, VCPU_R1(k1)
-    LONG_S  $2, VCPU_R2(k1)
-    LONG_S  $3, VCPU_R3(k1)
-    LONG_S  $4, VCPU_R4(k1)
-    LONG_S  $5, VCPU_R5(k1)
-    LONG_S  $6, VCPU_R6(k1)
-    LONG_S  $7, VCPU_R7(k1)
-    LONG_S  $8, VCPU_R8(k1)
-    LONG_S  $9, VCPU_R9(k1)
-    LONG_S  $10, VCPU_R10(k1)
-    LONG_S  $11, VCPU_R11(k1)
-    LONG_S  $12, VCPU_R12(k1)
-    LONG_S  $13, VCPU_R13(k1)
-    LONG_S  $14, VCPU_R14(k1)
-    LONG_S  $15, VCPU_R15(k1)
-    LONG_S  $16, VCPU_R16(k1)
-    LONG_S  $17,VCPU_R17(k1)
-    LONG_S  $18, VCPU_R18(k1)
-    LONG_S  $19, VCPU_R19(k1)
-    LONG_S  $20, VCPU_R20(k1)
-    LONG_S  $21, VCPU_R21(k1)
-    LONG_S  $22, VCPU_R22(k1)
-    LONG_S  $23, VCPU_R23(k1)
-    LONG_S  $24, VCPU_R24(k1)
-    LONG_S  $25, VCPU_R25(k1)
+    LONG_S  $0, KVM_VCPU_ARCH_R0(k1)
+    LONG_S  $1, KVM_VCPU_ARCH_R1(k1)
+    LONG_S  $2, KVM_VCPU_ARCH_R2(k1)
+    LONG_S  $3, KVM_VCPU_ARCH_R3(k1)
+    LONG_S  $4, KVM_VCPU_ARCH_R4(k1)
+    LONG_S  $5, KVM_VCPU_ARCH_R5(k1)
+    LONG_S  $6, KVM_VCPU_ARCH_R6(k1)
+    LONG_S  $7, KVM_VCPU_ARCH_R7(k1)
+    LONG_S  $8, KVM_VCPU_ARCH_R8(k1)
+    LONG_S  $9, KVM_VCPU_ARCH_R9(k1)
+    LONG_S  $10, KVM_VCPU_ARCH_R10(k1)
+    LONG_S  $11, KVM_VCPU_ARCH_R11(k1)
+    LONG_S  $12, KVM_VCPU_ARCH_R12(k1)
+    LONG_S  $13, KVM_VCPU_ARCH_R13(k1)
+    LONG_S  $14, KVM_VCPU_ARCH_R14(k1)
+    LONG_S  $15, KVM_VCPU_ARCH_R15(k1)
+    LONG_S  $16, KVM_VCPU_ARCH_R16(k1)
+    LONG_S  $17, KVM_VCPU_ARCH_R17(k1)
+    LONG_S  $18, KVM_VCPU_ARCH_R18(k1)
+    LONG_S  $19, KVM_VCPU_ARCH_R19(k1)
+    LONG_S  $20, KVM_VCPU_ARCH_R20(k1)
+    LONG_S  $21, KVM_VCPU_ARCH_R21(k1)
+    LONG_S  $22, KVM_VCPU_ARCH_R22(k1)
+    LONG_S  $23, KVM_VCPU_ARCH_R23(k1)
+    LONG_S  $24, KVM_VCPU_ARCH_R24(k1)
+    LONG_S  $25, KVM_VCPU_ARCH_R25(k1)
 
     /* Guest k0/k1 saved later */
 
-    LONG_S  $28, VCPU_R28(k1)
-    LONG_S  $29, VCPU_R29(k1)
-    LONG_S  $30, VCPU_R30(k1)
-    LONG_S  $31, VCPU_R31(k1)
+    LONG_S  $28, KVM_VCPU_ARCH_R28(k1)
+    LONG_S  $29, KVM_VCPU_ARCH_R29(k1)
+    LONG_S  $30, KVM_VCPU_ARCH_R30(k1)
+    LONG_S  $31, KVM_VCPU_ARCH_R31(k1)
 
     /* We need to save hi/lo and restore them on
      * the way out
      */
     mfhi    t0
-    LONG_S  t0, VCPU_HI(k1)
+    LONG_S  t0, KVM_VCPU_ARCH_HI(k1)
 
     mflo    t0
-    LONG_S  t0, VCPU_LO(k1)
+    LONG_S  t0, KVM_VCPU_ARCH_LO(k1)
 
     /* Finally save guest k0/k1 to VCPU */
     mfc0    t0, CP0_ERROREPC
-    LONG_S  t0, VCPU_R26(k1)
+    LONG_S  t0, KVM_VCPU_ARCH_R26(k1)
 
     /* Get GUEST k1 and save it in VCPU */
 	PTR_LI	t1, ~0x2ff
     mfc0    t0, CP0_EBASE
     and     t0, t0, t1
     LONG_L  t0, 0x3000(t0)
-    LONG_S  t0, VCPU_R27(k1)
+    LONG_S  t0, KVM_VCPU_ARCH_R27(k1)
 
     /* Now that context has been saved, we can use other registers */
 
@@ -461,48 +461,48 @@ __kvm_mips_return_to_guest:
     mtc0    zero,  CP0_HWRENA
 
     /* load the guest context from VCPU and return */
-    LONG_L  $0, VCPU_R0(k1)
-    LONG_L  $1, VCPU_R1(k1)
-    LONG_L  $2, VCPU_R2(k1)
-    LONG_L  $3, VCPU_R3(k1)
-    LONG_L  $4, VCPU_R4(k1)
-    LONG_L  $5, VCPU_R5(k1)
-    LONG_L  $6, VCPU_R6(k1)
-    LONG_L  $7, VCPU_R7(k1)
-    LONG_L  $8, VCPU_R8(k1)
-    LONG_L  $9, VCPU_R9(k1)
-    LONG_L  $10, VCPU_R10(k1)
-    LONG_L  $11, VCPU_R11(k1)
-    LONG_L  $12, VCPU_R12(k1)
-    LONG_L  $13, VCPU_R13(k1)
-    LONG_L  $14, VCPU_R14(k1)
-    LONG_L  $15, VCPU_R15(k1)
-    LONG_L  $16, VCPU_R16(k1)
-    LONG_L  $17, VCPU_R17(k1)
-    LONG_L  $18, VCPU_R18(k1)
-    LONG_L  $19, VCPU_R19(k1)
-    LONG_L  $20, VCPU_R20(k1)
-    LONG_L  $21, VCPU_R21(k1)
-    LONG_L  $22, VCPU_R22(k1)
-    LONG_L  $23, VCPU_R23(k1)
-    LONG_L  $24, VCPU_R24(k1)
-    LONG_L  $25, VCPU_R25(k1)
+    LONG_L  $0, KVM_VCPU_ARCH_R0(k1)
+    LONG_L  $1, KVM_VCPU_ARCH_R1(k1)
+    LONG_L  $2, KVM_VCPU_ARCH_R2(k1)
+    LONG_L  $3, KVM_VCPU_ARCH_R3(k1)
+    LONG_L  $4, KVM_VCPU_ARCH_R4(k1)
+    LONG_L  $5, KVM_VCPU_ARCH_R5(k1)
+    LONG_L  $6, KVM_VCPU_ARCH_R6(k1)
+    LONG_L  $7, KVM_VCPU_ARCH_R7(k1)
+    LONG_L  $8, KVM_VCPU_ARCH_R8(k1)
+    LONG_L  $9, KVM_VCPU_ARCH_R9(k1)
+    LONG_L  $10, KVM_VCPU_ARCH_R10(k1)
+    LONG_L  $11, KVM_VCPU_ARCH_R11(k1)
+    LONG_L  $12, KVM_VCPU_ARCH_R12(k1)
+    LONG_L  $13, KVM_VCPU_ARCH_R13(k1)
+    LONG_L  $14, KVM_VCPU_ARCH_R14(k1)
+    LONG_L  $15, KVM_VCPU_ARCH_R15(k1)
+    LONG_L  $16, KVM_VCPU_ARCH_R16(k1)
+    LONG_L  $17, KVM_VCPU_ARCH_R17(k1)
+    LONG_L  $18, KVM_VCPU_ARCH_R18(k1)
+    LONG_L  $19, KVM_VCPU_ARCH_R19(k1)
+    LONG_L  $20, KVM_VCPU_ARCH_R20(k1)
+    LONG_L  $21, KVM_VCPU_ARCH_R21(k1)
+    LONG_L  $22, KVM_VCPU_ARCH_R22(k1)
+    LONG_L  $23, KVM_VCPU_ARCH_R23(k1)
+    LONG_L  $24, KVM_VCPU_ARCH_R24(k1)
+    LONG_L  $25, KVM_VCPU_ARCH_R25(k1)
 
     /* $/k1 loaded later */
-    LONG_L  $28, VCPU_R28(k1)
-    LONG_L  $29, VCPU_R29(k1)
-    LONG_L  $30, VCPU_R30(k1)
-    LONG_L  $31, VCPU_R31(k1)
+    LONG_L  $28, KVM_VCPU_ARCH_R28(k1)
+    LONG_L  $29, KVM_VCPU_ARCH_R29(k1)
+    LONG_L  $30, KVM_VCPU_ARCH_R30(k1)
+    LONG_L  $31, KVM_VCPU_ARCH_R31(k1)
 
 FEXPORT(__kvm_mips_skip_guest_restore)
-    LONG_L  k0, VCPU_HI(k1)
+    LONG_L  k0, KVM_VCPU_ARCH_HI(k1)
     mthi    k0
 
-    LONG_L  k0, VCPU_LO(k1)
+    LONG_L  k0, KVM_VCPU_ARCH_LO(k1)
     mtlo    k0
 
-    LONG_L  k0, VCPU_R26(k1)
-    LONG_L  k1, VCPU_R27(k1)
+    LONG_L  k0, KVM_VCPU_ARCH_R26(k1)
+    LONG_L  k1, KVM_VCPU_ARCH_R27(k1)
 
     eret
 
-- 
1.7.11.7
