Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jun 2003 01:23:05 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:48884 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225239AbTFYAXD>;
	Wed, 25 Jun 2003 01:23:03 +0100
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id RAA15222;
	Tue, 24 Jun 2003 17:22:57 -0700
Subject: Re: [PATCH] au1000_eth.c - Dave Jones
From: Pete Popov <ppopov@mvista.com>
To: joeg@clearcore.com
Cc: Linux MIPS mailing list <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
In-Reply-To: <20030614052652.8161.qmail@clearcore.com>
References: <20030614052652.8161.qmail@clearcore.com>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1056500652.10455.312.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 24 Jun 2003 17:24:13 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2699
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips


I'm behind a few patches. I'll take care of it.

Pete

On Fri, 2003-06-13 at 22:26, Joe George wrote:
> This patch was submitted on lkml by Dave Jones and reviewed
> by Jeff Garzik.  Description:
> 
> - Missing release region
> - Unneeded initialization of private struct
>   (already done in init_etherdev)
> - Remove unneeded freeing of dev-priv
>   (auto-free'd by kfree(dev)
> - actually kfree(dev), plugging leak.
> 
> Joe
> 
> 
> diff -upN linux-mips-cvs24/drivers/net/au1000_eth.c tst_mips24/drivers/net/au1000_eth.c
> --- linux-mips-cvs24/drivers/net/au1000_eth.c	Fri Jun 13 20:15:18 2003
> +++ tst_mips24/drivers/net/au1000_eth.c	Fri Jun 13 22:19:09 2003
> @@ -1110,38 +1110,21 @@ au1000_probe1(struct net_device *dev, lo
>  	char *pmac, *argptr;
>  	char ethaddr[6];
>  
> -	if (!request_region(PHYSADDR(ioaddr), MAC_IOSIZE, "Au1x00 ENET")) {
> +	if (!request_region(PHYSADDR(ioaddr), MAC_IOSIZE, "Au1x00 ENET"))
>  		 return -ENODEV;
> -	}
>  
>  	if (version_printed++ == 0) printk(version);
>  
>  	if (!dev) {
> -		dev = init_etherdev(0, sizeof(struct au1000_private));
> -	}
> -	if (!dev) {
> -		 printk (KERN_ERR "au1000 eth: init_etherdev failed\n");  
> -		 return -ENODEV;
> +		dev = init_etherdev(NULL, sizeof(struct au1000_private));
> +		printk (KERN_ERR "au1000 eth: init_etherdev failed\n");  
> +		release_region(ioaddr, MAC_IOSIZE);
> +		return -ENODEV;
>  	}
>  
>  	printk("%s: Au1xxx ethernet found at 0x%lx, irq %d\n", 
>  			dev->name, ioaddr, irq);
>  
> -	/* Initialize our private structure */
> -	if (dev->priv == NULL) {
> -		aup = (struct au1000_private *) 
> -			kmalloc(sizeof(*aup), GFP_KERNEL);
> -		if (aup == NULL) {
> -			retval = -ENOMEM;
> -			goto free_region;
> -		}
> -		dev->priv = aup;
> -	}
> -
> -	aup = dev->priv;
> -	memset(aup, 0, sizeof(*aup));
> -
> -
>  	/* Allocate the data buffers */
>  	aup->vaddr = (u32)dma_alloc(MAX_BUF_SIZE * 
>  			(NUM_TX_BUFFS+NUM_RX_BUFFS), &aup->dma_addr);
> @@ -1280,8 +1263,6 @@ free_region:
>  	if (aup->vaddr) 
>  		dma_free((void *)aup->vaddr, 
>  				MAX_BUF_SIZE * (NUM_TX_BUFFS+NUM_RX_BUFFS));
> -	if (dev->priv != NULL)
> -		kfree(dev->priv);
>  	kfree(aup->mii);
>  	kfree(dev);
>  	printk(KERN_ERR "%s: au1000_probe1 failed.  Returns %d\n",
> @@ -1450,15 +1431,15 @@ static int au1000_close(struct net_devic
>  	spin_lock_irqsave(&aup->lock, flags);
>  	
>  	/* stop the device */
> -	if (netif_device_present(dev)) {
> +	if (netif_device_present(dev))
>  		netif_stop_queue(dev);
> -	}
>  
>  	/* disable the interrupt */
>  	free_irq(dev->irq, dev);
>  	spin_unlock_irqrestore(&aup->lock, flags);
>  
>  	reset_mac(dev);
> +	kfree(dev);
>  	MOD_DEC_USE_COUNT;
>  	return 0;
>  }
> 
> 
