Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Oct 2014 22:29:19 +0200 (CEST)
Received: from mail-pd0-f180.google.com ([209.85.192.180]:43451 "EHLO
        mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011638AbaJPU3QXBSir (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Oct 2014 22:29:16 +0200
Received: by mail-pd0-f180.google.com with SMTP id fp1so3877640pdb.11
        for <linux-mips@linux-mips.org>; Thu, 16 Oct 2014 13:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=xYM5kk9L+t5eW/0pfcwoo1cmvGeYS1Ev4BnR1ZLUj9M=;
        b=C2k+fAV+zJw+Lg7qa5fYp0e9zg4ea8of44z0vP00SVZOJNAGa0WzYo2gQv5FAx/ETn
         nNF6wA4+gH4qGE6uqeEgQgWtI7atJki7KhfZQNllPvHjf8tCYRiSEZYMor42Iem2YLik
         XljwJzAizvXhRlTBHhcy0C0rcts32y+O+pUGl49/uqPiHCjMYL+xc1IDfZf1YHsc0EP/
         GdWQLkcKc7eXtS9Wd6rhe18zdTy6QeXiQSpt96zQfwxDe3x+SKEvqNO3ZtSU2FObkP1P
         SD2SxFVWuG2tShkCC5o5gAabrwUv1PazRMeangHvsnX3gbdfSeyJ6xEwO+k8/bkgGT1J
         4LMw==
X-Received: by 10.70.89.12 with SMTP id bk12mr3799443pdb.102.1413491350310;
        Thu, 16 Oct 2014 13:29:10 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by mx.google.com with ESMTPSA id mu10sm20594160pdb.10.2014.10.16.13.29.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 16 Oct 2014 13:29:09 -0700 (PDT)
Date:   Thu, 16 Oct 2014 13:29:05 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     John Crispin <blogic@openwrt.org>
Cc:     Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] watchdog: rt2880_wdt: minor clean up
Message-ID: <20141016202905.GB26177@roeck-us.net>
References: <1413489665-52342-1-git-send-email-blogic@openwrt.org>
 <1413489665-52342-2-git-send-email-blogic@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1413489665-52342-2-git-send-email-blogic@openwrt.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43315
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

On Thu, Oct 16, 2014 at 10:01:05PM +0200, John Crispin wrote:
> Replace device_reset() with devm_reset_control_get() + reset_control_deassert().
> Make use of watchdog_init_timeout() instead of setting the timeout manually.
> 
> Signed-off-by: John Crispin <blogic@openwrt.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/rt2880_wdt.c |    9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/watchdog/rt2880_wdt.c b/drivers/watchdog/rt2880_wdt.c
> index d92c2d5..d2cd2bd 100644
> --- a/drivers/watchdog/rt2880_wdt.c
> +++ b/drivers/watchdog/rt2880_wdt.c
> @@ -45,6 +45,7 @@
>  static struct clk *rt288x_wdt_clk;
>  static unsigned long rt288x_wdt_freq;
>  static void __iomem *rt288x_wdt_base;
> +static struct reset_control *rt288x_wdt_reset;
>  
>  static bool nowayout = WATCHDOG_NOWAYOUT;
>  module_param(nowayout, bool, 0);
> @@ -151,16 +152,18 @@ static int rt288x_wdt_probe(struct platform_device *pdev)
>  	if (IS_ERR(rt288x_wdt_clk))
>  		return PTR_ERR(rt288x_wdt_clk);
>  
> -	device_reset(&pdev->dev);
> +	rt288x_wdt_reset = devm_reset_control_get(&pdev->dev, NULL);
> +	if (!IS_ERR(rt288x_wdt_reset))
> +		reset_control_deassert(rt288x_wdt_reset);
>  
>  	rt288x_wdt_freq = clk_get_rate(rt288x_wdt_clk) / RALINK_WDT_PRESCALE;
>  
>  	rt288x_wdt_dev.dev = &pdev->dev;
>  	rt288x_wdt_dev.bootstatus = rt288x_wdt_bootcause();
> -
>  	rt288x_wdt_dev.max_timeout = (0xfffful / rt288x_wdt_freq);
> -	rt288x_wdt_dev.timeout = rt288x_wdt_dev.max_timeout;
>  
> +	watchdog_init_timeout(&rt288x_wdt_dev, rt288x_wdt_dev.max_timeout,
> +			      &pdev->dev);
>  	watchdog_set_nowayout(&rt288x_wdt_dev, nowayout);
>  
>  	ret = watchdog_register_device(&rt288x_wdt_dev);
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
