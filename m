Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Aug 2009 14:48:38 +0200 (CEST)
Received: from mail-ew0-f225.google.com ([209.85.219.225]:33912 "EHLO
	mail-ew0-f225.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492366AbZH0Msb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 27 Aug 2009 14:48:31 +0200
Received: by ewy25 with SMTP id 25so1136183ewy.33
        for <multiple recipients>; Thu, 27 Aug 2009 05:48:25 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=PclOqaJ/QfH5TqUHk/9MQv1DYijLahHPQJxO2ixeolY=;
        b=tSYuJ/nacn+4X9v72JAKW35s8tDJDK0nW2IHaMNaMmoRrShAe16Ze4Emb59nViVL3W
         NN9ZVSEGpxaUvKb2pzacJp1wR/Hdae69C4vsKOz8XQfuRW6QW5Su39OU98oVrPpF8WG9
         6eVmMEgdGFojWtKOd6wI0l0Vo5yNZOzWI3V0A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ZOAXDHCJfdhaFDm+dNyJnOT9O2U/V5aLmeMPXtfHnMvZNU/ZI8CLET4IkdUvL4UqzP
         eUZehuI8M5Y7p/2gzjgP6wACLUmrKhcFfxN1XarDMz4LF7DGhxIYkX3qr+zatUNQPXgx
         YWB72tDL8Ri5OpXkBwQ48C8SAHwMzqzsq4l9M=
Received: by 10.211.154.18 with SMTP id g18mr279799ebo.70.1251376962764;
        Thu, 27 Aug 2009 05:42:42 -0700 (PDT)
Received: from florian.lab.openpattern.org (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id 23sm438786eya.35.2009.08.27.05.42.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 27 Aug 2009 05:42:40 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] alchemy: add au1000-eth platform device
Date:	Thu, 27 Aug 2009 14:42:34 +0200
User-Agent: KMail/1.9.9
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	Manuel Lauss <manuel.lauss@googlemail.com>,
	David Miller <davem@davemloft.net>, netdev@vger.kernel.org
References: <200908170105.38154.florian@openwrt.org> <200908181801.41602.florian@openwrt.org> <4A92D5D1.60009@ru.mvista.com>
In-Reply-To: <4A92D5D1.60009@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200908271442.36306.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23937
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hello,

Le Monday 24 August 2009 20:02:57 Sergei Shtylyov, vous avez écrit :
> Hello.
>
> Florian Fainelli wrote:
> >>>This patch adds the board code to register a per-board au1000-eth
> >>>platform device to be used wit the au1000-eth platform driver in a
> >>>subsequent patch. Note that the au1000-eth driver knows about the
> >>>default driver settings such that we do not need to pass any
> >>>platform_data informations in most cases except db1x00.
> >>
> >>    Sigh, NAK...
> >>    Please don't register the SoC device per board, do it in
> >>alchemy/common/platfrom.c and find a way to pass the board specific
> >>platform data from the board file there instead -- something like
> >>arch/arm/mach-davinci/usb.c does.
> >
> > Ok, like I promised, this was the per-board device registration. Do you
> > prefer something like this:
>
>     I certainly do, but still not in this incarnation... :-)
>
> > --
> > From fd75b7c7fa3c05c21122c43e43260d2785475a79 Mon Sep 17 00:00:00 2001
> > From: Florian Fainelli <florian@openwrt.org>
> > Date: Tue, 18 Aug 2009 17:53:21 +0200
> > Subject: [PATCH] alchemy: add au1000-eth platform device (v2)
> >
> > This patch makes the board code register the au1000-eth
> > platform device. The au1000-eth platform data can be
> > overriden with the au1xxx_override_eth0_cfg function
> > like it has to be done for the Bosporus board.
> >
> > Changes from v1:
> > - remove per-board platform.c file
> > - add an override function to pass custom eth0 platform_data PHY settings
> >
> > Signed-off-by: Florian Fainelli <florian@openwrt.org>
> > ---
> > diff --git a/arch/mips/alchemy/common/platform.c
> > b/arch/mips/alchemy/common/platform.c index 117f99f..559294a 100644
> > --- a/arch/mips/alchemy/common/platform.c
> > +++ b/arch/mips/alchemy/common/platform.c
> > @@ -19,6 +19,7 @@
> >  #include <asm/mach-au1x00/au1xxx.h>
> >  #include <asm/mach-au1x00/au1xxx_dbdma.h>
> >  #include <asm/mach-au1x00/au1100_mmc.h>
> > +#include <asm/mach-au1x00/au1xxx_eth.h>
> >
> >  #define PORT(_base, _irq)				\
> >  	{						\
> > @@ -331,6 +332,76 @@ static struct platform_device pbdb_smbus_device = {
> >  };
> >  #endif
> >
> > +/* Macro to help defining the Ethernet MAC resources */
> > +#define MAC_RES(_base, _enable, _irq)			\
> > +	{						\
> > +		.start	= CPHYSADDR(_base),		\
> > +		.end	= CPHYSADDR(_base + 0xffff),	\
> > +		.flags	= IORESOURCE_MEM,		\
> > +	},						\
> > +	{						\
> > +		.start	= CPHYSADDR(_enable),		\
> > +		.end	= CPHYSADDR(_enable + 0x3),	\
> > +		.flags	= IORESOURCE_MEM,		\
> > +	},						\
> > +	{						\
> > +		.start	= _irq,				\
> > +		.end	= _irq,				\
> > +		.flags	= IORESOURCE_IRQ		\
> > +	}
> > +
> > +static struct resource au1xxx_eth0_resources[] = {
> > +#if defined(CONFIG_SOC_AU1000)
> > +	MAC_RES(AU1000_ETH0_BASE, AU1000_MAC0_ENABLE, AU1000_MAC0_DMA_INT),
> > +#elif defined(CONFIG_SOC_AU1100)
> > +	MAC_RES(AU1100_ETH0_BASE, AU1100_MAC0_ENABLE, AU1100_MAC0_DMA_INT),
> > +#elif defined(CONFIG_SOC_AU1550)
> > +	MAC_RES(AU1550_ETH0_BASE, AU1550_MAC0_ENABLE, AU1550_MAC0_DMA_INT),
> > +#elif defined(CONFIG_SOC_AU1500)
> > +	MAC_RES(AU1500_ETH0_BASE, AU1500_MAC0_ENABLE, AU1500_MAC0_DMA_INT),
> > +#endif
> > +};
> > +
> > +static struct resource au1xxx_eth1_resources[] = {
> > +#if defined(CONFIG_SOC_AU1000)
> > +	MAC_RES(AU1000_ETH1_BASE, AU1000_MAC1_ENABLE, AU1000_MAC1_DMA_INT),
> > +#elif defined(CONFIG_SOC_AU1550)
> > +	MAC_RES(AU1550_ETH1_BASE, AU1550_MAC1_ENABLE, AU1550_MAC1_DMA_INT),
> > +#elif defined(CONFIG_SOC_AU1500)
> > +	MAC_RES(AU1500_ETH1_BASE, AU1500_MAC1_ENABLE, AU1500_MAC1_DMA_INT),
> > +#endif
> > +};
> > +
> > +static struct au1000_eth_platform_data au1xxx_eth0_platform_data = {
> > +	.phy1_search_mac0 = 1,
> > +};
>
>     I'm not sure that the default platfrom data is really a great idea...

Can you elaborate a bit more ? We actually need to make the Ethernet MAC driver aware of some PHY settings.

>
> > +#ifndef CONFIG_SOC_AU1100
> > +static struct platform_device au1xxx_eth1_device = {
> > +	.name		= "au1000-eth",
> > +	.id		= 1,
> > +	.num_resources	= ARRAY_SIZE(au1xxx_eth1_resources),
> > +	.resource	= au1xxx_eth1_resources,
>
>     And where's the platfrom data for the second Ethernet?

There is no need to, as the driver originally did not override any specific settings on the second MAC (afair).

>
> > +};
> > +#endif
> > +
> > +void __init au1xxx_override_eth0_cfg(struct au1000_eth_platform_data
> > *eth_data) +{
> > +	if (!eth_data)
> > +		return;
> > +
> > +	memcpy(&au1xxx_eth0_platform_data, eth_data,
> > +		sizeof(struct au1000_eth_platform_data));
>
>     Why not just set the pointer in au1xxx_eth0_device. And really, why not
> make the function more generic, with a prototype like:

For the same reasons as explained below, MAC1 did not need any specific change.

>
> void __init au1xxx_override_eth_cfg(unsigned port, struct
> 				    au1000_eth_platform_data *eth_data);
>
> > +}
> > +
> >  static struct platform_device *au1xxx_platform_devices[] __initdata = {
> >  	&au1xx0_uart_device,
> >  	&au1xxx_usb_ohci_device,
> > @@ -351,17 +422,25 @@ static struct platform_device
> > *au1xxx_platform_devices[] __initdata = { #ifdef SMBUS_PSC_BASE
> >  	&pbdb_smbus_device,
> >  #endif
> > +	&au1xxx_eth0_device,
> >  };
> >
> >  static int __init au1xxx_platform_init(void)
> >  {
> >  	unsigned int uartclk = get_au1x00_uart_baud_base() * 16;
> > -	int i;
> > +	int i, ni;
> >
> >  	/* Fill up uartclk. */
> >  	for (i = 0; au1x00_uart_data[i].flags; i++)
> >  		au1x00_uart_data[i].uartclk = uartclk;
> >
> > +	/* Register second MAC if enabled in pinfunc */
> > +#ifndef CONFIG_SOC_AU1100
> > +	ni = (int)((au_readl(SYS_PINFUNC) & (u32)(SYS_PF_NI2)) >> 4);
> > +	if (!(ni + 1))
>
>     Why so complex, and how can (ni + 1) ever be 0?! :-/

This is left-over debugging stub, I will rework it. About complexity, this line is taken directly from the au1000_eth driver.

>     Doesn't that field when 0 mean the pins configured for MAC1 and when 1
> -- for GPIO? Why not just:
>
> 	if (!(au_readl(SYS_PINFUNC) & SYS_PF_NI2))
>
> > +		platform_device_register(&au1xxx_eth1_device);
> > +#endif
> > +
>
> WBR, Sergei



-- 
Best regards, Florian Fainelli
Email: florian@openwrt.org
Web: http://openwrt.org
IRC: [florian] on irc.freenode.net
-------------------------------
