Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Mar 2015 15:50:51 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:4149 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013398AbbCKOsQCYCL5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Mar 2015 15:48:16 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 90AC47A613916;
        Wed, 11 Mar 2015 14:48:08 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 11 Mar 2015 14:48:10 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 11 Mar 2015 14:48:10 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
        <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Gleb Natapov <gleb@kernel.org>
Subject: [PATCH 10/20] MIPS: KVM: Add vcpu_get_regs/vcpu_set_regs callback
Date:   Wed, 11 Mar 2015 14:44:46 +0000
Message-ID: <1426085096-12932-11-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.0.5
In-Reply-To: <1426085096-12932-1-git-send-email-james.hogan@imgtec.com>
References: <1426085096-12932-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46324
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

Add a vcpu_get_regs() and vcpu_set_regs() callbacks for loading and
restoring context which may be in hardware registers. This may include
floating point and MIPS SIMD Architecture (MSA) state which may be
accessed directly by the guest (but restored lazily by the hypervisor),
and also dedicated guest registers as provided by the VZ ASE.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h |  2 ++
 arch/mips/kvm/tlb.c              |  6 ++++++
 arch/mips/kvm/trap_emul.c        | 12 ++++++++++++
 3 files changed, 20 insertions(+)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 3f58ee1ebfab..fb79d67de192 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -585,6 +585,8 @@ struct kvm_mips_callbacks {
 			   const struct kvm_one_reg *reg, s64 *v);
 	int (*set_one_reg)(struct kvm_vcpu *vcpu,
 			   const struct kvm_one_reg *reg, s64 v);
+	int (*vcpu_get_regs)(struct kvm_vcpu *vcpu);
+	int (*vcpu_set_regs)(struct kvm_vcpu *vcpu);
 };
 extern struct kvm_mips_callbacks *kvm_mips_callbacks;
 int kvm_mips_emulation_init(struct kvm_mips_callbacks **install_callbacks);
diff --git a/arch/mips/kvm/tlb.c b/arch/mips/kvm/tlb.c
index bbcd82242059..caa0b13fa37e 100644
--- a/arch/mips/kvm/tlb.c
+++ b/arch/mips/kvm/tlb.c
@@ -732,6 +732,9 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 		}
 	}
 
+	/* restore guest state to registers */
+	kvm_mips_callbacks->vcpu_set_regs(vcpu);
+
 	local_irq_restore(flags);
 
 }
@@ -750,6 +753,9 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 	vcpu->arch.preempt_entryhi = read_c0_entryhi();
 	vcpu->arch.last_sched_cpu = cpu;
 
+	/* save guest state in registers */
+	kvm_mips_callbacks->vcpu_get_regs(vcpu);
+
 	if (((cpu_context(cpu, current->mm) ^ asid_cache(cpu)) &
 	     ASID_VERSION_MASK)) {
 		kvm_debug("%s: Dropping MMU Context:  %#lx\n", __func__,
diff --git a/arch/mips/kvm/trap_emul.c b/arch/mips/kvm/trap_emul.c
index 8e0968428a78..0d2729d202f4 100644
--- a/arch/mips/kvm/trap_emul.c
+++ b/arch/mips/kvm/trap_emul.c
@@ -552,6 +552,16 @@ static int kvm_trap_emul_set_one_reg(struct kvm_vcpu *vcpu,
 	return ret;
 }
 
+static int kvm_trap_emul_vcpu_get_regs(struct kvm_vcpu *vcpu)
+{
+	return 0;
+}
+
+static int kvm_trap_emul_vcpu_set_regs(struct kvm_vcpu *vcpu)
+{
+	return 0;
+}
+
 static struct kvm_mips_callbacks kvm_trap_emul_callbacks = {
 	/* exit handlers */
 	.handle_cop_unusable = kvm_trap_emul_handle_cop_unusable,
@@ -578,6 +588,8 @@ static struct kvm_mips_callbacks kvm_trap_emul_callbacks = {
 	.irq_clear = kvm_mips_irq_clear_cb,
 	.get_one_reg = kvm_trap_emul_get_one_reg,
 	.set_one_reg = kvm_trap_emul_set_one_reg,
+	.vcpu_get_regs = kvm_trap_emul_vcpu_get_regs,
+	.vcpu_set_regs = kvm_trap_emul_vcpu_set_regs,
 };
 
 int kvm_mips_emulation_init(struct kvm_mips_callbacks **install_callbacks)
-- 
2.0.5
