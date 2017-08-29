Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Aug 2017 13:31:29 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:57610 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994928AbdH2LbOy4L9V convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Aug 2017 13:31:14 +0200
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 715285D686;
        Tue, 29 Aug 2017 11:31:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com 715285D686
Authentication-Results: ext-mx10.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx10.extmail.prod.ext.phx2.redhat.com; spf=fail smtp.mailfrom=cohuck@redhat.com
Received: from gondolin (dhcp-192-215.str.redhat.com [10.33.192.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B9D6E63646;
        Tue, 29 Aug 2017 11:31:01 +0000 (UTC)
Date:   Tue, 29 Aug 2017 13:30:59 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, kvm-ppc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Christoffer Dall <cdall@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Alexander Graf <agraf@suse.com>
Subject: Re: [PATCH RFC v3 3/9] KVM: remember position in kvm->vcpus array
Message-ID: <20170829133059.2b9442a5.cohuck@redhat.com>
In-Reply-To: <20170821203530.9266-4-rkrcmar@redhat.com>
References: <20170821203530.9266-1-rkrcmar@redhat.com>
        <20170821203530.9266-4-rkrcmar@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 29 Aug 2017 11:31:08 +0000 (UTC)
Return-Path: <cohuck@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59859
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cohuck@redhat.com
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

On Mon, 21 Aug 2017 22:35:24 +0200
Radim Krčmář <rkrcmar@redhat.com> wrote:

> Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
> ---
>  include/linux/kvm_host.h | 11 +++--------
>  virt/kvm/kvm_main.c      |  5 ++++-
>  2 files changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 6882538eda32..a8ff956616d2 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -220,7 +220,8 @@ struct kvm_vcpu {
>  	struct preempt_notifier preempt_notifier;
>  #endif
>  	int cpu;
> -	int vcpu_id;
> +	int vcpu_id; /* id given by userspace at creation */
> +	int vcpus_idx; /* index in kvm->vcpus array */

I predict confusion in the future over which is which... maybe
s/vcpus_idx/vcpus_array_pos/ or something like that?

>  	int srcu_idx;
>  	int mode;
>  	unsigned long requests;
> @@ -516,13 +517,7 @@ static inline struct kvm_vcpu *kvm_get_vcpu_by_id(struct kvm *kvm, int id)
>  
>  static inline int kvm_vcpu_get_idx(struct kvm_vcpu *vcpu)
>  {
> -	struct kvm_vcpu *tmp;
> -	int idx;
> -
> -	kvm_for_each_vcpu(idx, tmp, vcpu->kvm)
> -		if (tmp == vcpu)
> -			return idx;
> -	BUG();
> +	return vcpu->vcpus_idx;
>  }
>  
>  #define kvm_for_each_memslot(memslot, slots)	\
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index e17c40d986f3..caf8323f7df7 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2498,7 +2498,10 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, u32 id)
>  		goto unlock_vcpu_destroy;
>  	}
>  
> -	BUG_ON(kvm->vcpus[atomic_read(&kvm->online_vcpus)]);
> +	vcpu->vcpus_idx = atomic_read(&kvm->online_vcpus);
> +
> +	BUG_ON(kvm->vcpus[vcpu->vcpus_idx]);
> +
>  
>  	/* Now it's all set up, let userspace reach it */
>  	kvm_get_kvm(kvm);

I like the concept.
