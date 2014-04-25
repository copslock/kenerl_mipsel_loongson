Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Apr 2014 17:27:42 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.115]:8635 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6843062AbaDYPUssk7qN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 Apr 2014 17:20:48 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id E48A48986AB4D;
        Fri, 25 Apr 2014 16:20:38 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Fri, 25 Apr 2014 16:20:41 +0100
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
Subject: [PATCH 15/21] MIPS: KVM: Add count frequency KVM register
Date:   Fri, 25 Apr 2014 16:19:58 +0100
Message-ID: <1398439204-26171-16-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 39944
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

Expose the KVM guest CP0_Count frequency to userland via a new
KVM_REG_MIPS_COUNT_HZ register accessible with the KVM_{GET,SET}_ONE_REG
ioctls.

When the frequency is altered the bias is adjusted such that the guest
CP0_Count doesn't jump discontinuously or lose any timer interrupts.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: kvm@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: David Daney <david.daney@cavium.com>
Cc: Sanjay Lal <sanjayl@kymasys.com>
---
 arch/mips/include/asm/kvm_host.h |  1 +
 arch/mips/include/uapi/asm/kvm.h |  7 +++++
 arch/mips/kvm/kvm_mips.c         |  3 +++
 arch/mips/kvm/kvm_mips_emul.c    | 58 ++++++++++++++++++++++++++++++++++++++++
 arch/mips/kvm/kvm_trap_emul.c    |  6 +++++
 5 files changed, 75 insertions(+)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 2a7d4e1be25a..94a7299e1f6c 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -721,6 +721,7 @@ void kvm_mips_write_compare(struct kvm_vcpu *vcpu, uint32_t compare);
 void kvm_mips_init_count(struct kvm_vcpu *vcpu);
 int kvm_mips_set_count_ctl(struct kvm_vcpu *vcpu, s64 count_ctl);
 void kvm_mips_set_count_user_bias(struct kvm_vcpu *vcpu, s64 user_bias);
+int kvm_mips_set_count_hz(struct kvm_vcpu *vcpu, s64 count_hz);
 void kvm_mips_migrate_count(struct kvm_vcpu *vcpu);
 void kvm_mips_count_enable_cause(struct kvm_vcpu *vcpu);
 void kvm_mips_count_disable_cause(struct kvm_vcpu *vcpu);
diff --git a/arch/mips/include/uapi/asm/kvm.h b/arch/mips/include/uapi/asm/kvm.h
index c3d9f6697885..f9487f8b3394 100644
--- a/arch/mips/include/uapi/asm/kvm.h
+++ b/arch/mips/include/uapi/asm/kvm.h
@@ -138,6 +138,13 @@ struct kvm_fpu {
  */
 #define KVM_REG_MIPS_COUNT_BIAS		(KVM_REG_MIPS | KVM_REG_SIZE_U64 | \
 					 0x20000 | 2)
+/*
+ * CP0_Count rate in Hz
+ * Specifies the rate of the CP0_Count timer in Hz. Modifications occur without
+ * discontinuities in CP0_Count.
+ */
+#define KVM_REG_MIPS_COUNT_HZ		(KVM_REG_MIPS | KVM_REG_SIZE_U64 | \
+					 0x20000 | 3)
 
 /*
  * KVM MIPS specific structures and definitions
diff --git a/arch/mips/kvm/kvm_mips.c b/arch/mips/kvm/kvm_mips.c
index 9efb9d4c0882..cbb3cdca2878 100644
--- a/arch/mips/kvm/kvm_mips.c
+++ b/arch/mips/kvm/kvm_mips.c
@@ -550,6 +550,7 @@ static u64 kvm_mips_get_one_regs[] = {
 	KVM_REG_MIPS_COUNT_CTL,
 	KVM_REG_MIPS_COUNT_RESUME,
 	KVM_REG_MIPS_COUNT_BIAS,
+	KVM_REG_MIPS_COUNT_HZ,
 };
 
 static int kvm_mips_get_reg(struct kvm_vcpu *vcpu,
@@ -626,6 +627,7 @@ static int kvm_mips_get_reg(struct kvm_vcpu *vcpu,
 	case KVM_REG_MIPS_COUNT_CTL:
 	case KVM_REG_MIPS_COUNT_RESUME:
 	case KVM_REG_MIPS_COUNT_BIAS:
+	case KVM_REG_MIPS_COUNT_HZ:
 		ret = kvm_mips_callbacks->get_one_reg(vcpu, reg, &v);
 		if (ret)
 			return ret;
@@ -718,6 +720,7 @@ static int kvm_mips_set_reg(struct kvm_vcpu *vcpu,
 	case KVM_REG_MIPS_COUNT_CTL:
 	case KVM_REG_MIPS_COUNT_RESUME:
 	case KVM_REG_MIPS_COUNT_BIAS:
+	case KVM_REG_MIPS_COUNT_HZ:
 		return kvm_mips_callbacks->set_one_reg(vcpu, reg, v);
 	default:
 		return -EINVAL;
diff --git a/arch/mips/kvm/kvm_mips_emul.c b/arch/mips/kvm/kvm_mips_emul.c
index 8397f6b3a327..fcbc5ff6c347 100644
--- a/arch/mips/kvm/kvm_mips_emul.c
+++ b/arch/mips/kvm/kvm_mips_emul.c
@@ -546,6 +546,64 @@ void kvm_mips_set_count_user_bias(struct kvm_vcpu *vcpu, s64 user_bias)
 }
 
 /**
+ * kvm_mips_set_count_hz() - Update the frequency of the timer.
+ * @vcpu:	Virtual CPU.
+ * @count_hz:	Frequency of CP0_Count timer in Hz.
+ *
+ * Change the frequency of the CP0_Count timer. This is done atomically so that
+ * CP0_Count is continuous and no timer interrupt is lost.
+ *
+ * Returns:	-EINVAL if @count_hz is out of range.
+ *		0 on success.
+ */
+int kvm_mips_set_count_hz(struct kvm_vcpu *vcpu, s64 count_hz)
+{
+	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	int dc;
+	ktime_t now;
+	u32 count, bias;
+	s64 user_bias;
+
+	/* ensure the frequency is in a sensible range... */
+	if (count_hz <= 0 || count_hz > NSEC_PER_SEC)
+		return -EINVAL;
+	/* ... and has actually changed */
+	if (vcpu->arch.count_hz == count_hz)
+		return 0;
+
+	/* Safely freeze timer so we can keep it continuous */
+	dc = kvm_mips_count_disabled(vcpu);
+	if (dc) {
+		now = kvm_mips_count_time(vcpu);
+		count = kvm_read_c0_guest_count(cop0);
+	} else {
+		now = kvm_mips_freeze_hrtimer(vcpu, &count);
+	}
+
+	/* Update the frequency */
+	vcpu->arch.count_hz = count_hz;
+	vcpu->arch.count_period = div_u64((u64)NSEC_PER_SEC << 32, count_hz);
+	vcpu->arch.count_dyn_bias = 0;
+
+	/* Calculate adjusted bias so dynamic count is unchanged */
+	bias = count - kvm_mips_ktime_to_count(vcpu, now);
+
+	/* Calculate matching user-visible nanosecond bias */
+	user_bias = vcpu->arch.count_dyn_bias +
+			div_u64((u64)bias * NSEC_PER_SEC, count_hz);
+	if (ktime_to_ns(now) + user_bias >= vcpu->arch.count_period)
+		user_bias -= vcpu->arch.count_period;
+
+	vcpu->arch.count_bias = bias;
+	vcpu->arch.count_user_bias = user_bias;
+
+	/* Update and resume hrtimer */
+	if (!dc)
+		kvm_mips_resume_hrtimer(vcpu, now, count);
+	return 0;
+}
+
+/**
  * kvm_mips_write_compare() - Modify compare and update timer.
  * @vcpu:	Virtual CPU.
  * @compare:	New CP0_Compare value.
diff --git a/arch/mips/kvm/kvm_trap_emul.c b/arch/mips/kvm/kvm_trap_emul.c
index 7aedc822ac09..30cef8e6da81 100644
--- a/arch/mips/kvm/kvm_trap_emul.c
+++ b/arch/mips/kvm/kvm_trap_emul.c
@@ -418,6 +418,9 @@ static int kvm_trap_emul_get_one_reg(struct kvm_vcpu *vcpu,
 	case KVM_REG_MIPS_COUNT_BIAS:
 		*v = vcpu->arch.count_user_bias;
 		break;
+	case KVM_REG_MIPS_COUNT_HZ:
+		*v = vcpu->arch.count_hz;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -464,6 +467,9 @@ static int kvm_trap_emul_set_one_reg(struct kvm_vcpu *vcpu,
 	case KVM_REG_MIPS_COUNT_BIAS:
 		kvm_mips_set_count_user_bias(vcpu, v);
 		break;
+	case KVM_REG_MIPS_COUNT_HZ:
+		ret = kvm_mips_set_count_hz(vcpu, v);
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
1.8.1.2
