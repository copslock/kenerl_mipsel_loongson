Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Jun 2003 02:58:59 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:10997 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225197AbTF2B65>;
	Sun, 29 Jun 2003 02:58:57 +0100
Received: from [10.2.2.20] (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id SAA18672;
	Sat, 28 Jun 2003 18:58:47 -0700
Subject: Re: [PATCH] au1000_eth.c - Dave Jones
From: Pete Popov <ppopov@mvista.com>
To: joeg@clearcore.com
Cc: linux-mips@linux-mips.org
In-Reply-To: <20030614052652.8161.qmail@clearcore.com>
References: <20030614052652.8161.qmail@clearcore.com>
Content-Type: text/plain
Organization: 
Message-Id: <1056852170.1808.9.camel@adsl.pacbell.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 28 Jun 2003 19:02:50 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2718
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

Joe,

On Fri, 2003-06-13 at 22:26, Joe George wrote:
> This patch was submitted on lkml by Dave Jones and reviewed
> by Jeff Garzik.  Description:

In its exact form, the patch breaks the driver pretty badly.

> - Missing release region

OK.

> - Unneeded initialization of private struct
>   (already done in init_etherdev)

OK. But the "aup = dev->priv" was removed incorrectly. The pointer is
later used in the routine.

> - Remove unneeded freeing of dev-priv
>   (auto-free'd by kfree(dev)
> - actually kfree(dev), plugging leak.

No, the kfree(dev) can't be done there.  It probably should be done in
the cleanup_module routine but I haven't tested this driver as a module
in a very long time, so there may be other problems that need to get
fixed up.

The _probe1 routine allocs the dev structure and probe1 never gets
called again after the initialization. The eth0 and eth1 are both
brought up, but then eth1 is brought down because it's not in use. If
you do kfree(dev) in the _close routine, the next time you do "ifconfig
eth1 <ipaddress>" the driver will crash.  If eth1 is never used, then
the space allocated by "dev" is wasted ... but given that the dual macs
are probably some of the most widely used peripherals on that chip, I
doubt that that's a big problem.

I made these changes and applied the patch.

Pete

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
