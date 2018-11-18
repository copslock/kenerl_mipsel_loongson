Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Nov 2018 02:40:08 +0100 (CET)
Received: from mail-wm1-x341.google.com ([IPv6:2a00:1450:4864:20::341]:55500
        "EHLO mail-wm1-x341.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992834AbeKRBje21BHx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Nov 2018 02:39:34 +0100
Received: by mail-wm1-x341.google.com with SMTP id y139so2014795wmc.5
        for <linux-mips@linux-mips.org>; Sat, 17 Nov 2018 17:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vI52ho93BaiPE3L/jNpnme5yyJsC48fUm+EVPIHK0Ro=;
        b=Nx0pfWucMMU9pi45rz4IttZ/dm9RBdhvcThTdAPdqNuMdUkJ3dsVEAzBVBqcndACzy
         e4j4erjHuB/L2Hgqsz5Wfl4AXzy/4ra3VGV2L87eb2Q2xKiZ43qeAwbJXkL1K0NITzDC
         eBaLtgci18ZJLzqn4+TabBU+n6BmOgOKZVDP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vI52ho93BaiPE3L/jNpnme5yyJsC48fUm+EVPIHK0Ro=;
        b=ngXof0t4vLavFNqL8DXUPxVDt28S/7OyKohXREB67+Ds/qGGNtP1DchHlLR70/zWtF
         N8GS/JE9fXOkxWd0uhwRX+ee6d7FEWWEpHPcfW2FtEZAqeIbNHh52i9T/DB4KtFX9STI
         C8bwkSkkSdzqM8FTrg8Z+Q9nc3TPU0Kjuf0kJo7vmf6akf/T50HHh2doMea5XSilpJC8
         sIzzj9HobnBFJ65eNnfgV1zvrZ3I3iw6uCItGS1cw+tRfnFs/vI2XrZtW0tGhL40aWrP
         iTwGOqRDs/rOPKZez1fbBiMlHhSUFoMhLqqRvvteGipy5i+FryjZf3IR1xpADhKfdhba
         ojnA==
X-Gm-Message-State: AGRZ1gLvPWv9VfXl7NxayRb3oMfaGwkA3EirF2Ju5VJf3kJEvZV3jXh6
        0yFa6UnYBcPK6MshJ+3uAzA/+w==
X-Google-Smtp-Source: AFSGD/VYiCg8YZzREyj/XCxLhCD5MMsYL/+5joIhVVaQlO1jQBwf3vgFXPgwCdRlcodDL5adV+Zojw==
X-Received: by 2002:a1c:8d86:: with SMTP id p128-v6mr3101886wmd.48.1542505173803;
        Sat, 17 Nov 2018 17:39:33 -0800 (PST)
Received: from [192.168.0.40] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id 64-v6sm30918216wml.22.2018.11.17.17.39.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Nov 2018 17:39:33 -0800 (PST)
Subject: Re: [RFC v2 5/7] clocksource/drivers/rtl8186: Add RTL8186 timer
 driver
To:     Yasha Cherikovsky <yasha.che3@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20181001102952.7913-1-yasha.che3@gmail.com>
 <20181001102952.7913-6-yasha.che3@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <dd8dbad0-efc3-fab1-e1d8-75819af66879@linaro.org>
Date:   Sun, 18 Nov 2018 02:39:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181001102952.7913-6-yasha.che3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <daniel.lezcano@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67342
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


Hi Yasha,

except the few details below, the driver looks good to me.

On 01/10/2018 12:29, Yasha Cherikovsky wrote:
> The Realtek RTL8186 SoC is a MIPS based SoC
> used in some home routers [1][2].
> 
> This adds a driver to handle the built-in timers
> on this SoC.
> 
> Timers 0 and 1 are 24bit timers.
> Timers 2 and 3 are 32bit timers.
> 
> Use Timer2 as clocksource and Timer3 for clockevents.
> Timer2 is also used for sched_clock.
> 
> [1] https://www.linux-mips.org/wiki/Realtek_SOC#Realtek_RTL8186
> [2] https://wikidevi.com/wiki/Realtek_RTL8186
> 
> Signed-off-by: Yasha Cherikovsky <yasha.che3@gmail.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: James Hogan <jhogan@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-mips@linux-mips.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/clocksource/Kconfig         |   9 ++
>  drivers/clocksource/Makefile        |   1 +
>  drivers/clocksource/timer-rtl8186.c | 220 ++++++++++++++++++++++++++++
>  3 files changed, 230 insertions(+)
>  create mode 100644 drivers/clocksource/timer-rtl8186.c
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index dec0dd88ec15..da87f73d0631 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -609,4 +609,13 @@ config ATCPIT100_TIMER
>  	help
>  	  This option enables support for the Andestech ATCPIT100 timers.
>  
> +config RTL8186_TIMER
> +	bool "RTL8186 timer driver"
> +	depends on MACH_RTL8186
> +	depends on COMMON_CLK
> +	select TIMER_OF
> +	select CLKSRC_MMIO
> +	help
> +	  Enables support for the RTL8186 timer driver.
> +

Please, convert this entry like the MTK_TIMER or the SPRD_TIMER.

>  endmenu
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index 00caf37e52f9..734e8566e1b6 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -78,3 +78,4 @@ obj-$(CONFIG_H8300_TPU)			+= h8300_tpu.o
>  obj-$(CONFIG_CLKSRC_ST_LPC)		+= clksrc_st_lpc.o
>  obj-$(CONFIG_X86_NUMACHIP)		+= numachip.o
>  obj-$(CONFIG_ATCPIT100_TIMER)		+= timer-atcpit100.o
> +obj-$(CONFIG_RTL8186_TIMER)		+= timer-rtl8186.o
> diff --git a/drivers/clocksource/timer-rtl8186.c b/drivers/clocksource/timer-rtl8186.c
> new file mode 100644
> index 000000000000..47ef4b09ad27
> --- /dev/null
> +++ b/drivers/clocksource/timer-rtl8186.c
> @@ -0,0 +1,220 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Realtek RTL8186 SoC timer driver.
> + *
> + * Timer0 (24bit): Unused
> + * Timer1 (24bit): Unused
> + * Timer2 (32bit): Used as clocksource
> + * Timer3 (32bit): Used as clock event device
> + *
> + * Copyright (C) 2018 Yasha Cherikovsky
> + */
> +
> +#include <linux/init.h>
> +#include <linux/clockchips.h>
> +#include <linux/clocksource.h>
> +#include <linux/interrupt.h>
> +#include <linux/jiffies.h>
> +#include <linux/sched_clock.h>
> +#include <linux/of_clk.h>
> +#include <linux/io.h>
> +
> +#include <asm/time.h>
> +#include <asm/idle.h>

Why do you need those 2 includes above ?

> +#include "timer-of.h"
> +
> +/* Timer registers */
> +#define TCCNR			0x0
> +#define TCIR			0x4
> +#define TC_DATA(t)		(0x10 + 4 * (t))
> +#define TC_CNT(t)		(0x20 + 4 * (t))
> +
> +/* TCCNR register bits */
> +#define TCCNR_TC_EN_BIT(t)		BIT((t) * 2)
> +#define TCCNR_TC_MODE_BIT(t)		BIT((t) * 2 + 1)
> +#define TCCNR_TC_SRC_BIT(t)		BIT((t) + 8)
> +
> +/* TCIR register bits */
> +#define TCIR_TC_IE_BIT(t)		BIT(t)
> +#define TCIR_TC_IP_BIT(t)		BIT((t) + 4)
> +
> +
> +/* Forward declaration */
> +static struct timer_of to;
> +
> +static void __iomem *base;
> +
> +

nit: extra line

> +#define RTL8186_TIMER_MODE_COUNTER	0
> +#define RTL8186_TIMER_MODE_TIMER	1
> +

[ ... ]

Thanks

  -- Daniel



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
