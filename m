Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Nov 2014 22:21:57 +0100 (CET)
Received: from mail-wg0-f51.google.com ([74.125.82.51]:40958 "EHLO
        mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013874AbaKQVVyItm5l (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Nov 2014 22:21:54 +0100
Received: by mail-wg0-f51.google.com with SMTP id k14so6702480wgh.38
        for <linux-mips@linux-mips.org>; Mon, 17 Nov 2014 13:21:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=9SCANkBJeRXuRyGAzXNdrP1+mbExT5jxyYLBv1+eFVs=;
        b=gQvbdHsFuQMRasbU2IkrOFECEPoJmSLbyH4HTge3FVypBFf0+LOlp9RG5xKscGZ8ih
         +Ipk/XCIXGS6U5oCpV3g8iZWUwn5vwDs0qZaQl5DYfZ7QlKOJHhiVo0Yay0N1A94YzZf
         x6aHKVfUNP40+ONydvm+1/MLxMYcHaW7VdqD47oCM1IcYIan/CBTH1ISqrkwLo9ppjdf
         IDcxkGkQllec0ZpAfb/4O8E+LSCOX60a+MuCrapm6dtxuhRzkim22LagdOLDOwhTINOD
         xugAZfDk0O8KXnQL1+EZBtCLft4OW+ugAD8PmK5vogQ1BNOOHJKHQn031wS6ZT8UnUv8
         ODfA==
X-Gm-Message-State: ALoCoQniDchK5irZxlfqpen+NUobE0HjxxQ7etU2M18vpiXCcCqGMZUCt2Bjj9jzVCeB8smpOHlY
X-Received: by 10.180.103.33 with SMTP id ft1mr33840580wib.71.1416259308592;
        Mon, 17 Nov 2014 13:21:48 -0800 (PST)
Received: from [192.168.1.15] (AToulouse-656-1-820-36.w109-215.abo.wanadoo.fr. [109.215.21.36])
        by mx.google.com with ESMTPSA id bo1sm20379861wjc.18.2014.11.17.13.21.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Nov 2014 13:21:47 -0800 (PST)
Message-ID: <546A66EA.3090107@linaro.org>
Date:   Mon, 17 Nov 2014 22:21:46 +0100
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Andrew Bresticker <abrestic@chromium.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
CC:     John Crispin <blogic@openwrt.org>,
        David Daney <ddaney.cavm@gmail.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 4/4] clocksource: mips-gic: Add device-tree support
References: <1415821419-26974-1-git-send-email-abrestic@chromium.org> <1415821419-26974-5-git-send-email-abrestic@chromium.org>
In-Reply-To: <1415821419-26974-5-git-send-email-abrestic@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <daniel.lezcano@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44249
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.lezcano@linaro.org
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

On 11/12/2014 08:43 PM, Andrew Bresticker wrote:
> Parse the GIC timer frequency and interrupt from the device-tree.
>
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Hi Andrew,

through which tree is this patch supposed to go ?

Is there any dependency ?

> ---
> Changes from v4:
>   - don't probe from irqchip; just warn if DT is wrong
> Changes from v3:
>   - probe from GIC irqchip
> New for v3.
> ---
>   drivers/clocksource/Kconfig          |  1 +
>   drivers/clocksource/mips-gic-timer.c | 41 ++++++++++++++++++++++++++++++------
>   2 files changed, 35 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index cb7e7f4..89836dc 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -226,5 +226,6 @@ config CLKSRC_VERSATILE
>   config CLKSRC_MIPS_GIC
>   	bool
>   	depends on MIPS_GIC
> +	select CLKSRC_OF
>
>   endmenu
> diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-gic-timer.c
> index a749c81..3bd31b1 100644
> --- a/drivers/clocksource/mips-gic-timer.c
> +++ b/drivers/clocksource/mips-gic-timer.c
> @@ -11,6 +11,7 @@
>   #include <linux/interrupt.h>
>   #include <linux/irqchip/mips-gic.h>
>   #include <linux/notifier.h>
> +#include <linux/of_irq.h>
>   #include <linux/percpu.h>
>   #include <linux/smp.h>
>   #include <linux/time.h>
> @@ -101,8 +102,6 @@ static int gic_clockevent_init(void)
>   	if (!cpu_has_counter || !gic_frequency)
>   		return -ENXIO;
>
> -	gic_timer_irq = MIPS_GIC_IRQ_BASE +
> -		GIC_LOCAL_TO_HWIRQ(GIC_LOCAL_INT_COMPARE);
>   	setup_percpu_irq(gic_timer_irq, &gic_compare_irqaction);
>
>   	register_cpu_notifier(&gic_cpu_nb);
> @@ -123,17 +122,45 @@ static struct clocksource gic_clocksource = {
>   	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
>   };
>
> -void __init gic_clocksource_init(unsigned int frequency)
> +static void __init __gic_clocksource_init(void)
>   {
> -	gic_frequency = frequency;
> -
>   	/* Set clocksource mask. */
>   	gic_clocksource.mask = CLOCKSOURCE_MASK(gic_get_count_width());
>
>   	/* Calculate a somewhat reasonable rating value. */
> -	gic_clocksource.rating = 200 + frequency / 10000000;
> +	gic_clocksource.rating = 200 + gic_frequency / 10000000;
>
> -	clocksource_register_hz(&gic_clocksource, frequency);
> +	clocksource_register_hz(&gic_clocksource, gic_frequency);
>
>   	gic_clockevent_init();
>   }
> +
> +void __init gic_clocksource_init(unsigned int frequency)
> +{
> +	gic_frequency = frequency;
> +	gic_timer_irq = MIPS_GIC_IRQ_BASE +
> +		GIC_LOCAL_TO_HWIRQ(GIC_LOCAL_INT_COMPARE);
> +
> +	__gic_clocksource_init();
> +}
> +
> +static void __init gic_clocksource_of_init(struct device_node *node)
> +{
> +	if (WARN_ON(!gic_present || !node->parent ||
> +		    !of_device_is_compatible(node->parent, "mti,gic")))
> +		return;
> +
> +	if (of_property_read_u32(node, "clock-frequency", &gic_frequency)) {
> +		pr_err("GIC frequency not specified.\n");
> +		return;
> +	}
> +	gic_timer_irq = irq_of_parse_and_map(node, 0);
> +	if (!gic_timer_irq) {
> +		pr_err("GIC timer IRQ not specified.\n");
> +		return;
> +	}
> +
> +	__gic_clocksource_init();
> +}
> +CLOCKSOURCE_OF_DECLARE(mips_gic_timer, "mti,gic-timer",
> +		       gic_clocksource_of_init);
>


-- 
  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
