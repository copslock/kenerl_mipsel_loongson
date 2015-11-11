From: James Hogan <james.hogan@imgtec.com>
Date: Wed, 11 Nov 2015 14:21:20 +0000
Subject: MIPS: KVM: Uninit VCPU in vcpu_create error path
Message-ID: <20151111142120.ZAvD6JcsAw_PeoOYn1M1JDEqVSbzKLEJZ3wy40j-9jw@z>

commit 585bb8f9a5e592f2ce7abbe5ed3112d5438d2754 upstream.

If either of the memory allocations in kvm_arch_vcpu_create() fail, the
vcpu which has been allocated and kvm_vcpu_init'd doesn't get uninit'd
in the error handling path. Add a call to kvm_vcpu_uninit() to fix this.

Fixes: 669e846e6c4e ("KVM/MIPS32: MIPS arch specific APIs for KVM")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[ luis: backported to 3.16:
  - file rename: mips.c -> kvm_mips.c ]
Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/kvm/kvm_mips.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kvm/kvm_mips.c b/arch/mips/kvm/kvm_mips.c
index 538abbf..054216b 100644
--- a/arch/mips/kvm/kvm_mips.c
+++ b/arch/mips/kvm/kvm_mips.c
@@ -315,7 +315,7 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm, unsigned int id)

 	if (!gebase) {
 		err = -ENOMEM;
-		goto out_free_cpu;
+		goto out_uninit_cpu;
 	}
 	kvm_info("Allocated %d bytes for KVM Exception Handlers @ %p\n",
 		 ALIGN(size, PAGE_SIZE), gebase);
@@ -375,6 +375,9 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm, unsigned int id)
 out_free_gebase:
 	kfree(gebase);

+out_uninit_cpu:
+	kvm_vcpu_uninit(vcpu);
+
 out_free_cpu:
 	kfree(vcpu);

--
1.9.1
