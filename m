Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Mar 2010 11:34:27 +0100 (CET)
Received: from mail-bw0-f215.google.com ([209.85.218.215]:46963 "EHLO
        mail-bw0-f215.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491000Ab0CBKeW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Mar 2010 11:34:22 +0100
Received: by bwz7 with SMTP id 7so71660bwz.24
        for <multiple recipients>; Tue, 02 Mar 2010 02:34:17 -0800 (PST)
Received: by 10.204.4.139 with SMTP id 11mr4395227bkr.27.1267526057143;
        Tue, 02 Mar 2010 02:34:17 -0800 (PST)
Received: from ?192.168.2.2? (ppp91-77-213-207.pppoe.mtu-net.ru [91.77.213.207])
        by mx.google.com with ESMTPS id 15sm2688896bwz.8.2010.03.02.02.34.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Mar 2010 02:34:16 -0800 (PST)
Message-ID: <4B8CE98D.406@ru.mvista.com>
Date:   Tue, 02 Mar 2010 13:33:49 +0300
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
MIME-Version: 1.0
To:     Florian Fainelli <florian@openwrt.org>
CC:     ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 3/4] bcm63xx: add DWVS0 board
References: <201003012336.28071.florian@openwrt.org>
In-Reply-To: <201003012336.28071.florian@openwrt.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26085
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Florian Fainelli wrote:

> The DWVS0 board is a BCM6358-based board with an on-board OHCI controler.
>
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
> diff --git a/arch/mips/bcm63xx/boards/board_bcm963xx.c b/arch/mips/bcm63xx/boards/board_bcm963xx.c
> index 0b1d60f..8bf2c01 100644
> --- a/arch/mips/bcm63xx/boards/board_bcm963xx.c
> +++ b/arch/mips/bcm63xx/boards/board_bcm963xx.c
> @@ -567,6 +567,27 @@ static struct board_info __initdata board_AGPFS0 = {
>  	.has_ohci0 = 1,
>  	.has_ehci0 = 1,
>  };
> +
> +static struct board_info __initdata board_DWVS0 = {
> +	.name				= "DWV-S0",
> +	.expected_cpu_id		= 0x6358,
> +
> +	.has_enet0			= 1,
> +	.has_enet1			= 1,
> +	.has_pci			= 1,
> +
> +	.enet0 = {
> +		.has_phy		= 1,
> +		.use_internal_phy	= 1,
> +	},
> +
> +	.enet1 = {
> +		.force_speed_100	= 1,
> +		.force_duplex_full	= 1,
> +	},
> +
> +	.has_ohci0 = 1,
>   

   Why it's not aligned with the rest of initializers?

WBR, Sergei
