Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jun 2011 10:16:06 +0200 (CEST)
Received: from smtp4-g21.free.fr ([212.27.42.4]:58859 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491055Ab1FOIQD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Jun 2011 10:16:03 +0200
Received: from bobafett.staff.proxad.net (unknown [213.228.1.121])
        by smtp4-g21.free.fr (Postfix) with ESMTP id ECAC04C8113;
        Wed, 15 Jun 2011 10:15:54 +0200 (CEST)
Received: from flexo.localnet (unknown [172.18.3.103])
        by bobafett.staff.proxad.net (Postfix) with ESMTPS id C8E19180602;
        Wed, 15 Jun 2011 10:15:53 +0200 (CEST)
From:   Florian Fainelli <ffainelli@freebox.fr>
Organization: Freebox
To:     Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] phylib: Allow BCM63XX PHY to be selected only on BCM63XX.
Date:   Wed, 15 Jun 2011 10:20:11 +0200
User-Agent: KMail/1.13.6 (Linux/2.6.38-8-server; KDE/4.6.2; x86_64; ; )
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-mips@linux-mips.org
References: <20110615080758.GA3226@linux-mips.org>
In-Reply-To: <20110615080758.GA3226@linux-mips.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201106151020.11904.ffainelli@freebox.fr>
X-archive-position: 30401
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ffainelli@freebox.fr
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 12172

On Wednesday 15 June 2011 10:07:58 Ralf Baechle wrote:
> This PHY is available integrated into BCM63xx series SOCs only.
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

Acked-by: Florian Fainelli <ffainelli@freebox.fr>

> 
>  drivers/net/phy/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
> index 392a6c4..a702443 100644
> --- a/drivers/net/phy/Kconfig
> +++ b/drivers/net/phy/Kconfig
> @@ -58,6 +58,7 @@ config BROADCOM_PHY
> 
>  config BCM63XX_PHY
>  	tristate "Drivers for Broadcom 63xx SOCs internal PHY"
> +	depends on BCM63XX
>  	---help---
>  	  Currently supports the 6348 and 6358 PHYs.
