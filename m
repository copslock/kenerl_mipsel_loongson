Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jun 2014 11:10:08 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:57228 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6843037AbaFYJKD4u44r (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Jun 2014 11:10:03 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 24B53D01638A0;
        Wed, 25 Jun 2014 10:09:55 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.10.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Wed, 25 Jun
 2014 10:09:57 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.10.222) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Wed, 25 Jun 2014 10:09:57 +0100
Received: from [192.168.154.101] (192.168.154.101) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.174.1; Wed, 25 Jun
 2014 10:09:56 +0100
Message-ID: <53AA91E4.3090605@imgtec.com>
Date:   Wed, 25 Jun 2014 10:09:56 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>, <pbonzini@redhat.com>
CC:     <gleb@kernel.org>, <kvm@vger.kernel.org>, <sanjayl@kymasys.com>,
        <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH v3 4/9] MIPS: KVM: Remove unneeded volatile
References: <1403631071-6012-1-git-send-email-dengcheng.zhu@imgtec.com> <1403631071-6012-5-git-send-email-dengcheng.zhu@imgtec.com>
In-Reply-To: <1403631071-6012-5-git-send-email-dengcheng.zhu@imgtec.com>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.101]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40797
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

On 24/06/14 18:31, Deng-Cheng Zhu wrote:
> From: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
> 
> The keyword volatile for idx in the TLB functions is unnecessary.
> 
> Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>

Reviewed-by: James Hogan <james.hogan@imgtec.com>

Cheers
James

> ---
>  arch/mips/kvm/kvm_tlb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/kvm/kvm_tlb.c b/arch/mips/kvm/kvm_tlb.c
> index 29a5bdb..bbcd822 100644
> --- a/arch/mips/kvm/kvm_tlb.c
> +++ b/arch/mips/kvm/kvm_tlb.c
> @@ -201,7 +201,7 @@ int kvm_mips_host_tlb_write(struct kvm_vcpu *vcpu, unsigned long entryhi,
>  {
>  	unsigned long flags;
>  	unsigned long old_entryhi;
> -	volatile int idx;
> +	int idx;
>  
>  	local_irq_save(flags);
>  
> @@ -426,7 +426,7 @@ EXPORT_SYMBOL(kvm_mips_guest_tlb_lookup);
>  int kvm_mips_host_tlb_lookup(struct kvm_vcpu *vcpu, unsigned long vaddr)
>  {
>  	unsigned long old_entryhi, flags;
> -	volatile int idx;
> +	int idx;
>  
>  	local_irq_save(flags);
>  
> 
