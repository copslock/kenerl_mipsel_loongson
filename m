Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jun 2016 20:30:49 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:23558 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27042324AbcFOSaNwgJ6W (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Jun 2016 20:30:13 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id F1482453353FD;
        Wed, 15 Jun 2016 19:30:02 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 15 Jun 2016 19:30:07 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 02/17] MIPS: KVM: Factor writing of translated guest instructions
Date:   Wed, 15 Jun 2016 19:29:46 +0100
Message-ID: <1466015401-24433-3-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 54055
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

The code in kvm_mips_dyntrans.c to write a translated guest instruction
to guest memory depending on the segment is duplicated between each of
the functions. Additionally the cache op translation functions assume
the instruction is in the KSEG0/1 segment rather than KSEG2/3, which is
generally true but isn't guaranteed.

Factor that code into a new kvm_mips_trans_replace() which handles both
KSEG0/1 and KSEG2/3.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/dyntrans.c | 92 ++++++++++++++++++------------------------------
 1 file changed, 34 insertions(+), 58 deletions(-)

diff --git a/arch/mips/kvm/dyntrans.c b/arch/mips/kvm/dyntrans.c
index 79b134c91333..eb6e0d17a668 100644
--- a/arch/mips/kvm/dyntrans.c
+++ b/arch/mips/kvm/dyntrans.c
@@ -28,21 +28,41 @@
 #define CLEAR_TEMPLATE  0x00000020
 #define SW_TEMPLATE     0xac000000
 
+/**
+ * kvm_mips_trans_replace() - Replace trapping instruction in guest memory.
+ * @vcpu:	Virtual CPU.
+ * @opc:	PC of instruction to replace.
+ * @replace:	Instruction to write
+ */
+static int kvm_mips_trans_replace(struct kvm_vcpu *vcpu, u32 *opc, u32 replace)
+{
+	unsigned long kseg0_opc, flags;
+
+	if (KVM_GUEST_KSEGX(opc) == KVM_GUEST_KSEG0) {
+		kseg0_opc =
+		    CKSEG0ADDR(kvm_mips_translate_guest_kseg0_to_hpa
+			       (vcpu, (unsigned long) opc));
+		memcpy((void *)kseg0_opc, (void *)&replace, sizeof(u32));
+		local_flush_icache_range(kseg0_opc, kseg0_opc + 32);
+	} else if (KVM_GUEST_KSEGX((unsigned long) opc) == KVM_GUEST_KSEG23) {
+		local_irq_save(flags);
+		memcpy((void *)opc, (void *)&replace, sizeof(u32));
+		local_flush_icache_range((unsigned long)opc,
+					 (unsigned long)opc + 32);
+		local_irq_restore(flags);
+	} else {
+		kvm_err("%s: Invalid address: %p\n", __func__, opc);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
 int kvm_mips_trans_cache_index(u32 inst, u32 *opc,
 			       struct kvm_vcpu *vcpu)
 {
-	int result = 0;
-	unsigned long kseg0_opc;
-	u32 synci_inst = 0x0;
-
 	/* Replace the CACHE instruction, with a NOP */
-	kseg0_opc =
-	    CKSEG0ADDR(kvm_mips_translate_guest_kseg0_to_hpa
-		       (vcpu, (unsigned long) opc));
-	memcpy((void *)kseg0_opc, (void *)&synci_inst, sizeof(u32));
-	local_flush_icache_range(kseg0_opc, kseg0_opc + 32);
-
-	return result;
+	return kvm_mips_trans_replace(vcpu, opc, 0x00000000);
 }
 
 /*
@@ -52,8 +72,6 @@ int kvm_mips_trans_cache_index(u32 inst, u32 *opc,
 int kvm_mips_trans_cache_va(u32 inst, u32 *opc,
 			    struct kvm_vcpu *vcpu)
 {
-	int result = 0;
-	unsigned long kseg0_opc;
 	u32 synci_inst = SYNCI_TEMPLATE, base, offset;
 
 	base = (inst >> 21) & 0x1f;
@@ -61,20 +79,13 @@ int kvm_mips_trans_cache_va(u32 inst, u32 *opc,
 	synci_inst |= (base << 21);
 	synci_inst |= offset;
 
-	kseg0_opc =
-	    CKSEG0ADDR(kvm_mips_translate_guest_kseg0_to_hpa
-		       (vcpu, (unsigned long) opc));
-	memcpy((void *)kseg0_opc, (void *)&synci_inst, sizeof(u32));
-	local_flush_icache_range(kseg0_opc, kseg0_opc + 32);
-
-	return result;
+	return kvm_mips_trans_replace(vcpu, opc, synci_inst);
 }
 
 int kvm_mips_trans_mfc0(u32 inst, u32 *opc, struct kvm_vcpu *vcpu)
 {
 	u32 rt, rd, sel;
 	u32 mfc0_inst;
-	unsigned long kseg0_opc, flags;
 
 	rt = (inst >> 16) & 0x1f;
 	rd = (inst >> 11) & 0x1f;
@@ -90,31 +101,13 @@ int kvm_mips_trans_mfc0(u32 inst, u32 *opc, struct kvm_vcpu *vcpu)
 				      cop0.reg[rd][sel]);
 	}
 
-	if (KVM_GUEST_KSEGX(opc) == KVM_GUEST_KSEG0) {
-		kseg0_opc =
-		    CKSEG0ADDR(kvm_mips_translate_guest_kseg0_to_hpa
-			       (vcpu, (unsigned long) opc));
-		memcpy((void *)kseg0_opc, (void *)&mfc0_inst, sizeof(u32));
-		local_flush_icache_range(kseg0_opc, kseg0_opc + 32);
-	} else if (KVM_GUEST_KSEGX((unsigned long) opc) == KVM_GUEST_KSEG23) {
-		local_irq_save(flags);
-		memcpy((void *)opc, (void *)&mfc0_inst, sizeof(u32));
-		local_flush_icache_range((unsigned long)opc,
-					 (unsigned long)opc + 32);
-		local_irq_restore(flags);
-	} else {
-		kvm_err("%s: Invalid address: %p\n", __func__, opc);
-		return -EFAULT;
-	}
-
-	return 0;
+	return kvm_mips_trans_replace(vcpu, opc, mfc0_inst);
 }
 
 int kvm_mips_trans_mtc0(u32 inst, u32 *opc, struct kvm_vcpu *vcpu)
 {
 	u32 rt, rd, sel;
 	u32 mtc0_inst = SW_TEMPLATE;
-	unsigned long kseg0_opc, flags;
 
 	rt = (inst >> 16) & 0x1f;
 	rd = (inst >> 11) & 0x1f;
@@ -123,22 +116,5 @@ int kvm_mips_trans_mtc0(u32 inst, u32 *opc, struct kvm_vcpu *vcpu)
 	mtc0_inst |= ((rt & 0x1f) << 16);
 	mtc0_inst |= offsetof(struct kvm_mips_commpage, cop0.reg[rd][sel]);
 
-	if (KVM_GUEST_KSEGX(opc) == KVM_GUEST_KSEG0) {
-		kseg0_opc =
-		    CKSEG0ADDR(kvm_mips_translate_guest_kseg0_to_hpa
-			       (vcpu, (unsigned long) opc));
-		memcpy((void *)kseg0_opc, (void *)&mtc0_inst, sizeof(u32));
-		local_flush_icache_range(kseg0_opc, kseg0_opc + 32);
-	} else if (KVM_GUEST_KSEGX((unsigned long) opc) == KVM_GUEST_KSEG23) {
-		local_irq_save(flags);
-		memcpy((void *)opc, (void *)&mtc0_inst, sizeof(u32));
-		local_flush_icache_range((unsigned long)opc,
-					 (unsigned long)opc + 32);
-		local_irq_restore(flags);
-	} else {
-		kvm_err("%s: Invalid address: %p\n", __func__, opc);
-		return -EFAULT;
-	}
-
-	return 0;
+	return kvm_mips_trans_replace(vcpu, opc, mtc0_inst);
 }
-- 
2.4.10
