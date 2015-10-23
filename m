Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Oct 2015 06:55:05 +0200 (CEST)
Received: from mail-ig0-f170.google.com ([209.85.213.170]:37808 "EHLO
        mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008345AbbJWEzDhF6dk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Oct 2015 06:55:03 +0200
Received: by igbhv6 with SMTP id hv6so8883275igb.0;
        Thu, 22 Oct 2015 21:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=jg0Wmmj6hurvaFd2d7KM9B4hnTxePriqE1tm1iO6LuU=;
        b=N8hiA/y27Pd8Gy+jRPNcXrBB2lfHQq0pZ6/TS9I5abQLnLXKt5lPIaKi/oElVwYSja
         BHFarLanuSmeIzf+Up4+k1llIXLtzoXgDsQXQjyn5rzMT1Mk+gS4I6PcFNy7y5WPtIB3
         riLemXuw2gZVQpmR6LlPMwvpUpZMlPrgXwU9om6PnzIk5jj+n17wx1A2yLauWwjSvWsn
         7hvSkEXnWn359GJtPLN89557YtkYa/E9uq2xg4JES5sitZD+KtNfmZm7Twn6q8yIEKgD
         I/vIkXD0TXGTPYzzQHEISRZ/Vw+kJkXH4652N2gCuhoWu1FMexCxtdyGHSdnmvJzuS3U
         4kIg==
X-Received: by 10.50.111.231 with SMTP id il7mr2311989igb.34.1445576098088;
 Thu, 22 Oct 2015 21:54:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.165 with HTTP; Thu, 22 Oct 2015 21:54:18 -0700 (PDT)
In-Reply-To: <1445564663-66824-3-git-send-email-jaedon.shin@gmail.com>
References: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com> <1445564663-66824-3-git-send-email-jaedon.shin@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Date:   Thu, 22 Oct 2015 21:54:18 -0700
Message-ID: <CAGVrzcbdMkTVVby9V2HnZpvYB9sdo_ti_=5AvoxFO=OBvwb42Q@mail.gmail.com>
Subject: Re: [PATCH 02/10] ata: ahch_brcmstb: add data for port offset
To:     Jaedon Shin <jaedon.shin@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>
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
X-archive-position: 49655
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
> Add data of device node for port offset.

Looks good to me, some minor nits below.

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
>         struct device *dev;
>         void __iomem *top_ctrl;
> +       u32 port_offset;
>         u32 port_mask;
>  };
>
> @@ -110,7 +111,7 @@ static inline void brcm_sata_writereg(u32 val, void __iomem *addr)
>  static void brcm_sata_phy_enable(struct brcm_ahci_priv *priv, int port)
>  {
>         void __iomem *phyctrl = priv->top_ctrl + SATA_TOP_CTRL_PHY_CTRL +
> -                               (port * SATA_TOP_CTRL_PHY_OFFS);
> +                               (port * priv->port_offset);
>         void __iomem *p;
>         u32 reg;
>
> @@ -139,7 +140,7 @@ static void brcm_sata_phy_enable(struct brcm_ahci_priv *priv, int port)
>  static void brcm_sata_phy_disable(struct brcm_ahci_priv *priv, int port)
>  {
>         void __iomem *phyctrl = priv->top_ctrl + SATA_TOP_CTRL_PHY_CTRL +
> -                               (port * SATA_TOP_CTRL_PHY_OFFS);
> +                               (port * priv->port_offset);
>         void __iomem *p;
>         u32 reg;
>
> @@ -234,6 +235,13 @@ static int brcm_ahci_resume(struct device *dev)
>  }
>  #endif
>
> +static const struct of_device_id ahci_of_match[] = {
> +       {.compatible = "brcm,bcm7445-ahci",
> +                       .data = (void *)SATA_TOP_CTRL_PHY_OFFS},

We could omit having to specify explicitly the offset here.

> +       {},
> +};
> +MODULE_DEVICE_TABLE(of, ahci_of_match);
> +
>  static struct scsi_host_template ahci_platform_sht = {
>         AHCI_SHT(DRV_NAME),
>  };
> @@ -241,6 +249,7 @@ static struct scsi_host_template ahci_platform_sht = {
>  static int brcm_ahci_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
> +       const struct of_device_id *of_id = NULL;
>         struct brcm_ahci_priv *priv;
>         struct ahci_host_priv *hpriv;
>         struct resource *res;
> @@ -256,6 +265,12 @@ static int brcm_ahci_probe(struct platform_device *pdev)
>         if (IS_ERR(priv->top_ctrl))
>                 return PTR_ERR(priv->top_ctrl);
>
> +       of_id = of_match_node(ahci_of_match, dev->of_node);
> +       if (!of_id)
> +               return -EINVAL;
> +
> +       priv->port_offset = (u32)of_id->data;

And if of_id->data is NULL here, just default to
SATA_TOP_CTRL_PHY_OFFS. But I have no strong preference.
