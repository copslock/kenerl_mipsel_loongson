Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Apr 2014 18:44:30 +0200 (CEST)
Received: from mail-ig0-f180.google.com ([209.85.213.180]:39241 "EHLO
        mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816615AbaDYQo2TGX3O (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 Apr 2014 18:44:28 +0200
Received: by mail-ig0-f180.google.com with SMTP id c1so2419878igq.1
        for <multiple recipients>; Fri, 25 Apr 2014 09:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=YoTjWSzDuhFf3p+WI+iP5zgoY3ZLR9SIMdOby0JsjdQ=;
        b=BmJXuFPuERGevk0CFyVFQNiE1sURNw9pD3WV5k8UEeQErzjpIcS06pHKpJE97o7QLJ
         WIYg0GYMr/IPuq9iTpIazRqPAlrVIbHOMO7gSvIAIUVq2vQpJEnrUgVbh13sfNG6yv3e
         ZwtZnDmS/qE9NQZWsZrF071hYUgI85iIHLlSPJiW4gb3wG8BWyOJ5iZAvnsgglK5CwnW
         YA1Rq2b3ZLPzQHrNPSopQrWDGQFtemrHQ0RYQFb06gFrl+ylastYb6/8GaCTrlMnAfrc
         Olc9tdSUtKGC8JDrrsiVcLezcH904KgLIZ4rc6IasqS1LptihzHkXzf0hGwnAISrH7z4
         WV3g==
X-Received: by 10.42.106.15 with SMTP id x15mr2460628ico.67.1398444261877;
        Fri, 25 Apr 2014 09:44:21 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id b6sm9923216igm.2.2014.04.25.09.44.18
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 25 Apr 2014 09:44:19 -0700 (PDT)
Message-ID: <535A90E1.2030705@gmail.com>
Date:   Fri, 25 Apr 2014 09:44:17 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     James Hogan <james.hogan@imgtec.com>
CC:     Paolo Bonzini <pbonzini@redhat.com>,
        Gleb Natapov <gleb@kernel.org>, kvm@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        David Daney <david.daney@cavium.com>,
        Sanjay Lal <sanjayl@kymasys.com>
Subject: Re: [PATCH 05/21] MIPS: KVM: Add CP0_EPC KVM register access
References: <1398439204-26171-1-git-send-email-james.hogan@imgtec.com> <1398439204-26171-6-git-send-email-james.hogan@imgtec.com>
In-Reply-To: <1398439204-26171-6-git-send-email-james.hogan@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39948
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 04/25/2014 08:19 AM, James Hogan wrote:
> Contrary to the comment, the guest CP0_EPC register cannot be set via
> kvm_regs, since it is distinct from the guest PC. Add the EPC register
> to the KVM_{GET,SET}_ONE_REG ioctl interface.
>
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Gleb Natapov <gleb@kernel.org>
> Cc: kvm@vger.kernel.org
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Cc: David Daney <david.daney@cavium.com>
> Cc: Sanjay Lal <sanjayl@kymasys.com>

NACK...


> ---
>   arch/mips/kvm/kvm_mips.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/arch/mips/kvm/kvm_mips.c b/arch/mips/kvm/kvm_mips.c
> index 46cea0bad518..db41876cbac5 100644
> --- a/arch/mips/kvm/kvm_mips.c
> +++ b/arch/mips/kvm/kvm_mips.c
> @@ -512,6 +512,7 @@ kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
>   #define KVM_REG_MIPS_CP0_COMPARE	MIPS_CP0_32(11, 0)
>   #define KVM_REG_MIPS_CP0_STATUS		MIPS_CP0_32(12, 0)
>   #define KVM_REG_MIPS_CP0_CAUSE		MIPS_CP0_32(13, 0)
> +#define KVM_REG_MIPS_CP0_EPC		MIPS_CP0_64(14, 0)

This is already called KVM_REG_MIPS_PC, you cannot change that.


>   #define KVM_REG_MIPS_CP0_EBASE		MIPS_CP0_32(15, 1)
>   #define KVM_REG_MIPS_CP0_CONFIG		MIPS_CP0_32(16, 0)
>   #define KVM_REG_MIPS_CP0_CONFIG1	MIPS_CP0_32(16, 1)
> @@ -567,7 +568,7 @@ static u64 kvm_mips_get_one_regs[] = {
>   	KVM_REG_MIPS_CP0_ENTRYHI,
>   	KVM_REG_MIPS_CP0_STATUS,
>   	KVM_REG_MIPS_CP0_CAUSE,
> -	/* EPC set via kvm_regs, et al. */
> +	KVM_REG_MIPS_CP0_EPC,
>   	KVM_REG_MIPS_CP0_CONFIG,
>   	KVM_REG_MIPS_CP0_CONFIG1,
>   	KVM_REG_MIPS_CP0_CONFIG2,
> @@ -620,6 +621,9 @@ static int kvm_mips_get_reg(struct kvm_vcpu *vcpu,
>   	case KVM_REG_MIPS_CP0_CAUSE:
>   		v = (long)kvm_read_c0_guest_cause(cop0);
>   		break;
> +	case KVM_REG_MIPS_CP0_EPC:
> +		v = (long)kvm_read_c0_guest_epc(cop0);
> +		break;
>   	case KVM_REG_MIPS_CP0_ERROREPC:
>   		v = (long)kvm_read_c0_guest_errorepc(cop0);
>   		break;
> @@ -716,6 +720,9 @@ static int kvm_mips_set_reg(struct kvm_vcpu *vcpu,
>   	case KVM_REG_MIPS_CP0_CAUSE:
>   		kvm_write_c0_guest_cause(cop0, v);
>   		break;
> +	case KVM_REG_MIPS_CP0_EPC:
> +		kvm_write_c0_guest_epc(cop0, v);
> +		break;
>   	case KVM_REG_MIPS_CP0_ERROREPC:
>   		kvm_write_c0_guest_errorepc(cop0, v);
>   		break;
>
