Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Apr 2012 03:03:45 +0200 (CEST)
Received: from relmlor2.renesas.com ([210.160.252.172]:39530 "EHLO
        relmlor2.renesas.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903693Ab2DJBDj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 10 Apr 2012 03:03:39 +0200
Received: from relmlir2.idc.renesas.com ([10.200.68.152])
 by relmlor2.idc.renesas.com ( SJSMS)
 with ESMTP id <0M2800JONO94CQ20@relmlor2.idc.renesas.com>; Tue,
 10 Apr 2012 10:03:04 +0900 (JST)
Received: from relmlac1.idc.renesas.com ([10.200.69.21])
 by relmlir2.idc.renesas.com ( SJSMS)
 with ESMTP id <0M28004SVO94SGG0@relmlir2.idc.renesas.com>; Tue,
 10 Apr 2012 10:03:04 +0900 (JST)
Received: by relmlac1.idc.renesas.com (Postfix, from userid 0)
        id 15A7080177; Tue, 10 Apr 2012 10:03:04 +0900 (JST)
Received: from relmlac1.idc.renesas.com (localhost [127.0.0.1])
        by relmlac1.idc.renesas.com (Postfix) with ESMTP id 080BC8015B; Tue,
 10 Apr 2012 10:03:04 +0900 (JST)
Received: from relmlii2.idc.renesas.com [10.200.68.66]  by
 relmlac1.idc.renesas.com with ESMTP id LAA17604; Tue,
 10 Apr 2012 10:03:04 +0900
X-IronPort-AV: E=Sophos;i="4.75,396,1330873200";   d="scan'208";a="76457171"
Received: from unknown (HELO [10.161.69.127]) ([10.161.69.127])
 by relmlii2.idc.renesas.com with ESMTP; Tue, 10 Apr 2012 10:03:03 +0900
Message-id: <4F8386C8.9020401@renesas.com>
Date:   Tue, 10 Apr 2012 10:03:04 +0900
From:   Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120312
 Thunderbird/11.0
MIME-version: 1.0
To:     sjhill@mips.com
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org, douglas@mips.com,
        chris@mips.com
Subject: Re: [PATCH 01/10] MIPS: Add core files for MIPS SEAD-3 development
 platform.
References: <1333817315-30091-1-git-send-email-sjhill@mips.com>
 <1333817315-30091-2-git-send-email-sjhill@mips.com>
In-reply-to: <1333817315-30091-2-git-send-email-sjhill@mips.com>
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-archive-position: 32914
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shinya.kuribayashi.px@renesas.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello,

On 4/8/2012 1:48 AM, Steven J. Hill wrote:
> diff --git a/arch/mips/include/asm/mach-sead3/cpu-feature-overrides.h b/arch/mips/include/asm/mach-sead3/cpu-feature-overrides.h
> new file mode 100644
> index 0000000..7f3e3f9
> --- /dev/null
> +++ b/arch/mips/include/asm/mach-sead3/cpu-feature-overrides.h
> @@ -0,0 +1,72 @@
[...]
> +/*
> + * CPU feature overrides for MIPS boards
> + */
> +#ifdef CONFIG_CPU_MIPS32
> +#define cpu_has_tlb		1
> +#define cpu_has_4kex		1
> +#define cpu_has_4k_cache	1
> +/* #define cpu_has_fpu		? */
> +/* #define cpu_has_32fpr	? */
> +#define cpu_has_counter		1
> +/* #define cpu_has_watch	? */
> +#define cpu_has_divec		1
> +#define cpu_has_vce		0
> +/* #define cpu_has_cache_cdex_p	? */
> +/* #define cpu_has_cache_cdex_s	? */
> +/* #define cpu_has_prefetch	? */
> +#define cpu_has_mcheck		1
> +/* #define cpu_has_ejtag	? */
> +#ifdef CONFIG_CPU_HAS_LLSC
> +#define cpu_has_llsc		1
> +#else
> +#define cpu_has_llsc		0
> +#endif

This Ralf's commit maybe be still valid for sead3 board?

http://git.kernel.org/linus/b8d6f78cd058e34ec706f7cb353fdb2eb743c050
MIPS: Malta: Remove pointless use use of CONFIG_CPU_HAS_LLSC

> +/* #define cpu_has_vtag_icache	? */
> +/* #define cpu_has_dc_aliases	? */
> +/* #define cpu_has_ic_fills_f_dc ? */
> +#define cpu_has_nofpuex		0
> +/* #define cpu_has_64bits	? */
> +/* #define cpu_has_64bit_zero_reg ? */
> +/* #define cpu_has_inclusive_pcaches ? */
> +#define cpu_icache_snoops_remote_store 1
> +#endif

Also you might be interested in fls/ffs optimization using CLO/CLZ
instruction, that will be used in irq_ffs() at plat_irq_dispatch:

https://patchwork.linux-mips.org/patch/1453/
MIPS: Enable cpu_has_clo_clz for MIPS Technologies' platforms

Some discussions on this is found at:
http://www.linux-mips.org/archives/linux-mips/2010-07/msg00000.html

> diff --git a/arch/mips/mti-sead3/sead3-int.c b/arch/mips/mti-sead3/sead3-int.c
> new file mode 100644
> index 0000000..4cd569e
> --- /dev/null
> +++ b/arch/mips/mti-sead3/sead3-int.c
> @@ -0,0 +1,146 @@
[...]
> +/*
> + * Version of ffs that only looks at bits 8..15
> + */
> +static inline unsigned int irq_ffs(unsigned int pending)
> +{
> +#if defined(CONFIG_CPU_MIPS32) || defined(CONFIG_CPU_MIPS64)
> +	return fls(pending) - CAUSEB_IP - 1;
> +#else
> +	unsigned int a0 = 7;
> +	unsigned int t0;
> +
> +	t0 = pending & 0xf000;
> +	t0 = t0 < 1;
> +	t0 = t0 << 2;
> +	a0 = a0 - t0;
> +	pending = pending << t0;
> +
> +	t0 = pending & 0xc000;
> +	t0 = t0 < 1;
> +	t0 = t0 << 1;
> +	a0 = a0 - t0;
> +	pending = pending << t0;
> +
> +	t0 = pending & 0x8000;
> +	t0 = t0 < 1;
> +	/* t0 = t0 << 2; */
> +	a0 = a0 - t0;
> +	/* pending = pending << t0; */
> +
> +	return a0;
> +#endif
> +}
> +
> +asmlinkage void plat_irq_dispatch(void)
> +{
> +	unsigned int pending = read_c0_cause() & read_c0_status() & ST0_IM;
> +	int irq;
> +
> +	irq = irq_ffs(pending);
> +
> +	if (irq >= 0)
> +		do_IRQ(MIPS_CPU_IRQ_BASE + irq);
> +	else
> +		spurious_interrupt();
> +}

-- 
Shinya Kuribayashi
Renesas Electronics
