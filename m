Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jun 2016 20:31:41 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:60594 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27042332AbcFOSaPwU5WW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Jun 2016 20:30:15 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 71AA47A62C9B7;
        Wed, 15 Jun 2016 19:30:05 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 15 Jun 2016 19:30:09 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 05/17] MIPS: KVM: Make KVM_GET_REG_LIST dynamic
Date:   Wed, 15 Jun 2016 19:29:49 +0100
Message-ID: <1466015401-24433-6-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1466015401-24433-1-git-send-email-james.hogan@imgtec.com>
References: <1466015401-24433-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54058
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

Make the implementation of KVM_GET_REG_LIST more dynamic so that only
the subset of registers actually available can be exposed to user mode.
This is important for VZ where some of the guest register state may not
be possible to prevent the guest from accessing, therefore the user
process may need to be aware of the state even if it doesn't understand
what the state is for.

This also allows different MIPS KVM implementations to provide different
registers to one another, by way of new num_regs(vcpu) and
copy_reg_indices(vcpu, indices) callback functions, currently just
stubbed for trap & emulate.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h |  2 ++
 arch/mips/kvm/mips.c             | 29 ++++++++++++++++++++++-------
 arch/mips/kvm/trap_emul.c        | 13 +++++++++++++
 3 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 1e002136f514..38f0491fcb2f 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -560,6 +560,8 @@ struct kvm_mips_callbacks {
 			   u32 cause);
 	int (*irq_clear)(struct kvm_vcpu *vcpu, unsigned int priority,
 			 u32 cause);
+	unsigned long (*num_regs)(struct kvm_vcpu *vcpu);
+	int (*copy_reg_indices)(struct kvm_vcpu *vcpu, u64 __user *indices);
 	int (*get_one_reg)(struct kvm_vcpu *vcpu,
 			   const struct kvm_one_reg *reg, s64 *v);
 	int (*set_one_reg)(struct kvm_vcpu *vcpu,
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index fe82f3354c23..2c4709a09b78 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -538,6 +538,26 @@ static u64 kvm_mips_get_one_regs[] = {
 	KVM_REG_MIPS_COUNT_HZ,
 };
 
+static unsigned long kvm_mips_num_regs(struct kvm_vcpu *vcpu)
+{
+	unsigned long ret;
+
+	ret = ARRAY_SIZE(kvm_mips_get_one_regs);
+	ret += kvm_mips_callbacks->num_regs(vcpu);
+
+	return ret;
+}
+
+static int kvm_mips_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *indices)
+{
+	if (copy_to_user(indices, kvm_mips_get_one_regs,
+			 sizeof(kvm_mips_get_one_regs)))
+		return -EFAULT;
+	indices += ARRAY_SIZE(kvm_mips_get_one_regs);
+
+	return kvm_mips_callbacks->copy_reg_indices(vcpu, indices);
+}
+
 static int kvm_mips_get_reg(struct kvm_vcpu *vcpu,
 			    const struct kvm_one_reg *reg)
 {
@@ -908,23 +928,18 @@ long kvm_arch_vcpu_ioctl(struct file *filp, unsigned int ioctl,
 	}
 	case KVM_GET_REG_LIST: {
 		struct kvm_reg_list __user *user_list = argp;
-		u64 __user *reg_dest;
 		struct kvm_reg_list reg_list;
 		unsigned n;
 
 		if (copy_from_user(&reg_list, user_list, sizeof(reg_list)))
 			return -EFAULT;
 		n = reg_list.n;
-		reg_list.n = ARRAY_SIZE(kvm_mips_get_one_regs);
+		reg_list.n = kvm_mips_num_regs(vcpu);
 		if (copy_to_user(user_list, &reg_list, sizeof(reg_list)))
 			return -EFAULT;
 		if (n < reg_list.n)
 			return -E2BIG;
-		reg_dest = user_list->reg;
-		if (copy_to_user(reg_dest, kvm_mips_get_one_regs,
-				 sizeof(kvm_mips_get_one_regs)))
-			return -EFAULT;
-		return 0;
+		return kvm_mips_copy_reg_indices(vcpu, user_list->reg);
 	}
 	case KVM_NMI:
 		/* Treat the NMI as a CPU reset */
diff --git a/arch/mips/kvm/trap_emul.c b/arch/mips/kvm/trap_emul.c
index 09b97fa9dabb..b64ca1a222f7 100644
--- a/arch/mips/kvm/trap_emul.c
+++ b/arch/mips/kvm/trap_emul.c
@@ -478,6 +478,17 @@ static int kvm_trap_emul_vcpu_setup(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
+static unsigned long kvm_trap_emul_num_regs(struct kvm_vcpu *vcpu)
+{
+	return 0;
+}
+
+static int kvm_trap_emul_copy_reg_indices(struct kvm_vcpu *vcpu,
+					  u64 __user *indices)
+{
+	return 0;
+}
+
 static int kvm_trap_emul_get_one_reg(struct kvm_vcpu *vcpu,
 				     const struct kvm_one_reg *reg,
 				     s64 *v)
@@ -627,6 +638,8 @@ static struct kvm_mips_callbacks kvm_trap_emul_callbacks = {
 	.dequeue_io_int = kvm_mips_dequeue_io_int_cb,
 	.irq_deliver = kvm_mips_irq_deliver_cb,
 	.irq_clear = kvm_mips_irq_clear_cb,
+	.num_regs = kvm_trap_emul_num_regs,
+	.copy_reg_indices = kvm_trap_emul_copy_reg_indices,
 	.get_one_reg = kvm_trap_emul_get_one_reg,
 	.set_one_reg = kvm_trap_emul_set_one_reg,
 	.vcpu_get_regs = kvm_trap_emul_vcpu_get_regs,
-- 
2.4.10
