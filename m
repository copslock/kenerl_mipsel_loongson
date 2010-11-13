Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Nov 2010 12:55:04 +0100 (CET)
Received: from mail-ew0-f49.google.com ([209.85.215.49]:60458 "EHLO
        mail-ew0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491104Ab0KMLy6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 13 Nov 2010 12:54:58 +0100
Received: by ewy19 with SMTP id 19so2270093ewy.36
        for <multiple recipients>; Sat, 13 Nov 2010 03:54:58 -0800 (PST)
Received: by 10.14.119.205 with SMTP id n53mr2281843eeh.37.1289649298203;
        Sat, 13 Nov 2010 03:54:58 -0800 (PST)
Received: from [192.168.2.2] ([91.79.89.47])
        by mx.google.com with ESMTPS id b52sm4302239eei.7.2010.11.13.03.54.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 13 Nov 2010 03:54:57 -0800 (PST)
Message-ID: <4CDE7C25.4080204@mvista.com>
Date:   Sat, 13 Nov 2010 14:53:09 +0300
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-GB; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
MIME-Version: 1.0
To:     Gabor Juhos <juhosg@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        "Luis R. Rodriguez" <mcgrof@gmail.com>,
        Cliff Holden <Cliff.Holden@Atheros.com>,
        Imre Kaloz <kaloz@openwrt.org>
Subject: Re: [RFC 08/18] MIPS: ath79: add common watchdog device
References: <1289598684-30624-1-git-send-email-juhosg@openwrt.org> <1289598684-30624-9-git-send-email-juhosg@openwrt.org>
In-Reply-To: <1289598684-30624-9-git-send-email-juhosg@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28387
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

On 13-11-2010 0:51, Gabor Juhos wrote:

> All supported SoCs have a built-in hardware watchdog driver. This patch
> registers a platform_device for that to make it usable.

> Signed-off-by: Gabor Juhos<juhosg@openwrt.org>
> Signed-off-by: Imre Kaloz<kaloz@openwrt.org>
[...]

> diff --git a/arch/mips/ath79/Kconfig b/arch/mips/ath79/Kconfig
> index 2bd35ef..79bb528 100644
> --- a/arch/mips/ath79/Kconfig
> +++ b/arch/mips/ath79/Kconfig
> @@ -28,4 +28,7 @@ config ATH79_DEV_LEDS_GPIO
>   config ATH79_DEV_UART
>   	def_bool y
>
> +config ATH79_DEV_WDT
> +	def_bool y

    What's the point of introducing this?

> diff --git a/arch/mips/ath79/dev-wdt.c b/arch/mips/ath79/dev-wdt.c
> new file mode 100644
> index 0000000..ba6b8bd
> --- /dev/null
> +++ b/arch/mips/ath79/dev-wdt.c
> @@ -0,0 +1,30 @@
> +/*
> + *  Atheros AR71XX/AR724X/AR913X watchdog device
> + *
> + *  Copyright (C) 2008-2010 Gabor Juhos<juhosg@openwrt.org>
> + *  Copyright (C) 2008 Imre Kaloz<kaloz@openwrt.org>
> + *
> + *  Parts of this file are based on Atheros' 2.6.15 BSP
> + *
> + *  This program is free software; you can redistribute it and/or modify it
> + *  under the terms of the GNU General Public License version 2 as published
> + *  by the Free Software Foundation.
> + */
> +
> +#include<linux/kernel.h>
> +#include<linux/init.h>
> +#include<linux/platform_device.h>
> +
> +#include<asm/mach-ath79/ar71xx_regs.h>
> +#include "common.h"
> +#include "dev-wdt.h"
> +
> +static struct platform_device ath79_wdt_device = {
> +	.name		= "ath79-wdt",
> +	.id		= -1,
> +};
> +
> +void __init ath79_register_wdt(void)
> +{
> +	platform_device_register(&ath79_wdt_device);
> +}

    I'm not sure creating a separate file for the WDT platfrom device is 
really worth it...

> diff --git a/arch/mips/ath79/dev-wdt.h b/arch/mips/ath79/dev-wdt.h
> new file mode 100644
> index 0000000..2546415
> --- /dev/null
> +++ b/arch/mips/ath79/dev-wdt.h
> @@ -0,0 +1,17 @@
> +/*
> + *  Atheros AR71XX/AR724X/AR913X watchdog device
> + *
> + *  Copyright (C) 2008-2010 Gabor Juhos<juhosg@openwrt.org>
> + *  Copyright (C) 2008 Imre Kaloz<kaloz@openwrt.org>
> + *
> + *  This program is free software; you can redistribute it and/or modify it
> + *  under the terms of the GNU General Public License version 2 as published
> + *  by the Free Software Foundation.
> + */
> +
> +#ifndef _ATH_DEV_WDT_H
> +#define _ATH_DEV_WDT_H
> +
> +void ath79_register_wdt(void) __init;
> +
> +#endif

    I think this should better be put into some more common header...

> diff --git a/arch/mips/ath79/setup.c b/arch/mips/ath79/setup.c
> index b36f9f2..693a9e6 100644
> --- a/arch/mips/ath79/setup.c
> +++ b/arch/mips/ath79/setup.c
> @@ -24,6 +24,7 @@
>   #include<asm/mach-ath79/ar71xx_regs.h>
>   #include "common.h"
>   #include "dev-uart.h"
> +#include "dev-wdt.h"
>   #include "machtypes.h"
>
>   #define ATH79_SYS_TYPE_LEN	64
> @@ -259,6 +260,7 @@ static int __init ath79_setup(void)
>   {
>   	ath79_gpio_init();
>   	ath79_register_uart();
> +	ath79_register_wdt();

    Now what if CONFIG_ATH79_DEV_WDT is not enabled? You'll siply get a linker 
error. I think you should define an empty inline ath79_register_wdt() in that 
case.

WBR, Sergei
