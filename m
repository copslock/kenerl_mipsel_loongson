Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jan 2015 13:56:37 +0100 (CET)
Received: from resqmta-ch2-08v.sys.comcast.net ([69.252.207.40]:34858 "EHLO
        resqmta-ch2-08v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011973AbbAUM4dNun7i (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Jan 2015 13:56:33 +0100
Received: from resomta-ch2-11v.sys.comcast.net ([69.252.207.107])
        by resqmta-ch2-08v.sys.comcast.net with comcast
        id icvB1p0082Ka2Q501cwSMa; Wed, 21 Jan 2015 12:56:26 +0000
Received: from [192.168.1.13] ([73.212.71.42])
        by resomta-ch2-11v.sys.comcast.net with comcast
        id icwR1p0070uk1nt01cwRRT; Wed, 21 Jan 2015 12:56:26 +0000
Message-ID: <54BFA1F0.3010601@gentoo.org>
Date:   Wed, 21 Jan 2015 07:56:16 -0500
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Add R16000 detection
References: <54BC5E43.8060606@gentoo.org>
In-Reply-To: <54BC5E43.8060606@gentoo.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1421844986;
        bh=o96LyPZE9VvAkWUoGTkbQwbxs4MZjaU5jqLwGFfMh7w=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=wsQgnaWg/HcYC8LP4mKgGIHwjvjdVoDVXVtevizEGWERaxWh4bUN3CtCAepB0orP2
         i7nzEKzLDeDn2eASw6zD1VxOrAPIQAsOcyFJAPh4UzWfq7ESRVxI9tt9XTQaT4HV1i
         0YyZ+BJHl9AWhLE01Ro+j/86csnoebpTCT67zlqxf3b21YqaYp3QG1LxVPTMs4GFRF
         PeNzn2LFSB64p4n1EFvxGOb+mn/Wmz7VTnhG+TJzYxYGoXYmFcM2ZvDHiVDKmnQ7+m
         mQwTD0WScuN22fWDtYcXpgGKoLYSwTfbESIrMFZd92xa8FvRIctAMoVz+DVWKHHabp
         suXx+RCNgK1EQ==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45406
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

On 01/18/2015 20:30, Joshua Kinard wrote:
> From: Joshua Kinard <kumba@gentoo.org>
> 
> This allows the kernel to correctly detect an R16000 MIPS CPU on systems that
> have those.  Otherwise, such systems will detect the CPU as an R14000, due to
> similarities in the CPU PRId value.

Sending a v2 of this one, too.  Fixing up the split-r10k bits, I found an
additional spot or two for the R16K.

--J


> Signed-off-by: Joshua Kinard <kumba@gentoo.org>
> ---
>  arch/mips/include/asm/cpu-type.h     |    1 +
>  arch/mips/include/asm/cpu.h          |    6 +++---
>  arch/mips/kernel/cpu-probe.c         |    9 +++++++--
>  arch/mips/kernel/perf_event_mipsxx.c |    1 +
>  arch/mips/mm/c-r4k.c                 |    4 ++++
>  arch/mips/mm/page.c                  |    1 +
>  arch/mips/mm/tlb-r4k.c               |    3 ++-
>  arch/mips/mm/tlbex.c                 |    1 +
>  arch/mips/oprofile/common.c          |    1 +
>  arch/mips/oprofile/op_model_mipsxx.c |    1 +
>  10 files changed, 22 insertions(+), 6 deletions(-)
> 
> linux-mips-add-r16000-detection.patch
> diff --git a/arch/mips/include/asm/cpu-type.h b/arch/mips/include/asm/cpu-type.h
> index b4e2bd8..d85fc26 100644
> --- a/arch/mips/include/asm/cpu-type.h
> +++ b/arch/mips/include/asm/cpu-type.h
> @@ -150,6 +150,7 @@ static inline int __pure __get_cpu_type(const int cpu_type)
>  	case CPU_R10000:
>  	case CPU_R12000:
>  	case CPU_R14000:
> +	case CPU_R16000:
>  #endif
>  #ifdef CONFIG_SYS_HAS_CPU_RM7000
>  	case CPU_RM7000:
> diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
> index 33866fc..53acfce 100644
> --- a/arch/mips/include/asm/cpu.h
> +++ b/arch/mips/include/asm/cpu.h
> @@ -67,7 +67,7 @@
>  #define PRID_IMP_R4300		0x0b00
>  #define PRID_IMP_VR41XX		0x0c00
>  #define PRID_IMP_R12000		0x0e00
> -#define PRID_IMP_R14000		0x0f00
> +#define PRID_IMP_R14000		0x0f00		/* R14K && R16K */
>  #define PRID_IMP_R8000		0x1000
>  #define PRID_IMP_PR4450		0x1200
>  #define PRID_IMP_R4600		0x2000
> @@ -283,8 +283,8 @@ enum cpu_type_enum {
>  	CPU_R4000PC, CPU_R4000SC, CPU_R4000MC, CPU_R4200, CPU_R4300, CPU_R4310,
>  	CPU_R4400PC, CPU_R4400SC, CPU_R4400MC, CPU_R4600, CPU_R4640, CPU_R4650,
>  	CPU_R4700, CPU_R5000, CPU_R5500, CPU_NEVADA, CPU_R5432, CPU_R10000,
> -	CPU_R12000, CPU_R14000, CPU_VR41XX, CPU_VR4111, CPU_VR4121, CPU_VR4122,
> -	CPU_VR4131, CPU_VR4133, CPU_VR4181, CPU_VR4181A, CPU_RM7000,
> +	CPU_R12000, CPU_R14000, CPU_R16000, CPU_VR41XX, CPU_VR4111, CPU_VR4121,
> +	CPU_VR4122, CPU_VR4131, CPU_VR4133, CPU_VR4181, CPU_VR4181A, CPU_RM7000,
>  	CPU_SR71000, CPU_TX49XX,
>  
>  	/*
> diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
> index 5342674..3f334a8 100644
> --- a/arch/mips/kernel/cpu-probe.c
> +++ b/arch/mips/kernel/cpu-probe.c
> @@ -833,8 +833,13 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
>  		c->tlbsize = 64;
>  		break;
>  	case PRID_IMP_R14000:
> -		c->cputype = CPU_R14000;
> -		__cpu_name[cpu] = "R14000";
> +		if (((c->processor_id >> 4) & 0x0f) > 2) {
> +			c->cputype = CPU_R16000;
> +			__cpu_name[cpu] = "R16000";
> +		} else {
> +			c->cputype = CPU_R14000;
> +			__cpu_name[cpu] = "R14000";
> +		}
>  		set_isa(c, MIPS_CPU_ISA_IV);
>  		c->options = MIPS_CPU_TLB | MIPS_CPU_4K_CACHE | MIPS_CPU_4KEX |
>  			     MIPS_CPU_FPU | MIPS_CPU_32FPR |
> diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
> index 9466184..05dac89 100644
> --- a/arch/mips/kernel/perf_event_mipsxx.c
> +++ b/arch/mips/kernel/perf_event_mipsxx.c
> @@ -775,6 +775,7 @@ static int n_counters(void)
>  
>  	case CPU_R12000:
>  	case CPU_R14000:
> +	case CPU_R16000:
>  		counters = 4;
>  		break;
>  
> diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
> index dd261df..76a7eae 100644
> --- a/arch/mips/mm/c-r4k.c
> +++ b/arch/mips/mm/c-r4k.c
> @@ -430,6 +430,7 @@ static inline void local_r4k___flush_cache_all(void * args)
>  	case CPU_R10000:
>  	case CPU_R12000:
>  	case CPU_R14000:
> +	case CPU_R16000:
>  		/*
>  		 * These caches are inclusive caches, that is, if something
>  		 * is not cached in the S-cache, we know it also won't be
> @@ -1012,6 +1013,7 @@ static void probe_pcache(void)
>  	case CPU_R10000:
>  	case CPU_R12000:
>  	case CPU_R14000:
> +	case CPU_R16000:
>  		icache_size = 1 << (12 + ((config & R10K_CONF_IC) >> 29));
>  		c->icache.linesz = 64;
>  		c->icache.ways = 2;
> @@ -1240,6 +1242,7 @@ static void probe_pcache(void)
>  	case CPU_R10000:
>  	case CPU_R12000:
>  	case CPU_R14000:
> +	case CPU_R16000:
>  		break;
>  
>  	case CPU_74K:
> @@ -1437,6 +1440,7 @@ static void setup_scache(void)
>  	case CPU_R10000:
>  	case CPU_R12000:
>  	case CPU_R14000:
> +	case CPU_R16000:
>  		scache_size = 0x80000 << ((config & R10K_CONF_SS) >> 16);
>  		c->scache.linesz = 64 << ((config >> 13) & 1);
>  		c->scache.ways = 2;
> diff --git a/arch/mips/mm/page.c b/arch/mips/mm/page.c
> index b611102..6da7fc3 100644
> --- a/arch/mips/mm/page.c
> +++ b/arch/mips/mm/page.c
> @@ -143,6 +143,7 @@ static void set_prefetch_parameters(void)
>  		case CPU_R10000:
>  		case CPU_R12000:
>  		case CPU_R14000:
> +		case CPU_R16000:
>  			/*
>  			 * Those values have been experimentally tuned for an
>  			 * Origin 200.
> diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
> index e90b2e8..2a78321 100644
> --- a/arch/mips/mm/tlb-r4k.c
> +++ b/arch/mips/mm/tlb-r4k.c
> @@ -477,7 +477,8 @@ static void r4k_tlb_configure(void)
>  	write_c0_wired(0);
>  	if (current_cpu_type() == CPU_R10000 ||
>  	    current_cpu_type() == CPU_R12000 ||
> -	    current_cpu_type() == CPU_R14000)
> +	    current_cpu_type() == CPU_R14000 ||
> +	    current_cpu_type() == CPU_R16000)
>  		write_c0_framemask(0);
>  
>  	if (cpu_has_rixi) {
> diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
> index 3978a3d..3f9ae67 100644
> --- a/arch/mips/mm/tlbex.c
> +++ b/arch/mips/mm/tlbex.c
> @@ -568,6 +568,7 @@ static void build_tlb_write_entry(u32 **p, struct uasm_label **l,
>  	case CPU_R10000:
>  	case CPU_R12000:
>  	case CPU_R14000:
> +	case CPU_R16000:
>  	case CPU_4KC:
>  	case CPU_4KEC:
>  	case CPU_M14KC:
> diff --git a/arch/mips/oprofile/common.c b/arch/mips/oprofile/common.c
> index a26cbe3..81f5895 100644
> --- a/arch/mips/oprofile/common.c
> +++ b/arch/mips/oprofile/common.c
> @@ -98,6 +98,7 @@ int __init oprofile_arch_init(struct oprofile_operations *ops)
>  	case CPU_R10000:
>  	case CPU_R12000:
>  	case CPU_R14000:
> +	case CPU_R16000:
>  	case CPU_XLR:
>  		lmodel = &op_model_mipsxx_ops;
>  		break;
> diff --git a/arch/mips/oprofile/op_model_mipsxx.c b/arch/mips/oprofile/op_model_mipsxx.c
> index 01f721a..c79ebff 100644
> --- a/arch/mips/oprofile/op_model_mipsxx.c
> +++ b/arch/mips/oprofile/op_model_mipsxx.c
> @@ -296,6 +296,7 @@ static inline int n_counters(void)
>  
>  	case CPU_R12000:
>  	case CPU_R14000:
> +	case CPU_R16000:
>  		counters = 4;
>  		break;
>  
