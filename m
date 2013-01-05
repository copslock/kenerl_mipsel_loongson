Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Jan 2013 12:33:24 +0100 (CET)
Received: from mail-la0-f52.google.com ([209.85.215.52]:40794 "EHLO
        mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817387Ab3AELdXS0siT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 5 Jan 2013 12:33:23 +0100
Received: by mail-la0-f52.google.com with SMTP id fq12so11304854lab.11
        for <linux-mips@linux-mips.org>; Sat, 05 Jan 2013 03:33:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=9yJkSsmemYzbFv4p5d02ccZaO+1fsx1wgGqAaOpmCpM=;
        b=Ips29w5dz6cjMdmX5qSKw/ggs6zgS59iMCvNB49mZCKc2PPEotLAaIT0w5rYJrNyLt
         /Dfkh3wxK03lrdryc3+qKvWiYq1Hl1l1ghZIsmZZ1s7iGd6o/dktUHOFN+0Ou9CjxHWD
         khQ6tqvDHzHwN2FFX7fCPCjlo/MXSWZcp2Kyk4IhkvkcDnt0x/KE1uAAWpt6fV3fZXwJ
         HpSzK+b3dM878DrF84pkOzKlRMh7XkAREs9dx8j5v5vGKI8an8UPoMrfMSzBdpa+UAMk
         fTZUHF8BmV35nPMQdefoDpZCnxIbm4yFI3G8ScZblEUHwMl9p7+T2zKq9+t/kwcGSSAn
         n4sg==
X-Received: by 10.112.28.9 with SMTP id x9mr22385612lbg.27.1357385597645;
        Sat, 05 Jan 2013 03:33:17 -0800 (PST)
Received: from [192.168.2.2] (ppp91-79-72-139.pppoe.mtu-net.ru. [91.79.72.139])
        by mx.google.com with ESMTPS id sv4sm1769491lab.0.2013.01.05.03.33.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 Jan 2013 03:33:15 -0800 (PST)
Message-ID: <50E80F78.9030901@mvista.com>
Date:   Sat, 05 Jan 2013 15:33:12 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-Version: 1.0
To:     Arend van Spriel <arend@broadcom.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: Re: [PATCH] mips: bcm47xx: select GPIOLIB for BCMA on bcm47xx platform
References: <1357323005-28008-1-git-send-email-arend@broadcom.com>
In-Reply-To: <1357323005-28008-1-git-send-email-arend@broadcom.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQk9OuSIs4Gl7w597LsASKqhNMsUV3QSJQJH/pmka44i7iRmeJxokpFLaNCvRkqOGDyTG+3n
X-archive-position: 35379
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
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

Hello.

On 04-01-2013 22:10, Arend van Spriel wrote:

> The Kconfig items BCM47XX_BCMA and BCM47XX_SSB selected
> respectively BCMA_DRIVER_GPIO and SSB_DRIVER_GPIO. These
> options depend on GPIOLIB without explicitly selecting it
> so it results in a warning when GPIOLIB is not set:

> scripts/kconfig/conf --oldconfig Kconfig
> warning: (BCM47XX_BCMA) selects BCMA_DRIVER_GPIO ... unmet direct
> 	dependencies (BCMA_POSSIBLE && BCMA && GPIOLIB)
> warning: (BCM47XX_SSB) selects SSB_DRIVER_GPIO ... unmet direct
> 	dependencies (SSB_POSSIBLE && SSB && GPIOLIB)

> which subsequently results in compile errors.

> Cc: Hauke Mehrtens <hauke@hauke-m.de>
> Signed-off-by: Arend van Spriel <arend@broadcom.com>
> ---
> Fixing a Kconfig issue in our nightly Jenkins build.

> Gr. AvS
> ---
>   arch/mips/bcm47xx/Kconfig |    3 +++
>   1 file changed, 3 insertions(+)

> diff --git a/arch/mips/bcm47xx/Kconfig b/arch/mips/bcm47xx/Kconfig
> index d7af29f..ba61192 100644
> --- a/arch/mips/bcm47xx/Kconfig
> +++ b/arch/mips/bcm47xx/Kconfig
> @@ -8,8 +8,10 @@ config BCM47XX_SSB
>   	select SSB_DRIVER_EXTIF
>   	select SSB_EMBEDDED
>   	select SSB_B43_PCI_BRIDGE if PCI
> +	select SSB_DRIVER_PCICORE if PCI

    This change doesn';t seem to be documented in your changelog. Maybe it's 
worth another patch?

WBR, Sergei
