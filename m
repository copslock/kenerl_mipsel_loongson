Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Jun 2011 11:59:44 +0200 (CEST)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:47517 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491030Ab1FGJ7m (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Jun 2011 11:59:42 +0200
Received: by wwb17 with SMTP id 17so3969157wwb.24
        for <linux-mips@linux-mips.org>; Tue, 07 Jun 2011 02:59:36 -0700 (PDT)
Received: by 10.217.7.71 with SMTP id z49mr3891208wes.33.1307440776545;
        Tue, 07 Jun 2011 02:59:36 -0700 (PDT)
Received: from localhost (gw-ba1.picochip.com [94.175.234.108])
        by mx.google.com with ESMTPS id p21sm3425348wbh.57.2011.06.07.02.59.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 07 Jun 2011 02:59:34 -0700 (PDT)
Date:   Tue, 7 Jun 2011 10:59:32 +0100
From:   Jamie Iles <jamie@jamieiles.com>
To:     Florian Fainelli <florian@openwrt.org>
Cc:     Wim Van Sebroeck <wim@iguana.be>, linux-mips@linux-mips.org,
        linux-watchdog@vger.kernel.org,
        Manuel Lauss <manuel.lauss@googlemail.com>, stable@kernel.org
Subject: Re: [PATCH 3/3] WATCHDOG: mtx1-wdt: fix GPIO toggling
Message-ID: <20110607095932.GC21174@pulham.picochip.com>
References: <201106021454.21827.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201106021454.21827.florian@openwrt.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30280
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jamie@jamieiles.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 5372

On Thu, Jun 02, 2011 at 02:54:21PM +0200, Florian Fainelli wrote:
> Commit e391be76 (MIPS: Alchemy: Clean up GPIO registers and accessors)
> changed the way the GPIO was toggled. Prior to this patch, we would
> always actively drive the GPIO output to either 0 or 1, this patch
> drove the GPIO active to 0, and put the GPIO in tristate to drive it
> to 1, unfortunately this does not work, revert back to active driving.
> 
> Using a signed variable (gstate) to hold the gpio state and using a bit-
> wise operation on it also resulted in toggling value from 1 to -2 since
> the variable is signed. This value was then passed on to gpio_direction_
> output, which always perform a if (value) ... to set the value to the
> gpio, so we were always writing a 1 to this GPIO instead of 1 -> 0 -> 1 ...
> 
> CC: stable@kernel.org
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
> diff --git a/drivers/watchdog/mtx-1_wdt.c b/drivers/watchdog/mtx-1_wdt.c
> index 16086f8..9756da9 100644
> --- a/drivers/watchdog/mtx-1_wdt.c
> +++ b/drivers/watchdog/mtx-1_wdt.c
> @@ -66,7 +66,7 @@ static struct {
>  	int default_ticks;
>  	unsigned long inuse;
>  	unsigned gpio;
> -	int gstate;
> +	unsigned int gstate;
>  } mtx1_wdt_device;
>  
>  static void mtx1_wdt_trigger(unsigned long unused)
> @@ -78,11 +78,8 @@ static void mtx1_wdt_trigger(unsigned long unused)
>  		ticks--;
>  
>  	/* toggle wdt gpio */
> -	mtx1_wdt_device.gstate = ~mtx1_wdt_device.gstate;
> -	if (mtx1_wdt_device.gstate)
> -		gpio_direction_output(mtx1_wdt_device.gpio, 1);
> -	else
> -		gpio_direction_input(mtx1_wdt_device.gpio);
> +	mtx1_wdt_device.gstate = !mtx1_wdt_device.gstate;
> +	gpio_direction_output(mtx1_wdt_device.gpio, mtx1_wdt_device.gstate);

Would gpio_set_value() be more appropriate here?  Isn't the gpio always 
an output after the first call?

Jamie
