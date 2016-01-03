Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Jan 2016 20:18:55 +0100 (CET)
Received: from smtprelay0117.hostedemail.com ([216.40.44.117]:57352 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27009459AbcACTSw0q7p2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 3 Jan 2016 20:18:52 +0100
Received: from filter.hostedemail.com (unknown [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id AB15012BA12;
        Sun,  3 Jan 2016 19:18:50 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: drop74_6a1bfcbdea363
X-Filterd-Recvd-Size: 2703
Received: from joe-X200MA.home (pool-173-51-221-2.lsanca.fios.verizon.net [173.51.221.2])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Sun,  3 Jan 2016 19:18:49 +0000 (UTC)
Message-ID: <1451848727.4334.55.camel@perches.com>
Subject: Re: [PATCH 05/12] net-next: mediatek: add switch driver for mt7621
From:   Joe Perches <joe@perches.com>
To:     John Crispin <blogic@openwrt.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-mips@linux-mips.org,
        linux-mediatek@lists.infradead.org, Felix Fietkau <nbd@nbd.name>,
        Michael Lee <igvtee@gmail.com>,
        Steven Liu =?UTF-8?Q?=28=E5=8A=89=E4=BA=BA=E8=B1=AA=29?= 
        <steven.liu@mediatek.com>,
        Fred Chang =?UTF-8?Q?=28=E5=BC=B5=E5=98=89=E5=AE=8F=29?= 
        <Fred.Chang@mediatek.com>
Date:   Sun, 03 Jan 2016 11:18:47 -0800
In-Reply-To: <1451834775-15789-5-git-send-email-blogic@openwrt.org>
References: <1451834775-15789-1-git-send-email-blogic@openwrt.org>
         <1451834775-15789-5-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.18.3-1ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <joe@perches.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50832
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joe@perches.com
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

On Sun, 2016-01-03 at 16:26 +0100, John Crispin wrote:
> This driver is very basic and only provides basic init and irq support.
> The SoC and switch core both have support for a special tag making DSA
> support possible.

trivia:

> diff --git a/drivers/net/ethernet/mediatek/gsw_mt7621.c b/drivers/net/ethernet/mediatek/gsw_mt7621.c
[]
> +static irqreturn_t gsw_interrupt_mt7621(int irq, void *_priv)
> +{
> +	struct fe_priv *priv = (struct fe_priv *)_priv;
> +	struct mt7620_gsw *gsw = (struct mt7620_gsw *)priv->soc->swpriv;
> +	u32 reg, i;
> +
> +	reg = mt7530_mdio_r32(gsw, 0x700c);
> +
> +	for (i = 0; i < 5; i++)
> +		if (reg & BIT(i)) {
> +			unsigned int link;
> +
> +			link = mt7530_mdio_r32(gsw,
> +					       0x3008 + (i * 0x100)) & 0x1;
> +
> +			if (link != priv->link[i]) {
> +				priv->link[i] = link;
> +				if (link)
> +					netdev_info(priv->netdev,
> +						    "port %d link up\n", i);
> +				else
> +					netdev_info(priv->netdev,
> +						    "port %d link down\n", i);
> +			}
> +		}

It's more common to use braces after the for loop.
Perhaps this could be written with a continue; to reduce
indentation and also use a single netdev_info().

	for (i = 0; i < 5; i++) {
		unsigned int link;

		if (!(reg & BIT(i)))
			continue;

		link = mt7530_mdio_r32(gsw, 0x3008 + (i * 0x100)) & 0x1;

		if (link == priv->link[i])
			continue;

		priv->link[i] = link;
		netdev_info(priv->netdev, "port %d link %s\n",
			    i, link ? "up" : "down");
	}
