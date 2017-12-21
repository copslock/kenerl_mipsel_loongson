Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Dec 2017 17:42:35 +0100 (CET)
Received: from mx2.mailbox.org ([80.241.60.215]:54041 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991359AbdLUQm2JlpRE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 21 Dec 2017 17:42:28 +0100
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 8ED064D031;
        Thu, 21 Dec 2017 17:42:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id jQjiVqQ-oOJL; Thu, 21 Dec 2017 17:42:18 +0100 (CET)
Subject: Re: [PATCH v2] FIRMWARE: bcm47xx_nvram: Replace mac address parsing
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-mips@linux-mips.org,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
References: <20171221144055.3840-1-andriy.shevchenko@linux.intel.com>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <4671dc40-8c6e-2525-bed0-89e7844026a4@hauke-m.de>
Date:   Thu, 21 Dec 2017 17:42:16 +0100
MIME-Version: 1.0
In-Reply-To: <20171221144055.3840-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61543
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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



On 12/21/2017 03:40 PM, Andy Shevchenko wrote:
> Replace sscanf() with mac_pton().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Hauke Mehrtens <hauke@hauke-m.de>

The patch looks good, but I haven't tested them on my devices.

> ---
> - use negative condition to be consistent with the rest code
>  drivers/firmware/broadcom/Kconfig         |  1 +
>  drivers/firmware/broadcom/bcm47xx_sprom.c | 18 +++---------------
>  2 files changed, 4 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/firmware/broadcom/Kconfig b/drivers/firmware/broadcom/Kconfig
> index 5e29f83e7b39..c041dcb7ea52 100644
> --- a/drivers/firmware/broadcom/Kconfig
> +++ b/drivers/firmware/broadcom/Kconfig
> @@ -13,6 +13,7 @@ config BCM47XX_NVRAM
>  config BCM47XX_SPROM
>  	bool "Broadcom SPROM driver"
>  	depends on BCM47XX_NVRAM
> +	select GENERIC_NET_UTILS
>  	help
>  	  Broadcom devices store configuration data in SPROM. Accessing it is
>  	  specific to the bus host type, e.g. PCI(e) devices have it mapped in
> diff --git a/drivers/firmware/broadcom/bcm47xx_sprom.c b/drivers/firmware/broadcom/bcm47xx_sprom.c
> index 62aa3cf09b4d..4787f86c8ac1 100644
> --- a/drivers/firmware/broadcom/bcm47xx_sprom.c
> +++ b/drivers/firmware/broadcom/bcm47xx_sprom.c
> @@ -137,20 +137,6 @@ static void nvram_read_leddc(const char *prefix, const char *name,
>  	*leddc_off_time = (val >> 16) & 0xff;
>  }
>  
> -static void bcm47xx_nvram_parse_macaddr(char *buf, u8 macaddr[6])
> -{
> -	if (strchr(buf, ':'))
> -		sscanf(buf, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx", &macaddr[0],
> -			&macaddr[1], &macaddr[2], &macaddr[3], &macaddr[4],
> -			&macaddr[5]);
> -	else if (strchr(buf, '-'))
> -		sscanf(buf, "%hhx-%hhx-%hhx-%hhx-%hhx-%hhx", &macaddr[0],
> -			&macaddr[1], &macaddr[2], &macaddr[3], &macaddr[4],
> -			&macaddr[5]);
> -	else
> -		pr_warn("Can not parse mac address: %s\n", buf);
> -}
> -
>  static void nvram_read_macaddr(const char *prefix, const char *name,
>  			       u8 val[6], bool fallback)
>  {
> @@ -161,7 +147,9 @@ static void nvram_read_macaddr(const char *prefix, const char *name,
>  	if (err < 0)
>  		return;
>  
> -	bcm47xx_nvram_parse_macaddr(buf, val);
> +	strreplace(buf, '-', ':');
> +	if (!mac_pton(buf, val))
> +		pr_warn("Can not parse mac address: %s\n", buf);
>  }
>  
>  static void nvram_read_alpha2(const char *prefix, const char *name,
> 
