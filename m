Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Apr 2016 17:42:00 +0200 (CEST)
Received: from e06smtp16.uk.ibm.com ([195.75.94.112]:45425 "EHLO
        e06smtp16.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27027150AbcDTPlz6z0gs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Apr 2016 17:41:55 +0200
Received: from localhost
        by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <cornelia.huck@de.ibm.com>;
        Wed, 20 Apr 2016 16:41:50 +0100
Received: from d06dlp03.portsmouth.uk.ibm.com (9.149.20.15)
        by e06smtp16.uk.ibm.com (192.168.101.146) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Wed, 20 Apr 2016 16:41:47 +0100
X-IBM-Helo: d06dlp03.portsmouth.uk.ibm.com
X-IBM-MailFrom: cornelia.huck@de.ibm.com
X-IBM-RcptTo: linux-mips@linux-mips.org
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6C04C1B08074
        for <linux-mips@linux-mips.org>; Wed, 20 Apr 2016 16:42:31 +0100 (BST)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com [9.149.37.212])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u3KFfkwG4522480
        for <linux-mips@linux-mips.org>; Wed, 20 Apr 2016 15:41:46 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
        by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u3KFfkR6005506
        for <linux-mips@linux-mips.org>; Wed, 20 Apr 2016 09:41:46 -0600
Received: from gondolin (dyn-9-152-224-197.boeblingen.de.ibm.com [9.152.224.197])
        by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id u3KFfjtV005493;
        Wed, 20 Apr 2016 09:41:45 -0600
Date:   Wed, 20 Apr 2016 17:41:43 +0200
From:   Cornelia Huck <cornelia.huck@de.ibm.com>
To:     Greg Kurz <gkurz@linux.vnet.ibm.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, james.hogan@imgtec.com,
        mingo@redhat.com, linux-mips@linux-mips.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, qemu-ppc@nongnu.org,
        Paul Mackerras <paulus@samba.org>,
        David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v2] KVM: remove buggy vcpu id check on vcpu creation
Message-ID: <20160420174143.26200bea.cornelia.huck@de.ibm.com>
In-Reply-To: <146116593847.17621.12790270691583056759.stgit@bahia.huguette.org>
References: <146116593847.17621.12790270691583056759.stgit@bahia.huguette.org>
Organization: IBM Deutschland Research & Development GmbH Vorsitzende des
 Aufsichtsrats: Martina Koederitz =?UTF-8?B?R2VzY2jDpGZ0c2bDvGhydW5nOg==?=
 Dirk Wittkopp Sitz der Gesellschaft: =?UTF-8?B?QsO2Ymxpbmdlbg==?=
 Registergericht: Amtsgericht Stuttgart, HRB 243294
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 16042015-0025-0000-0000-000012C92F8B
Return-Path: <cornelia.huck@de.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53131
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cornelia.huck@de.ibm.com
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

On Wed, 20 Apr 2016 17:26:48 +0200
Greg Kurz <gkurz@linux.vnet.ibm.com> wrote:

> Commit 338c7dbadd26 ("KVM: Improve create VCPU parameter (CVE-2013-4587)")
> introduced a check to prevent potential kernel memory corruption in case
> the vcpu id is too great.
> 
> Unfortunately this check assumes vcpu ids grow in sequence with a common
> difference of 1, which is wrong: archs are free to use vcpu id as they fit.
> For example, QEMU originated vcpu ids for PowerPC cpus running in boot3s_hv
> mode, can grow with a common difference of 2, 4 or 8: if KVM_MAX_VCPUS is
> 1024, guests may be limited down to 128 vcpus on POWER8.
> 
> This means the check does not belong here and should be moved to some arch
> specific function: kvm_arch_vcpu_create() looks like a good candidate.
> 
> ARM and s390 already have such a check.
> 
> I could not spot any path in the PowerPC or common KVM code where a vcpu
> id is used as described in the above commit: I believe PowerPC can live
> without this check.
> 
> In the end, this patch simply moves the check to MIPS and x86.

The concept makes sense to me...

> 
> Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
> ---
> v2: move kzalloc() after the check in MIPS to avoid memory leak
> 
>  arch/mips/kvm/mips.c |    5 ++++-
>  arch/x86/kvm/x86.c   |    3 +++
>  virt/kvm/kvm_main.c  |    3 ---
>  3 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
> index 70ef1a43c114..c1ce9d44d685 100644
> --- a/arch/mips/kvm/mips.c
> +++ b/arch/mips/kvm/mips.c
> @@ -248,9 +248,12 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm, unsigned int id)
>  	int err, size, offset;
>  	void *gebase;
>  	int i;
> +	struct kvm_vcpu *vcpu;
> 
> -	struct kvm_vcpu *vcpu = kzalloc(sizeof(struct kvm_vcpu), GFP_KERNEL);
> +	if (id >= KVM_MAX_VCPUS)
> +		return -EINVAL;

...but you need to use ERR_PTR().

> 
> +	vcpu = kzalloc(sizeof(struct kvm_vcpu), GFP_KERNEL);
>  	if (!vcpu) {
>  		err = -ENOMEM;
>  		goto out;
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 9b7798c7b210..f705d57b12ed 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -7358,6 +7358,9 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm,
>  {
>  	struct kvm_vcpu *vcpu;
> 
> +	if (id >= KVM_MAX_VCPUS)
> +		return -EINVAL;

Here as well.

> +
>  	if (check_tsc_unstable() && atomic_read(&kvm->online_vcpus) != 0)
>  		printk_once(KERN_WARNING
>  		"kvm: SMP vm created on host with unstable TSC; "
