Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Dec 2011 14:27:59 +0100 (CET)
Received: from mail-we0-f177.google.com ([74.125.82.177]:40075 "EHLO
        mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903728Ab1LRN1y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Dec 2011 14:27:54 +0100
Received: by wera10 with SMTP id a10so1177937wer.36
        for <linux-mips@linux-mips.org>; Sun, 18 Dec 2011 05:27:48 -0800 (PST)
Received: by 10.216.132.213 with SMTP id o63mr5824825wei.11.1324214868500;
        Sun, 18 Dec 2011 05:27:48 -0800 (PST)
Received: from [192.168.2.2] ([91.79.83.96])
        by mx.google.com with ESMTPS id hb10sm21458785wib.16.2011.12.18.05.27.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 18 Dec 2011 05:27:47 -0800 (PST)
Message-ID: <4EEDEA17.4040006@mvista.com>
Date:   Sun, 18 Dec 2011 17:26:47 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:8.0) Gecko/20111105 Thunderbird/8.0
MIME-Version: 1.0
To:     Joshua Kinard <kumba@gentoo.org>
CC:     netdev@vger.kernel.org, Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH] net: meth: Add set_rx_mode hook to fix ICMPv6 neighbor
 discovery
References: <4EED3A3D.9080503@gentoo.org>
In-Reply-To: <4EED3A3D.9080503@gentoo.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 32136
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14440

Hello.

On 18-12-2011 4:56, Joshua Kinard wrote:

> SGI IP32 (O2)'s ethernet driver (meth) lacks a set_rx_mode function, which
> prevents IPv6 from working completely because any ICMPv6 neighbor
> solicitation requests aren't picked up by the driver.  So the machine can
> ping out and connect to other systems, but other systems will have a very
> hard time connecting to the O2.

> Signed-off-by: Joshua Kinard<kumba@gentoo.org>
> ---

    Some minor nits below...

>   drivers/net/ethernet/sgi/meth.c |   60 +++++++++++++++++++++++++++++++++++-----
>   1 file changed, 53 insertions(+), 7 deletions(-)

> --- a/drivers/net/ethernet/sgi/meth.c	2011-12-17 15:51:44.569166824 -0500
> +++ b/drivers/net/ethernet/sgi/meth.c	2011-12-17 15:51:20.259167050 -0500
[...]
> @@ -57,6 +58,12 @@ static const char *meth_str="SGI O2 Fast
>   static int timeout = TX_TIMEOUT;
>   module_param(timeout, int, 0);
>
> +/* Maximum number of multicast addresses to filter (vs. Rx-all-multicast).
> + * MACE Ethernet uses a 64 element hash table based on the Ethernet CRC.
> + */
> +static int multicast_filter_limit = 32;
> +
> +

    On empty oine would be enough...

>   /*
>    * This structure is private to each device. It is used to pass
>    * packets in and out, so there is place for a packet
> @@ -765,15 +775,51 @@ static int meth_ioctl(struct net_device
>   	}
>   }
>
> +static void meth_set_rx_mode(struct net_device *dev)
> +{
> +	struct meth_private *priv = netdev_priv(dev);
> +	unsigned long flags;
> +
> +	netif_stop_queue(dev);
> +	spin_lock_irqsave(&priv->meth_lock, flags);
> +	priv->mac_ctrl&= ~(METH_PROMISC);

    Parens not needed here.

> +
> +	if (dev->flags & IFF_PROMISC) {
> +		priv->mac_ctrl |= METH_PROMISC;
> +		priv->mcast_filter = 0xffffffffffffffffUL;
> +		mace->eth.mac_ctrl = priv->mac_ctrl;
> +		mace->eth.mcast_filter = priv->mcast_filter;
> +	} else if ((netdev_mc_count(dev) > multicast_filter_limit) ||
> +			   (dev->flags & IFF_ALLMULTI)) {
> +			priv->mac_ctrl |= METH_ACCEPT_AMCAST;
> +			priv->mcast_filter = 0xffffffffffffffffUL;
> +			mace->eth.mac_ctrl = priv->mac_ctrl;
> +			mace->eth.mcast_filter = priv->mcast_filter;

     This block is over-indented.

> +	} else {
> +		struct netdev_hw_addr *ha;
> +		priv->mac_ctrl |= METH_ACCEPT_MCAST;
> +
> +		netdev_for_each_mc_addr(ha, dev)
> +			set_bit((ether_crc(ETH_ALEN, ha->addr) >> 26),
> +				    (volatile long unsigned int *)&priv->mcast_filter);
> +
> +		mace->eth.mcast_filter = priv->mcast_filter;

    This last statement is common between all branches, so could be moved out 
of *if*...

> +	}
> +
> +	spin_unlock_irqrestore(&priv->meth_lock, flags);
> +	netif_wake_queue(dev);
> +}
> +
>   static const struct net_device_ops meth_netdev_ops = {
> -	.ndo_open		= meth_open,
> -	.ndo_stop		= meth_release,
> -	.ndo_start_xmit		= meth_tx,
> -	.ndo_do_ioctl		= meth_ioctl,
> -	.ndo_tx_timeout		= meth_tx_timeout,
> -	.ndo_change_mtu		= eth_change_mtu,
> -	.ndo_validate_addr	= eth_validate_addr,
> +	.ndo_open				= meth_open,
> +	.ndo_stop				= meth_release,
> +	.ndo_start_xmit			= meth_tx,
> +	.ndo_do_ioctl			= meth_ioctl,
> +	.ndo_tx_timeout			= meth_tx_timeout,
> +	.ndo_change_mtu			= eth_change_mtu,
> +	.ndo_validate_addr		= eth_validate_addr,
>   	.ndo_set_mac_address	= eth_mac_addr,
> +	.ndo_set_rx_mode    	= meth_set_rx_mode,

    The intializer values are not aligned now, and they were before the patch.

WBR, Sergei
