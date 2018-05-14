Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 May 2018 22:52:20 +0200 (CEST)
Received: from mail-wm0-x242.google.com ([IPv6:2a00:1450:400c:c09::242]:40586
        "EHLO mail-wm0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992670AbeENUwMtrT8Z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 May 2018 22:52:12 +0200
Received: by mail-wm0-x242.google.com with SMTP id j5-v6so17629768wme.5
        for <linux-mips@linux-mips.org>; Mon, 14 May 2018 13:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o6oKlTV0ZSFdN1HSa1jb+7Vcc9kymBVzW2eicFTjQV4=;
        b=hBfNVd3aJGxvme+zJ1aSLCylm4N1ZVzzJW8VXWE7QnPUKMKrmpKOKJRVDmgZOEQY2Q
         jflvvfGv5NXvQrd/l4jeKOr577Ino9poudAzQbh/sNhzUuXb+rVg1e+HF5vDf22x+jG0
         Wbu1A+QwI1kRhursf51mkjYESsumzcrPTevto6OniXZkajhn3pL2RkwmayaZ89TdG0X6
         oaRoBo4o0O2Qsr2aHOa0/hb5pTVGACl+PHTIFwRzrvSUlD+I1bwWR/Y9Jg7oHGhBtVJE
         3v5SwV8K2XBa7MlJsPSdIuYiFYrFiNPKnp8B3+XfK8ZXt9YhEwBTOMeBk0o7x1+WRftB
         B2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=o6oKlTV0ZSFdN1HSa1jb+7Vcc9kymBVzW2eicFTjQV4=;
        b=fxfvbkkXQUnV7mgmmKrQyOX/jgyrFoiGK02Sxp8QZuDPLz9ihxBPFkAaJ8Tz3LRT+r
         IZPfouMpHk6A34wKTPSqX2RL0zHFiiAJL85E8xzFgQNBELGvB/Ywc4OXPtr4BCp5R3yu
         9xFiANkW/rgdYwDOdi/Ur5byPymA/LLWvHT5icHrkd/hCPy1TFodt0Kyr+gQcuEdASFu
         Mc0yZz64Bmb4hs3IljEF1tXfjnqI1E5WR1Pm+/bAqsojH/z5hRz+LzUxfuQ/7/eDTP5i
         dvo1l3F0wKkT6nImn8K+GzUcPFCjWYPOiKN3qCyXJ6zD2WTrFiBTjYCFxUg97uSntaVS
         LOXg==
X-Gm-Message-State: ALKqPweCofc8tZlDxwIGZac2f7GP0nYB+PXB7q5Uby61xc+z/HJSs8dT
        hjKR8YlclMHwNeWKKUGmzsi/71Ez
X-Google-Smtp-Source: AB8JxZoaueQ7uOnS01CMuM6gOCj302mEabuUzxuyGwj9tsRwid7FpMp3sNfaheayXOS7agKALI9HNA==
X-Received: by 2002:aa7:c6d0:: with SMTP id b16-v6mr14261044eds.302.1526331127178;
        Mon, 14 May 2018 13:52:07 -0700 (PDT)
Received: from [10.69.41.93] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id h51-v6sm5522208eda.88.2018.05.14.13.52.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 May 2018 13:52:06 -0700 (PDT)
Subject: Re: [PATCH net-next v3 2/7] net: phy: mscc-miim: Add MDIO driver
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Allan Nielsen <Allan.Nielsen@microsemi.com>,
        razvan.stefanescu@nxp.com, po.liu@nxp.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
References: <20180514200500.2953-1-alexandre.belloni@bootlin.com>
 <20180514200500.2953-3-alexandre.belloni@bootlin.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <ffa13558-8ca0-00e5-9603-db8ee25a483e@gmail.com>
Date:   Mon, 14 May 2018 13:52:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180514200500.2953-3-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63947
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

On 05/14/2018 01:04 PM, Alexandre Belloni wrote:
> Add a driver for the Microsemi MII Management controller (MIIM) found on
> Microsemi SoCs.
> On Ocelot, there are two controllers, one is connected to the internal
> PHYs, the other one can communicate with external PHYs.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Nothing critical, so:

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

[snip]

> +static int mscc_miim_reset(struct mii_bus *bus)
> +{
> +	struct mscc_miim_dev *miim = bus->priv;
> +
> +	if (miim->phy_regs) {
> +		writel(0, miim->phy_regs + MSCC_PHY_REG_PHY_CFG);
> +		writel(0x1ff, miim->phy_regs + MSCC_PHY_REG_PHY_CFG);
> +		mdelay(500);

Can this become an msleep() in the future?

> +	}
> +
> +	return 0;
> +}
> +
> +static int mscc_miim_probe(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +	struct mii_bus *bus;
> +	struct mscc_miim_dev *dev;
> +	int ret;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -ENODEV;
> +
> +	bus = devm_mdiobus_alloc_size(&pdev->dev, sizeof(*dev));
> +	if (!bus)
> +		return -ENOMEM;
> +
> +	bus->name = "mscc_miim";
> +	bus->read = mscc_miim_read;
> +	bus->write = mscc_miim_write;
> +	bus->reset = mscc_miim_reset;
> +	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-mii", dev_name(&pdev->dev));
> +	bus->parent = &pdev->dev;
> +
> +	dev = bus->priv;
> +	dev->regs = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(dev->regs)) {
> +		dev_err(&pdev->dev, "Unable to map MIIM registers\n");
> +		return PTR_ERR(dev->regs);
> +	}
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	if (res) {
> +		dev->phy_regs = devm_ioremap_resource(&pdev->dev, res);
> +		if (IS_ERR(dev->phy_regs)) {
> +			dev_err(&pdev->dev, "Unable to map internal phy registers\n");
> +			return PTR_ERR(dev->phy_regs);
> +		}
> +	}
> +
> +	if (pdev->dev.of_node)
> +		ret = of_mdiobus_register(bus, pdev->dev.of_node);
> +	else
> +		ret = mdiobus_register(bus);

There are other drivers doing that, we should probably make that the
standard behavior of of_mdiobus_register(), like before, candidate for
another patch.
-- 
Florian
