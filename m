Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Mar 2015 14:58:51 +0100 (CET)
Received: from mail-wi0-f177.google.com ([209.85.212.177]:37266 "EHLO
        mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006155AbbCZN6si0o0q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Mar 2015 14:58:48 +0100
Received: by wiaa2 with SMTP id a2so23801323wia.0;
        Thu, 26 Mar 2015 06:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=NzuIpnlcXFmjjXFjczXOzYcQD41DQhwQJuE91s/ym58=;
        b=pjyiQoXOOkBku/4v/QwFS3tL6IaW4YTBUrmQzhvHqXXzCaGqa2VDtoIHFBnDIPFa14
         NY4na23Lq9+1yPC2byHjSloAJQPpeESKIi+dN1vHnybFN+4GUbxRoHjWYBGOoAi8QD/m
         xTSIMglFRWDkEB9IbG7o0MEHn0lmlnK/gSVnnlkHMggIi3t/7DgqWSHpitiqiU13QwPr
         kpFkstQr2HYY2v4yQw1uAO3HJIEYpB18mqDa6CY/m63MAgYmFTOeCY50YUcWyRs39Gwu
         p3CLBWdj4jBahlIZbegFJK56UYf9toYFZ1JE8mPHZ7Oh3dZKWz3HqzILnEWe3HqnKc7/
         SLwQ==
X-Received: by 10.194.159.105 with SMTP id xb9mr28544665wjb.156.1427378324372;
        Thu, 26 Mar 2015 06:58:44 -0700 (PDT)
Received: from [192.168.10.150] (net-93-66-123-41.cust.vodafonedsl.it. [93.66.123.41])
        by mx.google.com with ESMTPSA id hi6sm8520753wjc.34.2015.03.26.06.58.41
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Mar 2015 06:58:43 -0700 (PDT)
Message-ID: <5514108F.9060905@redhat.com>
Date:   Thu, 26 Mar 2015 14:58:39 +0100
From:   Paolo Bonzini <pbonzini@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     James Hogan <james.hogan@imgtec.com>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org
CC:     Ralf Baechle <ralf@linux-mips.org>, Gleb Natapov <gleb@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 20/20] MIPS: KVM: Wire up MSA capability
References: <1426085096-12932-1-git-send-email-james.hogan@imgtec.com> <1426085096-12932-21-git-send-email-james.hogan@imgtec.com>
In-Reply-To: <1426085096-12932-21-git-send-email-james.hogan@imgtec.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <paolo.bonzini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46547
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



On 11/03/2015 15:44, James Hogan wrote:
> Now that the code is in place for KVM to support MIPS SIMD Architecutre
> (MSA) in MIPS guests, wire up the new KVM_CAP_MIPS_MSA capability.
> 
> For backwards compatibility, the capability must be explicitly enabled
> in order to detect or make use of MSA from the guest.
> 
> The capability is not supported if the hardware supports MSA vector
> partitioning, since the extra support cannot be tested yet and it
> extends the state that the userland program would have to save.
> 
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Gleb Natapov <gleb@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-mips@linux-mips.org
> Cc: kvm@vger.kernel.org
> Cc: linux-api@vger.kernel.org
> Cc: linux-doc@vger.kernel.org
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> ---
>  Documentation/virtual/kvm/api.txt | 12 ++++++++++++
>  arch/mips/kvm/mips.c              | 24 ++++++++++++++++++++++++
>  include/uapi/linux/kvm.h          |  1 +
>  3 files changed, 37 insertions(+)
> 
> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> index 47ddf0475211..97dd9ee69ca8 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -3224,6 +3224,18 @@ done the KVM_REG_MIPS_FPR_* and KVM_REG_MIPS_FCR_* registers can be accessed
>  Config5.FRE bits are accessible via the KVM API and also from the guest,
>  depending on them being supported by the FPU.
>  
> +6.10 KVM_CAP_MIPS_MSA
> +
> +Architectures: mips
> +Target: vcpu
> +Parameters: args[0] is reserved for future use (should be 0).
> +
> +This capability allows the use of the MIPS SIMD Architecture (MSA) by the guest.
> +It allows the Config3.MSAP bit to be set to enable the use of MSA by the guest.
> +Once this is done the KVM_REG_MIPS_VEC_* and KVM_REG_MIPS_MSA_* registers can be
> +accessed, and the Config5.MSAEn bit is accessible via the KVM API and also from
> +the guest.
> +
>  7. Capabilities that can be enabled on VMs
>  ------------------------------------------
>  
> diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
> index 9319c4360285..3b3530f493eb 100644
> --- a/arch/mips/kvm/mips.c
> +++ b/arch/mips/kvm/mips.c
> @@ -880,6 +880,15 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
>  			return -EINVAL;
>  		vcpu->arch.fpu_enabled = true;
>  		break;
> +	case KVM_CAP_MIPS_MSA:
> +		/*
> +		 * MSA vector partitioning not supported,
> +		 * see kvm_vm_ioctl_check_extension().
> +		 */
> +		if (!cpu_has_msa || boot_cpu_data.msa_id & MSA_IR_WRPF)
> +			return -EINVAL;

Perhaps you can call kvm_vm_ioctl_check_extension directly, outside the
switch (it's okay if it's called for a capability other than FPU and MSA)?

Apart from this nit,

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo

> +		vcpu->arch.msa_enabled = true;
> +		break;
>  	default:
>  		r = -EINVAL;
>  		break;
> @@ -1071,6 +1080,21 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  	case KVM_CAP_MIPS_FPU:
>  		r = !!cpu_has_fpu;
>  		break;
> +	case KVM_CAP_MIPS_MSA:
> +		/*
> +		 * We don't support MSA vector partitioning yet:
> +		 * 1) It would require explicit support which can't be tested
> +		 *    yet due to lack of support in current hardware.
> +		 * 2) It extends the state that would need to be saved/restored
> +		 *    by e.g. QEMU for migration.
> +		 *
> +		 * When vector partitioning hardware becomes available, support
> +		 * could be added by requiring a flag when enabling
> +		 * KVM_CAP_MIPS_MSA capability to indicate that userland knows
> +		 * to save/restore the appropriate extra state.
> +		 */
> +		r = cpu_has_msa && !(boot_cpu_data.msa_id & MSA_IR_WRPF);
> +		break;
>  	default:
>  		r = 0;
>  		break;
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 98f6e5c653ff..5f859888e3ad 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -761,6 +761,7 @@ struct kvm_ppc_smmu_info {
>  #define KVM_CAP_CHECK_EXTENSION_VM 105
>  #define KVM_CAP_S390_USER_SIGP 106
>  #define KVM_CAP_MIPS_FPU 107
> +#define KVM_CAP_MIPS_MSA 108
>  
>  #ifdef KVM_CAP_IRQ_ROUTING
>  
> 
