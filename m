Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Oct 2015 16:47:18 +0100 (CET)
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33969 "EHLO
        mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011586AbbJ0PrNVV0hh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Oct 2015 16:47:13 +0100
Received: by padhk11 with SMTP id hk11so226357107pad.1;
        Tue, 27 Oct 2015 08:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=mKJru3+bgyN96qEj93ZHpq5MEpuEu+1uhrnx+qPc85Y=;
        b=w3g2woF+aTwlV/yWTchhzpBrCbPHZD/vNAH7kdv6YirS5paTuR1odN843H1Jy7g7GI
         LFsj5k1FkLv3i+6aHp6G1KMFDOfmag+LsbctZklz+fZ5kt8VwGek0Xjt0SfO50ktbGsI
         ke/XwB7hoPoU+7mtBnB3hzeSTcIYPYRoOspyAwOEtzjT1jXGjz0Rgbtfx91pN1dy1Wqu
         Skzkj4WWz1W9qyIw+yp0aw0pJCFqIRrTp/dv+ZjX5naD0lJQDavLkzOeVG2xPMdTIFPp
         TYMZ2LeOzyypcBdW4Mv8Emj5K8BinR2jgEUNclJtit/DlyaZg1SHJOpaHP2GygfsA8kP
         46dQ==
X-Received: by 10.68.225.41 with SMTP id rh9mr29080069pbc.116.1445960826212;
        Tue, 27 Oct 2015 08:47:06 -0700 (PDT)
Received: from [10.12.156.244] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.googlemail.com with ESMTPSA id ju7sm24648681pbc.46.2015.10.27.08.47.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2015 08:47:05 -0700 (PDT)
Message-ID: <562F9C52.8060609@gmail.com>
Date:   Tue, 27 Oct 2015 08:46:26 -0700
From:   Florian Fainelli <f.fainelli@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.8.0
MIME-Version: 1.0
To:     Jaedon Shin <jaedon.shin@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Dragan Stancevic <dragan.stancevic@gmail.com>,
        linux-ide@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>,
        devicetree@vger.kernel.org
Subject: Re: [v2 01/10] ata: ahci_brcmstb: add quick for broken ncq
References: <1445928491-7320-1-git-send-email-jaedon.shin@gmail.com> <1445928491-7320-2-git-send-email-jaedon.shin@gmail.com>
In-Reply-To: <1445928491-7320-2-git-send-email-jaedon.shin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49719
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

On 26/10/15 23:48, Jaedon Shin wrote:
> Add quick for bronken ncq. The chipsets (eg. BCM7439A0, BCM7445A0 and
> BCM7445B0) need a workaround disabling NCQ. and it may need the
> MIPS-based set-top box platforms.

None of these chips are production chips, so at this point, disabling
NCQ should be done based on the compatible string we probed the driver
with, not using a specific property.

There are more comments below

> 
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
> ---

[snip]

>  
> +static void brcm_sata_quick(struct platform_device *pdev,
> +			    struct brcm_ahci_priv *priv)
> +{
> +	void __iomem *ahci;
> +	struct resource *res;
> +	u32 reg;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ahci");
> +	ahci = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(ahci))
> +		return;
> +
> +	if (priv->quicks & BRCM_AHCI_QUICK_NONCQ) {
> +		reg  = readl(priv->top_ctrl + SATA_TOP_CTRL_BUS_CTRL);
> +		reg |= OVERRIDE_HWINIT;
> +		writel(reg, priv->top_ctrl + SATA_TOP_CTRL_BUS_CTRL);
> +
> +		/* Clear out the NCQ bit so the AHCI driver will not issue
> +		 * FPDMA/NCQ commands.
> +		 */
> +		reg = readl(ahci + HOST_CAP);
> +		reg &= ~HOST_CAP_NCQ;
> +		writel(reg, ahci + HOST_CAP);
> +
> +		reg = readl(priv->top_ctrl + SATA_TOP_CTRL_BUS_CTRL);
> +		reg &= ~OVERRIDE_HWINIT;
> +		writel(reg, priv->top_ctrl + SATA_TOP_CTRL_BUS_CTRL);
> +	}

In the original BSP, the NCQ disabling occurs prior to initializing the
SATA controller endianess. We would want to keep doing that in the same
order, and use brcm_sata_readreg() and brcm_sata_writereg() which take
care of doing these accesses in the native endianess of the system.

Reference is here:

https://github.com/Broadcom/stblinux-3.3/blob/master/linux/drivers/brcmstb/bchip.c#L254

> +
> +	devm_iounmap(&pdev->dev, ahci);
> +	devm_release_mem_region(&pdev->dev, res->start, resource_size(res));
> +}
> +
>  #ifdef CONFIG_PM_SLEEP
>  static int brcm_ahci_suspend(struct device *dev)
>  {
> @@ -256,7 +294,11 @@ static int brcm_ahci_probe(struct platform_device *pdev)
>  	if (IS_ERR(priv->top_ctrl))
>  		return PTR_ERR(priv->top_ctrl);
>  
> +	if (of_property_read_bool(dev->of_node, "brcm,broken-ncq"))
> +		priv->quicks |= BRCM_AHCI_QUICK_NONCQ;
> +
>  	brcm_sata_init(priv);
> +	brcm_sata_quick(pdev, priv);
Florian
