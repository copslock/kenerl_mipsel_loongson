Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Nov 2011 12:57:48 +0100 (CET)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:39380 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904023Ab1KQL5l (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Nov 2011 12:57:41 +0100
Received: by bkat2 with SMTP id t2so2389332bka.36
        for <multiple recipients>; Thu, 17 Nov 2011 03:57:36 -0800 (PST)
Received: by 10.205.127.139 with SMTP id ha11mr25834406bkc.111.1321531056326;
        Thu, 17 Nov 2011 03:57:36 -0800 (PST)
Received: from [192.168.2.2] (ppp85-141-177-81.pppoe.mtu-net.ru. [85.141.177.81])
        by mx.google.com with ESMTPS id f14sm18587592bkv.3.2011.11.17.03.57.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Nov 2011 03:57:35 -0800 (PST)
Message-ID: <4EC4F67A.2030407@mvista.com>
Date:   Thu, 17 Nov 2011 15:56:42 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:8.0) Gecko/20111105 Thunderbird/8.0
MIME-Version: 1.0
To:     Florian Fainelli <florian@openwrt.org>
CC:     ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: BCM63XX: generate WLAN MAC address after registering
 ethernet devices.
References: <1321476598-9450-1-git-send-email-florian@openwrt.org>
In-Reply-To: <1321476598-9450-1-git-send-email-florian@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 31722
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14392

Hello.

On 17-11-2011 0:49, Florian Fainelli wrote:

> In case the MAC address pool is not big enough to also register a WLAN device
> prefer registering the Ethernet devices.

> Signed-off-by: Florian Fainelli<florian@openwrt.org>
> ---
>   arch/mips/bcm63xx/boards/board_bcm963xx.c |   25 +++++++++++++------------
>   1 files changed, 13 insertions(+), 12 deletions(-)

> diff --git a/arch/mips/bcm63xx/boards/board_bcm963xx.c b/arch/mips/bcm63xx/boards/board_bcm963xx.c
> index ac948c2..fcd5a8c 100644
> --- a/arch/mips/bcm63xx/boards/board_bcm963xx.c
> +++ b/arch/mips/bcm63xx/boards/board_bcm963xx.c
> @@ -791,18 +791,6 @@ void __init board_prom_init(void)
>   	}
>
>   	bcm_gpio_writel(val, GPIO_MODE_REG);
> -
> -	/* Generate MAC address for WLAN and
> -	 * register our SPROM */
> -#ifdef CONFIG_SSB_PCIHOST
> -	if (!board_get_mac_address(bcm63xx_sprom.il0mac)) {
> -		memcpy(bcm63xx_sprom.et0mac, bcm63xx_sprom.il0mac, ETH_ALEN);
> -		memcpy(bcm63xx_sprom.et1mac, bcm63xx_sprom.il0mac, ETH_ALEN);
> -		if (ssb_arch_register_fallback_sprom(
> -				&bcm63xx_get_fallback_sprom)<  0)
> -			printk(KERN_ERR PFX "failed to register fallback SPROM\n");
> -	}
> -#endif
>   }
>
>   /*
> @@ -886,6 +874,19 @@ int __init board_register_devices(void)
>   	if (board.has_dsp)
>   		bcm63xx_dsp_register(&board.dsp);
>
> +	/* Generate MAC address for WLAN and register our SPROM,
> +	 * do this after registering enet devices
> +	 */
> +#ifdef CONFIG_SSB_PCIHOST
> +	if (!board_get_mac_address(bcm63xx_sprom.il0mac)) {
> +		memcpy(bcm63xx_sprom.et0mac, bcm63xx_sprom.il0mac, ETH_ALEN);
> +		memcpy(bcm63xx_sprom.et1mac, bcm63xx_sprom.il0mac, ETH_ALEN);
> +		if (ssb_arch_register_fallback_sprom(
> +			&bcm63xx_get_fallback_sprom) < 0)

    Please keep the old indentation. This one makes the code harder to read.

> +			pr_err(PFX "failed to register fallback SPROM\n");
> +	}
> +#endif
> +
>   	/* read base address of boot chip select (0) */
>   	val = bcm_mpi_readl(MPI_CSBASE_REG(0));
>   	val&= MPI_CSBASE_BASE_MASK;

WBR, Sergei
