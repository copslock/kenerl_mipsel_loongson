Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Sep 2016 14:06:34 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:6959 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992800AbcITMGL5OYP6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Sep 2016 14:06:11 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 65091BE1188E1;
        Tue, 20 Sep 2016 13:05:49 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 20 Sep 2016 13:05:51 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     <kvm@vger.kernel.org>
CC:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, James Hogan <james.hogan@imgtec.com>
Subject: [PATCH 3/4] KVM: MIPS: Invalidate TLB by regenerating ASIDs
Date:   Tue, 20 Sep 2016 13:05:48 +0100
Message-ID: <ca78c803825f896d1de6c623c122f8dd13c8b102.1474372617.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.7.3
MIME-Version: 1.0
In-Reply-To: <cover.b4aaacd5414bd20c4eb4d53417956b268d69d1af.1474372617.git-series.james.hogan@imgtec.com>
References: <cover.b4aaacd5414bd20c4eb4d53417956b268d69d1af.1474372617.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55211
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

Invalidate host TLB mappings when the guest ASID is changed by
regenerating ASIDs, rather than flushing the entire host TLB except
entries in the guest KSeg0 range.

For the guest kernel mode ASID we regenerate on the spot when the guest
ASID is changed, as that will always take place while the guest is in
kernel mode.

However when the guest invalidates TLB entries the ASID will often by
changed temporarily as part of writing EntryHi without the guest
returning to user mode in between. We therefore regenerate the user mode
ASID lazily before entering the guest in user mode, if and only if the
guest ASID has actually changed since the last guest user mode entry.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h |  3 +++
 arch/mips/kvm/emulate.c          | 18 +++++++++++++-----
 arch/mips/kvm/mips.c             | 30 ++++++++++++++++++++++++++++++
 arch/mips/kvm/mmu.c              |  4 ++++
 4 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 4d7e0e466b5a..a5685c1adba2 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -328,6 +328,9 @@ struct kvm_vcpu_arch {
 	u32 guest_kernel_asid[NR_CPUS];
 	struct mm_struct guest_kernel_mm, guest_user_mm;
 
+	/* Guest ASID of last user mode execution */
+	unsigned int last_user_gasid;
+
 	int last_sched_cpu;
 
 	/* WAIT executed */
diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index 43853ec6e160..8dc9e64346e6 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -1170,15 +1170,23 @@ enum emulation_result kvm_mips_emulate_CP0(union mips_instruction inst,
 							& KVM_ENTRYHI_ASID,
 						nasid);
 
+					/*
+					 * Regenerate/invalidate kernel MMU
+					 * context.
+					 * The user MMU context will be
+					 * regenerated lazily on re-entry to
+					 * guest user if the guest ASID actually
+					 * changes.
+					 */
 					preempt_disable();
-					/* Blow away the shadow host TLBs */
-					kvm_mips_flush_host_tlb(1);
 					cpu = smp_processor_id();
+					kvm_get_new_mmu_context(&vcpu->arch.guest_kernel_mm,
+								cpu, vcpu);
+					vcpu->arch.guest_kernel_asid[cpu] =
+						vcpu->arch.guest_kernel_mm.context.asid[cpu];
 					for_each_possible_cpu(i)
-						if (i != cpu) {
-							vcpu->arch.guest_user_asid[i] = 0;
+						if (i != cpu)
 							vcpu->arch.guest_kernel_asid[i] = 0;
-						}
 					preempt_enable();
 				}
 				kvm_write_c0_guest_entryhi(cop0,
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index a6ea084b4d9d..ad1b15ba5907 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -411,6 +411,31 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 	return -ENOIOCTLCMD;
 }
 
+/* Must be called with preemption disabled, just before entering guest */
+static void kvm_mips_check_asids(struct kvm_vcpu *vcpu)
+{
+	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	int cpu = smp_processor_id();
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
+			kvm_get_new_mmu_context(&vcpu->arch.guest_user_mm, cpu,
+						vcpu);
+			vcpu->arch.guest_user_asid[cpu] =
+				vcpu->arch.guest_user_mm.context.asid[cpu];
+			vcpu->arch.last_user_gasid = gasid;
+		}
+	}
+}
+
 int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
 	int r = 0;
@@ -438,6 +463,9 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	htw_stop();
 
 	trace_kvm_enter(vcpu);
+
+	kvm_mips_check_asids(vcpu);
+
 	r = vcpu->arch.vcpu_run(run, vcpu);
 	trace_kvm_out(vcpu);
 
@@ -1551,6 +1579,8 @@ skip_emul:
 	if (ret == RESUME_GUEST) {
 		trace_kvm_reenter(vcpu);
 
+		kvm_mips_check_asids(vcpu);
+
 		/*
 		 * If FPU / MSA are enabled (i.e. the guest's FPU / MSA context
 		 * is live), restore FCR31 / MSACSR.
diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index 3b677c851be0..03883ba806e2 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -260,9 +260,13 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 
 	if ((vcpu->arch.guest_user_asid[cpu] ^ asid_cache(cpu)) &
 						asid_version_mask(cpu)) {
+		u32 gasid = kvm_read_c0_guest_entryhi(vcpu->arch.cop0) &
+				KVM_ENTRYHI_ASID;
+
 		kvm_get_new_mmu_context(&vcpu->arch.guest_user_mm, cpu, vcpu);
 		vcpu->arch.guest_user_asid[cpu] =
 		    vcpu->arch.guest_user_mm.context.asid[cpu];
+		vcpu->arch.last_user_gasid = gasid;
 		newasid++;
 
 		kvm_debug("[%d]: cpu_context: %#lx\n", cpu,
-- 
git-series 0.8.10
