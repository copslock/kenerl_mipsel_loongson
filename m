Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Dec 2012 10:15:50 +0100 (CET)
Received: from mail-la0-f49.google.com ([209.85.215.49]:47904 "EHLO
        mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6828015Ab2LLJPtWRjLL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Dec 2012 10:15:49 +0100
Received: by mail-la0-f49.google.com with SMTP id r15so353705lag.36
        for <multiple recipients>; Wed, 12 Dec 2012 01:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:organization:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=QF2kaAKw4I4Zcb4sewnWvmYfYvZJh+U1DwryLc6DHcA=;
        b=o4eYlR+hUqQKbx0kJk2eyCMqgrLKFhVXn2s8YWuSXNyZYrrYxBHREv113itbRXLh3p
         4nAt/orjH4f1cJyJ/CLZ+MPeFqTTdELigfsUuXfQpYZGHBiRoy+g8j7evtv8HapiMbZw
         6fgR7wgnRpxA1D/wu2KhW2z8liu/7WYX5CE1vuCBauoH496jXhgEiLtFqX2p7LECuYfk
         cScIyQyjeuuKGPhoXo6y9f7ewZVMYrBjGaVtuEPRWvnKJsL0brgOaRSvw9xUVy14jcFu
         JHUB3mSSc0MWUoZOD72hSCi/fAMCjSiB4SM/a1PwMzm35g3V+/3cc0sg+DSM2Dy81nYS
         Q3Fw==
Received: by 10.152.108.42 with SMTP id hh10mr329703lab.4.1355303743736;
        Wed, 12 Dec 2012 01:15:43 -0800 (PST)
Received: from [192.168.108.37] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by mx.google.com with ESMTPS id v7sm9246637lbj.13.2012.12.12.01.15.42
        (version=SSLv3 cipher=OTHER);
        Wed, 12 Dec 2012 01:15:43 -0800 (PST)
Message-ID: <50C84AC3.9020809@openwrt.org>
Date:   Wed, 12 Dec 2012 10:13:39 +0100
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-Version: 1.0
To:     Hauke Mehrtens <hauke@hauke-m.de>
CC:     john@phrozen.org, ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: BCM47XX: fix compile error in wgt634u.c
References: <1355274612-19167-1-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1355274612-19167-1-git-send-email-hauke@hauke-m.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-archive-position: 35256
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello Hauke,

Le 12/12/12 02:10, Hauke Mehrtens a écrit :
> After the new GPIO handling for the bcm47xx target was introduced
> wgt634u.c was not changed.
> This patch fixes the following compile error:
>
> arch/mips/bcm47xx/wgt634u.c: In function ‘gpio_interrupt’:
> arch/mips/bcm47xx/wgt634u.c:119:2: error: implicit declaration of function ‘gpio_polarity’ [-Werror=implicit-function-declaration]
> arch/mips/bcm47xx/wgt634u.c: In function ‘wgt634u_init’:
> arch/mips/bcm47xx/wgt634u.c:153:4: error: implicit declaration of function ‘gpio_intmask’ [-Werror=implicit-function-declaration]

Thanks for fixing this. We should probably remove this wgt634u file some 
day or the other as it was an ad-hoc hack for this single device while 
we actually need a general solution for all BCM47xx boards out there.

>
> Reported-by: Ralf Baechle <ralf@linux-mips.org>
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>   arch/mips/bcm47xx/wgt634u.c |    8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> I am planing to remove this entire file, but I haven't come up with
> code adding support for most of the boards found in the wild.
>
> diff --git a/arch/mips/bcm47xx/wgt634u.c b/arch/mips/bcm47xx/wgt634u.c
> index e9f9ec8..6c28f6d 100644
> --- a/arch/mips/bcm47xx/wgt634u.c
> +++ b/arch/mips/bcm47xx/wgt634u.c
> @@ -11,6 +11,7 @@
>   #include <linux/leds.h>
>   #include <linux/mtd/physmap.h>
>   #include <linux/ssb/ssb.h>
> +#include <linux/ssb/ssb_embedded.h>
>   #include <linux/interrupt.h>
>   #include <linux/reboot.h>
>   #include <linux/gpio.h>
> @@ -116,7 +117,8 @@ static irqreturn_t gpio_interrupt(int irq, void *ignored)
>
>   	/* Interrupt are level triggered, revert the interrupt polarity
>   	   to clear the interrupt. */
> -	gpio_polarity(WGT634U_GPIO_RESET, state);
> +	ssb_gpio_polarity(&bcm47xx_bus.ssb, 1 << WGT634U_GPIO_RESET,
> +			  state ? 1 << WGT634U_GPIO_RESET : 0);
>
>   	if (!state) {
>   		printk(KERN_INFO "Reset button pressed");
> @@ -150,7 +152,9 @@ static int __init wgt634u_init(void)
>   				 gpio_interrupt, IRQF_SHARED,
>   				 "WGT634U GPIO", &bcm47xx_bus.ssb.chipco)) {
>   			gpio_direction_input(WGT634U_GPIO_RESET);
> -			gpio_intmask(WGT634U_GPIO_RESET, 1);
> +			ssb_gpio_intmask(&bcm47xx_bus.ssb,
> +					 1 << WGT634U_GPIO_RESET,
> +					 1 << WGT634U_GPIO_RESET);
>   			ssb_chipco_irq_mask(&bcm47xx_bus.ssb.chipco,
>   					    SSB_CHIPCO_IRQ_GPIO,
>   					    SSB_CHIPCO_IRQ_GPIO);
>
