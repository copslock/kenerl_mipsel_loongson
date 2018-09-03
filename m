Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Sep 2018 21:24:26 +0200 (CEST)
Received: from mail-pf1-x443.google.com ([IPv6:2607:f8b0:4864:20::443]:43156
        "EHLO mail-pf1-x443.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994240AbeICTYWl2Gct (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 3 Sep 2018 21:24:22 +0200
Received: by mail-pf1-x443.google.com with SMTP id j26-v6so530715pfi.10
        for <linux-mips@linux-mips.org>; Mon, 03 Sep 2018 12:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HlAisjhP4lFA8cg7p9tHEwbvL515iFhQ8Q2PDXwWkHk=;
        b=efQLxM7iU4Cubvt8G9hZqAjP1wRljtXfVfsAYw5V5XZ67+wOXB60EOmbRYM01BWA87
         SFE9AjBmHIBu5yIIksvnlEbYC9D84O59g4TquBmhh49UhlLLOJj1WEXyEab0l9/n1Euo
         U0WpulsCZ4vN07yc/5AZW4IT7T37au8xH07aPxmvlWIpB8T2G5BFtoRg5Ckel4UmDka2
         H/anGej5eW27ehI3hVnascDNXe3aUjKmgwAKbdZAyfJWbzhhQlA/TvesjuZ0BTVryUVo
         gMJVh98n/3ZzOi8ig4R8LeWLJsfb72innVZifdfFFDZ6WcaAToPlg3XvQu8isx1cSUSs
         gPGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HlAisjhP4lFA8cg7p9tHEwbvL515iFhQ8Q2PDXwWkHk=;
        b=jHBWAy8omm9Zfvd3SQCR6N6UCSNmrL/i8cJfGGi+KyIwelJv60KZbGAqtY4Pn8y7OM
         JWtXh7U4BK041x1L91ULHdlH8muMtYv193fxguT17AKVBvuqikW/w1TxuMBhrT8VmSsX
         5IpfYBG2mkoGYj51lcLC6nsSGiTVGqwpVHP33Iy/7W3iiDnvtdwAzjZPOWgJtdCVrAIe
         W8N46PuF6q9I3goHv63S6Ep2z2v/TI7xljHIl8dsAVRF2/rvt03+kkgKTWYSBckYofBm
         s8MLm9O6AaKXCb5KqDWGmtqG90u2nzSiQZ5ibCQsQILgVuO50kg35d9kQyQ9sQSJnRDx
         SdFQ==
X-Gm-Message-State: APzg51CZ/vM9pU3W9oWtH7+MqTX+gZEW340PIU76KqPRZSyFxHF+kVVv
        rDqsfKH7GbdbAMdOSlkubQU=
X-Google-Smtp-Source: ANB0VdZhupc3lYaVV4ntdn3iTl2LeU9a+nleK63GFf26Y7Yazpc3qtgz5OvB67EFk5pm+iLZ1Cvkgg==
X-Received: by 2002:a63:4663:: with SMTP id v35-v6mr27973680pgk.178.1536002655635;
        Mon, 03 Sep 2018 12:24:15 -0700 (PDT)
Received: from [10.10.115.170] ([192.19.218.250])
        by smtp.gmail.com with ESMTPSA id t12-v6sm32238034pgg.72.2018.09.03.12.24.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 12:24:14 -0700 (PDT)
Subject: Re: [PATCH v2 net-next 5/7] net: lantiq: Add Lantiq / Intel VRX200
 Ethernet driver
To:     Hauke Mehrtens <hauke@hauke-m.de>, davem@davemloft.net
Cc:     netdev@vger.kernel.org, andrew@lunn.ch,
        vivien.didelot@savoirfairelinux.com, john@phrozen.org,
        linux-mips@linux-mips.org, dev@kresin.me, hauke.mehrtens@intel.com,
        devicetree@vger.kernel.org
References: <20180901114535.9070-1-hauke@hauke-m.de>
 <20180901120427.9983-1-hauke@hauke-m.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <6d3bdb60-c993-9129-6e87-afb08ff5c113@gmail.com>
Date:   Mon, 3 Sep 2018 12:24:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180901120427.9983-1-hauke@hauke-m.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65917
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



On 9/1/2018 5:04 AM, Hauke Mehrtens wrote:
> This drives the PMAC between the GSWIP Switch and the CPU in the VRX200
> SoC. This is currently only the very basic version of the Ethernet
> driver.
> 
> When the DMA channel is activated we receive some packets which were
> send to the SoC while it was still in U-Boot, these packets have the
> wrong header. Resetting the IP cores did not work so we read out the
> extra packets at the beginning and discard them.
> 
> This also adapts the clock code in sysctrl.c to use the default name of
> the device node so that the driver gets the correct clock. sysctrl.c
> should be replaced with a proper common clock driver later.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>   MAINTAINERS                          |   1 +
>   arch/mips/lantiq/xway/sysctrl.c      |   6 +-
>   drivers/net/ethernet/Kconfig         |   7 +
>   drivers/net/ethernet/Makefile        |   1 +
>   drivers/net/ethernet/lantiq_xrx200.c | 591 +++++++++++++++++++++++++++++++++++
>   5 files changed, 603 insertions(+), 3 deletions(-)
>   create mode 100644 drivers/net/ethernet/lantiq_xrx200.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4b2ee65f6086..ffff912d31b5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8171,6 +8171,7 @@ M:	Hauke Mehrtens <hauke@hauke-m.de>
>   L:	netdev@vger.kernel.org
>   S:	Maintained
>   F:	net/dsa/tag_gswip.c
> +F:	drivers/net/ethernet/lantiq_xrx200.c
>   
>   LANTIQ MIPS ARCHITECTURE
>   M:	John Crispin <john@phrozen.org>
> diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/sysctrl.c
> index e0af39b33e28..eeb89a37e27e 100644
> --- a/arch/mips/lantiq/xway/sysctrl.c
> +++ b/arch/mips/lantiq/xway/sysctrl.c
> @@ -505,7 +505,7 @@ void __init ltq_soc_init(void)
>   		clkdev_add_pmu("1a800000.pcie", "msi", 1, 1, PMU1_PCIE2_MSI);
>   		clkdev_add_pmu("1a800000.pcie", "pdi", 1, 1, PMU1_PCIE2_PDI);
>   		clkdev_add_pmu("1a800000.pcie", "ctl", 1, 1, PMU1_PCIE2_CTL);
> -		clkdev_add_pmu("1e108000.eth", NULL, 0, 0, PMU_SWITCH | PMU_PPE_DP);
> +		clkdev_add_pmu("1e10b308.eth", NULL, 0, 0, PMU_SWITCH | PMU_PPE_DP);
>   		clkdev_add_pmu("1da00000.usif", "NULL", 1, 0, PMU_USIF);
>   		clkdev_add_pmu("1e103100.deu", NULL, 1, 0, PMU_DEU);
>   	} else if (of_machine_is_compatible("lantiq,ar10")) {
> @@ -513,7 +513,7 @@ void __init ltq_soc_init(void)
>   				  ltq_ar10_fpi_hz(), ltq_ar10_pp32_hz());
>   		clkdev_add_pmu("1e101000.usb", "otg", 1, 0, PMU_USB0);
>   		clkdev_add_pmu("1e106000.usb", "otg", 1, 0, PMU_USB1);
> -		clkdev_add_pmu("1e108000.eth", NULL, 0, 0, PMU_SWITCH |
> +		clkdev_add_pmu("1e10b308.eth", NULL, 0, 0, PMU_SWITCH |
>   			       PMU_PPE_DP | PMU_PPE_TC);

Should not that be part of patch 4 where you define the base register 
address?

>   		clkdev_add_pmu("1da00000.usif", "NULL", 1, 0, PMU_USIF);
>   		clkdev_add_pmu("1f203020.gphy", NULL, 1, 0, PMU_GPHY);
> @@ -536,7 +536,7 @@ void __init ltq_soc_init(void)
>   		clkdev_add_pmu(NULL, "ahb", 1, 0, PMU_AHBM | PMU_AHBS);
>   
>   		clkdev_add_pmu("1da00000.usif", "NULL", 1, 0, PMU_USIF);
> -		clkdev_add_pmu("1e108000.eth", NULL, 0, 0,
> +		clkdev_add_pmu("1e10b308.eth", NULL, 0, 0,
>   				PMU_SWITCH | PMU_PPE_DPLUS | PMU_PPE_DPLUM |
>   				PMU_PPE_EMA | PMU_PPE_TC | PMU_PPE_SLL01 |
>   				PMU_PPE_QSB | PMU_PPE_TOP);

Likewise.

[snip]

> +static int xrx200_open(struct net_device *dev)
> +{
> +	struct xrx200_priv *priv = netdev_priv(dev);
> +
> +	ltq_dma_open(&priv->chan_tx.dma);
> +	ltq_dma_enable_irq(&priv->chan_tx.dma);
> +
> +	napi_enable(&priv->chan_rx.napi);
> +	ltq_dma_open(&priv->chan_rx.dma);
> +	/* The boot loader does not always deactivate the receiving of frames
> +	 * on the ports and then some packets queue up in the PPE buffers.
> +	 * They already passed the PMAC so they do not have the tags
> +	 * configured here. Read the these packets here and drop them.
> +	 * The HW should have written them into memory after 10us
> +	 */
> +	udelay(10);

You execute in process context with the ndo_open() callback (AFAIR), 
would usleep_range() work here?

> +	xrx200_flush_dma(&priv->chan_rx);
> +	ltq_dma_enable_irq(&priv->chan_rx.dma);
> +
> +	netif_wake_queue(dev);
> +
> +	return 0;
> +}
> +
> +static int xrx200_close(struct net_device *dev)
> +{
> +	struct xrx200_priv *priv = netdev_priv(dev);
> +
> +	netif_stop_queue(dev);
> +
> +	napi_disable(&priv->chan_rx.napi);
> +	ltq_dma_close(&priv->chan_rx.dma);
> +
> +	ltq_dma_close(&priv->chan_tx.dma);
> +
> +	return 0;
> +}
> +
> +static int xrx200_alloc_skb(struct xrx200_chan *ch)
> +{
> +	int ret = 0;
> +
> +#define DMA_PAD	(NET_IP_ALIGN + NET_SKB_PAD)
> +	ch->skb[ch->dma.desc] = dev_alloc_skb(XRX200_DMA_DATA_LEN + DMA_PAD);
> +	if (!ch->skb[ch->dma.desc]) {
> +		ret = -ENOMEM;
> +		goto skip;
> +	}

Would not netdev_alloc_skb() do what you want already?

> +
> +	skb_reserve(ch->skb[ch->dma.desc], NET_SKB_PAD);
> +	ch->dma.desc_base[ch->dma.desc].addr = dma_map_single(ch->priv->dev,
> +			ch->skb[ch->dma.desc]->data, XRX200_DMA_DATA_LEN,
> +			DMA_FROM_DEVICE);
> +	if (unlikely(dma_mapping_error(ch->priv->dev,
> +				       ch->dma.desc_base[ch->dma.desc].addr))) {
> +		dev_kfree_skb_any(ch->skb[ch->dma.desc]);
> +		ret = -ENOMEM;
> +		goto skip;
> +	}
> +
> +	ch->dma.desc_base[ch->dma.desc].addr =
> +		CPHYSADDR(ch->skb[ch->dma.desc]->data);
> +	skb_reserve(ch->skb[ch->dma.desc], NET_IP_ALIGN);
> +
> +skip:
> +	ch->dma.desc_base[ch->dma.desc].ctl =
> +		LTQ_DMA_OWN | LTQ_DMA_RX_OFFSET(NET_IP_ALIGN) |
> +		XRX200_DMA_DATA_LEN;
> +
> +	return ret;
> +}
> +
> +static int xrx200_hw_receive(struct xrx200_chan *ch)
> +{
> +	struct xrx200_priv *priv = ch->priv;
> +	struct ltq_dma_desc *desc = &ch->dma.desc_base[ch->dma.desc];
> +	struct sk_buff *skb = ch->skb[ch->dma.desc];
> +	int len = (desc->ctl & LTQ_DMA_SIZE_MASK);
> +	int ret;
> +
> +	ret = xrx200_alloc_skb(ch);
> +
> +	ch->dma.desc++;
> +	ch->dma.desc %= LTQ_DESC_NUM;
> +
> +	if (ret) {
> +		netdev_err(priv->net_dev,
> +			   "failed to allocate new rx buffer\n");
> +		return ret;
> +	}
> +
> +	skb_put(skb, len);
> +	skb->dev = priv->net_dev;

eth_type_trans() does the skb->dev assignment already, this is not 
necessary.

> +	skb->protocol = eth_type_trans(skb, priv->net_dev);
> +	netif_receive_skb(skb);
> +	priv->stats.rx_packets++;
> +	priv->stats.rx_bytes += len;

Does the length reported by the hardware include the Ethernet Frame 
Check Sequence (FCS)? If so, you need to remove it here, since you are 
not supposed to pass it up the stack unless NETIF_F_RXFCS* is turned on.

[snip]

> +static void xrx200_tx_housekeeping(unsigned long ptr)
> +{
> +	struct xrx200_chan *ch = (struct xrx200_chan *)ptr;
> +	int pkts = 0;
> +	int bytes = 0;
> +
> +	ltq_dma_ack_irq(&ch->dma);
> +	while ((ch->dma.desc_base[ch->tx_free].ctl &
> +		(LTQ_DMA_OWN | LTQ_DMA_C)) == LTQ_DMA_C) {
> +		struct sk_buff *skb = ch->skb[ch->tx_free];
> +
> +		pkts++;
> +		bytes += skb->len;
> +		ch->skb[ch->tx_free] = NULL;
> +		dev_kfree_skb(skb);

Consider using dev_consume_skb() to be drop monitor friendly, 
dev_kfree_skb() indicates the SKB was freed upon error, this is not the 
case here.

> +		memset(&ch->dma.desc_base[ch->tx_free], 0,
> +		       sizeof(struct ltq_dma_desc));

Humm, don't you need a write barrier here to make sure the HW view's of 
the descriptor is consistent with the CPU's view?

> +		ch->tx_free++;
> +		ch->tx_free %= LTQ_DESC_NUM;
> +	}
> +	ltq_dma_enable_irq(&ch->dma);
> +
> +	netdev_completed_queue(ch->priv->net_dev, pkts, bytes);
> +
> +	if (!pkts)
> +		return;
> +
> +	netif_wake_queue(ch->priv->net_dev);

Can you do this in NAPI context, even if that means creating a specific 
TX NAPI object instead of doing this in tasklet context?

> +}
> +
> +static struct net_device_stats *xrx200_get_stats(struct net_device *dev)
> +{
> +	struct xrx200_priv *priv = netdev_priv(dev);
> +
> +	return &priv->stats;

As Andrew pointed out, consider using dev->stats, or better yet, 
implement 64-bit statistics.

> +}
> +
> +static int xrx200_start_xmit(struct sk_buff *skb, struct net_device *dev)
> +{
> +	struct xrx200_priv *priv = netdev_priv(dev);
> +	struct xrx200_chan *ch;
> +	struct ltq_dma_desc *desc;
> +	u32 byte_offset;
> +	dma_addr_t mapping;
> +	int len;
> +
> +	ch = &priv->chan_tx;
> +
> +	desc = &ch->dma.desc_base[ch->dma.desc];
> +
> +	skb->dev = dev;
> +	len = skb->len < ETH_ZLEN ? ETH_ZLEN : skb->len;

Consider using skb_put_padto() which would do that automatically for you.

> +
> +	/* dma needs to start on a 16 byte aligned address */
> +	byte_offset = CPHYSADDR(skb->data) % 16;

That really should not be necessary, the stack should already be handing 
you off packets that are aligned to the max between the L1 cache line 
size and 64 bytes. Also, CPHYSADDR is a MIPSism, getting rid of it would 
help with the portability and building the driver on other architectures.

> +
> +	if ((desc->ctl & (LTQ_DMA_OWN | LTQ_DMA_C)) || ch->skb[ch->dma.desc]) {
> +		netdev_err(dev, "tx ring full\n");
> +		netif_stop_queue(dev);
> +		return NETDEV_TX_BUSY;
> +	}
> +
> +	ch->skb[ch->dma.desc] = skb;
> +
> +	netif_trans_update(dev);

This should not be necessary the stack does that already AFAIR.

> +
> +	mapping = dma_map_single(priv->dev, skb->data, len, DMA_TO_DEVICE);
> +	if (unlikely(dma_mapping_error(priv->dev, mapping)))
> +		goto err_drop;
> +
> +	desc->addr = mapping - byte_offset;
> +	/* Make sure the address is written before we give it to HW */
> +	wmb();
> +	desc->ctl = LTQ_DMA_OWN | LTQ_DMA_SOP | LTQ_DMA_EOP |
> +		LTQ_DMA_TX_OFFSET(byte_offset) | (len & LTQ_DMA_SIZE_MASK);
> +	ch->dma.desc++;
> +	ch->dma.desc %= LTQ_DESC_NUM;
> +	if (ch->dma.desc == ch->tx_free)
> +		netif_stop_queue(dev);
> +
> +	netdev_sent_queue(dev, skb->len);

As soon as you write to the descriptor, the packet is handed to HW and 
you could thereoteically have it completed before you even get to access 
skb->len here since your TX completion interrupt could preempt this 
function, that would mean use after free, so consider using 'len' here.

> +	priv->stats.tx_packets++;
> +	priv->stats.tx_bytes += len;

Updating sucessful TX completion statistics should occur in your TX 
completion handler: xrx200_tx_housekeeping() because you could have a 
stuck TX path, so knowing whether the TX IRQ fired and cleaned up your 
packets is helpful to troubleshoot problems.

> +
> +	return NETDEV_TX_OK;
> +
> +err_drop:
> +	dev_kfree_skb(skb);
> +	priv->stats.tx_dropped++;
> +	priv->stats.tx_errors++;
> +	return NETDEV_TX_OK;
> +}
> +
> +static const struct net_device_ops xrx200_netdev_ops = {
> +	.ndo_open		= xrx200_open,
> +	.ndo_stop		= xrx200_close,
> +	.ndo_start_xmit		= xrx200_start_xmit,
> +	.ndo_set_mac_address	= eth_mac_addr,
> +	.ndo_validate_addr	= eth_validate_addr,
> +	.ndo_change_mtu		= eth_change_mtu,
> +	.ndo_get_stats		= xrx200_get_stats,
> +};
> +
> +static irqreturn_t xrx200_dma_irq_tx(int irq, void *ptr)
> +{
> +	struct xrx200_priv *priv = ptr;
> +	struct xrx200_chan *ch = &priv->chan_tx;
> +
> +	ltq_dma_disable_irq(&ch->dma);
> +	ltq_dma_ack_irq(&ch->dma);
> +
> +	tasklet_schedule(&ch->tasklet);

Can you use NAPI instead (similar to what was suggested before)?

[snip]

> +	/* enable clock gate */
> +	err = clk_prepare_enable(priv->clk);
> +	if (err)
> +		goto err_uninit_dma;

Since there is no guarantee that a network device will be used up until 
some point, you should consider defering the clock enabling into the 
ndo_open() callback to save some possible power. Likewise with resources 
that require memory allocations, you should defer them to as as late as 
possible.
-- 
Florian
