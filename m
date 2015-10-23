Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Oct 2015 23:09:20 +0200 (CEST)
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35240 "EHLO
        mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010009AbbJWVJSjsDmI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Oct 2015 23:09:18 +0200
Received: by pasz6 with SMTP id z6so127662869pas.2;
        Fri, 23 Oct 2015 14:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Etu24/+hFTQ9Z59H2t9+lhpBBBcweskWjy+5A2VYnuk=;
        b=W5Ugit+2323o/zJWgC575YehGB4VUdZ8zmZ+FPcnyQcTGwdyzbnLFOmO8CVkTIpwNj
         AgL2CS8QsnyxDvfbAbQ/geb/xvBHRyKYq2m6x5qflyOSkC2pXZo4bgevpcy4OhCdA7jJ
         HnHlMbFc3s7oQ2dU6QPoBhgkcecdvSWxPskXWI1vmwk6PDWNvBMi6UAaOO2BJYn5aIcx
         zx91yv9fBbdDBvVCo+yKRpKAMAngPqjKqr6yqI8AWyUNxSQqIRne8+OTi+o/Xe0RnrP/
         BNzzX9L1koEnAFu9tUDcwzXcIKlg6d32Qt+oSbHbebZGURHFhBLT0GfS8GWVlYEbB9m3
         z3sg==
X-Received: by 10.66.254.197 with SMTP id ak5mr18386846pad.130.1445634552577;
        Fri, 23 Oct 2015 14:09:12 -0700 (PDT)
Received: from google.com ([2620:0:1000:1301:2c06:ba91:afc7:e14d])
        by smtp.gmail.com with ESMTPSA id ir4sm20564024pbb.93.2015.10.23.14.09.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 23 Oct 2015 14:09:11 -0700 (PDT)
Date:   Fri, 23 Oct 2015 14:09:09 -0700
From:   Brian Norris <computersforpeace@gmail.com>
To:     Jaedon Shin <jaedon.shin@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 07/10] phy: phy_brcmstb_sata: add support 40nm platforms
Message-ID: <20151023210909.GP13239@google.com>
References: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com>
 <1445564663-66824-8-git-send-email-jaedon.shin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1445564663-66824-8-git-send-email-jaedon.shin@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <computersforpeace@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49668
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

On Fri, Oct 23, 2015 at 10:44:20AM +0900, Jaedon Shin wrote:
> Add offsets for 40nm BMIPS based set-top box platforms.
> 
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
> ---
>  drivers/phy/phy-brcmstb-sata.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/phy/phy-brcmstb-sata.c b/drivers/phy/phy-brcmstb-sata.c
> index 41c7535d706b..1cc80743b1b6 100644
> --- a/drivers/phy/phy-brcmstb-sata.c
> +++ b/drivers/phy/phy-brcmstb-sata.c
> @@ -30,7 +30,8 @@
>  #define MAX_PORTS					2
>  
>  /* Register offset between PHYs in PCB space */
> -#define SATA_MDIO_REG_SPACE_SIZE			0x1000
> +#define SATA_MDIO_REG_28NM_SPACE_SIZE			0x1000
> +#define SATA_MDIO_REG_40NM_SPACE_SIZE			0x10

Hmm, I thought there were other differences than just the offsets
between ports when rev'ing from 40nm to 28nm. But revisiting the only
documentation I have [1], this looks OK. I'd recommend double checking
the other registers, even if they're currently unused though.

>  
>  struct brcm_sata_port {
>  	int portnum;
> @@ -47,7 +48,7 @@ struct brcm_sata_phy {
>  	struct brcm_sata_port phys[MAX_PORTS];
>  };
>  
> -enum sata_mdio_phy_regs_28nm {
> +enum sata_mdio_phy_regs {
>  	PLL_REG_BANK_0				= 0x50,
>  	PLL_REG_BANK_0_PLLCONTROL_0		= 0x81,
>  
> @@ -85,7 +86,7 @@ static void brcm_sata_mdio_wr(void __iomem *addr, u32 bank, u32 ofs,
>  #define FMAX_VAL_DEFAULT	0x3df
>  #define FMAX_VAL_SSC		0x83
>  
> -static void brcm_sata_cfg_ssc_28nm(struct brcm_sata_port *port)
> +static void brcm_sata_cfg_ssc(struct brcm_sata_port *port)
>  {
>  	void __iomem *base = brcm_sata_phy_base(port);
>  	struct brcm_sata_phy *priv = port->phy_priv;
> @@ -116,19 +117,25 @@ static int brcm_sata_phy_init(struct phy *phy)
>  {
>  	struct brcm_sata_port *port = phy_get_drvdata(phy);
>  
> -	brcm_sata_cfg_ssc_28nm(port);
> +	brcm_sata_cfg_ssc(port);
>  
>  	return 0;
>  }
>  
> -static const struct phy_ops phy_ops_28nm = {
> +static const struct phy_ops phy_ops = {
>  	.init		= brcm_sata_phy_init,
>  	.owner		= THIS_MODULE,
>  };
>  
>  static const struct of_device_id brcm_sata_phy_of_match[] = {
>  	{ .compatible	= "brcm,bcm7445-sata-phy",
> -			.data = (void *)SATA_MDIO_REG_SPACE_SIZE },
> +			.data = (void *)SATA_MDIO_REG_28NM_SPACE_SIZE },
> +	{ .compatible   = "brcm,bcm7346-sata-phy",
> +			.data = (void *)SATA_MDIO_REG_40NM_SPACE_SIZE },
> +	{ .compatible   = "brcm,bcm7360-sata-phy",
> +			.data = (void *)SATA_MDIO_REG_40NM_SPACE_SIZE },
> +	{ .compatible   = "brcm,bcm7362-sata-phy",
> +			.data = (void *)SATA_MDIO_REG_40NM_SPACE_SIZE },

Like Florian suggested, this should probably be consolidated to the
first SoC that had this core on it. I think bcm7425, but I could be
wrong.

>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, brcm_sata_phy_of_match);
> @@ -185,7 +192,7 @@ static int brcm_sata_phy_probe(struct platform_device *pdev)
>  		port = &priv->phys[id];
>  		port->portnum = id;
>  		port->phy_priv = priv;
> -		port->phy = devm_phy_create(dev, child, &phy_ops_28nm);
> +		port->phy = devm_phy_create(dev, child, &phy_ops);
>  		port->ssc_en = of_property_read_bool(child, "brcm,enable-ssc");
>  		if (IS_ERR(port->phy)) {
>  			dev_err(dev, "failed to create PHY\n");
> -- 
> 2.6.2
> 

With that:

Reviewed-by: Brian Norris <computersforpeace@gmail.com>

[1] https://github.com/Broadcom/stblinux-3.8/blob/master/linux/drivers/ata/sata_brcmstb_phy.c
    https://github.com/Broadcom/stblinux-3.8/blob/master/linux/drivers/ata/sata_brcmstb.h
