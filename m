Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Mar 2015 15:51:10 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:34650 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013400AbbCKOsQLUOgn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Mar 2015 15:48:16 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id ED49C731F28A8;
        Wed, 11 Mar 2015 14:48:06 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 11 Mar 2015 14:48:09 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 11 Mar 2015 14:48:09 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
        <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Gleb Natapov <gleb@kernel.org>
Subject: [PATCH 09/20] MIPS: KVM: Add Config4/5 and writing of Config registers
Date:   Wed, 11 Mar 2015 14:44:45 +0000
Message-ID: <1426085096-12932-10-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 46325
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

Add Config4 and Config5 co-processor 0 registers, and add capability to
write the Config1, Config3, Config4, and Config5 registers using the KVM
API.

Only supported bits can be written, to minimise the chances of the guest
being given a configuration from e.g. QEMU that is inconsistent with
that being emulated, and as such the handling is in trap_emul.c as it
may need to be different for VZ. Currently the only modification
permitted is to make Config4 and Config5 exist via the M bits, but other
bits will be added for FPU and MSA support in future patches.

Care should be taken by userland not to change bits without fully
handling the possible extra state that may then exist and which the
guest may begin to use and depend on.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 Documentation/virtual/kvm/api.txt |  2 ++
 arch/mips/include/asm/kvm_host.h  | 13 ++++++++++
 arch/mips/kvm/emulate.c           | 52 +++++++++++++++++++++++++++++++++++++++
 arch/mips/kvm/mips.c              | 14 +++++++++++
 arch/mips/kvm/trap_emul.c         | 49 ++++++++++++++++++++++++++++++++++--
 5 files changed, 128 insertions(+), 2 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 22dfaa31ed86..1e59515b6d1f 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -1972,6 +1972,8 @@ registers, find a list below:
   MIPS  | KVM_REG_MIPS_CP0_CONFIG1      | 32
   MIPS  | KVM_REG_MIPS_CP0_CONFIG2      | 32
   MIPS  | KVM_REG_MIPS_CP0_CONFIG3      | 32
+  MIPS  | KVM_REG_MIPS_CP0_CONFIG4      | 32
+  MIPS  | KVM_REG_MIPS_CP0_CONFIG5      | 32
   MIPS  | KVM_REG_MIPS_CP0_CONFIG7      | 32
   MIPS  | KVM_REG_MIPS_CP0_ERROREPC     | 64
   MIPS  | KVM_REG_MIPS_COUNT_CTL        | 64
diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 6996447fd2a7..3f58ee1ebfab 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -48,6 +48,8 @@
 #define KVM_REG_MIPS_CP0_CONFIG1	MIPS_CP0_32(16, 1)
 #define KVM_REG_MIPS_CP0_CONFIG2	MIPS_CP0_32(16, 2)
 #define KVM_REG_MIPS_CP0_CONFIG3	MIPS_CP0_32(16, 3)
+#define KVM_REG_MIPS_CP0_CONFIG4	MIPS_CP0_32(16, 4)
+#define KVM_REG_MIPS_CP0_CONFIG5	MIPS_CP0_32(16, 5)
 #define KVM_REG_MIPS_CP0_CONFIG7	MIPS_CP0_32(16, 7)
 #define KVM_REG_MIPS_CP0_XCONTEXT	MIPS_CP0_64(20, 0)
 #define KVM_REG_MIPS_CP0_ERROREPC	MIPS_CP0_64(30, 0)
@@ -209,6 +211,8 @@ struct mips_coproc {
 #define MIPS_CP0_CONFIG1_SEL	1
 #define MIPS_CP0_CONFIG2_SEL	2
 #define MIPS_CP0_CONFIG3_SEL	3
+#define MIPS_CP0_CONFIG4_SEL	4
+#define MIPS_CP0_CONFIG5_SEL	5
 
 /* Config0 register bits */
 #define CP0C0_M			31
@@ -461,11 +465,15 @@ struct kvm_vcpu_arch {
 #define kvm_read_c0_guest_config1(cop0)		(cop0->reg[MIPS_CP0_CONFIG][1])
 #define kvm_read_c0_guest_config2(cop0)		(cop0->reg[MIPS_CP0_CONFIG][2])
 #define kvm_read_c0_guest_config3(cop0)		(cop0->reg[MIPS_CP0_CONFIG][3])
+#define kvm_read_c0_guest_config4(cop0)		(cop0->reg[MIPS_CP0_CONFIG][4])
+#define kvm_read_c0_guest_config5(cop0)		(cop0->reg[MIPS_CP0_CONFIG][5])
 #define kvm_read_c0_guest_config7(cop0)		(cop0->reg[MIPS_CP0_CONFIG][7])
 #define kvm_write_c0_guest_config(cop0, val)	(cop0->reg[MIPS_CP0_CONFIG][0] = (val))
 #define kvm_write_c0_guest_config1(cop0, val)	(cop0->reg[MIPS_CP0_CONFIG][1] = (val))
 #define kvm_write_c0_guest_config2(cop0, val)	(cop0->reg[MIPS_CP0_CONFIG][2] = (val))
 #define kvm_write_c0_guest_config3(cop0, val)	(cop0->reg[MIPS_CP0_CONFIG][3] = (val))
+#define kvm_write_c0_guest_config4(cop0, val)	(cop0->reg[MIPS_CP0_CONFIG][4] = (val))
+#define kvm_write_c0_guest_config5(cop0, val)	(cop0->reg[MIPS_CP0_CONFIG][5] = (val))
 #define kvm_write_c0_guest_config7(cop0, val)	(cop0->reg[MIPS_CP0_CONFIG][7] = (val))
 #define kvm_read_c0_guest_errorepc(cop0)	(cop0->reg[MIPS_CP0_ERROR_PC][0])
 #define kvm_write_c0_guest_errorepc(cop0, val)	(cop0->reg[MIPS_CP0_ERROR_PC][0] = (val))
@@ -735,6 +743,11 @@ enum emulation_result kvm_mips_emulate_load(uint32_t inst,
 					    struct kvm_run *run,
 					    struct kvm_vcpu *vcpu);
 
+unsigned int kvm_mips_config1_wrmask(struct kvm_vcpu *vcpu);
+unsigned int kvm_mips_config3_wrmask(struct kvm_vcpu *vcpu);
+unsigned int kvm_mips_config4_wrmask(struct kvm_vcpu *vcpu);
+unsigned int kvm_mips_config5_wrmask(struct kvm_vcpu *vcpu);
+
 /* Dynamic binary translation */
 extern int kvm_mips_trans_cache_index(uint32_t inst, uint32_t *opc,
 				      struct kvm_vcpu *vcpu);
diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index 33e132dc7de8..91d5b0e370b4 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -884,6 +884,58 @@ enum emulation_result kvm_mips_emul_tlbp(struct kvm_vcpu *vcpu)
 	return EMULATE_DONE;
 }
 
+/**
+ * kvm_mips_config1_wrmask() - Find mask of writable bits in guest Config1
+ * @vcpu:	Virtual CPU.
+ *
+ * Finds the mask of bits which are writable in the guest's Config1 CP0
+ * register, by userland (currently read-only to the guest).
+ */
+unsigned int kvm_mips_config1_wrmask(struct kvm_vcpu *vcpu)
+{
+	/* Read-only */
+	return 0;
+}
+
+/**
+ * kvm_mips_config3_wrmask() - Find mask of writable bits in guest Config3
+ * @vcpu:	Virtual CPU.
+ *
+ * Finds the mask of bits which are writable in the guest's Config3 CP0
+ * register, by userland (currently read-only to the guest).
+ */
+unsigned int kvm_mips_config3_wrmask(struct kvm_vcpu *vcpu)
+{
+	/* Config4 is optional */
+	return MIPS_CONF_M;
+}
+
+/**
+ * kvm_mips_config4_wrmask() - Find mask of writable bits in guest Config4
+ * @vcpu:	Virtual CPU.
+ *
+ * Finds the mask of bits which are writable in the guest's Config4 CP0
+ * register, by userland (currently read-only to the guest).
+ */
+unsigned int kvm_mips_config4_wrmask(struct kvm_vcpu *vcpu)
+{
+	/* Config5 is optional */
+	return MIPS_CONF_M;
+}
+
+/**
+ * kvm_mips_config5_wrmask() - Find mask of writable bits in guest Config5
+ * @vcpu:	Virtual CPU.
+ *
+ * Finds the mask of bits which are writable in the guest's Config5 CP0
+ * register, by the guest itself.
+ */
+unsigned int kvm_mips_config5_wrmask(struct kvm_vcpu *vcpu)
+{
+	/* Read-only */
+	return 0;
+}
+
 enum emulation_result kvm_mips_emulate_CP0(uint32_t inst, uint32_t *opc,
 					   uint32_t cause, struct kvm_run *run,
 					   struct kvm_vcpu *vcpu)
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 0aab83d894ba..73eecc779454 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -510,6 +510,8 @@ static u64 kvm_mips_get_one_regs[] = {
 	KVM_REG_MIPS_CP0_CONFIG1,
 	KVM_REG_MIPS_CP0_CONFIG2,
 	KVM_REG_MIPS_CP0_CONFIG3,
+	KVM_REG_MIPS_CP0_CONFIG4,
+	KVM_REG_MIPS_CP0_CONFIG5,
 	KVM_REG_MIPS_CP0_CONFIG7,
 	KVM_REG_MIPS_CP0_ERROREPC,
 
@@ -590,6 +592,12 @@ static int kvm_mips_get_reg(struct kvm_vcpu *vcpu,
 	case KVM_REG_MIPS_CP0_CONFIG3:
 		v = (long)kvm_read_c0_guest_config3(cop0);
 		break;
+	case KVM_REG_MIPS_CP0_CONFIG4:
+		v = (long)kvm_read_c0_guest_config4(cop0);
+		break;
+	case KVM_REG_MIPS_CP0_CONFIG5:
+		v = (long)kvm_read_c0_guest_config5(cop0);
+		break;
 	case KVM_REG_MIPS_CP0_CONFIG7:
 		v = (long)kvm_read_c0_guest_config7(cop0);
 		break;
@@ -701,6 +709,12 @@ static int kvm_mips_set_reg(struct kvm_vcpu *vcpu,
 	case KVM_REG_MIPS_CP0_COUNT:
 	case KVM_REG_MIPS_CP0_COMPARE:
 	case KVM_REG_MIPS_CP0_CAUSE:
+	case KVM_REG_MIPS_CP0_CONFIG:
+	case KVM_REG_MIPS_CP0_CONFIG1:
+	case KVM_REG_MIPS_CP0_CONFIG2:
+	case KVM_REG_MIPS_CP0_CONFIG3:
+	case KVM_REG_MIPS_CP0_CONFIG4:
+	case KVM_REG_MIPS_CP0_CONFIG5:
 	case KVM_REG_MIPS_COUNT_CTL:
 	case KVM_REG_MIPS_COUNT_RESUME:
 	case KVM_REG_MIPS_COUNT_HZ:
diff --git a/arch/mips/kvm/trap_emul.c b/arch/mips/kvm/trap_emul.c
index bffba002d1a4..8e0968428a78 100644
--- a/arch/mips/kvm/trap_emul.c
+++ b/arch/mips/kvm/trap_emul.c
@@ -418,8 +418,14 @@ static int kvm_trap_emul_vcpu_setup(struct kvm_vcpu *vcpu)
 	kvm_write_c0_guest_config2(cop0, MIPS_CONF_M);
 	/* MIPS_CONF_M | (read_c0_config2() & 0xfff) */
 
-	/* No config4, UserLocal */
-	kvm_write_c0_guest_config3(cop0, MIPS_CONF3_ULRI);
+	/* Have config4, UserLocal */
+	kvm_write_c0_guest_config3(cop0, MIPS_CONF_M | MIPS_CONF3_ULRI);
+
+	/* Have config5 */
+	kvm_write_c0_guest_config4(cop0, MIPS_CONF_M);
+
+	/* No config6 */
+	kvm_write_c0_guest_config5(cop0, 0);
 
 	/* Set Wait IE/IXMT Ignore in Config7, IAR, AR */
 	kvm_write_c0_guest_config7(cop0, (MIPS_CONF7_WII) | (1 << 10));
@@ -464,6 +470,7 @@ static int kvm_trap_emul_set_one_reg(struct kvm_vcpu *vcpu,
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	int ret = 0;
+	unsigned int cur, change;
 
 	switch (reg->id) {
 	case KVM_REG_MIPS_CP0_COUNT:
@@ -492,6 +499,44 @@ static int kvm_trap_emul_set_one_reg(struct kvm_vcpu *vcpu,
 			kvm_write_c0_guest_cause(cop0, v);
 		}
 		break;
+	case KVM_REG_MIPS_CP0_CONFIG:
+		/* read-only for now */
+		break;
+	case KVM_REG_MIPS_CP0_CONFIG1:
+		cur = kvm_read_c0_guest_config1(cop0);
+		change = (cur ^ v) & kvm_mips_config1_wrmask(vcpu);
+		if (change) {
+			v = cur ^ change;
+			kvm_write_c0_guest_config1(cop0, v);
+		}
+		break;
+	case KVM_REG_MIPS_CP0_CONFIG2:
+		/* read-only for now */
+		break;
+	case KVM_REG_MIPS_CP0_CONFIG3:
+		cur = kvm_read_c0_guest_config3(cop0);
+		change = (cur ^ v) & kvm_mips_config3_wrmask(vcpu);
+		if (change) {
+			v = cur ^ change;
+			kvm_write_c0_guest_config3(cop0, v);
+		}
+		break;
+	case KVM_REG_MIPS_CP0_CONFIG4:
+		cur = kvm_read_c0_guest_config4(cop0);
+		change = (cur ^ v) & kvm_mips_config4_wrmask(vcpu);
+		if (change) {
+			v = cur ^ change;
+			kvm_write_c0_guest_config4(cop0, v);
+		}
+		break;
+	case KVM_REG_MIPS_CP0_CONFIG5:
+		cur = kvm_read_c0_guest_config5(cop0);
+		change = (cur ^ v) & kvm_mips_config5_wrmask(vcpu);
+		if (change) {
+			v = cur ^ change;
+			kvm_write_c0_guest_config5(cop0, v);
+		}
+		break;
 	case KVM_REG_MIPS_COUNT_CTL:
 		ret = kvm_mips_set_count_ctl(vcpu, v);
 		break;
-- 
2.0.5
