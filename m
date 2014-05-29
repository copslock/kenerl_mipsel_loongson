From: James Hogan <james.hogan@imgtec.com>
Date: Thu, 29 May 2014 10:16:32 +0100
Subject: MIPS: KVM: Deliver guest interrupts after local_irq_disable()
Message-ID: <20140529091632.qS1D75GaedG5Xe7buxl7xGYEcPLBMtvWTAW5y1Z5ALw@z>

commit 044f0f03eca0110e1835b2ea038a484b93950328 upstream.

When about to run the guest, deliver guest interrupts after disabling
host interrupts. This should prevent an hrtimer interrupt from being
handled after delivering guest interrupts, and therefore not delivering
the guest timer interrupt until after the next guest exit.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: kvm@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: Sanjay Lal <sanjayl@kymasys.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/kvm/kvm_mips.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kvm/kvm_mips.c b/arch/mips/kvm/kvm_mips.c
index 7a8b440..4d058a7 100644
--- a/arch/mips/kvm/kvm_mips.c
+++ b/arch/mips/kvm/kvm_mips.c
@@ -424,11 +424,11 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		vcpu->mmio_needed = 0;
 	}

+	local_irq_disable();
 	/* Check if we have any exceptions/interrupts pending */
 	kvm_mips_deliver_interrupts(vcpu,
 				    kvm_read_c0_guest_cause(vcpu->arch.cop0));

-	local_irq_disable();
 	kvm_guest_enter();

 	r = __kvm_mips_vcpu_run(run, vcpu);
--
1.9.1
