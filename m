Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Apr 2011 00:47:23 +0200 (CEST)
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:51022
        "EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491085Ab1DLWrU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Apr 2011 00:47:20 +0200
Received: from localhost (localhost [127.0.0.1])
        by sunset.davemloft.net (Postfix) with ESMTP id 9530830001;
        Tue, 12 Apr 2011 15:46:42 -0700 (PDT)
Date:   Tue, 12 Apr 2011 15:46:42 -0700 (PDT)
Message-Id: <20110412.154642.200375628.davem@davemloft.net>
To:     blogic@openwrt.org
Cc:     ralf@linux-mips.org, ralph.hempel@lantiq.com,
        linux-mips@linux-mips.org, netdev@vger.kernel.org
Subject: Re: [PATCH 2/3] MIPS: lantiq: add ethernet driver
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1302624675-18652-3-git-send-email-blogic@openwrt.org>
References: <1302624675-18652-1-git-send-email-blogic@openwrt.org>
        <1302624675-18652-3-git-send-email-blogic@openwrt.org>
X-Mailer: Mew version 6.3 on Emacs 23.1 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29744
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips

From: John Crispin <blogic@openwrt.org>
Date: Tue, 12 Apr 2011 18:11:14 +0200

> This patch adds the driver for the ETOP Packet Processing Engine (PPE32) found
> inside the XWAY family of Lantiq MIPS SoCs. This driver makes 100MBit ethernet
> work. Support for all 8 dma channels, gbit and the embedded switch found on
> the ar9/vr9 still needs to be implemented.
> 
> Signed-off-by: John Crispin <blogic@openwrt.org>
> Signed-off-by: Ralph Hempel <ralph.hempel@lantiq.com>

This driver needs some work.

> +
> +	skb_put(skb, len);
> +	skb->dev = dev;
> +	skb->protocol = eth_type_trans(skb, dev);
> +	netif_rx(skb);
> +	priv->stats.rx_packets++;
> +	priv->stats.rx_bytes += len;

Please convert this driver to use NAPI for packet reception.

> +	local_irq_save(flags);
> +	priv->rx_tasklet_running = 0;
> +	if (priv->rx_channel_mask) {
> +		priv->rx_tasklet_running = 1;
> +		tasklet_schedule(&priv->rx_tasklet);
> +	}
> +	local_irq_restore(flags);

This doesn't protect anything, use proper locking.
