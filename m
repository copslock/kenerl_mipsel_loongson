Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jan 2017 02:37:31 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:10969 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993006AbdAFBdnK2vFu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Jan 2017 02:33:43 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id AEDDF6B5E1D7E;
        Fri,  6 Jan 2017 01:33:35 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 6 Jan 2017 01:33:36 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 10/30] KVM: MIPS: Add vcpu_run() & vcpu_reenter() callbacks
Date:   Fri, 6 Jan 2017 01:32:42 +0000
Message-ID: <2051dd34270234593dc176cb811b318329d0a704.1483665879.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
In-Reply-To: <cover.d6d201de414322ed2c1372e164254e6055ef7db9.1483665879.git-series.james.hogan@imgtec.com>
References: <cover.d6d201de414322ed2c1372e164254e6055ef7db9.1483665879.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56183
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

Add implementation callbacks for entering the guest (vcpu_run()) and
reentering the guest (vcpu_reenter()), allowing implementation specific
operations to be performed before entering the guest or after returning
to the host without cluttering kvm_arch_vcpu_ioctl_run().

This allows the T&E specific lazy user GVA flush to be moved into
trap_emul.c, along with disabling of the HTW. We also move
kvm_mips_deliver_interrupts() as VZ will need to restore the guest timer
state prior to delivering interrupts.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h |  2 +-
 arch/mips/kvm/mips.c             | 43 +-----------------------------
 arch/mips/kvm/trap_emul.c        | 48 +++++++++++++++++++++++++++++++++-
 3 files changed, 52 insertions(+), 41 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 923f81dc6115..9f319375835a 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -539,6 +539,8 @@ struct kvm_mips_callbacks {
 			   const struct kvm_one_reg *reg, s64 v);
 	int (*vcpu_load)(struct kvm_vcpu *vcpu, int cpu);
 	int (*vcpu_put)(struct kvm_vcpu *vcpu, int cpu);
+	int (*vcpu_run)(struct kvm_run *run, struct kvm_vcpu *vcpu);
+	void (*vcpu_reenter)(struct kvm_run *run, struct kvm_vcpu *vcpu);
 };
 extern struct kvm_mips_callbacks *kvm_mips_callbacks;
 int kvm_mips_emulation_init(struct kvm_mips_callbacks **install_callbacks);
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 155e1b36e87e..982fe31a952e 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -410,32 +410,6 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 	return -ENOIOCTLCMD;
 }
 
-/* Must be called with preemption disabled, just before entering guest */
-static void kvm_mips_check_asids(struct kvm_vcpu *vcpu)
-{
-	struct mm_struct *user_mm = &vcpu->arch.guest_user_mm;
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
-	int i, cpu = smp_processor_id();
-	unsigned int gasid;
-
-	/*
-	 * Lazy host ASID regeneration for guest user mode.
-	 * If the guest ASID has changed since the last guest usermode
-	 * execution, regenerate the host ASID so as to invalidate stale TLB
-	 * entries.
-	 */
-	if (!KVM_GUEST_KERNEL_MODE(vcpu)) {
-		gasid = kvm_read_c0_guest_entryhi(cop0) & KVM_ENTRYHI_ASID;
-		if (gasid != vcpu->arch.last_user_gasid) {
-			kvm_get_new_mmu_context(user_mm, cpu, vcpu);
-			for_each_possible_cpu(i)
-				if (i != cpu)
-					cpu_context(i, user_mm) = 0;
-			vcpu->arch.last_user_gasid = gasid;
-		}
-	}
-}
-
 int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
 	int r = 0;
@@ -453,25 +427,12 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	lose_fpu(1);
 
 	local_irq_disable();
-	/* Check if we have any exceptions/interrupts pending */
-	kvm_mips_deliver_interrupts(vcpu,
-				    kvm_read_c0_guest_cause(vcpu->arch.cop0));
-
 	guest_enter_irqoff();
-
-	/* Disable hardware page table walking while in guest */
-	htw_stop();
-
 	trace_kvm_enter(vcpu);
 
-	kvm_mips_check_asids(vcpu);
+	r = kvm_mips_callbacks->vcpu_run(run, vcpu);
 
-	r = vcpu->arch.vcpu_run(run, vcpu);
 	trace_kvm_out(vcpu);
-
-	/* Re-enable HTW before enabling interrupts */
-	htw_start();
-
 	guest_exit_irqoff();
 	local_irq_enable();
 
@@ -1575,7 +1536,7 @@ int kvm_mips_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu)
 	if (ret == RESUME_GUEST) {
 		trace_kvm_reenter(vcpu);
 
-		kvm_mips_check_asids(vcpu);
+		kvm_mips_callbacks->vcpu_reenter(run, vcpu);
 
 		/*
 		 * If FPU / MSA are enabled (i.e. the guest's FPU / MSA context
diff --git a/arch/mips/kvm/trap_emul.c b/arch/mips/kvm/trap_emul.c
index c7854d32fd64..92734d095c94 100644
--- a/arch/mips/kvm/trap_emul.c
+++ b/arch/mips/kvm/trap_emul.c
@@ -692,6 +692,52 @@ static int kvm_trap_emul_vcpu_put(struct kvm_vcpu *vcpu, int cpu)
 	return 0;
 }
 
+static void kvm_trap_emul_vcpu_reenter(struct kvm_run *run,
+				       struct kvm_vcpu *vcpu)
+{
+	struct mm_struct *user_mm = &vcpu->arch.guest_user_mm;
+	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	int i, cpu = smp_processor_id();
+	unsigned int gasid;
+
+	/*
+	 * Lazy host ASID regeneration for guest user mode.
+	 * If the guest ASID has changed since the last guest usermode
+	 * execution, regenerate the host ASID so as to invalidate stale TLB
+	 * entries.
+	 */
+	if (!KVM_GUEST_KERNEL_MODE(vcpu)) {
+		gasid = kvm_read_c0_guest_entryhi(cop0) & KVM_ENTRYHI_ASID;
+		if (gasid != vcpu->arch.last_user_gasid) {
+			kvm_get_new_mmu_context(user_mm, cpu, vcpu);
+			for_each_possible_cpu(i)
+				if (i != cpu)
+					cpu_context(i, user_mm) = 0;
+			vcpu->arch.last_user_gasid = gasid;
+		}
+	}
+}
+
+static int kvm_trap_emul_vcpu_run(struct kvm_run *run, struct kvm_vcpu *vcpu)
+{
+	int r;
+
+	/* Check if we have any exceptions/interrupts pending */
+	kvm_mips_deliver_interrupts(vcpu,
+				    kvm_read_c0_guest_cause(vcpu->arch.cop0));
+
+	kvm_trap_emul_vcpu_reenter(run, vcpu);
+
+	/* Disable hardware page table walking while in guest */
+	htw_stop();
+
+	r = vcpu->arch.vcpu_run(run, vcpu);
+
+	htw_start();
+
+	return r;
+}
+
 static struct kvm_mips_callbacks kvm_trap_emul_callbacks = {
 	/* exit handlers */
 	.handle_cop_unusable = kvm_trap_emul_handle_cop_unusable,
@@ -724,6 +770,8 @@ static struct kvm_mips_callbacks kvm_trap_emul_callbacks = {
 	.set_one_reg = kvm_trap_emul_set_one_reg,
 	.vcpu_load = kvm_trap_emul_vcpu_load,
 	.vcpu_put = kvm_trap_emul_vcpu_put,
+	.vcpu_run = kvm_trap_emul_vcpu_run,
+	.vcpu_reenter = kvm_trap_emul_vcpu_reenter,
 };
 
 int kvm_mips_emulation_init(struct kvm_mips_callbacks **install_callbacks)
-- 
git-series 0.8.10
