Return-Path: <SRS0=+lB5=UX=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FBCC4646B
	for <linux-mips@archiver.kernel.org>; Mon, 24 Jun 2019 21:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB72020665
	for <linux-mips@archiver.kernel.org>; Mon, 24 Jun 2019 21:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yQJ1V4us"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbfFXVxG (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 24 Jun 2019 17:53:06 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:55224 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726301AbfFXVxG (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 24 Jun 2019 17:53:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=nXnV3K3041bH5KruAWVhU8YbjxtW4QexjPRk7ueMrxw=; b=yQJ1V4usWaBbw+NMeyj/ryK2xj
        P76Xpng2LDJXCDNb6veATOD5UX2BR1h7nI5uITh7RWHJsXSymSGylua2omlgDwdTXkuzJ0TymxYZd
        qBmiAliSpIZZEarBxXCNTSzlOjzNSdQ7yG2y0RaUQYk7fez4x7ckQ3rE434tVbcAmI64=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hfWtM-0000jm-Dc; Mon, 24 Jun 2019 23:52:48 +0200
Date:   Mon, 24 Jun 2019 23:52:48 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     =?iso-8859-1?Q?Ren=E9?= van Dorst <opensource@vdorst.com>
Cc:     sean.wang@mediatek.com, f.fainelli@gmail.com,
        linux@armlinux.org.uk, davem@davemloft.net, matthias.bgg@gmail.com,
        vivien.didelot@gmail.com, frank-w@public-files.de,
        netdev@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH RFC net-next 5/5] net: dsa: mt7530: Add
 mediatek,ephy-handle to isolate external phy
Message-ID: <20190624215248.GC31306@lunn.ch>
References: <20190624145251.4849-1-opensource@vdorst.com>
 <20190624145251.4849-6-opensource@vdorst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624145251.4849-6-opensource@vdorst.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

> +static int mt7530_isolate_ephy(struct dsa_switch *ds,
> +			       struct device_node *ephy_node)
> +{
> +	struct phy_device *phydev = of_phy_find_device(ephy_node);
> +	int ret;
> +
> +	if (!phydev)
> +		return 0;
> +
> +	ret = phy_modify(phydev, MII_BMCR, 0, (BMCR_ISOLATE | BMCR_PDOWN));

genphy_suspend() does what you want.

> +	if (ret)
> +		dev_err(ds->dev, "Failed to put phy %s in isolation mode!\n",
> +			ephy_node->full_name);
> +	else
> +		dev_info(ds->dev, "Phy %s in isolation mode!\n",
> +			 ephy_node->full_name);

No need to clog up the system with yet more kernel messages.

   Andrew
