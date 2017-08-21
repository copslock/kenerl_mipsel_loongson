Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Aug 2017 15:49:20 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43315 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993868AbdHUNtJ39W9z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 Aug 2017 15:49:09 +0200
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v7LDn4uT105453
        for <linux-mips@linux-mips.org>; Mon, 21 Aug 2017 09:49:08 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2cg0611pte-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Mon, 21 Aug 2017 09:49:05 -0400
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <borntraeger@de.ibm.com>;
        Mon, 21 Aug 2017 14:49:03 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp14.uk.ibm.com (192.168.101.144) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Mon, 21 Aug 2017 14:48:58 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v7LDmwWM11927656;
        Mon, 21 Aug 2017 13:48:58 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 43FBBA4057;
        Mon, 21 Aug 2017 14:45:38 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CDE09A404D;
        Mon, 21 Aug 2017 14:45:37 +0100 (BST)
Received: from oc7330422307.ibm.com (unknown [9.152.224.206])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 21 Aug 2017 14:45:37 +0100 (BST)
Subject: Re: [PATCH RFC 1/2] KVM: remove unused __KVM_HAVE_ARCH_VM_ALLOC
To:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, kvm-ppc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Christoffer Dall <cdall@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Alexander Graf <agraf@suse.com>
References: <20170816194037.9460-1-rkrcmar@redhat.com>
 <20170816194037.9460-2-rkrcmar@redhat.com>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Date:   Mon, 21 Aug 2017 15:48:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20170816194037.9460-2-rkrcmar@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 17082113-0016-0000-0000-000004E52CA7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 17082113-0017-0000-0000-0000281E5CAC
Message-Id: <b73c394a-cd08-1f70-aaf5-5387d5a9adce@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-08-21_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=2
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.0.1-1707230000
 definitions=main-1708210220
Return-Path: <borntraeger@de.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59735
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

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>

Since we removed ia64 from KVM we no longer need an _arch_ variant.

On 08/16/2017 09:40 PM, Radim Krčmář wrote:
> Moving it to generic code will allow us to extend it with ease.
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
> ---
>  include/linux/kvm_host.h | 12 ------------
>  virt/kvm/kvm_main.c      | 16 +++++++++++++---
>  2 files changed, 13 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 6882538eda32..c8df733eed41 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -803,18 +803,6 @@ int kvm_arch_vcpu_runnable(struct kvm_vcpu *vcpu);
>  bool kvm_arch_vcpu_in_kernel(struct kvm_vcpu *vcpu);
>  int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu);
> 
> -#ifndef __KVM_HAVE_ARCH_VM_ALLOC
> -static inline struct kvm *kvm_arch_alloc_vm(void)
> -{
> -	return kzalloc(sizeof(struct kvm), GFP_KERNEL);
> -}
> -
> -static inline void kvm_arch_free_vm(struct kvm *kvm)
> -{
> -	kfree(kvm);
> -}
> -#endif
> -
>  #ifdef __KVM_HAVE_ARCH_NONCOHERENT_DMA
>  void kvm_arch_register_noncoherent_dma(struct kvm *kvm);
>  void kvm_arch_unregister_noncoherent_dma(struct kvm *kvm);
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index e17c40d986f3..2eac2c62795f 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -640,10 +640,20 @@ static int kvm_create_vm_debugfs(struct kvm *kvm, int fd)
>  	return 0;
>  }
> 
> +static inline struct kvm *kvm_alloc_vm(void)
> +{
> +	return kzalloc(sizeof(struct kvm), GFP_KERNEL);
> +}
> +
> +static inline void kvm_free_vm(struct kvm *kvm)
> +{
> +	kfree(kvm);
> +}
> +
>  static struct kvm *kvm_create_vm(unsigned long type)
>  {
>  	int r, i;
> -	struct kvm *kvm = kvm_arch_alloc_vm();
> +	struct kvm *kvm = kvm_alloc_vm();
> 
>  	if (!kvm)
>  		return ERR_PTR(-ENOMEM);
> @@ -720,7 +730,7 @@ static struct kvm *kvm_create_vm(unsigned long type)
>  		kfree(kvm_get_bus(kvm, i));
>  	for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++)
>  		kvm_free_memslots(kvm, __kvm_memslots(kvm, i));
> -	kvm_arch_free_vm(kvm);
> +	kvm_free_vm(kvm);
>  	mmdrop(current->mm);
>  	return ERR_PTR(r);
>  }
> @@ -771,7 +781,7 @@ static void kvm_destroy_vm(struct kvm *kvm)
>  		kvm_free_memslots(kvm, __kvm_memslots(kvm, i));
>  	cleanup_srcu_struct(&kvm->irq_srcu);
>  	cleanup_srcu_struct(&kvm->srcu);
> -	kvm_arch_free_vm(kvm);
> +	kvm_free_vm(kvm);
>  	preempt_notifier_dec();
>  	hardware_disable_all();
>  	mmdrop(mm);
> 
