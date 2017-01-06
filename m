Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jan 2017 02:44:14 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:32156 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993136AbdAFBdyLSNDu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Jan 2017 02:33:54 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 27BDB1CF2D54C;
        Fri,  6 Jan 2017 01:33:47 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 6 Jan 2017 01:33:47 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 25/30] KVM: MIPS: Drop vm_init() callback
Date:   Fri, 6 Jan 2017 01:32:57 +0000
Message-ID: <8057f963338fe0fda37fe34783e17eb2d84d46a4.1483665879.git-series.james.hogan@imgtec.com>
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
X-archive-position: 56199
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

Now that the commpage doesn't use wired TLB entries, the per-CPU
vm_init() callback is the only work done by kvm_mips_init_vm_percpu().

The trap & emulate implementation doesn't actually need to do anything
from vm_init(), and the future VZ implementation would be better served
by a kvm_arch_hardware_enable callback anyway.

Therefore drop the vm_init() callback entirely, allowing the
kvm_mips_init_vm_percpu() function to also be dropped, along with the
kvm_mips_instance atomic counter.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h |  3 ---
 arch/mips/kvm/mips.c             | 16 ----------------
 arch/mips/kvm/tlb.c              |  3 ---
 arch/mips/kvm/trap_emul.c        |  6 ------
 4 files changed, 0 insertions(+), 28 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 667bf34b91f7..f4e9bb04350e 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -121,8 +121,6 @@ static inline bool kvm_is_error_hva(unsigned long addr)
 	return IS_ERR_VALUE(addr);
 }
 
-extern atomic_t kvm_mips_instance;
-
 struct kvm_vm_stat {
 	ulong remote_tlb_flush;
 };
@@ -528,7 +526,6 @@ struct kvm_mips_callbacks {
 	int (*handle_msa_fpe)(struct kvm_vcpu *vcpu);
 	int (*handle_fpe)(struct kvm_vcpu *vcpu);
 	int (*handle_msa_disabled)(struct kvm_vcpu *vcpu);
-	int (*vm_init)(struct kvm *kvm);
 	int (*vcpu_init)(struct kvm_vcpu *vcpu);
 	void (*vcpu_uninit)(struct kvm_vcpu *vcpu);
 	int (*vcpu_setup)(struct kvm_vcpu *vcpu);
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 09fcfde0a9db..001349124bad 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -92,22 +92,8 @@ void kvm_arch_check_processor_compat(void *rtn)
 	*(int *)rtn = 0;
 }
 
-static void kvm_mips_init_vm_percpu(void *arg)
-{
-	struct kvm *kvm = (struct kvm *)arg;
-
-	kvm_mips_callbacks->vm_init(kvm);
-
-}
-
 int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 {
-	if (atomic_inc_return(&kvm_mips_instance) == 1) {
-		kvm_debug("%s: 1st KVM instance, setup host TLB parameters\n",
-			  __func__);
-		on_each_cpu(kvm_mips_init_vm_percpu, kvm, 1);
-	}
-
 	return 0;
 }
 
@@ -150,8 +136,6 @@ void kvm_mips_free_vcpus(struct kvm *kvm)
 void kvm_arch_destroy_vm(struct kvm *kvm)
 {
 	kvm_mips_free_vcpus(kvm);
-
-	atomic_dec(&kvm_mips_instance);
 }
 
 long kvm_arch_dev_ioctl(struct file *filp, unsigned int ioctl,
diff --git a/arch/mips/kvm/tlb.c b/arch/mips/kvm/tlb.c
index 9bcab0dc827b..22b17207b3b7 100644
--- a/arch/mips/kvm/tlb.c
+++ b/arch/mips/kvm/tlb.c
@@ -33,9 +33,6 @@
 #define KVM_GUEST_PC_TLB    0
 #define KVM_GUEST_SP_TLB    1
 
-atomic_t kvm_mips_instance;
-EXPORT_SYMBOL_GPL(kvm_mips_instance);
-
 static u32 kvm_mips_get_kernel_asid(struct kvm_vcpu *vcpu)
 {
 	struct mm_struct *kern_mm = &vcpu->arch.guest_kernel_mm;
diff --git a/arch/mips/kvm/trap_emul.c b/arch/mips/kvm/trap_emul.c
index 7ef7b77834ed..087f73dfec9f 100644
--- a/arch/mips/kvm/trap_emul.c
+++ b/arch/mips/kvm/trap_emul.c
@@ -429,11 +429,6 @@ static int kvm_trap_emul_handle_msa_disabled(struct kvm_vcpu *vcpu)
 	return ret;
 }
 
-static int kvm_trap_emul_vm_init(struct kvm *kvm)
-{
-	return 0;
-}
-
 static int kvm_trap_emul_vcpu_init(struct kvm_vcpu *vcpu)
 {
 	struct mm_struct *kern_mm = &vcpu->arch.guest_kernel_mm;
@@ -851,7 +846,6 @@ static struct kvm_mips_callbacks kvm_trap_emul_callbacks = {
 	.handle_fpe = kvm_trap_emul_handle_fpe,
 	.handle_msa_disabled = kvm_trap_emul_handle_msa_disabled,
 
-	.vm_init = kvm_trap_emul_vm_init,
 	.vcpu_init = kvm_trap_emul_vcpu_init,
 	.vcpu_uninit = kvm_trap_emul_vcpu_uninit,
 	.vcpu_setup = kvm_trap_emul_vcpu_setup,
-- 
git-series 0.8.10
