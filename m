Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Nov 2015 03:16:14 +0100 (CET)
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34996 "EHLO
        mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012869AbbKQCQMKtosE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Nov 2015 03:16:12 +0100
Received: by pacej9 with SMTP id ej9so87486179pac.2;
        Mon, 16 Nov 2015 18:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=H42PfSainDLZz1Z41KHN+I4et0IdaAeSe4gs/12nfpk=;
        b=oz3NB9kcrfqVuWoWqdveTiZU9G/QJLvk0HpfZebbW5zzbUIOLcFoMq0fvCr/bFjG/i
         e87q4bSa/eamUKXuiyCAqPpSlAW5TcJucuepvPnL4WLh23t/LSgaRHTZdMHcLFwzvuPL
         9tbcMV1IM9mX00p3bUbAQ70kKEKTlo3zvcWaQSQOxzXOyrSiWprqNiq6whzkAiGINIgw
         7p91adNYSYnfkiiecEBW1G9kV7lAtUx/3YRIYmjc7mT9B4j9sR6wksd9C1fB1uzri5hg
         EjPxFUcZf4oTa9TraIWjli6TXZ4WGMPcU7QvuU23gZNHiL3vku2ph2QNKjvmwFv2wUuK
         9oIQ==
X-Received: by 10.68.249.33 with SMTP id yr1mr59938924pbc.94.1447726565831;
        Mon, 16 Nov 2015 18:16:05 -0800 (PST)
Received: from google.com ([2620:0:1000:1301:64ae:171:73e1:bc49])
        by smtp.gmail.com with ESMTPSA id ir5sm39043894pbc.13.2015.11.16.18.16.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 16 Nov 2015 18:16:05 -0800 (PST)
Date:   Mon, 16 Nov 2015 18:16:03 -0800
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
Subject: Re: [v4 02/10] ata: ahci_brcmstb: add quirk for broken ncq
Message-ID: <20151117021603.GW8456@google.com>
References: <1446213684-2625-1-git-send-email-jaedon.shin@gmail.com>
 <1446213684-2625-3-git-send-email-jaedon.shin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1446213684-2625-3-git-send-email-jaedon.shin@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <computersforpeace@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49958
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

Hi,

On Fri, Oct 30, 2015 at 11:01:16PM +0900, Jaedon Shin wrote:
> Add quirk for broken ncq. Some chipsets (eg. BCM7349A0, BCM7445A0,
> BCM7445B0, and all 40nm chipsets including BCM7425) need a workaround
> disabling NCQ.
> 
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
> ---
>  drivers/ata/ahci_brcmstb.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/drivers/ata/ahci_brcmstb.c b/drivers/ata/ahci_brcmstb.c
> index 73e3b0b2a3c2..194aeda8f14d 100644
> --- a/drivers/ata/ahci_brcmstb.c
> +++ b/drivers/ata/ahci_brcmstb.c
> @@ -69,10 +69,15 @@
>  	(DATA_ENDIAN << DMADESC_ENDIAN_SHIFT) |		\
>  	(MMIO_ENDIAN << MMIO_ENDIAN_SHIFT))
>  
> +enum brcm_ahci_quirks {
> +	BRCM_AHCI_QUIRK_NONCQ		= BIT(0),
> +};
> +
>  struct brcm_ahci_priv {
>  	struct device *dev;
>  	void __iomem *top_ctrl;
>  	u32 port_mask;
> +	u32 quirks;
>  };
>  
>  static const struct ata_port_info ahci_brcm_port_info = {
> @@ -202,6 +207,42 @@ static u32 brcm_ahci_get_portmask(struct platform_device *pdev,
>  	return impl;
>  }
>  
> +static void brcm_sata_quirks(struct platform_device *pdev,
> +			     struct brcm_ahci_priv *priv)
> +{
> +	if (priv->quirks & BRCM_AHCI_QUIRK_NONCQ) {
> +		void __iomem *ctrl = priv->top_ctrl + SATA_TOP_CTRL_BUS_CTRL;
> +		void __iomem *ahci;
> +		struct resource *res;
> +		u32 reg;
> +
> +		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> +						   "ahci");
> +		ahci = devm_ioremap_resource(&pdev->dev, res);
> +		if (IS_ERR(ahci))
> +			return;
> +
> +		reg = brcm_sata_readreg(ctrl);
> +		reg |= OVERRIDE_HWINIT;
> +		brcm_sata_writereg(reg, ctrl);
> +
> +		/* Clear out the NCQ bit so the AHCI driver will not issue
> +		 * FPDMA/NCQ commands.
> +		 */
> +		reg = readl(ahci + HOST_CAP);
> +		reg &= ~HOST_CAP_NCQ;
> +		writel(reg, ahci + HOST_CAP);

You're using readl()/writel() to access the AHCI block, but...

> +
> +		reg = brcm_sata_readreg(ctrl);
> +		reg &= ~OVERRIDE_HWINIT;
> +		brcm_sata_writereg(reg, ctrl);
> +
> +		devm_iounmap(&pdev->dev, ahci);
> +		devm_release_mem_region(&pdev->dev, res->start,
> +					resource_size(res));
> +	}
> +}
> +
>  static void brcm_sata_init(struct brcm_ahci_priv *priv)
>  {
>  	/* Configure endianness */
> @@ -256,6 +297,11 @@ static int brcm_ahci_probe(struct platform_device *pdev)
>  	if (IS_ERR(priv->top_ctrl))
>  		return PTR_ERR(priv->top_ctrl);
>  
> +	if (of_device_is_compatible(dev->of_node, "brcm,bcm7425-ahci"))
> +		priv->quirks |= BRCM_AHCI_QUIRK_NONCQ;
> +
> +	brcm_sata_quirks(pdev, priv);
> +
>  	brcm_sata_init(priv);

...the MMIO endianness is only configured in brcm_sata_init(). You won't
see this problem on ARM LE, but you should on MIPS BE. Maybe
brcm_sata_quirks() should be after brcm_sata_init()?

>  
>  	priv->port_mask = brcm_ahci_get_portmask(pdev, priv);

Brian
