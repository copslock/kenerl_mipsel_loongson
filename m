From: James Hogan <james.hogan@imgtec.com>
Date: Thu, 18 Aug 2016 10:22:54 +0100
Subject: [PATCH BACKPORT 3.10-3.15 3/4] MIPS: KVM: Fix gfn range check in kseg0 tlb faults
To: <stable@vger.kernel.org>
Cc: James Hogan <james.hogan@imgtec.com>, Paolo Bonzini <pbonzini@redhat.com>, Radim Krčmář <rkrcmar@redhat.com>, Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Message-ID:
 <86ad47b80d7285bab4b9bb144764d4ac1d4d1adf.1471021142.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20160818092254.sbMBsWnQ3_jg3mgqETuY896aFSEv4I0dxSxORTurvMU@z>

From: James Hogan <james.hogan@imgtec.com>

commit 0741f52d1b980dbeb290afe67d88fc2928edd8ab upstream.

Two consecutive gfns are loaded into host TLB, so ensure the range check
isn't off by one if guest_pmap_npages is odd.

Fixes: 858dd5d45733 ("KVM/MIPS32: MMU/TLB operations for the Guest.")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
[james.hogan@imgtec.com: Backport to v3.10.y - v3.15.y]
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/kvm/kvm_tlb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/kvm/kvm_tlb.c
+++ b/arch/mips/kvm/kvm_tlb.c
@@ -285,7 +285,7 @@ int kvm_mips_handle_kseg0_tlb_fault(unsi
 	}
 
 	gfn = (KVM_GUEST_CPHYSADDR(badvaddr) >> PAGE_SHIFT);
-	if (gfn >= kvm->arch.guest_pmap_npages) {
+	if ((gfn | 1) >= kvm->arch.guest_pmap_npages) {
 		kvm_err("%s: Invalid gfn: %#llx, BadVaddr: %#lx\n", __func__,
 			gfn, badvaddr);
 		kvm_mips_dump_host_tlbs();


Patches currently in stable-queue which might be from james.hogan@imgtec.com are

queue-3.14/mips-kvm-add-missing-gfn-range-check.patch
queue-3.14/mips-kvm-propagate-kseg0-mapped-tlb-fault-errors.patch
queue-3.14/mips-kvm-fix-mapped-fault-broken-commpage-handling.patch
queue-3.14/mips-kvm-fix-gfn-range-check-in-kseg0-tlb-faults.patch
