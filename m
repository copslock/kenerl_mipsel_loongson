Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Sep 2009 12:43:31 +0200 (CEST)
Received: from mail-ew0-f225.google.com ([209.85.219.225]:35310 "EHLO
	mail-ew0-f225.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492369AbZISKnZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 19 Sep 2009 12:43:25 +0200
Received: by ewy25 with SMTP id 25so1826469ewy.33
        for <multiple recipients>; Sat, 19 Sep 2009 03:43:19 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:reply-to:to
         :subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        bh=2abi43fqIlgh8GSk5rP/ZNCSVAQ0GVEuz0P2rto7uHE=;
        b=LDe5E3DvIefFwr7zrrG+ahEcqBi2eT2bhGunJ/RGusoXS0XuRyzXeTVeFQA3tks0aK
         76top25kGy9l7YieFw2UXzG2k9J0MHDkC3kTh9ZDiXOVrUQjhmeScPFx4UZbWnOYxIFv
         re890TW/TwufQsFKs3PNrj9ldsPWcEyc/YK0c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:reply-to:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=aBQp397FWiBH8QIx1ykdLaQ6v9mojPHaQHNLlwv6lLNEuU4V383eonBuqpgLkDej48
         er0r9iTYPwMRdwjIsBn6N8WdQJ+AULkE7ltLkV3XQ1tki254Ibw2lk1BJsiuenYEIF0F
         SL1wRFiTHaVD6XbG5TNZzfT/Ikh0Ya37qvO2Q=
Received: by 10.210.60.13 with SMTP id i13mr669665eba.8.1253356999442;
        Sat, 19 Sep 2009 03:43:19 -0700 (PDT)
Received: from lenovo.localnet (147.59.76-86.rev.gaoland.net [86.76.59.147])
        by mx.google.com with ESMTPS id 28sm2932206eyg.9.2009.09.19.03.43.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 19 Sep 2009 03:43:18 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Reply-To: Florian Fainelli <florian@openwrt.org>
To:	David Miller <davem@davemloft.net>
Subject: Re: [PATCH] cpmac: fix compilation errors against undeclared BUS_ID_SIZE
Date:	Sat, 19 Sep 2009 12:43:08 +0200
User-Agent: KMail/1.11.4 (Linux/2.6.29-2-686; KDE/4.2.4; i686; ; )
Cc:	netdev@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org
References: <200909160944.24265.florian@openwrt.org>
In-Reply-To: <200909160944.24265.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200909191243.09166.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24057
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

David,

Ping ? This fixes a build failure. Thank you very much !

Le mercredi 16 septembre 2009 09:44:22, Florian Fainelli a écrit :
> Hi David,
>
> This is relevant for 2.6.32-rc0, thanks !
> --
> From: Florian Fainelli <florian@openwrt.org>
> Subject: [PATCH] cpmac: fix compilation errors against undeclared
> BUS_ID_SIZE
>
> With the removal of BUS_ID_SIZE, cpmac was not fully
> converted to use MII_BUS_ID_SIZE as it ought to. This
> patch fixes the following cpmac build failure:
>  CC      drivers/net/cpmac.o
> drivers/net/cpmac.c: In function 'cpmac_start_xmit':
> drivers/net/cpmac.c:563: warning: comparison of distinct pointer types
> lacks a cast drivers/net/cpmac.c: In function 'cpmac_probe':
> drivers/net/cpmac.c:1112: error: 'BUS_ID_SIZE' undeclared (first use in
> this function) drivers/net/cpmac.c:1112: error: (Each undeclared identifier
> is reported only once drivers/net/cpmac.c:1112: error: for each function it
> appears in.)
>
> Reported-by: Ralf Baechle <ralf@linux-mips.org>
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
> diff --git a/drivers/net/cpmac.c b/drivers/net/cpmac.c
> index 3e3fab8..61f9da2 100644
> --- a/drivers/net/cpmac.c
> +++ b/drivers/net/cpmac.c
> @@ -1109,7 +1109,7 @@ static int external_switch;
>  static int __devinit cpmac_probe(struct platform_device *pdev)
>  {
>  	int rc, phy_id;
> -	char mdio_bus_id[BUS_ID_SIZE];
> +	char mdio_bus_id[MII_BUS_ID_SIZE];
>  	struct resource *mem;
>  	struct cpmac_priv *priv;
>  	struct net_device *dev;
> @@ -1118,7 +1118,7 @@ static int __devinit cpmac_probe(struct
> platform_device *pdev) pdata = pdev->dev.platform_data;
>
>  	if (external_switch || dumb_switch) {
> -		strncpy(mdio_bus_id, "0", BUS_ID_SIZE); /* fixed phys bus */
> +		strncpy(mdio_bus_id, "0", MII_BUS_ID_SIZE); /* fixed phys bus */
>  		phy_id = pdev->id;
>  	} else {
>  		for (phy_id = 0; phy_id < PHY_MAX_ADDR; phy_id++) {
> @@ -1126,7 +1126,7 @@ static int __devinit cpmac_probe(struct
> platform_device *pdev) continue;
>  			if (!cpmac_mii->phy_map[phy_id])
>  				continue;
> -			strncpy(mdio_bus_id, cpmac_mii->id, BUS_ID_SIZE);
> +			strncpy(mdio_bus_id, cpmac_mii->id, MII_BUS_ID_SIZE);
>  			break;
>  		}
>  	}
> @@ -1167,7 +1167,7 @@ static int __devinit cpmac_probe(struct
> platform_device *pdev) priv->msg_enable = netif_msg_init(debug_level,
> 0xff);
>  	memcpy(dev->dev_addr, pdata->dev_addr, sizeof(dev->dev_addr));
>
> -	snprintf(priv->phy_name, BUS_ID_SIZE, PHY_ID_FMT, mdio_bus_id, phy_id);
> +	snprintf(priv->phy_name, MII_BUS_ID_SIZE, PHY_ID_FMT, mdio_bus_id,
> phy_id);
>
>  	priv->phy = phy_connect(dev, priv->phy_name, &cpmac_adjust_link, 0,
>  						PHY_INTERFACE_MODE_MII);

-- 
Best regards, Florian Fainelli
Email: florian@openwrt.org
Web: http://openwrt.org
IRC: [florian] on irc.freenode.net
-------------------------------
