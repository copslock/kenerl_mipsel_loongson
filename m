Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Nov 2014 22:28:44 +0100 (CET)
Received: from mail-wg0-f47.google.com ([74.125.82.47]:34600 "EHLO
        mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013876AbaKQV2jpbPXk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Nov 2014 22:28:39 +0100
Received: by mail-wg0-f47.google.com with SMTP id n12so3770862wgh.6
        for <linux-mips@linux-mips.org>; Mon, 17 Nov 2014 13:28:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=Xi4/Lyyvmn2XpeLdgfjUtejwMbObo9V4NUz8gRZF+gA=;
        b=aLnDR3zB18urnhwT6Q9ufu89m1ietUXrCNLDctMa1HoUd/C2U1dwNHRe8ncvdFG/gi
         uz/Fr8WWjOhkY26EW86PbkxWBx7kBySAl6u/UsEq70qCgmYDmM9MMS9rpxMVNaS81uWR
         6Q8S+jSy/VnXEms0vn2vhHlR660PEUUMXZWxBn5XAA8QeJ0t6j9DblJl7YGVXCrB6+gA
         hvXFsRdmcUh8w/f5OoSbGSYGPmalDqY/bT8FimamOqLHgGpGK6XoE2pyw5iOCP8wH+xe
         UQlcbEFAnEJNiddGkkKut9MKnr2Km0MHOGf0kAWCM6k+iDzg58fKKDwCiJ1agkgzYTco
         t4oQ==
X-Gm-Message-State: ALoCoQlHvQEaGhBzIX1ThWQb3eT412DLRwxS69BJpsrI8he5YFo1bnUI8H2cpk4MeZ1X3SxMlhjc
X-Received: by 10.194.81.70 with SMTP id y6mr40323989wjx.113.1416259714533;
        Mon, 17 Nov 2014 13:28:34 -0800 (PST)
Received: from [192.168.1.15] (AToulouse-656-1-820-36.w109-215.abo.wanadoo.fr. [109.215.21.36])
        by mx.google.com with ESMTPSA id ft8sm30203394wjb.17.2014.11.17.13.28.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Nov 2014 13:28:33 -0800 (PST)
Message-ID: <546A687F.6050104@linaro.org>
Date:   Mon, 17 Nov 2014 22:28:31 +0100
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
X-archive-position: 44252
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

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

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
