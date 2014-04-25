Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Apr 2014 17:24:05 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.114]:5134 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6842534AbaDYPUnKyMbG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 Apr 2014 17:20:43 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id D0FB6C93FD0F2;
        Fri, 25 Apr 2014 16:20:37 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Fri, 25 Apr
 2014 16:20:40 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Fri, 25 Apr 2014 16:20:40 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.65) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Fri, 25 Apr 2014 16:20:40 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     James Hogan <james.hogan@imgtec.com>,
        Gleb Natapov <gleb@kernel.org>, <kvm@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, David Daney <david.daney@cavium.com>,
        Sanjay Lal <sanjayl@kymasys.com>
Subject: [PATCH 14/21] MIPS: KVM: Add nanosecond count bias KVM register
Date:   Fri, 25 Apr 2014 16:19:57 +0100
Message-ID: <1398439204-26171-15-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <1398439204-26171-1-git-send-email-james.hogan@imgtec.com>
References: <1398439204-26171-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.65]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39934
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

Expose the KVM guest CP0_Count bias (from the monotonic kernel time) to
userland in nanosecond units via a new KVM_REG_MIPS_COUNT_BIAS register
accessible with the KVM_{GET,SET}_ONE_REG ioctls. This gives userland
control of the bias so that it can exactly match its own monotonic time.

The nanosecond bias is stored separately from the raw bias used
internally (since nanoseconds isn't a convenient or efficient unit for
various timer calculations), and is recalculated each time the raw count
bias is altered. The raw count bias used in CP0_Count determination is
recalculated when the nanosecond bias is altered via the KVM_SET_ONE_REG
ioctl.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: kvm@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: David Daney <david.daney@cavium.com>
Cc: Sanjay Lal <sanjayl@kymasys.com>
---
 arch/mips/include/asm/kvm_host.h |  3 +++
 arch/mips/include/uapi/asm/kvm.h |  9 ++++++++
 arch/mips/kvm/kvm_mips.c         |  3 +++
 arch/mips/kvm/kvm_mips_emul.c    | 46 ++++++++++++++++++++++++++++++++++++++++
 arch/mips/kvm/kvm_trap_emul.c    |  6 ++++++
 5 files changed, 67 insertions(+)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 8a6b8f6f44bc..2a7d4e1be25a 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -413,6 +413,8 @@ struct kvm_vcpu_arch {
 	uint32_t count_hz;
 	/* Dynamic nanosecond bias (multiple of count_period) to avoid overflow */
 	s64 count_dyn_bias;
+	/* Userland nanosecond bias */
+	s64 count_user_bias;
 	/* Resume time */
 	ktime_t count_resume;
 	/* Period of timer tick in ns */
@@ -718,6 +720,7 @@ void kvm_mips_write_count(struct kvm_vcpu *vcpu, uint32_t count);
 void kvm_mips_write_compare(struct kvm_vcpu *vcpu, uint32_t compare);
 void kvm_mips_init_count(struct kvm_vcpu *vcpu);
 int kvm_mips_set_count_ctl(struct kvm_vcpu *vcpu, s64 count_ctl);
+void kvm_mips_set_count_user_bias(struct kvm_vcpu *vcpu, s64 user_bias);
 void kvm_mips_migrate_count(struct kvm_vcpu *vcpu);
 void kvm_mips_count_enable_cause(struct kvm_vcpu *vcpu);
 void kvm_mips_count_disable_cause(struct kvm_vcpu *vcpu);
diff --git a/arch/mips/include/uapi/asm/kvm.h b/arch/mips/include/uapi/asm/kvm.h
index 1ddc7d7d412a..c3d9f6697885 100644
--- a/arch/mips/include/uapi/asm/kvm.h
+++ b/arch/mips/include/uapi/asm/kvm.h
@@ -129,6 +129,15 @@ struct kvm_fpu {
  */
 #define KVM_REG_MIPS_COUNT_RESUME	(KVM_REG_MIPS | KVM_REG_SIZE_U64 | \
 					 0x20000 | 1)
+/*
+ * CP0_Count bias against monotonic nanoseconds
+ * This bias added to monotonic nanoseconds and scaled by the frequency gives
+ * the CP0_Count value.
+ * Modified automatically by other changes to CP0_Count.
+ * Modification can result in discontinuous changes in CP0_Count.
+ */
+#define KVM_REG_MIPS_COUNT_BIAS		(KVM_REG_MIPS | KVM_REG_SIZE_U64 | \
+					 0x20000 | 2)
 
 /*
  * KVM MIPS specific structures and definitions
diff --git a/arch/mips/kvm/kvm_mips.c b/arch/mips/kvm/kvm_mips.c
index f99f8c323b9e..9efb9d4c0882 100644
--- a/arch/mips/kvm/kvm_mips.c
+++ b/arch/mips/kvm/kvm_mips.c
@@ -549,6 +549,7 @@ static u64 kvm_mips_get_one_regs[] = {
 
 	KVM_REG_MIPS_COUNT_CTL,
 	KVM_REG_MIPS_COUNT_RESUME,
+	KVM_REG_MIPS_COUNT_BIAS,
 };
 
 static int kvm_mips_get_reg(struct kvm_vcpu *vcpu,
@@ -624,6 +625,7 @@ static int kvm_mips_get_reg(struct kvm_vcpu *vcpu,
 	case KVM_REG_MIPS_CP0_COUNT:
 	case KVM_REG_MIPS_COUNT_CTL:
 	case KVM_REG_MIPS_COUNT_RESUME:
+	case KVM_REG_MIPS_COUNT_BIAS:
 		ret = kvm_mips_callbacks->get_one_reg(vcpu, reg, &v);
 		if (ret)
 			return ret;
@@ -715,6 +717,7 @@ static int kvm_mips_set_reg(struct kvm_vcpu *vcpu,
 	case KVM_REG_MIPS_CP0_CAUSE:
 	case KVM_REG_MIPS_COUNT_CTL:
 	case KVM_REG_MIPS_COUNT_RESUME:
+	case KVM_REG_MIPS_COUNT_BIAS:
 		return kvm_mips_callbacks->set_one_reg(vcpu, reg, v);
 	default:
 		return -EINVAL;
diff --git a/arch/mips/kvm/kvm_mips_emul.c b/arch/mips/kvm/kvm_mips_emul.c
index d68af25ffa7f..8397f6b3a327 100644
--- a/arch/mips/kvm/kvm_mips_emul.c
+++ b/arch/mips/kvm/kvm_mips_emul.c
@@ -466,11 +466,20 @@ void kvm_mips_write_count(struct kvm_vcpu *vcpu, uint32_t count)
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	ktime_t now;
 	u32 bias;
+	s64 user_bias;
 
 	/* Calculate bias */
 	now = kvm_mips_count_time(vcpu);
 	bias = count - kvm_mips_ktime_to_count(vcpu, now);
+
+	/* Calculate matching user-visible nanosecond bias */
+	user_bias = vcpu->arch.count_dyn_bias +
+			div_u64((u64)bias * NSEC_PER_SEC, vcpu->arch.count_hz);
+	if (ktime_to_ns(now) + user_bias >= vcpu->arch.count_period)
+		user_bias -= vcpu->arch.count_period;
+
 	vcpu->arch.count_bias = bias;
+	vcpu->arch.count_user_bias = user_bias;
 
 	if (kvm_mips_count_disabled(vcpu))
 		/* The timer's disabled, adjust the static count */
@@ -500,6 +509,43 @@ void kvm_mips_init_count(struct kvm_vcpu *vcpu)
 }
 
 /**
+ * kvm_mips_set_count_user_bias() - Set the ns user visible timer bias.
+ * @vcpu:	Virtual CPU.
+ * @user_bias:	User bias in nanoseconds.
+ *
+ * Set the user provided nanosecond bias of the CP0_Count timer, updating the
+ * timer accordingly.
+ */
+void kvm_mips_set_count_user_bias(struct kvm_vcpu *vcpu, s64 user_bias)
+{
+	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	ktime_t now;
+	s64 periods;
+	uint32_t count;
+
+	/* Save new user bias unaltered */
+	vcpu->arch.count_user_bias = user_bias;
+
+	/* Adjust ns bias to be within +/- period */
+	periods = div64_s64(user_bias, vcpu->arch.count_period);
+	user_bias -= periods * vcpu->arch.count_period;
+
+	/* Adjust count_bias = user_bias*hz/1e9 */
+	vcpu->arch.count_bias = div_s64(user_bias * vcpu->arch.count_hz,
+					NSEC_PER_SEC);
+
+	if (kvm_mips_count_disabled(vcpu)) {
+		/* The timer's disabled, adjust the static count */
+		now = kvm_mips_count_time(vcpu);
+		count = kvm_mips_read_count_running(vcpu, now);
+		kvm_write_c0_guest_count(cop0, count);
+	} else {
+		/* Update timeout */
+		kvm_mips_update_hrtimer(vcpu);
+	}
+}
+
+/**
  * kvm_mips_write_compare() - Modify compare and update timer.
  * @vcpu:	Virtual CPU.
  * @compare:	New CP0_Compare value.
diff --git a/arch/mips/kvm/kvm_trap_emul.c b/arch/mips/kvm/kvm_trap_emul.c
index 36fb52f55b11..7aedc822ac09 100644
--- a/arch/mips/kvm/kvm_trap_emul.c
+++ b/arch/mips/kvm/kvm_trap_emul.c
@@ -415,6 +415,9 @@ static int kvm_trap_emul_get_one_reg(struct kvm_vcpu *vcpu,
 	case KVM_REG_MIPS_COUNT_RESUME:
 		*v = ktime_to_ns(vcpu->arch.count_resume);
 		break;
+	case KVM_REG_MIPS_COUNT_BIAS:
+		*v = vcpu->arch.count_user_bias;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -458,6 +461,9 @@ static int kvm_trap_emul_set_one_reg(struct kvm_vcpu *vcpu,
 	case KVM_REG_MIPS_COUNT_CTL:
 		ret = kvm_mips_set_count_ctl(vcpu, v);
 		break;
+	case KVM_REG_MIPS_COUNT_BIAS:
+		kvm_mips_set_count_user_bias(vcpu, v);
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
1.8.1.2
