Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Nov 2012 13:09:40 +0100 (CET)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:62237 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817667Ab2KAMJdnKTKt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Nov 2012 13:09:33 +0100
Received: by mail-lb0-f177.google.com with SMTP id gi11so1691766lbb.36
        for <linux-mips@linux-mips.org>; Thu, 01 Nov 2012 05:09:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=iXNpXsJoHsT7jgG2PaOsB5+AF9Z08hqO1PXa9ObolB8=;
        b=STny4TT5af+eY4gnAW1Bt80MdP5e4NnD7Kp18KvsjE7fzQWrHhZucyGy/BNu7w6tFI
         ZbOYMG3+lzaH3OYgcmQ1LXkPEekdZjr0OZ84ckdFeKJvQt/KYg0eDZx0NDcPFpBTi9kk
         Q5NRn61pDsubCK5L2Rrt6+rjw5GtIsONNTxVQG093BdkUtRpUr3K3uO9/v8+CgoWyW6x
         zCqp1xJ7vHVkQhSaWtZKohfYOpxJEDQQ0OjbUFiyQopwQ8UtJopxvEfBlKOYx8ZVmlnq
         JAXu/+uGvWeZ2IqV5JbT9t7x4kRM22tKrj3z40GpfXKxJRbatH2TyEO8p/7pPHDxeFp9
         UTXA==
Received: by 10.112.36.42 with SMTP id n10mr16049318lbj.42.1351771767933;
        Thu, 01 Nov 2012 05:09:27 -0700 (PDT)
Received: from [192.168.2.2] (ppp91-79-82-15.pppoe.mtu-net.ru. [91.79.82.15])
        by mx.google.com with ESMTPS id g5sm2249758lbk.7.2012.11.01.05.09.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 01 Nov 2012 05:09:27 -0700 (PDT)
Message-ID: <5092662E.7060800@mvista.com>
Date:   Thu, 01 Nov 2012 16:08:14 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:16.0) Gecko/20121026 Thunderbird/16.0.2
MIME-Version: 1.0
To:     Sanjay Lal <sanjayl@kymasys.com>
CC:     kvm@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 15/20] MIPS: If KVM is enabled then use the KVM specific
 routine to flush the TLBs on a ASID wrap
References: <333219EB-AEDE-47AE-BD69-2B69BBECD188@kymasys.com>
In-Reply-To: <333219EB-AEDE-47AE-BD69-2B69BBECD188@kymasys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQnhjy4fmxJt5KAfyjVr/O3hSb5HIk1ClLi6XS/qWBxfFKM3nZ3Yjn4kHUg6DLLJnDs0iqH/
X-archive-position: 34839
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 31-10-2012 19:20, Sanjay Lal wrote:

> Signed-off-by: Sanjay Lal <sanjayl@kymasys.com>
> ---
>   arch/mips/include/asm/mmu_context.h | 6 ++++++
>   1 file changed, 6 insertions(+)

> diff --git a/arch/mips/include/asm/mmu_context.h b/arch/mips/include/asm/mmu_context.h
> index 9b02cfb..9c7024c 100644
> --- a/arch/mips/include/asm/mmu_context.h
> +++ b/arch/mips/include/asm/mmu_context.h
> @@ -112,15 +112,21 @@ static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
>   static inline void
>   get_new_mmu_context(struct mm_struct *mm, unsigned long cpu)
>   {
> +    extern void kvm_local_flush_tlb_all(void);
>   	unsigned long asid = asid_cache(cpu);
>
>   	if (! ((asid += ASID_INC) & ASID_MASK) ) {
>   		if (cpu_has_vtag_icache)
>   			flush_icache_all();
> +#ifdef CONFIG_VIRTUALIZATION
> +        kvm_local_flush_tlb_all();      /* start new asid cycle */

    Please use tabs to indent the code, not spaces.

WBR, Sergei
