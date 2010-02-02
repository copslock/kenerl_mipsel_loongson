Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Feb 2010 19:35:37 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:14614 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492498Ab0BBSfd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Feb 2010 19:35:33 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b686f340000>; Tue, 02 Feb 2010 10:30:17 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Tue, 2 Feb 2010 10:29:25 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Tue, 2 Feb 2010 10:29:25 -0800
Message-ID: <4B686F05.9090109@caviumnetworks.com>
Date:   Tue, 02 Feb 2010 10:29:25 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:     Guenter Roeck <guenter.roeck@ericsson.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH v6 01/01] Virtual memory size detection for 64 bit MIPS
 CPUs
References: <1265129540-10884-1-git-send-email-guenter.roeck@ericsson.com> <1265129540-10884-2-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1265129540-10884-2-git-send-email-guenter.roeck@ericsson.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Feb 2010 18:29:25.0586 (UTC) FILETIME=[A5D45B20:01CAA435]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25859
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Guenter Roeck wrote:
> Linux kernel 2.6.32 and later allocates memory from the top of virtual memory
> space.
> 
> This patch implements virtual memory size detection for 64 bit MIPS CPUs
> to avoid resulting crashes.
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>

Reviewed-by: David Daney <ddaney@caviumnetworks.com>


> ---
>  arch/mips/include/asm/cpu-features.h |    7 +++++++
>  arch/mips/include/asm/cpu-info.h     |    3 +++
>  arch/mips/include/asm/pgtable-64.h   |    4 +++-
>  arch/mips/kernel/cpu-probe.c         |   11 +++++++++++
>  4 files changed, 24 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
> index 1f4df64..e5835dd 100644
> --- a/arch/mips/include/asm/cpu-features.h
> +++ b/arch/mips/include/asm/cpu-features.h
> @@ -191,6 +191,9 @@
>  # ifndef cpu_has_64bit_addresses
>  # define cpu_has_64bit_addresses	0
>  # endif
> +# ifndef cpu_vmbits
> +# define cpu_vmbits 31
> +# endif
>  #endif
>  
>  #ifdef CONFIG_64BIT
> @@ -209,6 +212,10 @@
>  # ifndef cpu_has_64bit_addresses
>  # define cpu_has_64bit_addresses	1
>  # endif
> +# ifndef cpu_vmbits
> +# define cpu_vmbits cpu_data[0].vmbits
> +# define __NEED_VMBITS_PROBE
> +# endif
>  #endif
>  
>  #if defined(CONFIG_CPU_MIPSR2_IRQ_VI) && !defined(cpu_has_vint)
> diff --git a/arch/mips/include/asm/cpu-info.h b/arch/mips/include/asm/cpu-info.h
> index 1260443..b39def3 100644
> --- a/arch/mips/include/asm/cpu-info.h
> +++ b/arch/mips/include/asm/cpu-info.h
> @@ -58,6 +58,9 @@ struct cpuinfo_mips {
>  	struct cache_desc	tcache;	/* Tertiary/split secondary cache */
>  	int			srsets;	/* Shadow register sets */
>  	int			core;	/* physical core number */
> +#ifdef CONFIG_64BIT
> +	int			vmbits;	/* Virtual memory size in bits */
> +#endif
>  #if defined(CONFIG_MIPS_MT_SMP) || defined(CONFIG_MIPS_MT_SMTC)
>  	/*
>  	 * In the MIPS MT "SMTC" model, each TC is considered
> diff --git a/arch/mips/include/asm/pgtable-64.h b/arch/mips/include/asm/pgtable-64.h
> index 9cd5089..8eda30b 100644
> --- a/arch/mips/include/asm/pgtable-64.h
> +++ b/arch/mips/include/asm/pgtable-64.h
> @@ -110,7 +110,9 @@
>  #define VMALLOC_START		MAP_BASE
>  #define VMALLOC_END	\
>  	(VMALLOC_START + \
> -	 PTRS_PER_PGD * PTRS_PER_PMD * PTRS_PER_PTE * PAGE_SIZE - (1UL << 32))
> +	 min(PTRS_PER_PGD * PTRS_PER_PMD * PTRS_PER_PTE * PAGE_SIZE, \
> +	     (1UL << cpu_vmbits)) - (1UL << 32))
> +
>  #if defined(CONFIG_MODULES) && defined(KBUILD_64BIT_SYM32) && \
>  	VMALLOC_START != CKSSEG
>  /* Load modules into 32bit-compatible segment. */
> diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
> index 7a51866..00d7124 100644
> --- a/arch/mips/kernel/cpu-probe.c
> +++ b/arch/mips/kernel/cpu-probe.c
> @@ -282,6 +282,15 @@ static inline int __cpu_has_fpu(void)
>  	return ((cpu_get_fpu_id() & 0xff00) != FPIR_IMP_NONE);
>  }
>  
> +static inline void cpu_probe_vmbits(struct cpuinfo_mips *c)
> +{
> +#ifdef __NEED_VMBITS_PROBE
> +	write_c0_entryhi(0x3ffffffffffff000ULL);
> +	back_to_back_c0_hazard();
> +	c->vmbits = fls64(read_c0_entryhi() & 0x3ffffffffffff000ULL);
> +#endif
> +}
> +
>  #define R4K_OPTS (MIPS_CPU_TLB | MIPS_CPU_4KEX | MIPS_CPU_4K_CACHE \
>  		| MIPS_CPU_COUNTER)
>  
> @@ -967,6 +976,8 @@ __cpuinit void cpu_probe(void)
>  		c->srsets = ((read_c0_srsctl() >> 26) & 0x0f) + 1;
>  	else
>  		c->srsets = 1;
> +
> +	cpu_probe_vmbits(c);
>  }
>  
>  __cpuinit void cpu_report(void)
