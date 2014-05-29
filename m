Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 May 2014 11:19:45 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:25569 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6824796AbaE2JRHIWbuU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 May 2014 11:17:07 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id D9447F0A0E662;
        Thu, 29 May 2014 10:16:57 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Thu, 29 May 2014 10:16:59 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.101) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Thu, 29 May 2014 10:16:59 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        James Hogan <james.hogan@imgtec.com>,
        Gleb Natapov <gleb@kernel.org>, <kvm@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, David Daney <david.daney@cavium.com>,
        Sanjay Lal <sanjayl@kymasys.com>
Subject: [PATCH v2 07/23] MIPS: KVM: Add CP0_Count/Compare KVM register access
Date:   Thu, 29 May 2014 10:16:29 +0100
Message-ID: <1401355005-20370-8-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1401355005-20370-1-git-send-email-james.hogan@imgtec.com>
References: <1401355005-20370-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.101]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40328
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

Implement KVM_{GET,SET}_ONE_REG ioctl based access to the guest CP0
Count and Compare registers. These registers are special in that writing
to them has side effects (adjusting the time until the next timer
interrupt) and reading of Count depends on the time. Therefore add a
couple of callbacks so that different implementations (trap & emulate or
VZ) can implement them differently depending on what the hardware
provides.

The trap & emulate versions mostly duplicate what happens when a T&E
guest reads or writes these registers, so it inherits the same
limitations which can be fixed in later patches.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: kvm@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: David Daney <david.daney@cavium.com>
Cc: Sanjay Lal <sanjayl@kymasys.com>
---
 arch/mips/include/asm/kvm_host.h |  4 ++++
 arch/mips/kvm/kvm_mips.c         | 16 ++++++++++++++++
 arch/mips/kvm/kvm_trap_emul.c    | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 9f6bfc963a5b..41e180ed36e3 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -523,6 +523,10 @@ struct kvm_mips_callbacks {
 			    uint32_t cause);
 	int (*irq_clear) (struct kvm_vcpu *vcpu, unsigned int priority,
 			  uint32_t cause);
+	int (*get_one_reg)(struct kvm_vcpu *vcpu,
+			   const struct kvm_one_reg *reg, s64 *v);
+	int (*set_one_reg)(struct kvm_vcpu *vcpu,
+			   const struct kvm_one_reg *reg, s64 v);
 };
 extern struct kvm_mips_callbacks *kvm_mips_callbacks;
 int kvm_mips_emulation_init(struct kvm_mips_callbacks **install_callbacks);
diff --git a/arch/mips/kvm/kvm_mips.c b/arch/mips/kvm/kvm_mips.c
index a4dd796dfa67..2f6344cca653 100644
--- a/arch/mips/kvm/kvm_mips.c
+++ b/arch/mips/kvm/kvm_mips.c
@@ -534,7 +534,9 @@ static u64 kvm_mips_get_one_regs[] = {
 	KVM_REG_MIPS_CP0_PAGEMASK,
 	KVM_REG_MIPS_CP0_WIRED,
 	KVM_REG_MIPS_CP0_BADVADDR,
+	KVM_REG_MIPS_CP0_COUNT,
 	KVM_REG_MIPS_CP0_ENTRYHI,
+	KVM_REG_MIPS_CP0_COMPARE,
 	KVM_REG_MIPS_CP0_STATUS,
 	KVM_REG_MIPS_CP0_CAUSE,
 	KVM_REG_MIPS_CP0_EPC,
@@ -550,6 +552,7 @@ static int kvm_mips_get_reg(struct kvm_vcpu *vcpu,
 			    const struct kvm_one_reg *reg)
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	int ret;
 	s64 v;
 
 	switch (reg->id) {
@@ -584,6 +587,9 @@ static int kvm_mips_get_reg(struct kvm_vcpu *vcpu,
 	case KVM_REG_MIPS_CP0_ENTRYHI:
 		v = (long)kvm_read_c0_guest_entryhi(cop0);
 		break;
+	case KVM_REG_MIPS_CP0_COMPARE:
+		v = (long)kvm_read_c0_guest_compare(cop0);
+		break;
 	case KVM_REG_MIPS_CP0_STATUS:
 		v = (long)kvm_read_c0_guest_status(cop0);
 		break;
@@ -611,6 +617,12 @@ static int kvm_mips_get_reg(struct kvm_vcpu *vcpu,
 	case KVM_REG_MIPS_CP0_CONFIG7:
 		v = (long)kvm_read_c0_guest_config7(cop0);
 		break;
+	/* registers to be handled specially */
+	case KVM_REG_MIPS_CP0_COUNT:
+		ret = kvm_mips_callbacks->get_one_reg(vcpu, reg, &v);
+		if (ret)
+			return ret;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -695,6 +707,10 @@ static int kvm_mips_set_reg(struct kvm_vcpu *vcpu,
 	case KVM_REG_MIPS_CP0_ERROREPC:
 		kvm_write_c0_guest_errorepc(cop0, v);
 		break;
+	/* registers to be handled specially */
+	case KVM_REG_MIPS_CP0_COUNT:
+	case KVM_REG_MIPS_CP0_COMPARE:
+		return kvm_mips_callbacks->set_one_reg(vcpu, reg, v);
 	default:
 		return -EINVAL;
 	}
diff --git a/arch/mips/kvm/kvm_trap_emul.c b/arch/mips/kvm/kvm_trap_emul.c
index 30d725321db1..f1e8389f8d33 100644
--- a/arch/mips/kvm/kvm_trap_emul.c
+++ b/arch/mips/kvm/kvm_trap_emul.c
@@ -401,6 +401,40 @@ static int kvm_trap_emul_vcpu_setup(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
+static int kvm_trap_emul_get_one_reg(struct kvm_vcpu *vcpu,
+				     const struct kvm_one_reg *reg,
+				     s64 *v)
+{
+	switch (reg->id) {
+	case KVM_REG_MIPS_CP0_COUNT:
+		/* XXXKYMA: Run the Guest count register @ 1/4 the rate of the host */
+		*v = (read_c0_count() >> 2);
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int kvm_trap_emul_set_one_reg(struct kvm_vcpu *vcpu,
+				     const struct kvm_one_reg *reg,
+				     s64 v)
+{
+	struct mips_coproc *cop0 = vcpu->arch.cop0;
+
+	switch (reg->id) {
+	case KVM_REG_MIPS_CP0_COUNT:
+		/* Not supported yet */
+		break;
+	case KVM_REG_MIPS_CP0_COMPARE:
+		kvm_write_c0_guest_compare(cop0, v);
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static struct kvm_mips_callbacks kvm_trap_emul_callbacks = {
 	/* exit handlers */
 	.handle_cop_unusable = kvm_trap_emul_handle_cop_unusable,
@@ -423,6 +457,8 @@ static struct kvm_mips_callbacks kvm_trap_emul_callbacks = {
 	.dequeue_io_int = kvm_mips_dequeue_io_int_cb,
 	.irq_deliver = kvm_mips_irq_deliver_cb,
 	.irq_clear = kvm_mips_irq_clear_cb,
+	.get_one_reg = kvm_trap_emul_get_one_reg,
+	.set_one_reg = kvm_trap_emul_set_one_reg,
 };
 
 int kvm_mips_emulation_init(struct kvm_mips_callbacks **install_callbacks)
-- 
1.9.3
