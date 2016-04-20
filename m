Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Apr 2016 17:21:28 +0200 (CEST)
Received: from e06smtp06.uk.ibm.com ([195.75.94.102]:55977 "EHLO
        e06smtp06.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026686AbcDTPV0Br5Gx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Apr 2016 17:21:26 +0200
Received: from localhost
        by e06smtp06.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <gkurz@linux.vnet.ibm.com>;
        Wed, 20 Apr 2016 16:21:19 +0100
Received: from d06dlp01.portsmouth.uk.ibm.com (9.149.20.13)
        by e06smtp06.uk.ibm.com (192.168.101.136) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Wed, 20 Apr 2016 16:21:12 +0100
X-IBM-Helo: d06dlp01.portsmouth.uk.ibm.com
X-IBM-MailFrom: gkurz@linux.vnet.ibm.com
X-IBM-RcptTo: linux-mips@linux-mips.org
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9F50F17D805D
        for <linux-mips@linux-mips.org>; Wed, 20 Apr 2016 16:21:59 +0100 (BST)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com [9.149.37.251])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u3KFLC7X7143742
        for <linux-mips@linux-mips.org>; Wed, 20 Apr 2016 15:21:12 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
        by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u3KELDkb023429
        for <linux-mips@linux-mips.org>; Wed, 20 Apr 2016 08:21:14 -0600
Received: from smtp.lab.toulouse-stg.fr.ibm.com (srv01.lab.toulouse-stg.fr.ibm.com [9.101.4.1])
        by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id u3KELD8O023414;
        Wed, 20 Apr 2016 08:21:13 -0600
Received: from bahia.huguette.org (sig-9-83-160-41.evts.uk.ibm.com [9.83.160.41])
        by smtp.lab.toulouse-stg.fr.ibm.com (Postfix) with ESMTP id EB1B2220083;
        Wed, 20 Apr 2016 17:21:09 +0200 (CEST)
Date:   Wed, 20 Apr 2016 17:21:07 +0200
From:   Greg Kurz <gkurz@linux.vnet.ibm.com>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, <mingo@redhat.com>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <qemu-ppc@nongnu.org>,
        Cornelia Huck <cornelia.huck@de.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] KVM: remove buggy vcpu id check on vcpu creation
Message-ID: <20160420172107.3c8a1076@bahia.huguette.org>
In-Reply-To: <20160420151246.GY7859@jhogan-linux.le.imgtec.org>
References: <146116487861.14909.7528002102875279653.stgit@bahia.huguette.org>
        <20160420151246.GY7859@jhogan-linux.le.imgtec.org>
Organization: IBM
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 16042015-0025-0000-0000-000013DD13E7
Return-Path: <gkurz@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53127
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

On Wed, 20 Apr 2016 16:12:46 +0100
James Hogan <james.hogan@imgtec.com> wrote:

> Hi Greg,
> 
> On Wed, Apr 20, 2016 at 05:07:58PM +0200, Greg Kurz wrote:
> > Commit 338c7dbadd26 ("KVM: Improve create VCPU parameter (CVE-2013-4587)")
> > introduced a check to prevent potential kernel memory corruption in case
> > the vcpu id is too great.
> > 
> > Unfortunately this check assumes vcpu ids grow in sequence with a common
> > difference of 1, which is wrong: archs are free to use vcpu id as they fit.
> > For example, QEMU originated vcpu ids for PowerPC cpus running in boot3s_hv
> > mode, can grow with a common difference of 2, 4 or 8: if KVM_MAX_VCPUS is
> > 1024, guests may be limited down to 128 vcpus on POWER8.
> > 
> > This means the check does not belong here and should be moved to some arch
> > specific function: kvm_arch_vcpu_create() looks like a good candidate.
> > 
> > ARM and s390 already have such a check.
> > 
> > I could not spot any path in the PowerPC or common KVM code where a vcpu
> > id is used as described in the above commit: I believe PowerPC can live
> > without this check.
> > 
> > In the end, this patch simply moves the check to MIPS and x86.
> > 
> > Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
> > ---
> >  arch/mips/kvm/mips.c |    3 +++
> >  arch/x86/kvm/x86.c   |    3 +++
> >  virt/kvm/kvm_main.c  |    3 ---
> >  3 files changed, 6 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
> > index 70ef1a43c114..ce3f1e8a8b3f 100644
> > --- a/arch/mips/kvm/mips.c
> > +++ b/arch/mips/kvm/mips.c
> > @@ -251,6 +251,9 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm, unsigned int id)
> >  
> >  	struct kvm_vcpu *vcpu = kzalloc(sizeof(struct kvm_vcpu), GFP_KERNEL);
> >  
> > +	if (id >= KVM_MAX_VCPUS)
> > +		return -EINVAL;  
> 
> This needs to go before the kzalloc above, otherwise you introduce a
> memory leak.
> 

Oops you're right.. my bad. I'll post a v2 right away.

Thanks !

--
Greg

> Cheers
> James
> 
> > +
> >  	if (!vcpu) {
> >  		err = -ENOMEM;
> >  		goto out;
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index 9b7798c7b210..f705d57b12ed 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -7358,6 +7358,9 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm,
> >  {
> >  	struct kvm_vcpu *vcpu;
> >  
> > +	if (id >= KVM_MAX_VCPUS)
> > +		return -EINVAL;
> > +
> >  	if (check_tsc_unstable() && atomic_read(&kvm->online_vcpus) != 0)
> >  		printk_once(KERN_WARNING
> >  		"kvm: SMP vm created on host with unstable TSC; "
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index 4fd482fb9260..6b6cca3cb488 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -2272,9 +2272,6 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, u32 id)
> >  	int r;
> >  	struct kvm_vcpu *vcpu;
> >  
> > -	if (id >= KVM_MAX_VCPUS)
> > -		return -EINVAL;
> > -
> >  	vcpu = kvm_arch_vcpu_create(kvm, id);
> >  	if (IS_ERR(vcpu))
> >  		return PTR_ERR(vcpu);
> >   
