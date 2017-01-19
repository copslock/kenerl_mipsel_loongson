Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jan 2017 10:50:19 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:33190 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993179AbdASJuMVkhr0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 19 Jan 2017 10:50:12 +0100
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D4F147F368;
        Thu, 19 Jan 2017 09:50:04 +0000 (UTC)
Received: from [10.36.116.242] (ovpn-116-242.ams2.redhat.com [10.36.116.242])
        by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id v0J9o000006645
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 19 Jan 2017 04:50:02 -0500
Subject: Re: [PATCH] MIPS: KVM: Return directly after a failed
 copy_from_user() in kvm_arch_vcpu_ioctl()
To:     SF Markus Elfring <elfring@users.sourceforge.net>,
        kvm@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <james.hogan@imgtec.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        =?UTF-8?Q?Ralf_B=c3=a4chle?= <ralf@linux-mips.org>
References: <87aac8b8-4f30-2edd-4688-42d32d815cd1@users.sourceforge.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <88b008c5-552b-7314-94d8-02214f38a456@redhat.com>
Date:   Thu, 19 Jan 2017 10:50:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <87aac8b8-4f30-2edd-4688-42d32d815cd1@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 19 Jan 2017 09:50:04 +0000 (UTC)
Return-Path: <pbonzini@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56408
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



On 18/01/2017 20:52, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 18 Jan 2017 20:43:41 +0100
> 
> Return directly after a call of the function "copy_from_user" failed
> in a case block.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

The "out" label is now unused, so you should remove it.

Paolo

> ---
>  arch/mips/kvm/mips.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
> index 06a60b19acfb..1dad78f74e8c 100644
> --- a/arch/mips/kvm/mips.c
> +++ b/arch/mips/kvm/mips.c
> @@ -1152,10 +1152,8 @@ long kvm_arch_vcpu_ioctl(struct file *filp, unsigned int ioctl,
>  		{
>  			struct kvm_mips_interrupt irq;
>  
> -			r = -EFAULT;
>  			if (copy_from_user(&irq, argp, sizeof(irq)))
> -				goto out;
> -
> +				return -EFAULT;
>  			kvm_debug("[%d] %s: irq: %d\n", vcpu->vcpu_id, __func__,
>  				  irq.irq);
>  
> @@ -1165,9 +1163,8 @@ long kvm_arch_vcpu_ioctl(struct file *filp, unsigned int ioctl,
>  	case KVM_ENABLE_CAP: {
>  		struct kvm_enable_cap cap;
>  
> -		r = -EFAULT;
>  		if (copy_from_user(&cap, argp, sizeof(cap)))
> -			goto out;
> +			return -EFAULT;
>  		r = kvm_vcpu_ioctl_enable_cap(vcpu, &cap);
>  		break;
>  	}
> 
