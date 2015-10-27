Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Oct 2015 17:35:13 +0100 (CET)
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36486 "EHLO
        mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011604AbbJ0QfLYkeF7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Oct 2015 17:35:11 +0100
Received: by pacfv9 with SMTP id fv9so237331957pac.3;
        Tue, 27 Oct 2015 09:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=VkBkfh0pPzuqvQOW5TO4QXjVycTgfLHopUccjPotOeg=;
        b=q2i0duWE053knJ8iu1mz1225eEN2xdL1U+BEAoqGXJP98X1PCpb6CaRdHDLlhtifXw
         b/flUORnINylboCniYF2VGU4SeOJBePN4sTMPDa+0LQJN1Rm4CrnBosLeAHMEa9fyNU0
         +o66uQiN61WS9FERHAIskDsaFKsB1TMWT1CereXwRs6LAtcHv2gRAEJDKxeUOKh1nwDW
         BZmBcVPfyGxmT+xSQqx5leerrmzlzICrIDJpBdyocac7hz3kMaDl0gKBY33BQTR8JBAQ
         N20bUXv/F5gvD7CeVytAhGBH+T8pZ4lwF6Qbej5knTVFao51jFD/G7EbjESIAjUN7rxj
         310Q==
X-Received: by 10.68.131.161 with SMTP id on1mr28968370pbb.144.1445963705449;
        Tue, 27 Oct 2015 09:35:05 -0700 (PDT)
Received: from google.com ([2620:0:1000:1301:69dc:8af3:1d71:215a])
        by smtp.gmail.com with ESMTPSA id q8sm40755321pap.34.2015.10.27.09.35.04
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 27 Oct 2015 09:35:04 -0700 (PDT)
Date:   Tue, 27 Oct 2015 09:35:03 -0700
From:   Brian Norris <computersforpeace@gmail.com>
To:     Jaedon Shin <jaedon.shin@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, Tejun Heo <tj@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Dragan Stancevic <dragan.stancevic@gmail.com>,
        linux-ide@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>,
        devicetree@vger.kernel.org
Subject: Re: [v2 02/10] ata: ahci_brcmstb: add support MIPS-based platforms
Message-ID: <20151027163503.GR13239@google.com>
References: <1445928491-7320-1-git-send-email-jaedon.shin@gmail.com>
 <1445928491-7320-3-git-send-email-jaedon.shin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1445928491-7320-3-git-send-email-jaedon.shin@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <computersforpeace@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49721
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: computersforpeace@gmail.com
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

On Tue, Oct 27, 2015 at 03:48:03PM +0900, Jaedon Shin wrote:
> The BCM7xxx ARM-based and MIPS-based platforms share a similar hardware
> block for AHCI SATA3.
> 
> The BCM7425 is flagship chipset of 40nm class. Other MIPS-based 40nm
> chipsets has same hardware block. so the compatible string may be use
> brcm,bcm7425-ahci.
> 
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
> ---
>  Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt | 4 ++--
>  drivers/ata/Kconfig                                         | 2 +-
>  drivers/ata/ahci_brcmstb.c                                  | 1 +
>  3 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt b/Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt
> index 4650c0aff6b3..488a383ce202 100644
> --- a/Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt
> +++ b/Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt
> @@ -4,8 +4,8 @@ SATA nodes are defined to describe on-chip Serial ATA controllers.
>  Each SATA controller should have its own node.
>  
>  Required properties:
> -- compatible         : compatible list, may contain "brcm,bcm7445-ahci" and/or
> -                       "brcm,sata3-ahci"
> +- compatible         : compatible list, may contain "brcm,bcm7445-ahci" or
> +                       "brcm,bcm7425-ahci" or "brcm,sata3-ahci"

If you're going to spin this series anyway, you might as well turn this
into a list, with one compatible string per line. That way it's easier
to expand if needed.

Brian

>  - reg                : register mappings for AHCI and SATA_TOP_CTRL
>  - reg-names          : "ahci" and "top-ctrl"
>  - interrupts         : interrupt mapping for SATA IRQ
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 15e40ee62a94..8f535a88a0c7 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -100,7 +100,7 @@ config SATA_AHCI_PLATFORM
>  
>  config AHCI_BRCMSTB
>  	tristate "Broadcom STB AHCI SATA support"
> -	depends on ARCH_BRCMSTB
> +	depends on ARCH_BRCMSTB || BMIPS_GENERIC
>  	help
>  	  This option enables support for the AHCI SATA3 controller found on
>  	  STB SoC's.
> diff --git a/drivers/ata/ahci_brcmstb.c b/drivers/ata/ahci_brcmstb.c
> index a2df76698adb..e53962cb48ee 100644
> --- a/drivers/ata/ahci_brcmstb.c
> +++ b/drivers/ata/ahci_brcmstb.c
> @@ -343,6 +343,7 @@ static int brcm_ahci_remove(struct platform_device *pdev)
>  
>  static const struct of_device_id ahci_of_match[] = {
>  	{.compatible = "brcm,bcm7445-ahci"},
> +	{.compatible = "brcm,bcm7425-ahci"},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, ahci_of_match);
> -- 
> 2.6.2
> 
