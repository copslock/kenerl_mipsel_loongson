Return-Path: <SRS0=Alrm=QM=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A3EC282D7
	for <linux-mips@archiver.kernel.org>; Tue,  5 Feb 2019 20:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9E2C2083B
	for <linux-mips@archiver.kernel.org>; Tue,  5 Feb 2019 20:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729373AbfBEUzP (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 5 Feb 2019 15:55:15 -0500
Received: from mga11.intel.com ([192.55.52.93]:26834 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729354AbfBEUzP (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Tue, 5 Feb 2019 15:55:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2019 12:55:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,336,1544515200"; 
   d="scan'208";a="297508903"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.14])
  by orsmga005.jf.intel.com with ESMTP; 05 Feb 2019 12:55:14 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        James Hogan <jhogan@kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org,
        linux-mips@vger.kernel.org, kvm-ppc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu,
        Xiao Guangrong <guangrong.xiao@gmail.com>
Subject: [PATCH v2 01/27] KVM: Call kvm_arch_memslots_updated() before updating memslots
Date:   Tue,  5 Feb 2019 12:54:17 -0800
Message-Id: <20190205205443.1059-2-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190205205443.1059-1-sean.j.christopherson@intel.com>
References: <20190205205443.1059-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

kvm_arch_memslots_updated() is at this point in time an x86-specific
hook for handling MMIO generation wraparound.  x86 stashes 19 bits of
the memslots generation number in its MMIO sptes in order to avoid
full page fault walks for repeat faults on emulated MMIO addresses.
Because only 19 bits are used, wrapping the MMIO generation number is
possible, if unlikely.  kvm_arch_memslots_updated() alerts x86 that
the generation has changed so that it can invalidate all MMIO sptes in
case the effective MMIO generation has wrapped so as to avoid using a
stale spte, e.g. a (very) old spte that was created with generation==0.

Given that the purpose of kvm_arch_memslots_updated() is to prevent
consuming stale entries, it needs to be called before the new generation
is propagated to memslots.  Invalidating the MMIO sptes after updating
memslots means that there is a window where a vCPU could dereference
the new memslots generation, e.g. 0, and incorrectly reuse an old MMIO
spte that was created with (pre-wrap) generation==0.

Fixes: e59dbe09f8e6 ("KVM: Introduce kvm_arch_memslots_updated()")
Cc: <stable@vger.kernel.org>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/mips/include/asm/kvm_host.h    | 2 +-
 arch/powerpc/include/asm/kvm_host.h | 2 +-
 arch/s390/include/asm/kvm_host.h    | 2 +-
 arch/x86/include/asm/kvm_host.h     | 2 +-
 arch/x86/kvm/mmu.c                  | 4 ++--
 arch/x86/kvm/x86.c                  | 4 ++--
 include/linux/kvm_host.h            | 2 +-
 virt/kvm/arm/mmu.c                  | 2 +-
 virt/kvm/kvm_main.c                 | 7 +++++--
 9 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 71c3f21d80d5..f764a2de68e2 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -1131,7 +1131,7 @@ static inline void kvm_arch_hardware_unsetup(void) {}
 static inline void kvm_arch_sync_events(struct kvm *kvm) {}
 static inline void kvm_arch_free_memslot(struct kvm *kvm,
 		struct kvm_memory_slot *free, struct kvm_memory_slot *dont) {}
-static inline void kvm_arch_memslots_updated(struct kvm *kvm, struct kvm_memslots *slots) {}
+static inline void kvm_arch_memslots_updated(struct kvm *kvm, u64 gen) {}
 static inline void kvm_arch_sched_in(struct kvm_vcpu *vcpu, int cpu) {}
 static inline void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu) {}
 static inline void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu) {}
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 0f98f00da2ea..19693b8add93 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -837,7 +837,7 @@ struct kvm_vcpu_arch {
 static inline void kvm_arch_hardware_disable(void) {}
 static inline void kvm_arch_hardware_unsetup(void) {}
 static inline void kvm_arch_sync_events(struct kvm *kvm) {}
-static inline void kvm_arch_memslots_updated(struct kvm *kvm, struct kvm_memslots *slots) {}
+static inline void kvm_arch_memslots_updated(struct kvm *kvm, u64 gen) {}
 static inline void kvm_arch_flush_shadow_all(struct kvm *kvm) {}
 static inline void kvm_arch_sched_in(struct kvm_vcpu *vcpu, int cpu) {}
 static inline void kvm_arch_exit(void) {}
diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index d5d24889c3bc..c2b8c8c6c9be 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -878,7 +878,7 @@ static inline void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu) {}
 static inline void kvm_arch_sched_in(struct kvm_vcpu *vcpu, int cpu) {}
 static inline void kvm_arch_free_memslot(struct kvm *kvm,
 		struct kvm_memory_slot *free, struct kvm_memory_slot *dont) {}
-static inline void kvm_arch_memslots_updated(struct kvm *kvm, struct kvm_memslots *slots) {}
+static inline void kvm_arch_memslots_updated(struct kvm *kvm, u64 gen) {}
 static inline void kvm_arch_flush_shadow_all(struct kvm *kvm) {}
 static inline void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
 		struct kvm_memory_slot *slot) {}
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 4660ce90de7f..1c7f726e3ad5 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1253,7 +1253,7 @@ void kvm_mmu_clear_dirty_pt_masked(struct kvm *kvm,
 				   struct kvm_memory_slot *slot,
 				   gfn_t gfn_offset, unsigned long mask);
 void kvm_mmu_zap_all(struct kvm *kvm);
-void kvm_mmu_invalidate_mmio_sptes(struct kvm *kvm, struct kvm_memslots *slots);
+void kvm_mmu_invalidate_mmio_sptes(struct kvm *kvm, u64 gen);
 unsigned int kvm_mmu_calculate_mmu_pages(struct kvm *kvm);
 void kvm_mmu_change_mmu_pages(struct kvm *kvm, unsigned int kvm_nr_mmu_pages);
 
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index ce770b446238..fb040ea42454 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -5890,13 +5890,13 @@ static bool kvm_has_zapped_obsolete_pages(struct kvm *kvm)
 	return unlikely(!list_empty_careful(&kvm->arch.zapped_obsolete_pages));
 }
 
-void kvm_mmu_invalidate_mmio_sptes(struct kvm *kvm, struct kvm_memslots *slots)
+void kvm_mmu_invalidate_mmio_sptes(struct kvm *kvm, u64 gen)
 {
 	/*
 	 * The very rare case: if the generation-number is round,
 	 * zap all shadow pages.
 	 */
-	if (unlikely((slots->generation & MMIO_GEN_MASK) == 0)) {
+	if (unlikely((gen & MMIO_GEN_MASK) == 0)) {
 		kvm_debug_ratelimited("kvm: zapping shadow pages for mmio generation wraparound\n");
 		kvm_mmu_invalidate_zap_all_pages(kvm);
 	}
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 9ce1b8e2d3b9..4d05fca04fe1 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9337,13 +9337,13 @@ int kvm_arch_create_memslot(struct kvm *kvm, struct kvm_memory_slot *slot,
 	return -ENOMEM;
 }
 
-void kvm_arch_memslots_updated(struct kvm *kvm, struct kvm_memslots *slots)
+void kvm_arch_memslots_updated(struct kvm *kvm, u64 gen)
 {
 	/*
 	 * memslots->generation has been incremented.
 	 * mmio generation may have reached its maximum value.
 	 */
-	kvm_mmu_invalidate_mmio_sptes(kvm, slots);
+	kvm_mmu_invalidate_mmio_sptes(kvm, gen);
 }
 
 int kvm_arch_prepare_memory_region(struct kvm *kvm,
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index c38cc5eb7e73..cf761ff58224 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -634,7 +634,7 @@ void kvm_arch_free_memslot(struct kvm *kvm, struct kvm_memory_slot *free,
 			   struct kvm_memory_slot *dont);
 int kvm_arch_create_memslot(struct kvm *kvm, struct kvm_memory_slot *slot,
 			    unsigned long npages);
-void kvm_arch_memslots_updated(struct kvm *kvm, struct kvm_memslots *slots);
+void kvm_arch_memslots_updated(struct kvm *kvm, u64 gen);
 int kvm_arch_prepare_memory_region(struct kvm *kvm,
 				struct kvm_memory_slot *memslot,
 				const struct kvm_userspace_memory_region *mem,
diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index 3053bf2584f8..3ab0daee3fea 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -2350,7 +2350,7 @@ int kvm_arch_create_memslot(struct kvm *kvm, struct kvm_memory_slot *slot,
 	return 0;
 }
 
-void kvm_arch_memslots_updated(struct kvm *kvm, struct kvm_memslots *slots)
+void kvm_arch_memslots_updated(struct kvm *kvm, u64 gen)
 {
 }
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index cf7cc0554094..df5dc7224f02 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -878,6 +878,7 @@ static struct kvm_memslots *install_new_memslots(struct kvm *kvm,
 		int as_id, struct kvm_memslots *slots)
 {
 	struct kvm_memslots *old_memslots = __kvm_memslots(kvm, as_id);
+	u64 gen;
 
 	/*
 	 * Set the low bit in the generation, which disables SPTE caching
@@ -900,9 +901,11 @@ static struct kvm_memslots *install_new_memslots(struct kvm *kvm,
 	 * space 0 will use generations 0, 4, 8, ... while * address space 1 will
 	 * use generations 2, 6, 10, 14, ...
 	 */
-	slots->generation += KVM_ADDRESS_SPACE_NUM * 2 - 1;
+	gen = slots->generation + KVM_ADDRESS_SPACE_NUM * 2 - 1;
 
-	kvm_arch_memslots_updated(kvm, slots);
+	kvm_arch_memslots_updated(kvm, gen);
+
+	slots->generation = gen;
 
 	return old_memslots;
 }
-- 
2.20.1

