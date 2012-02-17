Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Feb 2012 00:03:04 +0100 (CET)
Received: from mail-ey0-f177.google.com ([209.85.215.177]:55575 "EHLO
        mail-ey0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903696Ab2BQXC6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 18 Feb 2012 00:02:58 +0100
Received: by eaai1 with SMTP id i1so1555783eaa.36
        for <multiple recipients>; Fri, 17 Feb 2012 15:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=BlBM68LqsaffaL5juZBo/Kid123MzpTnrNRnbd665mg=;
        b=dJfSmCyVTxvEWigLIV0BM8do0WTJ7FgKBhpPXMuP/v05343C7T+zFBguUCHqphNN0P
         gbhY4tE/7pgv/jBtSqdELme6kDlwLkSG2PMqDcELW7c/4lJdRtmjmkwEEoDGmYId+G1a
         4vgBwWral8aWo7P6kdkaEM7/n0JmMG/EwzH/Q=
Received: by 10.213.26.198 with SMTP id f6mr1511402ebc.25.1329519772372;
        Fri, 17 Feb 2012 15:02:52 -0800 (PST)
Received: from [192.168.100.100] (dslb-188-106-254-057.pools.arcor-ip.net. [188.106.254.57])
        by mx.google.com with ESMTPS id y14sm14552266eef.10.2012.02.17.15.02.50
        (version=SSLv3 cipher=OTHER);
        Fri, 17 Feb 2012 15:02:51 -0800 (PST)
Message-ID: <4F3EDC99.2070106@googlemail.com>
Date:   Sat, 18 Feb 2012 00:02:49 +0100
From:   Daniel Schwierzeck <daniel.schwierzeck@googlemail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 3/3] MIPS: lantiq: make use of module_platform_driver()
References: <1329474832-21095-1-git-send-email-blogic@openwrt.org> <1329474832-21095-3-git-send-email-blogic@openwrt.org>
In-Reply-To: <1329474832-21095-3-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 32466
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.schwierzeck@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Am 17.02.2012 11:33, schrieb John Crispin:
> Reduce boilerplate code.
>
> Signed-off-by: John Crispin<blogic@openwrt.org>
> ---
>   drivers/mtd/maps/lantiq-flash.c    |   20 ++------------------
>   drivers/net/ethernet/lantiq_etop.c |   20 ++------------------
>   drivers/watchdog/lantiq_wdt.c      |   17 ++---------------
>   3 files changed, 6 insertions(+), 51 deletions(-)
>
> diff --git a/drivers/mtd/maps/lantiq-flash.c b/drivers/mtd/maps/lantiq-flash.c
> index 7b889de..e22436d 100644
> --- a/drivers/mtd/maps/lantiq-flash.c
> +++ b/drivers/mtd/maps/lantiq-flash.c
> @@ -203,6 +203,7 @@ ltq_mtd_remove(struct platform_device *pdev)
>   }
>
>   static struct platform_driver ltq_mtd_driver = {
> +	.probe = ltq_mtd_probe,

you also need to change __init to __devinit at ltq_mtd_probe. Compiling 
with CONFIG_DEBUG_SECTION_MISMATCH shows following warning:

WARNING: drivers/mtd/maps/built-in.o(.data+0x0): Section mismatch in 
reference from the variable ltq_mtd_driver to the function 
.init.text:ltq_mtd_probe()
     The variable ltq_mtd_driver references
     the function __init ltq_mtd_probe()
     If the reference is valid then annotate the
     variable with __init* or __refdata (see linux/init.h) or name the 
variable:
     *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console


>   	.remove = __devexit_p(ltq_mtd_remove),
>   	.driver = {
>   		.name = "ltq_nor",
> @@ -210,24 +211,7 @@ static struct platform_driver ltq_mtd_driver = {
>   	},
>   };
>
> -static int __init
> -init_ltq_mtd(void)
> -{
> -	int ret = platform_driver_probe(&ltq_mtd_driver, ltq_mtd_probe);
> -
> -	if (ret)
> -		pr_err("ltq_nor: error registering platform driver");
> -	return ret;
> -}
> -
> -static void __exit
> -exit_ltq_mtd(void)
> -{
> -	platform_driver_unregister(&ltq_mtd_driver);
> -}
> -
> -module_init(init_ltq_mtd);
> -module_exit(exit_ltq_mtd);
> +module_platform_driver(ltq_mtd_driver);
>
>   MODULE_LICENSE("GPL");
>   MODULE_AUTHOR("John Crispin<blogic@openwrt.org>");
> diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
> index fa2580b..4cfc314 100644
> --- a/drivers/net/ethernet/lantiq_etop.c
> +++ b/drivers/net/ethernet/lantiq_etop.c
> @@ -943,6 +943,7 @@ ltq_etop_remove(struct platform_device *pdev)
>   }
>
>   static struct platform_driver ltq_mii_driver = {
> +	.probe = ltq_etop_probe,

dito

>   	.remove = __devexit_p(ltq_etop_remove),
>   	.driver = {
>   		.name = "ltq_etop",
> @@ -950,24 +951,7 @@ static struct platform_driver ltq_mii_driver = {
>   	},
>   };
>
> -int __init
> -init_ltq_etop(void)
> -{
> -	int ret = platform_driver_probe(&ltq_mii_driver, ltq_etop_probe);
> -
> -	if (ret)
> -		pr_err("ltq_etop: Error registering platfom driver!");
> -	return ret;
> -}
> -
> -static void __exit
> -exit_ltq_etop(void)
> -{
> -	platform_driver_unregister(&ltq_mii_driver);
> -}
> -
> -module_init(init_ltq_etop);
> -module_exit(exit_ltq_etop);
> +module_platform_driver(ltq_mii_driver);
>
>   MODULE_AUTHOR("John Crispin<blogic@openwrt.org>");
>   MODULE_DESCRIPTION("Lantiq SoC ETOP");
> diff --git a/drivers/watchdog/lantiq_wdt.c b/drivers/watchdog/lantiq_wdt.c
> index 05646b8..572ac60 100644
> --- a/drivers/watchdog/lantiq_wdt.c
> +++ b/drivers/watchdog/lantiq_wdt.c
> @@ -227,6 +227,7 @@ ltq_wdt_remove(struct platform_device *pdev)
>
>
>   static struct platform_driver ltq_wdt_driver = {
> +	.probe = ltq_wdt_probe,

dito

>   	.remove = __devexit_p(ltq_wdt_remove),
>   	.driver = {
>   		.name = "ltq_wdt",
> @@ -234,21 +235,7 @@ static struct platform_driver ltq_wdt_driver = {
>   	},
>   };
>
> -static int __init
> -init_ltq_wdt(void)
> -{
> -	return platform_driver_probe(&ltq_wdt_driver, ltq_wdt_probe);
> -}
> -
> -static void __exit
> -exit_ltq_wdt(void)
> -{
> -	return platform_driver_unregister(&ltq_wdt_driver);
> -}
> -
> -module_init(init_ltq_wdt);
> -module_exit(exit_ltq_wdt);
> -
> +module_platform_driver(ltq_wdt_driver);
>   module_param(nowayout, int, 0);
>   MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started");
>


-- 
Best regards,
Daniel
