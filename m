Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Nov 2004 17:32:08 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:24564 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8225274AbUKSRcD>; Fri, 19 Nov 2004 17:32:03 +0000
Received: from mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id 3627C183E0; Fri, 19 Nov 2004 09:32:01 -0800 (PST)
Message-ID: <419E2E10.5020304@mvista.com>
Date: Fri, 19 Nov 2004 09:32:00 -0800
From: Manish Lachwani <mlachwani@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: TheNop <TheNop@gmx.net>
Cc: linux-mips@linux-mips.org
Subject: Re: Titan ethernet driver broken
References: <419D03DE.8090403@gmx.net> <419D04AA.50508@mvista.com> <419D171E.5040507@gmx.net> <419D173E.6050602@mvista.com> <419D1A2D.5000009@gmx.net> <419D1F76.6010603@gmx.net>
In-Reply-To: <419D1F76.6010603@gmx.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6370
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Hello !

If you are interested in creating a patch for supporting Titan GE in 
older Titan versions (1.0 and 1.1), then I have indicated the part of 
the diffs below that you will need to apply to the current driver

>  
>  /*
> + * Do the slowpath route. This route is kicked off
> + * when the IP header is misaligned. Grrr ..
> + */
> +static int titan_ge_slowpath(struct sk_buff *skb,
> +				titan_ge_packet *packet,
> +				struct net_device *netdev)
> +{
> +	struct sk_buff *copy_skb;
> +
> +	copy_skb = dev_alloc_skb(packet->len + 2);
> +
> +	if (!copy_skb) {
> +		dev_kfree_skb_any(packet->skb);
> +		return -1;
> +	}
> +
> +	copy_skb->dev = netdev;
> +	skb_reserve(copy_skb, 2);
> +	skb_put(copy_skb, packet->len);
> +
> +	memcpy(copy_skb->data, skb->data, packet->len);
> +
> +	/* Titan supports Rx checksum offload */
> +	copy_skb->ip_summed = CHECKSUM_HW;
> +	copy_skb->csum = packet->checksum;
> +
> +	copy_skb->protocol = eth_type_trans(copy_skb, netdev);
> +
> +	dev_kfree_skb_any(packet->skb);
> +#ifdef TITAN_RX_NAPI
> +	netif_receive_skb(copy_skb);
> +#else
> +	netif_rx(copy_skb);
> +#endif
> +
> +	return 0;
> +}
> +
> +/*
>   * Threshold beyond which we do the cleaning of
>   * Tx queue and new allocation for the Rx
>   * queue
> @@ -1434,10 +1421,11 @@
>  
>  		titan_ge_eth->rx_ring_skbs--;
>  
> +#ifdef TITAN_RX_NAPI
>  		if (--titan_ge_eth->rx_work_limit < 0)
>  			break;
>  		received_packets++;
> -
> +#endif
>  		stats->rx_packets++;
>  		stats->rx_bytes += packet.len;
>  
> @@ -1456,36 +1444,41 @@
>  		 * idea is to cut down the number of checks and improve
>  		 * the fastpath.
>  		 */
> +		skb_put(skb, packet.len);
>  
> -		skb_put(skb, packet.len - 2);
> -
> -		/*
> -		 * Increment data pointer by two since thats where
> -		 * the MAC starts
> -		 */
> -		skb_reserve(skb, 2);
> -		skb->protocol = eth_type_trans(skb, netdev);
> -		netif_receive_skb(skb);
> +		if (titan_ge_slowpath(skb, &packet, netdev) < 0) 
> +			goto out_next;
>  
> +#ifdef TITAN_RX_NAPI
>  		if (titan_ge_eth->rx_threshold > RX_THRESHOLD) {
>  			ack = titan_ge_rx_task(netdev, titan_ge_eth);
>  			TITAN_GE_WRITE((0x5048 + (port_num << 8)), ack);
>  			titan_ge_eth->rx_threshold = 0;
>  		} else
>  			titan_ge_eth->rx_threshold++;
> +#else
> +		ack = titan_ge_rx_task(netdev, titan_ge_eth);
> +		TITAN_GE_WRITE((0x5048 + (port_num << 8)), ack);
> +#endif
>  
> +out_next:
> +
> +#ifdef TITAN_RX_NAPI
>  		if (titan_ge_eth->tx_threshold > TX_THRESHOLD) {
>  			titan_ge_eth->tx_threshold = 0;
>  			titan_ge_free_tx_queue(titan_ge_eth);
>  		}
>  		else
>  			titan_ge_eth->tx_threshold++;
> +#endif
>  
>  	}
>  	return received_packets;
>  }
>  

Thanks
Manish Lachwani
