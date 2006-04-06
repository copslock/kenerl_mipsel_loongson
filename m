Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Apr 2006 15:33:48 +0100 (BST)
Received: from rtsoft2.corbina.net ([85.21.88.2]:56761 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133467AbWDFOdj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 6 Apr 2006 15:33:39 +0100
Received: (qmail 30386 invoked from network); 6 Apr 2006 18:46:15 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 6 Apr 2006 18:46:15 -0000
Message-ID: <4435290C.50607@ru.mvista.com>
Date:	Thu, 06 Apr 2006 18:43:24 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Linux MIPS <linux-mips@linux-mips.org>
CC:	Rodolfo Giometti <giometti@linux.it>,
	Jordan Crouse <jordan.crouse@amd.com>,
	Pete Popov <ppopov@embeddedalley.com>
Subject: Re: [PATCH] Oops! - Re: Power management for au1000_eth.c
References: <20060405154711.GL7029@enneenne.com> <20060405222332.GO7029@enneenne.com> <20060405222620.GP7029@enneenne.com>
In-Reply-To: <20060405222620.GP7029@enneenne.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11048
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Rodolfo Giometti wrote:

>>>I'm trying to add power management support to au1000_eth.c driver.

>>Solved! :)

>>Here a patch to implement power management functions for au1000_eth.

    Actually, the network driver patches should be sent to Jeff Garzik and 
Andrew Morton.

>>Note that this patch needs my previous one who implements new power
>>management's sysfs interface.

> The forgotten attachment. :)

    Funny, I've also been cooking a patch to straighten Alchemy Ethernet 
probing code a bit...

> ------------------------------------------------------------------------
> 
> --- /home/develop/embedded/mipsel/linux/linux-mips.git/arch/mips/au1000/common/au1xxx_irqmap.c	2006-03-31 16:57:26.000000000 +0200
> +++ arch/mips/au1000/common/au1xxx_irqmap.c	2006-04-03 17:50:49.000000000 +0200
> @@ -118,7 +118,7 @@
>  	{ AU1000_USB_DEV_SUS_INT, INTC_INT_RISE_EDGE, 0 },
>  	{ AU1000_USB_HOST_INT, INTC_INT_LOW_LEVEL, 0 },
>  	{ AU1000_ACSYNC_INT, INTC_INT_RISE_EDGE, 0 },
> -	{ AU1500_MAC0_DMA_INT, INTC_INT_HIGH_LEVEL, 0},
> +	{ AU1000_MAC0_DMA_INT, INTC_INT_HIGH_LEVEL, 0},
>  	{ AU1500_MAC1_DMA_INT, INTC_INT_HIGH_LEVEL, 0},
>  	{ AU1000_AC97C_INT, INTC_INT_RISE_EDGE, 0 },
>  
> @@ -152,7 +152,7 @@
>  	{ AU1000_USB_DEV_SUS_INT, INTC_INT_RISE_EDGE, 0 },
>  	{ AU1000_USB_HOST_INT, INTC_INT_LOW_LEVEL, 0 },
>  	{ AU1000_ACSYNC_INT, INTC_INT_RISE_EDGE, 0 },
> -	{ AU1100_MAC0_DMA_INT, INTC_INT_HIGH_LEVEL, 0},
> +	{ AU1000_MAC0_DMA_INT, INTC_INT_HIGH_LEVEL, 0},
>  	/*{ AU1000_GPIO215_208_INT, INTC_INT_HIGH_LEVEL, 0},*/
>  	{ AU1100_LCD_INT, INTC_INT_HIGH_LEVEL, 0},
>  	{ AU1000_AC97C_INT, INTC_INT_RISE_EDGE, 0 },

    Don't think these changes are necessary.

> --- /home/develop/embedded/mipsel/linux/linux-mips.git/arch/mips/au1000/common/platform.c	2006-04-03 18:22:05.000000000 +0200
> +++ arch/mips/au1000/common/platform.c	2006-04-05 23:08:55.000000000 +0200
> @@ -16,6 +16,78 @@
>  
>  #include <asm/mach-au1x00/au1xxx.h>
>  
> +#if defined(CONFIG_MIPS_AU1X00_ENET) || defined(CONFIG_MIPS_AU1X00_ENET_MODULE)
> +/* Ethernet controllers */
> +static struct resource au1xxx_eth0_resources[] = {
> +	[0] = {
> +		.name	= "eth-base",
> +		.start	= ETH0_BASE,
> +		.end	= ETH0_BASE + 0x0ffff,
 > +		.flags	= IORESOURCE_MEM,
 > +	},

    NAK, ETH0_BASE not defined anywhere, and that address differs between SOCs.
Note that this must be a *physical* address, not KSEG1-base.

> +	[1] = {
> +		.name	= "eth-mac",
> +		.start	= MAC0_ENABLE,
> +		.end	= MAC0_ENABLE + 0x0ffff,
 > +		.flags	= IORESOURCE_MEM,
 > +	},

    NAK, because:

1) MAC0_ENABLE not defined anywhere, and that address differs between SOCs;
2) MAC enable register occupies 4 bytes, not 65536.

[...]

> +#if defined(CONFIG_SOC_AU1000) || \
> +    defined(CONFIG_SOC_AU1500) || defined(CONFIG_SOC_AU1550)
> +static struct resource au1xxx_eth1_resources[] = {
> +	[0] = {
> +		.name	= "eth-base",
> +		.start	= ETH1_BASE,
> +		.end	= ETH1_BASE + 0x0ffff,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.name	= "eth-mac",
> +		.start	= MAC1_ENABLE,
> +		.end	= MAC1_ENABLE + 0x0ffff,
 > +		.flags	= IORESOURCE_MEM,
 > +	},

    Same here.

> --- /home/develop/embedded/mipsel/linux/linux-mips.git/drivers/net/au1000_eth.c	2006-04-03 18:23:17.000000000 +0200
> +++ drivers/net/au1000_eth.c	2006-04-05 23:43:18.000000000 +0200

[...]

> @@ -67,8 +71,8 @@
>  static int au1000_debug = 3;
>  #endif
>  
> -#define DRV_NAME	"au1000eth"
> -#define DRV_VERSION	"1.5"
> +#define DRV_NAME	"au1xxx-eth"

    au1000_eth, according to the driver name.

> +#define DRV_VERSION	"1.6"

    Heh, nobody keeps track of the versions. :-)

> @@ -1435,40 +1391,14 @@
>  	.get_link = au1000_get_link
>  };
>  
> -static struct net_device *
> -au1000_probe(u32 ioaddr, int irq, int port_num)
> +static int 
> +au1000_lowlevel_probe(struct net_device *ndev, u32 ioaddr, u32 macen_addr, int port_num)

[...]

> @@ -1477,15 +1407,16 @@
>  			&aup->dma_addr,
>  			0);
>  	if (!aup->vaddr) {
> -		free_netdev(dev);
> -		release_mem_region(CPHYSADDR(ioaddr), MAC_IOSIZE);
> -		return NULL;
> +		printk(KERN_ERR "%s: cannot dma_alloc_noncoherent\n",
> +		       ndev->name);
> +		ret = -ENOMEM;
> +		goto out;
>  	}
>  
>  	/* aup->mac is the base address of the MAC's registers */
>  	aup->mac = (volatile mac_reg_t *)((unsigned long)ioaddr);

    NAK, ioaddr should be physical address.

>  	/* Setup some variables for quick register address access */
> -	if (ioaddr == iflist[0].base_addr)
> +	if (port_num == 0)

    Yep, I disliked this code too. :-)

>  	{
>  		/* check env variables first */
>  		if (!get_ethernet_addr(ethaddr)) { 
> @@ -1495,7 +1426,7 @@
>  			argptr = prom_getcmdline();
>  			if ((pmac = strstr(argptr, "ethaddr=")) == NULL) {
>  				printk(KERN_INFO "%s: No mac address found\n", 
> -						dev->name);
> +						ndev->name);
>  				/* use the hard coded mac addresses */
>  			} else {
>  				str2eaddr(ethaddr, pmac + strlen("ethaddr="));
> @@ -1504,26 +1435,26 @@
>  			}
>  		}
>  			aup->enable = (volatile u32 *) 
> -				((unsigned long)iflist[0].macen_addr);
> -		memcpy(dev->dev_addr, au1000_mac_addr, sizeof(au1000_mac_addr));
> +				((unsigned long) macen_addr);

    NAK, macen_addr should have been a physical address at that point too
(if the plarform definitions were correct :-).  Also, this could have been done
outside of "if".

> +		memcpy(ndev->dev_addr, au1000_mac_addr, sizeof(au1000_mac_addr));

    That too.

>  		setup_hw_rings(aup, MAC0_RX_DMA_ADDR, MAC0_TX_DMA_ADDR);
>  		aup->mac_id = 0;
>  		au_macs[0] = aup;
>  	}
>  		else
> -	if (ioaddr == iflist[1].base_addr)
> +	if (port_num == 1)
>  	{
>  			aup->enable = (volatile u32 *) 
> -				((unsigned long)iflist[1].macen_addr);
> -		memcpy(dev->dev_addr, au1000_mac_addr, sizeof(au1000_mac_addr));
> -		dev->dev_addr[4] += 0x10;
> +				((unsigned long) macen_addr);
> +		memcpy(ndev->dev_addr, au1000_mac_addr, sizeof(au1000_mac_addr));
> +		ndev->dev_addr[4] += 0x10;

    Actually, the DBAu15x0 boards have their Ethernet addresess differ by 1 in 
the last byte, not by 0x10 in the next to last one. This code assigns to the 
port an address different to what's printed on a port's sticker. This should 
be fixed I guess...

>  		setup_hw_rings(aup, MAC1_RX_DMA_ADDR, MAC1_TX_DMA_ADDR);
>  		aup->mac_id = 1;
>  		au_macs[1] = aup;
>  	}
>  	else
>  	{
> -		printk(KERN_ERR "%s: bad ioaddr\n", dev->name);
> +		printk(KERN_ERR "%s: bad ioaddr\n", ndev->name);
>  	}

    Doubt we need this "else" at all...

> @@ -2255,5 +2162,232 @@
>  	return 0;
>  }
>  
> -module_init(au1000_init_module);
> -module_exit(au1000_cleanup_module);
> +/*
> + * Setup the base address and interupt of the Au1xxx ethernet macs
> + * based on cpu type and whether the interface is enabled in sys_pinfunc
> + * register. The last interface is enabled if SYS_PF_NI2 (bit 4) is 0.
> + */
> +static int au1000_drv_probe(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct net_device *ndev;
> +	struct au1000_private *aup;
> +	struct resource *res;
> +	static unsigned version_printed = 0;
> +	u32 base_addr, macen_addr;
> +	int irq, ret;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "eth-base");
> +	if (!res) {
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +	base_addr = res->start;
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "eth-mac");
> +	if (!res) {
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +	macen_addr = res->start;
> +	res = platform_get_resource_byname(pdev, IORESOURCE_IRQ, "eth-irq");
> +	if (!res) {
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +	irq = res->start;
> +
> +	if (!request_mem_region(CPHYSADDR(base_addr), MAC_IOSIZE, "Au1x00 ENET")) {

    NAK, base_addr should adready be a physical address. Also, why no 
request_mem_region()
for the MAC enable register?

> +	ret = au1000_lowlevel_probe(ndev, base_addr, macen_addr, pdev->id);

    Remember, The passed addresses are physical at that point.

[...]

WBR, Sergei
