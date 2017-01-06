Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jan 2017 02:36:12 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:47222 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993003AbdAFBdm3dcFu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Jan 2017 02:33:42 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id E00E984571B58;
        Fri,  6 Jan 2017 01:33:34 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 6 Jan 2017 01:33:35 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 9/30] KVM: MIPS: Remove duplicated ASIDs from vcpu
Date:   Fri, 6 Jan 2017 01:32:41 +0000
Message-ID: <7fd9d82b60dd918c850e96ef49fb395c5fccb86c.1483665879.git-series.james.hogan@imgtec.com>
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
X-archive-position: 56180
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

The kvm_vcpu_arch structure contains both mm_structs for allocating MMU
contexts (primarily the ASID) but it also copies the resulting ASIDs
into guest_{user,kernel}_asid[] arrays which are referenced from uasm
generated code.

This duplication doesn't seem to serve any purpose, and it gets in the
way of generalising the ASID handling across guest kernel/user modes, so
lets just extract the ASID straight out of the mm_struct on demand, and
in fact there are convenient cpu_context() and cpu_asid() macros for
doing so.

To reduce the verbosity of this code we do also add kern_mm and user_mm
local variables where the kernel and user mm_structs are used.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h |  4 +---
 arch/mips/kvm/emulate.c          | 13 +++++++------
 arch/mips/kvm/entry.c            | 22 +++++++++++++---------
 arch/mips/kvm/mips.c             |  8 +++-----
 arch/mips/kvm/mmu.c              |  8 ++++----
 arch/mips/kvm/tlb.c              |  8 ++++----
 arch/mips/kvm/trap_emul.c        | 29 ++++++++++++-----------------
 7 files changed, 44 insertions(+), 48 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 1c70b5224151..923f81dc6115 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -321,9 +321,7 @@ struct kvm_vcpu_arch {
 	/* S/W Based TLB for guest */
 	struct kvm_mips_tlb guest_tlb[KVM_MIPS_GUEST_TLB_SIZE];
 
-	/* Cached guest kernel/user ASIDs */
-	u32 guest_user_asid[NR_CPUS];
-	u32 guest_kernel_asid[NR_CPUS];
+	/* Guest kernel/user [partial] mm */
 	struct mm_struct guest_kernel_mm, guest_user_mm;
 
 	/* Guest ASID of last user mode execution */
diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index aa0937423e28..060acc5b3378 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -856,6 +856,8 @@ enum emulation_result kvm_mips_emul_tlbr(struct kvm_vcpu *vcpu)
 static void kvm_mips_invalidate_guest_tlb(struct kvm_vcpu *vcpu,
 					  struct kvm_mips_tlb *tlb)
 {
+	struct mm_struct *kern_mm = &vcpu->arch.guest_kernel_mm;
+	struct mm_struct *user_mm = &vcpu->arch.guest_user_mm;
 	int cpu, i;
 	bool user;
 
@@ -879,8 +881,8 @@ static void kvm_mips_invalidate_guest_tlb(struct kvm_vcpu *vcpu,
 		if (i == cpu)
 			continue;
 		if (user)
-			vcpu->arch.guest_user_asid[i] = 0;
-		vcpu->arch.guest_kernel_asid[i] = 0;
+			cpu_context(i, user_mm) = 0;
+		cpu_context(i, kern_mm) = 0;
 	}
 
 	preempt_enable();
@@ -1056,6 +1058,7 @@ enum emulation_result kvm_mips_emulate_CP0(union mips_instruction inst,
 					   struct kvm_vcpu *vcpu)
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct mm_struct *kern_mm = &vcpu->arch.guest_kernel_mm;
 	enum emulation_result er = EMULATE_DONE;
 	u32 rt, rd, sel;
 	unsigned long curr_pc;
@@ -1178,13 +1181,11 @@ enum emulation_result kvm_mips_emulate_CP0(union mips_instruction inst,
 					 */
 					preempt_disable();
 					cpu = smp_processor_id();
-					kvm_get_new_mmu_context(&vcpu->arch.guest_kernel_mm,
+					kvm_get_new_mmu_context(kern_mm,
 								cpu, vcpu);
-					vcpu->arch.guest_kernel_asid[cpu] =
-						vcpu->arch.guest_kernel_mm.context.asid[cpu];
 					for_each_possible_cpu(i)
 						if (i != cpu)
-							vcpu->arch.guest_kernel_asid[i] = 0;
+							cpu_context(i, kern_mm) = 0;
 					preempt_enable();
 				}
 				kvm_write_c0_guest_entryhi(cop0,
diff --git a/arch/mips/kvm/entry.c b/arch/mips/kvm/entry.c
index e92fb190e2d6..f81888704caa 100644
--- a/arch/mips/kvm/entry.c
+++ b/arch/mips/kvm/entry.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/kvm_host.h>
+#include <linux/log2.h>
 #include <asm/msa.h>
 #include <asm/setup.h>
 #include <asm/uasm.h>
@@ -286,23 +287,26 @@ static void *kvm_mips_build_enter_guest(void *addr)
 	uasm_i_andi(&p, T0, T0, KSU_USER | ST0_ERL | ST0_EXL);
 	uasm_i_xori(&p, T0, T0, KSU_USER);
 	uasm_il_bnez(&p, &r, T0, label_kernel_asid);
-	 UASM_i_ADDIU(&p, T1, K1,
-		      offsetof(struct kvm_vcpu_arch, guest_kernel_asid));
+	 UASM_i_ADDIU(&p, T1, K1, offsetof(struct kvm_vcpu_arch,
+					   guest_kernel_mm.context.asid));
 	/* else user */
-	UASM_i_ADDIU(&p, T1, K1,
-		     offsetof(struct kvm_vcpu_arch, guest_user_asid));
+	UASM_i_ADDIU(&p, T1, K1, offsetof(struct kvm_vcpu_arch,
+					  guest_user_mm.context.asid));
 	uasm_l_kernel_asid(&l, p);
 
 	/* t1: contains the base of the ASID array, need to get the cpu id  */
 	/* smp_processor_id */
 	uasm_i_lw(&p, T2, offsetof(struct thread_info, cpu), GP);
-	/* x4 */
-	uasm_i_sll(&p, T2, T2, 2);
+	/* index the ASID array */
+	uasm_i_sll(&p, T2, T2, ilog2(sizeof(long)));
 	UASM_i_ADDU(&p, T3, T1, T2);
-	uasm_i_lw(&p, K0, 0, T3);
+	UASM_i_LW(&p, K0, 0, T3);
 #ifdef CONFIG_MIPS_ASID_BITS_VARIABLE
-	/* x sizeof(struct cpuinfo_mips)/4 */
-	uasm_i_addiu(&p, T3, ZERO, sizeof(struct cpuinfo_mips)/4);
+	/*
+	 * reuse ASID array offset
+	 * cpuinfo_mips is a multiple of sizeof(long)
+	 */
+	uasm_i_addiu(&p, T3, ZERO, sizeof(struct cpuinfo_mips)/sizeof(long));
 	uasm_i_mul(&p, T2, T2, T3);
 
 	UASM_i_LA_mostly(&p, AT, (long)&cpu_data[0].asid_mask);
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index de32ce30c78c..155e1b36e87e 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -413,6 +413,7 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 /* Must be called with preemption disabled, just before entering guest */
 static void kvm_mips_check_asids(struct kvm_vcpu *vcpu)
 {
+	struct mm_struct *user_mm = &vcpu->arch.guest_user_mm;
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	int i, cpu = smp_processor_id();
 	unsigned int gasid;
@@ -426,13 +427,10 @@ static void kvm_mips_check_asids(struct kvm_vcpu *vcpu)
 	if (!KVM_GUEST_KERNEL_MODE(vcpu)) {
 		gasid = kvm_read_c0_guest_entryhi(cop0) & KVM_ENTRYHI_ASID;
 		if (gasid != vcpu->arch.last_user_gasid) {
-			kvm_get_new_mmu_context(&vcpu->arch.guest_user_mm, cpu,
-						vcpu);
-			vcpu->arch.guest_user_asid[cpu] =
-				vcpu->arch.guest_user_mm.context.asid[cpu];
+			kvm_get_new_mmu_context(user_mm, cpu, vcpu);
 			for_each_possible_cpu(i)
 				if (i != cpu)
-					vcpu->arch.guest_user_asid[cpu] = 0;
+					cpu_context(i, user_mm) = 0;
 			vcpu->arch.last_user_gasid = gasid;
 		}
 	}
diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index df013538113f..27d6d0dbfeb4 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -15,18 +15,18 @@
 
 static u32 kvm_mips_get_kernel_asid(struct kvm_vcpu *vcpu)
 {
+	struct mm_struct *kern_mm = &vcpu->arch.guest_kernel_mm;
 	int cpu = smp_processor_id();
 
-	return vcpu->arch.guest_kernel_asid[cpu] &
-			cpu_asid_mask(&cpu_data[cpu]);
+	return cpu_asid(cpu, kern_mm);
 }
 
 static u32 kvm_mips_get_user_asid(struct kvm_vcpu *vcpu)
 {
+	struct mm_struct *user_mm = &vcpu->arch.guest_user_mm;
 	int cpu = smp_processor_id();
 
-	return vcpu->arch.guest_user_asid[cpu] &
-			cpu_asid_mask(&cpu_data[cpu]);
+	return cpu_asid(cpu, user_mm);
 }
 
 static int kvm_mips_map_page(struct kvm *kvm, gfn_t gfn)
diff --git a/arch/mips/kvm/tlb.c b/arch/mips/kvm/tlb.c
index 254377d8e0b9..ba490130b5e7 100644
--- a/arch/mips/kvm/tlb.c
+++ b/arch/mips/kvm/tlb.c
@@ -38,18 +38,18 @@ EXPORT_SYMBOL_GPL(kvm_mips_instance);
 
 static u32 kvm_mips_get_kernel_asid(struct kvm_vcpu *vcpu)
 {
+	struct mm_struct *kern_mm = &vcpu->arch.guest_kernel_mm;
 	int cpu = smp_processor_id();
 
-	return vcpu->arch.guest_kernel_asid[cpu] &
-			cpu_asid_mask(&cpu_data[cpu]);
+	return cpu_asid(cpu, kern_mm);
 }
 
 static u32 kvm_mips_get_user_asid(struct kvm_vcpu *vcpu)
 {
+	struct mm_struct *user_mm = &vcpu->arch.guest_user_mm;
 	int cpu = smp_processor_id();
 
-	return vcpu->arch.guest_user_asid[cpu] &
-			cpu_asid_mask(&cpu_data[cpu]);
+	return cpu_asid(cpu, user_mm);
 }
 
 inline u32 kvm_mips_get_commpage_asid(struct kvm_vcpu *vcpu)
diff --git a/arch/mips/kvm/trap_emul.c b/arch/mips/kvm/trap_emul.c
index 494a90221b5e..c7854d32fd64 100644
--- a/arch/mips/kvm/trap_emul.c
+++ b/arch/mips/kvm/trap_emul.c
@@ -635,32 +635,29 @@ static int kvm_trap_emul_set_one_reg(struct kvm_vcpu *vcpu,
 
 static int kvm_trap_emul_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
-	unsigned long asid_mask = cpu_asid_mask(&cpu_data[cpu]);
+	struct mm_struct *kern_mm = &vcpu->arch.guest_kernel_mm;
+	struct mm_struct *user_mm = &vcpu->arch.guest_user_mm;
 
 	/* Allocate new kernel and user ASIDs if needed */
 
-	if ((vcpu->arch.guest_kernel_asid[cpu] ^ asid_cache(cpu)) &
+	if ((cpu_context(cpu, kern_mm) ^ asid_cache(cpu)) &
 						asid_version_mask(cpu)) {
-		kvm_get_new_mmu_context(&vcpu->arch.guest_kernel_mm, cpu, vcpu);
-		vcpu->arch.guest_kernel_asid[cpu] =
-		    vcpu->arch.guest_kernel_mm.context.asid[cpu];
+		kvm_get_new_mmu_context(kern_mm, cpu, vcpu);
 
 		kvm_debug("[%d]: cpu_context: %#lx\n", cpu,
 			  cpu_context(cpu, current->mm));
-		kvm_debug("[%d]: Allocated new ASID for Guest Kernel: %#x\n",
-			  cpu, vcpu->arch.guest_kernel_asid[cpu]);
+		kvm_debug("[%d]: Allocated new ASID for Guest Kernel: %#lx\n",
+			  cpu, cpu_context(cpu, kern_mm));
 	}
 
-	if ((vcpu->arch.guest_user_asid[cpu] ^ asid_cache(cpu)) &
+	if ((cpu_context(cpu, user_mm) ^ asid_cache(cpu)) &
 						asid_version_mask(cpu)) {
-		kvm_get_new_mmu_context(&vcpu->arch.guest_user_mm, cpu, vcpu);
-		vcpu->arch.guest_user_asid[cpu] =
-		    vcpu->arch.guest_user_mm.context.asid[cpu];
+		kvm_get_new_mmu_context(user_mm, cpu, vcpu);
 
 		kvm_debug("[%d]: cpu_context: %#lx\n", cpu,
 			  cpu_context(cpu, current->mm));
-		kvm_debug("[%d]: Allocated new ASID for Guest User: %#x\n", cpu,
-			  vcpu->arch.guest_user_asid[cpu]);
+		kvm_debug("[%d]: Allocated new ASID for Guest User: %#lx\n",
+			  cpu, cpu_context(cpu, user_mm));
 	}
 
 	/*
@@ -670,11 +667,9 @@ static int kvm_trap_emul_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	 */
 	if (current->flags & PF_VCPU) {
 		if (KVM_GUEST_KERNEL_MODE(vcpu))
-			write_c0_entryhi(vcpu->arch.guest_kernel_asid[cpu] &
-					 asid_mask);
+			write_c0_entryhi(cpu_asid(cpu, kern_mm));
 		else
-			write_c0_entryhi(vcpu->arch.guest_user_asid[cpu] &
-					 asid_mask);
+			write_c0_entryhi(cpu_asid(cpu, user_mm));
 		ehb();
 	}
 
-- 
git-series 0.8.10
