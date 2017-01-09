Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jan 2017 21:54:23 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:37867 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993868AbdAIUx331kIP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Jan 2017 21:53:29 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 545A9B0E1CF77;
        Mon,  9 Jan 2017 20:53:19 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 9 Jan 2017 20:53:23 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 3/10] KVM: MIPS: Update vcpu->mode and vcpu->cpu
Date:   Mon, 9 Jan 2017 20:51:55 +0000
Message-ID: <5ba3054eea35eeca00b2a653f40ebbed3e6940f3.1483993967.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
In-Reply-To: <cover.4133d2f24fd73c1889a46ea05bb8924867b33747.1483993967.git-series.james.hogan@imgtec.com>
References: <cover.4133d2f24fd73c1889a46ea05bb8924867b33747.1483993967.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56237
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

Keep the vcpu->mode and vcpu->cpu variables up to date so that
kvm_make_all_cpus_request() has a chance of functioning correctly. This
will soon need to be used for kvm_flush_remote_tlbs().

We can easily update vcpu->cpu when the VCPU context is loaded or saved,
which will happen when accessing guest context and when the guest is
scheduled in and out.

We need to be a little careful with vcpu->mode though, as we will in
future be checking for outstanding VCPU requests, and this must be done
after the value of IN_GUEST_MODE in vcpu->mode is visible to other CPUs.
Otherwise the other CPU could fail to trigger an IPI to wait for
completion dispite the VCPU request not being seen.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/mips.c | 18 ++++++++++++++++++
 arch/mips/kvm/mmu.c  |  2 ++
 2 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 90c28fbf4829..325e98367b30 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -365,6 +365,14 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	guest_enter_irqoff();
 	trace_kvm_enter(vcpu);
 
+	/*
+	 * Make sure the read of VCPU requests in vcpu_run() callback is not
+	 * reordered ahead of the write to vcpu->mode, or we could miss a TLB
+	 * flush request while the requester sees the VCPU as outside of guest
+	 * mode and not needing an IPI.
+	 */
+	smp_store_mb(vcpu->mode, IN_GUEST_MODE);
+
 	r = kvm_mips_callbacks->vcpu_run(run, vcpu);
 
 	trace_kvm_out(vcpu);
@@ -1331,6 +1339,8 @@ int kvm_mips_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu)
 	u32 inst;
 	int ret = RESUME_GUEST;
 
+	vcpu->mode = OUTSIDE_GUEST_MODE;
+
 	/* re-enable HTW before enabling interrupts */
 	htw_start();
 
@@ -1486,6 +1496,14 @@ int kvm_mips_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu)
 	if (ret == RESUME_GUEST) {
 		trace_kvm_reenter(vcpu);
 
+		/*
+		 * Make sure the read of VCPU requests in vcpu_reenter()
+		 * callback is not reordered ahead of the write to vcpu->mode,
+		 * or we could miss a TLB flush request while the requester sees
+		 * the VCPU as outside of guest mode and not needing an IPI.
+		 */
+		smp_store_mb(vcpu->mode, IN_GUEST_MODE);
+
 		kvm_mips_callbacks->vcpu_reenter(run, vcpu);
 
 		/*
diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index 09f5da706d9a..e41ee36dd626 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -696,6 +696,7 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 
 	local_irq_save(flags);
 
+	vcpu->cpu = cpu;
 	if (vcpu->arch.last_sched_cpu != cpu) {
 		kvm_debug("[%d->%d]KVM VCPU[%d] switch\n",
 			  vcpu->arch.last_sched_cpu, cpu, vcpu->vcpu_id);
@@ -723,6 +724,7 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 
 	cpu = smp_processor_id();
 	vcpu->arch.last_sched_cpu = cpu;
+	vcpu->cpu = -1;
 
 	/* save guest state in registers */
 	kvm_mips_callbacks->vcpu_put(vcpu, cpu);
-- 
git-series 0.8.10
