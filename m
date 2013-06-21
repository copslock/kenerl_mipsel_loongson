Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Jun 2013 21:12:59 +0200 (CEST)
Received: from mail-pb0-f50.google.com ([209.85.160.50]:35405 "EHLO
        mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6819546Ab3FUTMrfOz-W (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Jun 2013 21:12:47 +0200
Received: by mail-pb0-f50.google.com with SMTP id wz7so8245747pbc.37
        for <multiple recipients>; Fri, 21 Jun 2013 12:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=unmzr1PYATC32WeIZAaebTGmIx+ds22t5LpBRlP1jBI=;
        b=pRg9X7qs9ulH3cXvBOC4D/Kr3RFqYM3GbNo5IBRD8yPp6a4SbnQiPi8PGSLr/ST3uu
         Pp/uVes7ZPu636lKs9FmPdCaftjSZtD7/XZ9z3NCt+ScPE0kRyrtVkZAgPno22Iypuqr
         C7ifXjKItfdA9aMdx22VJMqt7px1RFmH+yNyxy0BtXKNvw/1PUSSKe1kS/EFxpxGj0p8
         d3/sULv4/WL5uUTK1G3SVM5fbIWEe6HP2U1i34YOYPF6tJ1DX5IMW1jlvf8BJUhLmRRL
         ivCT1VxzftVIO/ZxNFtUzWOy+VRV1xw6TS7450CkrGpFWgH1203TYVIMHq8unohCS6Os
         2p6Q==
X-Received: by 10.66.164.232 with SMTP id yt8mr17589782pab.21.1371841960518;
        Fri, 21 Jun 2013 12:12:40 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id ty8sm6850914pac.8.2013.06.21.12.12.38
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 21 Jun 2013 12:12:39 -0700 (PDT)
Message-ID: <51C4A5A5.9050201@gmail.com>
Date:   Fri, 21 Jun 2013 12:12:37 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130514 Thunderbird/17.0.6
MIME-Version: 1.0
To:     Jonas Gorski <jogo@openwrt.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Jayachandran C <jchandra@broadcom.com>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH V3] MIPS: flush TLB handlers directly after writing them
References: <1371840528-5207-1-git-send-email-jogo@openwrt.org>
In-Reply-To: <1371840528-5207-1-git-send-email-jogo@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37093
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

A couple of thoughts about this...

On 06/21/2013 11:48 AM, Jonas Gorski wrote:
> When having enabled MIPS_PGD_C0_CONTEXT, trap_init() might call the
> generated tlbmiss_handler_setup_pgd before it was committed to memory,
> causing boot failures:
>
>    trap_init()
>     |- per_cpu_trap_init()
>     |   |- TLBMISS_HANDLER_SETUP()
>     |       |- tlbmiss_handler_setup_pgd()
>     |- flush_tlb_handlers()
>
> To avoid this, move flush_tlb_handlers() into build_tlb_refill_handler()
> right after they were generated. We can do this as the cache handling is
> initialized just before creating the tlb handlers.
>
> This issue was introduced in 3d8bfdd0307223de678962f1c1907a7cec549136
> ("MIPS: Use C0_KScratch (if present) to hold PGD pointer.").
>
> Signed-off-by: Jonas Gorski <jogo@openwrt.org>
> ---
> @Ralf, this is a direct replacement for V2.
>
> V2 -> V3:
>   * Move flush_tlb_handlers() call into build_tlb_refill_handler() as
>     suggested by Jayachandran C.
>   * Make it static as now doesn't need to be called from external anymore.
>   * Move it on top of build_tlb_refill_handler() to avoid having to add a
>     prototype for it.
>
> V1 -> V2:
>   * Move flush_tlb_handlers into per_cpu_trap_init() to also fix it for
>     !boot_cpu.
>
>   arch/mips/kernel/traps.c |    2 --
>   arch/mips/mm/tlbex.c     |   30 ++++++++++++++++--------------
>   2 files changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
> index 142d2be..f44366d 100644
> --- a/arch/mips/kernel/traps.c
> +++ b/arch/mips/kernel/traps.c
> @@ -1668,7 +1668,6 @@ void *set_vi_handler(int n, vi_handler_t addr)
>   }
>
>   extern void tlb_init(void);
> -extern void flush_tlb_handlers(void);
>
>   /*
>    * Timer interrupt
> @@ -1997,7 +1996,6 @@ void __init trap_init(void)
>   		set_handler(0x080, &except_vec3_generic, 0x80);
>
>   	local_flush_icache_range(ebase, ebase + 0x400);
> -	flush_tlb_handlers();
>
>   	sort_extable(__start___dbe_table, __stop___dbe_table);
>
> diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
> index f1eabe7..02b1b22 100644
> --- a/arch/mips/mm/tlbex.c
> +++ b/arch/mips/mm/tlbex.c
> @@ -2192,6 +2192,20 @@ static void __cpuinit build_r4000_tlb_modify_handler(void)
>   	dump_handler("r4000_tlb_modify", handle_tlbm, ARRAY_SIZE(handle_tlbm));
>   }
>
> +static void __cpuinit flush_tlb_handlers(void)
> +{
> +	local_flush_icache_range((unsigned long)handle_tlbl,
> +			   (unsigned long)handle_tlbl + sizeof(handle_tlbl));
> +	local_flush_icache_range((unsigned long)handle_tlbs,
> +			   (unsigned long)handle_tlbs + sizeof(handle_tlbs));
> +	local_flush_icache_range((unsigned long)handle_tlbm,
> +			   (unsigned long)handle_tlbm + sizeof(handle_tlbm));
> +#ifdef CONFIG_MIPS_PGD_C0_CONTEXT
> +	local_flush_icache_range((unsigned long)tlbmiss_handler_setup_pgd_array,
> +			   (unsigned long)tlbmiss_handler_setup_pgd_array + sizeof(handle_tlbm));
> +#endif
> +}
> +

1) Why not move the local_flush_icache_range() into the build_*
    function right after the point where the instructions are written
    to their final location?

    Having this out-of-line flusher seems like it is patching up
    something we forgot to do when we generated the code.

2) Also what happens on the other CPUs?  Don't they need their icache
    invalidated as well?  How is that handled?

3) Why is is called local_flush_icache_range?  It seems like
    local_invalidate... would be better

>   void __cpuinit build_tlb_refill_handler(void)
>   {
>   	/*
> @@ -2224,6 +2238,7 @@ void __cpuinit build_tlb_refill_handler(void)
>   			build_r3000_tlb_load_handler();
>   			build_r3000_tlb_store_handler();
>   			build_r3000_tlb_modify_handler();
> +			flush_tlb_handlers();
>   			run_once++;
>   		}
>   #else
> @@ -2251,23 +2266,10 @@ void __cpuinit build_tlb_refill_handler(void)
>   			build_r4000_tlb_modify_handler();
>   			if (!cpu_has_local_ebase)
>   				build_r4000_tlb_refill_handler();
> +			flush_tlb_handlers();
>   			run_once++;
>   		}
>   		if (cpu_has_local_ebase)
>   			build_r4000_tlb_refill_handler();
>   	}
>   }
> -
> -void __cpuinit flush_tlb_handlers(void)
> -{
> -	local_flush_icache_range((unsigned long)handle_tlbl,
> -			   (unsigned long)handle_tlbl + sizeof(handle_tlbl));
> -	local_flush_icache_range((unsigned long)handle_tlbs,
> -			   (unsigned long)handle_tlbs + sizeof(handle_tlbs));
> -	local_flush_icache_range((unsigned long)handle_tlbm,
> -			   (unsigned long)handle_tlbm + sizeof(handle_tlbm));
> -#ifdef CONFIG_MIPS_PGD_C0_CONTEXT
> -	local_flush_icache_range((unsigned long)tlbmiss_handler_setup_pgd_array,
> -			   (unsigned long)tlbmiss_handler_setup_pgd_array + sizeof(handle_tlbm));
> -#endif
> -}
>
