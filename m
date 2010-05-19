Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 May 2010 03:28:13 +0200 (CEST)
Received: from mail-gw0-f49.google.com ([74.125.83.49]:59296 "EHLO
        mail-gw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492248Ab0ESB2J (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 May 2010 03:28:09 +0200
Received: by gwaa12 with SMTP id a12so2845395gwa.36
        for <multiple recipients>; Tue, 18 May 2010 18:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=YEmDByfwsQSVZOBcys7357Ni1Nvm9DHQrHbxxTdZDyU=;
        b=hb6/dvdTv1beuGo2BxCkpFQsQHfjNLtMX/4AILZ340L1u+XeITTIdnPQYdMtWpB5vw
         ZovpsFAmoId18Nj4GxtT/ogxOtosg668L98cxs4NOywXYr77eNwFjJsU1FEQCvQas2fI
         8LzwczwgwBPUDa9QmMOw18w8kfjka1nd2Ac04=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=pP1b1wULSMh/6KYam6Ayiy3JAREhWhOJORqrP5abguS9ZUSWi7HZpVQbucQ5c/YkRN
         jI/pTAcIWY+U3PGX9YAGWVxwDyzRO5xbIoaNCVvdZBgBfItiLDPQnrcxOlXTSWyCR5OT
         thUo8AyuAg9d+o8plhNWx6rBPzKO+uiNF8ePQ=
Received: by 10.101.135.20 with SMTP id m20mr9202755ann.135.1274232482607;
        Tue, 18 May 2010 18:28:02 -0700 (PDT)
Received: from [192.168.2.218] ([202.201.14.140])
        by mx.google.com with ESMTPS id 13sm3863272gxk.8.2010.05.18.18.27.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 18 May 2010 18:28:00 -0700 (PDT)
Subject: Re: [PATCH] MIPS: Don't overflow cevt-r4k.c calculations at high
 clock rates.
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <1274220676-4562-1-git-send-email-ddaney@caviumnetworks.com>
References: <1274220676-4562-1-git-send-email-ddaney@caviumnetworks.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Wed, 19 May 2010 09:27:51 +0800
Message-ID: <1274232471.4170.8.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26762
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

Seems this is similar to the overflow problem in the high resolution
sched_clock(), If not ensure the 'mult' is in 32bit, we must use the
128bit calculation in the common function clocksource_cyc2ns() defined
in include/linux/clocksource.h.

Regards,
	Wu Zhangjin

On Tue, 2010-05-18 at 15:11 -0700, David Daney wrote:
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
