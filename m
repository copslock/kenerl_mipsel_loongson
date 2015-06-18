Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Jun 2015 18:52:26 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:18907 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009005AbbFRQwZBuL08 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Jun 2015 18:52:25 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id DD4AE738ABA45;
        Thu, 18 Jun 2015 17:52:15 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 18 Jun 2015 17:52:18 +0100
Received: from [192.168.154.94] (192.168.154.94) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 18 Jun
 2015 17:52:18 +0100
Message-ID: <5582F742.30905@imgtec.com>
Date:   Thu, 18 Jun 2015 17:52:18 +0100
From:   Qais Yousef <qais.yousef@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Tony Wu <tung7970@gmail.com>
CC:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: Re: [PATCH] MIPS: Add platform specific secondary core init
References: <20150618220254-tung7970@googlemail.com>
In-Reply-To: <20150618220254-tung7970@googlemail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47971
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: qais.yousef@imgtec.com
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

On 06/18/2015 03:05 PM, Tony Wu wrote:
> Define plat_smp_init_secondary() API, and move platform specific
> secondary core initialization to each platform.

I really can't see that this code being platform specific. Why would a 
platform care about the c0_status register when a secondary boot is 
initialised?

That comment about Malta in smp-mt.c is misleading.

Qais

>
> Signed-off-by: Tony Wu <tung7970@gmail.com>
> Cc: James Hogan <james.hogan@imgtec.com>
> Cc: Paul Burton <paul.burton@imgtec.com>
> Cc: linux-mips@linux-mips.org
> ---
>   arch/mips/include/asm/smp-ops.h  |    1 +
>   arch/mips/kernel/smp-cmp.c       |    8 ++------
>   arch/mips/kernel/smp-cps.c       |    4 ++--
>   arch/mips/kernel/smp-mt.c        |   12 ++----------
>   arch/mips/mti-malta/malta-init.c |   13 +++++++++++++
>   5 files changed, 20 insertions(+), 18 deletions(-)
>
> diff --git a/arch/mips/include/asm/smp-ops.h b/arch/mips/include/asm/smp-ops.h
> index 6ba1fb8..53ce7e1 100644
> --- a/arch/mips/include/asm/smp-ops.h
> +++ b/arch/mips/include/asm/smp-ops.h
> @@ -36,6 +36,7 @@ struct plat_smp_ops {
>   };
>   
>   extern void register_smp_ops(struct plat_smp_ops *ops);
> +extern void plat_smp_init_secondary(void)
>   
>   static inline void plat_smp_setup(void)
>   {
> diff --git a/arch/mips/kernel/smp-cmp.c b/arch/mips/kernel/smp-cmp.c
> index d5e0f94..e8c0258 100644
> --- a/arch/mips/kernel/smp-cmp.c
> +++ b/arch/mips/kernel/smp-cmp.c
> @@ -43,17 +43,13 @@ static void cmp_init_secondary(void)
>   {
>   	struct cpuinfo_mips *c __maybe_unused = &current_cpu_data;
>   
> -	/* Assume GIC is present */
> -	change_c0_status(ST0_IM, STATUSF_IP2 | STATUSF_IP3 | STATUSF_IP4 |
> -				 STATUSF_IP5 | STATUSF_IP6 | STATUSF_IP7);
> -
> -	/* Enable per-cpu interrupts: platform specific */
> -
>   #ifdef CONFIG_MIPS_MT_SMP
>   	if (cpu_has_mipsmt)
>   		c->vpe_id = (read_c0_tcbind() >> TCBIND_CURVPE_SHIFT) &
>   			TCBIND_CURVPE;
>   #endif
> +	/* Call platform specific init secondary */
> +	plat_smp_init_secondary();
>   }
>   
>   static void cmp_smp_finish(void)
> diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
> index 4251d39..5570bc8 100644
> --- a/arch/mips/kernel/smp-cps.c
> +++ b/arch/mips/kernel/smp-cps.c
> @@ -279,8 +279,8 @@ static void cps_init_secondary(void)
>   	if (cpu_has_mipsmt)
>   		dmt();
>   
> -	change_c0_status(ST0_IM, STATUSF_IP2 | STATUSF_IP3 | STATUSF_IP4 |
> -				 STATUSF_IP5 | STATUSF_IP6 | STATUSF_IP7);
> +	/* Call platform specific init secondary */
> +	plat_smp_init_secondary();
>   }
>   
>   static void cps_smp_finish(void)
> diff --git a/arch/mips/kernel/smp-mt.c b/arch/mips/kernel/smp-mt.c
> index 86311a1..3d1e32a 100644
> --- a/arch/mips/kernel/smp-mt.c
> +++ b/arch/mips/kernel/smp-mt.c
> @@ -158,16 +158,8 @@ static void vsmp_send_ipi_mask(const struct cpumask *mask, unsigned int action)
>   
>   static void vsmp_init_secondary(void)
>   {
> -#ifdef CONFIG_MIPS_GIC
> -	/* This is Malta specific: IPI,performance and timer interrupts */
> -	if (gic_present)
> -		change_c0_status(ST0_IM, STATUSF_IP2 | STATUSF_IP3 |
> -					 STATUSF_IP4 | STATUSF_IP5 |
> -					 STATUSF_IP6 | STATUSF_IP7);
> -	else
> -#endif
> -		change_c0_status(ST0_IM, STATUSF_IP0 | STATUSF_IP1 |
> -					 STATUSF_IP6 | STATUSF_IP7);
> +	/* Call platform specific init secondary */
> +	plat_smp_init_secondary();
>   }
>   
>   static void vsmp_smp_finish(void)
> diff --git a/arch/mips/mti-malta/malta-init.c b/arch/mips/mti-malta/malta-init.c
> index cec3e18..3385ad9 100644
> --- a/arch/mips/mti-malta/malta-init.c
> +++ b/arch/mips/mti-malta/malta-init.c
> @@ -116,6 +116,19 @@ phys_addr_t mips_cpc_default_phys_base(void)
>   	return CPC_BASE_ADDR;
>   }
>   
> +void plat_smp_init_secondary(void)
> +{
> +#ifdef CONFIG_MIPS_GIC
> +	if (gic_present)
> +		change_c0_status(ST0_IM, STATUSF_IP2 | STATUSF_IP3 |
> +					 STATUSF_IP4 | STATUSF_IP5 |
> +					 STATUSF_IP6 | STATUSF_IP7);
> +	else
> +#endif
> +		change_c0_status(ST0_IM, STATUSF_IP0 | STATUSF_IP1 |
> +					 STATUSF_IP6 | STATUSF_IP7);
> +}
> +
>   void __init prom_init(void)
>   {
>   	mips_display_message("LINUX");
