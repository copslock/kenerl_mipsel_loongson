Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Apr 2015 13:44:14 +0200 (CEST)
Received: from e06smtp11.uk.ibm.com ([195.75.94.107]:34241 "EHLO
        e06smtp11.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026348AbbD3LnklslR4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Apr 2015 13:43:40 +0200
Received: from /spool/local
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <borntraeger@de.ibm.com>;
        Thu, 30 Apr 2015 12:43:36 +0100
Received: from d06dlp02.portsmouth.uk.ibm.com (9.149.20.14)
        by e06smtp11.uk.ibm.com (192.168.101.141) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Thu, 30 Apr 2015 12:43:34 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id A0C13219004D
        for <linux-mips@linux-mips.org>; Thu, 30 Apr 2015 12:43:16 +0100 (BST)
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com [9.149.37.229])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t3UBhYPd9961806
        for <linux-mips@linux-mips.org>; Thu, 30 Apr 2015 11:43:34 GMT
Received: from d06av05.portsmouth.uk.ibm.com (localhost [127.0.0.1])
        by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t3UBhXI9020757
        for <linux-mips@linux-mips.org>; Thu, 30 Apr 2015 05:43:33 -0600
Received: from tuxmaker.boeblingen.de.ibm.com (tuxmaker.boeblingen.de.ibm.com [9.152.85.9])
        by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id t3UBhXvY020749;
        Thu, 30 Apr 2015 05:43:33 -0600
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 25651)
        id 931B31224437; Thu, 30 Apr 2015 13:43:33 +0200 (CEST)
From:   Christian Borntraeger <borntraeger@de.ibm.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     KVM <kvm@vger.kernel.org>, kvm-ppc@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-mips@linux-mips.org,
        Cornelia Huck <cornelia.huck@de.ibm.com>,
        Alexander Graf <agraf@suse.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 2/2] KVM: arm/mips/x86/power use __kvm_guest_{enter|exit}
Date:   Thu, 30 Apr 2015 13:43:31 +0200
Message-Id: <1430394211-25209-3-git-send-email-borntraeger@de.ibm.com>
X-Mailer: git-send-email 2.3.0
In-Reply-To: <1430394211-25209-1-git-send-email-borntraeger@de.ibm.com>
References: <1430394211-25209-1-git-send-email-borntraeger@de.ibm.com>
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 15043011-0041-0000-0000-000004403DD5
Return-Path: <borntraeger@de.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47170
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

Use __kvm_guest_{enter|exit} instead of kvm_guest_{enter|exit}
where interrupts are disabled.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/arm/kvm/arm.c         | 4 ++--
 arch/mips/kvm/mips.c       | 4 ++--
 arch/powerpc/kvm/powerpc.c | 2 +-
 arch/x86/kvm/x86.c         | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 5560f74..050c274 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -533,13 +533,13 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		 * Enter the guest
 		 */
 		trace_kvm_entry(*vcpu_pc(vcpu));
-		kvm_guest_enter();
+		__kvm_guest_enter();
 		vcpu->mode = IN_GUEST_MODE;
 
 		ret = kvm_call_hyp(__kvm_vcpu_run, vcpu);
 
 		vcpu->mode = OUTSIDE_GUEST_MODE;
-		kvm_guest_exit();
+		__kvm_guest_exit();
 		trace_kvm_exit(kvm_vcpu_trap_get_class(vcpu), *vcpu_pc(vcpu));
 		/*
 		 * We may have taken a host interrupt in HYP mode (ie
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index c9eccf5..539c12c 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -388,7 +388,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	kvm_mips_deliver_interrupts(vcpu,
 				    kvm_read_c0_guest_cause(vcpu->arch.cop0));
 
-	kvm_guest_enter();
+	__kvm_guest_enter();
 
 	/* Disable hardware page table walking while in guest */
 	htw_stop();
@@ -398,7 +398,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	/* Re-enable HTW before enabling interrupts */
 	htw_start();
 
-	kvm_guest_exit();
+	__kvm_guest_exit();
 	local_irq_enable();
 
 	if (vcpu->sigset_active)
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 27c0fac..e5c0be5 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -115,7 +115,7 @@ int kvmppc_prepare_to_enter(struct kvm_vcpu *vcpu)
 			continue;
 		}
 
-		kvm_guest_enter();
+		__kvm_guest_enter();
 		return 1;
 	}
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 32bf19e..eb8aa96 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6292,7 +6292,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	if (req_immediate_exit)
 		smp_send_reschedule(vcpu->cpu);
 
-	kvm_guest_enter();
+	__kvm_guest_enter();
 
 	if (unlikely(vcpu->arch.switch_db_regs)) {
 		set_debugreg(0, 7);
-- 
2.3.0
