Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 31 Oct 2015 16:20:37 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.187]:61052 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010152AbbJaPUgFdpIA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 31 Oct 2015 16:20:36 +0100
Received: from wuerfel.localnet ([134.3.118.24]) by mrelayeu.kundenserver.de
 (mreue005) with ESMTPSA (Nemesis) id 0LouSd-1aQD4a0N9H-00gpY7; Sat, 31 Oct
 2015 16:20:27 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jaedon Shin <jaedon.shin@gmail.com>
Cc:     Brian Norris <computersforpeace@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Dragan Stancevic <dragan.stancevic@gmail.com>,
        linux-ide@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>,
        devicetree@vger.kernel.org
Subject: Re: [v2 06/10] phy: phy_brcmstb_sata: add data for phy version
Date:   Sat, 31 Oct 2015 16:20:24 +0100
Message-ID: <7143236.HOM9hXl6B3@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <1445928491-7320-7-git-send-email-jaedon.shin@gmail.com>
References: <1445928491-7320-1-git-send-email-jaedon.shin@gmail.com> <1445928491-7320-7-git-send-email-jaedon.shin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K0:A+nFX0gm4ee96zFlL49m0hRYl2nxg+MbYWG8KYYLMj3ZnID8mQ0
 Fi6oVGWfTV+z6UhXuOFv3lnbXRqBAQWaj7+/gtJcfazNk4Ate7vW2zY9zo/wvcpYq0Ttg2m
 e/27wLWcv9MPIVz7Os/CrLgdr5rCwFvVz7EUmh6FvqRNQe50byLf9iYH1aW3QGM8ykVtYQf
 WpmxV+X80VxWaX1TOqpow==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9VHxN8yKt0s=:ELK5ZsxgS+uVZCDlN6vTzj
 WhOGnqlaEyZ9eQim85EV5WmOq0JCKGO1w7+qE1OvRzbKeGKK2STB+XixZOu/lgh8Hvbvi5ut1
 y6tbEwM4ccmJKVioXtsBI2zriLnQJzDLV1E4Nt53PdWj3F/Fl7i7l1u9ipTb2fJn/nWkJYTWt
 DqgmrJ7/GC4iGHuF4wdT+QhOf/A1wWDDywbqSfUdcZ/4qDwQDDdJuIfNreBgYn0HDwatOclc4
 ZyY6/D25k7h8cSve1b22SdvkIbtDfacf0xAHGemMGn4mKzJ7T7D2rpHHCo/qzk8qgczlgFLPk
 dFQlo6t5bYG43RSP4iOrGWPtrIFav3/9e7kxRHMpX7Boii9dPi+fssqyfgTkyFQpgYINikZw4
 valk6YoEX+xjWVmnBtY3+3gUSqwE2G+su/utaNUf44YvXr8EkkwOwBHVFucJtATlWUQlHx5Z7
 W/k6+wrQ+w6NA9mlEfxWG9QOn6MG/JI9dzkB5cW7pqIPYz3ox9pk55sBRW1Z2K6pLOYN0mAgb
 I2N4Gt2c7oFmZA2dLUBHahelxU4rN3Xf+cwsudkrYK8CW2z9uRKCqtxTCY8Yw1OB6pUjXLs+C
 otITgbu5b3rO3MZLr0GaCdwjR++7x5+3x2gmxhATslzAFMc3XyWHz//Lp6Tz+Zb3CWkdzFQLY
 r0mHn6yQrTrCe6A0cbKGlvavg1oUfYRYYp7QWp0G7JhmuNtbIWXJa9GdYmrXumqg82/hyi2Mg
 AxZUwFXJ0JK9Ay1C
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49799
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Tuesday 27 October 2015 15:48:07 Jaedon Shin wrote:
> 
>  static const struct of_device_id brcm_sata_phy_of_match[] = {
> -       { .compatible   = "brcm,bcm7445-sata-phy" },
> +       { .compatible   = "brcm,bcm7445-sata-phy",
> +         .data = (void *)BRCM_SATA_PHY_28NM },
>         {},
>  };
>  MODULE_DEVICE_TABLE(of, brcm_sata_phy_of_match);
> @@ -135,6 +145,7 @@ static int brcm_sata_phy_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
>         struct device_node *dn = dev->of_node, *child;
> +       const struct of_device_id *of_id;
>         struct brcm_sata_phy *priv;
>         struct resource *res;
>         struct phy_provider *provider;
> @@ -154,6 +165,12 @@ static int brcm_sata_phy_probe(struct platform_device *pdev)
>         if (IS_ERR(priv->phy_base))
>                 return PTR_ERR(priv->phy_base);
>  
> +       of_id = of_match_node(brcm_sata_phy_of_match, dn);
> +       if (of_id)
> +               priv->version = (enum brcm_sata_phy_version)of_id->data;
> +       else
> +               priv->version = BRCM_SATA_PHY_28NM;
> +
> 

As you don't actually use that variable except to set the 'offset' for
phy_base, it would be nicer to use a structure that you can point to:

struct brcm_sata_phy_data {
	unsigned long offset;
};

const struct brcm_sata_phy_data brcm_sata_phy_28nm = {
	.offset = SATA_MDIO_REG_28NM_SPACE_SIZE,
};

static const struct of_device_id brcm_sata_phy_of_match[] = {
	{ .compatible   = "brcm,bcm7445-sata-phy", .data = &brcm_sata_phy_28nm },
	{},
};

	Arnd
