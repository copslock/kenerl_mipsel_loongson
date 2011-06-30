Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jun 2011 10:27:27 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:35407 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491031Ab1F3I1T (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Jun 2011 10:27:19 +0200
Received: by mail-wy0-f177.google.com with SMTP id 23so1715320wyf.36
        for <linux-mips@linux-mips.org>; Thu, 30 Jun 2011 01:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        bh=KGMcGmTYN2tKIYEC/Ysw9Yi96P71adOOo5g5iSOL10M=;
        b=F2XDnRFcJ/t3puMXEJlRob1ML1Ap7Q7LtfUzBRyVsLJqrv8w52aRhyviQJxhTIjeff
         wQhlNqP69ginxTK2WJytanwQFZW3zz97bM3+gZn84Cp/lMD2VTXj/2rBa5s0QPN59UQO
         k7M58fAVRcE/MFgQwbgB92KkoAJ4XAZpohcHY=
Received: by 10.216.59.73 with SMTP id r51mr238665wec.45.1309422439382;
        Thu, 30 Jun 2011 01:27:19 -0700 (PDT)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by mx.google.com with ESMTPS id w62sm997269wec.42.2011.06.30.01.27.18
        (version=SSLv3 cipher=OTHER);
        Thu, 30 Jun 2011 01:27:18 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
To:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: Re: [RFC v3 12/13] bcm47xx: add support for bcma bus
Date:   Thu, 30 Jun 2011 10:31:30 +0200
User-Agent: KMail/1.13.6 (Linux/2.6.38-8-server; KDE/4.6.2; x86_64; ; )
Cc:     linux-wireless@vger.kernel.org, zajec5@gmail.com,
        linux-mips@linux-mips.org, mb@bu3sch.de, george@znau.edu.ua,
        arend@broadcom.com, b43-dev@lists.infradead.org,
        bernhardloos@googlemail.com, arnd@arndb.de,
        julian.calaby@gmail.com, sshtylyov@mvista.com
References: <1309385518-12097-1-git-send-email-hauke@hauke-m.de> <1309385518-12097-13-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1309385518-12097-13-git-send-email-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201106301031.30524.florian@openwrt.org>
X-archive-position: 30560
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 24712

On Thursday 30 June 2011 00:11:57 Hauke Mehrtens wrote:
> This patch add support for the bcma bus. Broadcom uses only Mips 74K
> CPUs on the new SoC and on the old ons using ssb bus there are no Mips
> 74K CPUs.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>  arch/mips/bcm47xx/Kconfig                    |   13 ++++++
>  arch/mips/bcm47xx/gpio.c                     |   22 +++++++++++
>  arch/mips/bcm47xx/nvram.c                    |   10 +++++
>  arch/mips/bcm47xx/serial.c                   |   29 ++++++++++++++
>  arch/mips/bcm47xx/setup.c                    |   53
> +++++++++++++++++++++++++- arch/mips/bcm47xx/time.c                     | 
>   5 ++
>  arch/mips/include/asm/mach-bcm47xx/bcm47xx.h |    8 ++++
>  arch/mips/include/asm/mach-bcm47xx/gpio.h    |   41 ++++++++++++++++++++
>  drivers/watchdog/bcm47xx_wdt.c               |   11 +++++
>  9 files changed, 190 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/bcm47xx/Kconfig b/arch/mips/bcm47xx/Kconfig
> index 443d918..85ca1f5 100644
> --- a/arch/mips/bcm47xx/Kconfig
> +++ b/arch/mips/bcm47xx/Kconfig
> @@ -15,4 +15,17 @@ config BCM47XX_SSB
> 
>  	 This will generate an image with support for SSB and MIPS32 R2
> instruction set.
> 
> +config BCM47XX_BCMA
> +	bool "SSB Support for Broadcom BCM47XX"

and "BCMA support for Broadcom BCM47XX" here?
