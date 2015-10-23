Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Oct 2015 16:47:20 +0200 (CEST)
Received: from comal.ext.ti.com ([198.47.26.152]:33745 "EHLO comal.ext.ti.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011206AbbJWOrRc3XfZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 23 Oct 2015 16:47:17 +0200
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id t9NEl824013712;
        Fri, 23 Oct 2015 09:47:08 -0500
Received: from DFLE73.ent.ti.com (dfle73.ent.ti.com [128.247.5.110])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id t9NEl86c021789;
        Fri, 23 Oct 2015 09:47:08 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE73.ent.ti.com
 (128.247.5.110) with Microsoft SMTP Server id 14.3.224.2; Fri, 23 Oct 2015
 09:47:08 -0500
Received: from [10.247.27.30] (ileax41-snat.itg.ti.com [10.172.224.153])        by
 dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id t9NEl7A1010657;        Fri, 23 Oct
 2015 09:47:07 -0500
Subject: Re: [PATCH 04/10] phy: phy_brcmstb_sata: make the driver buildable on
 BMIPS_GENERIC
To:     Jaedon Shin <jaedon.shin@gmail.com>, Tejun Heo <tj@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
References: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com>
 <1445564663-66824-5-git-send-email-jaedon.shin@gmail.com>
CC:     <linux-ide@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <devicetree@vger.kernel.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <562A486B.5020500@ti.com>
Date:   Fri, 23 Oct 2015 20:17:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <1445564663-66824-5-git-send-email-jaedon.shin@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-Path: <kishon@ti.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49662
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kishon@ti.com
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

+Brian Norris

Hi,

On Friday 23 October 2015 07:14 AM, Jaedon Shin wrote:
> The BCM7xxx ARM and MIPS platforms share a similar hardware block for AHCI
> SATA3 PHY.
> 
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
> ---
>  drivers/phy/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index 47da573d0bab..c83e48661fd7 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -364,11 +364,11 @@ config PHY_TUSB1210
>  
>  config PHY_BRCMSTB_SATA
>  	tristate "Broadcom STB SATA PHY driver"
> -	depends on ARCH_BRCMSTB
> +	depends on ARCH_BRCMSTB || BMIPS_GENERIC

Nice to see the same driver is been used across multiple platforms.
Cc'ed Brian who is the author of brcmstb-sata.c

Thanks
Kishon
>  	depends on OF
>  	select GENERIC_PHY
>  	help
> -	  Enable this to support the SATA3 PHY on 28nm Broadcom STB SoCs.
> +	  Enable this to support the SATA3 PHY on 28nm or 40nm Broadcom STB SoCs.
>  	  Likely useful only with CONFIG_SATA_BRCMSTB enabled.
>  
>  endmenu
> 
