Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2014 17:56:51 +0100 (CET)
Received: from mail-pd0-f180.google.com ([209.85.192.180]:38665 "EHLO
        mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012156AbaJ2Q4sKbn6d (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2014 17:56:48 +0100
Received: by mail-pd0-f180.google.com with SMTP id ft15so3289592pdb.25
        for <multiple recipients>; Wed, 29 Oct 2014 09:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=3ujmXphCAO3He4y+QExGLGzL83iBNIVJLrbibioZ9Zc=;
        b=rUmnkMfF76xSXt8OJpjmRfBZljEjQcVffUclRJWDPwQy8YyaA0piTf4baIStvT8F5P
         letruUrNbpei9aFTL7QlUecfakDS0j+mgRGvS2Q/7xuQ39XjwFyA9x9se43X5RuB0dTZ
         vKh4obn7L0t+1FgtfgUjq81Yck0azCR+1xs20uTkBb/Ya/cOWtftw5n5RGsdCfbpJA0j
         uZ/LSczQn61Z70ZbCDSpQJvdvFnOHfSnAZoTwZpZPGHVIyBaO1Kvm6C4tzL/bq5IZJVE
         vlXFo2GmJYal0SrRye2qF7U1lhfid/+fKLWZ8l+ZSUgNwNCfhwBPoc5jeeQbVNFjFIyd
         ldMw==
X-Received: by 10.70.38.165 with SMTP id h5mr11378846pdk.121.1414601802068;
        Wed, 29 Oct 2014 09:56:42 -0700 (PDT)
Received: from [10.12.164.252] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id h3sm4030565pdl.22.2014.10.29.09.56.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Oct 2014 09:56:41 -0700 (PDT)
Message-ID: <54511C2E.50007@gmail.com>
Date:   Wed, 29 Oct 2014 09:56:14 -0700
From:   Florian Fainelli <f.fainelli@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Kevin Cernekee <cernekee@gmail.com>, tglx@linutronix.de,
        jason@lakedaemon.net, ralf@linux-mips.org
CC:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 11/11] irqchip: Decouple bcm7120-l2 from brcmstb-l2
References: <1414555138-6500-1-git-send-email-cernekee@gmail.com> <1414555138-6500-11-git-send-email-cernekee@gmail.com>
In-Reply-To: <1414555138-6500-11-git-send-email-cernekee@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43708
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

On 10/28/2014 08:58 PM, Kevin Cernekee wrote:
> Some chips, such as BCM6328, only require the former driver.  Some
> BCM7xxx STB configurations only require the latter driver.  Treat them
> as two separate entities, and update the mach-bcm dependencies to
> reflect the change.
> 
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

> ---
>  arch/arm/mach-bcm/Kconfig        | 1 +
>  drivers/irqchip/Kconfig          | 5 +++++
>  drivers/irqchip/Makefile         | 4 ++--
>  drivers/irqchip/irq-bcm7120-l2.c | 2 +-
>  4 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
> index 2abad74..bf47eb0 100644
> --- a/arch/arm/mach-bcm/Kconfig
> +++ b/arch/arm/mach-bcm/Kconfig
> @@ -125,6 +125,7 @@ config ARCH_BRCMSTB
>  	select HAVE_ARM_ARCH_TIMER
>  	select BRCMSTB_GISB_ARB
>  	select BRCMSTB_L2_IRQ
> +	select BCM7120_L2_IRQ
>  	help
>  	  Say Y if you intend to run the kernel on a Broadcom ARM-based STB
>  	  chipset.
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index 6a03c65..2d52b07 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -51,6 +51,11 @@ config ATMEL_AIC5_IRQ
>  	select MULTI_IRQ_HANDLER
>  	select SPARSE_IRQ
>  
> +config BCM7120_L2_IRQ
> +	bool
> +	select GENERIC_IRQ_CHIP
> +	select IRQ_DOMAIN
> +
>  config BRCMSTB_L2_IRQ
>  	bool
>  	select GENERIC_IRQ_CHIP
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index 173bb5f..f0909d0 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -35,6 +35,6 @@ obj-$(CONFIG_TB10X_IRQC)		+= irq-tb10x.o
>  obj-$(CONFIG_XTENSA)			+= irq-xtensa-pic.o
>  obj-$(CONFIG_XTENSA_MX)			+= irq-xtensa-mx.o
>  obj-$(CONFIG_IRQ_CROSSBAR)		+= irq-crossbar.o
> -obj-$(CONFIG_BRCMSTB_L2_IRQ)		+= irq-brcmstb-l2.o \
> -					   irq-bcm7120-l2.o
> +obj-$(CONFIG_BCM7120_L2_IRQ)		+= irq-bcm7120-l2.o
> +obj-$(CONFIG_BRCMSTB_L2_IRQ)		+= irq-brcmstb-l2.o
>  obj-$(CONFIG_KEYSTONE_IRQ)		+= irq-keystone.o
> diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l2.c
> index 734fece..91065b9 100644
> --- a/drivers/irqchip/irq-bcm7120-l2.c
> +++ b/drivers/irqchip/irq-bcm7120-l2.c
> @@ -247,5 +247,5 @@ out_unmap:
>  	kfree(data);
>  	return ret;
>  }
> -IRQCHIP_DECLARE(brcmstb_l2_intc, "brcm,bcm7120-l2-intc",
> +IRQCHIP_DECLARE(bcm7120_l2_intc, "brcm,bcm7120-l2-intc",
>  		bcm7120_l2_intc_of_init);
> 
