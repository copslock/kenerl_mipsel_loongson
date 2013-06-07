Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Jun 2013 01:04:55 +0200 (CEST)
Received: from mail-ie0-f175.google.com ([209.85.223.175]:34194 "EHLO
        mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835081Ab3FGXDwu7gHw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 8 Jun 2013 01:03:52 +0200
Received: by mail-ie0-f175.google.com with SMTP id a14so1691228iee.6
        for <multiple recipients>; Fri, 07 Jun 2013 16:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=6omzsfz8A098hZb9RL7ts8xo8T3oLVe9o80Se//NTBE=;
        b=Du18xdvSmn/wuyNbpo+EMtjhyj1HQpJ/aAmMtK6pwPXW71H4Ji/gqESG18KBeDbCfm
         pC9RehMHzvZFm0hUSUiyw2bOkzSGHrxbRRKMCOLyW4PMWdTXiBrzZceO+nEWkR8YiVfM
         v6LlQcnnoJ0ftajZGFZSYFIZod5Xsc6HGyzG5q7JLwXzGTIKzt0szo6S8EgDsxdDmBe8
         JoyZd4qwd3osiLiTjZfrv1QCOH3Zwo8cgxsPW9OaJat+ebHc32wvNPWqyXdIpqFB75SS
         02ZDJksYzy2OB3hmoWD7zegOlgGeDkhymTddOiX1gNjTnfeo1VB95x06q8AxVWo5E5B+
         Ru+g==
X-Received: by 10.50.82.98 with SMTP id h2mr2323176igy.33.1370646226716;
        Fri, 07 Jun 2013 16:03:46 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id k10sm1232128ige.0.2013.06.07.16.03.45
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 07 Jun 2013 16:03:46 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r57N3iH9006626;
        Fri, 7 Jun 2013 16:03:44 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r57N3ick006625;
        Fri, 7 Jun 2013 16:03:44 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, Sanjay Lal <sanjayl@kymasys.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 04/31] mips/kvm: Add casts to avoid pointer width mismatch build failures.
Date:   Fri,  7 Jun 2013 16:03:08 -0700
Message-Id: <1370646215-6543-5-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
References: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36722
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

When building for 64-bits we need these cases to make it build.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/kvm/kvm_mips.c          | 4 ++--
 arch/mips/kvm/kvm_mips_dyntrans.c | 4 ++--
 arch/mips/kvm/kvm_mips_emul.c     | 2 +-
 arch/mips/kvm/kvm_tlb.c           | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/mips/kvm/kvm_mips.c b/arch/mips/kvm/kvm_mips.c
index d934b01..6018e2a 100644
--- a/arch/mips/kvm/kvm_mips.c
+++ b/arch/mips/kvm/kvm_mips.c
@@ -303,7 +303,7 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm, unsigned int id)
 	}
 
 	/* Save Linux EBASE */
-	vcpu->arch.host_ebase = (void *)read_c0_ebase();
+	vcpu->arch.host_ebase = (void *)(long)(read_c0_ebase() & 0x3ff);
 
 	gebase = kzalloc(ALIGN(size, PAGE_SIZE), GFP_KERNEL);
 
@@ -339,7 +339,7 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm, unsigned int id)
 	offset = 0x2000;
 	kvm_info("Installing KVM Exception handlers @ %p, %#x bytes\n",
 		 gebase + offset,
-		 mips32_GuestExceptionEnd - mips32_GuestException);
+		 (unsigned)(mips32_GuestExceptionEnd - mips32_GuestException));
 
 	memcpy(gebase + offset, mips32_GuestException,
 	       mips32_GuestExceptionEnd - mips32_GuestException);
diff --git a/arch/mips/kvm/kvm_mips_dyntrans.c b/arch/mips/kvm/kvm_mips_dyntrans.c
index 96528e2..dd0b8f9 100644
--- a/arch/mips/kvm/kvm_mips_dyntrans.c
+++ b/arch/mips/kvm/kvm_mips_dyntrans.c
@@ -94,7 +94,7 @@ kvm_mips_trans_mfc0(uint32_t inst, uint32_t *opc, struct kvm_vcpu *vcpu)
 						      cop0);
 	}
 
-	if (KVM_GUEST_KSEGX(opc) == KVM_GUEST_KSEG0) {
+	if (KVM_GUEST_KSEGX((unsigned long)opc) == KVM_GUEST_KSEG0) {
 		kseg0_opc =
 		    CKSEG0ADDR(kvm_mips_translate_guest_kseg0_to_hpa
 			       (vcpu, (unsigned long) opc));
@@ -129,7 +129,7 @@ kvm_mips_trans_mtc0(uint32_t inst, uint32_t *opc, struct kvm_vcpu *vcpu)
 	    offsetof(struct mips_coproc,
 		     reg[rd][sel]) + offsetof(struct kvm_mips_commpage, cop0);
 
-	if (KVM_GUEST_KSEGX(opc) == KVM_GUEST_KSEG0) {
+	if (KVM_GUEST_KSEGX((unsigned long)opc) == KVM_GUEST_KSEG0) {
 		kseg0_opc =
 		    CKSEG0ADDR(kvm_mips_translate_guest_kseg0_to_hpa
 			       (vcpu, (unsigned long) opc));
diff --git a/arch/mips/kvm/kvm_mips_emul.c b/arch/mips/kvm/kvm_mips_emul.c
index 4b6274b..af9a661 100644
--- a/arch/mips/kvm/kvm_mips_emul.c
+++ b/arch/mips/kvm/kvm_mips_emul.c
@@ -892,7 +892,7 @@ int kvm_mips_sync_icache(unsigned long va, struct kvm_vcpu *vcpu)
 	pfn = kvm->arch.guest_pmap[gfn];
 	pa = (pfn << PAGE_SHIFT) | offset;
 
-	printk("%s: va: %#lx, unmapped: %#x\n", __func__, va, CKSEG0ADDR(pa));
+	printk("%s: va: %#lx, unmapped: %#lx\n", __func__, va, CKSEG0ADDR(pa));
 
 	mips32_SyncICache(CKSEG0ADDR(pa), 32);
 	return 0;
diff --git a/arch/mips/kvm/kvm_tlb.c b/arch/mips/kvm/kvm_tlb.c
index c777dd3..5e189be 100644
--- a/arch/mips/kvm/kvm_tlb.c
+++ b/arch/mips/kvm/kvm_tlb.c
@@ -353,7 +353,7 @@ int kvm_mips_handle_commpage_tlb_fault(unsigned long badvaddr,
 	unsigned long entrylo0 = 0, entrylo1 = 0;
 
 
-	pfn0 = CPHYSADDR(vcpu->arch.kseg0_commpage) >> PAGE_SHIFT;
+	pfn0 = CPHYSADDR((unsigned long)vcpu->arch.kseg0_commpage) >> PAGE_SHIFT;
 	pfn1 = 0;
 	entrylo0 = mips3_paddr_to_tlbpfn(pfn0 << PAGE_SHIFT) | (0x3 << 3) | (1 << 2) |
 			(0x1 << 1);
@@ -916,7 +916,7 @@ uint32_t kvm_get_inst(uint32_t *opc, struct kvm_vcpu *vcpu)
 			inst = *(opc);
 		}
 		local_irq_restore(flags);
-	} else if (KVM_GUEST_KSEGX(opc) == KVM_GUEST_KSEG0) {
+	} else if (KVM_GUEST_KSEGX((unsigned long)opc) == KVM_GUEST_KSEG0) {
 		paddr =
 		    kvm_mips_translate_guest_kseg0_to_hpa(vcpu,
 							 (unsigned long) opc);
-- 
1.7.11.7
