From: Nicholas Mc Guire <hofrat@osadl.org>
Date: Thu, 7 May 2015 14:47:50 +0200
Subject: MIPS: KVM: Do not sign extend on unsigned MMIO load
Message-ID: <20150507124750.5crJ_gnEDUP1yXqFD8fuyK1wT_jQDfjGKHSbp4NJSdQ@z>

commit ed9244e6c534612d2b5ae47feab2f55a0d4b4ced upstream.

Fix possible unintended sign extension in unsigned MMIO loads by casting
to uint16_t in the case of mmio_needed != 2.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Reviewed-by: James Hogan <james.hogan@imgtec.com>
Tested-by: James Hogan <james.hogan@imgtec.com>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/9985/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
[ luis: backported to 3.16:
  - file rename: emulate.c -> kvm_mips_emul.c ]
Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 arch/mips/kvm/kvm_mips_emul.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kvm/kvm_mips_emul.c b/arch/mips/kvm/kvm_mips_emul.c
index 2071472bc3c4..18b4e2fdae33 100644
--- a/arch/mips/kvm/kvm_mips_emul.c
+++ b/arch/mips/kvm/kvm_mips_emul.c
@@ -2130,7 +2130,7 @@ kvm_mips_complete_mmio_load(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		if (vcpu->mmio_needed == 2)
 			*gpr = *(int16_t *) run->mmio.data;
 		else
-			*gpr = *(int16_t *) run->mmio.data;
+			*gpr = *(uint16_t *)run->mmio.data;

 		break;
 	case 1:
