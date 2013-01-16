Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jan 2013 10:47:17 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:55042 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823034Ab3APJrQriM8w (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Jan 2013 10:47:16 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id F1EC78F61;
        Wed, 16 Jan 2013 10:47:15 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pcC5qMX4gE7t; Wed, 16 Jan 2013 10:47:08 +0100 (CET)
Received: from [IPv6:2001:470:1f0b:447:a03b:8863:ffdb:a382] (unknown [IPv6:2001:470:1f0b:447:a03b:8863:ffdb:a382])
        by hauke-m.de (Postfix) with ESMTPSA id AB3628E1C;
        Wed, 16 Jan 2013 10:47:07 +0100 (CET)
Message-ID: <50F67719.5010005@hauke-m.de>
Date:   Wed, 16 Jan 2013 10:47:05 +0100
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
MIME-Version: 1.0
To:     Thierry Reding <thierry.reding@avionic-design.de>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Arend van Spriel <arend@broadcom.com>
Subject: Re: [PATCH] MIPS: bcm47xx: Fix BCMA build failure
References: <1358321286-8695-1-git-send-email-thierry.reding@avionic-design.de>
In-Reply-To: <1358321286-8695-1-git-send-email-thierry.reding@avionic-design.de>
X-Enigmail-Version: 1.4.6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 35459
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 01/16/2013 08:28 AM, Thierry Reding wrote:
> Enabling the BCMA driver automatically selects BCMA_DRIVER_GPIO, which
> in turn depends on GPIOLIB. GPIOLIB support is not enabled by default,
> however, so Kconfig complains about it:
> 
> 	warning: (BCM47XX_BCMA) selects BCMA_DRIVER_GPIO which has unmet direct dependencies (BCMA_POSSIBLE && BCMA && GPIOLIB)
> 	warning: (BCM47XX_SSB) selects SSB_DRIVER_GPIO which has unmet direct dependencies (SSB_POSSIBLE && SSB && GPIOLIB)
> 	warning: (BCM47XX_SSB) selects SSB_DRIVER_GPIO which has unmet direct dependencies (SSB_POSSIBLE && SSB && GPIOLIB)
> 	warning: (BCM47XX_BCMA) selects BCMA_DRIVER_GPIO which has unmet direct dependencies (BCMA_POSSIBLE && BCMA && GPIOLIB)
> 
> This patch fixes the issue by explicitly selecting GPIOLIB if
> BCM47XX_BCMA is enabled.
> 
> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>

Arend van Spriel already send a similar patch fixing this issue, but it
was not applied yet:
https://patchwork.linux-mips.org/patch/4759/

CONFIG_GPIOLIB should also be selected by CONFIG_BCM47XX_SSB.

> ---
>  arch/mips/bcm47xx/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/mips/bcm47xx/Kconfig b/arch/mips/bcm47xx/Kconfig
> index d7af29f..0f95b5e 100644
> --- a/arch/mips/bcm47xx/Kconfig
> +++ b/arch/mips/bcm47xx/Kconfig
> @@ -19,6 +19,7 @@ config BCM47XX_SSB
>  config BCM47XX_BCMA
>  	bool "BCMA Support for Broadcom BCM47XX"
>  	select SYS_HAS_CPU_MIPS32_R2
> +	select GPIOLIB
>  	select BCMA
>  	select BCMA_HOST_SOC
>  	select BCMA_DRIVER_MIPS
> 
