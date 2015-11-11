From: James Hogan <james.hogan@imgtec.com>
Date: Wed, 11 Nov 2015 14:21:19 +0000
Subject: MIPS: KVM: Fix CACHE immediate offset sign extension
Message-ID: <20151111142119.ivtoOF1GdcIpXjrwfzMC3XtxJsF3e78D71RyGr9C8j4@z>

commit c5c2a3b998f1ff5a586f9d37e154070b8d550d17 upstream.

The immediate field of the CACHE instruction is signed, so ensure that
it gets sign extended by casting it to an int16_t rather than just
masking the low 16 bits.

Fixes: e685c689f3a8 ("KVM/MIPS32: Privileged instruction/target branch emulation.")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[ luis: backported to 3.16:
  - file rename: emulate.c -> kvm_mips_emul.c ]
Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 arch/mips/kvm/kvm_mips_emul.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kvm/kvm_mips_emul.c b/arch/mips/kvm/kvm_mips_emul.c
index 18b4e2fdae33..950229176c2f 100644
--- a/arch/mips/kvm/kvm_mips_emul.c
+++ b/arch/mips/kvm/kvm_mips_emul.c
@@ -1434,7 +1434,7 @@ kvm_mips_emulate_cache(uint32_t inst, uint32_t *opc, uint32_t cause,

 	base = (inst >> 21) & 0x1f;
 	op_inst = (inst >> 16) & 0x1f;
-	offset = inst & 0xffff;
+	offset = (int16_t)inst;
 	cache = (inst >> 16) & 0x3;
 	op = (inst >> 18) & 0x7;
