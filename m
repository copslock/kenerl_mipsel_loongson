Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Mar 2017 11:26:35 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:65059 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994814AbdCNKSZAuk9U (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Mar 2017 11:18:25 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id E1FBE8DAF5F25;
        Tue, 14 Mar 2017 10:18:15 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 14 Mar 2017 10:18:18 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH v2 21/33] KVM: MIPS/Emulate: Update CP0_Compare emulation for VZ
Date:   Tue, 14 Mar 2017 10:15:28 +0000
Message-ID: <eb8eaf283cea07b0a59ce0acd8db6544ae7c1877.1489485940.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.1
MIME-Version: 1.0
In-Reply-To: <cover.26e10ec77a4ed0d3177ccf4fabf57bc95ea030f8.1489485940.git-series.james.hogan@imgtec.com>
References: <cover.26e10ec77a4ed0d3177ccf4fabf57bc95ea030f8.1489485940.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57220
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

Update emulation of guest writes to CP0_Compare for VZ. There are two
main differences compared to trap & emulate:

 - Writing to CP0_Compare in the VZ hardware guest context acks any
   pending timer, clearing CP0_Cause.TI. If we don't want an ack to take
   place we must carefully restore the TI bit if it was previously set.

 - Even with guest timer access disabled in CP0_GuestCtl0.GT, if the
   guest CP0_Count reaches the guest CP0_Compare the timer interrupt
   will assert. To prevent this we must set CP0_GTOffset to move the
   guest CP0_Count out of the way of the new guest CP0_Compare, either
   before or after depending on whether it is a forwards or backwards
   change.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/emulate.c | 43 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index e6fce30eb440..42424822898c 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -621,7 +621,9 @@ void kvm_mips_write_compare(struct kvm_vcpu *vcpu, u32 compare, bool ack)
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	int dc;
 	u32 old_compare = kvm_read_c0_guest_compare(cop0);
-	ktime_t now;
+	s32 delta = compare - old_compare;
+	u32 cause;
+	ktime_t now = ktime_set(0, 0); /* silence bogus GCC warning */
 	u32 count;
 
 	/* if unchanged, must just be an ack */
@@ -633,6 +635,21 @@ void kvm_mips_write_compare(struct kvm_vcpu *vcpu, u32 compare, bool ack)
 		return;
 	}
 
+	/*
+	 * If guest CP0_Compare moves forward, CP0_GTOffset should be adjusted
+	 * too to prevent guest CP0_Count hitting guest CP0_Compare.
+	 *
+	 * The new GTOffset corresponds to the new value of CP0_Compare, and is
+	 * set prior to it being written into the guest context. We disable
+	 * preemption until the new value is written to prevent restore of a
+	 * GTOffset corresponding to the old CP0_Compare value.
+	 */
+	if (IS_ENABLED(CONFIG_KVM_MIPS_VZ) && delta > 0) {
+		preempt_disable();
+		write_c0_gtoffset(compare - read_c0_count());
+		back_to_back_c0_hazard();
+	}
+
 	/* freeze_hrtimer() takes care of timer interrupts <= count */
 	dc = kvm_mips_count_disabled(vcpu);
 	if (!dc)
@@ -640,12 +657,36 @@ void kvm_mips_write_compare(struct kvm_vcpu *vcpu, u32 compare, bool ack)
 
 	if (ack)
 		kvm_mips_callbacks->dequeue_timer_int(vcpu);
+	else if (IS_ENABLED(CONFIG_KVM_MIPS_VZ))
+		/*
+		 * With VZ, writing CP0_Compare acks (clears) CP0_Cause.TI, so
+		 * preserve guest CP0_Cause.TI if we don't want to ack it.
+		 */
+		cause = kvm_read_c0_guest_cause(cop0);
 
 	kvm_write_c0_guest_compare(cop0, compare);
 
+	if (IS_ENABLED(CONFIG_KVM_MIPS_VZ)) {
+		if (delta > 0)
+			preempt_enable();
+
+		back_to_back_c0_hazard();
+
+		if (!ack && cause & CAUSEF_TI)
+			kvm_write_c0_guest_cause(cop0, cause);
+	}
+
 	/* resume_hrtimer() takes care of timer interrupts > count */
 	if (!dc)
 		kvm_mips_resume_hrtimer(vcpu, now, count);
+
+	/*
+	 * If guest CP0_Compare is moving backward, we delay CP0_GTOffset change
+	 * until after the new CP0_Compare is written, otherwise new guest
+	 * CP0_Count could hit new guest CP0_Compare.
+	 */
+	if (IS_ENABLED(CONFIG_KVM_MIPS_VZ) && delta <= 0)
+		write_c0_gtoffset(compare - read_c0_count());
 }
 
 /**
-- 
git-series 0.8.10
