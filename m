Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Apr 2015 13:43:41 +0200 (CEST)
Received: from e06smtp13.uk.ibm.com ([195.75.94.109]:40288 "EHLO
        e06smtp13.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012289AbbD3LnjpsTGG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Apr 2015 13:43:39 +0200
Received: from /spool/local
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <borntraeger@de.ibm.com>;
        Thu, 30 Apr 2015 12:43:36 +0100
Received: from d06dlp03.portsmouth.uk.ibm.com (9.149.20.15)
        by e06smtp13.uk.ibm.com (192.168.101.143) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Thu, 30 Apr 2015 12:43:35 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4D24D1B08069
        for <linux-mips@linux-mips.org>; Thu, 30 Apr 2015 12:44:14 +0100 (BST)
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com [9.149.37.248])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t3UBhYC72556288
        for <linux-mips@linux-mips.org>; Thu, 30 Apr 2015 11:43:34 GMT
Received: from d06av07.portsmouth.uk.ibm.com (localhost [127.0.0.1])
        by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t3UBhXat014548
        for <linux-mips@linux-mips.org>; Thu, 30 Apr 2015 07:43:34 -0400
Received: from tuxmaker.boeblingen.de.ibm.com (tuxmaker.boeblingen.de.ibm.com [9.152.85.9])
        by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id t3UBhX45014543;
        Thu, 30 Apr 2015 07:43:33 -0400
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 25651)
        id 6E26B1224435; Thu, 30 Apr 2015 13:43:33 +0200 (CEST)
From:   Christian Borntraeger <borntraeger@de.ibm.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     KVM <kvm@vger.kernel.org>, kvm-ppc@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-mips@linux-mips.org,
        Cornelia Huck <cornelia.huck@de.ibm.com>,
        Alexander Graf <agraf@suse.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 1/2] KVM: provide irq_unsafe kvm_guest_{enter|exit}
Date:   Thu, 30 Apr 2015 13:43:30 +0200
Message-Id: <1430394211-25209-2-git-send-email-borntraeger@de.ibm.com>
X-Mailer: git-send-email 2.3.0
In-Reply-To: <1430394211-25209-1-git-send-email-borntraeger@de.ibm.com>
References: <1430394211-25209-1-git-send-email-borntraeger@de.ibm.com>
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 15043011-0013-0000-0000-000003D4C729
Return-Path: <borntraeger@de.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47168
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

Several kvm architectures disable interrupts before kvm_guest_enter.
kvm_guest_enter then uses local_irq_save/restore to disable interrupts
again or for the first time. Lets provide underscore versions of
kvm_guest_{enter|exit} that assume being called locked.
kvm_guest_enter now disables interrupts for the full function and
thus we can remove the check for preemptible.

This patch then adopts s390/kvm to use local_irq_disable/enable calls
which are slighty cheaper that local_irq_save/restore and call these
new functions.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 10 ++++++----
 include/linux/kvm_host.h | 27 ++++++++++++++++++---------
 2 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 46f37df..c25d4e5 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2010,12 +2010,14 @@ static int __vcpu_run(struct kvm_vcpu *vcpu)
 		 * As PF_VCPU will be used in fault handler, between
 		 * guest_enter and guest_exit should be no uaccess.
 		 */
-		preempt_disable();
-		kvm_guest_enter();
-		preempt_enable();
+		local_irq_disable();
+		__kvm_guest_enter();
+		local_irq_enable();
 		exit_reason = sie64a(vcpu->arch.sie_block,
 				     vcpu->run->s.regs.gprs);
-		kvm_guest_exit();
+		local_irq_disable();
+		__kvm_guest_exit();
+		local_irq_enable();
 		vcpu->srcu_idx = srcu_read_lock(&vcpu->kvm->srcu);
 
 		rc = vcpu_post_run(vcpu, exit_reason);
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index d12b210..2d3b3ce 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -749,16 +749,10 @@ static inline void kvm_iommu_unmap_pages(struct kvm *kvm,
 }
 #endif
 
-static inline void kvm_guest_enter(void)
+/* must be called with irqs disabled */
+static inline void __kvm_guest_enter(void)
 {
-	unsigned long flags;
-
-	BUG_ON(preemptible());
-
-	local_irq_save(flags);
 	guest_enter();
-	local_irq_restore(flags);
-
 	/* KVM does not hold any references to rcu protected data when it
 	 * switches CPU into a guest mode. In fact switching to a guest mode
 	 * is very similar to exiting to userspace from rcu point of view. In
@@ -769,12 +763,27 @@ static inline void kvm_guest_enter(void)
 	rcu_virt_note_context_switch(smp_processor_id());
 }
 
+/* must be called with irqs disabled */
+static inline void __kvm_guest_exit(void)
+{
+	guest_exit();
+}
+
+static inline void kvm_guest_enter(void)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	__kvm_guest_enter();
+	local_irq_restore(flags);
+}
+
 static inline void kvm_guest_exit(void)
 {
 	unsigned long flags;
 
 	local_irq_save(flags);
-	guest_exit();
+	__kvm_guest_exit();
 	local_irq_restore(flags);
 }
 
-- 
2.3.0
