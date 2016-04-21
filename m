Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Apr 2016 16:30:31 +0200 (CEST)
Received: from e06smtp05.uk.ibm.com ([195.75.94.101]:51164 "EHLO
        e06smtp05.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026758AbcDUOa26NAMz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Apr 2016 16:30:28 +0200
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <gkurz@linux.vnet.ibm.com>;
        Thu, 21 Apr 2016 15:30:23 +0100
Received: from d06dlp02.portsmouth.uk.ibm.com (9.149.20.14)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Thu, 21 Apr 2016 15:30:21 +0100
X-IBM-Helo: d06dlp02.portsmouth.uk.ibm.com
X-IBM-MailFrom: gkurz@linux.vnet.ibm.com
X-IBM-RcptTo: linux-mips@linux-mips.org
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9A0CA2190056
        for <linux-mips@linux-mips.org>; Thu, 21 Apr 2016 15:29:58 +0100 (BST)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com [9.149.37.251])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u3LEUKXO62783594
        for <linux-mips@linux-mips.org>; Thu, 21 Apr 2016 14:30:20 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
        by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u3LDUMHV024247
        for <linux-mips@linux-mips.org>; Thu, 21 Apr 2016 07:30:22 -0600
Received: from smtp.lab.toulouse-stg.fr.ibm.com (srv01.lab.toulouse-stg.fr.ibm.com [9.101.4.1])
        by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id u3LDULLZ023857;
        Thu, 21 Apr 2016 07:30:22 -0600
Received: from bahia.huguette.org (sig-9-83-160-41.evts.uk.ibm.com [9.83.160.41])
        by smtp.lab.toulouse-stg.fr.ibm.com (Postfix) with ESMTP id 3C80B220083;
        Thu, 21 Apr 2016 16:30:10 +0200 (CEST)
Date:   Thu, 21 Apr 2016 16:30:07 +0200
From:   Greg Kurz <gkurz@linux.vnet.ibm.com>
To:     David Hildenbrand <dahi@linux.vnet.ibm.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, james.hogan@imgtec.com,
        mingo@redhat.com, linux-mips@linux-mips.org, kvm@vger.kernel.org,
        rkrcmar@redhat.com, linux-kernel@vger.kernel.org,
        qemu-ppc@nongnu.org, Cornelia Huck <cornelia.huck@de.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v4 1/2] KVM: remove NULL return path for vcpu ids >=
 KVM_MAX_VCPUS
Message-ID: <20160421163007.6302a1bc@bahia.huguette.org>
In-Reply-To: <20160421161729.2f430008@thinkpad-w530>
References: <146124809455.32509.15232948272580716135.stgit@bahia.huguette.org>
        <146124810201.32509.2946887043729554992.stgit@bahia.huguette.org>
        <20160421161729.2f430008@thinkpad-w530>
Organization: IBM
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 16042114-0021-0000-0000-0000193F255A
Return-Path: <gkurz@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53173
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

On Thu, 21 Apr 2016 16:17:29 +0200
David Hildenbrand <dahi@linux.vnet.ibm.com> wrote:

> > Commit c896939f7cff ("KVM: use heuristic for fast VCPU lookup by id") added
> > a return path that prevents vcpu ids to exceed KVM_MAX_VCPUS. This is a
> > problem for powerpc where vcpu ids can grow up to 8*KVM_MAX_VCPUS.
> > 
> > This patch simply reverses the logic so that we only try fast path if the
> > vcpu id can be tried as an index in kvm->vcpus[]. The slow path is not
> > affected by the change.
> > 
> > Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
> > ---
> >  include/linux/kvm_host.h |    7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > index 5276fe0916fc..23bfe1bd159c 100644
> > --- a/include/linux/kvm_host.h
> > +++ b/include/linux/kvm_host.h
> > @@ -447,12 +447,13 @@ static inline struct kvm_vcpu *kvm_get_vcpu(struct kvm *kvm, int i)
> > 
> >  static inline struct kvm_vcpu *kvm_get_vcpu_by_id(struct kvm *kvm, int id)
> >  {
> > -	struct kvm_vcpu *vcpu;
> > +	struct kvm_vcpu *vcpu = NULL;
> >  	int i;
> > 
> > -	if (id < 0 || id >= KVM_MAX_VCPUS)
> > +	if (id < 0)
> >  		return NULL;
> > -	vcpu = kvm_get_vcpu(kvm, id);
> > +	if (id < KVM_MAX_VCPUS)
> > +		vcpu = kvm_get_vcpu(kvm, id);  
> 
> Maybe this check even should go into kvm_get_vcpu()
> 

Yeah possibly, but there are 19 users for kvm_get_vcpu() and I'm not sure if
none of them is on a hot path where this extra check could hurt... maybe this
can be done in a cleanup patch afterwards ?

> >  	if (vcpu && vcpu->vcpu_id == id)
> >  		return vcpu;
> >  	kvm_for_each_vcpu(i, vcpu, kvm)
> >   
> 
> Anyhow,
> 
> Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
> 
> David

Thanks for the review !

Cheers.

--
Greg
