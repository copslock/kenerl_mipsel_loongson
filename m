Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Apr 2016 17:27:02 +0200 (CEST)
Received: from e06smtp12.uk.ibm.com ([195.75.94.108]:39545 "EHLO
        e06smtp12.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026017AbcDTP1BQbqhs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Apr 2016 17:27:01 +0200
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <gkurz@linux.vnet.ibm.com>;
        Wed, 20 Apr 2016 16:26:54 +0100
Received: from d06dlp03.portsmouth.uk.ibm.com (9.149.20.15)
        by e06smtp12.uk.ibm.com (192.168.101.142) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Wed, 20 Apr 2016 16:26:53 +0100
X-IBM-Helo: d06dlp03.portsmouth.uk.ibm.com
X-IBM-MailFrom: gkurz@linux.vnet.ibm.com
X-IBM-RcptTo: linux-mips@linux-mips.org
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id D87051B08075
        for <linux-mips@linux-mips.org>; Wed, 20 Apr 2016 16:27:36 +0100 (BST)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com [9.149.37.216])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u3KFQqZ08323534
        for <linux-mips@linux-mips.org>; Wed, 20 Apr 2016 15:26:52 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
        by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u3KFQoXL031907
        for <linux-mips@linux-mips.org>; Wed, 20 Apr 2016 09:26:51 -0600
Received: from smtp.lab.toulouse-stg.fr.ibm.com (srv01.lab.toulouse-stg.fr.ibm.com [9.101.4.1])
        by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id u3KFQoUB031899;
        Wed, 20 Apr 2016 09:26:50 -0600
Received: from bahia.huguette.org (sig-9-83-160-41.evts.uk.ibm.com [9.83.160.41])
        by smtp.lab.toulouse-stg.fr.ibm.com (Postfix) with ESMTP id 76B2922050F;
        Wed, 20 Apr 2016 17:26:49 +0200 (CEST)
Subject: [PATCH v2] KVM: remove buggy vcpu id check on vcpu creation
From:   Greg Kurz <gkurz@linux.vnet.ibm.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, james.hogan@imgtec.com,
        mingo@redhat.com
Cc:     linux-mips@linux-mips.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, qemu-ppc@nongnu.org,
        Cornelia Huck <cornelia.huck@de.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        David Gibson <david@gibson.dropbear.id.au>
Date:   Wed, 20 Apr 2016 17:26:48 +0200
Message-ID: <146116593847.17621.12790270691583056759.stgit@bahia.huguette.org>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 16042015-0009-0000-0000-0000158919DA
Return-Path: <gkurz@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53129
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gkurz@linux.vnet.ibm.com
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

Commit 338c7dbadd26 ("KVM: Improve create VCPU parameter (CVE-2013-4587)")
introduced a check to prevent potential kernel memory corruption in case
the vcpu id is too great.

Unfortunately this check assumes vcpu ids grow in sequence with a common
difference of 1, which is wrong: archs are free to use vcpu id as they fit.
For example, QEMU originated vcpu ids for PowerPC cpus running in boot3s_hv
mode, can grow with a common difference of 2, 4 or 8: if KVM_MAX_VCPUS is
1024, guests may be limited down to 128 vcpus on POWER8.

This means the check does not belong here and should be moved to some arch
specific function: kvm_arch_vcpu_create() looks like a good candidate.

ARM and s390 already have such a check.

I could not spot any path in the PowerPC or common KVM code where a vcpu
id is used as described in the above commit: I believe PowerPC can live
without this check.

In the end, this patch simply moves the check to MIPS and x86.

Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
---
v2: move kzalloc() after the check in MIPS to avoid memory leak

 arch/mips/kvm/mips.c |    5 ++++-
 arch/x86/kvm/x86.c   |    3 +++
 virt/kvm/kvm_main.c  |    3 ---
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 70ef1a43c114..c1ce9d44d685 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -248,9 +248,12 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm, unsigned int id)
 	int err, size, offset;
 	void *gebase;
 	int i;
+	struct kvm_vcpu *vcpu;
 
-	struct kvm_vcpu *vcpu = kzalloc(sizeof(struct kvm_vcpu), GFP_KERNEL);
+	if (id >= KVM_MAX_VCPUS)
+		return -EINVAL;
 
+	vcpu = kzalloc(sizeof(struct kvm_vcpu), GFP_KERNEL);
 	if (!vcpu) {
 		err = -ENOMEM;
 		goto out;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 9b7798c7b210..f705d57b12ed 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7358,6 +7358,9 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm,
 {
 	struct kvm_vcpu *vcpu;
 
+	if (id >= KVM_MAX_VCPUS)
+		return -EINVAL;
+
 	if (check_tsc_unstable() && atomic_read(&kvm->online_vcpus) != 0)
 		printk_once(KERN_WARNING
 		"kvm: SMP vm created on host with unstable TSC; "
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 4fd482fb9260..6b6cca3cb488 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2272,9 +2272,6 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, u32 id)
 	int r;
 	struct kvm_vcpu *vcpu;
 
-	if (id >= KVM_MAX_VCPUS)
-		return -EINVAL;
-
 	vcpu = kvm_arch_vcpu_create(kvm, id);
 	if (IS_ERR(vcpu))
 		return PTR_ERR(vcpu);
