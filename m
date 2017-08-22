Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Aug 2017 16:19:20 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:52384 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992724AbdHVOTMTMeHR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 22 Aug 2017 16:19:12 +0200
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7E46C37E68;
        Tue, 22 Aug 2017 14:19:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com 7E46C37E68
Authentication-Results: ext-mx05.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx05.extmail.prod.ext.phx2.redhat.com; spf=fail smtp.mailfrom=david@redhat.com
Received: from [10.36.117.255] (unknown [10.36.117.255])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 92C2E7EF62;
        Tue, 22 Aug 2017 14:19:00 +0000 (UTC)
Subject: Re: [PATCH RFC v3 7/9] KVM: add kvm_free_vcpus and
 kvm_arch_free_vcpus
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
 <20170821203530.9266-8-rkrcmar@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <45e07499-e60c-5289-f439-9c51f59866ec@redhat.com>
Date:   Tue, 22 Aug 2017 16:18:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170821203530.9266-8-rkrcmar@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 22 Aug 2017 14:19:05 +0000 (UTC)
Return-Path: <david@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59759
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


> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 33a15e176927..0d2d8b0c785c 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -750,6 +750,23 @@ static void kvm_destroy_devices(struct kvm *kvm)
>  	}
>  }
>  
> +void kvm_free_vcpus(struct kvm *kvm)
> +{
> +	int i;
> +
> +	kvm_arch_free_vcpus(kvm);

I wonder if it would be possible to get rid of kvm_arch_free_vcpus(kvm)
completely and simply call

kvm_for_each_vcpu(i, vcpu, kvm)
	kvm_arch_vcpu_free(vcpu);

at that point.

Would certainly require some refactoring, and I am not sure if we could
modify the special mmu handling for x86 ("Unpin any mmu pages first.").
But if in doubt, that part could be moved to kvm_arch_destroy_vm(), just
before calling kvm_free_vcpus().

> +
> +	mutex_lock(&kvm->lock);
> +
> +	i = atomic_read(&kvm->online_vcpus);
> +	atomic_set(&kvm->online_vcpus, 0);

i = atomic_xchg(&kvm->online_vcpus, 0);

> +
> +	while (i--)
> +		kvm->vcpus[i] = NULL;
> +
> +	mutex_unlock(&kvm->lock);
> +}
> +
>  static void kvm_destroy_vm(struct kvm *kvm)
>  {
>  	int i;
> 


-- 

Thanks,

David
