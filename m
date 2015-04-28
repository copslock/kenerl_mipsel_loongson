Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Apr 2015 12:33:16 +0200 (CEST)
Received: from e06smtp14.uk.ibm.com ([195.75.94.110]:59339 "EHLO
        e06smtp14.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011991AbbD1Kc6CIT5J (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Apr 2015 12:32:58 +0200
Received: from /spool/local
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <borntraeger@de.ibm.com>;
        Tue, 28 Apr 2015 11:32:52 +0100
Received: from d06dlp03.portsmouth.uk.ibm.com (9.149.20.15)
        by e06smtp14.uk.ibm.com (192.168.101.144) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Tue, 28 Apr 2015 11:32:51 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 486861B08070
        for <linux-mips@linux-mips.org>; Tue, 28 Apr 2015 11:33:30 +0100 (BST)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com [9.149.37.216])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t3SAWpJY6291934
        for <linux-mips@linux-mips.org>; Tue, 28 Apr 2015 10:32:51 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
        by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t3SAWoDd024875
        for <linux-mips@linux-mips.org>; Tue, 28 Apr 2015 04:32:50 -0600
Received: from tuxmaker.boeblingen.de.ibm.com (tuxmaker.boeblingen.de.ibm.com [9.152.85.9])
        by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id t3SAWnRq024845;
        Tue, 28 Apr 2015 04:32:50 -0600
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 25651)
        id E0E391224437; Tue, 28 Apr 2015 12:32:49 +0200 (CEST)
From:   Christian Borntraeger <borntraeger@de.ibm.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     KVM <kvm@vger.kernel.org>, kvm-ppc@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-mips@linux-mips.org,
        Cornelia Huck <cornelia.huck@de.ibm.com>,
        Alexander Graf <agraf@suse.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH/RFC 2/2] KVM: push down irq_save from kvm_guest_exit
Date:   Tue, 28 Apr 2015 12:32:48 +0200
Message-Id: <1430217168-25504-3-git-send-email-borntraeger@de.ibm.com>
X-Mailer: git-send-email 2.3.0
In-Reply-To: <1430217168-25504-1-git-send-email-borntraeger@de.ibm.com>
References: <1430217168-25504-1-git-send-email-borntraeger@de.ibm.com>
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 15042810-0017-0000-0000-000003DEC558
Return-Path: <borntraeger@de.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47122
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

Some architectures already have irq disabled when calling
kvm_guest_exit. Push down the disabling into the architectures
to avoid double disabling. This also allows to replace
irq_save with irq_disable which might be cheaper.
arm and mips already have interrupts disabled. s390/power/x86
need adoptions.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/powerpc/kvm/book3s_hv.c | 2 ++
 arch/powerpc/kvm/book3s_pr.c | 2 ++
 arch/powerpc/kvm/booke.c     | 4 ++--
 arch/s390/kvm/kvm-s390.c     | 2 ++
 arch/x86/kvm/x86.c           | 2 ++
 include/linux/kvm_host.h     | 4 ----
 6 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index a5f392d..63b35b1 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1811,7 +1811,9 @@ static void kvmppc_run_core(struct kvmppc_vcore *vc)
 
 	/* make sure updates to secondary vcpu structs are visible now */
 	smp_mb();
+	local_irq_disable();
 	kvm_guest_exit();
+	local_irq_enable();
 
 	preempt_enable();
 	cond_resched();
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index f573839..eafcb8c 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -891,7 +891,9 @@ int kvmppc_handle_exit_pr(struct kvm_run *run, struct kvm_vcpu *vcpu,
 
 	/* We get here with MSR.EE=1 */
 
+	local_irq_disable();
 	trace_kvm_exit(exit_nr, vcpu);
+	local_irq_enable();
 	kvm_guest_exit();
 
 	switch (exit_nr) {
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 6c1316a..f1d6af3 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -1004,11 +1004,11 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		break;
 	}
 
-	local_irq_enable();
-
 	trace_kvm_exit(exit_nr, vcpu);
 	kvm_guest_exit();
 
+	local_irq_enable();
+
 	run->exit_reason = KVM_EXIT_UNKNOWN;
 	run->ready_for_interrupt_injection = 1;
 
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 9f4c954..0aa2534 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2015,7 +2015,9 @@ static int __vcpu_run(struct kvm_vcpu *vcpu)
 		local_irq_enable();
 		exit_reason = sie64a(vcpu->arch.sie_block,
 				     vcpu->run->s.regs.gprs);
+		local_irq_disable();
 		kvm_guest_exit();
+		local_irq_enable();
 		vcpu->srcu_idx = srcu_read_lock(&vcpu->kvm->srcu);
 
 		rc = vcpu_post_run(vcpu, exit_reason);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 32bf19e..a5fbd45 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6351,7 +6351,9 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	 */
 	barrier();
 
+	local_irq_disable();
 	kvm_guest_exit();
+	local_irq_enable();
 
 	preempt_enable();
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index a34bf6ed..fe699fb 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -773,11 +773,7 @@ static inline void kvm_guest_enter(void)
 
 static inline void kvm_guest_exit(void)
 {
-	unsigned long flags;
-
-	local_irq_save(flags);
 	guest_exit();
-	local_irq_restore(flags);
 }
 
 /*
-- 
2.3.0
