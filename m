Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jan 2010 08:55:19 +0100 (CET)
Received: from mail-gx0-f227.google.com ([209.85.217.227]:43890 "EHLO
        mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491900Ab0ARHzP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Jan 2010 08:55:15 +0100
Received: by gxk27 with SMTP id 27so2324702gxk.7
        for <multiple recipients>; Sun, 17 Jan 2010 23:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=+RGh275zXWQT/esBsOaDMxfhftGqOP3KboyDLzLbjrA=;
        b=cgG8xV7izVLyxaDqAi4trbu7+a1rdifHJ6zqh4toyYYJ3mPidHssh0YK6N3SgwBEyH
         XpVLUW/hweg6nLCui6yrLWIt5tSTJr3pArYwqM2Gts2/lefZh5Uw8kgKNT5eO2Vglacq
         B8P7NHmo3B822sAXOPqT3zvmdRzhQVGAH4XbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=wTdmj+6mYckSR5kMI7ZeK7DlpQ/ohLLOowPx0PIGnRAzxRPCWT1Al++Gp9zcXHiI+x
         RNbc+o7D48UPiPGbNifOEP6H0ovYRkK1Y78Hwh2RhfuUt8Alj3q98cIHViqhfqXgqSUE
         Ux2uD1TUKsaJ9v6BQvjyLX61sYmZR7C47M+KA=
Received: by 10.101.211.37 with SMTP id n37mr9090935anq.82.1263801309234;
        Sun, 17 Jan 2010 23:55:09 -0800 (PST)
Received: from ?192.168.2.212? ([202.201.14.140])
        by mx.google.com with ESMTPS id 21sm4288127iwn.6.2010.01.17.23.55.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 17 Jan 2010 23:55:07 -0800 (PST)
Subject: Re: [PATCH v6] MIPS: Add a high resolution sched_clock() via
 cnt32_to_63().
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Sergei Shtylyov <sshtylyov@ru.mvista.com>,
        David Daney <david.s.daney@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mips@linux-mips.org
In-Reply-To: <1259319110-16107-1-git-send-email-wuzhangjin@gmail.com>
References: <1259319110-16107-1-git-send-email-wuzhangjin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Mon, 18 Jan 2010 15:54:44 +0800
Message-ID: <1263801284.11671.50.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
X-archive-position: 25602
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 11580

If the processor support dynamic cpu frequency and the support is
enabled in kernel, this sched_clock() implementation will be broken(and
If the frequency of the MIPS CP0 counter is related to the cpu's
frequency).

So, some extra resitrictions should be added to it.

arch/mips/Kconfig

config CPU_HAS_FIXED_CP0_COUNTER
	bool

config SYS_SUPPORTS_HRES_SCHED_CLOCK
	bool
	depends on CPU_HAS_FIXED_CP0_COUNTER || !CPU_FREQ

arch/mips/kernel/csrc-r4k.c

#ifdef SYS_SUPPORTS_HRES_SCHED_CLOCK

/* The high resolution version of sched_clock() */

#endif

And I'm not sure whether the cavium octeon support dynamic cpu
frequency, if yes, it's high resolution version of sched_clock() also
should be wrapped with the above macro to ensure it is not broken:

arch/mips/cavium-octeon/csrc-octeon.c

Regards,
	Wu Zhangjin

On Fri, 2009-11-27 at 18:51 +0800, Wu Zhangjin wrote:
> From: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> (The changes of this v6 revision from v5 revision:
> 
>  o hard-codes the cycle2ns_scale_factor as 8 for 30(cs->shift) is too
>  big. With 30, the return value of sched_clock() will also overflow quickly.
>  o moves the sched_clock() back into csrc-r4k.c as David and Sergei
>  recommended.
>  o inits c0 count as zero for PRINTK_TIME=y.
>  o drops the HR_SCHED_CLCOK option for the current sched_clock() is stable
>  enough to replace the jiffies based one.
> )
> 
> This patch adds a cnt32_to_63() and MIPS c0 count based sched_clock(),
> which provides high resolution.
> 
> Without it, the Ftrace for MIPS will give useless timestamp information.
> 
> Because cnt32_to_63() needs to be called at least once per half period
> to work properly, Differ from the old version, this v2 revision set up a
> kernel timer to ensure the requirement of some MIPSs which have short c0
> count period.
> 
> And also, we init the c0 count as ZERO(just as jiffies does) in
> time_init() before plat_time_init(), without it, PRINTK_TIME=y will get
> wrong timestamp information. (NOTE: some platforms have initiazlied c0
> count as zero, but some not, this may introduce some duplication,
> perhaps a new patch is needed to remove the initialized of c0 count in
> the platforms later?)
> 
> This is originally from arch/arm/plat-orion/time.c
> 
> This revision works well for function graph tracer now, and also,
> PRINTK_TIME=y will get normal timestamp informatin.
> 
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> ---
>  arch/mips/kernel/csrc-r4k.c |   54 +++++++++++++++++++++++++++++++++++++++++++
>  arch/mips/kernel/time.c     |    3 ++
>  2 files changed, 57 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/mips/kernel/csrc-r4k.c b/arch/mips/kernel/csrc-r4k.c
> index e95a3cd..12755f2 100644
> --- a/arch/mips/kernel/csrc-r4k.c
> +++ b/arch/mips/kernel/csrc-r4k.c
> @@ -6,10 +6,62 @@
>   * Copyright (C) 2007 by Ralf Baechle
>   */
>  #include <linux/clocksource.h>
> +#include <linux/cnt32_to_63.h>
>  #include <linux/init.h>
> +#include <linux/timer.h>
>  
>  #include <asm/time.h>
>  
> +/*
> + * MIPS sched_clock implementation.
> + *
> + * Because the hardware timer period is quite short and because cnt32_to_63()
> + * needs to be called at least once per half period to work properly, a kernel
> + * timer is set up to ensure this requirement is always met.
> + *
> + * Please refer to include/linux/cnt32_to_63.h and arch/arm/plat-orion/time.c
> + */
> +#define CLOCK2NS_SCALE_FACTOR 8
> +
> +static unsigned long clock2ns_scale;
> +
> +unsigned long long notrace sched_clock(void)
> +{
> +	unsigned long long v = cnt32_to_63(read_c0_count());
> +	return (v * clock2ns_scale) >> CLOCK2NS_SCALE_FACTOR;
> +}
> +
> +static struct timer_list cnt32_to_63_keepwarm_timer;
> +
> +static void cnt32_to_63_keepwarm(unsigned long data)
> +{
> +	mod_timer(&cnt32_to_63_keepwarm_timer, round_jiffies(jiffies + data));
> +	sched_clock();
> +}
> +
> +static void __init setup_hres_sched_clock(unsigned long clock)
> +{
> +	unsigned long long v;
> +	unsigned long data;
> +
> +	v = NSEC_PER_SEC;
> +	v <<= CLOCK2NS_SCALE_FACTOR;
> +	v += clock/2;
> +	do_div(v, clock);
> +	/*
> +	 * We want an even value to automatically clear the top bit
> +	 * returned by cnt32_to_63() without an additional run time
> +	 * instruction. So if the LSB is 1 then round it up.
> +	 */
> +	if (v & 1)
> +		v++;
> +	clock2ns_scale = v;
> +
> +	data = 0x80000000UL / clock * HZ;
> +	setup_timer(&cnt32_to_63_keepwarm_timer, cnt32_to_63_keepwarm, data);
> +	mod_timer(&cnt32_to_63_keepwarm_timer, round_jiffies(jiffies + data));
> +}
> +
>  static cycle_t c0_hpt_read(struct clocksource *cs)
>  {
>  	return read_c0_count();
> @@ -27,6 +79,8 @@ int __init init_r4k_clocksource(void)
>  	if (!cpu_has_counter || !mips_hpt_frequency)
>  		return -ENXIO;
>  
> +	setup_hres_sched_clock(mips_hpt_frequency);
> +
>  	/* Calculate a somewhat reasonable rating value */
>  	clocksource_mips.rating = 200 + mips_hpt_frequency / 10000000;
>  
> diff --git a/arch/mips/kernel/time.c b/arch/mips/kernel/time.c
> index 1f467d5..4b5e93c 100644
> --- a/arch/mips/kernel/time.c
> +++ b/arch/mips/kernel/time.c
> @@ -152,6 +152,9 @@ static __init int cpu_has_mfc0_count_bug(void)
>  
>  void __init time_init(void)
>  {
> +	if (!mips_clockevent_init() || !cpu_has_mfc0_count_bug())
> +		write_c0_count(0);
> +
>  	plat_time_init();
>  
>  	if (!mips_clockevent_init() || !cpu_has_mfc0_count_bug())
