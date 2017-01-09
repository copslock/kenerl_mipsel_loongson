Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jan 2017 21:57:33 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:38179 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993879AbdAIUxe63YjP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Jan 2017 21:53:34 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id D2C7672AD39E7;
        Mon,  9 Jan 2017 20:53:24 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 9 Jan 2017 20:53:28 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 10/10] KVM: MIPS: Implement kvm_arch_flush_shadow_all/memslot
Date:   Mon, 9 Jan 2017 20:52:02 +0000
Message-ID: <1d9e3a9ebcf4987aff26cbd64daf380db8465465.1483993967.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
In-Reply-To: <cover.4133d2f24fd73c1889a46ea05bb8924867b33747.1483993967.git-series.james.hogan@imgtec.com>
References: <cover.4133d2f24fd73c1889a46ea05bb8924867b33747.1483993967.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56245
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

Implement the kvm_arch_flush_shadow_all() and
kvm_arch_flush_shadow_memslot() KVM functions for MIPS to allow guest
physical mappings to be safely changed.

The general MIPS KVM code takes care of flushing of GPA page table
entries. kvm_arch_flush_shadow_all() flushes the whole GPA page table,
and is always called on the cleanup path so there is no need to acquire
the kvm->mmu_lock. kvm_arch_flush_shadow_memslot() flushes only the
range of mappings in the GPA page table corresponding to the slot being
flushed, and happens when memory regions are moved or deleted.

MIPS KVM implementation callbacks are added for handling the
implementation specific flushing of mappings derived from the GPA page
tables. These are implemented for trap_emul.c using
kvm_flush_remote_tlbs() which should now be functional, and will flush
the per-VCPU GVA page tables and ASIDS synchronously (before next
entering guest mode or directly accessing GVA space).

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h | 11 ++++++++---
 arch/mips/kvm/mips.c             | 26 ++++++++++++++++++++++++++
 arch/mips/kvm/trap_emul.c        | 14 ++++++++++++++
 3 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index de20a6da5a4d..c24c1c23196b 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -531,6 +531,14 @@ struct kvm_mips_callbacks {
 	int (*vcpu_init)(struct kvm_vcpu *vcpu);
 	void (*vcpu_uninit)(struct kvm_vcpu *vcpu);
 	int (*vcpu_setup)(struct kvm_vcpu *vcpu);
+	void (*flush_shadow_all)(struct kvm *kvm);
+	/*
+	 * Must take care of flushing any cached GPA PTEs (e.g. guest entries in
+	 * VZ root TLB, or T&E GVA page tables and corresponding root TLB
+	 * mappings).
+	 */
+	void (*flush_shadow_memslot)(struct kvm *kvm,
+				     const struct kvm_memory_slot *slot);
 	gpa_t (*gva_to_gpa)(gva_t gva);
 	void (*queue_timer_int)(struct kvm_vcpu *vcpu);
 	void (*dequeue_timer_int)(struct kvm_vcpu *vcpu);
@@ -824,9 +832,6 @@ static inline void kvm_arch_sync_events(struct kvm *kvm) {}
 static inline void kvm_arch_free_memslot(struct kvm *kvm,
 		struct kvm_memory_slot *free, struct kvm_memory_slot *dont) {}
 static inline void kvm_arch_memslots_updated(struct kvm *kvm, struct kvm_memslots *slots) {}
-static inline void kvm_arch_flush_shadow_all(struct kvm *kvm) {}
-static inline void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
-		struct kvm_memory_slot *slot) {}
 static inline void kvm_arch_sched_in(struct kvm_vcpu *vcpu, int cpu) {}
 static inline void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu) {}
 static inline void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu) {}
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 325e98367b30..b0d9fe2176c0 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -157,6 +157,32 @@ int kvm_arch_create_memslot(struct kvm *kvm, struct kvm_memory_slot *slot,
 	return 0;
 }
 
+void kvm_arch_flush_shadow_all(struct kvm *kvm)
+{
+	/* Flush whole GPA */
+	kvm_mips_flush_gpa_pt(kvm, 0, ~0);
+
+	/* Let implementation do the rest */
+	kvm_mips_callbacks->flush_shadow_all(kvm);
+}
+
+void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
+				   struct kvm_memory_slot *slot)
+{
+	/*
+	 * The slot has been made invalid (ready for moving or deletion), so we
+	 * need to ensure that it can no longer be accessed by any guest VCPUs.
+	 */
+
+	spin_lock(&kvm->mmu_lock);
+	/* Flush slot from GPA */
+	kvm_mips_flush_gpa_pt(kvm, slot->base_gfn,
+			      slot->base_gfn + slot->npages - 1);
+	/* Let implementation do the rest */
+	kvm_mips_callbacks->flush_shadow_memslot(kvm, slot);
+	spin_unlock(&kvm->mmu_lock);
+}
+
 int kvm_arch_prepare_memory_region(struct kvm *kvm,
 				   struct kvm_memory_slot *memslot,
 				   const struct kvm_userspace_memory_region *mem,
diff --git a/arch/mips/kvm/trap_emul.c b/arch/mips/kvm/trap_emul.c
index 2cc637ed9e95..a9a8c8e450e4 100644
--- a/arch/mips/kvm/trap_emul.c
+++ b/arch/mips/kvm/trap_emul.c
@@ -586,6 +586,18 @@ static int kvm_trap_emul_vcpu_setup(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
+static void kvm_trap_emul_flush_shadow_all(struct kvm *kvm)
+{
+	/* Flush GVA page tables and invalidate GVA ASIDs on all VCPUs */
+	kvm_flush_remote_tlbs(kvm);
+}
+
+static void kvm_trap_emul_flush_shadow_memslot(struct kvm *kvm,
+					const struct kvm_memory_slot *slot)
+{
+	kvm_trap_emul_flush_shadow_all(kvm);
+}
+
 static unsigned long kvm_trap_emul_num_regs(struct kvm_vcpu *vcpu)
 {
 	return 0;
@@ -967,6 +979,8 @@ static struct kvm_mips_callbacks kvm_trap_emul_callbacks = {
 	.vcpu_init = kvm_trap_emul_vcpu_init,
 	.vcpu_uninit = kvm_trap_emul_vcpu_uninit,
 	.vcpu_setup = kvm_trap_emul_vcpu_setup,
+	.flush_shadow_all = kvm_trap_emul_flush_shadow_all,
+	.flush_shadow_memslot = kvm_trap_emul_flush_shadow_memslot,
 	.gva_to_gpa = kvm_trap_emul_gva_to_gpa_cb,
 	.queue_timer_int = kvm_mips_queue_timer_int_cb,
 	.dequeue_timer_int = kvm_mips_dequeue_timer_int_cb,
-- 
git-series 0.8.10
