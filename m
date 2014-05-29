Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 May 2014 11:23:04 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:32004 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6834666AbaE2JRME9Psd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 May 2014 11:17:12 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 5DB69FE5B98BE;
        Thu, 29 May 2014 10:17:02 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Thu, 29 May 2014 10:17:04 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.101) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Thu, 29 May 2014 10:17:03 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        James Hogan <james.hogan@imgtec.com>,
        Gleb Natapov <gleb@kernel.org>, <kvm@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, Sanjay Lal <sanjayl@kymasys.com>
Subject: [PATCH v2 13/23] MIPS: KVM: Rewrite count/compare timer emulation
Date:   Thu, 29 May 2014 10:16:35 +0100
Message-ID: <1401355005-20370-14-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 40338
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

Previously the emulation of the CPU timer was just enough to get a Linux
guest running but some shortcuts were taken:
 - The guest timer interrupt was hard coded to always happen every 10 ms
   rather than being timed to when CP0_Count would match CP0_Compare.
 - The guest's CP0_Count register was based on the host's CP0_Count
   register. This isn't very portable and fails on cores without a
   CP_Count register implemented such as Ingenic XBurst. It also meant
   that the guest's CP0_Cause.DC bit to disable the CP0_Count register
   took no effect.
 - The guest's CP0_Count register was emulated by just dividing the
   host's CP0_Count register by 4. This resulted in continuity problems
   when used as a clock source, since when the host CP0_Count overflows
   from 0x7fffffff to 0x80000000, the guest CP0_Count transitions
   discontinuously from 0x1fffffff to 0xe0000000.

Therefore rewrite & fix emulation of the guest timer based on the
monotonic kernel time (i.e. ktime_get()). Internally a 32-bit count_bias
value is added to the frequency scaled nanosecond monotonic time to get
the guest's CP0_Count. The frequency of the timer is initialised to
100MHz and cannot yet be changed, but a later patch will allow the
frequency to be configured via the KVM_{GET,SET}_ONE_REG ioctl
interface.

The timer can now be stopped via the CP0_Cause.DC bit (by the guest or
via the KVM_SET_ONE_REG ioctl interface), at which point the current
CP0_Count is stored and can be read directly. When it is restarted the
bias is recalculated such that the CP0_Count value is continuous.

Due to the nature of hrtimer interrupts any read of the guest's
CP0_Count register while it is running triggers a check for whether the
hrtimer has expired, so that the guest/userland cannot observe the
CP0_Count passing CP0_Compare without queuing a timer interrupt. This is
also taken advantage of when stopping the timer to ensure that a pending
timer interrupt is queued.

This replaces the implementation of:
 - Guest read of CP0_Count
 - Guest write of CP0_Count
 - Guest write of CP0_Compare
 - Guest write of CP0_Cause
 - Guest read of HWR 2 (CC) with RDHWR
 - Host read of CP0_Count via KVM_GET_ONE_REG ioctl interface
 - Host write of CP0_Count via KVM_SET_ONE_REG ioctl interface
 - Host write of CP0_Compare via KVM_SET_ONE_REG ioctl interface
 - Host write of CP0_Cause via KVM_SET_ONE_REG ioctl interface

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: kvm@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: Sanjay Lal <sanjayl@kymasys.com>
---
 arch/mips/include/asm/kvm_host.h |  21 ++-
 arch/mips/kvm/kvm_mips.c         |  10 +-
 arch/mips/kvm/kvm_mips_emul.c    | 393 ++++++++++++++++++++++++++++++++++++---
 arch/mips/kvm/kvm_trap_emul.c    |  27 ++-
 4 files changed, 413 insertions(+), 38 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 79410f85a5a7..75ed94aeefe7 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -404,8 +404,15 @@ struct kvm_vcpu_arch {
 
 	u32 io_gpr;		/* GPR used as IO source/target */
 
-	/* Used to calibrate the virutal count register for the guest */
-	int32_t host_cp0_count;
+	struct hrtimer comparecount_timer;
+	/* Count bias from the raw time */
+	uint32_t count_bias;
+	/* Frequency of timer in Hz */
+	uint32_t count_hz;
+	/* Dynamic nanosecond bias (multiple of count_period) to avoid overflow */
+	s64 count_dyn_bias;
+	/* Period of timer tick in ns */
+	u64 count_period;
 
 	/* Bitmask of exceptions that are pending */
 	unsigned long pending_exceptions;
@@ -426,8 +433,6 @@ struct kvm_vcpu_arch {
 	uint32_t guest_kernel_asid[NR_CPUS];
 	struct mm_struct guest_kernel_mm, guest_user_mm;
 
-	struct hrtimer comparecount_timer;
-
 	int last_sched_cpu;
 
 	/* WAIT executed */
@@ -705,7 +710,13 @@ extern enum emulation_result kvm_mips_emulate_bp_exc(unsigned long cause,
 extern enum emulation_result kvm_mips_complete_mmio_load(struct kvm_vcpu *vcpu,
 							 struct kvm_run *run);
 
-enum emulation_result kvm_mips_emulate_count(struct kvm_vcpu *vcpu);
+uint32_t kvm_mips_read_count(struct kvm_vcpu *vcpu);
+void kvm_mips_write_count(struct kvm_vcpu *vcpu, uint32_t count);
+void kvm_mips_write_compare(struct kvm_vcpu *vcpu, uint32_t compare);
+void kvm_mips_init_count(struct kvm_vcpu *vcpu);
+void kvm_mips_count_enable_cause(struct kvm_vcpu *vcpu);
+void kvm_mips_count_disable_cause(struct kvm_vcpu *vcpu);
+enum hrtimer_restart kvm_mips_count_timeout(struct kvm_vcpu *vcpu);
 
 enum emulation_result kvm_mips_check_privilege(unsigned long cause,
 					       uint32_t *opc,
diff --git a/arch/mips/kvm/kvm_mips.c b/arch/mips/kvm/kvm_mips.c
index 2ca84e2efcea..a5f33cbc13ab 100644
--- a/arch/mips/kvm/kvm_mips.c
+++ b/arch/mips/kvm/kvm_mips.c
@@ -368,7 +368,7 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm, unsigned int id)
 	vcpu->arch.last_sched_cpu = -1;
 
 	/* Start off the timer */
-	kvm_mips_emulate_count(vcpu);
+	kvm_mips_init_count(vcpu);
 
 	return vcpu;
 
@@ -712,9 +712,6 @@ static int kvm_mips_set_reg(struct kvm_vcpu *vcpu,
 	case KVM_REG_MIPS_CP0_STATUS:
 		kvm_write_c0_guest_status(cop0, v);
 		break;
-	case KVM_REG_MIPS_CP0_CAUSE:
-		kvm_write_c0_guest_cause(cop0, v);
-		break;
 	case KVM_REG_MIPS_CP0_EPC:
 		kvm_write_c0_guest_epc(cop0, v);
 		break;
@@ -724,6 +721,7 @@ static int kvm_mips_set_reg(struct kvm_vcpu *vcpu,
 	/* registers to be handled specially */
 	case KVM_REG_MIPS_CP0_COUNT:
 	case KVM_REG_MIPS_CP0_COMPARE:
+	case KVM_REG_MIPS_CP0_CAUSE:
 		return kvm_mips_callbacks->set_one_reg(vcpu, reg, v);
 	default:
 		return -EINVAL;
@@ -997,9 +995,7 @@ enum hrtimer_restart kvm_mips_comparecount_wakeup(struct hrtimer *timer)
 
 	vcpu = container_of(timer, struct kvm_vcpu, arch.comparecount_timer);
 	kvm_mips_comparecount_func((unsigned long) vcpu);
-	hrtimer_forward_now(&vcpu->arch.comparecount_timer,
-			    ktime_set(0, MS_TO_NS(10)));
-	return HRTIMER_RESTART;
+	return kvm_mips_count_timeout(vcpu);
 }
 
 int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
diff --git a/arch/mips/kvm/kvm_mips_emul.c b/arch/mips/kvm/kvm_mips_emul.c
index bad31c6235d4..088c25d73a11 100644
--- a/arch/mips/kvm/kvm_mips_emul.c
+++ b/arch/mips/kvm/kvm_mips_emul.c
@@ -11,6 +11,7 @@
 
 #include <linux/errno.h>
 #include <linux/err.h>
+#include <linux/ktime.h>
 #include <linux/kvm_host.h>
 #include <linux/module.h>
 #include <linux/vmalloc.h>
@@ -228,25 +229,364 @@ enum emulation_result update_pc(struct kvm_vcpu *vcpu, uint32_t cause)
 	return er;
 }
 
-/* Everytime the compare register is written to, we need to decide when to fire
- * the timer that represents timer ticks to the GUEST.
+/**
+ * kvm_mips_count_disabled() - Find whether the CP0_Count timer is disabled.
+ * @vcpu:	Virtual CPU.
  *
+ * Returns:	1 if the CP0_Count timer is disabled by the guest CP0_Cause.DC
+ *		bit.
+ *		0 otherwise (in which case CP0_Count timer is running).
  */
-enum emulation_result kvm_mips_emulate_count(struct kvm_vcpu *vcpu)
+static inline int kvm_mips_count_disabled(struct kvm_vcpu *vcpu)
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
-	enum emulation_result er = EMULATE_DONE;
+	return kvm_read_c0_guest_cause(cop0) & CAUSEF_DC;
+}
 
-	/* If COUNT is enabled */
-	if (!(kvm_read_c0_guest_cause(cop0) & CAUSEF_DC)) {
-		hrtimer_try_to_cancel(&vcpu->arch.comparecount_timer);
-		hrtimer_start(&vcpu->arch.comparecount_timer,
-			      ktime_set(0, MS_TO_NS(10)), HRTIMER_MODE_REL);
-	} else {
-		hrtimer_try_to_cancel(&vcpu->arch.comparecount_timer);
+/**
+ * kvm_mips_ktime_to_count() - Scale ktime_t to a 32-bit count.
+ *
+ * Caches the dynamic nanosecond bias in vcpu->arch.count_dyn_bias.
+ *
+ * Assumes !kvm_mips_count_disabled(@vcpu) (guest CP0_Count timer is running).
+ */
+static uint32_t kvm_mips_ktime_to_count(struct kvm_vcpu *vcpu, ktime_t now)
+{
+	s64 now_ns, periods;
+	u64 delta;
+
+	now_ns = ktime_to_ns(now);
+	delta = now_ns + vcpu->arch.count_dyn_bias;
+
+	if (delta >= vcpu->arch.count_period) {
+		/* If delta is out of safe range the bias needs adjusting */
+		periods = div64_s64(now_ns, vcpu->arch.count_period);
+		vcpu->arch.count_dyn_bias = -periods * vcpu->arch.count_period;
+		/* Recalculate delta with new bias */
+		delta = now_ns + vcpu->arch.count_dyn_bias;
+	}
+
+	/*
+	 * We've ensured that:
+	 *   delta < count_period
+	 *
+	 * Therefore the intermediate delta*count_hz will never overflow since
+	 * at the boundary condition:
+	 *   delta = count_period
+	 *   delta = NSEC_PER_SEC * 2^32 / count_hz
+	 *   delta * count_hz = NSEC_PER_SEC * 2^32
+	 */
+	return div_u64(delta * vcpu->arch.count_hz, NSEC_PER_SEC);
+}
+
+/**
+ * kvm_mips_read_count_running() - Read the current count value as if running.
+ * @vcpu:	Virtual CPU.
+ * @now:	Kernel time to read CP0_Count at.
+ *
+ * Returns the current guest CP0_Count register at time @now and handles if the
+ * timer interrupt is pending and hasn't been handled yet.
+ *
+ * Returns:	The current value of the guest CP0_Count register.
+ */
+static uint32_t kvm_mips_read_count_running(struct kvm_vcpu *vcpu, ktime_t now)
+{
+	ktime_t expires;
+	int running;
+
+	/* Is the hrtimer pending? */
+	expires = hrtimer_get_expires(&vcpu->arch.comparecount_timer);
+	if (ktime_compare(now, expires) >= 0) {
+		/*
+		 * Cancel it while we handle it so there's no chance of
+		 * interference with the timeout handler.
+		 */
+		running = hrtimer_cancel(&vcpu->arch.comparecount_timer);
+
+		/* Nothing should be waiting on the timeout */
+		kvm_mips_callbacks->queue_timer_int(vcpu);
+
+		/*
+		 * Restart the timer if it was running based on the expiry time
+		 * we read, so that we don't push it back 2 periods.
+		 */
+		if (running) {
+			expires = ktime_add_ns(expires,
+					       vcpu->arch.count_period);
+			hrtimer_start(&vcpu->arch.comparecount_timer, expires,
+				      HRTIMER_MODE_ABS);
+		}
 	}
 
-	return er;
+	/* Return the biased and scaled guest CP0_Count */
+	return vcpu->arch.count_bias + kvm_mips_ktime_to_count(vcpu, now);
+}
+
+/**
+ * kvm_mips_read_count() - Read the current count value.
+ * @vcpu:	Virtual CPU.
+ *
+ * Read the current guest CP0_Count value, taking into account whether the timer
+ * is stopped.
+ *
+ * Returns:	The current guest CP0_Count value.
+ */
+uint32_t kvm_mips_read_count(struct kvm_vcpu *vcpu)
+{
+	struct mips_coproc *cop0 = vcpu->arch.cop0;
+
+	/* If count disabled just read static copy of count */
+	if (kvm_mips_count_disabled(vcpu))
+		return kvm_read_c0_guest_count(cop0);
+
+	return kvm_mips_read_count_running(vcpu, ktime_get());
+}
+
+/**
+ * kvm_mips_freeze_hrtimer() - Safely stop the hrtimer.
+ * @vcpu:	Virtual CPU.
+ * @count:	Output pointer for CP0_Count value at point of freeze.
+ *
+ * Freeze the hrtimer safely and return both the ktime and the CP0_Count value
+ * at the point it was frozen. It is guaranteed that any pending interrupts at
+ * the point it was frozen are handled, and none after that point.
+ *
+ * This is useful where the time/CP0_Count is needed in the calculation of the
+ * new parameters.
+ *
+ * Assumes !kvm_mips_count_disabled(@vcpu) (guest CP0_Count timer is running).
+ *
+ * Returns:	The ktime at the point of freeze.
+ */
+static ktime_t kvm_mips_freeze_hrtimer(struct kvm_vcpu *vcpu,
+				       uint32_t *count)
+{
+	ktime_t now;
+
+	/* stop hrtimer before finding time */
+	hrtimer_cancel(&vcpu->arch.comparecount_timer);
+	now = ktime_get();
+
+	/* find count at this point and handle pending hrtimer */
+	*count = kvm_mips_read_count_running(vcpu, now);
+
+	return now;
+}
+
+
+/**
+ * kvm_mips_resume_hrtimer() - Resume hrtimer, updating expiry.
+ * @vcpu:	Virtual CPU.
+ * @now:	ktime at point of resume.
+ * @count:	CP0_Count at point of resume.
+ *
+ * Resumes the timer and updates the timer expiry based on @now and @count.
+ * This can be used in conjunction with kvm_mips_freeze_timer() when timer
+ * parameters need to be changed.
+ *
+ * It is guaranteed that a timer interrupt immediately after resume will be
+ * handled, but not if CP_Compare is exactly at @count. That case is already
+ * handled by kvm_mips_freeze_timer().
+ *
+ * Assumes !kvm_mips_count_disabled(@vcpu) (guest CP0_Count timer is running).
+ */
+static void kvm_mips_resume_hrtimer(struct kvm_vcpu *vcpu,
+				    ktime_t now, uint32_t count)
+{
+	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	uint32_t compare;
+	u64 delta;
+	ktime_t expire;
+
+	/* Calculate timeout (wrap 0 to 2^32) */
+	compare = kvm_read_c0_guest_compare(cop0);
+	delta = (u64)(uint32_t)(compare - count - 1) + 1;
+	delta = div_u64(delta * NSEC_PER_SEC, vcpu->arch.count_hz);
+	expire = ktime_add_ns(now, delta);
+
+	/* Update hrtimer to use new timeout */
+	hrtimer_cancel(&vcpu->arch.comparecount_timer);
+	hrtimer_start(&vcpu->arch.comparecount_timer, expire, HRTIMER_MODE_ABS);
+}
+
+/**
+ * kvm_mips_update_hrtimer() - Update next expiry time of hrtimer.
+ * @vcpu:	Virtual CPU.
+ *
+ * Recalculates and updates the expiry time of the hrtimer. This can be used
+ * after timer parameters have been altered which do not depend on the time that
+ * the change occurs (in those cases kvm_mips_freeze_hrtimer() and
+ * kvm_mips_resume_hrtimer() are used directly).
+ *
+ * It is guaranteed that no timer interrupts will be lost in the process.
+ *
+ * Assumes !kvm_mips_count_disabled(@vcpu) (guest CP0_Count timer is running).
+ */
+static void kvm_mips_update_hrtimer(struct kvm_vcpu *vcpu)
+{
+	ktime_t now;
+	uint32_t count;
+
+	/*
+	 * freeze_hrtimer takes care of a timer interrupts <= count, and
+	 * resume_hrtimer the hrtimer takes care of a timer interrupts > count.
+	 */
+	now = kvm_mips_freeze_hrtimer(vcpu, &count);
+	kvm_mips_resume_hrtimer(vcpu, now, count);
+}
+
+/**
+ * kvm_mips_write_count() - Modify the count and update timer.
+ * @vcpu:	Virtual CPU.
+ * @count:	Guest CP0_Count value to set.
+ *
+ * Sets the CP0_Count value and updates the timer accordingly.
+ */
+void kvm_mips_write_count(struct kvm_vcpu *vcpu, uint32_t count)
+{
+	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	ktime_t now;
+
+	/* Calculate bias */
+	now = ktime_get();
+	vcpu->arch.count_bias = count - kvm_mips_ktime_to_count(vcpu, now);
+
+	if (kvm_mips_count_disabled(vcpu))
+		/* The timer's disabled, adjust the static count */
+		kvm_write_c0_guest_count(cop0, count);
+	else
+		/* Update timeout */
+		kvm_mips_resume_hrtimer(vcpu, now, count);
+}
+
+/**
+ * kvm_mips_init_count() - Initialise timer.
+ * @vcpu:	Virtual CPU.
+ *
+ * Initialise the timer to a sensible frequency, namely 100MHz, zero it, and set
+ * it going if it's enabled.
+ */
+void kvm_mips_init_count(struct kvm_vcpu *vcpu)
+{
+	/* 100 MHz */
+	vcpu->arch.count_hz = 100*1000*1000;
+	vcpu->arch.count_period = div_u64((u64)NSEC_PER_SEC << 32,
+					  vcpu->arch.count_hz);
+	vcpu->arch.count_dyn_bias = 0;
+
+	/* Starting at 0 */
+	kvm_mips_write_count(vcpu, 0);
+}
+
+/**
+ * kvm_mips_write_compare() - Modify compare and update timer.
+ * @vcpu:	Virtual CPU.
+ * @compare:	New CP0_Compare value.
+ *
+ * Update CP0_Compare to a new value and update the timeout.
+ */
+void kvm_mips_write_compare(struct kvm_vcpu *vcpu, uint32_t compare)
+{
+	struct mips_coproc *cop0 = vcpu->arch.cop0;
+
+	/* if unchanged, must just be an ack */
+	if (kvm_read_c0_guest_compare(cop0) == compare)
+		return;
+
+	/* Update compare */
+	kvm_write_c0_guest_compare(cop0, compare);
+
+	/* Update timeout if count enabled */
+	if (!kvm_mips_count_disabled(vcpu))
+		kvm_mips_update_hrtimer(vcpu);
+}
+
+/**
+ * kvm_mips_count_disable() - Disable count.
+ * @vcpu:	Virtual CPU.
+ *
+ * Disable the CP0_Count timer. A timer interrupt on or before the final stop
+ * time will be handled but not after.
+ *
+ * Assumes CP0_Count was previously enabled but now Guest.CP0_Cause.DC has been
+ * set (count disabled).
+ *
+ * Returns:	The time that the timer was stopped.
+ */
+static ktime_t kvm_mips_count_disable(struct kvm_vcpu *vcpu)
+{
+	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	uint32_t count;
+	ktime_t now;
+
+	/* Stop hrtimer */
+	hrtimer_cancel(&vcpu->arch.comparecount_timer);
+
+	/* Set the static count from the dynamic count, handling pending TI */
+	now = ktime_get();
+	count = kvm_mips_read_count_running(vcpu, now);
+	kvm_write_c0_guest_count(cop0, count);
+
+	return now;
+}
+
+/**
+ * kvm_mips_count_disable_cause() - Disable count using CP0_Cause.DC.
+ * @vcpu:	Virtual CPU.
+ *
+ * Disable the CP0_Count timer and set CP0_Cause.DC. A timer interrupt on or
+ * before the final stop time will be handled, but not after.
+ *
+ * Assumes CP0_Cause.DC is clear (count enabled).
+ */
+void kvm_mips_count_disable_cause(struct kvm_vcpu *vcpu)
+{
+	struct mips_coproc *cop0 = vcpu->arch.cop0;
+
+	kvm_set_c0_guest_cause(cop0, CAUSEF_DC);
+	kvm_mips_count_disable(vcpu);
+}
+
+/**
+ * kvm_mips_count_enable_cause() - Enable count using CP0_Cause.DC.
+ * @vcpu:	Virtual CPU.
+ *
+ * Enable the CP0_Count timer and clear CP0_Cause.DC. A timer interrupt after
+ * the start time will be handled, potentially before even returning, so the
+ * caller should be careful with ordering of CP0_Cause modifications so as not
+ * to lose it.
+ *
+ * Assumes CP0_Cause.DC is set (count disabled).
+ */
+void kvm_mips_count_enable_cause(struct kvm_vcpu *vcpu)
+{
+	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	uint32_t count;
+
+	kvm_clear_c0_guest_cause(cop0, CAUSEF_DC);
+
+	/*
+	 * Set the dynamic count to match the static count.
+	 * This starts the hrtimer.
+	 */
+	count = kvm_read_c0_guest_count(cop0);
+	kvm_mips_write_count(vcpu, count);
+}
+
+/**
+ * kvm_mips_count_timeout() - Push timer forward on timeout.
+ * @vcpu:	Virtual CPU.
+ *
+ * Handle an hrtimer event by push the hrtimer forward a period.
+ *
+ * Returns:	The hrtimer_restart value to return to the hrtimer subsystem.
+ */
+enum hrtimer_restart kvm_mips_count_timeout(struct kvm_vcpu *vcpu)
+{
+	/* Add the Count period to the current expiry time */
+	hrtimer_add_expires_ns(&vcpu->arch.comparecount_timer,
+			       vcpu->arch.count_period);
+	return HRTIMER_RESTART;
 }
 
 enum emulation_result kvm_mips_emul_eret(struct kvm_vcpu *vcpu)
@@ -471,8 +811,7 @@ kvm_mips_emulate_CP0(uint32_t inst, uint32_t *opc, uint32_t cause,
 #endif
 			/* Get reg */
 			if ((rd == MIPS_CP0_COUNT) && (sel == 0)) {
-				/* XXXKYMA: Run the Guest count register @ 1/4 the rate of the host */
-				vcpu->arch.gprs[rt] = (read_c0_count() >> 2);
+				vcpu->arch.gprs[rt] = kvm_mips_read_count(vcpu);
 			} else if ((rd == MIPS_CP0_ERRCTL) && (sel == 0)) {
 				vcpu->arch.gprs[rt] = 0x0;
 #ifdef CONFIG_KVM_MIPS_DYN_TRANS
@@ -539,10 +878,7 @@ kvm_mips_emulate_CP0(uint32_t inst, uint32_t *opc, uint32_t cause,
 			}
 			/* Are we writing to COUNT */
 			else if ((rd == MIPS_CP0_COUNT) && (sel == 0)) {
-				/* Linux doesn't seem to write into COUNT, we throw an error
-				 * if we notice a write to COUNT
-				 */
-				/*er = EMULATE_FAIL; */
+				kvm_mips_write_count(vcpu, vcpu->arch.gprs[rt]);
 				goto done;
 			} else if ((rd == MIPS_CP0_COMPARE) && (sel == 0)) {
 				kvm_debug("[%#x] MTCz, COMPARE %#lx <- %#lx\n",
@@ -552,8 +888,8 @@ kvm_mips_emulate_CP0(uint32_t inst, uint32_t *opc, uint32_t cause,
 				/* If we are writing to COMPARE */
 				/* Clear pending timer interrupt, if any */
 				kvm_mips_callbacks->dequeue_timer_int(vcpu);
-				kvm_write_c0_guest_compare(cop0,
-							   vcpu->arch.gprs[rt]);
+				kvm_mips_write_compare(vcpu,
+						       vcpu->arch.gprs[rt]);
 			} else if ((rd == MIPS_CP0_STATUS) && (sel == 0)) {
 				kvm_write_c0_guest_status(cop0,
 							  vcpu->arch.gprs[rt]);
@@ -564,6 +900,20 @@ kvm_mips_emulate_CP0(uint32_t inst, uint32_t *opc, uint32_t cause,
 #ifdef CONFIG_KVM_MIPS_DYN_TRANS
 				kvm_mips_trans_mtc0(inst, opc, vcpu);
 #endif
+			} else if ((rd == MIPS_CP0_CAUSE) && (sel == 0)) {
+				uint32_t old_cause, new_cause;
+				old_cause = kvm_read_c0_guest_cause(cop0);
+				new_cause = vcpu->arch.gprs[rt];
+				/* Update R/W bits */
+				kvm_change_c0_guest_cause(cop0, 0x08800300,
+							  new_cause);
+				/* DC bit enabling/disabling timer? */
+				if ((old_cause ^ new_cause) & CAUSEF_DC) {
+					if (new_cause & CAUSEF_DC)
+						kvm_mips_count_disable_cause(vcpu);
+					else
+						kvm_mips_count_enable_cause(vcpu);
+				}
 			} else {
 				cop0->reg[rd][sel] = vcpu->arch.gprs[rt];
 #ifdef CONFIG_KVM_MIPS_DYN_TRANS
@@ -1553,8 +1903,7 @@ kvm_mips_handle_ri(unsigned long cause, uint32_t *opc,
 					     current_cpu_data.icache.linesz);
 			break;
 		case 2:	/* Read count register */
-			printk("RDHWR: Cont register\n");
-			arch->gprs[rt] = kvm_read_c0_guest_count(cop0);
+			arch->gprs[rt] = kvm_mips_read_count(vcpu);
 			break;
 		case 3:	/* Count register resolution */
 			switch (current_cpu_data.cputype) {
diff --git a/arch/mips/kvm/kvm_trap_emul.c b/arch/mips/kvm/kvm_trap_emul.c
index f1e8389f8d33..9908f2b0ff46 100644
--- a/arch/mips/kvm/kvm_trap_emul.c
+++ b/arch/mips/kvm/kvm_trap_emul.c
@@ -407,8 +407,7 @@ static int kvm_trap_emul_get_one_reg(struct kvm_vcpu *vcpu,
 {
 	switch (reg->id) {
 	case KVM_REG_MIPS_CP0_COUNT:
-		/* XXXKYMA: Run the Guest count register @ 1/4 the rate of the host */
-		*v = (read_c0_count() >> 2);
+		*v = kvm_mips_read_count(vcpu);
 		break;
 	default:
 		return -EINVAL;
@@ -424,10 +423,30 @@ static int kvm_trap_emul_set_one_reg(struct kvm_vcpu *vcpu,
 
 	switch (reg->id) {
 	case KVM_REG_MIPS_CP0_COUNT:
-		/* Not supported yet */
+		kvm_mips_write_count(vcpu, v);
 		break;
 	case KVM_REG_MIPS_CP0_COMPARE:
-		kvm_write_c0_guest_compare(cop0, v);
+		kvm_mips_write_compare(vcpu, v);
+		break;
+	case KVM_REG_MIPS_CP0_CAUSE:
+		/*
+		 * If the timer is stopped or started (DC bit) it must look
+		 * atomic with changes to the interrupt pending bits (TI, IRQ5).
+		 * A timer interrupt should not happen in between.
+		 */
+		if ((kvm_read_c0_guest_cause(cop0) ^ v) & CAUSEF_DC) {
+			if (v & CAUSEF_DC) {
+				/* disable timer first */
+				kvm_mips_count_disable_cause(vcpu);
+				kvm_change_c0_guest_cause(cop0, ~CAUSEF_DC, v);
+			} else {
+				/* enable timer last */
+				kvm_change_c0_guest_cause(cop0, ~CAUSEF_DC, v);
+				kvm_mips_count_enable_cause(vcpu);
+			}
+		} else {
+			kvm_write_c0_guest_cause(cop0, v);
+		}
 		break;
 	default:
 		return -EINVAL;
-- 
1.9.3
