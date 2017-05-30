Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 May 2017 18:36:35 +0200 (CEST)
Received: from smtprelay.synopsys.com ([198.182.47.9]:48516 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993996AbdE3QgXz6pN3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 May 2017 18:36:23 +0200
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 71CB224E0331;
        Tue, 30 May 2017 09:36:14 -0700 (PDT)
Received: from mailhost.synopsys.com (localhost [127.0.0.1])
        by mailhost.synopsys.com (Postfix) with ESMTP id 3C36E5E6;
        Tue, 30 May 2017 09:36:14 -0700 (PDT)
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id 6DA425C2;
        Tue, 30 May 2017 09:36:12 -0700 (PDT)
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.106) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.266.1; Tue, 30 May 2017 09:36:12 -0700
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.104) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.105) with Microsoft SMTP Server
 (TLS) id 14.3.266.1; Tue, 30 May 2017 22:06:09 +0530
Received: from [10.10.161.108] (10.10.161.108) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.266.1; Tue, 30 May 2017 22:06:09 +0530
Subject: Re: [PATCH 2/7] clocksource: Rename CLOCKSOURCE_OF_DECLARE
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC:     Mark Rutland <mark.rutland@arm.com>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Baruch Siach <baruch@tkos.co.il>,
        Heiko Stuebner <heiko@sntech.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        "Liviu Dudau" <liviu.dudau@arm.com>,
        "moderated list:ARM/OXNAS platform support" 
        <linux-oxnas@lists.tuxfamily.org>,
        Patrice Chotard <patrice.chotard@st.com>,
        Eric Anholt <eric@anholt.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        "open list:ARM/STI ARCHITECTURE" <kernel@stlinux.com>,
        Alexandre Courbot <gnurou@gmail.com>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>
Newsgroups: gmane.linux.kernel.arc,gmane.linux.ports.mips.general,gmane.linux.kernel.samsung-soc,gmane.linux.ports.arm.rockchip,gmane.linux.ports.arm.mediatek,gmane.linux.ports.arm.kernel,gmane.linux.ports.tegra,gmane.linux.kernel.rpi,gmane.linux.kernel
References: <1495879129-28109-1-git-send-email-daniel.lezcano@linaro.org>
 <1495879129-28109-2-git-send-email-daniel.lezcano@linaro.org>
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
Message-ID: <1cc18f5a-2181-7be9-183d-270ae093b844@synopsys.com>
Date:   Tue, 30 May 2017 09:36:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <1495879129-28109-2-git-send-email-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.10.161.108]
Return-Path: <Vineet.Gupta1@synopsys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58075
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Vineet.Gupta1@synopsys.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On 05/27/2017 02:58 AM, Daniel Lezcano wrote:

...

> So instead of dealing with a named clocksource macro, let's use a more generic
> one: TIMER_OF_DECLARE.
> 
> The patch has not functional changes.
> 
...

>   drivers/clocksource/arc_timer.c           |  6 +++---

...

> diff --git a/drivers/clocksource/arc_timer.c b/drivers/clocksource/arc_timer.c
> index 2164973..4927355 100644
> --- a/drivers/clocksource/arc_timer.c
> +++ b/drivers/clocksource/arc_timer.c
> @@ -99,7 +99,7 @@ static int __init arc_cs_setup_gfrc(struct device_node *node)
>   
>   	return clocksource_register_hz(&arc_counter_gfrc, arc_timer_freq);
>   }
> -CLOCKSOURCE_OF_DECLARE(arc_gfrc, "snps,archs-timer-gfrc", arc_cs_setup_gfrc);
> +TIMER_OF_DECLARE(arc_gfrc, "snps,archs-timer-gfrc", arc_cs_setup_gfrc);
>   
>   #define AUX_RTC_CTRL	0x103
>   #define AUX_RTC_LOW	0x104
> @@ -158,7 +158,7 @@ static int __init arc_cs_setup_rtc(struct device_node *node)
>   
>   	return clocksource_register_hz(&arc_counter_rtc, arc_timer_freq);
>   }
> -CLOCKSOURCE_OF_DECLARE(arc_rtc, "snps,archs-timer-rtc", arc_cs_setup_rtc);
> +TIMER_OF_DECLARE(arc_rtc, "snps,archs-timer-rtc", arc_cs_setup_rtc);
>   
>   #endif
>   
> @@ -333,4 +333,4 @@ static int __init arc_of_timer_init(struct device_node *np)
>   
>   	return ret;
>   }
> -CLOCKSOURCE_OF_DECLARE(arc_clkevt, "snps,arc-timer", arc_of_timer_init);
> +TIMER_OF_DECLARE(arc_clkevt, "snps,arc-timer", arc_of_timer_init);

Acked-by: Vineet Gupta vgupta@snyopsys.com

Thx,
-Vineet
