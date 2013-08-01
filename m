Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Aug 2013 22:24:20 +0200 (CEST)
Received: from mail-oa0-f46.google.com ([209.85.219.46]:34422 "EHLO
        mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825118Ab3HAUWx1R-yI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Aug 2013 22:22:53 +0200
Received: by mail-oa0-f46.google.com with SMTP id l10so5380397oag.33
        for <multiple recipients>; Thu, 01 Aug 2013 13:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ohc0VKDBvqK243O8bvPvUjvlFhyllwoaVGM7nQK9Zbg=;
        b=nf0Od/jKjzH54wSqlNutBZzSt/6ye968NclfdlUNncy2e7ZvLSi9xk4yx/skZJlLCr
         3e4GRoQuk8lsiO8mwyK1lzLkqzv5LeIm9n3Ci6j3iBp+pGov65BSQt5g02st/RE2qMDp
         JJ5SPJKp6ZHISgbED9BdpHhePKFFvIir4IdoPqmoXaWDvoy+ki1Q69TC7CHBRN0Lj0CS
         SesOCxPHV0t847e7WFn9MEpcwbE9uNfX+W3EhzDO8GND6zOesvh1g+YFZG4xsq+aPHFm
         um/7DFMrHxUOnA0UlnIrgGXW7hxFDDuOUdNnbIOb1np4QXjD7V0eujiRczMWZq5CNaRJ
         BNiw==
X-Received: by 10.182.66.46 with SMTP id c14mr2740512obt.33.1375388567199;
        Thu, 01 Aug 2013 13:22:47 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id j7sm4766326oew.5.2013.08.01.13.22.45
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 01 Aug 2013 13:22:46 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r71KMiDk004094;
        Thu, 1 Aug 2013 13:22:44 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r71KMiVV004093;
        Thu, 1 Aug 2013 13:22:44 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, Sanjay Lal <sanjayl@kymasys.com>,
        Gleb Natapov <gleb@redhat.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 3/3] mips/kvm: Make kvm_locore.S 64-bit buildable/safe.
Date:   Thu,  1 Aug 2013 13:22:35 -0700
Message-Id: <1375388555-4045-4-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1375388555-4045-1-git-send-email-ddaney.cavm@gmail.com>
References: <1375388555-4045-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37425
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

We need to use more of the Macros in asm.h to allow kvm_locore.S to
build in a 64-bit kernel.

For 32-bit there is no change in the generated object code.

Signed-off-by: David Daney <david.daney@cavium.com>
Acked-by: Ralf Baechle <ralf@linux-mips.org>
---
 arch/mips/kvm/kvm_locore.S | 54 +++++++++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/mips/kvm/kvm_locore.S b/arch/mips/kvm/kvm_locore.S
index fdc169d..bce2247 100644
--- a/arch/mips/kvm/kvm_locore.S
+++ b/arch/mips/kvm/kvm_locore.S
@@ -60,7 +60,7 @@
 
 FEXPORT(__kvm_mips_vcpu_run)
 	/* k0/k1 not being used in host kernel context */
-	addiu	k1, sp, -PT_SIZE
+	INT_ADDIU k1, sp, -PT_SIZE
 	LONG_S	$0, PT_R0(k1)
 	LONG_S	$1, PT_R1(k1)
 	LONG_S	$2, PT_R2(k1)
@@ -121,7 +121,7 @@ FEXPORT(__kvm_mips_vcpu_run)
 	mtc0	a1, CP0_DDATA_LO
 
 	/* Offset into vcpu->arch */
-	addiu	k1, a1, VCPU_HOST_ARCH
+	INT_ADDIU k1, a1, VCPU_HOST_ARCH
 
 	/*
 	 * Save the host stack to VCPU, used for exception processing
@@ -159,16 +159,16 @@ FEXPORT(__kvm_mips_vcpu_run)
 
 FEXPORT(__kvm_mips_load_asid)
 	/* Set the ASID for the Guest Kernel */
-	sll	t0, t0, 1	/* with kseg0 @ 0x40000000, kernel */
+	INT_SLL	t0, t0, 1	/* with kseg0 @ 0x40000000, kernel */
 			        /* addresses shift to 0x80000000 */
 	bltz	t0, 1f		/* If kernel */
-	 addiu	t1, k1, VCPU_GUEST_KERNEL_ASID  /* (BD)  */
-	addiu	t1, k1, VCPU_GUEST_USER_ASID    /* else user */
+	 INT_ADDIU t1, k1, VCPU_GUEST_KERNEL_ASID  /* (BD)  */
+	INT_ADDIU t1, k1, VCPU_GUEST_USER_ASID    /* else user */
 1:
 	     /* t1: contains the base of the ASID array, need to get the cpu id  */
 	LONG_L	t2, TI_CPU($28)             /* smp_processor_id */
-	sll	t2, t2, 2                   /* x4 */
-	addu	t3, t1, t2
+	INT_SLL	t2, t2, 2                   /* x4 */
+	REG_ADDU t3, t1, t2
 	LONG_L	k0, (t3)
 	andi	k0, k0, 0xff
 	mtc0	k0, CP0_ENTRYHI
@@ -236,10 +236,10 @@ VECTOR(MIPSX(exception), unknown)
 	ehb				#02:
 
 	mfc0	k0, CP0_EBASE		#02: Get EBASE
-	srl	k0, k0, 10		#03: Get rid of CPUNum
-	sll	k0, k0, 10		#04
+	INT_SRL	k0, k0, 10		#03: Get rid of CPUNum
+	INT_SLL	k0, k0, 10		#04
 	LONG_S	k1, 0x3000(k0)		#05: Save k1 @ offset 0x3000
-	addiu	k0, k0, 0x2000		#06: Exception handler is installed @ offset 0x2000
+	INT_ADDIU k0, k0, 0x2000		#06: Exception handler is installed @ offset 0x2000
 	j	k0			#07: jump to the function
 	 nop				#08: branch delay slot
 VECTOR_END(MIPSX(exceptionEnd))
@@ -253,7 +253,7 @@ VECTOR_END(MIPSX(exceptionEnd))
 NESTED (MIPSX(GuestException), CALLFRAME_SIZ, ra)
 	/* Get the VCPU pointer from DDTATA_LO */
 	mfc0	k1, CP0_DDATA_LO
-	addiu	k1, k1, VCPU_HOST_ARCH
+	INT_ADDIU k1, k1, VCPU_HOST_ARCH
 
 	/* Start saving Guest context to VCPU */
 	LONG_S	$0, VCPU_R0(k1)
@@ -304,7 +304,7 @@ NESTED (MIPSX(GuestException), CALLFRAME_SIZ, ra)
 	LONG_S	t0, VCPU_R26(k1)
 
 	/* Get GUEST k1 and save it in VCPU */
-	la	t1, ~0x2ff
+	PTR_LI	t1, ~0x2ff
 	mfc0	t0, CP0_EBASE
 	and	t0, t0, t1
 	LONG_L	t0, 0x3000(t0)
@@ -367,7 +367,7 @@ NESTED (MIPSX(GuestException), CALLFRAME_SIZ, ra)
 	LONG_L	sp, VCPU_HOST_STACK(k1)
 
 	/* Saved host state */
-	addiu	sp, sp, -PT_SIZE
+	INT_ADDIU sp, sp, -PT_SIZE
 
 	/* XXXKYMA do we need to load the host ASID, maybe not because the
 	 * kernel entries are marked GLOBAL, need to verify
@@ -378,7 +378,7 @@ NESTED (MIPSX(GuestException), CALLFRAME_SIZ, ra)
 	mtc0	k0, CP0_DDATA_LO
 
 	/* Restore RDHWR access */
-	la	k0, 0x2000000F
+	PTR_LI	k0, 0x2000000F
 	mtc0	k0, CP0_HWRENA
 
 	/* Jump to handler */
@@ -386,9 +386,9 @@ FEXPORT(__kvm_mips_jump_to_handler)
 	/* XXXKYMA: not sure if this is safe, how large is the stack??
 	 * Now jump to the kvm_mips_handle_exit() to see if we can deal
 	 * with this in the kernel */
-	la	t9, kvm_mips_handle_exit
+	PTR_LA	t9, kvm_mips_handle_exit
 	jalr.hb	t9
-	 addiu	sp, sp, -CALLFRAME_SIZ           /* BD Slot */
+	 INT_ADDIU sp, sp, -CALLFRAME_SIZ           /* BD Slot */
 
 	/* Return from handler Make sure interrupts are disabled */
 	di
@@ -400,7 +400,7 @@ FEXPORT(__kvm_mips_jump_to_handler)
 	 */
 
 	move	k1, s1
-	addiu	k1, k1, VCPU_HOST_ARCH
+	INT_ADDIU k1, k1, VCPU_HOST_ARCH
 
 	/* Check return value, should tell us if we are returning to the
 	 * host (handle I/O etc)or resuming the guest
@@ -438,16 +438,16 @@ __kvm_mips_return_to_guest:
 	mtc0	t0, CP0_EPC
 
 	/* Set the ASID for the Guest Kernel */
-	sll	t0, t0, 1	/* with kseg0 @ 0x40000000, kernel */
+	INT_SLL	t0, t0, 1	/* with kseg0 @ 0x40000000, kernel */
 				/* addresses shift to 0x80000000 */
 	bltz	t0, 1f		/* If kernel */
-	 addiu	t1, k1, VCPU_GUEST_KERNEL_ASID  /* (BD)  */
-	addiu	t1, k1, VCPU_GUEST_USER_ASID    /* else user */
+	 INT_ADDIU t1, k1, VCPU_GUEST_KERNEL_ASID  /* (BD)  */
+	INT_ADDIU t1, k1, VCPU_GUEST_USER_ASID    /* else user */
 1:
 	/* t1: contains the base of the ASID array, need to get the cpu id  */
 	LONG_L	t2, TI_CPU($28)		/* smp_processor_id */
-	sll	t2, t2, 2		/* x4 */
-	addu	t3, t1, t2
+	INT_SLL	t2, t2, 2		/* x4 */
+	REG_ADDU t3, t1, t2
 	LONG_L	k0, (t3)
 	andi	k0, k0, 0xff
 	mtc0	k0,CP0_ENTRYHI
@@ -505,7 +505,7 @@ FEXPORT(__kvm_mips_skip_guest_restore)
 __kvm_mips_return_to_host:
 	/* EBASE is already pointing to Linux */
 	LONG_L	k1, VCPU_HOST_STACK(k1)
-	addiu	k1,k1, -PT_SIZE
+	INT_ADDIU k1,k1, -PT_SIZE
 
 	/* Restore host DDATA_LO */
 	LONG_L	k0, PT_HOST_USERLOCAL(k1)
@@ -523,7 +523,7 @@ __kvm_mips_return_to_host:
 
 	/* r2/v0 is the return code, shift it down by 2 (arithmetic)
 	 * to recover the err code  */
-	sra	k0, v0, 2
+	INT_SRA	k0, v0, 2
 	move	$2, k0
 
 	LONG_L	$3, PT_R3(k1)
@@ -563,7 +563,7 @@ __kvm_mips_return_to_host:
 	mtlo	k0
 
 	/* Restore RDHWR access */
-	la	k0, 0x2000000F
+	PTR_LI	k0, 0x2000000F
 	mtc0	k0,  CP0_HWRENA
 
 
@@ -627,13 +627,13 @@ LEAF(MIPSX(SyncICache))
 	.set	mips32r2
 	beq	a1, zero, 20f
 	 nop
-	addu	a1, a0, a1
+	REG_ADDU a1, a0, a1
 	rdhwr	v0, HW_SYNCI_Step
 	beq	v0, zero, 20f
 	 nop
 10:
 	synci	0(a0)
-	addu	a0, a0, v0
+	REG_ADDU a0, a0, v0
 	sltu	v1, a0, a1
 	bne	v1, zero, 10b
 	 nop
-- 
1.7.11.7
