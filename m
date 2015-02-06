From: James Hogan <james.hogan@imgtec.com>
Date: Fri, 6 Feb 2015 11:11:56 +0000
Subject: MIPS: KVM: Handle MSA Disabled exceptions from guest
Message-ID: <20150206111156.aNhBYj5vzH65r3jaTbnWeqiAUiQxhTuNDktfkXxnDlM@z>

commit 98119ad53376885819d93dfb8737b6a9a61ca0ba upstream.

Guest user mode can generate a guest MSA Disabled exception on an MSA
capable core by simply trying to execute an MSA instruction. Since this
exception is unknown to KVM it will be passed on to the guest kernel.
However guest Linux kernels prior to v3.15 do not set up an exception
handler for the MSA Disabled exception as they don't support any MSA
capable cores. This results in a guest OS panic.

Since an older processor ID may be being emulated, and MSA support is
not advertised to the guest, the correct behaviour is to generate a
Reserved Instruction exception in the guest kernel so it can send the
guest process an illegal instruction signal (SIGILL), as would happen
with a non-MSA-capable core.

Fix this as minimally as reasonably possible by preventing
kvm_mips_check_privilege() from relaying MSA Disabled exceptions from
guest user mode to the guest kernel, and handling the MSA Disabled
exception by emulating a Reserved Instruction exception in the guest,
via a new handle_msa_disabled() KVM callback.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
[ luis: backported to 3.16: files renamed:
  - arch/mips/kvm/emulate.c -> arch/mips/kvm/kvm_mips_emul.c
  - arch/mips/kvm/mips.c -> arch/mips/kvm/kvm_mips.c]
Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 arch/mips/include/asm/kvm_host.h |  2 ++
 arch/mips/kvm/kvm_mips.c         |  4 ++++
 arch/mips/kvm/kvm_mips_emul.c    |  1 +
 arch/mips/kvm/kvm_trap_emul.c    | 28 ++++++++++++++++++++++++++++
 4 files changed, 35 insertions(+)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index b0aa95565752..5a8defbad431 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -326,6 +326,7 @@ enum mips_mmu_types {
 #define T_TRAP			13	/* Trap instruction */
 #define T_VCEI			14	/* Virtual coherency exception */
 #define T_FPE			15	/* Floating point exception */
+#define T_MSADIS		21	/* MSA disabled exception */
 #define T_WATCH			23	/* Watch address reference */
 #define T_VCED			31	/* Virtual coherency data */

@@ -578,6 +579,7 @@ struct kvm_mips_callbacks {
 	int (*handle_syscall)(struct kvm_vcpu *vcpu);
 	int (*handle_res_inst)(struct kvm_vcpu *vcpu);
 	int (*handle_break)(struct kvm_vcpu *vcpu);
+	int (*handle_msa_disabled)(struct kvm_vcpu *vcpu);
 	int (*vm_init)(struct kvm *kvm);
 	int (*vcpu_init)(struct kvm_vcpu *vcpu);
 	int (*vcpu_setup)(struct kvm_vcpu *vcpu);
diff --git a/arch/mips/kvm/kvm_mips.c b/arch/mips/kvm/kvm_mips.c
index d84f96e51349..59298b97ac39 100644
--- a/arch/mips/kvm/kvm_mips.c
+++ b/arch/mips/kvm/kvm_mips.c
@@ -1156,6 +1156,10 @@ int kvm_mips_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu)
 		ret = kvm_mips_callbacks->handle_break(vcpu);
 		break;

+	case T_MSADIS:
+		ret = kvm_mips_callbacks->handle_msa_disabled(vcpu);
+		break;
+
 	default:
 		kvm_err
 		    ("Exception Code: %d, not yet handled, @ PC: %p, inst: 0x%08x  BadVaddr: %#lx Status: %#lx\n",
diff --git a/arch/mips/kvm/kvm_mips_emul.c b/arch/mips/kvm/kvm_mips_emul.c
index 8d4840090082..2071472bc3c4 100644
--- a/arch/mips/kvm/kvm_mips_emul.c
+++ b/arch/mips/kvm/kvm_mips_emul.c
@@ -2204,6 +2204,7 @@ kvm_mips_check_privilege(unsigned long cause, uint32_t *opc,
 		case T_SYSCALL:
 		case T_BREAK:
 		case T_RES_INST:
+		case T_MSADIS:
 			break;

 		case T_COP_UNUSABLE:
diff --git a/arch/mips/kvm/kvm_trap_emul.c b/arch/mips/kvm/kvm_trap_emul.c
index 693f952b2fbb..0c521c356553 100644
--- a/arch/mips/kvm/kvm_trap_emul.c
+++ b/arch/mips/kvm/kvm_trap_emul.c
@@ -333,6 +333,33 @@ static int kvm_trap_emul_handle_break(struct kvm_vcpu *vcpu)
 	return ret;
 }

+static int kvm_trap_emul_handle_msa_disabled(struct kvm_vcpu *vcpu)
+{
+	struct kvm_run *run = vcpu->run;
+	uint32_t __user *opc = (uint32_t __user *) vcpu->arch.pc;
+	unsigned long cause = vcpu->arch.host_cp0_cause;
+	enum emulation_result er = EMULATE_DONE;
+	int ret = RESUME_GUEST;
+
+	/* No MSA supported in guest, guest reserved instruction exception */
+	er = kvm_mips_emulate_ri_exc(cause, opc, run, vcpu);
+
+	switch (er) {
+	case EMULATE_DONE:
+		ret = RESUME_GUEST;
+		break;
+
+	case EMULATE_FAIL:
+		run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
+		ret = RESUME_HOST;
+		break;
+
+	default:
+		BUG();
+	}
+	return ret;
+}
+
 static int kvm_trap_emul_vm_init(struct kvm *kvm)
 {
 	return 0;
@@ -472,6 +499,7 @@ static struct kvm_mips_callbacks kvm_trap_emul_callbacks = {
 	.handle_syscall = kvm_trap_emul_handle_syscall,
 	.handle_res_inst = kvm_trap_emul_handle_res_inst,
 	.handle_break = kvm_trap_emul_handle_break,
+	.handle_msa_disabled = kvm_trap_emul_handle_msa_disabled,

 	.vm_init = kvm_trap_emul_vm_init,
 	.vcpu_init = kvm_trap_emul_vcpu_init,
