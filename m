Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Mar 2012 14:25:20 +0200 (CEST)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:39724 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903689Ab2C3MZE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Mar 2012 14:25:04 +0200
Received: by bkcjk13 with SMTP id jk13so580563bkc.36
        for <linux-mips@linux-mips.org>; Fri, 30 Mar 2012 05:24:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-gm-message-state:content-type
         :content-transfer-encoding;
        bh=B+J6QBN2J2twqt5staYQQKbvwMedhpZoSfSdvDeWIfs=;
        b=Ss9Cp/NxGeiZNQJ77SI4gvg2BM16zSfyNu095eP2NEAAlN2TVbXJkdGDUFmpYsFR7D
         W1SMmpn3d1nA+RY4ZZvrenwOBuWoqI6SiVwj/74aVkS90NTMbJbW2tuBSYwxiHUDhnLC
         p6J31gMQqelMhaRkA7rQ0fzSjxlvedVzTchmD/xhmZSQO5QjwMzLre+EZRhDOf9aomaC
         IM2pXcQLFr/4LtqusGR4e2ryF5j/iF6B01k/g6i1OPQ65oi/qvHf1G0C4ok1Lgz1jmcL
         VqxdZk4e0epUeXO1iluViVeRio/lfzddWJySth8PYfKHck2abifLZ7Y80qgDQyqhGq4q
         sIoQ==
Received: by 10.204.152.72 with SMTP id f8mr859779bkw.103.1333110299155;
        Fri, 30 Mar 2012 05:24:59 -0700 (PDT)
Received: from [192.168.2.2] (ppp91-79-89-254.pppoe.mtu-net.ru. [91.79.89.254])
        by mx.google.com with ESMTPS id zx16sm20361254bkb.13.2012.03.30.05.24.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 30 Mar 2012 05:24:58 -0700 (PDT)
Message-ID: <4F75A5C3.9000405@mvista.com>
Date:   Fri, 30 Mar 2012 16:23:31 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
MIME-Version: 1.0
To:     Maarten ter Huurne <maarten@treewalker.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: JZ4740: reset: Initialize hibernate wakeup counters.
References: <1333037998-18762-1-git-send-email-maarten@treewalker.org>
In-Reply-To: <1333037998-18762-1-git-send-email-maarten@treewalker.org>
X-Gm-Message-State: ALoCoQks7ZDDUybbZIO9y691nd7f1aU9Msl0rrbe99TD+JUR9vx/gX9V3c94J0E0fIi7aRBnis3y
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 32826
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 29-03-2012 20:19, Maarten ter Huurne wrote:

> In hibernation mode only the wakeup logic and the RTC are left running,
> so this is what users perceive as power down.

> If the counters are not initialized, the corresponding pin (typically
> connected to the power button) has to be asserted for two seconds
> before the device wakes up. Most users expect a shorter wakeup time.

> I took the timing values of 100 ms and 60 ms from BouKiCHi's patch for
> the Dingoo A320 kernel.

> Signed-off-by: Maarten ter Huurne<maarten@treewalker.org>
> Acked-by: Lars-Peter Clausen<lars@metafoo.de>
> ---
>   arch/mips/jz4740/reset.c |   46 ++++++++++++++++++++++++++++++++++++++++------
>   1 files changed, 40 insertions(+), 6 deletions(-)

> diff --git a/arch/mips/jz4740/reset.c b/arch/mips/jz4740/reset.c
> index 5f1fb95..e6d1d7b 100644
> --- a/arch/mips/jz4740/reset.c
> +++ b/arch/mips/jz4740/reset.c
[...]
> @@ -53,21 +56,52 @@ static void jz4740_restart(char *command)
[...]
> -static void jz4740_power_off(void)
> +static inline void jz4740_rtc_wait_ready(void __iomem *rtc_base)
>   {
> -	void __iomem *rtc_base = ioremap(JZ4740_RTC_BASE_ADDR, 0x24);
>   	uint32_t ctrl;
> -

    Do not remove the empty line here.

>   	do {
>   		ctrl = readl(rtc_base + JZ_REG_RTC_CTRL);
>   	} while (!(ctrl&  JZ_RTC_CTRL_WRDY));
> +}
> +
> +static void jz4740_power_off(void)
> +{
> +	void __iomem *rtc_base = ioremap(JZ4740_RTC_BASE_ADDR, 0x38);
> +	unsigned long long wakeup_filter_ticks;
> +	unsigned long long reset_counter_ticks;
> +
> +	/* Set minimum wakeup pin assertion time: 100 ms.
> +	   Range is 0 to 2 sec if RTC is clocked at 32 kHz. */
> +	wakeup_filter_ticks = (100 * jz4740_clock_bdata.rtc_rate) / 1000;
> +	if (wakeup_filter_ticks<  JZ_RTC_WAKEUP_FILTER_MASK)
> +		wakeup_filter_ticks&= JZ_RTC_WAKEUP_FILTER_MASK;
> +	else
> +		wakeup_filter_ticks = JZ_RTC_WAKEUP_FILTER_MASK;
> +	jz4740_rtc_wait_ready(rtc_base);
> +	writel(wakeup_filter_ticks, rtc_base + JZ_REG_RTC_WAKEUP_FILTER);

    Writing 64-bit variable to a 32-bit register?

> +	/* Set reset pin low-level assertion time after wakeup: 60 ms.
> +	   Range is 0 to 125 ms if RTC is clocked at 32 kHz. */

    The preferred style for multi-line comments is this:

/*
  * bla
  * bla
  */

> +	reset_counter_ticks = (60 * jz4740_clock_bdata.rtc_rate) / 1000;
> +	if (reset_counter_ticks<  JZ_RTC_RESET_COUNTER_MASK)
> +		reset_counter_ticks&= JZ_RTC_RESET_COUNTER_MASK;
> +	else
> +		reset_counter_ticks = JZ_RTC_RESET_COUNTER_MASK;
> +	jz4740_rtc_wait_ready(rtc_base);
> +	writel(reset_counter_ticks, rtc_base + JZ_REG_RTC_RESET_COUNTER);

    Writing 64-bit variable to a 32-bit register?

WBR, Sergei
