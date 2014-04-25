Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Apr 2014 17:27:19 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.115]:61178 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6843060AbaDYPUro4gNM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 Apr 2014 17:20:47 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 5D5EF23153BAB;
        Fri, 25 Apr 2014 16:20:37 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Fri, 25 Apr 2014 16:20:39 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.65) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Fri, 25 Apr 2014 16:20:39 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     James Hogan <james.hogan@imgtec.com>,
        Gleb Natapov <gleb@kernel.org>, <kvm@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, David Daney <david.daney@cavium.com>,
        Sanjay Lal <sanjayl@kymasys.com>
Subject: [PATCH 13/21] MIPS: KVM: Add master disable count interface
Date:   Fri, 25 Apr 2014 16:19:56 +0100
Message-ID: <1398439204-26171-14-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 39943
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

Expose two new virtual registers to userland via the
KVM_{GET,SET}_ONE_REG ioctls.

KVM_REG_MIPS_COUNT_CTL is for timer configuration fields and just
contains a master disable count bit. This can be used by userland to
freeze the timer in order to read a consistent state from the timer
count value and timer interrupt pending bit. This cannot be done with
the CP0_Cause.DC bit because the timer interrupt pending bit (TI) is
also in CP0_Cause so it would be impossible to stop the timer without
also risking a race with an hrtimer interrupt and having to explicitly
check whether an interrupt should have occurred.

When the timer is re-enabled it resumes without losing time, i.e. the
CP0_Count value jumps to what it would have been had the timer not been
disabled, which would also be impossible to do from userland with
CP0_Cause.DC. The timer interrupt also cannot be lost, i.e. if a timer
interrupt would have occurred had the timer not been disabled it is
queued when the timer is re-enabled.

This works by storing the nanosecond monotonic time when the master
disable is set, and using it for various operations instead of the
current monotonic time (e.g. when recalculating the bias when the
CP0_Count is set), until the master disable is cleared again, i.e. the
timer state is read/written as it would have been at that time. This
state is exposed to userland via the read-only KVM_REG_MIPS_COUNT_RESUME
virtual register so that userland can determine the exact time the
master disable took effect.

This should allow userland to atomically save the state of the timer,
and later restore it.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: kvm@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: David Daney <david.daney@cavium.com>
Cc: Sanjay Lal <sanjayl@kymasys.com>
---
 arch/mips/include/asm/kvm_host.h |   5 ++
 arch/mips/include/uapi/asm/kvm.h |  24 +++++++++
 arch/mips/kvm/kvm_mips.c         |   9 +++-
 arch/mips/kvm/kvm_mips_emul.c    | 108 ++++++++++++++++++++++++++++++++++-----
 arch/mips/kvm/kvm_trap_emul.c    |  12 ++++-
 5 files changed, 144 insertions(+), 14 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 57c1085fd6ab..8a6b8f6f44bc 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -405,12 +405,16 @@ struct kvm_vcpu_arch {
 	u32 io_gpr;		/* GPR used as IO source/target */
 
 	struct hrtimer comparecount_timer;
+	/* Count timer control KVM register */
+	uint32_t count_ctl;
 	/* Count bias from the raw time */
 	uint32_t count_bias;
 	/* Frequency of timer in Hz */
 	uint32_t count_hz;
 	/* Dynamic nanosecond bias (multiple of count_period) to avoid overflow */
 	s64 count_dyn_bias;
+	/* Resume time */
+	ktime_t count_resume;
 	/* Period of timer tick in ns */
 	u64 count_period;
 
@@ -713,6 +717,7 @@ uint32_t kvm_mips_read_count(struct kvm_vcpu *vcpu);
 void kvm_mips_write_count(struct kvm_vcpu *vcpu, uint32_t count);
 void kvm_mips_write_compare(struct kvm_vcpu *vcpu, uint32_t compare);
 void kvm_mips_init_count(struct kvm_vcpu *vcpu);
+int kvm_mips_set_count_ctl(struct kvm_vcpu *vcpu, s64 count_ctl);
 void kvm_mips_migrate_count(struct kvm_vcpu *vcpu);
 void kvm_mips_count_enable_cause(struct kvm_vcpu *vcpu);
 void kvm_mips_count_disable_cause(struct kvm_vcpu *vcpu);
diff --git a/arch/mips/include/uapi/asm/kvm.h b/arch/mips/include/uapi/asm/kvm.h
index f09ff5ae2059..1ddc7d7d412a 100644
--- a/arch/mips/include/uapi/asm/kvm.h
+++ b/arch/mips/include/uapi/asm/kvm.h
@@ -106,6 +106,30 @@ struct kvm_fpu {
 #define KVM_REG_MIPS_LO (KVM_REG_MIPS | KVM_REG_SIZE_U64 | 33)
 #define KVM_REG_MIPS_PC (KVM_REG_MIPS | KVM_REG_SIZE_U64 | 34)
 
+/* KVM specific control registers */
+
+/*
+ * CP0_Count control
+ * DC:    Set 0: Master disable CP0_Count and set COUNT_RESUME to now
+ *        Set 1: Master re-enable CP0_Count with unchanged bias, handling timer
+ *               interrupts since COUNT_RESUME
+ *        This can be used to freeze the timer to get a consistent snapshot of
+ *        the CP0_Count and timer interrupt pending state, while also resuming
+ *        safely without losing time or guest timer interrupts.
+ * Other: Reserved, do not change.
+ */
+#define KVM_REG_MIPS_COUNT_CTL		(KVM_REG_MIPS | KVM_REG_SIZE_U64 | \
+					 0x20000 | 0)
+#define KVM_REG_MIPS_COUNT_CTL_DC	0x00000001
+/*
+ * CP0_Count resume monotonic nanoseconds
+ * The monotonic nanosecond time of the last set of COUNT_CTL.DC (master
+ * disable). When COUNT_CTL.DC is cleared again (master enable) any timer
+ * interrupts since this time will be emulated.
+ */
+#define KVM_REG_MIPS_COUNT_RESUME	(KVM_REG_MIPS | KVM_REG_SIZE_U64 | \
+					 0x20000 | 1)
+
 /*
  * KVM MIPS specific structures and definitions
  *
diff --git a/arch/mips/kvm/kvm_mips.c b/arch/mips/kvm/kvm_mips.c
index b32e05efe8b7..f99f8c323b9e 100644
--- a/arch/mips/kvm/kvm_mips.c
+++ b/arch/mips/kvm/kvm_mips.c
@@ -545,7 +545,10 @@ static u64 kvm_mips_get_one_regs[] = {
 	KVM_REG_MIPS_CP0_CONFIG2,
 	KVM_REG_MIPS_CP0_CONFIG3,
 	KVM_REG_MIPS_CP0_CONFIG7,
-	KVM_REG_MIPS_CP0_ERROREPC
+	KVM_REG_MIPS_CP0_ERROREPC,
+
+	KVM_REG_MIPS_COUNT_CTL,
+	KVM_REG_MIPS_COUNT_RESUME,
 };
 
 static int kvm_mips_get_reg(struct kvm_vcpu *vcpu,
@@ -619,6 +622,8 @@ static int kvm_mips_get_reg(struct kvm_vcpu *vcpu,
 		break;
 	/* registers to be handled specially */
 	case KVM_REG_MIPS_CP0_COUNT:
+	case KVM_REG_MIPS_COUNT_CTL:
+	case KVM_REG_MIPS_COUNT_RESUME:
 		ret = kvm_mips_callbacks->get_one_reg(vcpu, reg, &v);
 		if (ret)
 			return ret;
@@ -708,6 +713,8 @@ static int kvm_mips_set_reg(struct kvm_vcpu *vcpu,
 	case KVM_REG_MIPS_CP0_COUNT:
 	case KVM_REG_MIPS_CP0_COMPARE:
 	case KVM_REG_MIPS_CP0_CAUSE:
+	case KVM_REG_MIPS_COUNT_CTL:
+	case KVM_REG_MIPS_COUNT_RESUME:
 		return kvm_mips_callbacks->set_one_reg(vcpu, reg, v);
 	default:
 		return -EINVAL;
diff --git a/arch/mips/kvm/kvm_mips_emul.c b/arch/mips/kvm/kvm_mips_emul.c
index 8ebfd675a3a1..d68af25ffa7f 100644
--- a/arch/mips/kvm/kvm_mips_emul.c
+++ b/arch/mips/kvm/kvm_mips_emul.c
@@ -233,14 +233,15 @@ enum emulation_result update_pc(struct kvm_vcpu *vcpu, uint32_t cause)
  * kvm_mips_count_disabled() - Find whether the CP0_Count timer is disabled.
  * @vcpu:	Virtual CPU.
  *
- * Returns:	1 if the CP0_Count timer is disabled by the guest CP0_Cause.DC
- *		bit.
+ * Returns:	1 if the CP0_Count timer is disabled by either the guest
+ *		CP0_Cause.DC bit or the count_ctl.DC bit.
  *		0 otherwise (in which case CP0_Count timer is running).
  */
 static inline int kvm_mips_count_disabled(struct kvm_vcpu *vcpu)
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
-	return kvm_read_c0_guest_cause(cop0) & CAUSEF_DC;
+	return	(vcpu->arch.count_ctl & KVM_REG_MIPS_COUNT_CTL_DC) ||
+		(kvm_read_c0_guest_cause(cop0) & CAUSEF_DC);
 }
 
 /**
@@ -280,6 +281,24 @@ static uint32_t kvm_mips_ktime_to_count(struct kvm_vcpu *vcpu, ktime_t now)
 }
 
 /**
+ * kvm_mips_count_time() - Get effective current time.
+ * @vcpu:	Virtual CPU.
+ *
+ * Get effective monotonic ktime. This is usually a straightforward ktime_get(),
+ * except when the master disable bit is set in count_ctl, in which case it is
+ * count_resume, i.e. the time that the count was disabled.
+ *
+ * Returns:	Effective monotonic ktime for CP0_Count.
+ */
+static inline ktime_t kvm_mips_count_time(struct kvm_vcpu *vcpu)
+{
+	if (unlikely(vcpu->arch.count_ctl & KVM_REG_MIPS_COUNT_CTL_DC))
+		return vcpu->arch.count_resume;
+
+	return ktime_get();
+}
+
+/**
  * kvm_mips_read_count_running() - Read the current count value as if running.
  * @vcpu:	Virtual CPU.
  * @now:	Kernel time to read CP0_Count at.
@@ -449,7 +468,7 @@ void kvm_mips_write_count(struct kvm_vcpu *vcpu, uint32_t count)
 	u32 bias;
 
 	/* Calculate bias */
-	now = ktime_get();
+	now = kvm_mips_count_time(vcpu);
 	bias = count - kvm_mips_ktime_to_count(vcpu, now);
 	vcpu->arch.count_bias = bias;
 
@@ -527,8 +546,8 @@ void kvm_mips_migrate_count(struct kvm_vcpu *vcpu)
  * Disable the CP0_Count timer. A timer interrupt on or before the final stop
  * time will be handled but not after.
  *
- * Assumes CP0_Count was previously enabled but now Guest.CP0_Cause.DC has been
- * set (count disabled).
+ * Assumes CP0_Count was previously enabled but now Guest.CP0_Cause.DC or
+ * count_ctl.DC has been set (count disabled).
  *
  * Returns:	The time that the timer was stopped.
  */
@@ -554,7 +573,8 @@ static ktime_t kvm_mips_count_disable(struct kvm_vcpu *vcpu)
  * @vcpu:	Virtual CPU.
  *
  * Disable the CP0_Count timer and set CP0_Cause.DC. A timer interrupt on or
- * before the final stop time will be handled, but not after.
+ * before the final stop time will be handled if the timer isn't disabled by
+ * count_ctl.DC, but not after.
  *
  * Assumes CP0_Cause.DC is clear (count enabled).
  */
@@ -563,7 +583,8 @@ void kvm_mips_count_disable_cause(struct kvm_vcpu *vcpu)
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 
 	kvm_set_c0_guest_cause(cop0, CAUSEF_DC);
-	kvm_mips_count_disable(vcpu);
+	if (!(vcpu->arch.count_ctl & KVM_REG_MIPS_COUNT_CTL_DC))
+		kvm_mips_count_disable(vcpu);
 }
 
 /**
@@ -571,9 +592,9 @@ void kvm_mips_count_disable_cause(struct kvm_vcpu *vcpu)
  * @vcpu:	Virtual CPU.
  *
  * Enable the CP0_Count timer and clear CP0_Cause.DC. A timer interrupt after
- * the start time will be handled, potentially before even returning, so the
- * caller should be careful with ordering of CP0_Cause modifications so as not
- * to lose it.
+ * the start time will be handled if the timer isn't disabled by count_ctl.DC,
+ * potentially before even returning, so the caller should be careful with
+ * ordering of CP0_Cause modifications so as not to lose it.
  *
  * Assumes CP0_Cause.DC is set (count disabled).
  */
@@ -586,13 +607,76 @@ void kvm_mips_count_enable_cause(struct kvm_vcpu *vcpu)
 
 	/*
 	 * Set the dynamic count to match the static count.
-	 * This starts the hrtimer.
+	 * This starts the hrtimer if count_ctl.DC allows it.
+	 * Otherwise it conveniently updates the biases.
 	 */
 	count = kvm_read_c0_guest_count(cop0);
 	kvm_mips_write_count(vcpu, count);
 }
 
 /**
+ * kvm_mips_set_count_ctl() - Update the count control KVM register.
+ * @vcpu:	Virtual CPU.
+ * @count_ctl:	Count control register new value.
+ *
+ * Set the count control KVM register. The timer is updated accordingly.
+ *
+ * Returns:	-EINVAL if reserved bits are set.
+ *		0 on success.
+ */
+int kvm_mips_set_count_ctl(struct kvm_vcpu *vcpu, s64 count_ctl)
+{
+	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	s64 changed = count_ctl ^ vcpu->arch.count_ctl;
+	s64 delta;
+	ktime_t expire, now;
+	uint32_t count, compare;
+
+	/* Only allow defined bits to be changed */
+	if (changed & ~(s64)(KVM_REG_MIPS_COUNT_CTL_DC))
+		return -EINVAL;
+
+	/* Apply new value */
+	vcpu->arch.count_ctl = count_ctl;
+
+	/* Master CP0_Count disable */
+	if (changed & KVM_REG_MIPS_COUNT_CTL_DC) {
+		/* Is CP0_Cause.DC already disabling CP0_Count? */
+		if (kvm_read_c0_guest_cause(cop0) & CAUSEF_DC) {
+			if (count_ctl & KVM_REG_MIPS_COUNT_CTL_DC)
+				/* Just record the current time */
+				vcpu->arch.count_resume = ktime_get();
+		} else if (count_ctl & KVM_REG_MIPS_COUNT_CTL_DC) {
+			/* disable timer and record current time */
+			vcpu->arch.count_resume = kvm_mips_count_disable(vcpu);
+		} else {
+			/*
+			 * Calculate timeout relative to static count at resume
+			 * time (wrap 0 to 2^32).
+			 */
+			count = kvm_read_c0_guest_count(cop0);
+			compare = kvm_read_c0_guest_compare(cop0);
+			delta = (u64)(uint32_t)(compare - count - 1) + 1;
+			delta = div_u64(delta * NSEC_PER_SEC,
+					vcpu->arch.count_hz);
+			expire = ktime_add_ns(vcpu->arch.count_resume, delta);
+
+			/* Handle pending interrupt */
+			now = ktime_get();
+			if (ktime_compare(now, expire) >= 0)
+				/* Nothing should be waiting on the timeout */
+				kvm_mips_callbacks->queue_timer_int(vcpu);
+
+			/* Resume hrtimer without changing bias */
+			count = kvm_mips_read_count_running(vcpu, now);
+			kvm_mips_resume_hrtimer(vcpu, now, count);
+		}
+	}
+
+	return 0;
+}
+
+/**
  * kvm_mips_count_timeout() - Push timer forward on timeout.
  * @vcpu:	Virtual CPU.
  *
diff --git a/arch/mips/kvm/kvm_trap_emul.c b/arch/mips/kvm/kvm_trap_emul.c
index 9908f2b0ff46..36fb52f55b11 100644
--- a/arch/mips/kvm/kvm_trap_emul.c
+++ b/arch/mips/kvm/kvm_trap_emul.c
@@ -409,6 +409,12 @@ static int kvm_trap_emul_get_one_reg(struct kvm_vcpu *vcpu,
 	case KVM_REG_MIPS_CP0_COUNT:
 		*v = kvm_mips_read_count(vcpu);
 		break;
+	case KVM_REG_MIPS_COUNT_CTL:
+		*v = vcpu->arch.count_ctl;
+		break;
+	case KVM_REG_MIPS_COUNT_RESUME:
+		*v = ktime_to_ns(vcpu->arch.count_resume);
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -420,6 +426,7 @@ static int kvm_trap_emul_set_one_reg(struct kvm_vcpu *vcpu,
 				     s64 v)
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	int ret = 0;
 
 	switch (reg->id) {
 	case KVM_REG_MIPS_CP0_COUNT:
@@ -448,10 +455,13 @@ static int kvm_trap_emul_set_one_reg(struct kvm_vcpu *vcpu,
 			kvm_write_c0_guest_cause(cop0, v);
 		}
 		break;
+	case KVM_REG_MIPS_COUNT_CTL:
+		ret = kvm_mips_set_count_ctl(vcpu, v);
+		break;
 	default:
 		return -EINVAL;
 	}
-	return 0;
+	return ret;
 }
 
 static struct kvm_mips_callbacks kvm_trap_emul_callbacks = {
-- 
1.8.1.2
