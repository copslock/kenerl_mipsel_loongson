Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jun 2016 20:32:15 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:44876 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27042335AbcFOSaRQBrpW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Jun 2016 20:30:17 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id D1AE02110D382;
        Wed, 15 Jun 2016 19:30:06 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 15 Jun 2016 19:30:10 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 07/17] MIPS: KVM: List FPU/MSA registers
Date:   Wed, 15 Jun 2016 19:29:51 +0100
Message-ID: <1466015401-24433-8-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 54060
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

Make KVM_GET_REG_LIST list FPU & MSA registers. Specifically we list all
32 vector registers when MSA can be enabled, 32 single-precision FP
registers when FPU can be enabled, and either 16 or 32 double-precision
FP registers when FPU can be enabled depending on whether FR mode is
supported (which provides 32 doubles instead of 16 even doubles).

Note, these registers may still be inaccessible depending on the current
FP mode of the guest.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/mips.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 2c4709a09b78..622b9feba927 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -538,11 +538,29 @@ static u64 kvm_mips_get_one_regs[] = {
 	KVM_REG_MIPS_COUNT_HZ,
 };
 
+static u64 kvm_mips_get_one_regs_fpu[] = {
+	KVM_REG_MIPS_FCR_IR,
+	KVM_REG_MIPS_FCR_CSR,
+};
+
+static u64 kvm_mips_get_one_regs_msa[] = {
+	KVM_REG_MIPS_MSA_IR,
+	KVM_REG_MIPS_MSA_CSR,
+};
+
 static unsigned long kvm_mips_num_regs(struct kvm_vcpu *vcpu)
 {
 	unsigned long ret;
 
 	ret = ARRAY_SIZE(kvm_mips_get_one_regs);
+	if (kvm_mips_guest_can_have_fpu(&vcpu->arch)) {
+		ret += ARRAY_SIZE(kvm_mips_get_one_regs_fpu) + 48;
+		/* odd doubles */
+		if (boot_cpu_data.fpu_id & MIPS_FPIR_F64)
+			ret += 16;
+	}
+	if (kvm_mips_guest_can_have_msa(&vcpu->arch))
+		ret += ARRAY_SIZE(kvm_mips_get_one_regs_msa) + 32;
 	ret += kvm_mips_callbacks->num_regs(vcpu);
 
 	return ret;
@@ -550,11 +568,51 @@ static unsigned long kvm_mips_num_regs(struct kvm_vcpu *vcpu)
 
 static int kvm_mips_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *indices)
 {
+	u64 index;
+	unsigned int i;
+
 	if (copy_to_user(indices, kvm_mips_get_one_regs,
 			 sizeof(kvm_mips_get_one_regs)))
 		return -EFAULT;
 	indices += ARRAY_SIZE(kvm_mips_get_one_regs);
 
+	if (kvm_mips_guest_can_have_fpu(&vcpu->arch)) {
+		if (copy_to_user(indices, kvm_mips_get_one_regs_fpu,
+				 sizeof(kvm_mips_get_one_regs_fpu)))
+			return -EFAULT;
+		indices += ARRAY_SIZE(kvm_mips_get_one_regs_fpu);
+
+		for (i = 0; i < 32; ++i) {
+			index = KVM_REG_MIPS_FPR_32(i);
+			if (copy_to_user(indices, &index, sizeof(index)))
+				return -EFAULT;
+			++indices;
+
+			/* skip odd doubles if no F64 */
+			if (i & 1 && !(boot_cpu_data.fpu_id & MIPS_FPIR_F64))
+				continue;
+
+			index = KVM_REG_MIPS_FPR_64(i);
+			if (copy_to_user(indices, &index, sizeof(index)))
+				return -EFAULT;
+			++indices;
+		}
+	}
+
+	if (kvm_mips_guest_can_have_msa(&vcpu->arch)) {
+		if (copy_to_user(indices, kvm_mips_get_one_regs_msa,
+				 sizeof(kvm_mips_get_one_regs_msa)))
+			return -EFAULT;
+		indices += ARRAY_SIZE(kvm_mips_get_one_regs_msa);
+
+		for (i = 0; i < 32; ++i) {
+			index = KVM_REG_MIPS_VEC_128(i);
+			if (copy_to_user(indices, &index, sizeof(index)))
+				return -EFAULT;
+			++indices;
+		}
+	}
+
 	return kvm_mips_callbacks->copy_reg_indices(vcpu, indices);
 }
 
-- 
2.4.10
