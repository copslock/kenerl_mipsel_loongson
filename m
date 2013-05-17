Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 May 2013 23:26:14 +0200 (CEST)
Received: from kymasys.com ([64.62.140.43]:60758 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6835011Ab3EQVZhrJQYq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 May 2013 23:25:37 +0200
Received: from agni.kymasys.com ([75.40.23.192]) by kymasys.com for <linux-mips@linux-mips.org>; Fri, 17 May 2013 14:25:28 -0700
Received: by agni.kymasys.com (Postfix, from userid 500)
        id 2F819630051; Fri, 17 May 2013 14:25:20 -0700 (PDT)
From:   Sanjay Lal <sanjayl@kymasys.com>
To:     kvm@vger.kernel.org
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org, gleb@redhat.com,
        mtosatti@redhat.com, Sanjay Lal <sanjayl@kymasys.com>
Subject: [PATCH 2/3] KVM/MIPS32: Wrap calls to gfn_to_pfn() with srcu_read_lock/unlock()
Date:   Fri, 17 May 2013 14:25:11 -0700
Message-Id: <1368825912-23562-3-git-send-email-sanjayl@kymasys.com>
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1368825912-23562-1-git-send-email-sanjayl@kymasys.com>
References: <n>
 <1368825912-23562-1-git-send-email-sanjayl@kymasys.com>
Return-Path: <sanjayl@kymasys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36440
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sanjayl@kymasys.com
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

- As suggested by Gleb, wrap calls to gfn_to_pfn() with srcu_read_lock/unlock().
  Memory slots should be acccessed from a SRCU read section.
- kvm_mips_map_page() now returns an error code to it's callers, instead of calling panic()
 if it cannot find a mapping for a particular gfn.

Signed-off-by: Sanjay Lal <sanjayl@kymasys.com>
---
 arch/mips/kvm/kvm_tlb.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/arch/mips/kvm/kvm_tlb.c b/arch/mips/kvm/kvm_tlb.c
index 89511a9..ab2e9b0 100644
--- a/arch/mips/kvm/kvm_tlb.c
+++ b/arch/mips/kvm/kvm_tlb.c
@@ -16,7 +16,10 @@
 #include <linux/mm.h>
 #include <linux/delay.h>
 #include <linux/module.h>
+#include <linux/bootmem.h>
 #include <linux/kvm_host.h>
+#include <linux/srcu.h>
+
 
 #include <asm/cpu.h>
 #include <asm/bootinfo.h>
@@ -169,21 +172,27 @@ void kvm_mips_dump_shadow_tlbs(struct kvm_vcpu *vcpu)
 	}
 }
 
-static void kvm_mips_map_page(struct kvm *kvm, gfn_t gfn)
+static int kvm_mips_map_page(struct kvm *kvm, gfn_t gfn)
 {
+	int srcu_idx, err = 0;
 	pfn_t pfn;
 
 	if (kvm->arch.guest_pmap[gfn] != KVM_INVALID_PAGE)
-		return;
+		return 0;
 
+        srcu_idx = srcu_read_lock(&kvm->srcu);
 	pfn = kvm_mips_gfn_to_pfn(kvm, gfn);
 
 	if (kvm_mips_is_error_pfn(pfn)) {
-		panic("Couldn't get pfn for gfn %#" PRIx64 "!\n", gfn);
+		kvm_err("Couldn't get pfn for gfn %#" PRIx64 "!\n", gfn);
+		err = -EFAULT;
+		goto out;
 	}
 
 	kvm->arch.guest_pmap[gfn] = pfn;
-	return;
+out:
+	srcu_read_unlock(&kvm->srcu, srcu_idx);
+	return err;
 }
 
 /* Translate guest KSEG0 addresses to Host PA */
@@ -207,7 +216,10 @@ unsigned long kvm_mips_translate_guest_kseg0_to_hpa(struct kvm_vcpu *vcpu,
 			gva);
 		return KVM_INVALID_PAGE;
 	}
-	kvm_mips_map_page(vcpu->kvm, gfn);
+
+	if (kvm_mips_map_page(vcpu->kvm, gfn) < 0)
+		return KVM_INVALID_ADDR;
+
 	return (kvm->arch.guest_pmap[gfn] << PAGE_SHIFT) + offset;
 }
 
@@ -310,8 +322,11 @@ int kvm_mips_handle_kseg0_tlb_fault(unsigned long badvaddr,
 	even = !(gfn & 0x1);
 	vaddr = badvaddr & (PAGE_MASK << 1);
 
-	kvm_mips_map_page(vcpu->kvm, gfn);
-	kvm_mips_map_page(vcpu->kvm, gfn ^ 0x1);
+	if (kvm_mips_map_page(vcpu->kvm, gfn) < 0)
+		return -1;
+
+	if (kvm_mips_map_page(vcpu->kvm, gfn ^ 0x1) < 0)
+		return -1;
 
 	if (even) {
 		pfn0 = kvm->arch.guest_pmap[gfn];
@@ -389,8 +404,11 @@ kvm_mips_handle_mapped_seg_tlb_fault(struct kvm_vcpu *vcpu,
 		pfn0 = 0;
 		pfn1 = 0;
 	} else {
-		kvm_mips_map_page(kvm, mips3_tlbpfn_to_paddr(tlb->tlb_lo0) >> PAGE_SHIFT);
-		kvm_mips_map_page(kvm, mips3_tlbpfn_to_paddr(tlb->tlb_lo1) >> PAGE_SHIFT);
+		if (kvm_mips_map_page(kvm, mips3_tlbpfn_to_paddr(tlb->tlb_lo0) >> PAGE_SHIFT) < 0)
+			return -1;
+
+		if (kvm_mips_map_page(kvm, mips3_tlbpfn_to_paddr(tlb->tlb_lo1) >> PAGE_SHIFT) < 0)
+			return -1;
 
 		pfn0 = kvm->arch.guest_pmap[mips3_tlbpfn_to_paddr(tlb->tlb_lo0) >> PAGE_SHIFT];
 		pfn1 = kvm->arch.guest_pmap[mips3_tlbpfn_to_paddr(tlb->tlb_lo1) >> PAGE_SHIFT];
-- 
1.7.11.3
