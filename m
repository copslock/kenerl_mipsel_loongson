Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Aug 2011 14:46:12 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:53801 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1493552Ab1HWMqH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 23 Aug 2011 14:46:07 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p7NCk61M022440;
        Tue, 23 Aug 2011 14:46:06 +0200
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p7NCk6iJ022439;
        Tue, 23 Aug 2011 14:46:06 +0200
Date:   Tue, 23 Aug 2011 14:46:06 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Jayachandran C <jayachandranc@netlogicmicro.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 1/4] MIPS: Netlogic: XLP CPU support.
Message-ID: <20110823124606.GA20817@linux-mips.org>
References: <cover.1312024106.git.jayachandranc@netlogicmicro.com>
 <22a3c5f618c9213bbf24c9564a82d94c831def4e.1312024108.git.jayachandranc@netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22a3c5f618c9213bbf24c9564a82d94c831def4e.1312024108.git.jayachandranc@netlogicmicro.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30958
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 16826

On Sat, Jul 30, 2011 at 06:58:08PM +0530, Jayachandran C wrote:

> +#if defined(CONFIG_CPU_XLR)
> +#define cpu_has_userlocal	0
> +#define cpu_has_dc_aliases	0
> +#define cpu_has_mips32r2	0
> +#define cpu_has_mips64r2	0
> +#elif defined(CONFIG_CPU_XLP)
> +#define cpu_has_userlocal	1
> +#define cpu_has_mips32r2	1
> +#define cpu_has_mips64r2	1
> +#define cpu_has_dc_aliases	1
> +#else
> +#error "Unknown Netlogic CPU"
> +#endif

If you remove this block altogether the kernel would do runtime probing.
One step closer towards a generic kernel for XLP and XLR.  Is that of
interest?

> --- a/arch/mips/mm/c-r4k.c
> +++ b/arch/mips/mm/c-r4k.c
> @@ -1235,6 +1235,10 @@ static void __cpuinit setup_scache(void)
>  		loongson2_sc_init();
>  		return;
>  #endif
> +	case CPU_XLP:
> +		/* don't need to worry about L2 fully coherent */
> +		sc_present = 0;
> +		break;

No need to add this because sc_present defaults to zero.

Or even better, just fill all the variables like the R10000 (which also
has a full coherent S-cache).  Due to the other cpu feature flags the
code will know that it doesn't have to do any cache maintenance.

That way diagnostic code and possibly some performance optimizations
can still use the cache data.

> diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
> index b6e1cff..0833a63 100644
> --- a/arch/mips/mm/tlbex.c
> +++ b/arch/mips/mm/tlbex.c
> @@ -484,6 +484,7 @@ static void __cpuinit build_tlb_write_entry(u32 **p, struct uasm_label **l,
>  	case CPU_TX49XX:
>  	case CPU_PR4450:
>  	case CPU_XLR:
> +	case CPU_XLP:
>  		uasm_i_nop(p);

If the XLP is a MIPS64 R2 processor adding this code is unnecessary because
the cpu_has_mips_r2 if near the top of this function will handle the CPU.

  Ralf
