Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Jun 2013 15:17:39 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:32822 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6823020Ab3FNNRh5I5Xd (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 14 Jun 2013 15:17:37 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5EDHZxE025461;
        Fri, 14 Jun 2013 15:17:35 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5EDHZcu025460;
        Fri, 14 Jun 2013 15:17:35 +0200
Date:   Fri, 14 Jun 2013 15:17:35 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     linux-mips@linux-mips.org, kvm@vger.kernel.org,
        Sanjay Lal <sanjayl@kymasys.com>, linux-kernel@vger.kernel.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 05/31] mips/kvm: Use generic cache flushing functions.
Message-ID: <20130614131735.GG15775@linux-mips.org>
References: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
 <1370646215-6543-6-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1370646215-6543-6-git-send-email-ddaney.cavm@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36884
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Fri, Jun 07, 2013 at 04:03:09PM -0700, David Daney wrote:

> From: David Daney <david.daney@cavium.com>
> 
> We don't know if we have the r4k specific functions available, so use
> universally available __flush_cache_all() instead.  This takes longer
> as it flushes both i-cache and d-cache, but is available for all CPUs.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>  arch/mips/kvm/kvm_mips_emul.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/mips/kvm/kvm_mips_emul.c b/arch/mips/kvm/kvm_mips_emul.c
> index af9a661..a2c6687 100644
> --- a/arch/mips/kvm/kvm_mips_emul.c
> +++ b/arch/mips/kvm/kvm_mips_emul.c
> @@ -916,8 +916,6 @@ kvm_mips_emulate_cache(uint32_t inst, uint32_t *opc, uint32_t cause,
>  		       struct kvm_run *run, struct kvm_vcpu *vcpu)
>  {
>  	struct mips_coproc *cop0 = vcpu->arch.cop0;
> -	extern void (*r4k_blast_dcache) (void);
> -	extern void (*r4k_blast_icache) (void);
>  	enum emulation_result er = EMULATE_DONE;
>  	int32_t offset, cache, op_inst, op, base;
>  	struct kvm_vcpu_arch *arch = &vcpu->arch;
> @@ -954,9 +952,9 @@ kvm_mips_emulate_cache(uint32_t inst, uint32_t *opc, uint32_t cause,
>  		     arch->gprs[base], offset);
>  
>  		if (cache == MIPS_CACHE_DCACHE)
> -			r4k_blast_dcache();

Only nukes the D-cache.

> +			__flush_cache_all();

This is also going to blow away the I-cache, so will be slower.

>  		else if (cache == MIPS_CACHE_ICACHE)
> -			r4k_blast_icache();

Only nukes the I-cache.

> +			__flush_cache_all();

This is also going to blow away the D-cache, so will be slower.

  Ralf
