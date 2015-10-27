Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Oct 2015 09:18:06 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:44324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009692AbbJ0ISDyG9LA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 27 Oct 2015 09:18:03 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id CFBE62087B;
        Tue, 27 Oct 2015 08:18:01 +0000 (UTC)
Received: from mail-yk0-f170.google.com (mail-yk0-f170.google.com [209.85.160.170])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 639512086B;
        Tue, 27 Oct 2015 08:18:00 +0000 (UTC)
Received: by ykdr3 with SMTP id r3so210162616ykd.1;
        Tue, 27 Oct 2015 01:17:59 -0700 (PDT)
X-Received: by 10.129.51.196 with SMTP id z187mr28610713ywz.198.1445933879772;
 Tue, 27 Oct 2015 01:17:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.254.65 with HTTP; Tue, 27 Oct 2015 01:17:40 -0700 (PDT)
In-Reply-To: <1445928491-7320-4-git-send-email-jaedon.shin@gmail.com>
References: <1445928491-7320-1-git-send-email-jaedon.shin@gmail.com> <1445928491-7320-4-git-send-email-jaedon.shin@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 27 Oct 2015 03:17:40 -0500
Message-ID: <CAL_Jsq+GngRS80_T2joPZwOB3gGnHZuuaTzXn6Tc07exAq_Fag@mail.gmail.com>
Subject: Re: [v2 03/10] ata: ahci_brcmstb: add quick for broken phy
To:     Jaedon Shin <jaedon.shin@gmail.com>
Cc:     Brian Norris <computersforpeace@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Dragan Stancevic <dragan.stancevic@gmail.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <robh+dt@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49715
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh+dt@kernel.org
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

On Tue, Oct 27, 2015 at 1:48 AM, Jaedon Shin <jaedon.shin@gmail.com> wrote:
> Add quick for broken phy. The ARM-based 28nm chipsets have four phy

I believe you mean "quirk".

> interface control registers and each port has two registers. But, The

registers, but the...

> MIPS-based 40nm chipsets have three. and there are no information and

s/and there/There/

> documentation. The legacy version of broadcom's strict-ahci based
> initial code did not control these registers.
>
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
> ---
>  Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt |  1 +

Other than the commit message:

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/ata/ahci_brcmstb.c                                  | 10 ++++++++++
>  2 files changed, 11 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt b/Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt
> index 488a383ce202..0f0925d58188 100644
> --- a/Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt
> +++ b/Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt
> @@ -12,6 +12,7 @@ Required properties:
>
>  Optional properties:
>  - brcm,broken-ncq    : if present, NCQ is unusable
> +- brcm,broken-phy    : if present, to control phy interface is unusable
>
>  Also see ahci-platform.txt.
>
> diff --git a/drivers/ata/ahci_brcmstb.c b/drivers/ata/ahci_brcmstb.c
> index e53962cb48ee..c61303f7c7dc 100644
> --- a/drivers/ata/ahci_brcmstb.c
> +++ b/drivers/ata/ahci_brcmstb.c
> @@ -71,6 +71,7 @@
>
>  enum brcm_ahci_quicks {
>         BRCM_AHCI_QUICK_NONCQ           = BIT(0),
> +       BRCM_AHCI_QUICK_NOPHY           = BIT(1),
>  };
>
>  struct brcm_ahci_priv {
> @@ -119,6 +120,9 @@ static void brcm_sata_phy_enable(struct brcm_ahci_priv *priv, int port)
>         void __iomem *p;
>         u32 reg;
>
> +       if (priv->quicks & BRCM_AHCI_QUICK_NOPHY)
> +               return;
> +
>         /* clear PHY_DEFAULT_POWER_STATE */
>         p = phyctrl + SATA_TOP_CTRL_PHY_CTRL_1;
>         reg = brcm_sata_readreg(p);
> @@ -148,6 +152,9 @@ static void brcm_sata_phy_disable(struct brcm_ahci_priv *priv, int port)
>         void __iomem *p;
>         u32 reg;
>
> +       if (priv->quicks & BRCM_AHCI_QUICK_NOPHY)
> +               return;
> +
>         /* power-off the PHY digital logic */
>         p = phyctrl + SATA_TOP_CTRL_PHY_CTRL_2;
>         reg = brcm_sata_readreg(p);
> @@ -297,6 +304,9 @@ static int brcm_ahci_probe(struct platform_device *pdev)
>         if (of_property_read_bool(dev->of_node, "brcm,broken-ncq"))
>                 priv->quicks |= BRCM_AHCI_QUICK_NONCQ;
>
> +       if (of_property_read_bool(dev->of_node, "brcm,broken-phy"))
> +               priv->quicks |= BRCM_AHCI_QUICK_NOPHY;
> +
>         brcm_sata_init(priv);
>         brcm_sata_quick(pdev, priv);
>
> --
> 2.6.2
>
