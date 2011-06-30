Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jun 2011 10:27:01 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:35407 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491023Ab1F3I06 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Jun 2011 10:26:58 +0200
Received: by wyf23 with SMTP id 23so1715320wyf.36
        for <linux-mips@linux-mips.org>; Thu, 30 Jun 2011 01:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        bh=QsonXrry24kLk3AYc71WeRs6f4rOdAjBpjzHqGuBaRA=;
        b=O1EDkVhYCguZXph5KXmkEFOCFuxu07RsJAzbX85c6FNu29nPCl/2z7DZ5XgCYH+YPl
         4c1T8/BUoAXDvUs8fj1+z2S9oj3vivb7Dl8+mvtI5nzxeHauZW2kRpY/3deZwNStuzwP
         BI4mPicJqiwMHJF5nSt35cmMpmd5cbKDBs6B8=
Received: by 10.216.231.165 with SMTP id l37mr1442419weq.78.1309422412448;
        Thu, 30 Jun 2011 01:26:52 -0700 (PDT)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by mx.google.com with ESMTPS id w58sm1000309weq.25.2011.06.30.01.26.50
        (version=SSLv3 cipher=OTHER);
        Thu, 30 Jun 2011 01:26:51 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
To:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: Re: [RFC v3 11/13] bcm47xx: make it possible to build bcm47xx without ssb.
Date:   Thu, 30 Jun 2011 10:31:03 +0200
User-Agent: KMail/1.13.6 (Linux/2.6.38-8-server; KDE/4.6.2; x86_64; ; )
Cc:     linux-wireless@vger.kernel.org, zajec5@gmail.com,
        linux-mips@linux-mips.org, mb@bu3sch.de, george@znau.edu.ua,
        arend@broadcom.com, b43-dev@lists.infradead.org,
        bernhardloos@googlemail.com, arnd@arndb.de,
        julian.calaby@gmail.com, sshtylyov@mvista.com
References: <1309385518-12097-1-git-send-email-hauke@hauke-m.de> <1309385518-12097-12-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1309385518-12097-12-git-send-email-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201106301031.03203.florian@openwrt.org>
X-archive-position: 30559
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 24711

Hello Hauke,

On Thursday 30 June 2011 00:11:56 Hauke Mehrtens wrote:
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>  arch/mips/Kconfig                            |    8 +-------
>  arch/mips/bcm47xx/Kconfig                    |   18 ++++++++++++++++++
>  arch/mips/bcm47xx/Makefile                   |    3 ++-
>  arch/mips/bcm47xx/gpio.c                     |    6 ++++++
>  arch/mips/bcm47xx/nvram.c                    |    4 ++++
>  arch/mips/bcm47xx/serial.c                   |    4 ++++
>  arch/mips/bcm47xx/setup.c                    |    8 ++++++++
>  arch/mips/bcm47xx/time.c                     |    2 ++
>  arch/mips/include/asm/mach-bcm47xx/bcm47xx.h |    4 ++++
>  arch/mips/include/asm/mach-bcm47xx/gpio.h    |   12 ++++++++++++
>  arch/mips/pci/pci-bcm47xx.c                  |    6 ++++++
>  drivers/watchdog/bcm47xx_wdt.c               |    4 ++++
>  12 files changed, 71 insertions(+), 8 deletions(-)
>  create mode 100644 arch/mips/bcm47xx/Kconfig
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 45f7aac..dcb3675 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -91,15 +91,8 @@ config BCM47XX
>  	select DMA_NONCOHERENT
>  	select HW_HAS_PCI
>  	select IRQ_CPU
> -	select SYS_HAS_CPU_MIPS32_R1
>  	select SYS_SUPPORTS_32BIT_KERNEL
>  	select SYS_SUPPORTS_LITTLE_ENDIAN
> -	select SSB
> -	select SSB_DRIVER_MIPS
> -	select SSB_DRIVER_EXTIF
> -	select SSB_EMBEDDED
> -	select SSB_B43_PCI_BRIDGE if PCI
> -	select SSB_PCICORE_HOSTMODE if PCI
>  	select GENERIC_GPIO
>  	select SYS_HAS_EARLY_PRINTK
>  	select CFE
> @@ -788,6 +781,7 @@ endchoice
> 
>  source "arch/mips/alchemy/Kconfig"
>  source "arch/mips/ath79/Kconfig"
> +source "arch/mips/bcm47xx/Kconfig"
>  source "arch/mips/bcm63xx/Kconfig"
>  source "arch/mips/jazz/Kconfig"
>  source "arch/mips/jz4740/Kconfig"
> diff --git a/arch/mips/bcm47xx/Kconfig b/arch/mips/bcm47xx/Kconfig
> new file mode 100644
> index 0000000..443d918
> --- /dev/null
> +++ b/arch/mips/bcm47xx/Kconfig
> @@ -0,0 +1,18 @@
> +if BCM47XX
> +
> +config BCM47XX_SSB
> +	bool "BCMA Support for Broadcom BCM47XX"

Should not this be:
"SSB support for Broadcom BCM47XX"?

> +	select SYS_HAS_CPU_MIPS32_R1
> +	select SSB
> +	select SSB_DRIVER_MIPS
> +	select SSB_DRIVER_EXTIF
> +	select SSB_EMBEDDED
> +	select SSB_B43_PCI_BRIDGE if PCI
> +	select SSB_PCICORE_HOSTMODE if PCI
> +	default y
> +	help
> +	 Add support for old Broadcom BCM47xx boards with Sonics Silicon
> Backplane support bus. +
> +	 This will generate an image with support for SSB and MIPS32 R2
> instruction set. +
> +endif
> diff --git a/arch/mips/bcm47xx/Makefile b/arch/mips/bcm47xx/Makefile
> index 7465e8a..4add173 100644
> --- a/arch/mips/bcm47xx/Makefile
> +++ b/arch/mips/bcm47xx/Makefile
> @@ -3,4 +3,5 @@
>  # under Linux.
>  #
