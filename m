Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 May 2010 19:42:56 +0200 (CEST)
Received: from www.tglx.de ([62.245.132.106]:56429 "EHLO www.tglx.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491881Ab0ESRmw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 19 May 2010 19:42:52 +0200
Received: from localhost (www.tglx.de [127.0.0.1])
        by www.tglx.de (8.13.8/8.13.8/TGLX-2007100201) with ESMTP id o4JHgiBq012288
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 19 May 2010 19:42:45 +0200
Date:   Wed, 19 May 2010 19:42:44 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     David Daney <ddaney@caviumnetworks.com>
cc:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH v2] MIPS: Don't overflow cevt-r4k.c calculations at high
 clock rates.
In-Reply-To: <1274290853-16947-1-git-send-email-ddaney@caviumnetworks.com>
Message-ID: <alpine.LFD.2.00.1005191942130.3368@localhost.localdomain>
References: <1274290853-16947-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: clamav-milter 0.95.3 at www.tglx.de
X-Virus-Status: Clean
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26769
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

On Wed, 19 May 2010, David Daney wrote:

> The 'mult' element of struct clock_event_device must never be wider
> than 32-bits.  If it were, it would get truncated when used by
> clockevent_delta2ns() when this calls do_div().
> 
> We can meet this requirement by using clockevent_set_clock() to set
> the MULT and SHIFT values.
> 
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> CC: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Thomas Gleixner <tglx@linutronix.de>

> ---
>  arch/mips/kernel/cevt-r4k.c |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/mips/kernel/cevt-r4k.c b/arch/mips/kernel/cevt-r4k.c
> index 0b2450c..2a4d50f 100644
> --- a/arch/mips/kernel/cevt-r4k.c
> +++ b/arch/mips/kernel/cevt-r4k.c
> @@ -163,7 +163,6 @@ int c0_compare_int_usable(void)
>  
>  int __cpuinit r4k_clockevent_init(void)
>  {
> -	uint64_t mips_freq = mips_hpt_frequency;
>  	unsigned int cpu = smp_processor_id();
>  	struct clock_event_device *cd;
>  	unsigned int irq;
> @@ -188,9 +187,9 @@ int __cpuinit r4k_clockevent_init(void)
>  	cd->name		= "MIPS";
>  	cd->features		= CLOCK_EVT_FEAT_ONESHOT;
>  
> +	clockevent_set_clock(cd, mips_hpt_frequency);
> +
>  	/* Calculate the min / max delta */
> -	cd->mult	= div_sc((unsigned long) mips_freq, NSEC_PER_SEC, 32);
> -	cd->shift		= 32;
>  	cd->max_delta_ns	= clockevent_delta2ns(0x7fffffff, cd);
>  	cd->min_delta_ns	= clockevent_delta2ns(0x300, cd);
>  
> -- 
> 1.6.6.1
> 
