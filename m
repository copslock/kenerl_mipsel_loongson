Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2016 15:22:20 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:50323 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27041086AbcFINTo3xJQi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jun 2016 15:19:44 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 35AA438ACD8DD;
        Thu,  9 Jun 2016 14:19:35 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 9 Jun 2016 14:19:38 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     James Hogan <james.hogan@imgtec.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 08/18] MIPS: KVM: Don't indirect KVM functions
Date:   Thu, 9 Jun 2016 14:19:11 +0100
Message-ID: <1465478361-7431-9-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1465478361-7431-1-git-send-email-james.hogan@imgtec.com>
References: <1465478361-7431-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53922
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

Several KVM module functions are indirected so that they can be accessed
from tlb.c which is statically built into the kernel. This is no longer
necessary as the relevant bits of code have moved into mmu.c which is
part of the KVM module, so drop the indirections.

Note: is_error_pfn() is defined inline in kvm_host.h, so didn't actually
require the KVM module to be loaded for it to work anyway.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h |  3 ---
 arch/mips/kvm/mips.c             | 18 +-----------------
 arch/mips/kvm/mmu.c              |  4 ++--
 arch/mips/kvm/tlb.c              | 10 ----------
 4 files changed, 3 insertions(+), 32 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index f64be7987a32..c8f9671c2779 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -93,9 +93,6 @@
 #define KVM_INVALID_ADDR		0xdeadbeef
 
 extern atomic_t kvm_mips_instance;
-extern kvm_pfn_t (*kvm_mips_gfn_to_pfn)(struct kvm *kvm, gfn_t gfn);
-extern void (*kvm_mips_release_pfn_clean)(kvm_pfn_t pfn);
-extern bool (*kvm_mips_is_error_pfn)(kvm_pfn_t pfn);
 
 struct kvm_vm_stat {
 	u32 remote_tlb_flush;
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index a2b1b9205b94..c1ab6110ca1d 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -147,7 +147,7 @@ void kvm_mips_free_vcpus(struct kvm *kvm)
 	/* Put the pages we reserved for the guest pmap */
 	for (i = 0; i < kvm->arch.guest_pmap_npages; i++) {
 		if (kvm->arch.guest_pmap[i] != KVM_INVALID_PAGE)
-			kvm_mips_release_pfn_clean(kvm->arch.guest_pmap[i]);
+			kvm_release_pfn_clean(kvm->arch.guest_pmap[i]);
 	}
 	kfree(kvm->arch.guest_pmap);
 
@@ -1645,18 +1645,6 @@ static int __init kvm_mips_init(void)
 
 	register_die_notifier(&kvm_mips_csr_die_notifier);
 
-	/*
-	 * On MIPS, kernel modules are executed from "mapped space", which
-	 * requires TLBs. The TLB handling code is statically linked with
-	 * the rest of the kernel (tlb.c) to avoid the possibility of
-	 * double faulting. The issue is that the TLB code references
-	 * routines that are part of the the KVM module, which are only
-	 * available once the module is loaded.
-	 */
-	kvm_mips_gfn_to_pfn = gfn_to_pfn;
-	kvm_mips_release_pfn_clean = kvm_release_pfn_clean;
-	kvm_mips_is_error_pfn = is_error_pfn;
-
 	return 0;
 }
 
@@ -1664,10 +1652,6 @@ static void __exit kvm_mips_exit(void)
 {
 	kvm_exit();
 
-	kvm_mips_gfn_to_pfn = NULL;
-	kvm_mips_release_pfn_clean = NULL;
-	kvm_mips_is_error_pfn = NULL;
-
 	unregister_die_notifier(&kvm_mips_csr_die_notifier);
 }
 
diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index d18cadfd6e01..d5ada83ec55c 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -37,9 +37,9 @@ static int kvm_mips_map_page(struct kvm *kvm, gfn_t gfn)
 		return 0;
 
 	srcu_idx = srcu_read_lock(&kvm->srcu);
-	pfn = kvm_mips_gfn_to_pfn(kvm, gfn);
+	pfn = gfn_to_pfn(kvm, gfn);
 
-	if (kvm_mips_is_error_pfn(pfn)) {
+	if (is_error_pfn(pfn)) {
 		kvm_err("Couldn't get pfn for gfn %#llx!\n", gfn);
 		err = -EFAULT;
 		goto out;
diff --git a/arch/mips/kvm/tlb.c b/arch/mips/kvm/tlb.c
index 373817c3166b..37d77ad8431e 100644
--- a/arch/mips/kvm/tlb.c
+++ b/arch/mips/kvm/tlb.c
@@ -35,16 +35,6 @@
 atomic_t kvm_mips_instance;
 EXPORT_SYMBOL_GPL(kvm_mips_instance);
 
-/* These function pointers are initialized once the KVM module is loaded */
-kvm_pfn_t (*kvm_mips_gfn_to_pfn)(struct kvm *kvm, gfn_t gfn);
-EXPORT_SYMBOL_GPL(kvm_mips_gfn_to_pfn);
-
-void (*kvm_mips_release_pfn_clean)(kvm_pfn_t pfn);
-EXPORT_SYMBOL_GPL(kvm_mips_release_pfn_clean);
-
-bool (*kvm_mips_is_error_pfn)(kvm_pfn_t pfn);
-EXPORT_SYMBOL_GPL(kvm_mips_is_error_pfn);
-
 static u32 kvm_mips_get_kernel_asid(struct kvm_vcpu *vcpu)
 {
 	int cpu = smp_processor_id();
-- 
2.4.10
