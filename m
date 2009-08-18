Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Aug 2009 16:55:24 +0200 (CEST)
Received: from h155.mvista.com ([63.81.120.155]:48211 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493047AbZHROzQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 18 Aug 2009 16:55:16 +0200
Received: from [192.168.11.189] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 3CC5B3ECA; Tue, 18 Aug 2009 07:55:12 -0700 (PDT)
Message-ID: <4A8AC125.3020602@ru.mvista.com>
Date:	Tue, 18 Aug 2009 18:56:37 +0400
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
References: <200908170105.38154.florian@openwrt.org>
In-Reply-To: <200908170105.38154.florian@openwrt.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23913
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Florian Fainelli wrote:

> This patch adds the board code to register a per-board au1000-eth
> platform device to be used wit the au1000-eth platform driver in a
> subsequent patch. Note that the au1000-eth driver knows about the
> default driver settings such that we do not need to pass any
> platform_data informations in most cases except db1x00.

    Sigh, NAK...
    Please don't register the SoC device per board, do it in 
alchemy/common/platfrom.c and find a way to pass the board specific platform 
data from the board file there instead -- something like 
arch/arm/mach-davinci/usb.c does.

> Signed-off-by: Florian Fainelli <florian@openwrt.org>

[...]

> diff --git a/arch/mips/include/asm/mach-au1x00/au1xxx_eth.h b/arch/mips/include/asm/mach-au1x00/au1xxx_eth.h
> new file mode 100644
> index 0000000..6d1543e
> --- /dev/null
> +++ b/arch/mips/include/asm/mach-au1x00/au1xxx_eth.h
> @@ -0,0 +1,33 @@
> +#ifndef __AU1X00_ETH_DATA_H
> +#define __AU1X00_ETH_DATA_H
> +
> +/* Macro to help defining the Ethernet MAC resources */
> +#define MAC_RES(_base, _enable, _irq)			\
> +	{						\
> +		.start	= CPHYSADDR(_base),		\
> +		.end	= CPHYSADDR(_base + 0xffff),	\
> +		.flags	= IORESOURCE_MEM,		\
> +	},						\
> +	{						\
> +		.start	= CPHYSADDR(_enable),		\
> +		.end	= CPHYSADDR(_enable + 0x4),	\

    s/4/3/.

WBR, Sergei
