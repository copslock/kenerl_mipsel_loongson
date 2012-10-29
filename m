Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Oct 2012 12:11:40 +0100 (CET)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:57770 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823426Ab2J2LLjBoWyc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 29 Oct 2012 12:11:39 +0100
Received: by mail-bk0-f49.google.com with SMTP id j4so1644876bkw.36
        for <multiple recipients>; Mon, 29 Oct 2012 04:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:organization:user-agent
         :in-reply-to:references:mime-version:content-transfer-encoding
         :content-type;
        bh=cBCugO0jcV6fQERlC9UtVfhBkDfwddjb3a0hfb92h20=;
        b=QwggkC458x33dOv2094CMSPuDt91w9PVDy80V5b6hg///DjF5ZuHjRlIpe6CKIUfQA
         42s3lXYWwau6Peuogjf47EUBNe1FsMMjAvvyuq4j2f8b1B5rRCLUaEKgrnfnjgAThOO7
         nWC/dq9tpcw5RL+XJyNCKlb12exPOzq/0xkRGJ5wWR7QAW/v2byBRmCNuhFGXad0xOcq
         bncP79YGkzNbcGfrfXEL5/JKBYbLt5gGOb1UTxo5qcYUOSh7xFS+Cto3xCPpTknSST7d
         SDj4NbuQq3JDbWnho49TvYfE1LhqpCo6DViySg5zCLlBOMRvMU2rpZGkQTM+JsfPGmMh
         zc8Q==
Received: by 10.204.5.215 with SMTP id 23mr9040340bkw.101.1351509093460;
        Mon, 29 Oct 2012 04:11:33 -0700 (PDT)
Received: from flexo.localnet (freebox.vlq16.iliad.fr. [213.36.7.13])
        by mx.google.com with ESMTPS id z13sm3625473bkv.8.2012.10.29.04.11.32
        (version=SSLv3 cipher=OTHER);
        Mon, 29 Oct 2012 04:11:32 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
To:     Jonas Gorski <jonas.gorski@gmail.com>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: Re: [PATCH] MIPS: BCM63XX: add and use a clock for PCIe
Date:   Mon, 29 Oct 2012 12:10:09 +0100
Message-ID: <1396016.7LyuGEyaiC@flexo>
Organization: OpenWrt
User-Agent: KMail/4.9.2 (Linux/3.5.0-17-generic; KDE/4.9.2; x86_64; ; )
In-Reply-To: <1351428593-13355-1-git-send-email-jonas.gorski@gmail.com>
References: <1351428593-13355-1-git-send-email-jonas.gorski@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-archive-position: 34788
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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

On Sunday 28 October 2012 13:49:53 Jonas Gorski wrote:
> Add a PCIe clock and use that instead of directly touching the clock
> control register. While at it, fail if there is no such clock.

Looks good, thanks Jonas.

Acked-by: Florian Fainelli <florian@openwrt.org>

> 
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> ---
>  arch/mips/bcm63xx/clk.c     |   15 +++++++++++++++
>  arch/mips/pci/pci-bcm63xx.c |   15 ++++++++++-----
>  2 files changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/mips/bcm63xx/clk.c b/arch/mips/bcm63xx/clk.c
> index dff79ab..89a5fb0 100644
> --- a/arch/mips/bcm63xx/clk.c
> +++ b/arch/mips/bcm63xx/clk.c
> @@ -253,6 +253,19 @@ static struct clk clk_ipsec = {
>  };
>  
>  /*
> + * PCIe clock
> + */
> +
> +static void pcie_set(struct clk *clk, int enable)
> +{
> +	bcm_hwclock_set(CKCTL_6328_PCIE_EN, enable);
> +}
> +
> +static struct clk clk_pcie = {
> +	.set	= pcie_set,
> +};
> +
> +/*
>   * Internal peripheral clock
>   */
>  static struct clk clk_periph = {
> @@ -313,6 +326,8 @@ struct clk *clk_get(struct device *dev, const char *id)
>  		return &clk_pcm;
>  	if (BCMCPU_IS_6368() && !strcmp(id, "ipsec"))
>  		return &clk_ipsec;
> +	if (BCMCPU_IS_6328() && !strcmp(id, "pcie"))
> +		return &clk_pcie;
>  	return ERR_PTR(-ENOENT);
>  }
>  
> diff --git a/arch/mips/pci/pci-bcm63xx.c b/arch/mips/pci/pci-bcm63xx.c
> index 8a48139..fa8c320 100644
> --- a/arch/mips/pci/pci-bcm63xx.c
> +++ b/arch/mips/pci/pci-bcm63xx.c
> @@ -11,6 +11,7 @@
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/delay.h>
> +#include <linux/clk.h>
>  #include <asm/bootinfo.h>
>  
>  #include "pci-bcm63xx.h"
> @@ -119,11 +120,6 @@ static void __init bcm63xx_reset_pcie(void)
>  {
>  	u32 val;
>  
> -	/* enable clock */
> -	val = bcm_perf_readl(PERF_CKCTL_REG);
> -	val |= CKCTL_6328_PCIE_EN;
> -	bcm_perf_writel(val, PERF_CKCTL_REG);
> -
>  	/* enable SERDES */
>  	val = bcm_misc_readl(MISC_SERDES_CTRL_REG);
>  	val |= SERDES_PCIE_EN | SERDES_PCIE_EXD_EN;
> @@ -150,10 +146,19 @@ static void __init bcm63xx_reset_pcie(void)
>  	mdelay(200);
>  }
>  
> +static struct clk *pcie_clk;
> +
>  static int __init bcm63xx_register_pcie(void)
>  {
>  	u32 val;
>  
> +	/* enable clock */
> +	pcie_clk = clk_get(NULL, "pcie");
> +	if (IS_ERR_OR_NULL(pcie_clk))
> +		return -ENODEV;
> +
> +	clk_prepare_enable(pcie_clk);
> +
>  	bcm63xx_reset_pcie();
>  
>  	/* configure the PCIe bridge */
> -- 
> 1.7.2.5
> 
