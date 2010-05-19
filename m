Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 May 2010 11:53:45 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:37310 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491794Ab0ESJxk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 May 2010 11:53:40 +0200
Received: by wyf28 with SMTP id 28so2387554wyf.36
        for <multiple recipients>; Wed, 19 May 2010 02:53:33 -0700 (PDT)
Received: by 10.227.151.138 with SMTP id c10mr7498526wbw.219.1274262813604;
        Wed, 19 May 2010 02:53:33 -0700 (PDT)
Received: from [192.168.2.2] (ppp85-140-114-172.pppoe.mtu-net.ru [85.140.114.172])
        by mx.google.com with ESMTPS id h22sm11275957wbh.15.2010.05.19.02.53.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 19 May 2010 02:53:32 -0700 (PDT)
Message-ID: <4BF3B4ED.7000807@mvista.com>
Date:   Wed, 19 May 2010 13:52:45 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
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
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26763
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

David Daney wrote:

> The 'mult' element of struct clock_event_device must never be wider
> than 32-bits.  If it were, it would get truncated when used by
> clockevent_delta2ns() when this calls do_div().

> We meet the requirement by ensuring that the relationship:

>  (mips_hpt_frequency >> (32 - shift)) < NSEC_PER_SEC

> Always holds.

> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> CC: Thomas Gleixner <tglx@linutronix.de>
[...]
> diff --git a/arch/mips/kernel/cevt-r4k.c b/arch/mips/kernel/cevt-r4k.c
> index 0b2450c..4495158 100644
> --- a/arch/mips/kernel/cevt-r4k.c
> +++ b/arch/mips/kernel/cevt-r4k.c
[...]
> @@ -189,8 +190,17 @@ int __cpuinit r4k_clockevent_init(void)
>  	cd->features		= CLOCK_EVT_FEAT_ONESHOT;
>  
>  	/* Calculate the min / max delta */
> -	cd->mult	= div_sc((unsigned long) mips_freq, NSEC_PER_SEC, 32);
> -	cd->shift		= 32;
> +	shift = 32;
> +	while (scaled_freq >= NSEC_PER_SEC && shift) {
> +		scaled_freq = scaled_freq >> 1;

    Why not:

		scaled_freq >>= 1;

    It's C after all. :-)

WBR, Sergei
