Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Oct 2009 18:51:16 +0200 (CEST)
Received: from gateway-1237.mvista.com ([206.112.117.35]:49555 "HELO
	imap.sh.mvista.com" rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org
	with SMTP id S1493582AbZJWQvI (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 23 Oct 2009 18:51:08 +0200
Received: from [192.168.11.189] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with SMTP
	id 3707A3EEB; Fri, 23 Oct 2009 09:50:50 -0700 (PDT)
Message-ID: <4AE1DEFD.4090902@ru.mvista.com>
Date:	Fri, 23 Oct 2009 20:51:09 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Florian Fainelli <florian@openwrt.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	Manuel Lauss <manuel.lauss@googlemail.com>,
	David Miller <davem@davemloft.net>, netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] alchemy: add au1000-eth platform device
References: <200908170105.38154.florian@openwrt.org> <4A969519.7010604@ru.mvista.com> <200908271655.11086.florian@openwrt.org> <200910171048.24962.florian@openwrt.org>
In-Reply-To: <200910171048.24962.florian@openwrt.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24469
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Florian Fainelli wrote:

> Please find below and updated version, hopefully addressing most if not all
> of your comments.

    Thanks. I still have some comments on the code testing the NI2 bit. :-)

> --
> From: Florian Fainelli <florian@openwrt.org>
> Subject: [PATCH 1/2] alchemy: add au1000-eth platform device (v3)
> 
> This patch makes the board code register the au1000-eth
> platform device. The au1000-eth platform data can be
> overriden with the au1xxx_override_eth_cfg function
> like it has to be done for the Bosporus board which uses
> a different MAC/PHY setup.
> 
> Changes from v2:
> - declared the au1000-eth second driver instance platform_data
> - made the override function generic and pass it the port number too
> 
> Changes from v1:
> - remove per-board platform.c file
> - add an override function to pass custom eth0 platform_data PHY settings
> 
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
> diff --git a/arch/mips/alchemy/common/platform.c b/arch/mips/alchemy/common/platform.c
> index 195e5b3..167b24e 100644
> --- a/arch/mips/alchemy/common/platform.c
> +++ b/arch/mips/alchemy/common/platform.c
[...]
>  static int __init au1xxx_platform_init(void)
> @@ -354,6 +438,12 @@ static int __init au1xxx_platform_init(void)
>  	for (i = 0; au1x00_uart_data[i].flags; i++)
>  		au1x00_uart_data[i].uartclk = uartclk;
>  
> +#ifndef CONFIG_SOC_AU1100
> +	/* Register second MAC if enabled in pinfunc */
> +	if (!(au_readl(SYS_PINFUNC) & (u32)(SYS_PF_NI2)) >> 4)

    Parens around SYS_PF_NI2 not needed. Shift not needed too.

> +		platform_device_register(&au1xxx_eth1_device);
> +#endif
> +
>  	return platform_add_devices(au1xxx_platform_devices,
>  				    ARRAY_SIZE(au1xxx_platform_devices));
>  }
> diff --git a/arch/mips/alchemy/devboards/db1x00/board_setup.c b/arch/mips/alchemy/devboards/db1x00/board_setup.c
> index 64eb26f..f938924 100644
> --- a/arch/mips/alchemy/devboards/db1x00/board_setup.c
> +++ b/arch/mips/alchemy/devboards/db1x00/board_setup.c
> @@ -32,6 +32,7 @@
>  #include <linux/interrupt.h>
>  
>  #include <asm/mach-au1x00/au1000.h>
> +#include <asm/mach-au1x00/au1xxx_eth.h>
>  #include <asm/mach-db1x00/db1x00.h>
>  #include <asm/mach-db1x00/bcsr.h>
>  
> @@ -101,6 +102,22 @@ void __init board_setup(void)
>  	printk(KERN_INFO "AMD Alchemy Au1100/Db1100 Board\n");
>  #endif
>  #ifdef CONFIG_MIPS_BOSPORUS
> +	struct au1000_eth_platform_data eth0_pdata;

    You can't declare data like that, amidst the code -- gcc will emit a 
warning which would be fatal with -Werror in Makefile. Do it inside a block 
instead.

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

    Why noyt have an initializer instead (and why not make eth0_data 
*static* too)?

WBR, Sergei
