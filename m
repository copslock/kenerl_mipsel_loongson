Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Nov 2009 06:30:54 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:57804 "EHLO
	mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1491888AbZKVFar (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 22 Nov 2009 06:30:47 +0100
Received: by pwi15 with SMTP id 15so2940256pwi.24
        for <multiple recipients>; Sat, 21 Nov 2009 21:30:40 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=E2TQxFjJm/tHBQyd1BeY5P7FTo5S1Z2JMuxYpcY4KEA=;
        b=uGoruA+HyGlNM4zZ604ZkgkvJ+iX8e2Sj0tDwULbj1rGAgS/+oc46GZUBHyVo2dazU
         vPHmVScBoH850vxKUrZDfF7FRfotYARK/yO9OrkLB5KHQeu6sSRh7cTYiQyECEhj+e2t
         xSW/KongOAUwliHk24kupj+pgk/tfB8o8neQ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=R/VgGHTCJiua7/HzItLmJtWV9tlgDHzBefeAkjp14jkkkZrvrEaz2ZEa6+G07PpwrM
         mAUMiotBBKgGdtpuPIyznqsP6Fgyt2Kab3P7g3eIMJdM2+HijOVBaZXPJfrtzZJ65hp/
         824L87BIcUQhrAOCbH+QR3ToYaQo5Or4BDMl4=
Received: by 10.115.100.30 with SMTP id c30mr5306589wam.211.1258867840714;
        Sat, 21 Nov 2009 21:30:40 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 21sm2023057pxi.8.2009.11.21.21.30.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 21 Nov 2009 21:30:39 -0800 (PST)
Subject: Re: [PATCH v1] MIPS: Add a high precision sched_clock() via
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
In-Reply-To: <0d92a3c45f7ffff2b0df815c4345d6e9a01cb00c.1258814214.git.wuzhangjin@gmail.com>
References: <0d92a3c45f7ffff2b0df815c4345d6e9a01cb00c.1258814214.git.wuzhangjin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:	Sun, 22 Nov 2009 13:30:26 +0800
Message-ID: <1258867826.1864.2.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25026
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Sat, 2009-11-21 at 22:49 +0800, Wu Zhangjin wrote:
> From: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> This patch adds a cnt32_to_63() and MIPS c0 count based sched_clock(),
> which can provide high resolution. and also, two new kernel options are
> added. the HR_SCHED_CLOCK is used to enable/disable this sched_clock(),
> and the HT_SCHED_CLOCK_UPDATE is used to allow whether update the
> sched_clock() automatically or not.
> 
> Without it, the Ftrace for MIPS will give useless timestamp information.
> 
> (Because cnt32_to_63() needs to be called at least once per half period
> to work properly, Differ from the old version, this v1 revision set up a
> kernel timer to ensure the requirement of some MIPSs which have short c0
> count period.)
[...]
>  
> diff --git a/arch/mips/kernel/csrc-r4k.c b/arch/mips/kernel/csrc-r4k.c
> index e95a3cd..5048989 100644
> --- a/arch/mips/kernel/csrc-r4k.c
> +++ b/arch/mips/kernel/csrc-r4k.c
> @@ -6,10 +6,62 @@
>   * Copyright (C) 2007 by Ralf Baechle
>   */
>  #include <linux/clocksource.h>
> +#include <linux/cnt32_to_63.h>
> +#include <linux/timer.h>
>  #include <linux/init.h>
>  
>  #include <asm/time.h>
>  
> +/*
> + * MIPS' sched_clock implementation.
> + *
> + * because cnt32_to_63() needs to be called at least once per half period to
> + * work properly, and some of the MIPS' frequency is very low, perhaps a kernel
> + * timer is needed to be set up to ensure this requirement is always met.
> + * please refer to  arch/arm/plat-orion/time.c and include/linux/cnt32_to_63.h
> + */
> +static unsigned long __maybe_unused tclk2ns_scale;
> +static unsigned long __maybe_unused tclk2ns_scale_factor;
> +

need to be:

#ifdef CONFIG_HR_SCHED_CLOCK
> +unsigned long long notrace sched_clock(void)
> +{
> +	unsigned long long v = cnt32_to_63(read_c0_count());
> +	return (v * tclk2ns_scale) >> tclk2ns_scale_factor;
> +}
> +
#endif

Regards,
	Wu Zhangjin
