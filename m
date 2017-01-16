Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jan 2017 13:52:44 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:40873 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993884AbdAPMtz0u4Tk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Jan 2017 13:49:55 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 134F69DE348DE;
        Mon, 16 Jan 2017 12:49:44 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 16 Jan 2017 12:49:47 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 7/13] KVM: MIPS/MMU: Use generic dirty log & protect helper
Date:   Mon, 16 Jan 2017 12:49:28 +0000
Message-ID: <03ffe27f34192cd1b57695bff062bff86dcf705f.1484570878.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
In-Reply-To: <cover.99eec1b2ac935212acbcf2effacaab95cf6cdbf1.1484570878.git-series.james.hogan@imgtec.com>
References: <cover.99eec1b2ac935212acbcf2effacaab95cf6cdbf1.1484570878.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56326
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

MIPS hasn't up to this point properly supported dirty page logging, as
pages in slots with dirty logging enabled aren't made clean, and tlbmod
exceptions from writes to clean pages have been assumed to be due to
guest TLB protection and unconditionally passed to the guest.

Use the generic dirty logging helper kvm_get_dirty_log_protect() to
properly implement kvm_vm_ioctl_get_dirty_log(), similar to how ARM
does. This uses xchg to clear the dirty bits when reading them, rather
than wiping them out afterwards with a memset, which would potentially
wipe recently set bits that weren't caught by kvm_get_dirty_log(). It
also makes the pages clean again using the
kvm_arch_mmu_enable_log_dirty_pt_masked() architecture callback so that
further writes after the shadow memslot is flushed will trigger tlbmod
exceptions and dirty handling.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/Kconfig |  1 +
 arch/mips/kvm/mips.c  | 42 +++++++++++++++++++++++-------------------
 arch/mips/kvm/mmu.c   | 22 ++++++++++++++++++++++
 3 files changed, 46 insertions(+), 19 deletions(-)

diff --git a/arch/mips/kvm/Kconfig b/arch/mips/kvm/Kconfig
index 7c56d6b124d1..85c4593b634a 100644
--- a/arch/mips/kvm/Kconfig
+++ b/arch/mips/kvm/Kconfig
@@ -20,6 +20,7 @@ config KVM
 	select EXPORT_UASM
 	select PREEMPT_NOTIFIERS
 	select ANON_INODES
+	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
 	select KVM_MMIO
 	select SRCU
 	---help---
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index b0d9fe2176c0..bee7f5eabd4f 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -1091,42 +1091,46 @@ long kvm_arch_vcpu_ioctl(struct file *filp, unsigned int ioctl,
 	return r;
 }
 
-/* Get (and clear) the dirty memory log for a memory slot. */
+/**
+ * kvm_vm_ioctl_get_dirty_log - get and clear the log of dirty pages in a slot
+ * @kvm: kvm instance
+ * @log: slot id and address to which we copy the log
+ *
+ * Steps 1-4 below provide general overview of dirty page logging. See
+ * kvm_get_dirty_log_protect() function description for additional details.
+ *
+ * We call kvm_get_dirty_log_protect() to handle steps 1-3, upon return we
+ * always flush the TLB (step 4) even if previous step failed  and the dirty
+ * bitmap may be corrupt. Regardless of previous outcome the KVM logging API
+ * does not preclude user space subsequent dirty log read. Flushing TLB ensures
+ * writes will be marked dirty for next log read.
+ *
+ *   1. Take a snapshot of the bit and clear it if needed.
+ *   2. Write protect the corresponding page.
+ *   3. Copy the snapshot to the userspace.
+ *   4. Flush TLB's if needed.
+ */
 int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
 {
 	struct kvm_memslots *slots;
 	struct kvm_memory_slot *memslot;
-	unsigned long ga, ga_end;
-	int is_dirty = 0;
+	bool is_dirty = false;
 	int r;
-	unsigned long n;
 
 	mutex_lock(&kvm->slots_lock);
 
-	r = kvm_get_dirty_log(kvm, log, &is_dirty);
-	if (r)
-		goto out;
+	r = kvm_get_dirty_log_protect(kvm, log, &is_dirty);
 
-	/* If nothing is dirty, don't bother messing with page tables. */
 	if (is_dirty) {
 		slots = kvm_memslots(kvm);
 		memslot = id_to_memslot(slots, log->slot);
 
-		ga = memslot->base_gfn << PAGE_SHIFT;
-		ga_end = ga + (memslot->npages << PAGE_SHIFT);
-
-		kvm_info("%s: dirty, ga: %#lx, ga_end %#lx\n", __func__, ga,
-			 ga_end);
-
-		n = kvm_dirty_bitmap_bytes(memslot);
-		memset(memslot->dirty_bitmap, 0, n);
+		/* Let implementation handle TLB/GVA invalidation */
+		kvm_mips_callbacks->flush_shadow_memslot(kvm, memslot);
 	}
 
-	r = 0;
-out:
 	mutex_unlock(&kvm->slots_lock);
 	return r;
-
 }
 
 long kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index 892fd0ede718..63a6d542ecb3 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -429,6 +429,28 @@ int kvm_mips_mkclean_gpa_pt(struct kvm *kvm, gfn_t start_gfn, gfn_t end_gfn)
 }
 
 /**
+ * kvm_arch_mmu_enable_log_dirty_pt_masked() - write protect dirty pages
+ * @kvm:	The KVM pointer
+ * @slot:	The memory slot associated with mask
+ * @gfn_offset:	The gfn offset in memory slot
+ * @mask:	The mask of dirty pages at offset 'gfn_offset' in this memory
+ *		slot to be write protected
+ *
+ * Walks bits set in mask write protects the associated pte's. Caller must
+ * acquire @kvm->mmu_lock.
+ */
+void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
+		struct kvm_memory_slot *slot,
+		gfn_t gfn_offset, unsigned long mask)
+{
+	gfn_t base_gfn = slot->base_gfn + gfn_offset;
+	gfn_t start = base_gfn +  __ffs(mask);
+	gfn_t end = base_gfn + __fls(mask);
+
+	kvm_mips_mkclean_gpa_pt(kvm, start, end);
+}
+
+/**
  * kvm_mips_map_page() - Map a guest physical page.
  * @vcpu:		VCPU pointer.
  * @gpa:		Guest physical address of fault.
-- 
git-series 0.8.10
