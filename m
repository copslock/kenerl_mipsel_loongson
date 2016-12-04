Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Dec 2016 18:26:37 +0100 (CET)
Received: from bh-25.webhostbox.net ([208.91.199.152]:39494 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993126AbcLDR0aHzduo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 4 Dec 2016 18:26:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject;
        bh=9ceyts4lBkleKGSerEtIfJ6RGOF6154wn2OAqdtuRP4=; b=I9/BkEMO+FhGCDYWpT2GS8I03v
        V2TFXQM2cbqRmxqfJP7rsLR+RCEv7jW+gniqDmouptA0OF4GcjqyQoMyQpw/t7zG2L2lhkfUy49qx
        dBzc21g+jwCUjkJr0WL0mLpNgQ0v58apMMSBX6ur7RkMIlaaFjizThypBR0bbpAV1/r175WJFdIt9
        wszxGIeEfDyfW0rY2EeIy7aqgW4/4qzmd0FWJZg0JtLqjQGUppg5bNlZKXb/dZb5b6B3s+r+TMMY2
        rqBceeMwq0co6zYQTLYWTH44IbTJPzhn0X0IX5qsUdX5xk4Td8nv/w/sJaZik48HdiMLxYlytCjs6
        mdoz+sdg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:54204 helo=server.roeck-us.net)
        by bh-25.webhostbox.net with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
        (Exim 4.86_1)
        (envelope-from <linux@roeck-us.net>)
        id 1cDaYM-0016J3-Vm; Sun, 04 Dec 2016 17:26:19 +0000
Subject: Re: [PATCH v2.3 2/3] watchdog: loongson1: Add Loongson1 SoC watchdog
 driver
To:     Yang Ling <gnaygnil@gmail.com>, wim@iguana.be,
        keguang.zhang@gmail.com
References: <20161204150250.GA29772@ubuntu>
Cc:     linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <8b12c705-27d3-f9a9-2a99-6be190f19ae9@roeck-us.net>
Date:   Sun, 4 Dec 2016 09:26:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20161204150250.GA29772@ubuntu>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated_sender: linux@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: linux@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: linux@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55939
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On 12/04/2016 07:02 AM, Yang Ling wrote:
> Add watchdog timer specific driver for Loongson1 SoC.
>
> Signed-off-by: Yang Ling <gnaygnil@gmail.com>
>
> ---
> V2.3:
>   Set DEFAULT_HEARTBEAT value to ls1x_wdt->timeout.
> V2.2:
>   Remove the wide character.
>   Check the return value for clk_get_rate().
> V2.1 from Kelvin Cheung:
>   Use max_hw_heartbeat_ms instead of max_timeout.
> V2.0:
>   Increase the value of the default heartbeat.
>   Modify the setup process for register.
>   Order include files and Makefile alphabetically.
> V1.1:
>   Add a little debugging information.
> ---
>  drivers/watchdog/Kconfig         |   7 ++
>  drivers/watchdog/Makefile        |   1 +
>  drivers/watchdog/loongson1_wdt.c | 170 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 178 insertions(+)
>  create mode 100644 drivers/watchdog/loongson1_wdt.c
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index fdd3228..c5b9c6e 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1513,6 +1513,13 @@ config LANTIQ_WDT
>  	help
>  	  Hardware driver for the Lantiq SoC Watchdog Timer.
>
> +config LOONGSON1_WDT
> +	tristate "Loongson1 SoC hardware watchdog"
> +	depends on MACH_LOONGSON32
> +	select WATCHDOG_CORE
> +	help
> +	  Hardware driver for the Loongson1 SoC Watchdog Timer.
> +
>  config RALINK_WDT
>  	tristate "Ralink SoC watchdog"
>  	select WATCHDOG_CORE
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index caa9f4a..0c3d35e 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -163,6 +163,7 @@ obj-$(CONFIG_TXX9_WDT) += txx9wdt.o
>  obj-$(CONFIG_OCTEON_WDT) += octeon-wdt.o
>  octeon-wdt-y := octeon-wdt-main.o octeon-wdt-nmi.o
>  obj-$(CONFIG_LANTIQ_WDT) += lantiq_wdt.o
> +obj-$(CONFIG_LOONGSON1_WDT) += loongson1_wdt.o
>  obj-$(CONFIG_RALINK_WDT) += rt2880_wdt.o
>  obj-$(CONFIG_IMGPDC_WDT) += imgpdc_wdt.o
>  obj-$(CONFIG_MT7621_WDT) += mt7621_wdt.o
> diff --git a/drivers/watchdog/loongson1_wdt.c b/drivers/watchdog/loongson1_wdt.c
> new file mode 100644
> index 0000000..c43ad38
> --- /dev/null
> +++ b/drivers/watchdog/loongson1_wdt.c
> @@ -0,0 +1,170 @@
> +/*
> + * Copyright (c) 2016 Yang Ling <gnaygnil@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; either version 2 of the License, or (at your
> + * option) any later version.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/watchdog.h>
> +#include <loongson1.h>
> +
> +#define DEFAULT_HEARTBEAT	30
> +
> +static bool nowayout = WATCHDOG_NOWAYOUT;
> +module_param(nowayout, bool, 0444);
> +
> +static unsigned int heartbeat = DEFAULT_HEARTBEAT;

heartbeat should be 0.

Guenter
