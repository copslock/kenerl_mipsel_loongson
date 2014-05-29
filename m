Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 May 2014 11:22:43 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:41242 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6833400AbaE2JRKpEbLf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 May 2014 11:17:10 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 0007094246223;
        Thu, 29 May 2014 10:17:01 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Thu, 29 May
 2014 10:17:03 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Thu, 29 May 2014 10:17:03 +0100
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
Subject: [PATCH v2 12/23] MIPS: KVM: Migrate hrtimer to follow VCPU
Date:   Thu, 29 May 2014 10:16:34 +0100
Message-ID: <1401355005-20370-13-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 40337
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

When a VCPU is scheduled in on a different CPU, refresh the hrtimer used
for emulating count/compare so that it gets migrated to the same CPU.

This should prevent a timer interrupt occurring on a different CPU to
where the guest it relates to is running, which would cause the guest
timer interrupt not to be delivered until after the next guest exit.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: kvm@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: Sanjay Lal <sanjayl@kymasys.com>
---
v2:
 - Move kvm_mips_migrate_count() into kvm_tlb.c to fix a link error when
   KVM is built as a module, since kvm_tlb.c is built statically and
   cannot reference symbols in kvm_mips_emul.c.
---
 arch/mips/kvm/kvm_tlb.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/mips/kvm/kvm_tlb.c b/arch/mips/kvm/kvm_tlb.c
index 9d371ee0a755..d65999a9f8af 100644
--- a/arch/mips/kvm/kvm_tlb.c
+++ b/arch/mips/kvm/kvm_tlb.c
@@ -656,6 +656,23 @@ void kvm_local_flush_tlb_all(void)
 	local_irq_restore(flags);
 }
 
+/**
+ * kvm_mips_migrate_count() - Migrate timer.
+ * @vcpu:	Virtual CPU.
+ *
+ * Migrate CP0_Count hrtimer to the current CPU by cancelling and restarting it
+ * if it was running prior to being cancelled.
+ *
+ * Must be called when the VCPU is migrated to a different CPU to ensure that
+ * timer expiry during guest execution interrupts the guest and causes the
+ * interrupt to be delivered in a timely manner.
+ */
+static void kvm_mips_migrate_count(struct kvm_vcpu *vcpu)
+{
+	if (hrtimer_cancel(&vcpu->arch.comparecount_timer))
+		hrtimer_restart(&vcpu->arch.comparecount_timer);
+}
+
 /* Restore ASID once we are scheduled back after preemption */
 void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
@@ -691,6 +708,12 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	if (vcpu->arch.last_sched_cpu != cpu) {
 		kvm_info("[%d->%d]KVM VCPU[%d] switch\n",
 			 vcpu->arch.last_sched_cpu, cpu, vcpu->vcpu_id);
+		/*
+		 * Migrate the timer interrupt to the current CPU so that it
+		 * always interrupts the guest and synchronously triggers a
+		 * guest timer interrupt.
+		 */
+		kvm_mips_migrate_count(vcpu);
 	}
 
 	if (!newasid) {
-- 
1.9.3
