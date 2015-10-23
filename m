Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Oct 2015 07:06:50 +0200 (CEST)
Received: from mail-ig0-f180.google.com ([209.85.213.180]:34763 "EHLO
        mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008881AbbJWFGsi4Wrk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Oct 2015 07:06:48 +0200
Received: by igbni9 with SMTP id ni9so27964752igb.1;
        Thu, 22 Oct 2015 22:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=UzoTj763K1K7JqIQyeEfRHJkw9Y+faEg+N3ZwW7zMc4=;
        b=jYDy6gvvofFJ8+pn7Y8ZxC1vx7qDyg9R75/S7IJ6TG6WTsO9DtzWwZ4J/pg1Dhj6ZU
         EKD/sTqsW6HeBTvCHT1LPlFRB5SoAIuX+oB8WmzxxzHzfH9d7mV74N+eU3qMaeVkqpj9
         Q+Pk395usbSpwv+2ydiIkWbQp2g+9nn6VO0Zb+fjIE1Vxx0PVJlLlHvRrJ238S79/HY6
         jEi/0evQ8CSf+z/8+8F1l5hw1XGJX6aBorNRV1UQjo+4oF186xJjXYp8aU8QNBr+POWu
         Vj/btvNZWzeFKsEP6rR9x4Y73G14APukKtfFPHb8bR2iyAdhHDlUhjD5tdkhEUDMsRVf
         0zWg==
X-Received: by 10.50.43.162 with SMTP id x2mr2152853igl.82.1445576802599; Thu,
 22 Oct 2015 22:06:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.165 with HTTP; Thu, 22 Oct 2015 22:06:03 -0700 (PDT)
In-Reply-To: <1445564663-66824-8-git-send-email-jaedon.shin@gmail.com>
References: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com> <1445564663-66824-8-git-send-email-jaedon.shin@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Date:   Thu, 22 Oct 2015 22:06:03 -0700
Message-ID: <CAGVrzcaYPv3zyV8n6Wag-b5S34C30YU=dDnHpPr7eKuut7JEvg@mail.gmail.com>
Subject: Re: [PATCH 07/10] phy: phy_brcmstb_sata: add support 40nm platforms
To:     Jaedon Shin <jaedon.shin@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49660
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

2015-10-22 18:44 GMT-07:00 Jaedon Shin <jaedon.shin@gmail.com>:
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
>  #define MAX_PORTS                                      2
>
>  /* Register offset between PHYs in PCB space */
> -#define SATA_MDIO_REG_SPACE_SIZE                       0x1000
> +#define SATA_MDIO_REG_28NM_SPACE_SIZE                  0x1000
> +#define SATA_MDIO_REG_40NM_SPACE_SIZE                  0x10
>
>  struct brcm_sata_port {
>         int portnum;
> @@ -47,7 +48,7 @@ struct brcm_sata_phy {
>         struct brcm_sata_port phys[MAX_PORTS];
>  };
>
> -enum sata_mdio_phy_regs_28nm {
> +enum sata_mdio_phy_regs {
>         PLL_REG_BANK_0                          = 0x50,
>         PLL_REG_BANK_0_PLLCONTROL_0             = 0x81,
>
> @@ -85,7 +86,7 @@ static void brcm_sata_mdio_wr(void __iomem *addr, u32 bank, u32 ofs,
>  #define FMAX_VAL_DEFAULT       0x3df
>  #define FMAX_VAL_SSC           0x83
>
> -static void brcm_sata_cfg_ssc_28nm(struct brcm_sata_port *port)
> +static void brcm_sata_cfg_ssc(struct brcm_sata_port *port)
>  {
>         void __iomem *base = brcm_sata_phy_base(port);
>         struct brcm_sata_phy *priv = port->phy_priv;
> @@ -116,19 +117,25 @@ static int brcm_sata_phy_init(struct phy *phy)
>  {
>         struct brcm_sata_port *port = phy_get_drvdata(phy);
>
> -       brcm_sata_cfg_ssc_28nm(port);
> +       brcm_sata_cfg_ssc(port);
>
>         return 0;
>  }
>
> -static const struct phy_ops phy_ops_28nm = {
> +static const struct phy_ops phy_ops = {
>         .init           = brcm_sata_phy_init,
>         .owner          = THIS_MODULE,
>  };
>
>  static const struct of_device_id brcm_sata_phy_of_match[] = {
>         { .compatible   = "brcm,bcm7445-sata-phy",
> -                       .data = (void *)SATA_MDIO_REG_SPACE_SIZE },
> +                       .data = (void *)SATA_MDIO_REG_28NM_SPACE_SIZE },
> +       { .compatible   = "brcm,bcm7346-sata-phy",
> +                       .data = (void *)SATA_MDIO_REG_40NM_SPACE_SIZE },
> +       { .compatible   = "brcm,bcm7360-sata-phy",
> +                       .data = (void *)SATA_MDIO_REG_40NM_SPACE_SIZE },
> +       { .compatible   = "brcm,bcm7362-sata-phy",
> +                       .data = (void *)SATA_MDIO_REG_40NM_SPACE_SIZE },

Same comment as the AHCI portion, we need to update the Device Tree
binding document to make these new compatible strings documented
there.

Thank you!

>         {},
>  };
>  MODULE_DEVICE_TABLE(of, brcm_sata_phy_of_match);
> @@ -185,7 +192,7 @@ static int brcm_sata_phy_probe(struct platform_device *pdev)
>                 port = &priv->phys[id];
>                 port->portnum = id;
>                 port->phy_priv = priv;
> -               port->phy = devm_phy_create(dev, child, &phy_ops_28nm);
> +               port->phy = devm_phy_create(dev, child, &phy_ops);
>                 port->ssc_en = of_property_read_bool(child, "brcm,enable-ssc");
>                 if (IS_ERR(port->phy)) {
>                         dev_err(dev, "failed to create PHY\n");
> --
> 2.6.2
>



-- 
Florian
