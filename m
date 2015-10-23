Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Oct 2015 23:09:50 +0200 (CEST)
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36716 "EHLO
        mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010009AbbJWVJsl0ziI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Oct 2015 23:09:48 +0200
Received: by pacfv9 with SMTP id fv9so133581436pac.3;
        Fri, 23 Oct 2015 14:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=1kc+tuohudKpg8Li8yQwIbKyrPx4V783UU8pNNKKh2U=;
        b=BN4k+81YnimuH5ZSjmKbQd16cQTCcPeabmx8E3XUXclmjAoKO+pO1QEWLWlc0ALDdo
         1fAftRiMyu3aDHkRqHksTHRaYk6NEsesc0qgwW3aJB0jPLTy9m05FZ+GzjZ3UXTo4ozM
         ZqVDHhz0aSlegYQ4ZAqHcGm3EtMUz8RfOli1gWa90ldEiaS0ORY2/W3Sk9xKt9oRSLkQ
         dgP37Vj+8ztl2PIHgSrmXGo5Hp6P3AGmNVLYDMS91jtFajsibAWOoKQaPzIDXgHdqCXR
         AW1HTMXsur0qaF10rQsFeUjgrAdag57DYP7K0Wc93Xa9ZIpXbvLenMfF9I5bap3vK0Wj
         Mskg==
X-Received: by 10.68.234.230 with SMTP id uh6mr7298326pbc.19.1445634582697;
        Fri, 23 Oct 2015 14:09:42 -0700 (PDT)
Received: from google.com ([2620:0:1000:1301:2c06:ba91:afc7:e14d])
        by smtp.gmail.com with ESMTPSA id ou1sm14845943pbc.7.2015.10.23.14.09.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 23 Oct 2015 14:09:42 -0700 (PDT)
Date:   Fri, 23 Oct 2015 14:09:40 -0700
From:   Brian Norris <computersforpeace@gmail.com>
To:     Jaedon Shin <jaedon.shin@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 06/10] phy: phy_brcmstb_sata: add data for phy offset
Message-ID: <20151023210940.GQ13239@google.com>
References: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com>
 <1445564663-66824-7-git-send-email-jaedon.shin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1445564663-66824-7-git-send-email-jaedon.shin@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <computersforpeace@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49669
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

On Fri, Oct 23, 2015 at 10:44:19AM +0900, Jaedon Shin wrote:
> Add data of device node for phy offset.
> 
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
> ---
>  drivers/phy/phy-brcmstb-sata.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/phy-brcmstb-sata.c b/drivers/phy/phy-brcmstb-sata.c
> index 0be55dafe9ea..41c7535d706b 100644
> --- a/drivers/phy/phy-brcmstb-sata.c
> +++ b/drivers/phy/phy-brcmstb-sata.c
> @@ -42,6 +42,7 @@ struct brcm_sata_port {
>  struct brcm_sata_phy {
>  	struct device *dev;
>  	void __iomem *phy_base;
> +	u32 phy_offset;
>  
>  	struct brcm_sata_port phys[MAX_PORTS];
>  };
> @@ -65,7 +66,7 @@ static inline void __iomem *brcm_sata_phy_base(struct brcm_sata_port *port)
>  {
>  	struct brcm_sata_phy *priv = port->phy_priv;
>  
> -	return priv->phy_base + (port->portnum * SATA_MDIO_REG_SPACE_SIZE);
> +	return priv->phy_base + (port->portnum * priv->phy_offset);
>  }
>  
>  static void brcm_sata_mdio_wr(void __iomem *addr, u32 bank, u32 ofs,
> @@ -126,7 +127,8 @@ static const struct phy_ops phy_ops_28nm = {
>  };
>  
>  static const struct of_device_id brcm_sata_phy_of_match[] = {
> -	{ .compatible	= "brcm,bcm7445-sata-phy" },
> +	{ .compatible	= "brcm,bcm7445-sata-phy",
> +			.data = (void *)SATA_MDIO_REG_SPACE_SIZE },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, brcm_sata_phy_of_match);
> @@ -135,6 +137,7 @@ static int brcm_sata_phy_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct device_node *dn = dev->of_node, *child;
> +	const struct of_device_id *of_id = NULL;

Drop the '= NULL', since it's unncessary. Then the compiler will
complain if you ever end up dereferencing it before (properly)
initializing it.

>  	struct brcm_sata_phy *priv;
>  	struct resource *res;
>  	struct phy_provider *provider;
> @@ -154,6 +157,12 @@ static int brcm_sata_phy_probe(struct platform_device *pdev)
>  	if (IS_ERR(priv->phy_base))
>  		return PTR_ERR(priv->phy_base);
>  
> +	of_id = of_match_node(brcm_sata_phy_of_match, dn);
> +	if (!of_id)
> +		return -EINVAL;
> +
> +	priv->phy_offset = (u32)of_id->data;

Using my mental compiler, I expect you'll get warnings on 64-bit systems
about casting from a pointer to an integer of different size. Using
uintptr_t would get around that. And if you wanted to be really clear
that you are purposely truncating, maybe an ugly double cast?

	priv->phy_offset = (u32)(uintptr_t)of_id->data;

With that:

Reviewed-by: Brian Norris <computersforpeace@gmail.com>

> +
>  	for_each_available_child_of_node(dn, child) {
>  		unsigned int id;
>  		struct brcm_sata_port *port;
> -- 
> 2.6.2
