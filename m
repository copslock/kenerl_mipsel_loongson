Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Apr 2016 11:41:34 +0200 (CEST)
Received: from e35.co.us.ibm.com ([32.97.110.153]:33614 "EHLO
        e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27027570AbcD0JlbxD36y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Apr 2016 11:41:31 +0200
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <gkurz@linux.vnet.ibm.com>;
        Wed, 27 Apr 2016 03:41:25 -0600
Received: from d03dlp01.boulder.ibm.com (9.17.202.177)
        by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Wed, 27 Apr 2016 03:40:56 -0600
X-IBM-Helo: d03dlp01.boulder.ibm.com
X-IBM-MailFrom: gkurz@linux.vnet.ibm.com
X-IBM-RcptTo: linux-mips@linux-mips.org
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id B1C7A1FF0049
        for <linux-mips@linux-mips.org>; Wed, 27 Apr 2016 03:40:40 -0600 (MDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u3R9etLJ27066574
        for <linux-mips@linux-mips.org>; Wed, 27 Apr 2016 09:40:55 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
        by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u3R9eso7029825
        for <linux-mips@linux-mips.org>; Wed, 27 Apr 2016 05:40:54 -0400
Received: from ltcweb.rtp.raleigh.ibm.com (ltcweb.rtp.raleigh.ibm.com [9.37.210.204])
        by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id u3R9eq1C029739;
        Wed, 27 Apr 2016 05:40:53 -0400
Received: by ltcweb.rtp.raleigh.ibm.com (Postfix, from userid 48)
        id D2408C0139; Wed, 27 Apr 2016 05:40:52 -0400 (EDT)
Received: from sig-9-84-87-14.evts.de.ibm.com
 (sig-9-84-87-14.evts.de.ibm.com [9.84.87.14]) by ltc.linux.ibm.com (Horde
 Framework) with HTTP; Wed, 27 Apr 2016 05:40:52 -0400
Date:   Wed, 27 Apr 2016 05:40:52 -0400
Message-ID: <20160427054052.Horde.SSxGXKxS_wcijUfLJchjWw2@ltc.linux.ibm.com>
From:   Gerg Kurz <gkurz@linux.vnet.ibm.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, james.hogan@imgtec.com,
        mingo@redhat.com
Cc:     linux-mips@linux-mips.org, kvm@vger.kernel.org, rkrcmar@redhat.com,
        linux-kernel@vger.kernel.org,
        David Hildenbrand <dahi@linux.vnet.ibm.com>,
        qemu-ppc@nongnu.org, Cornelia Huck <cornelia.huck@de.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        Radim =?utf-8?b?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v4 1/2] KVM: remove NULL return path for vcpu ids >=
 KVM_MAX_VCPUS
References: <146124809455.32509.15232948272580716135.stgit@bahia.huguette.org>
 <146124810201.32509.2946887043729554992.stgit@bahia.huguette.org>
In-Reply-To: <146124810201.32509.2946887043729554992.stgit@bahia.huguette.org>
User-Agent: Internet Messaging Program (IMP) H5 (6.1.7)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 16042709-0013-0000-0000-000034BA3E74
Return-Path: <gkurz@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53237
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


Quoting Greg Kurz <gkurz@linux.vnet.ibm.com>:

> Commit c896939f7cff ("KVM: use heuristic for fast VCPU lookup by id") added
> a return path that prevents vcpu ids to exceed KVM_MAX_VCPUS. This is a
> problem for powerpc where vcpu ids can grow up to 8*KVM_MAX_VCPUS.
>
> This patch simply reverses the logic so that we only try fast path if the
> vcpu id can be tried as an index in kvm->vcpus[]. The slow path is not
> affected by the change.
>
> Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
> ---

Radim,

I think this sanity check is only needed because kvm_get_vcpu() use the
id as an index in kvm->vcpus[]. Checking against the new KVM_MAX_VCPU_ID
would be clearly wrong here.

And this patch got two R-b tags already. Do you agree we keep it ?

Cheers.

--
Greg

>  include/linux/kvm_host.h |    7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 5276fe0916fc..23bfe1bd159c 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -447,12 +447,13 @@ static inline struct kvm_vcpu  
> *kvm_get_vcpu(struct kvm *kvm, int i)
>
>  static inline struct kvm_vcpu *kvm_get_vcpu_by_id(struct kvm *kvm, int id)
>  {
> -	struct kvm_vcpu *vcpu;
> +	struct kvm_vcpu *vcpu = NULL;
>  	int i;
>
> -	if (id < 0 || id >= KVM_MAX_VCPUS)
> +	if (id < 0)
>  		return NULL;
> -	vcpu = kvm_get_vcpu(kvm, id);
> +	if (id < KVM_MAX_VCPUS)
> +		vcpu = kvm_get_vcpu(kvm, id);
>  	if (vcpu && vcpu->vcpu_id == id)
>  		return vcpu;
>  	kvm_for_each_vcpu(i, vcpu, kvm)
>
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
