Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Oct 2015 16:55:06 +0100 (CET)
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36183 "EHLO
        mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011384AbbJ0PzEqqabh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Oct 2015 16:55:04 +0100
Received: by pacfv9 with SMTP id fv9so236358944pac.3;
        Tue, 27 Oct 2015 08:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=e67tLHNZLnRUazc6SXh70DNIXv1LrHoKViNzu/u64OY=;
        b=dSH3z+MKORt5Fb2jZz61uzNsgpePuoV8E9tQ5hLPiPyVuRCI0HFMJa5549SITFBHtT
         WtrvZJoHLCupX5/auA8MnQiB1iYnxC1w3bc3q//wvqyDDMRX1F6wP/giZ5gYZyz5yNg4
         2P/0ArUErYczEaYI41Frr5Jdwpw6RSSkSAixEK4kForMMJ9Sin5zsRkTVLloGY/vwwaL
         tlJsP2ZSW5Godu0b9g4JpQVa8DJDr1WEfgxxV4Qr28S2/YO8BfUSYZcwPTkkGbJM+r+4
         xX+VqWr9w8/r5AmSy7oYq3k6N+n7Q8f5pqrk0eY7xdyb+z3BTjoAX7h5/iERr7HHIRWH
         tYKw==
X-Received: by 10.68.57.208 with SMTP id k16mr48773987pbq.12.1445961298653;
        Tue, 27 Oct 2015 08:54:58 -0700 (PDT)
Received: from [10.12.156.244] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.googlemail.com with ESMTPSA id xu5sm38139342pab.12.2015.10.27.08.54.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2015 08:54:58 -0700 (PDT)
Message-ID: <562F9E29.3060806@gmail.com>
Date:   Tue, 27 Oct 2015 08:54:17 -0700
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
Subject: Re: [v2 03/10] ata: ahci_brcmstb: add quick for broken phy
References: <1445928491-7320-1-git-send-email-jaedon.shin@gmail.com> <1445928491-7320-4-git-send-email-jaedon.shin@gmail.com>
In-Reply-To: <1445928491-7320-4-git-send-email-jaedon.shin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49720
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
> Add quick for broken phy. The ARM-based 28nm chipsets have four phy
> interface control registers and each port has two registers. But, The
> MIPS-based 40nm chipsets have three. and there are no information and
> documentation. The legacy version of broadcom's strict-ahci based
> initial code did not control these registers.

Qualifying this of a broken PHY is a misnomer, this is more about the
fact that the PHY control registers have a different layout and behavior
on 40nm vs 28nm chips, but more importantly, do not require any kind of
configuration.

> 
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
> ---
>  Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt |  1 +
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

Same comment as in patch 1, this is something that can be known based on
the compatible string, and the name of the property is misleading.

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
>  	BRCM_AHCI_QUICK_NONCQ		= BIT(0),
> +	BRCM_AHCI_QUICK_NOPHY		= BIT(1),

I would use something like BRCM_AHCI_SKIP_PHY_ENABLE or something like
that to illustrate what this really is about.

>  };
>  
>  struct brcm_ahci_priv {
> @@ -119,6 +120,9 @@ static void brcm_sata_phy_enable(struct brcm_ahci_priv *priv, int port)
>  	void __iomem *p;
>  	u32 reg;
>  
> +	if (priv->quicks & BRCM_AHCI_QUICK_NOPHY)
> +		return;
> +
>  	/* clear PHY_DEFAULT_POWER_STATE */
>  	p = phyctrl + SATA_TOP_CTRL_PHY_CTRL_1;
>  	reg = brcm_sata_readreg(p);
> @@ -148,6 +152,9 @@ static void brcm_sata_phy_disable(struct brcm_ahci_priv *priv, int port)
>  	void __iomem *p;
>  	u32 reg;
>  
> +	if (priv->quicks & BRCM_AHCI_QUICK_NOPHY)
> +		return;
> +
>  	/* power-off the PHY digital logic */
>  	p = phyctrl + SATA_TOP_CTRL_PHY_CTRL_2;
>  	reg = brcm_sata_readreg(p);
> @@ -297,6 +304,9 @@ static int brcm_ahci_probe(struct platform_device *pdev)
>  	if (of_property_read_bool(dev->of_node, "brcm,broken-ncq"))
>  		priv->quicks |= BRCM_AHCI_QUICK_NONCQ;
>  
> +	if (of_property_read_bool(dev->of_node, "brcm,broken-phy"))
> +		priv->quicks |= BRCM_AHCI_QUICK_NOPHY;
> +
>  	brcm_sata_init(priv);
>  	brcm_sata_quick(pdev, priv);
>  
> 


-- 
Florian
