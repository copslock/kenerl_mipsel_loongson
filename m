Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Nov 2017 17:53:23 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:55800 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990451AbdK0QxNsAbwh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Nov 2017 17:53:13 +0100
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 244DFC04AC5C;
        Mon, 27 Nov 2017 16:53:07 +0000 (UTC)
Received: from [10.36.116.17] (ovpn-116-17.ams2.redhat.com [10.36.116.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A4E4F5C54A;
        Mon, 27 Nov 2017 16:53:02 +0000 (UTC)
Subject: Re: [PATCH 01/15] KVM: Prepare for moving vcpu_load/vcpu_put into
 arch specific code
To:     Christoffer Dall <christoffer.dall@linaro.org>, kvm@vger.kernel.org
Cc:     Andrew Jones <drjones@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Alexander Graf <agraf@suse.com>, kvm-ppc@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org
References: <20171125205718.7731-1-christoffer.dall@linaro.org>
 <20171125205718.7731-2-christoffer.dall@linaro.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <838db374-6040-c805-82f3-187a2cdfc40d@redhat.com>
Date:   Mon, 27 Nov 2017 17:53:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171125205718.7731-2-christoffer.dall@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 27 Nov 2017 16:53:07 +0000 (UTC)
Return-Path: <pbonzini@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61100
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pbonzini@redhat.com
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

On 25/11/2017 21:57, Christoffer Dall wrote:
> In preparation for moving calls to vcpu_load() and vcpu_put() into the
> architecture specific implementations of the KVM vcpu ioctls, move the
> calls in the main kvm_vcpu_ioctl() dispatcher function to each case
> of the ioctl select statement.  This allows us to move the vcpu_load()
> and vcpu_put() calls into architecture specific implementations of vcpu
> ioctls, one by one.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  virt/kvm/kvm_main.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 48 insertions(+), 5 deletions(-)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 9deb5a245b83..fafafcc38b5a 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2528,16 +2528,15 @@ static long kvm_vcpu_ioctl(struct file *filp,
>  		return kvm_arch_vcpu_ioctl(filp, ioctl, arg);
>  #endif
>  
> -
> -	r = vcpu_load(vcpu);
> -	if (r)
> -		return r;
>  	switch (ioctl) {
>  	case KVM_RUN: {
>  		struct pid *oldpid;
>  		r = -EINVAL;
>  		if (arg)
>  			goto out;
> +		r = vcpu_load(vcpu);
> +		if (r)
> +			goto out;
>  		oldpid = rcu_access_pointer(vcpu->pid);

If it is not a problem for ARM, maybe it would actually be best to leave
the locking in kvm_vcpu_ioctl (with the already existing exception of
KVM_INTERRUPT).  This would make vcpu_load void, and would also let you
keep the PID adjustment in common code.  This would be more similar to
the previous version, but without introducing __vcpu_load/__vcpu_put.

Looks good apart from this doubt!  Thanks,

Paolo
