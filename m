Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Oct 2015 23:28:14 +0200 (CEST)
Received: from mail-pa0-f53.google.com ([209.85.220.53]:32840 "EHLO
        mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010009AbbJWV2Jzi6lr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Oct 2015 23:28:09 +0200
Received: by pabrc13 with SMTP id rc13so127850331pab.0;
        Fri, 23 Oct 2015 14:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=2tkr/1qXjx8ILZaB57Up7PvmX09th4i0SbEUrl2kKHA=;
        b=WKhp5jRKIEjRlFwNVRxXB83jID51Eo2pKwIFJ7jo+5VTbqVrUJnfSnyjFlqB/EIVFj
         X6AfpQVpxCAABLRTYhHBqJXEqaLBNbg1SSkUnHabTDmiRXDF1Whg1hG40Xtoub/eIxYg
         kAo7Xjd1HHxz7pd/6TfjFsx8l+07vkzxoGAJDkxiRASk86g04rBYFlv6kvTi1/RvdPDj
         Awwg7Mraf1tGr7oWcSZCLBqH/iC1rlnROT8qwV8+2kddLB6GQq0rV2iKYa+GxsXi1/V6
         jGaRrJKE3mpnHKfmsdlvsyByNoGMKchylFTYwZpQQ18958ay/isU4Fg3VMLhNuajzV3V
         uSJg==
X-Received: by 10.66.144.169 with SMTP id sn9mr6471642pab.15.1445635684125;
        Fri, 23 Oct 2015 14:28:04 -0700 (PDT)
Received: from google.com ([2620:0:1000:1301:2c06:ba91:afc7:e14d])
        by smtp.gmail.com with ESMTPSA id ju7sm4896658pbc.46.2015.10.23.14.28.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 23 Oct 2015 14:28:03 -0700 (PDT)
Date:   Fri, 23 Oct 2015 14:28:01 -0700
From:   Brian Norris <computersforpeace@gmail.com>
To:     Jaedon Shin <jaedon.shin@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 02/10] ata: ahch_brcmstb: add data for port offset
Message-ID: <20151023212801.GU13239@google.com>
References: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com>
 <1445564663-66824-3-git-send-email-jaedon.shin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1445564663-66824-3-git-send-email-jaedon.shin@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <computersforpeace@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49673
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

On Fri, Oct 23, 2015 at 10:44:15AM +0900, Jaedon Shin wrote:
> Add data of device node for port offset.
> 
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
> ---
>  drivers/ata/ahci_brcmstb.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/ata/ahci_brcmstb.c b/drivers/ata/ahci_brcmstb.c
> index 14b7305d2ba0..8cf6f7d4798f 100644
> --- a/drivers/ata/ahci_brcmstb.c
> +++ b/drivers/ata/ahci_brcmstb.c
> @@ -72,6 +72,7 @@
>  struct brcm_ahci_priv {
>  	struct device *dev;
>  	void __iomem *top_ctrl;
> +	u32 port_offset;

You're gonna need to vary more than just the port offset for 40nm vs.
28nm, I think. See my comments on patch 3.

Brian

>  	u32 port_mask;
>  };
>  
> @@ -110,7 +111,7 @@ static inline void brcm_sata_writereg(u32 val, void __iomem *addr)
>  static void brcm_sata_phy_enable(struct brcm_ahci_priv *priv, int port)
>  {
>  	void __iomem *phyctrl = priv->top_ctrl + SATA_TOP_CTRL_PHY_CTRL +
> -				(port * SATA_TOP_CTRL_PHY_OFFS);
> +				(port * priv->port_offset);
>  	void __iomem *p;
>  	u32 reg;
>  
> @@ -139,7 +140,7 @@ static void brcm_sata_phy_enable(struct brcm_ahci_priv *priv, int port)
>  static void brcm_sata_phy_disable(struct brcm_ahci_priv *priv, int port)
>  {
>  	void __iomem *phyctrl = priv->top_ctrl + SATA_TOP_CTRL_PHY_CTRL +
> -				(port * SATA_TOP_CTRL_PHY_OFFS);
> +				(port * priv->port_offset);
>  	void __iomem *p;
>  	u32 reg;
>  
> @@ -234,6 +235,13 @@ static int brcm_ahci_resume(struct device *dev)
>  }
>  #endif
>  
> +static const struct of_device_id ahci_of_match[] = {
> +	{.compatible = "brcm,bcm7445-ahci",
> +			.data = (void *)SATA_TOP_CTRL_PHY_OFFS},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, ahci_of_match);
> +
>  static struct scsi_host_template ahci_platform_sht = {
>  	AHCI_SHT(DRV_NAME),
>  };
> @@ -241,6 +249,7 @@ static struct scsi_host_template ahci_platform_sht = {
>  static int brcm_ahci_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> +	const struct of_device_id *of_id = NULL;
>  	struct brcm_ahci_priv *priv;
>  	struct ahci_host_priv *hpriv;
>  	struct resource *res;
> @@ -256,6 +265,12 @@ static int brcm_ahci_probe(struct platform_device *pdev)
>  	if (IS_ERR(priv->top_ctrl))
>  		return PTR_ERR(priv->top_ctrl);
>  
> +	of_id = of_match_node(ahci_of_match, dev->of_node);
> +	if (!of_id)
> +		return -EINVAL;
> +
> +	priv->port_offset = (u32)of_id->data;
> +
>  	brcm_sata_init(priv);
>  
>  	priv->port_mask = brcm_ahci_get_portmask(pdev, priv);
> @@ -299,12 +314,6 @@ static int brcm_ahci_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static const struct of_device_id ahci_of_match[] = {
> -	{.compatible = "brcm,bcm7445-ahci"},
> -	{},
> -};
> -MODULE_DEVICE_TABLE(of, ahci_of_match);
> -
>  static SIMPLE_DEV_PM_OPS(ahci_brcm_pm_ops, brcm_ahci_suspend, brcm_ahci_resume);
>  
>  static struct platform_driver brcm_ahci_driver = {
> -- 
> 2.6.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
