Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jan 2017 02:39:37 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:45625 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993066AbdAFBdoCso8u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Jan 2017 02:33:44 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 1EEECE3D3EE8;
        Fri,  6 Jan 2017 01:33:37 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 6 Jan 2017 01:33:37 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 12/30] KVM: MIPS/T&E: active_mm = init_mm in guest context
Date:   Fri, 6 Jan 2017 01:32:44 +0000
Message-ID: <2cb054b4510d0cd88605f1ec258843f86b83000b.1483665879.git-series.james.hogan@imgtec.com>
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
X-archive-position: 56188
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

Set init_mm as the active_mm and update mm_cpumask(current->mm) to
reflect that it isn't active when in guest context. This prevents cache
management code from attempting cache flushes on host virtual addresses
while in guest context, for example due to a cache management IPIs or
later when writing of dynamically translated code hits copy on write.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/trap_emul.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kvm/trap_emul.c b/arch/mips/kvm/trap_emul.c
index 3e1dbcbcea85..ab3750f6a768 100644
--- a/arch/mips/kvm/trap_emul.c
+++ b/arch/mips/kvm/trap_emul.c
@@ -670,6 +670,8 @@ static int kvm_trap_emul_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 			write_c0_entryhi(cpu_asid(cpu, kern_mm));
 		else
 			write_c0_entryhi(cpu_asid(cpu, user_mm));
+		cpumask_clear_cpu(cpu, mm_cpumask(current->active_mm));
+		current->active_mm = &init_mm;
 		ehb();
 	}
 
@@ -689,6 +691,8 @@ static int kvm_trap_emul_vcpu_put(struct kvm_vcpu *vcpu, int cpu)
 			get_new_mmu_context(current->mm, cpu);
 		}
 		write_c0_entryhi(cpu_asid(cpu, current->mm));
+		cpumask_set_cpu(cpu, mm_cpumask(current->mm));
+		current->active_mm = current->mm;
 		ehb();
 	}
 
@@ -723,7 +727,7 @@ static void kvm_trap_emul_vcpu_reenter(struct kvm_run *run,
 
 static int kvm_trap_emul_vcpu_run(struct kvm_run *run, struct kvm_vcpu *vcpu)
 {
-	int cpu;
+	int cpu = smp_processor_id();
 	int r;
 
 	/* Check if we have any exceptions/interrupts pending */
@@ -735,6 +739,14 @@ static int kvm_trap_emul_vcpu_run(struct kvm_run *run, struct kvm_vcpu *vcpu)
 	/* Disable hardware page table walking while in guest */
 	htw_stop();
 
+	/*
+	 * While in guest context we're in the guest's address space, not the
+	 * host process address space, so we need to be careful not to confuse
+	 * e.g. cache management IPIs.
+	 */
+	cpumask_clear_cpu(cpu, mm_cpumask(current->active_mm));
+	current->active_mm = &init_mm;
+
 	r = vcpu->arch.vcpu_run(run, vcpu);
 
 	/* We may have migrated while handling guest exits */
@@ -745,6 +757,8 @@ static int kvm_trap_emul_vcpu_run(struct kvm_run *run, struct kvm_vcpu *vcpu)
 	     asid_version_mask(cpu)))
 		get_new_mmu_context(current->mm, cpu);
 	write_c0_entryhi(cpu_asid(cpu, current->mm));
+	cpumask_set_cpu(cpu, mm_cpumask(current->mm));
+	current->active_mm = current->mm;
 
 	htw_start();
 
-- 
git-series 0.8.10
