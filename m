Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jun 2011 11:24:46 +0200 (CEST)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:45838 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490989Ab1FMJYn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Jun 2011 11:24:43 +0200
Received: by wwb17 with SMTP id 17so3862024wwb.24
        for <linux-mips@linux-mips.org>; Mon, 13 Jun 2011 02:24:38 -0700 (PDT)
Received: by 10.227.203.145 with SMTP id fi17mr4810254wbb.106.1307957078207;
        Mon, 13 Jun 2011 02:24:38 -0700 (PDT)
Received: from localhost (gw-ba1.picochip.com [94.175.234.108])
        by mx.google.com with ESMTPS id fm14sm4093141wbb.41.2011.06.13.02.24.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 13 Jun 2011 02:24:37 -0700 (PDT)
Date:   Mon, 13 Jun 2011 10:24:35 +0100
From:   Jamie Iles <jamie@jamieiles.com>
To:     Florian Fainelli <florian@openwrt.org>
Cc:     Wim Van Sebroeck <wim@iguana.be>, linux-mips@linux-mips.org,
        linux-watchdog@vger.kernel.org,
        Manuel Lauss <manuel.lauss@googlemail.com>,
        Jamie Iles <jamie@jamieiles.com>, stable@kernel.org
Subject: Re: [PATCH 2/5 v2] WATCHDOG: mtx1-wdt: request gpio before using it
Message-ID: <20110613092435.GC2472@pulham.picochip.com>
References: <201106121856.17176.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201106121856.17176.florian@openwrt.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30366
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jamie@jamieiles.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10477

On Sun, Jun 12, 2011 at 06:56:17PM +0200, Florian Fainelli wrote:
> Otherwise, the gpiolib autorequest feature will produce a WARN_ON():
> 
> WARNING: at drivers/gpio/gpiolib.c:101 0x8020ec6c()
> autorequest GPIO-215
> [...]
> 
> CC:stable@kernel.org
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---

One really minor nit inline but otherwise this series looks fine to me.

Jamie

> Changes since v1:
> - use gpio_request_one()
> - added missing gpio_free() in mtx1_wdt_remove
> 
> Stable: [2.6.39+]
> 
> diff --git a/drivers/watchdog/mtx-1_wdt.c b/drivers/watchdog/mtx-1_wdt.c
> index 63df28c..9b63642 100644
> --- a/drivers/watchdog/mtx-1_wdt.c
> +++ b/drivers/watchdog/mtx-1_wdt.c
> @@ -214,6 +214,12 @@ static int __devinit mtx1_wdt_probe(struct platform_device *pdev)
>  	int ret;
>  
>  	mtx1_wdt_device.gpio = pdev->resource[0].start;
> +	ret = gpio_request_one(mtx1_wdt_device.gpio,
> +				GPIOF_OUT_INIT_HIGH,"mtx1-wdt");

Missing an extra space after the comma.

> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to request gpio");
> +		return ret;
> +	}
>  
>  	spin_lock_init(&mtx1_wdt_device.lock);
>  	init_completion(&mtx1_wdt_device.stop);
> @@ -239,6 +245,8 @@ static int __devexit mtx1_wdt_remove(struct platform_device *pdev)
>  		mtx1_wdt_device.queue = 0;
>  		wait_for_completion(&mtx1_wdt_device.stop);
>  	}
> +
> +	gpio_free(mtx1_wdt_device.gpio);
>  	misc_deregister(&mtx1_wdt_misc);
>  	return 0;
>  }
> -- 
> 1.7.4.1
> 
