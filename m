Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Mar 2017 10:49:01 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:31027 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993899AbdCBJhoca0Jt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Mar 2017 10:37:44 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 20F10F37D7F99;
        Thu,  2 Mar 2017 09:37:40 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 2 Mar 2017 09:37:41 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 31/32] KVM: MIPS/VZ: Support hardware guest timer
Date:   Thu, 2 Mar 2017 09:36:58 +0000
Message-ID: <a09adec8a4e780f504e4fcc4c1bff9c7d93beeab.1488447004.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.1
MIME-Version: 1.0
In-Reply-To: <cover.5cfb5298ebc2f5308f4f56aaac7fa31c39a8ab58.1488447004.git-series.james.hogan@imgtec.com>
References: <cover.5cfb5298ebc2f5308f4f56aaac7fa31c39a8ab58.1488447004.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56987
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

Transfer timer state to the VZ guest context (CP0_GTOffset & guest
CP0_Count) when entering guest mode, enabling direct guest access to it,
and transfer back to soft timer when saving guest register state.

This usually allows guest code to directly read CP0_Count (via MFC0 and
RDHWR) and read/write CP0_Compare, without trapping to the hypervisor
for it to emulate the guest timer. Writing to CP0_Count or CP0_Cause.DC
is much less common and still triggers a hypervisor GPSI exception, in
which case the timer state is transferred back to an hrtimer before
emulating the write.

We are careful to prevent small amounts of drift from building up due to
undeterministic time intervals between reading of the ktime and reading
of CP0_Count. Some drift is expected however, since the system
clocksource may use a different timer to the local CP0_Count timer used
by VZ. This is permitted to prevent guest CP0_Count from appearing to go
backwards.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h |  14 ++-
 arch/mips/kvm/emulate.c          |  81 ++++++++++++-
 arch/mips/kvm/mips.c             |   6 +-
 arch/mips/kvm/vz.c               | 197 ++++++++++++++++++++++++++++++--
 4 files changed, 287 insertions(+), 11 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 3b381b52fd6c..d9af9bafb18b 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -1071,6 +1071,20 @@ void kvm_mips_count_enable_cause(struct kvm_vcpu *vcpu);
 void kvm_mips_count_disable_cause(struct kvm_vcpu *vcpu);
 enum hrtimer_restart kvm_mips_count_timeout(struct kvm_vcpu *vcpu);
 
+/* fairly internal functions requiring some care to use */
+int kvm_mips_count_disabled(struct kvm_vcpu *vcpu);
+ktime_t kvm_mips_freeze_hrtimer(struct kvm_vcpu *vcpu, u32 *count);
+int kvm_mips_restore_hrtimer(struct kvm_vcpu *vcpu, ktime_t before,
+			     u32 count, int min_drift);
+
+#ifdef CONFIG_KVM_MIPS_VZ
+void kvm_vz_acquire_htimer(struct kvm_vcpu *vcpu);
+void kvm_vz_lose_htimer(struct kvm_vcpu *vcpu);
+#else
+static inline void kvm_vz_acquire_htimer(struct kvm_vcpu *vcpu) {}
+static inline void kvm_vz_lose_htimer(struct kvm_vcpu *vcpu) {}
+#endif
+
 enum emulation_result kvm_mips_check_privilege(u32 cause,
 					       u32 *opc,
 					       struct kvm_run *run,
diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index bb0449296cd6..2070864c8e48 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -308,7 +308,7 @@ int kvm_get_badinstrp(u32 *opc, struct kvm_vcpu *vcpu, u32 *out)
  *		CP0_Cause.DC bit or the count_ctl.DC bit.
  *		0 otherwise (in which case CP0_Count timer is running).
  */
-static inline int kvm_mips_count_disabled(struct kvm_vcpu *vcpu)
+int kvm_mips_count_disabled(struct kvm_vcpu *vcpu)
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 
@@ -467,7 +467,7 @@ u32 kvm_mips_read_count(struct kvm_vcpu *vcpu)
  *
  * Returns:	The ktime at the point of freeze.
  */
-static ktime_t kvm_mips_freeze_hrtimer(struct kvm_vcpu *vcpu, u32 *count)
+ktime_t kvm_mips_freeze_hrtimer(struct kvm_vcpu *vcpu, u32 *count)
 {
 	ktime_t now;
 
@@ -517,6 +517,82 @@ static void kvm_mips_resume_hrtimer(struct kvm_vcpu *vcpu,
 }
 
 /**
+ * kvm_mips_restore_hrtimer() - Restore hrtimer after a gap, updating expiry.
+ * @vcpu:	Virtual CPU.
+ * @before:	Time before Count was saved, lower bound of drift calculation.
+ * @count:	CP0_Count at point of restore.
+ * @min_drift:	Minimum amount of drift permitted before correction.
+ *		Must be <= 0.
+ *
+ * Restores the timer from a particular @count, accounting for drift. This can
+ * be used in conjunction with kvm_mips_freeze_timer() when a hardware timer is
+ * to be used for a period of time, but the exact ktime corresponding to the
+ * final Count that must be restored is not known.
+ *
+ * It is gauranteed that a timer interrupt immediately after restore will be
+ * handled, but not if CP0_Compare is exactly at @count. That case should
+ * already be handled when the hardware timer state is saved.
+ *
+ * Assumes !kvm_mips_count_disabled(@vcpu) (guest CP0_Count timer is not
+ * stopped).
+ *
+ * Returns:	Amount of correction to count_bias due to drift.
+ */
+int kvm_mips_restore_hrtimer(struct kvm_vcpu *vcpu, ktime_t before,
+			     u32 count, int min_drift)
+{
+	ktime_t now, count_time;
+	u32 now_count, before_count;
+	u64 delta;
+	int drift, ret = 0;
+
+	/* Calculate expected count at before */
+	before_count = vcpu->arch.count_bias +
+			kvm_mips_ktime_to_count(vcpu, before);
+
+	/*
+	 * Detect significantly negative drift, where count is lower than
+	 * expected. Some negative drift is expected when hardware counter is
+	 * set after kvm_mips_freeze_timer(), and it is harmless to allow the
+	 * time to jump forwards a little, within reason. If the drift is too
+	 * significant, adjust the bias to avoid a big Guest.CP0_Count jump.
+	 */
+	drift = count - before_count;
+	if (drift < min_drift) {
+		count_time = before;
+		vcpu->arch.count_bias += drift;
+		ret = drift;
+		goto resume;
+	}
+
+	/* Calculate expected count right now */
+	now = ktime_get();
+	now_count = vcpu->arch.count_bias + kvm_mips_ktime_to_count(vcpu, now);
+
+	/*
+	 * Detect positive drift, where count is higher than expected, and
+	 * adjust the bias to avoid guest time going backwards.
+	 */
+	drift = count - now_count;
+	if (drift > 0) {
+		count_time = now;
+		vcpu->arch.count_bias += drift;
+		ret = drift;
+		goto resume;
+	}
+
+	/* Subtract nanosecond delta to find ktime when count was read */
+	delta = (u64)(u32)(now_count - count);
+	delta = div_u64(delta * NSEC_PER_SEC, vcpu->arch.count_hz);
+	count_time = ktime_sub_ns(now, delta);
+
+resume:
+	/* Resume using the calculated ktime */
+	kvm_mips_resume_hrtimer(vcpu, count_time, count);
+	return ret;
+}
+
+/**
  * kvm_mips_write_count() - Modify the count and update timer.
  * @vcpu:	Virtual CPU.
  * @count:	Guest CP0_Count value to set.
@@ -897,6 +973,7 @@ enum emulation_result kvm_mips_emul_wait(struct kvm_vcpu *vcpu)
 	++vcpu->stat.wait_exits;
 	trace_kvm_exit(vcpu, KVM_TRACE_EXIT_WAIT);
 	if (!vcpu->arch.pending_exceptions) {
+		kvm_vz_lose_htimer(vcpu);
 		vcpu->arch.wait = 1;
 		kvm_vcpu_block(vcpu);
 
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 4296eba6f630..05b4714b25c2 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -1097,7 +1097,8 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 
 int kvm_cpu_has_pending_timer(struct kvm_vcpu *vcpu)
 {
-	return kvm_mips_pending_timer(vcpu);
+	return kvm_mips_pending_timer(vcpu) ||
+		kvm_read_c0_guest_cause(vcpu->arch.cop0) & C_TI;
 }
 
 int kvm_arch_vcpu_dump_regs(struct kvm_vcpu *vcpu)
@@ -1385,6 +1386,9 @@ int kvm_mips_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu)
 skip_emul:
 	local_irq_disable();
 
+	if (ret == RESUME_GUEST)
+		kvm_vz_acquire_htimer(vcpu);
+
 	if (er == EMULATE_DONE && !(ret & RESUME_HOST))
 		kvm_mips_deliver_interrupts(vcpu, cause);
 
diff --git a/arch/mips/kvm/vz.c b/arch/mips/kvm/vz.c
index c859295c0526..cfb3ad5d25d6 100644
--- a/arch/mips/kvm/vz.c
+++ b/arch/mips/kvm/vz.c
@@ -354,12 +354,37 @@ kvm_vz_irq_clear_cb(struct kvm_vcpu *vcpu, unsigned int priority, u32 cause)
  */
 
 /**
+ * kvm_vz_should_use_htimer() - Find whether to use the VZ hard guest timer.
+ * @vcpu:	Virtual CPU.
+ *
+ * Returns:	true if the VZ GTOffset & real guest CP0_Count should be used
+ *		instead of software emulation of guest timer.
+ *		false otherwise.
+ */
+static bool kvm_vz_should_use_htimer(struct kvm_vcpu *vcpu)
+{
+	if (kvm_mips_count_disabled(vcpu))
+		return false;
+
+	/* Chosen frequency must match real frequency */
+	if (mips_hpt_frequency != vcpu->arch.count_hz)
+		return false;
+
+	/* We don't support a CP0_GTOffset with fewer bits than CP0_Count */
+	if (current_cpu_data.gtoffset_mask != 0xffffffff)
+		return false;
+
+	return true;
+}
+
+/**
  * _kvm_vz_restore_stimer() - Restore soft timer state.
  * @vcpu:	Virtual CPU.
  * @compare:	CP0_Compare register value, restored by caller.
  * @cause:	CP0_Cause register to restore.
  *
- * Restore VZ state relating to the soft timer.
+ * Restore VZ state relating to the soft timer. The hard timer can be enabled
+ * later.
  */
 static void _kvm_vz_restore_stimer(struct kvm_vcpu *vcpu, u32 compare,
 				   u32 cause)
@@ -375,7 +400,47 @@ static void _kvm_vz_restore_stimer(struct kvm_vcpu *vcpu, u32 compare,
 }
 
 /**
- * kvm_vz_restore_timer() - Restore guest timer state.
+ * _kvm_vz_restore_htimer() - Restore hard timer state.
+ * @vcpu:	Virtual CPU.
+ * @compare:	CP0_Compare register value, restored by caller.
+ * @cause:	CP0_Cause register to restore.
+ *
+ * Restore hard timer Guest.Count & Guest.Cause taking care to preserve the
+ * value of Guest.CP0_Cause.TI while restoring Guest.CP0_Cause.
+ */
+static void _kvm_vz_restore_htimer(struct kvm_vcpu *vcpu,
+				   u32 compare, u32 cause)
+{
+	u32 start_count, after_count;
+	ktime_t freeze_time;
+	unsigned long flags;
+
+	/*
+	 * Freeze the soft-timer and sync the guest CP0_Count with it. We do
+	 * this with interrupts disabled to avoid latency.
+	 */
+	local_irq_save(flags);
+	freeze_time = kvm_mips_freeze_hrtimer(vcpu, &start_count);
+	write_c0_gtoffset(start_count - read_c0_count());
+	local_irq_restore(flags);
+
+	/* restore guest CP0_Cause, as TI may already be set */
+	back_to_back_c0_hazard();
+	write_gc0_cause(cause);
+
+	/*
+	 * The above sequence isn't atomic and would result in lost timer
+	 * interrupts if we're not careful. Detect if a timer interrupt is due
+	 * and assert it.
+	 */
+	back_to_back_c0_hazard();
+	after_count = read_gc0_count();
+	if (after_count - start_count > compare - start_count - 1)
+		kvm_vz_queue_irq(vcpu, MIPS_EXC_INT_TIMER);
+}
+
+/**
+ * kvm_vz_restore_timer() - Restore timer state.
  * @vcpu:	Virtual CPU.
  *
  * Restore soft timer state from saved context.
@@ -393,18 +458,104 @@ static void kvm_vz_restore_timer(struct kvm_vcpu *vcpu)
 }
 
 /**
+ * kvm_vz_acquire_htimer() - Switch to hard timer state.
+ * @vcpu:	Virtual CPU.
+ *
+ * Restore hard timer state on top of existing soft timer state if possible.
+ *
+ * Since hard timer won't remain active over preemption, preemption should be
+ * disabled by the caller.
+ */
+void kvm_vz_acquire_htimer(struct kvm_vcpu *vcpu)
+{
+	u32 gctl0;
+
+	gctl0 = read_c0_guestctl0();
+	if (!(gctl0 & MIPS_GCTL0_GT) && kvm_vz_should_use_htimer(vcpu)) {
+		/* enable guest access to hard timer */
+		write_c0_guestctl0(gctl0 | MIPS_GCTL0_GT);
+
+		_kvm_vz_restore_htimer(vcpu, read_gc0_compare(),
+				       read_gc0_cause());
+	}
+}
+
+/**
+ * _kvm_vz_save_htimer() - Switch to software emulation of guest timer.
+ * @vcpu:	Virtual CPU.
+ * @compare:	Pointer to write compare value to.
+ * @cause:	Pointer to write cause value to.
+ *
+ * Save VZ guest timer state and switch to software emulation of guest CP0
+ * timer. The hard timer must already be in use, so preemption should be
+ * disabled.
+ */
+static void _kvm_vz_save_htimer(struct kvm_vcpu *vcpu,
+				u32 *out_compare, u32 *out_cause)
+{
+	u32 cause, compare, before_count, end_count;
+	ktime_t before_time;
+
+	compare = read_gc0_compare();
+	*out_compare = compare;
+
+	before_time = ktime_get();
+
+	/*
+	 * Record the CP0_Count *prior* to saving CP0_Cause, so we have a time
+	 * at which no pending timer interrupt is missing.
+	 */
+	before_count = read_gc0_count();
+	back_to_back_c0_hazard();
+	cause = read_gc0_cause();
+	*out_cause = cause;
+
+	/*
+	 * Record a final CP0_Count which we will transfer to the soft-timer.
+	 * This is recorded *after* saving CP0_Cause, so we don't get any timer
+	 * interrupts from just after the final CP0_Count point.
+	 */
+	back_to_back_c0_hazard();
+	end_count = read_gc0_count();
+
+	/*
+	 * The above sequence isn't atomic, so we could miss a timer interrupt
+	 * between reading CP0_Cause and end_count. Detect and record any timer
+	 * interrupt due between before_count and end_count.
+	 */
+	if (end_count - before_count > compare - before_count - 1)
+		kvm_vz_queue_irq(vcpu, MIPS_EXC_INT_TIMER);
+
+	/*
+	 * Restore soft-timer, ignoring a small amount of negative drift due to
+	 * delay between freeze_hrtimer and setting CP0_GTOffset.
+	 */
+	kvm_mips_restore_hrtimer(vcpu, before_time, end_count, -0x10000);
+}
+
+/**
  * kvm_vz_save_timer() - Save guest timer state.
  * @vcpu:	Virtual CPU.
  *
- * Save VZ guest timer state.
+ * Save VZ guest timer state and switch to soft guest timer if hard timer was in
+ * use.
  */
 static void kvm_vz_save_timer(struct kvm_vcpu *vcpu)
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
-	u32 compare, cause;
+	u32 gctl0, compare, cause;
 
-	compare = read_gc0_compare();
-	cause = read_gc0_cause();
+	gctl0 = read_c0_guestctl0();
+	if (gctl0 & MIPS_GCTL0_GT) {
+		/* disable guest use of hard timer */
+		write_c0_guestctl0(gctl0 & ~MIPS_GCTL0_GT);
+
+		/* save hard timer state */
+		_kvm_vz_save_htimer(vcpu, &compare, &cause);
+	} else {
+		compare = read_gc0_compare();
+		cause = read_gc0_cause();
+	}
 
 	/* save timer-related state to VCPU context */
 	kvm_write_sw_gc0_cause(cop0, cause);
@@ -412,6 +563,32 @@ static void kvm_vz_save_timer(struct kvm_vcpu *vcpu)
 }
 
 /**
+ * kvm_vz_lose_htimer() - Ensure hard guest timer is not in use.
+ * @vcpu:	Virtual CPU.
+ *
+ * Transfers the state of the hard guest timer to the soft guest timer, leaving
+ * guest state intact so it can continue to be used with the soft timer.
+ */
+void kvm_vz_lose_htimer(struct kvm_vcpu *vcpu)
+{
+	u32 gctl0, compare, cause;
+
+	preempt_disable();
+	gctl0 = read_c0_guestctl0();
+	if (gctl0 & MIPS_GCTL0_GT) {
+		/* disable guest use of timer */
+		write_c0_guestctl0(gctl0 & ~MIPS_GCTL0_GT);
+
+		/* switch to soft timer */
+		_kvm_vz_save_htimer(vcpu, &compare, &cause);
+
+		/* leave soft timer in usable state */
+		_kvm_vz_restore_stimer(vcpu, compare, cause);
+	}
+	preempt_enable();
+}
+
+/**
  * is_eva_access() - Find whether an instruction is an EVA memory accessor.
  * @inst:	32-bit instruction encoding.
  *
@@ -826,6 +1003,7 @@ static enum emulation_result kvm_vz_gpsi_cop0(union mips_instruction inst,
 
 			if (rd == MIPS_CP0_COUNT &&
 			    sel == 0) {			/* Count */
+				kvm_vz_lose_htimer(vcpu);
 				kvm_mips_write_count(vcpu, vcpu->arch.gprs[rt]);
 			} else if (rd == MIPS_CP0_COMPARE &&
 				   sel == 0) {		/* Compare */
@@ -1090,10 +1268,12 @@ enum emulation_result kvm_trap_vz_handle_gsfc(u32 cause, u32 *opc,
 
 			/* DC bit enabling/disabling timer? */
 			if (change & CAUSEF_DC) {
-				if (val & CAUSEF_DC)
+				if (val & CAUSEF_DC) {
+					kvm_vz_lose_htimer(vcpu);
 					kvm_mips_count_disable_cause(vcpu);
-				else
+				} else {
 					kvm_mips_count_enable_cause(vcpu);
+				}
 			}
 
 			/* Only certain bits are RW to the guest */
@@ -2862,6 +3042,7 @@ static int kvm_vz_vcpu_run(struct kvm_run *run, struct kvm_vcpu *vcpu)
 	int cpu = smp_processor_id();
 	int r;
 
+	kvm_vz_acquire_htimer(vcpu);
 	/* Check if we have any exceptions/interrupts pending */
 	kvm_mips_deliver_interrupts(vcpu, read_gc0_cause());
 
-- 
git-series 0.8.10
