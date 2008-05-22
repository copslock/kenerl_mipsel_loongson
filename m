Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 May 2008 11:22:21 +0100 (BST)
Received: from srv5.dvmed.net ([207.36.208.214]:13706 "EHLO mail.dvmed.net")
	by ftp.linux-mips.org with ESMTP id S20027324AbYEVKWT (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 22 May 2008 11:22:19 +0100
Received: from cpe-069-134-153-115.nc.res.rr.com ([69.134.153.115] helo=core.yyz.us)
	by mail.dvmed.net with esmtpsa (Exim 4.68 #1 (Red Hat Linux))
	id 1Jz7w2-0001kq-4I; Thu, 22 May 2008 10:22:11 +0000
Message-ID: <48354951.7010907@pobox.com>
Date:	Thu, 22 May 2008 06:22:09 -0400
From:	Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
MIME-Version: 1.0
To:	Matteo Croce <matteo@openwrt.org>
CC:	Andrew Morton <akpm@linux-foundation.org>, ralf@linux-mips.org,
	nbd@openwrt.org, ejka@imfi.kspu.ru, linux-mips@linux-mips.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH]: cpmac bugfixes and enhancements
References: <200805041904.22726.matteo@openwrt.org> <20080505161634.6964d46b.akpm@linux-foundation.org> <200805140058.32890.matteo@openwrt.org>
In-Reply-To: <200805140058.32890.matteo@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jgarzik@pobox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19337
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jgarzik@pobox.com
Precedence: bulk
X-list: linux-mips

Matteo Croce wrote:
> Il Tuesday 06 May 2008 01:16:34 Andrew Morton ha scritto:
>> On Sun, 4 May 2008 19:04:22 +0200
>> Matteo Croce <matteo@openwrt.org> wrote:
>>
>>> This patch fixes an IRQ storm, a locking issues, moves platform code in the right sections
>>> and other small fixes.
>>>
>> Please feed this patch (and all future ones) through scripts/checkpatch.pl.
>> It picks up rather a lot of simple problems which there is no reason for
>> us to retain.
>>
>>> ...
>>>
>>> +	spin_unlock(&priv->rx_lock);
>>> +	netif_rx_complete(priv->dev, napi);
>>> +	netif_stop_queue(priv->dev);
>>> +	napi_disable(&priv->napi);
>>> +	
>>> +	atomic_inc(&priv->reset_pending);
>>> +	cpmac_hw_stop(priv->dev);
>>> +	if (!schedule_work(&priv->reset_work))
>>> +		atomic_dec(&priv->reset_pending);
>>> +	return 0;
>>> + 
>>>  }
>>>  
>>>  static int cpmac_start_xmit(struct sk_buff *skb, struct net_device *dev)
>>> @@ -456,6 +549,9 @@ static int cpmac_start_xmit(struct sk_buff *skb, struct net_device *dev)
>>>  	struct cpmac_desc *desc;
>>>  	struct cpmac_priv *priv = netdev_priv(dev);
>>>  
>>> +	if (unlikely(atomic_read(&priv->reset_pending)))
>>> +		return NETDEV_TX_BUSY;
>>> +
>> This looks a bit strange.  schedule_work() will return zero if the work was
>> already scheduled, in which case we arrange for cpmac_start_xmit() to abort
>> early.
>>
>> But if schedule_work() *doesn't* return zero, there is a time window in
>> which the reset is still pending.  Because it takes time for keventd to be
>> awoken and to run the work function.
>>
>> I would have thought that we would want to prevent cpmac_start_xmit() from
>> running within that time window also?
>>
>>
>> But that's just a guess - the text which you used to describe your work is
>> missing much information, so I don't have a lot to work with here.
>>
> 
> This one is cleaner:
> 
> 
> Signed-off-by: Matteo Croce <matteo@openwrt.org>
> Signed-off-by: Felix Fietkau <nbd@openwrt.org>
> 
> diff --git a/drivers/net/cpmac.c b/drivers/net/cpmac.c
> index 2b5740b..7f3f62e 100644
> --- a/drivers/net/cpmac.c
> +++ b/drivers/net/cpmac.c
> @@ -38,6 +38,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/dma-mapping.h>
>  #include <asm/gpio.h>
> +#include <asm/atomic.h>
>  
>  MODULE_AUTHOR("Eugene Konev <ejka@imfi.kspu.ru>");
>  MODULE_DESCRIPTION("TI AR7 ethernet driver (CPMAC)");
> @@ -187,6 +188,7 @@ struct cpmac_desc {
>  #define CPMAC_EOQ			0x1000
>  	struct sk_buff *skb;
>  	struct cpmac_desc *next;
> +	struct cpmac_desc *prev;
>  	dma_addr_t mapping;
>  	dma_addr_t data_mapping;
>  };
> @@ -208,6 +210,7 @@ struct cpmac_priv {
>  	struct work_struct reset_work;
>  	struct platform_device *pdev;
>  	struct napi_struct napi;
> +	atomic_t reset_pending;
>  };
>  
>  static irqreturn_t cpmac_irq(int, void *);
> @@ -241,6 +244,16 @@ static void cpmac_dump_desc(struct net_device *dev, struct cpmac_desc *desc)
>  	printk("\n");
>  }
>  
> +static void cpmac_dump_all_desc(struct net_device *dev)
> +{
> +	struct cpmac_priv *priv = netdev_priv(dev);
> +	struct cpmac_desc *dump = priv->rx_head;
> +	do {
> +		cpmac_dump_desc(dev, dump);
> +		dump = dump->next;
> +	} while (dump != priv->rx_head);
> +}
> +
>  static void cpmac_dump_skb(struct net_device *dev, struct sk_buff *skb)
>  {
>  	int i;
> @@ -412,21 +425,42 @@ static struct sk_buff *cpmac_rx_one(struct cpmac_priv *priv,
>  static int cpmac_poll(struct napi_struct *napi, int budget)
>  {
>  	struct sk_buff *skb;
> -	struct cpmac_desc *desc;
> -	int received = 0;
> +	struct cpmac_desc *desc, *restart;
>  	struct cpmac_priv *priv = container_of(napi, struct cpmac_priv, napi);
> +	int received = 0, processed = 0;
>  
>  	spin_lock(&priv->rx_lock);
>  	if (unlikely(!priv->rx_head)) {
>  		if (netif_msg_rx_err(priv) && net_ratelimit())
>  			printk(KERN_WARNING "%s: rx: polling, but no queue\n",
>  			       priv->dev->name);
> +		spin_unlock(&priv->rx_lock);
>  		netif_rx_complete(priv->dev, napi);
>  		return 0;
>  	}
>  
>  	desc = priv->rx_head;
> +	restart = NULL;
>  	while (((desc->dataflags & CPMAC_OWN) == 0) && (received < budget)) {
> +		processed++;
> +
> +		if ((desc->dataflags & CPMAC_EOQ) != 0) {
> +			/* The last update to eoq->hw_next didn't happen
> +			* soon enough, and the receiver stopped here.
> +			*Remember this descriptor so we can restart
> +			* the receiver after freeing some space.
> +			*/
> +			if (unlikely(restart)) {
> +				if (netif_msg_rx_err(priv))
> +					printk(KERN_ERR "%s: poll found a"
> +						" duplicate EOQ: %p and %p\n",
> +						priv->dev->name, restart, desc);
> +				goto fatal_error;
> +			}
> +
> +			restart = desc->next;
> +		}
> +
>  		skb = cpmac_rx_one(priv, desc);
>  		if (likely(skb)) {
>  			netif_receive_skb(skb);
> @@ -435,19 +469,90 @@ static int cpmac_poll(struct napi_struct *napi, int budget)
>  		desc = desc->next;
>  	}
>  
> +	if (desc != priv->rx_head) {
> +		/* We freed some buffers, but not the whole ring,
> +		 * add what we did free to the rx list */
> +		desc->prev->hw_next = (u32)0;
> +		priv->rx_head->prev->hw_next = priv->rx_head->mapping;
> +	}
> +
> +	/* Optimization: If we did not actually process an EOQ (perhaps because
> +	 * of quota limits), check to see if the tail of the queue has EOQ set.
> +	* We should immediately restart in that case so that the receiver can
> +	* restart and run in parallel with more packet processing.
> +	* This lets us handle slightly larger bursts before running
> +	* out of ring space (assuming dev->weight < ring_size) */
> +
> +	if (!restart &&
> +	     (priv->rx_head->prev->dataflags & (CPMAC_OWN|CPMAC_EOQ))
> +		    == CPMAC_EOQ &&
> +	     (priv->rx_head->dataflags & CPMAC_OWN) != 0) {
> +		/* reset EOQ so the poll loop (above) doesn't try to
> +		* restart this when it eventually gets to this descriptor.
> +		*/
> +		priv->rx_head->prev->dataflags &= ~CPMAC_EOQ;
> +		restart = priv->rx_head;
> +	}
> +
> +	if (restart) {
> +		priv->dev->stats.rx_errors++;
> +		priv->dev->stats.rx_fifo_errors++;
> +		if (netif_msg_rx_err(priv) && net_ratelimit())
> +			printk(KERN_WARNING "%s: rx dma ring overrun\n",
> +			       priv->dev->name);
> +
> +		if (unlikely((restart->dataflags & CPMAC_OWN) == 0)) {
> +			if (netif_msg_drv(priv))
> +				printk(KERN_ERR "%s: cpmac_poll is trying to "
> +					"restart rx from a descriptor that's "
> +					"not free: %p\n",
> +					priv->dev->name, restart);
> +				goto fatal_error;
> +		}
> +
> +		cpmac_write(priv->regs, CPMAC_RX_PTR(0), restart->mapping);
> +	}
> +
>  	priv->rx_head = desc;
>  	spin_unlock(&priv->rx_lock);
>  	if (unlikely(netif_msg_rx_status(priv)))
>  		printk(KERN_DEBUG "%s: poll processed %d packets\n",
>  		       priv->dev->name, received);
> -	if (desc->dataflags & CPMAC_OWN) {
> +	if (processed == 0) {
> +		/* we ran out of packets to read,
> +		 * revert to interrupt-driven mode */
>  		netif_rx_complete(priv->dev, napi);
> -		cpmac_write(priv->regs, CPMAC_RX_PTR(0), (u32)desc->mapping);
>  		cpmac_write(priv->regs, CPMAC_RX_INT_ENABLE, 1);
>  		return 0;
>  	}
>  
>  	return 1;
> +
> +fatal_error:
> +	/* Something went horribly wrong.
> +	 * Reset hardware to try to recover rather than wedging. */
> +
> +	if (netif_msg_drv(priv)) {
> +		printk(KERN_ERR "%s: cpmac_poll is confused. "
> +				"Resetting hardware\n", priv->dev->name);
> +		cpmac_dump_all_desc(priv->dev);
> +		printk(KERN_DEBUG "%s: RX_PTR(0)=0x%08x RX_ACK(0)=0x%08x\n",
> +			priv->dev->name,
> +			cpmac_read(priv->regs, CPMAC_RX_PTR(0)),
> +			cpmac_read(priv->regs, CPMAC_RX_ACK(0)));
> +	}
> +
> +	spin_unlock(&priv->rx_lock);
> +	netif_rx_complete(priv->dev, napi);
> +	netif_stop_queue(priv->dev);
> +	napi_disable(&priv->napi);
> +
> +	atomic_inc(&priv->reset_pending);
> +	cpmac_hw_stop(priv->dev);
> +	if (!schedule_work(&priv->reset_work))
> +		atomic_dec(&priv->reset_pending);
> +	return 0;
> +
>  }
>  
>  static int cpmac_start_xmit(struct sk_buff *skb, struct net_device *dev)
> @@ -456,6 +561,9 @@ static int cpmac_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  	struct cpmac_desc *desc;
>  	struct cpmac_priv *priv = netdev_priv(dev);
>  
> +	if (unlikely(atomic_read(&priv->reset_pending)))
> +		return NETDEV_TX_BUSY;
> +
>  	if (unlikely(skb_padto(skb, ETH_ZLEN)))
>  		return NETDEV_TX_OK;
>  
> @@ -621,8 +729,10 @@ static void cpmac_clear_rx(struct net_device *dev)
>  			desc->dataflags = CPMAC_OWN;
>  			dev->stats.rx_dropped++;
>  		}
> +		desc->hw_next = desc->next->mapping;
>  		desc = desc->next;
>  	}
> +	priv->rx_head->prev->hw_next = 0;
>  }
>  
>  static void cpmac_clear_tx(struct net_device *dev)
> @@ -635,14 +745,14 @@ static void cpmac_clear_tx(struct net_device *dev)
>  		priv->desc_ring[i].dataflags = 0;
>  		if (priv->desc_ring[i].skb) {
>  			dev_kfree_skb_any(priv->desc_ring[i].skb);
> -			if (netif_subqueue_stopped(dev, i))
> -			    netif_wake_subqueue(dev, i);
> +			priv->desc_ring[i].skb = NULL;
>  		}
>  	}
>  }
>  
>  static void cpmac_hw_error(struct work_struct *work)
>  {
> +	int i;
>  	struct cpmac_priv *priv =
>  		container_of(work, struct cpmac_priv, reset_work);
>  
> @@ -651,8 +761,48 @@ static void cpmac_hw_error(struct work_struct *work)
>  	spin_unlock(&priv->rx_lock);
>  	cpmac_clear_tx(priv->dev);
>  	cpmac_hw_start(priv->dev);
> -	napi_enable(&priv->napi);
> -	netif_start_queue(priv->dev);
> +	barrier();
> +	atomic_dec(&priv->reset_pending);
> +
> +	for (i = 0; i < CPMAC_QUEUES; i++)
> +		netif_wake_subqueue(priv->dev, i);
> +	netif_wake_queue(priv->dev);
> +	cpmac_write(priv->regs, CPMAC_MAC_INT_ENABLE, 3);
> +}
> +
> +static void cpmac_check_status(struct net_device *dev)
> +{
> +	struct cpmac_priv *priv = netdev_priv(dev);
> +
> +	u32 macstatus = cpmac_read(priv->regs, CPMAC_MAC_STATUS);
> +	int rx_channel = (macstatus >> 8) & 7;
> +	int rx_code = (macstatus >> 12) & 15;
> +	int tx_channel = (macstatus >> 16) & 7;
> +	int tx_code = (macstatus >> 20) & 15;
> +
> +	if (rx_code || tx_code) {
> +		if (netif_msg_drv(priv) && net_ratelimit()) {
> +			/* Can't find any documentation on what these
> +			 *error codes actually are. So just log them and hope..
> +			 */
> +			if (rx_code)
> +				printk(KERN_WARNING "%s: host error %d on rx "
> +				     "channel %d (macstatus %08x), resetting\n",
> +				     dev->name, rx_code, rx_channel, macstatus);
> +			if (tx_code)
> +				printk(KERN_WARNING "%s: host error %d on tx "
> +				     "channel %d (macstatus %08x), resetting\n",
> +				     dev->name, tx_code, tx_channel, macstatus);
> +		}
> +
> +		netif_stop_queue(dev);
> +		cpmac_hw_stop(dev);
> +		if (schedule_work(&priv->reset_work))
> +			atomic_inc(&priv->reset_pending);
> +		if (unlikely(netif_msg_hw(priv)))
> +			cpmac_dump_regs(dev);
> +	}
> +	cpmac_write(priv->regs, CPMAC_MAC_INT_CLEAR, 0xff);
>  }
>  
>  static irqreturn_t cpmac_irq(int irq, void *dev_id)
> @@ -683,49 +833,32 @@ static irqreturn_t cpmac_irq(int irq, void *dev_id)
>  
>  	cpmac_write(priv->regs, CPMAC_MAC_EOI_VECTOR, 0);
>  
> -	if (unlikely(status & (MAC_INT_HOST | MAC_INT_STATUS))) {
> -		if (netif_msg_drv(priv) && net_ratelimit())
> -			printk(KERN_ERR "%s: hw error, resetting...\n",
> -			       dev->name);
> -		netif_stop_queue(dev);
> -		napi_disable(&priv->napi);
> -		cpmac_hw_stop(dev);
> -		schedule_work(&priv->reset_work);
> -		if (unlikely(netif_msg_hw(priv)))
> -			cpmac_dump_regs(dev);
> -	}
> +	if (unlikely(status & (MAC_INT_HOST | MAC_INT_STATUS)))
> +		cpmac_check_status(dev);
>  
>  	return IRQ_HANDLED;
>  }
>  
>  static void cpmac_tx_timeout(struct net_device *dev)
>  {
> -	struct cpmac_priv *priv = netdev_priv(dev);
>  	int i;
> +	struct cpmac_priv *priv = netdev_priv(dev);
>  
>  	spin_lock(&priv->lock);
>  	dev->stats.tx_errors++;
>  	spin_unlock(&priv->lock);
>  	if (netif_msg_tx_err(priv) && net_ratelimit())
>  		printk(KERN_WARNING "%s: transmit timeout\n", dev->name);
> -	/* 
> -	 * FIXME: waking up random queue is not the best thing to
> -	 * do... on the other hand why we got here at all?
> -	 */
> -#ifdef CONFIG_NETDEVICES_MULTIQUEUE
> +
> +	atomic_inc(&priv->reset_pending);
> +	barrier();
> +	cpmac_clear_tx(dev);
> +	barrier();
> +	atomic_dec(&priv->reset_pending);
> +
> +	netif_wake_queue(priv->dev);
>  	for (i = 0; i < CPMAC_QUEUES; i++)
> -		if (priv->desc_ring[i].skb) {
> -			priv->desc_ring[i].dataflags = 0;
> -			dev_kfree_skb_any(priv->desc_ring[i].skb);
> -			netif_wake_subqueue(dev, i);
> -			break;
> -		}
> -#else
> -	priv->desc_ring[0].dataflags = 0;
> -	if (priv->desc_ring[0].skb)
> -		dev_kfree_skb_any(priv->desc_ring[0].skb);
> -	netif_wake_queue(dev);
> -#endif
> +		netif_wake_subqueue(dev, i);
>  }
>  
>  static int cpmac_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
> @@ -901,9 +1034,12 @@ static int cpmac_open(struct net_device *dev)
>  		desc->buflen = CPMAC_SKB_SIZE;
>  		desc->dataflags = CPMAC_OWN;
>  		desc->next = &priv->rx_head[(i + 1) % priv->ring_size];
> +		desc->next->prev = desc;
>  		desc->hw_next = (u32)desc->next->mapping;
>  	}
>  
> +	priv->rx_head->prev->hw_next = (u32)0;
> +
>  	if ((res = request_irq(dev->irq, cpmac_irq, IRQF_SHARED,
>  			       dev->name, dev))) {
>  		if (netif_msg_drv(priv))
> @@ -912,6 +1048,7 @@ static int cpmac_open(struct net_device *dev)
>  		goto fail_irq;
>  	}
>  
> +	atomic_set(&priv->reset_pending, 0);
>  	INIT_WORK(&priv->reset_work, cpmac_hw_error);
>  	cpmac_hw_start(dev);
>  
> @@ -1007,21 +1144,10 @@ static int __devinit cpmac_probe(struct platform_device *pdev)
>  
>  	if (phy_id == PHY_MAX_ADDR) {
>  		if (external_switch || dumb_switch) {
> -			struct fixed_phy_status status = {};
> -
> -			/*
> -			 * FIXME: this should be in the platform code!
> -			 * Since there is not platform code at all (that is,
> -			 * no mainline users of that driver), place it here
> -			 * for now.
> -			 */
> -			phy_id = 0;
> -			status.link = 1;
> -			status.duplex = 1;
> -			status.speed = 100;
> -			fixed_phy_add(PHY_POLL, phy_id, &status);
> +			mdio_bus_id = 0; /* fixed phys bus */
> +			phy_id = pdev->id;
>  		} else {
> -			printk(KERN_ERR "cpmac: no PHY present\n");
> +			dev_err(&pdev->dev, "no PHY present\n");
>  			return -ENODEV;
>  		}
>  	}
> @@ -1064,10 +1190,8 @@ static int __devinit cpmac_probe(struct platform_device *pdev)
>  	priv->msg_enable = netif_msg_init(debug_level, 0xff);
>  	memcpy(dev->dev_addr, pdata->dev_addr, sizeof(dev->dev_addr));
>  
> -	snprintf(priv->phy_name, BUS_ID_SIZE, PHY_ID_FMT, mdio_bus_id, phy_id);
> -
> -	priv->phy = phy_connect(dev, priv->phy_name, &cpmac_adjust_link, 0,
> -				PHY_INTERFACE_MODE_MII);
> +	priv->phy = phy_connect(dev, cpmac_mii.phy_map[phy_id]->dev.bus_id,
> +				&cpmac_adjust_link, 0, PHY_INTERFACE_MODE_MII);
>  	if (IS_ERR(priv->phy)) {
>  		if (netif_msg_drv(priv))

applied
