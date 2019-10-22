Return-Path: <SRS0=Z+4i=YP=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F83CA9EAF
	for <linux-mips@archiver.kernel.org>; Tue, 22 Oct 2019 00:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 456002089E
	for <linux-mips@archiver.kernel.org>; Tue, 22 Oct 2019 00:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730923AbfJVAgl (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 21 Oct 2019 20:36:41 -0400
Received: from mga07.intel.com ([134.134.136.100]:35282 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730601AbfJVAfm (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 21 Oct 2019 20:35:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2019 17:35:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,325,1566889200"; 
   d="scan'208";a="348897217"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.41])
  by orsmga004.jf.intel.com with ESMTP; 21 Oct 2019 17:35:39 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     James Hogan <jhogan@kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-mips@vger.kernel.org, kvm-ppc@vger.kernel.org,
        kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/15] KVM: Refactor error handling for setting memory region
Date:   Mon, 21 Oct 2019 17:35:29 -0700
Message-Id: <20191022003537.13013-8-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20191022003537.13013-1-sean.j.christopherson@intel.com>
References: <20191022003537.13013-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Replace a big pile o' gotos with returns to make it more obvious what
error code is being returned, and to prepare for refactoring the
functional, i.e. post-checks, portion of __kvm_set_memory_region().

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 virt/kvm/kvm_main.c | 40 ++++++++++++++++++----------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 26151e2e3365..40e27ffaf29a 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -930,34 +930,33 @@ int __kvm_set_memory_region(struct kvm *kvm,
 
 	r = check_memory_region_flags(mem);
 	if (r)
-		goto out;
+		return r;
 
-	r = -EINVAL;
 	as_id = mem->slot >> 16;
 	id = (u16)mem->slot;
 
 	/* General sanity checks */
 	if (mem->memory_size & (PAGE_SIZE - 1))
-		goto out;
+		return -EINVAL;
 	if (mem->guest_phys_addr & (PAGE_SIZE - 1))
-		goto out;
+		return -EINVAL;
 	/* We can read the guest memory with __xxx_user() later on. */
 	if ((id < KVM_USER_MEM_SLOTS) &&
 	    ((mem->userspace_addr & (PAGE_SIZE - 1)) ||
 	     !access_ok((void __user *)(unsigned long)mem->userspace_addr,
 			mem->memory_size)))
-		goto out;
+		return -EINVAL;
 	if (as_id >= KVM_ADDRESS_SPACE_NUM || id >= KVM_MEM_SLOTS_NUM)
-		goto out;
+		return -EINVAL;
 	if (mem->guest_phys_addr + mem->memory_size < mem->guest_phys_addr)
-		goto out;
+		return -EINVAL;
 
 	slot = id_to_memslot(__kvm_memslots(kvm, as_id), id);
 	base_gfn = mem->guest_phys_addr >> PAGE_SHIFT;
 	npages = mem->memory_size >> PAGE_SHIFT;
 
 	if (npages > KVM_MEM_MAX_NR_PAGES)
-		goto out;
+		return -EINVAL;
 
 	new = old = *slot;
 
@@ -974,20 +973,18 @@ int __kvm_set_memory_region(struct kvm *kvm,
 			if ((new.userspace_addr != old.userspace_addr) ||
 			    (npages != old.npages) ||
 			    ((new.flags ^ old.flags) & KVM_MEM_READONLY))
-				goto out;
+				return -EINVAL;
 
 			if (base_gfn != old.base_gfn)
 				change = KVM_MR_MOVE;
 			else if (new.flags != old.flags)
 				change = KVM_MR_FLAGS_ONLY;
-			else { /* Nothing to change. */
-				r = 0;
-				goto out;
-			}
+			else /* Nothing to change. */
+				return 0;
 		}
 	} else {
 		if (!old.npages)
-			goto out;
+			return -EINVAL;
 
 		change = KVM_MR_DELETE;
 		new.base_gfn = 0;
@@ -996,29 +993,29 @@ int __kvm_set_memory_region(struct kvm *kvm,
 
 	if ((change == KVM_MR_CREATE) || (change == KVM_MR_MOVE)) {
 		/* Check for overlaps */
-		r = -EEXIST;
 		kvm_for_each_memslot(slot, __kvm_memslots(kvm, as_id)) {
 			if (slot->id == id)
 				continue;
 			if (!((base_gfn + npages <= slot->base_gfn) ||
 			      (base_gfn >= slot->base_gfn + slot->npages)))
-				goto out;
+				return -EEXIST;
 		}
 	}
 
-	r = -ENOMEM;
-
 	/* Allocate/free page dirty bitmap as needed */
 	if (!(new.flags & KVM_MEM_LOG_DIRTY_PAGES))
 		new.dirty_bitmap = NULL;
 	else if (!new.dirty_bitmap) {
-		if (kvm_create_dirty_bitmap(&new) < 0)
-			goto out;
+		r = kvm_create_dirty_bitmap(&new);
+		if (r)
+			return r;
 	}
 
 	slots = kvzalloc(sizeof(struct kvm_memslots), GFP_KERNEL_ACCOUNT);
-	if (!slots)
+	if (!slots) {
+		r = -ENOMEM;
 		goto out_bitmap;
+	}
 	memcpy(slots, __kvm_memslots(kvm, as_id), sizeof(struct kvm_memslots));
 
 	if ((change == KVM_MR_DELETE) || (change == KVM_MR_MOVE)) {
@@ -1069,7 +1066,6 @@ int __kvm_set_memory_region(struct kvm *kvm,
 out_bitmap:
 	if (new.dirty_bitmap && !old.dirty_bitmap)
 		kvm_destroy_dirty_bitmap(&new);
-out:
 	return r;
 }
 EXPORT_SYMBOL_GPL(__kvm_set_memory_region);
-- 
2.22.0

