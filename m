Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Nov 2017 18:26:05 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:41740 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991957AbdK2RZ6JEUuV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 29 Nov 2017 18:25:58 +0100
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9C8CE60161;
        Wed, 29 Nov 2017 17:25:51 +0000 (UTC)
Received: from [10.36.117.80] (ovpn-117-80.ams2.redhat.com [10.36.117.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AED9D5D976;
        Wed, 29 Nov 2017 17:25:47 +0000 (UTC)
Subject: Re: [PATCH v2 02/16] KVM: Prepare for moving vcpu_load/vcpu_put into
 arch specific code
To:     Christoffer Dall <christoffer.dall@linaro.org>, kvm@vger.kernel.org
Cc:     Andrew Jones <drjones@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Alexander Graf <agraf@suse.com>, kvm-ppc@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org
References: <20171129164116.16167-1-christoffer.dall@linaro.org>
 <20171129164116.16167-3-christoffer.dall@linaro.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <4c2cd2f8-41e6-afdc-a3c0-a5872ba9b929@redhat.com>
Date:   Wed, 29 Nov 2017 18:25:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171129164116.16167-3-christoffer.dall@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 29 Nov 2017 17:25:51 +0000 (UTC)
Return-Path: <david@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61213
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

On 29.11.2017 17:41, Christoffer Dall wrote:
> In preparation for moving calls to vcpu_load() and vcpu_put() into the
> architecture specific implementations of the KVM vcpu ioctls, move the
> calls in the main kvm_vcpu_ioctl() dispatcher function to each case
> of the ioctl select statement.  This allows us to move the vcpu_load()
> and vcpu_put() calls into architecture specific implementations of vcpu
> ioctls, one by one.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  virt/kvm/kvm_main.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 39961fb..480b16c 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2525,13 +2525,13 @@ static long kvm_vcpu_ioctl(struct file *filp,
>  
>  	if (mutex_lock_killable(&vcpu->mutex))
>  		return -EINTR;
> -	vcpu_load(vcpu);
>  	switch (ioctl) {
>  	case KVM_RUN: {
>  		struct pid *oldpid;
>  		r = -EINVAL;
>  		if (arg)
>  			goto out;
> +		vcpu_load(vcpu);
>  		oldpid = rcu_access_pointer(vcpu->pid);
>  		if (unlikely(oldpid != current->pids[PIDTYPE_PID].pid)) {
>  			/* The thread running this VCPU changed. */
> @@ -2543,6 +2543,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
>  			put_pid(oldpid);
>  		}
>  		r = kvm_arch_vcpu_ioctl_run(vcpu, vcpu->run);
> +		vcpu_put(vcpu);
>  		trace_kvm_userspace_exit(vcpu->run->exit_reason, r);
>  		break;
>  	}
> @@ -2553,7 +2554,9 @@ static long kvm_vcpu_ioctl(struct file *filp,
>  		kvm_regs = kzalloc(sizeof(struct kvm_regs), GFP_KERNEL);
>  		if (!kvm_regs)
>  			goto out;
> +		vcpu_load(vcpu);
>  		r = kvm_arch_vcpu_ioctl_get_regs(vcpu, kvm_regs);
> +		vcpu_put(vcpu);
>  		if (r)
>  			goto out_free1;
>  		r = -EFAULT;
> @@ -2573,7 +2576,9 @@ static long kvm_vcpu_ioctl(struct file *filp,
>  			r = PTR_ERR(kvm_regs);
>  			goto out;
>  		}
> +		vcpu_load(vcpu);
>  		r = kvm_arch_vcpu_ioctl_set_regs(vcpu, kvm_regs);
> +		vcpu_put(vcpu);
>  		kfree(kvm_regs);
>  		break;
>  	}
> @@ -2582,7 +2587,9 @@ static long kvm_vcpu_ioctl(struct file *filp,
>  		r = -ENOMEM;
>  		if (!kvm_sregs)
>  			goto out;
> +		vcpu_load(vcpu);
>  		r = kvm_arch_vcpu_ioctl_get_sregs(vcpu, kvm_sregs);
> +		vcpu_put(vcpu);
>  		if (r)
>  			goto out;
>  		r = -EFAULT;
> @@ -2598,13 +2605,17 @@ static long kvm_vcpu_ioctl(struct file *filp,
>  			kvm_sregs = NULL;
>  			goto out;
>  		}
> +		vcpu_load(vcpu);
>  		r = kvm_arch_vcpu_ioctl_set_sregs(vcpu, kvm_sregs);
> +		vcpu_put(vcpu);
>  		break;
>  	}
>  	case KVM_GET_MP_STATE: {
>  		struct kvm_mp_state mp_state;
>  
> +		vcpu_load(vcpu);
>  		r = kvm_arch_vcpu_ioctl_get_mpstate(vcpu, &mp_state);
> +		vcpu_put(vcpu);
>  		if (r)
>  			goto out;
>  		r = -EFAULT;
> @@ -2619,7 +2630,9 @@ static long kvm_vcpu_ioctl(struct file *filp,
>  		r = -EFAULT;
>  		if (copy_from_user(&mp_state, argp, sizeof(mp_state)))
>  			goto out;
> +		vcpu_load(vcpu);
>  		r = kvm_arch_vcpu_ioctl_set_mpstate(vcpu, &mp_state);
> +		vcpu_put(vcpu);
>  		break;
>  	}
>  	case KVM_TRANSLATE: {
> @@ -2628,7 +2641,9 @@ static long kvm_vcpu_ioctl(struct file *filp,
>  		r = -EFAULT;
>  		if (copy_from_user(&tr, argp, sizeof(tr)))
>  			goto out;
> +		vcpu_load(vcpu);
>  		r = kvm_arch_vcpu_ioctl_translate(vcpu, &tr);
> +		vcpu_put(vcpu);
>  		if (r)
>  			goto out;
>  		r = -EFAULT;
> @@ -2643,7 +2658,9 @@ static long kvm_vcpu_ioctl(struct file *filp,
>  		r = -EFAULT;
>  		if (copy_from_user(&dbg, argp, sizeof(dbg)))
>  			goto out;
> +		vcpu_load(vcpu);
>  		r = kvm_arch_vcpu_ioctl_set_guest_debug(vcpu, &dbg);
> +		vcpu_put(vcpu);
>  		break;
>  	}
>  	case KVM_SET_SIGNAL_MASK: {
> @@ -2674,7 +2691,9 @@ static long kvm_vcpu_ioctl(struct file *filp,
>  		r = -ENOMEM;
>  		if (!fpu)
>  			goto out;
> +		vcpu_load(vcpu);
>  		r = kvm_arch_vcpu_ioctl_get_fpu(vcpu, fpu);
> +		vcpu_put(vcpu);
>  		if (r)
>  			goto out;
>  		r = -EFAULT;
> @@ -2690,14 +2709,17 @@ static long kvm_vcpu_ioctl(struct file *filp,
>  			fpu = NULL;
>  			goto out;
>  		}
> +		vcpu_load(vcpu);
>  		r = kvm_arch_vcpu_ioctl_set_fpu(vcpu, fpu);
> +		vcpu_put(vcpu);
>  		break;
>  	}
>  	default:
> +		vcpu_load(vcpu);
>  		r = kvm_arch_vcpu_ioctl(filp, ioctl, arg);
> +		vcpu_put(vcpu);
>  	}
>  out:
> -	vcpu_put(vcpu);
>  	mutex_unlock(&vcpu->mutex);
>  	kfree(fpu);
>  	kfree(kvm_sregs);
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
