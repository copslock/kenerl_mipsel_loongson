Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Aug 2016 20:14:50 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39235 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993074AbcHMSOnOJfhD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 13 Aug 2016 20:14:43 +0200
Received: from 92.40.249.202.threembb.co.uk ([92.40.249.202] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1bYdSD-0004jg-Dy; Sat, 13 Aug 2016 19:14:41 +0100
Received: from ben by deadeye with local (Exim 4.87)
        (envelope-from <ben@decadent.org.uk>)
        id 1bYd3f-0002t8-Bo; Sat, 13 Aug 2016 18:49:19 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Ralf Baechle" <ralf@linux-mips.org>,
        "James Hogan" <james.hogan@imgtec.com>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org,
        "Radim =?UTF-8?Q?Kr=C3=84=C2=8Dm=C3=83=C2=A1=C3=85=E2=84=A2?=" 
        <rkrcmar@redhat.com>, "Paolo Bonzini" <pbonzini@redhat.com>
Date:   Sat, 13 Aug 2016 18:42:51 +0100
Message-ID: <lsq.1471110171.57632095@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 062/305] MIPS: KVM: Fix timer IRQ race when writing
 CP0_Compare
In-Reply-To: <lsq.1471110169.907390585@decadent.org.uk>
X-SA-Exim-Connect-IP: 92.40.249.202
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54528
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.16.37-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <james.hogan@imgtec.com>

commit b45bacd2d048f405c7760e5cc9b60dd67708734f upstream.

Writing CP0_Compare clears the timer interrupt pending bit
(CP0_Cause.TI), but this wasn't being done atomically. If a timer
interrupt raced with the write of the guest CP0_Compare, the timer
interrupt could end up being pending even though the new CP0_Compare is
nowhere near CP0_Count.

We were already updating the hrtimer expiry with
kvm_mips_update_hrtimer(), which used both kvm_mips_freeze_hrtimer() and
kvm_mips_resume_hrtimer(). Close the race window by expanding out
kvm_mips_update_hrtimer(), and clearing CP0_Cause.TI and setting
CP0_Compare between the freeze and resume. Since the pending timer
interrupt should not be cleared when CP0_Compare is written via the KVM
user API, an ack argument is added to distinguish the source of the
write.

Fixes: e30492bbe95a ("MIPS: KVM: Rewrite count/compare timer emulation")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim KrÄmÃ¡Å™" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[bwh: Backported to 3.16: adjust filenames]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/include/asm/kvm_host.h |  2 +-
 arch/mips/kvm/kvm_mips_emul.c    | 61 ++++++++++++++++++----------------------
 arch/mips/kvm/kvm_trap_emul.c    |  2 +-
 3 files changed, 29 insertions(+), 36 deletions(-)

--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -718,7 +718,7 @@ extern enum emulation_result kvm_mips_co
 
 uint32_t kvm_mips_read_count(struct kvm_vcpu *vcpu);
 void kvm_mips_write_count(struct kvm_vcpu *vcpu, uint32_t count);
-void kvm_mips_write_compare(struct kvm_vcpu *vcpu, uint32_t compare);
+void kvm_mips_write_compare(struct kvm_vcpu *vcpu, uint32_t compare, bool ack);
 void kvm_mips_init_count(struct kvm_vcpu *vcpu);
 int kvm_mips_set_count_ctl(struct kvm_vcpu *vcpu, s64 count_ctl);
 int kvm_mips_set_count_resume(struct kvm_vcpu *vcpu, s64 count_resume);
--- a/arch/mips/kvm/kvm_mips_emul.c
+++ b/arch/mips/kvm/kvm_mips_emul.c
@@ -447,32 +447,6 @@ static void kvm_mips_resume_hrtimer(stru
 }
 
 /**
- * kvm_mips_update_hrtimer() - Update next expiry time of hrtimer.
- * @vcpu:	Virtual CPU.
- *
- * Recalculates and updates the expiry time of the hrtimer. This can be used
- * after timer parameters have been altered which do not depend on the time that
- * the change occurs (in those cases kvm_mips_freeze_hrtimer() and
- * kvm_mips_resume_hrtimer() are used directly).
- *
- * It is guaranteed that no timer interrupts will be lost in the process.
- *
- * Assumes !kvm_mips_count_disabled(@vcpu) (guest CP0_Count timer is running).
- */
-static void kvm_mips_update_hrtimer(struct kvm_vcpu *vcpu)
-{
-	ktime_t now;
-	uint32_t count;
-
-	/*
-	 * freeze_hrtimer takes care of a timer interrupts <= count, and
-	 * resume_hrtimer the hrtimer takes care of a timer interrupts > count.
-	 */
-	now = kvm_mips_freeze_hrtimer(vcpu, &count);
-	kvm_mips_resume_hrtimer(vcpu, now, count);
-}
-
-/**
  * kvm_mips_write_count() - Modify the count and update timer.
  * @vcpu:	Virtual CPU.
  * @count:	Guest CP0_Count value to set.
@@ -567,23 +541,42 @@ int kvm_mips_set_count_hz(struct kvm_vcp
  * kvm_mips_write_compare() - Modify compare and update timer.
  * @vcpu:	Virtual CPU.
  * @compare:	New CP0_Compare value.
+ * @ack:	Whether to acknowledge timer interrupt.
  *
  * Update CP0_Compare to a new value and update the timeout.
+ * If @ack, atomically acknowledge any pending timer interrupt, otherwise ensure
+ * any pending timer interrupt is preserved.
  */
-void kvm_mips_write_compare(struct kvm_vcpu *vcpu, uint32_t compare)
+void kvm_mips_write_compare(struct kvm_vcpu *vcpu, uint32_t compare, bool ack)
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	int dc;
+	u32 old_compare = kvm_read_c0_guest_compare(cop0);
+	ktime_t now;
+	uint32_t count;
 
 	/* if unchanged, must just be an ack */
-	if (kvm_read_c0_guest_compare(cop0) == compare)
+	if (old_compare == compare) {
+		if (!ack)
+			return;
+		kvm_mips_callbacks->dequeue_timer_int(vcpu);
+		kvm_write_c0_guest_compare(cop0, compare);
 		return;
+	}
+
+	/* freeze_hrtimer() takes care of timer interrupts <= count */
+	dc = kvm_mips_count_disabled(vcpu);
+	if (!dc)
+		now = kvm_mips_freeze_hrtimer(vcpu, &count);
+
+	if (ack)
+		kvm_mips_callbacks->dequeue_timer_int(vcpu);
 
-	/* Update compare */
 	kvm_write_c0_guest_compare(cop0, compare);
 
-	/* Update timeout if count enabled */
-	if (!kvm_mips_count_disabled(vcpu))
-		kvm_mips_update_hrtimer(vcpu);
+	/* resume_hrtimer() takes care of timer interrupts > count */
+	if (!dc)
+		kvm_mips_resume_hrtimer(vcpu, now, count);
 }
 
 /**
@@ -1061,9 +1054,9 @@ kvm_mips_emulate_CP0(uint32_t inst, uint
 
 				/* If we are writing to COMPARE */
 				/* Clear pending timer interrupt, if any */
-				kvm_mips_callbacks->dequeue_timer_int(vcpu);
 				kvm_mips_write_compare(vcpu,
-						       vcpu->arch.gprs[rt]);
+						       vcpu->arch.gprs[rt],
+						       true);
 			} else if ((rd == MIPS_CP0_STATUS) && (sel == 0)) {
 				kvm_write_c0_guest_status(cop0,
 							  vcpu->arch.gprs[rt]);
--- a/arch/mips/kvm/kvm_trap_emul.c
+++ b/arch/mips/kvm/kvm_trap_emul.c
@@ -451,7 +451,7 @@ static int kvm_trap_emul_set_one_reg(str
 		kvm_mips_write_count(vcpu, v);
 		break;
 	case KVM_REG_MIPS_CP0_COMPARE:
-		kvm_mips_write_compare(vcpu, v);
+		kvm_mips_write_compare(vcpu, v, false);
 		break;
 	case KVM_REG_MIPS_CP0_CAUSE:
 		/*
