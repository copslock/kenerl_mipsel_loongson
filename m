Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Aug 2009 18:53:27 +0200 (CEST)
Received: from mail-bw0-f208.google.com ([209.85.218.208]:39778 "EHLO
	mail-bw0-f208.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492986AbZHUQxV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 21 Aug 2009 18:53:21 +0200
Received: by bwz4 with SMTP id 4so781470bwz.0
        for <multiple recipients>; Fri, 21 Aug 2009 09:53:15 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=MvflFqKE750wxTG2wYd7DcLpvFSYG4F/aKyYoB3+zZw=;
        b=GCWjS+sds9pHNudzTpozUSgZXHGKFOXSZWMwHaI28azb+DHaY0MmozVAAku0UkTQ1c
         BqzIeu2tzediGWw3khBCnl5NUyKGFLop/9vwAXHuGJXnMEJtcGfO9q+OvX/QgN2cJEF6
         SfExLMxNcAQadIMdwKzzkKUzP1paQsfevHaLs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=AB2e0VufKyofR779y0+ydgLzL5nGaYwX7s2Yiu3o/jPfo6zJtdEXCiBnWHMKwOT6WM
         gE5ZLGe+N6gICNzXz6Nd4esqxq7kf3rMj3+Rt9nZS6TGP1+b8ARdRhX1j4QUSzYoi2rM
         WvrdB1N5vSH/KLbmhV+CU5vRdj/ntFj1a1r50=
Received: by 10.103.76.29 with SMTP id d29mr581358mul.50.1250873595421;
        Fri, 21 Aug 2009 09:53:15 -0700 (PDT)
Received: from ?192.168.250.6? ([85.233.201.131])
        by mx.google.com with ESMTPS id 23sm10989494mum.35.2009.08.21.09.53.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 21 Aug 2009 09:53:13 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] alchemy: add au1000-eth platform device
Date:	Fri, 21 Aug 2009 18:53:07 +0200
User-Agent: KMail/1.9.9
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	Manuel Lauss <manuel.lauss@googlemail.com>,
	David Miller <davem@davemloft.net>, netdev@vger.kernel.org
References: <200908170105.38154.florian@openwrt.org> <4A8AC125.3020602@ru.mvista.com> <200908181801.41602.florian@openwrt.org>
In-Reply-To: <200908181801.41602.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200908211853.07969.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23919
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Le Tuesday 18 August 2009 18:01:40 Florian Fainelli, vous avez écrit :
> Le Tuesday 18 August 2009 16:56:37 Sergei Shtylyov, vous avez écrit :
> > Hello.
> >
> > Florian Fainelli wrote:
> > > This patch adds the board code to register a per-board au1000-eth
> > > platform device to be used wit the au1000-eth platform driver in a
> > > subsequent patch. Note that the au1000-eth driver knows about the
> > > default driver settings such that we do not need to pass any
> > > platform_data informations in most cases except db1x00.
> >
> >     Sigh, NAK...
> >     Please don't register the SoC device per board, do it in
> > alchemy/common/platfrom.c and find a way to pass the board specific
> > platform data from the board file there instead -- something like
> > arch/arm/mach-davinci/usb.c does.
>
> Ok, like I promised, this was the per-board device registration. Do you
> prefer something like this: --
> From fd75b7c7fa3c05c21122c43e43260d2785475a79 Mon Sep 17 00:00:00 2001
> From: Florian Fainelli <florian@openwrt.org>
> Date: Tue, 18 Aug 2009 17:53:21 +0200
> Subject: [PATCH] alchemy: add au1000-eth platform device (v2)
>
> This patch makes the board code register the au1000-eth
> platform device. The au1000-eth platform data can be
> overriden with the au1xxx_override_eth0_cfg function
> like it has to be done for the Bosporus board.

Sergei, any comments on that version? What about you Manuel?

>
> Changes from v1:
> - remove per-board platform.c file
> - add an override function to pass custom eth0 platform_data PHY settings
>
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
> diff --git a/arch/mips/alchemy/common/platform.c
> b/arch/mips/alchemy/common/platform.c index 117f99f..559294a 100644
> --- a/arch/mips/alchemy/common/platform.c
> +++ b/arch/mips/alchemy/common/platform.c
> @@ -19,6 +19,7 @@
>  #include <asm/mach-au1x00/au1xxx.h>
>  #include <asm/mach-au1x00/au1xxx_dbdma.h>
>  #include <asm/mach-au1x00/au1100_mmc.h>
> +#include <asm/mach-au1x00/au1xxx_eth.h>
>
>  #define PORT(_base, _irq)				\
>  	{						\
> @@ -331,6 +332,76 @@ static struct platform_device pbdb_smbus_device = {
>  };
>  #endif
>
> +/* Macro to help defining the Ethernet MAC resources */
> +#define MAC_RES(_base, _enable, _irq)			\
> +	{						\
> +		.start	= CPHYSADDR(_base),		\
> +		.end	= CPHYSADDR(_base + 0xffff),	\
> +		.flags	= IORESOURCE_MEM,		\
> +	},						\
> +	{						\
> +		.start	= CPHYSADDR(_enable),		\
> +		.end	= CPHYSADDR(_enable + 0x3),	\
> +		.flags	= IORESOURCE_MEM,		\
> +	},						\
> +	{						\
> +		.start	= _irq,				\
> +		.end	= _irq,				\
> +		.flags	= IORESOURCE_IRQ		\
> +	}
> +
> +static struct resource au1xxx_eth0_resources[] = {
> +#if defined(CONFIG_SOC_AU1000)
> +	MAC_RES(AU1000_ETH0_BASE, AU1000_MAC0_ENABLE, AU1000_MAC0_DMA_INT),
> +#elif defined(CONFIG_SOC_AU1100)
> +	MAC_RES(AU1100_ETH0_BASE, AU1100_MAC0_ENABLE, AU1100_MAC0_DMA_INT),
> +#elif defined(CONFIG_SOC_AU1550)
> +	MAC_RES(AU1550_ETH0_BASE, AU1550_MAC0_ENABLE, AU1550_MAC0_DMA_INT),
> +#elif defined(CONFIG_SOC_AU1500)
> +	MAC_RES(AU1500_ETH0_BASE, AU1500_MAC0_ENABLE, AU1500_MAC0_DMA_INT),
> +#endif
> +};
> +
> +static struct resource au1xxx_eth1_resources[] = {
> +#if defined(CONFIG_SOC_AU1000)
> +	MAC_RES(AU1000_ETH1_BASE, AU1000_MAC1_ENABLE, AU1000_MAC1_DMA_INT),
> +#elif defined(CONFIG_SOC_AU1550)
> +	MAC_RES(AU1550_ETH1_BASE, AU1550_MAC1_ENABLE, AU1550_MAC1_DMA_INT),
> +#elif defined(CONFIG_SOC_AU1500)
> +	MAC_RES(AU1500_ETH1_BASE, AU1500_MAC1_ENABLE, AU1500_MAC1_DMA_INT),
> +#endif
> +};
> +
> +static struct au1000_eth_platform_data au1xxx_eth0_platform_data = {
> +	.phy1_search_mac0 = 1,
> +};
> +
> +static struct platform_device au1xxx_eth0_device = {
> +	.name		= "au1000-eth",
> +	.id		= 0,
> +	.num_resources	= ARRAY_SIZE(au1xxx_eth0_resources),
> +	.resource	= au1xxx_eth0_resources,
> +	.dev.platform_data = &au1xxx_eth0_platform_data,
> +};
> +
> +#ifndef CONFIG_SOC_AU1100
> +static struct platform_device au1xxx_eth1_device = {
> +	.name		= "au1000-eth",
> +	.id		= 1,
> +	.num_resources	= ARRAY_SIZE(au1xxx_eth1_resources),
> +	.resource	= au1xxx_eth1_resources,
> +};
> +#endif
> +
> +void __init au1xxx_override_eth0_cfg(struct au1000_eth_platform_data
> *eth_data) +{
> +	if (!eth_data)
> +		return;
> +
> +	memcpy(&au1xxx_eth0_platform_data, eth_data,
> +		sizeof(struct au1000_eth_platform_data));
> +}
> +
>  static struct platform_device *au1xxx_platform_devices[] __initdata = {
>  	&au1xx0_uart_device,
>  	&au1xxx_usb_ohci_device,
> @@ -351,17 +422,25 @@ static struct platform_device
> *au1xxx_platform_devices[] __initdata = { #ifdef SMBUS_PSC_BASE
>  	&pbdb_smbus_device,
>  #endif
> +	&au1xxx_eth0_device,
>  };
>
>  static int __init au1xxx_platform_init(void)
>  {
>  	unsigned int uartclk = get_au1x00_uart_baud_base() * 16;
> -	int i;
> +	int i, ni;
>
>  	/* Fill up uartclk. */
>  	for (i = 0; au1x00_uart_data[i].flags; i++)
>  		au1x00_uart_data[i].uartclk = uartclk;
>
> +	/* Register second MAC if enabled in pinfunc */
> +#ifndef CONFIG_SOC_AU1100
> +	ni = (int)((au_readl(SYS_PINFUNC) & (u32)(SYS_PF_NI2)) >> 4);
> +	if (!(ni + 1))
> +		platform_device_register(&au1xxx_eth1_device);
> +#endif
> +
>  	return platform_add_devices(au1xxx_platform_devices,
>  				    ARRAY_SIZE(au1xxx_platform_devices));
>  }
> diff --git a/arch/mips/alchemy/devboards/db1x00/board_setup.c
> b/arch/mips/alchemy/devboards/db1x00/board_setup.c index de30d8e..4d2d32c
> 100644
> --- a/arch/mips/alchemy/devboards/db1x00/board_setup.c
> +++ b/arch/mips/alchemy/devboards/db1x00/board_setup.c
> @@ -32,6 +32,7 @@
>
>  #include <asm/mach-au1x00/au1000.h>
>  #include <asm/mach-db1x00/db1x00.h>
> +#include <asm/mach-au1x00/au1xxx_eth.h>
>
>  #include <prom.h>
>
> @@ -134,6 +135,22 @@ void __init board_setup(void)
>  	printk(KERN_INFO "AMD Alchemy Au1100/Db1100 Board\n");
>  #endif
>  #ifdef CONFIG_MIPS_BOSPORUS
> +	struct au1000_eth_platform_data eth0_pdata;
> +
> +	/*
> +	 * Micrel/Kendin 5 port switch attached to MAC0,
> +	 * MAC0 is associated with PHY address 5 (== WAN port)
> +	 * MAC1 is not associated with any PHY, since it's connected directly
> +	 * to the switch.
> +	 * no interrupts are used
> +	 */
> +	eth0_pdata.phy1_search_mac0 = 0;
> +	eth0_pdata.phy_static_config = 1;
> +	eth0_pdata.phy_addr = 5;
> +	eth0_pdata.phy_busid = 0;
> +
> +	au1xxx_override_eth0_cfg(&eth0_pdata);
> +
>  	printk(KERN_INFO "AMD Alchemy Bosporus Board\n");
>  #endif
>  #ifdef CONFIG_MIPS_MIRAGE
> diff --git a/arch/mips/include/asm/mach-au1x00/au1xxx_eth.h
> b/arch/mips/include/asm/mach-au1x00/au1xxx_eth.h new file mode 100644
> index 0000000..876187e
> --- /dev/null
> +++ b/arch/mips/include/asm/mach-au1x00/au1xxx_eth.h
> @@ -0,0 +1,17 @@
> +#ifndef __AU1X00_ETH_DATA_H
> +#define __AU1X00_ETH_DATA_H
> +
> +/* Platform specific PHY configuration passed to the MAC driver */
> +struct au1000_eth_platform_data {
> +	int phy_static_config;
> +	int phy_search_highest_addr;
> +	int phy1_search_mac0;
> +	int phy_addr;
> +	int phy_busid;
> +	int phy_irq;
> +};
> +
> +void __init au1xxx_override_eth0_cfg(struct au1000_eth_platform_data
> *eth_data); +
> +#endif /* __AU1X00_ETH_DATA_H */
> +



-- 
Best regards, Florian Fainelli
Email: florian@openwrt.org
Web: http://openwrt.org
IRC: [florian] on irc.freenode.net
-------------------------------
