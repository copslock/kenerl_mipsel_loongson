Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Apr 2015 12:33:36 +0200 (CEST)
Received: from e06smtp12.uk.ibm.com ([195.75.94.108]:54027 "EHLO
        e06smtp12.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012039AbbD1Kc6GTV0D (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Apr 2015 12:32:58 +0200
Received: from /spool/local
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <borntraeger@de.ibm.com>;
        Tue, 28 Apr 2015 11:32:54 +0100
Received: from d06dlp03.portsmouth.uk.ibm.com (9.149.20.15)
        by e06smtp12.uk.ibm.com (192.168.101.142) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Tue, 28 Apr 2015 11:32:51 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 5E7C11B0805F
        for <linux-mips@linux-mips.org>; Tue, 28 Apr 2015 11:33:30 +0100 (BST)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com [9.149.37.216])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t3SAWpML60948724
        for <linux-mips@linux-mips.org>; Tue, 28 Apr 2015 10:32:51 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
        by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t3SAWoba024871
        for <linux-mips@linux-mips.org>; Tue, 28 Apr 2015 04:32:51 -0600
Received: from tuxmaker.boeblingen.de.ibm.com (tuxmaker.boeblingen.de.ibm.com [9.152.85.9])
        by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id t3SAWnoC024841;
        Tue, 28 Apr 2015 04:32:49 -0600
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 25651)
        id BE27A1224435; Tue, 28 Apr 2015 12:32:49 +0200 (CEST)
From:   Christian Borntraeger <borntraeger@de.ibm.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     KVM <kvm@vger.kernel.org>, kvm-ppc@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-mips@linux-mips.org,
        Cornelia Huck <cornelia.huck@de.ibm.com>,
        Alexander Graf <agraf@suse.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH/RFC 1/2] KVM: Push down irq_save to architectures before kvm_guest_enter
Date:   Tue, 28 Apr 2015 12:32:47 +0200
Message-Id: <1430217168-25504-2-git-send-email-borntraeger@de.ibm.com>
X-Mailer: git-send-email 2.3.0
In-Reply-To: <1430217168-25504-1-git-send-email-borntraeger@de.ibm.com>
References: <1430217168-25504-1-git-send-email-borntraeger@de.ibm.com>
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 15042810-0009-0000-0000-000003FADE8D
Return-Path: <borntraeger@de.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47123
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: borntraeger@de.ibm.com
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

local_irq_disable can be cheaper than local_irq_save, especially
when done only once instead of twice. We can push down the
local_irq_save (and replace it with local_irq_disable) to
save some cycles.
x86, mips and arm already disable the interrupts before calling
kvm_guest_enter. Here we save one local_irq_save/restore pair.
power and s390 are reworked to disable the interrupts before calling
kvm_guest_enter. s390 saves a preempt_disable/enable pair but also
saves some cycles as local_irq_disable/enable can be cheaper than
local_irq_save/restore on some machines.

power should be almost a no-op change (interrupts are disabled
slighty longer).

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/powerpc/kvm/book3s_hv.c |  2 ++
 arch/s390/kvm/kvm-s390.c     |  4 ++--
 include/linux/kvm_host.h     | 14 ++++++++------
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index de74756..a5f392d 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1779,7 +1779,9 @@ static void kvmppc_run_core(struct kvmppc_vcore *vc)
 
 	spin_unlock(&vc->lock);
 
+	local_irq_disable();
 	kvm_guest_enter();
+	local_irq_enable();
 
 	srcu_idx = srcu_read_lock(&vc->kvm->srcu);
 
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 46f37df..9f4c954 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2010,9 +2010,9 @@ static int __vcpu_run(struct kvm_vcpu *vcpu)
 		 * As PF_VCPU will be used in fault handler, between
 		 * guest_enter and guest_exit should be no uaccess.
 		 */
-		preempt_disable();
+		local_irq_disable();
 		kvm_guest_enter();
-		preempt_enable();
+		local_irq_enable();
 		exit_reason = sie64a(vcpu->arch.sie_block,
 				     vcpu->run->s.regs.gprs);
 		kvm_guest_exit();
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index d12b210..a34bf6ed 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -751,13 +751,15 @@ static inline void kvm_iommu_unmap_pages(struct kvm *kvm,
 
 static inline void kvm_guest_enter(void)
 {
-	unsigned long flags;
-
-	BUG_ON(preemptible());
-
-	local_irq_save(flags);
+	/*
+	 * guest_enter needs disabled irqs and rcu_virt_note_context_switch
+	 * wants disabled preemption. Ensure that the caller has disabled
+	 * irqs for kvm_guest_enter. Please note: Some architectures (e.g.
+	 * s390) will reenable irqs before entering the guest, but this is
+	 * ok. We just need a stable CPU for the accounting itself.
+	 */
+	WARN_ON(!irqs_disabled());
 	guest_enter();
-	local_irq_restore(flags);
 
 	/* KVM does not hold any references to rcu protected data when it
 	 * switches CPU into a guest mode. In fact switching to a guest mode
-- 
2.3.0
