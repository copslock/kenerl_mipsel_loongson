Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Aug 2017 13:52:05 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:56916 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992110AbdHVLv56UADt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 22 Aug 2017 13:51:57 +0200
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7F03EC05680C;
        Tue, 22 Aug 2017 11:51:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com 7F03EC05680C
Authentication-Results: ext-mx08.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx08.extmail.prod.ext.phx2.redhat.com; spf=fail smtp.mailfrom=david@redhat.com
Received: from [10.36.117.62] (ovpn-117-62.ams2.redhat.com [10.36.117.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7708B5E1D1;
        Tue, 22 Aug 2017 11:51:48 +0000 (UTC)
Subject: Re: [PATCH RFC v3 4/9] KVM: arm/arm64: use locking helpers in
 kvm_vgic_create()
To:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, kvm-ppc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Christoffer Dall <cdall@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Alexander Graf <agraf@suse.com>
References: <20170821203530.9266-1-rkrcmar@redhat.com>
 <20170821203530.9266-5-rkrcmar@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <1ef9ab09-b998-b0c9-86e3-7fd2234418fa@redhat.com>
Date:   Tue, 22 Aug 2017 13:51:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170821203530.9266-5-rkrcmar@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 22 Aug 2017 11:51:51 +0000 (UTC)
Return-Path: <david@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59757
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david@redhat.com
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

On 21.08.2017 22:35, Radim Krčmář wrote:
> No new VCPUs can be created because we are holding the kvm->lock.
> This means that if we successfuly lock all VCPUs, we'll be unlocking the
> same set and there is no need to do extra bookkeeping.
> 
> Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
> ---
>  virt/kvm/arm/vgic/vgic-init.c       | 24 +++++++++---------------
>  virt/kvm/arm/vgic/vgic-kvm-device.c |  6 +++++-
>  2 files changed, 14 insertions(+), 16 deletions(-)
> 
> diff --git a/virt/kvm/arm/vgic/vgic-init.c b/virt/kvm/arm/vgic/vgic-init.c
> index 5801261f3add..feb766f74c34 100644
> --- a/virt/kvm/arm/vgic/vgic-init.c
> +++ b/virt/kvm/arm/vgic/vgic-init.c
> @@ -119,7 +119,7 @@ void kvm_vgic_vcpu_early_init(struct kvm_vcpu *vcpu)
>   */
>  int kvm_vgic_create(struct kvm *kvm, u32 type)
>  {
> -	int i, vcpu_lock_idx = -1, ret;
> +	int i, ret;
>  	struct kvm_vcpu *vcpu;
>  
>  	if (irqchip_in_kernel(kvm))
> @@ -140,18 +140,14 @@ int kvm_vgic_create(struct kvm *kvm, u32 type)
>  	 * vcpu->mutex.  By grabbing the vcpu->mutex of all VCPUs we ensure
>  	 * that no other VCPUs are run while we create the vgic.
>  	 */
> -	ret = -EBUSY;
> -	kvm_for_each_vcpu(i, vcpu, kvm) {
> -		if (!mutex_trylock(&vcpu->mutex))
> -			goto out_unlock;
> -		vcpu_lock_idx = i;
> -	}
> +	if (!lock_all_vcpus(kvm))
> +		return -EBUSY;

Yes, this makes sense.

>  
> -	kvm_for_each_vcpu(i, vcpu, kvm) {
> -		if (vcpu->arch.has_run_once)
> +	kvm_for_each_vcpu(i, vcpu, kvm)
> +		if (vcpu->arch.has_run_once) {
> +			ret = -EBUSY;
>  			goto out_unlock;
> -	}
> -	ret = 0;
> +		}

somehow I prefer keeping the {}

>  
>  	if (type == KVM_DEV_TYPE_ARM_VGIC_V2)
>  		kvm->arch.max_vcpus = VGIC_V2_MAX_CPUS;
> @@ -176,11 +172,9 @@ int kvm_vgic_create(struct kvm *kvm, u32 type)
>  	kvm->arch.vgic.vgic_cpu_base = VGIC_ADDR_UNDEF;
>  	kvm->arch.vgic.vgic_redist_base = VGIC_ADDR_UNDEF;
>  
> +	ret = 0;
>  out_unlock:
> -	for (; vcpu_lock_idx >= 0; vcpu_lock_idx--) {
> -		vcpu = kvm_get_vcpu(kvm, vcpu_lock_idx);
> -		mutex_unlock(&vcpu->mutex);
> -	}
> +	unlock_all_vcpus(kvm);
>  	return ret;
>  }
>  
> diff --git a/virt/kvm/arm/vgic/vgic-kvm-device.c b/virt/kvm/arm/vgic/vgic-kvm-device.c
> index 10ae6f394b71..c5124737c7fc 100644
> --- a/virt/kvm/arm/vgic/vgic-kvm-device.c
> +++ b/virt/kvm/arm/vgic/vgic-kvm-device.c
> @@ -270,7 +270,11 @@ static void unlock_vcpus(struct kvm *kvm, int vcpu_lock_idx)
>  
>  void unlock_all_vcpus(struct kvm *kvm)
>  {
> -	unlock_vcpus(kvm, atomic_read(&kvm->online_vcpus) - 1);
> +	int i;
> +	struct kvm_vcpu *tmp_vcpu;
> +
> +	kvm_for_each_vcpu(i, tmp_vcpu, kvm)
> +		mutex_unlock(&tmp_vcpu->mutex);
>  }
>  
>  /* Returns true if all vcpus were locked, false otherwise */
> 

Looks sane to me.

-- 

Thanks,

David
