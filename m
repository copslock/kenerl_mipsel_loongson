Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Nov 2009 14:21:12 +0100 (CET)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:36173 "EHLO
	mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1494116AbZKTNVF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 20 Nov 2009 14:21:05 +0100
Received: by pzk35 with SMTP id 35so2401755pzk.22
        for <multiple recipients>; Fri, 20 Nov 2009 05:20:57 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=4acnx5EOnmHgnKykGyKuP7cJsJTPTO9rCm13SYoWs4U=;
        b=Gsrl7ArIthpbWMWrrrAUMdDEbZ5LE5PhkHya+yHAcUc60U2Q+fyMql49h+S+PztxNJ
         IjoLpmG8B35xLNR8u+eTrrA3SfKH5l9NEIfPKroicX9Xm3TEdW6+hQiAJVqKxLWtmFd5
         xtoLvaoQNiP8dlq56ykgtg2ZdtcVHJ4Yri40I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=FEXt1WCeQJvUQi7J2sA4uEyzOHvxtexeFvqvi+DgHdA+d30hB2kH3CVF654wuR0qqW
         fHCwQ8gx68yUVe+mVUi1Vrqzn57IzQ2Hom0yLr1XU78luim/u2v0cAzzoyPfME3kabKG
         vu8QgfuHl5vBGbCMtPhq5sXdnoUgl/Ui7fuLE=
Received: by 10.115.101.10 with SMTP id d10mr1994765wam.61.1258723257143;
        Fri, 20 Nov 2009 05:20:57 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 20sm954232pzk.13.2009.11.20.05.20.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Nov 2009 05:20:54 -0800 (PST)
Subject: Re: [PATCH] MIPS: Add a high precision sched_clock() via
 cnt32_to_63().
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	David Daney <ddaney@caviumnetworks.com>,
	linux-mips@linux-mips.org, Michal Simek <monstr@monstr.eu>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <1258703602-29065-1-git-send-email-wuzhangjin@gmail.com>
References: <1258703602-29065-1-git-send-email-wuzhangjin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:	Fri, 20 Nov 2009 21:20:37 +0800
Message-ID: <1258723237.5791.18.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25002
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

[...]
> ---
>  arch/mips/kernel/csrc-r4k.c |   37 +++++++++++++++++++++++++++++++++++++
>  1 files changed, 37 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/mips/kernel/csrc-r4k.c b/arch/mips/kernel/csrc-r4k.c
> index e95a3cd..865035d 100644
> --- a/arch/mips/kernel/csrc-r4k.c
> +++ b/arch/mips/kernel/csrc-r4k.c
> @@ -6,10 +6,45 @@
>   * Copyright (C) 2007 by Ralf Baechle
>   */
>  #include <linux/clocksource.h>
> +#include <linux/cnt32_to_63.h>
> +#include <linux/timer.h>

Sorry, <linux/timer.h> is not needed here, I have used it in the old
version with setup_timer()/mod_timer().

>  #include <linux/init.h>
>  
>  #include <asm/time.h>
>  
> +/*
> + * MIPS' sched_clock implementation.
> + *
> + * NOTE: because cnt32_to_63() needs to be called at least once per half period
> + * to work properly, and some of the MIPS' frequency is very low, perhaps a
> + * kernel timer is needed to be set up to ensure this requirement is always
> + * met. please refer to  arch/arm/plat-orion/time.c and
> + * include/linux/cnt32_to_63.h
> + */
> +static unsigned long tclk2ns_scale, tclk2ns_scale_factor;
> +
> +unsigned long long notrace sched_clock(void)
> +{
> +	unsigned long long v = cnt32_to_63(read_c0_count());
> +	return (v * tclk2ns_scale) >> tclk2ns_scale_factor;
> +}
> +
> +static void __init setup_sched_clock(struct clocksource *cs, unsigned long tclk)

the tclk is not used, I have also used it in the old version with
setup_timer()/mod_timer(). so, we can remove it for this version.

> +{
> +	unsigned long long v;
> +
> +	v = cs->mult;
> +	/*
> +	 * We want an even value to automatically clear the top bit
> +	 * returned by cnt32_to_63() without an additional run time
> +	 * instruction. So if the LSB is 1 then round it up.
> +	 */
> +	if (v & 1)
> +		v++;
> +	tclk2ns_scale = v;
> +	tclk2ns_scale_factor = cs->shift;
> +}
> +
>  static cycle_t c0_hpt_read(struct clocksource *cs)
>  {
>  	return read_c0_count();
> @@ -32,6 +67,8 @@ int __init init_r4k_clocksource(void)
>  
>  	clocksource_set_clock(&clocksource_mips, mips_hpt_frequency);
>  
> +	setup_sched_clock(&clocksource_mips, mips_hpt_frequency);
> +

And here should be setup_sched_clock(&clocksource_mips);

Regards,
	Wu Zhangjin
