Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Apr 2016 02:55:03 +0200 (CEST)
Received: from szxga02-in.huawei.com ([119.145.14.65]:62690 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026834AbcDWAzAg0vIf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 23 Apr 2016 02:55:00 +0200
Received: from 172.24.1.51 (EHLO szxeml431-hub.china.huawei.com) ([172.24.1.51])
        by szxrg02-dlp.huawei.com (MOS 4.3.7-GA FastPath queued)
        with ESMTP id DFW17094;
        Sat, 23 Apr 2016 08:53:39 +0800 (CST)
Received: from localhost (10.160.19.74) by szxeml431-hub.china.huawei.com
 (10.82.67.208) with Microsoft SMTP Server id 14.3.235.1; Sat, 23 Apr 2016
 08:53:28 +0800
Date:   Sat, 23 Apr 2016 08:51:24 +0800
From:   Wei Yang <richard.weiyang@huawei.com>
To:     Greg Kurz <gkurz@linux.vnet.ibm.com>
CC:     Wei Yang <richard.weiyang@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>, <james.hogan@imgtec.com>,
        <mingo@redhat.com>, <linux-mips@linux-mips.org>,
        <kvm@vger.kernel.org>, <rkrcmar@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        David Hildenbrand <dahi@linux.vnet.ibm.com>,
        <qemu-ppc@nongnu.org>, Cornelia Huck <cornelia.huck@de.ibm.com>,
        "Paul Mackerras" <paulus@samba.org>,
        David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v4 2/2] KVM: move vcpu id checking to archs
Message-ID: <20160423005124.GB1718@linux-gk3p>
Reply-To: Wei Yang <richard.weiyang@huawei.com>
References: <146124809455.32509.15232948272580716135.stgit@bahia.huguette.org> <146124811255.32509.17679765789502091772.stgit@bahia.huguette.org> <20160422092103.GA3851@linux-gk3p> <20160422113045.14560b66@bahia.huguette.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20160422113045.14560b66@bahia.huguette.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Originating-IP: [10.160.19.74]
X-CFilter-Loop: Reflected
X-Mirapoint-Virus-RAPID-Raw: score=unknown(0),
        refid=str=0001.0A0B0204.571AC795.00D3,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0,
        ip=0.0.0.0,
        so=2013-06-18 04:22:30,
        dmn=2013-03-21 17:37:32
X-Mirapoint-Loop-Id: 351bb13eff208123c7ba5c4ea277a927
Return-Path: <richard.weiyang@huawei.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53222
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: richard.weiyang@huawei.com
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

On Fri, Apr 22, 2016 at 11:30:45AM +0200, Greg Kurz wrote:
>On Fri, 22 Apr 2016 17:21:03 +0800
>Wei Yang <richard.weiyang@huawei.com> wrote:
>
>> Hi, Greg
>> 
>
>Hi Wei !
>
>> One confusion.
>> 
>> There are 5 kvm_arch_vcpu_create() while in this patch you changed 2 of them.
>> Some particular reason?
>> 
>
>Yes and the reason is given in the changelog:
>- ARM and s390 already have such a check
>- PowerPC can live without this check
>- this patch simply moves the check to MIPS and x86
>
>Does it clarify ?
>

Sure, thanks :-)

>Cheers.
>
>--
>Greg
>
>> On Thu, Apr 21, 2016 at 04:20:53PM +0200, Greg Kurz wrote:
>> >Commit 338c7dbadd26 ("KVM: Improve create VCPU parameter (CVE-2013-4587)")
>> >introduced a check to prevent potential kernel memory corruption in case
>> >the vcpu id is too great.
>> >
>> >Unfortunately this check assumes vcpu ids grow in sequence with a common
>> >difference of 1, which is wrong: archs are free to use vcpu id as they fit.
>> >For example, QEMU originated vcpu ids for PowerPC cpus running in boot3s_hv
>> >mode, can grow with a common difference of 2, 4 or 8: if KVM_MAX_VCPUS is
>> >1024, guests may be limited down to 128 vcpus on POWER8.
>> >
>> >This means the check does not belong here and should be moved to some arch
>> >specific function: kvm_arch_vcpu_create() looks like a good candidate.
>> >
>> >ARM and s390 already have such a check.
>> >
>> >I could not spot any path in the PowerPC or common KVM code where a vcpu
>> >id is used as described in the above commit: I believe PowerPC can live
>> >without this check.
>> >
>> >In the end, this patch simply moves the check to MIPS and x86. While here,
>> >we also update the documentation to dissociate vcpu ids from the maximum
>> >number of vcpus per virtual machine.
>> >
>> >Acked-by: James Hogan <james.hogan@imgtec.com>
>> >Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
>> >Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
>> >---
>> >v4: - updated subject for more clarity on what the patch does
>> >    - added James's and Connie's A-b tags
>> >    - updated documentation
>> >
>> > Documentation/virtual/kvm/api.txt |    7 +++----
>> > arch/mips/kvm/mips.c              |    7 ++++++-
>> > arch/x86/kvm/x86.c                |    3 +++
>> > virt/kvm/kvm_main.c               |    3 ---
>> > 4 files changed, 12 insertions(+), 8 deletions(-)
>> >
>> >diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
>> >index 4d0542c5206b..486a1d783b82 100644
>> >--- a/Documentation/virtual/kvm/api.txt
>> >+++ b/Documentation/virtual/kvm/api.txt
>> >@@ -199,11 +199,10 @@ Type: vm ioctl
>> > Parameters: vcpu id (apic id on x86)
>> > Returns: vcpu fd on success, -1 on error
>> > 
>> >-This API adds a vcpu to a virtual machine.  The vcpu id is a small integer
>> >-in the range [0, max_vcpus).
>> >+This API adds a vcpu to a virtual machine.  The vcpu id is a positive integer.
>> > 
>> >-The recommended max_vcpus value can be retrieved using the KVM_CAP_NR_VCPUS of
>> >-the KVM_CHECK_EXTENSION ioctl() at run-time.
>> >+The recommended maximum number of vcpus (max_vcpus) can be retrieved using the
>> >+KVM_CAP_NR_VCPUS of the KVM_CHECK_EXTENSION ioctl() at run-time.
>> > The maximum possible value for max_vcpus can be retrieved using the
>> > KVM_CAP_MAX_VCPUS of the KVM_CHECK_EXTENSION ioctl() at run-time.
>> > 
>> >diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
>> >index 70ef1a43c114..0278ea146db5 100644
>> >--- a/arch/mips/kvm/mips.c
>> >+++ b/arch/mips/kvm/mips.c
>> >@@ -248,9 +248,14 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm, unsigned int id)
>> > 	int err, size, offset;
>> > 	void *gebase;
>> > 	int i;
>> >+	struct kvm_vcpu *vcpu;
>> > 
>> >-	struct kvm_vcpu *vcpu = kzalloc(sizeof(struct kvm_vcpu), GFP_KERNEL);
>> >+	if (id >= KVM_MAX_VCPUS) {
>> >+		err = -EINVAL;
>> >+		goto out;
>> >+	}
>> > 
>> >+	vcpu = kzalloc(sizeof(struct kvm_vcpu), GFP_KERNEL);
>> > 	if (!vcpu) {
>> > 		err = -ENOMEM;
>> > 		goto out;
>> >diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> >index 9b7798c7b210..7738202edcce 100644
>> >--- a/arch/x86/kvm/x86.c
>> >+++ b/arch/x86/kvm/x86.c
>> >@@ -7358,6 +7358,9 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm,
>> > {
>> > 	struct kvm_vcpu *vcpu;
>> > 
>> >+	if (id >= KVM_MAX_VCPUS)
>> >+		return ERR_PTR(-EINVAL);
>> >+
>> > 	if (check_tsc_unstable() && atomic_read(&kvm->online_vcpus) != 0)
>> > 		printk_once(KERN_WARNING
>> > 		"kvm: SMP vm created on host with unstable TSC; "
>> >diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
>> >index 4fd482fb9260..6b6cca3cb488 100644
>> >--- a/virt/kvm/kvm_main.c
>> >+++ b/virt/kvm/kvm_main.c
>> >@@ -2272,9 +2272,6 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, u32 id)
>> > 	int r;
>> > 	struct kvm_vcpu *vcpu;
>> > 
>> >-	if (id >= KVM_MAX_VCPUS)
>> >-		return -EINVAL;
>> >-
>> > 	vcpu = kvm_arch_vcpu_create(kvm, id);
>> > 	if (IS_ERR(vcpu))
>> > 		return PTR_ERR(vcpu);
>> >
>> >--
>> >To unsubscribe from this list: send the line "unsubscribe kvm" in
>> >the body of a message to majordomo@vger.kernel.org
>> >More majordomo info at  http://vger.kernel.org/majordomo-info.html  
>> 

-- 
Richard Yang\nHelp you, Help me
