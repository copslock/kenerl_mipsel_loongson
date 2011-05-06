Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 May 2011 12:28:12 +0200 (CEST)
Received: from mail-ew0-f49.google.com ([209.85.215.49]:56015 "EHLO
        mail-ew0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491015Ab1EFK2H (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 May 2011 12:28:07 +0200
Received: by ewy3 with SMTP id 3so1034226ewy.36
        for <multiple recipients>; Fri, 06 May 2011 03:28:02 -0700 (PDT)
Received: by 10.14.17.6 with SMTP id i6mr1673015eei.51.1304677682110;
        Fri, 06 May 2011 03:28:02 -0700 (PDT)
Received: from [192.168.2.2] ([91.79.96.47])
        by mx.google.com with ESMTPS id e32sm1195003eee.5.2011.05.06.03.27.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 06 May 2011 03:27:57 -0700 (PDT)
Message-ID: <4DC3CCC9.4040002@mvista.com>
Date:   Fri, 06 May 2011 14:26:17 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-GB; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH V2 3/3] MIPS: lantiq: add dma/etop board support
References: <1304633402-24161-1-git-send-email-blogic@openwrt.org> <1304633402-24161-4-git-send-email-blogic@openwrt.org>
In-Reply-To: <1304633402-24161-4-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29839
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

On 06-05-2011 2:10, John Crispin wrote:

> This patch adds functions to register the etop and dma platform devices and
> calls them from the board specific setup code.

> Signed-off-by: John Crispin<blogic@openwrt.org>
> Signed-off-by: Ralph Hempel<ralph.hempel@lantiq.com>
> Cc: linux-mips@linux-mips.org
[...]

> diff --git a/arch/mips/lantiq/devices.c b/arch/mips/lantiq/devices.c
> index e758863..a10244e 100644
> --- a/arch/mips/lantiq/devices.c
> +++ b/arch/mips/lantiq/devices.c
> @@ -31,6 +31,19 @@
>   #define IRQ_RES(resname, irq) \
>   	{.name = #resname, .start = (irq), .flags = IORESOURCE_IRQ}
>
> +/* dma engine */
> +static struct resource ltq_dma_resource = {
> +	.name	= "dma",
> +	.start	= LTQ_DMA_BASE_ADDR,
> +	.end	= LTQ_DMA_BASE_ADDR + LTQ_DMA_SIZE - 1,
> +	.flags  = IORESOURCE_MEM,

    Spaces before = instead of tab here.

> diff --git a/arch/mips/lantiq/xway/devices.c b/arch/mips/lantiq/xway/devices.c
> index 7d58ae5..99ff2ef 100644
> --- a/arch/mips/lantiq/xway/devices.c
> +++ b/arch/mips/lantiq/xway/devices.c
> @@ -75,3 +75,30 @@ void __init ltq_register_gpio_stp(void)
>   {
>   	platform_device_register_simple("ltq_stp", 0,&ltq_stp_resource, 1);
>   }
> +
> +/* ethernet */
> +static struct resource ltq_ethernet_resources = {
> +	.name   = "etop",
> +	.start  = LTQ_ETOP_BASE_ADDR,
> +	.end    = LTQ_ETOP_BASE_ADDR + LTQ_ETOP_SIZE - 1,
> +	.flags  = IORESOURCE_MEM,

    It's better to use tabs, not spaces between the filed names and =, like 
above...

> +};
> +
> +static struct platform_device ltq_ethernet = {
> +	.name = "ltq_etop",
> +	.resource =&ltq_ethernet_resources,
> +	.num_resources  = 1,

    Too many spaces?

> +};
> +
> +void __init
> +ltq_register_ethernet(struct ltq_eth_data *eth)
> +{
> +	if (!eth)
> +		return;
> +	if (!is_valid_ether_addr(eth->mac.sa_data)) {
> +		pr_warn("etop: invalid MAC, using random\n");
> +		random_ether_addr(eth->mac.sa_data);
> +	}

    Why not do it in the driver?

> +	ltq_ethernet.dev.platform_data = eth;
> +	platform_device_register(&ltq_ethernet);
> +}
[...]
> diff --git a/arch/mips/lantiq/xway/mach-easy50712.c b/arch/mips/lantiq/xway/mach-easy50712.c
> index 5242a27..a001761 100644
> --- a/arch/mips/lantiq/xway/mach-easy50712.c
> +++ b/arch/mips/lantiq/xway/mach-easy50712.c
> @@ -59,13 +59,19 @@ static struct ltq_pci_data ltq_pci_data = {
>   	},
>   };
>
> +static struct ltq_eth_data ltq_eth_data = {
> +	.mii_mode = PHY_INTERFACE_MODE_MII,
> +};
> +
>   static void __init easy50712_init(void)
>   {
> +	ltq_register_dma();
>   	ltq_register_gpio();
>   	ltq_register_gpio_stp();
>   	ltq_register_nor(&easy50712_flash_data);
>   	ltq_register_wdt();
>   	ltq_register_pci(&ltq_pci_data);
> +	ltq_register_ethernet(&ltq_eth_data);
>   }
>
>   MIPS_MACHINE(LTQ_MACH_EASY50712,

    I'd put the board code in a sperate patch...

WBR, Sergei
