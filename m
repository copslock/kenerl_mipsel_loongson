Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 Nov 2014 13:16:24 +0100 (CET)
Received: from hauke-m.de ([5.39.93.123]:48027 "EHLO hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006659AbaKWMQVhLWfb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 23 Nov 2014 13:16:21 +0100
Received: from [192.168.178.21] (host-091-097-251-142.ewe-ip-backbone.de [91.97.251.142])
        by hauke-m.de (Postfix) with ESMTPSA id 04FBC20010;
        Sun, 23 Nov 2014 13:16:20 +0100 (CET)
Message-ID: <5471D014.9040709@hauke-m.de>
Date:   Sun, 23 Nov 2014 13:16:20 +0100
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kumar Gala <galak@codeaurora.org>,
        Paul Walmsley <paul@pwsan.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Sandeep Nair <sandeep_n@ti.com>
Subject: Re: [PATCH V2] MIPS: BCM47XX: Move NVRAM driver to the drivers/soc/
References: <1416736241-12723-1-git-send-email-zajec5@gmail.com>
In-Reply-To: <1416736241-12723-1-git-send-email-zajec5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44351
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

On 11/23/2014 10:50 AM, Rafał Miłecki wrote:
> After Broadcom switched from MIPS to ARM for their home routers we need
> to have NVRAM driver in some common place (not arch/mips/).
> We were thinking about putting it in bus directory, however there are
> two possible buses for MIPS: drivers/ssb/ and drivers/bcma/. So this
> won't fit there neither.
> This is why I would like to move this driver to the drivers/soc/
> 
> Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
> ---
> V2: Use drivers/soc/broadcom/ (instead of misc) and use -M for patch
> 
> I wasn't sure who to to/cc sending this patch. There isn't entry for
> drivers/soc/ in MAINTAINERS. I picked e-mails from the commit
> 3a6e08218f36baa9c49282ad2fe0dfbf001d8f23
> soc: Introduce drivers/soc place-holder for SOC specific drivers
> ---
>  arch/mips/Kconfig                                            |  1 +
>  arch/mips/bcm47xx/Makefile                                   |  2 +-
>  arch/mips/bcm47xx/board.c                                    |  2 +-
>  arch/mips/bcm47xx/setup.c                                    |  1 -
>  arch/mips/bcm47xx/sprom.c                                    |  1 -
>  arch/mips/bcm47xx/time.c                                     |  1 -
>  arch/mips/include/asm/mach-bcm47xx/bcm47xx.h                 |  1 +
>  drivers/bcma/driver_mips.c                                   |  2 +-
>  drivers/net/ethernet/broadcom/b44.c                          |  2 +-
>  drivers/net/ethernet/broadcom/bgmac.c                        |  2 +-
>  drivers/soc/Kconfig                                          |  1 +
>  drivers/soc/Makefile                                         |  1 +
>  drivers/soc/broadcom/Kconfig                                 | 12 ++++++++++++
>  drivers/soc/broadcom/Makefile                                |  1 +
>  .../bcm47xx/nvram.c => drivers/soc/broadcom/bcm47xx_nvram.c  |  4 +++-
>  drivers/ssb/driver_chipcommon_pmu.c                          |  2 +-
>  drivers/ssb/driver_mipscore.c                                |  2 +-
>  .../asm/mach-bcm47xx => include/linux}/bcm47xx_nvram.h       |  3 ---
>  18 files changed, 27 insertions(+), 14 deletions(-)
>  create mode 100644 drivers/soc/broadcom/Kconfig
>  create mode 100644 drivers/soc/broadcom/Makefile
>  rename arch/mips/bcm47xx/nvram.c => drivers/soc/broadcom/bcm47xx_nvram.c (98%)
>  rename {arch/mips/include/asm/mach-bcm47xx => include/linux}/bcm47xx_nvram.h (84%)
> 

....

> diff --git a/drivers/soc/broadcom/Kconfig b/drivers/soc/broadcom/Kconfig
> new file mode 100644
> index 0000000..4f1d498
> --- /dev/null
> +++ b/drivers/soc/broadcom/Kconfig
> @@ -0,0 +1,12 @@
> +#
> +# Broadcom SoC drivers
> +#
> +
> +config BCM47XX_NVRAM
> +	bool "Broadcom NVRAM driver"
> +	depends on BCM47XX || ARCH_BCM_5301X
> +	help
> +	  Broadcom home routers contain flash partition called "nvram" with all
> +	  important hardware configuration as well as some minor user setup.
> +	  It contains a text-like data representing name=value pairs.
> +	  This driver provides an easy way to get value of requested parameter.

You could also explicitly add that this "driver" does not drive any
hardware. I think your text already says so, but it could be that
someone does not understand this.

> diff --git a/arch/mips/include/asm/mach-bcm47xx/bcm47xx_nvram.h b/include/linux/bcm47xx_nvram.h
> similarity index 84%
> rename from arch/mips/include/asm/mach-bcm47xx/bcm47xx_nvram.h
> rename to include/linux/bcm47xx_nvram.h
> index ee59ffe..5ed6917 100644
> --- a/arch/mips/include/asm/mach-bcm47xx/bcm47xx_nvram.h
> +++ b/include/linux/bcm47xx_nvram.h
> @@ -1,7 +1,4 @@
>  /*
> - *  Copyright (C) 2005, Broadcom Corporation
> - *  Copyright (C) 2006, Felix Fietkau <nbd@openwrt.org>
> - *

Any reason for removing these copyright statements? I think that nothing
in this file is copyrightable, but I am not a lawyer and would not
remove these lines.

>   *  This program is free software; you can redistribute  it and/or modify it
>   *  under  the terms of  the GNU General  Public License as published by the
>   *  Free Software Foundation;  either version 2 of the  License, or (at your
> 
