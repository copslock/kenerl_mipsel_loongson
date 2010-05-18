Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 May 2010 00:48:28 +0200 (CEST)
Received: from gateway09.websitewelcome.com ([69.93.164.9]:56138 "HELO
        gateway09.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1492160Ab0ERWsY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 May 2010 00:48:24 +0200
Received: (qmail 28038 invoked from network); 18 May 2010 22:52:11 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway09.websitewelcome.com with SMTP; 18 May 2010 22:52:11 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=paralogos.com;
        h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=Qx79sRwUT6MF6zqyxvXUEcAfST7GQMAWhQE9yOmYFSuHCh+crAWTqdkiu7eUJPdI5RIFq0ctyEMO/cEKWx3E0+fuaPP2Cm5aQ5i3oZxvDNg9Gh66G4JvzAThGCGJM46m;
Received: from 216-239-45-4.google.com ([216.239.45.4]:6758 helo=epiktistes.mtv.corp.google.com)
        by gator750.hostgator.com with esmtpa (Exim 4.69)
        (envelope-from <kevink@paralogos.com>)
        id 1OEVa2-0005jd-NN; Tue, 18 May 2010 17:48:06 -0500
Message-ID: <4BF31931.5040704@paralogos.com>
Date:   Tue, 18 May 2010 15:48:17 -0700
From:   "Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Thunderbird 2.0.0.24 (X11/20100317)
MIME-Version: 1.0
To:     David Daney <ddaney@caviumnetworks.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] MIPS: Don't overflow cevt-r4k.c calculations at high
 clock rates.
References: <1274220676-4562-1-git-send-email-ddaney@caviumnetworks.com>
In-Reply-To: <1274220676-4562-1-git-send-email-ddaney@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator750.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - paralogos.com
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26757
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

Easy for me to say, of course, but once this patch is accepted, the same 
thing needs to be done to smtc_clockevent_init() in cevt-smtc.c.

          Regards,

          Kevin K.


David Daney wrote:
> The 'mult' element of struct clock_event_device must never be wider
> than 32-bits.  If it were, it would get truncated when used by
> clockevent_delta2ns() when this calls do_div().
>
> We meet the requirement by ensuring that the relationship:
>
>  (mips_hpt_frequency >> (32 - shift)) < NSEC_PER_SEC
>
> Always holds.
>
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> CC: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/mips/kernel/cevt-r4k.c |   16 +++++++++++++---
>  1 files changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/arch/mips/kernel/cevt-r4k.c b/arch/mips/kernel/cevt-r4k.c
> index 0b2450c..4495158 100644
> --- a/arch/mips/kernel/cevt-r4k.c
> +++ b/arch/mips/kernel/cevt-r4k.c
> @@ -163,10 +163,11 @@ int c0_compare_int_usable(void)
>  
>  int __cpuinit r4k_clockevent_init(void)
>  {
> -	uint64_t mips_freq = mips_hpt_frequency;
> +	uint64_t scaled_freq = mips_hpt_frequency;
>  	unsigned int cpu = smp_processor_id();
>  	struct clock_event_device *cd;
>  	unsigned int irq;
> +	int shift;
>  
>  	if (!cpu_has_counter || !mips_hpt_frequency)
>  		return -ENXIO;
> @@ -189,8 +190,17 @@ int __cpuinit r4k_clockevent_init(void)
>  	cd->features		= CLOCK_EVT_FEAT_ONESHOT;
>  
>  	/* Calculate the min / max delta */
> -	cd->mult	= div_sc((unsigned long) mips_freq, NSEC_PER_SEC, 32);
> -	cd->shift		= 32;
> +	shift = 32;
> +	while (scaled_freq >= NSEC_PER_SEC && shift) {
> +		scaled_freq = scaled_freq >> 1;
> +		shift--;
> +	}
> +	BUG_ON(shift == 0);
> +
> +	cd->mult		= div_sc((unsigned long) mips_hpt_frequency,
> +					 NSEC_PER_SEC, shift);
> +	cd->shift		= shift;
> +
>  	cd->max_delta_ns	= clockevent_delta2ns(0x7fffffff, cd);
>  	cd->min_delta_ns	= clockevent_delta2ns(0x300, cd);
>  
>   
