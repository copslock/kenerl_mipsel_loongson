Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 May 2016 23:11:41 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:42269 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27040250AbcE3VLWoXT2l (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 May 2016 23:11:22 +0200
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A4627943;
        Mon, 30 May 2016 21:11:16 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C3=84=C2=8Dm=C3=83=C2=A1=C3=85=E2=84=A2?= 
        <rkrcmar@redhat.com>, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org, kvm@vger.kernel.org
Subject: [PATCH 4.6 065/100] MIPS: KVM: Fix timer IRQ race when writing CP0_Compare
Date:   Mon, 30 May 2016 13:50:00 -0700
Message-Id: <20160530204910.537181422@linuxfoundation.org>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20160530204908.422037419@linuxfoundation.org>
References: <20160530204908.422037419@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53710
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.6-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/include/asm/kvm_host.h |    2 -
 arch/mips/kvm/emulate.c          |   61 +++++++++++++++++----------------------
 arch/mips/kvm/trap_emul.c        |    2 -
 3 files changed, 29 insertions(+), 36 deletions(-)

--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -747,7 +747,7 @@ extern enum emulation_result kvm_mips_co
 
 uint32_t kvm_mips_read_count(struct kvm_vcpu *vcpu);
 void kvm_mips_write_count(struct kvm_vcpu *vcpu, uint32_t count);
-void kvm_mips_write_compare(struct kvm_vcpu *vcpu, uint32_t compare);
+void kvm_mips_write_compare(struct kvm_vcpu *vcpu, uint32_t compare, bool ack);
 void kvm_mips_init_count(struct kvm_vcpu *vcpu);
 int kvm_mips_set_count_ctl(struct kvm_vcpu *vcpu, s64 count_ctl);
 int kvm_mips_set_count_resume(struct kvm_vcpu *vcpu, s64 count_resume);
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -438,32 +438,6 @@ static void kvm_mips_resume_hrtimer(stru
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
@@ -558,23 +532,42 @@ int kvm_mips_set_count_hz(struct kvm_vcp
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
@@ -1113,9 +1106,9 @@ enum emulation_result kvm_mips_emulate_C
 
 				/* If we are writing to COMPARE */
 				/* Clear pending timer interrupt, if any */
-				kvm_mips_callbacks->dequeue_timer_int(vcpu);
 				kvm_mips_write_compare(vcpu,
-						       vcpu->arch.gprs[rt]);
+						       vcpu->arch.gprs[rt],
+						       true);
 			} else if ((rd == MIPS_CP0_STATUS) && (sel == 0)) {
 				unsigned int old_val, val, change;
 
--- a/arch/mips/kvm/trap_emul.c
+++ b/arch/mips/kvm/trap_emul.c
@@ -546,7 +546,7 @@ static int kvm_trap_emul_set_one_reg(str
 		kvm_mips_write_count(vcpu, v);
 		break;
 	case KVM_REG_MIPS_CP0_COMPARE:
-		kvm_mips_write_compare(vcpu, v);
+		kvm_mips_write_compare(vcpu, v, false);
 		break;
 	case KVM_REG_MIPS_CP0_CAUSE:
 		/*
