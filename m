Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Feb 2012 13:24:30 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:47225 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1901169Ab2BQMYY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Feb 2012 13:24:24 +0100
Message-ID: <4F3E46F0.5010701@openwrt.org>
Date:   Fri, 17 Feb 2012 13:24:16 +0100
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.20) Gecko/20110820 Icedove/3.1.12
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH 4/6] NET: MIPS: lantiq: convert etop to managed gpio
References: <1329474771-20874-1-git-send-email-blogic@openwrt.org> <1329474771-20874-5-git-send-email-blogic@openwrt.org>
In-Reply-To: <1329474771-20874-5-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 32457
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>


>  	ltq_gbit_w32_mask(0, PX_CTL_DMDIO, LTQ_GBIT_P0_CTL);
> @@ -873,6 +870,12 @@ ltq_etop_probe(struct platform_device *pdev)
>  			err = -ENOMEM;
>  			goto err_out;
>  		}
> +		if (ltq_gpio_request(&pdev->dev, 42, 2, 1, "MDIO") ||
> +				ltq_gpio_request(&pdev->dev, 43, 2, 1, "MDC")) {
> +			dev_err(&pdev->dev, "failed to request MDIO gpios\n");
> +			err = -ENOMEM;
-EBUSY should go here instead of -ENOMEM


> +			goto err_out;
> +		}
>  	}
>  
>  	dev = alloc_etherdev_mq(sizeof(struct ltq_etop_priv), 4);
