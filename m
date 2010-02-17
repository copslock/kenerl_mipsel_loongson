Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Feb 2010 16:05:06 +0100 (CET)
Received: from mail-ew0-f223.google.com ([209.85.219.223]:55995 "EHLO
        mail-ew0-f223.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491122Ab0BQPFA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Feb 2010 16:05:00 +0100
Received: by ewy23 with SMTP id 23so1844676ewy.24
        for <multiple recipients>; Wed, 17 Feb 2010 07:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:organization:to
         :subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:message-id;
        bh=+B7kphgBT53J28P6TT/DeH/3Uri5p/w1F50qEYPa45c=;
        b=vdrAM9n3/6F8GkVAohrQM4JDwCFIW87qBZ3iAkcmKFx8Wq64+g01i8+UIg1AQUF6+4
         iw0DD8nEkUF1Zvn6+8+shhz2Ahc4x0iFGK+8A28NJqrgx7ng/EzJId0lxr/ndZnWn0jV
         joweQNZr9k/Uf5fB59u3V/+zolvfpmZu9mfno=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=r/yyVcBpIAUttz17F0MJUQrT2vuxmwKa6UF4sZ1b87mKKGMGWk3yqnO2EirNZ0nhLK
         6/CV3irPuLYZ+N0Ebo/kyxSId/Aqj3e4LGdVeHOShJ5Y0YK3vXpmGKSGwWJW8Z3vq1TP
         afwNq40N6KqJ9kJ3OYJcLOmx9ao4vnxQvipC8=
Received: by 10.213.109.134 with SMTP id j6mr2247956ebp.72.1266419092928;
        Wed, 17 Feb 2010 07:04:52 -0800 (PST)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by mx.google.com with ESMTPS id 13sm5937669ewy.5.2010.02.17.07.04.51
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 17 Feb 2010 07:04:51 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
To:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: [PATCH -queue] MIPS/net: fix au1000_eth.c build and warnings
Date:   Wed, 17 Feb 2010 16:03:44 +0100
User-Agent: KMail/1.12.2 (Linux/2.6.31-17-server; KDE/4.3.2; x86_64; ; )
Cc:     "Linux-MIPS" <linux-mips@linux-mips.org>,
        Ralf =?utf-8?q?B=EF=BF=BDchle?= <ralf@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>
References: <1266263017-6874-1-git-send-email-manuel.lauss@gmail.com>
In-Reply-To: <1266263017-6874-1-git-send-email-manuel.lauss@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201002171603.44952.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25951
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi Manuel,

On Monday 15 February 2010 20:43:37 Manuel Lauss wrote:
> - buildfix: DECLARE_MAC_BUF was removed recently.
> - remove various warnings spit out during build
> 
> Only compile-tested.
> 
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
> ---
> Hi Ralf!  Please fold this into the patch titled
> "NET: au1000-eth: convert to platform_driver model"
> in mips-queue, thank you!
> 
>  drivers/net/au1000_eth.c |   14 +++++++-------
>  1 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/au1000_eth.c b/drivers/net/au1000_eth.c
> index 1acf2c1..6e5a68e 100644
> --- a/drivers/net/au1000_eth.c
> +++ b/drivers/net/au1000_eth.c
> @@ -397,11 +397,12 @@ static int mii_probe (struct net_device *dev)
>  				/* find the first (lowest address) non-attached PHY on
>  				 * the MAC0 MII bus */
>  				for (phy_addr = 0; phy_addr < PHY_MAX_ADDR; phy_addr++) {
> -					if (aup->mac_id == 1)
> -						break;
>  					struct phy_device *const tmp_phydev =
>  							aup->mii_bus->phy_map[phy_addr];
> 
> +					if (aup->mac_id == 1)
> +						break;
> +
>  					if (!tmp_phydev)
>  						continue; /* no PHY here... */
> 
> @@ -650,7 +651,6 @@ static int au1000_init(struct net_device *dev)
> 
>  static inline void update_rx_stats(struct net_device *dev, u32 status)
>  {
> -	struct au1000_private *aup = netdev_priv(dev);
>  	struct net_device_stats *ps = &dev->stats;
> 
>  	ps->rx_packets++;
> @@ -908,7 +908,7 @@ static netdev_tx_t au1000_tx(struct sk_buff *skb,
>  struct net_device *dev) }
> 
>  	pDB = aup->tx_db_inuse[aup->tx_head];
> -	skb_copy_from_linear_data(skb, pDB->vaddr, skb->len);
> +	skb_copy_from_linear_data(skb, (void *)pDB->vaddr, skb->len);
>  	if (skb->len < ETH_ZLEN) {
>  		for (i=skb->len; i<ETH_ZLEN; i++) {
>  			((char *)pDB->vaddr)[i] = 0;
> @@ -1006,7 +1006,7 @@ static int __devinit au1000_probe(struct
>  platform_device *pdev) db_dest_t *pDB, *pDBfree;
>  	int irq, i, err = 0;
>  	struct resource *base, *macen;
> -	DECLARE_MAC_BUF(ethaddr);
> +	char ethaddr[6];

That hunk is already in net-next-2.6.
--
Florian
-- 
Regards, Florian
