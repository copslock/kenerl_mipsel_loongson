Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Jun 2011 11:59:00 +0200 (CEST)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:48425 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491030Ab1FGJ65 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Jun 2011 11:58:57 +0200
Received: by wwb17 with SMTP id 17so3968604wwb.24
        for <linux-mips@linux-mips.org>; Tue, 07 Jun 2011 02:58:52 -0700 (PDT)
Received: by 10.216.67.199 with SMTP id j49mr3570593wed.59.1307440731821;
        Tue, 07 Jun 2011 02:58:51 -0700 (PDT)
Received: from localhost (gw-ba1.picochip.com [94.175.234.108])
        by mx.google.com with ESMTPS id z66sm2769118weq.0.2011.06.07.02.58.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 07 Jun 2011 02:58:49 -0700 (PDT)
Date:   Tue, 7 Jun 2011 10:58:47 +0100
From:   Jamie Iles <jamie@jamieiles.com>
To:     Florian Fainelli <florian@openwrt.org>
Cc:     Wim Van Sebroeck <wim@iguana.be>, linux-mips@linux-mips.org,
        linux-watchdog@vger.kernel.org,
        Manuel Lauss <manuel.lauss@googlemail.com>, stable@kernel.org
Subject: Re: [PATCH 2/3] WATCHDOG: mtx1-wdt: request gpio before using it
Message-ID: <20110607095847.GB21174@pulham.picochip.com>
References: <201106021454.20111.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201106021454.20111.florian@openwrt.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30279
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jamie@jamieiles.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 5371

On Thu, Jun 02, 2011 at 02:54:20PM +0200, Florian Fainelli wrote:
> Otherwise, the gpiolib autorequest feature will produce a WARN_ON():
> 
> WARNING: at drivers/gpio/gpiolib.c:101 0x8020ec6c()
> autorequest GPIO-215
> [...]
> 
> CC: stable@kernel.org
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
> diff --git a/drivers/watchdog/mtx-1_wdt.c b/drivers/watchdog/mtx-1_wdt.c
> index 63df28c..16086f8 100644
> --- a/drivers/watchdog/mtx-1_wdt.c
> +++ b/drivers/watchdog/mtx-1_wdt.c
> @@ -214,6 +214,11 @@ static int __devinit mtx1_wdt_probe(struct platform_device *pdev)
>  	int ret;
>  
>  	mtx1_wdt_device.gpio = pdev->resource[0].start;
> +	ret = gpio_request(mtx1_wdt_device.gpio, "mtx1-wdt");
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to request gpio");
> +		return ret;
> +	}

Could you use gpio_request_one() here to make sure the GPIO is in the 
correct direction first?

Jamie
