Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Feb 2017 13:08:24 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:9114 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993913AbdBBMFHlBnFv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Feb 2017 13:05:07 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id F1408A5608D62;
        Thu,  2 Feb 2017 12:04:54 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 2 Feb 2017 12:04:57 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH v2 7/30] KVM: MIPS: Convert get/set_regs -> vcpu_load/put
Date:   Thu, 2 Feb 2017 12:04:20 +0000
Message-ID: <f08ab28e7e470f0504f3686747fe708534ffa92b.1486036366.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
In-Reply-To: <cover.e37f86dece46fc3ed00a075d68119cab361cda8e.1486036366.git-series.james.hogan@imgtec.com>
References: <cover.e37f86dece46fc3ed00a075d68119cab361cda8e.1486036366.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56596
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

Convert the get_regs() and set_regs() callbacks to vcpu_load() and
vcpu_put(), which provide a cpu argument and more closely match the
kvm_arch_vcpu_load() / kvm_arch_vcpu_put() that they are called by.

This is in preparation for moving ASID management into the
implementations.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h |  4 ++--
 arch/mips/kvm/mmu.c              |  4 ++--
 arch/mips/kvm/trap_emul.c        | 12 ++++++------
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 7cc53e44b42e..1c70b5224151 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -539,8 +539,8 @@ struct kvm_mips_callbacks {
 			   const struct kvm_one_reg *reg, s64 *v);
 	int (*set_one_reg)(struct kvm_vcpu *vcpu,
 			   const struct kvm_one_reg *reg, s64 v);
-	int (*vcpu_get_regs)(struct kvm_vcpu *vcpu);
-	int (*vcpu_set_regs)(struct kvm_vcpu *vcpu);
+	int (*vcpu_load)(struct kvm_vcpu *vcpu, int cpu);
+	int (*vcpu_put)(struct kvm_vcpu *vcpu, int cpu);
 };
 extern struct kvm_mips_callbacks *kvm_mips_callbacks;
 int kvm_mips_emulation_init(struct kvm_mips_callbacks **install_callbacks);
diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index e1698a66253b..ed46528611f4 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -294,7 +294,7 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	}
 
 	/* restore guest state to registers */
-	kvm_mips_callbacks->vcpu_set_regs(vcpu);
+	kvm_mips_callbacks->vcpu_load(vcpu, cpu);
 
 	local_irq_restore(flags);
 
@@ -312,7 +312,7 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 	vcpu->arch.last_sched_cpu = cpu;
 
 	/* save guest state in registers */
-	kvm_mips_callbacks->vcpu_get_regs(vcpu);
+	kvm_mips_callbacks->vcpu_put(vcpu, cpu);
 
 	if (((cpu_context(cpu, current->mm) ^ asid_cache(cpu)) &
 	     asid_version_mask(cpu))) {
diff --git a/arch/mips/kvm/trap_emul.c b/arch/mips/kvm/trap_emul.c
index 3b20441f2beb..c0ee51465913 100644
--- a/arch/mips/kvm/trap_emul.c
+++ b/arch/mips/kvm/trap_emul.c
@@ -633,15 +633,15 @@ static int kvm_trap_emul_set_one_reg(struct kvm_vcpu *vcpu,
 	return ret;
 }
 
-static int kvm_trap_emul_vcpu_get_regs(struct kvm_vcpu *vcpu)
+static int kvm_trap_emul_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
-	kvm_lose_fpu(vcpu);
-
 	return 0;
 }
 
-static int kvm_trap_emul_vcpu_set_regs(struct kvm_vcpu *vcpu)
+static int kvm_trap_emul_vcpu_put(struct kvm_vcpu *vcpu, int cpu)
 {
+	kvm_lose_fpu(vcpu);
+
 	return 0;
 }
 
@@ -675,8 +675,8 @@ static struct kvm_mips_callbacks kvm_trap_emul_callbacks = {
 	.copy_reg_indices = kvm_trap_emul_copy_reg_indices,
 	.get_one_reg = kvm_trap_emul_get_one_reg,
 	.set_one_reg = kvm_trap_emul_set_one_reg,
-	.vcpu_get_regs = kvm_trap_emul_vcpu_get_regs,
-	.vcpu_set_regs = kvm_trap_emul_vcpu_set_regs,
+	.vcpu_load = kvm_trap_emul_vcpu_load,
+	.vcpu_put = kvm_trap_emul_vcpu_put,
 };
 
 int kvm_mips_emulation_init(struct kvm_mips_callbacks **install_callbacks)
-- 
git-series 0.8.10
