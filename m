Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Mar 2003 22:46:37 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:46576 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225255AbTCMWqg>;
	Thu, 13 Mar 2003 22:46:36 +0000
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id OAA26403;
	Thu, 13 Mar 2003 14:45:27 -0800
Subject: Re: Patches for Au1000: PCI int problem, DB1500 board reset &
	ethernet
From: Pete Popov <ppopov@mvista.com>
To: Hartvig Ekner <hartvig@ekner.info>
Cc: Linux MIPS mailing list <linux-mips@linux-mips.org>
In-Reply-To: <3E70E52E.B6FF1C2A@ekner.info>
References: <3E70E52E.B6FF1C2A@ekner.info>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1047595537.819.131.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 13 Mar 2003 14:45:38 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1746
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Thu, 2003-03-13 at 12:08, Hartvig Ekner wrote:
> Hi,
> 
> The first patch below fixes interrupt setup for DB1500. The PCI interrupts 
> were polarized wrongly, causing a deadlock when used.

Applied. Thanks for catching that one. I had tested the Db1500 pci slot
with a graphics card. I guess the interrupt handling doesn't get tested
with a frame buffer driver :)

> The second patch adds board reset using HW register for DB1500.

I want to see if this is applicable to all Db boards before checking it
in.

> The third patch reverses interrupt handling order for RX & TX to 
> minimize packet loss in high-load situations.

Applied. Though I wonder about the performance when the target is
transmitting heavily vs receiving.

Pete

> 
> /Hartvig
> 
> 
> 
> ______________________________________________________________________
> 
> Index: irq.c
> ===================================================================
> RCS file: /home/cvs/linux/arch/mips/au1000/common/irq.c,v
> retrieving revision 1.11.2.14
> diff -u -r1.11.2.14 irq.c
> --- irq.c	26 Feb 2003 21:14:24 -0000	1.11.2.14
> +++ irq.c	13 Mar 2003 19:45:57 -0000
> @@ -430,14 +430,10 @@
>  			case AU1000_IRDA_RX_INT:
>  
>  			case AU1000_MAC0_DMA_INT:
> -#if defined(CONFIG_MIPS_PB1000) || defined(CONFIG_MIPS_DB1000) || defined(CONFIG_MIPS_DB1500)
> -			case AU1000_MAC1_DMA_INT:
> -#endif
> -#ifdef CONFIG_MIPS_PB1500
> +#if defined(CONFIG_MIPS_PB1000) || defined(CONFIG_MIPS_DB1000) || defined(CONFIG_MIPS_PB1500) || defined(CONFIG_MIPS_DB1500)
>  			case AU1000_MAC1_DMA_INT:
>  #endif
>  			case AU1500_GPIO_204:
> -
>  				setup_local_irq(i, INTC_INT_HIGH_LEVEL, 0);
>  				irq_desc[i].handler = &level_irq_type;
>  				break;
> @@ -446,7 +442,7 @@
>  			case AU1000_GPIO_15:
>  #endif
>  		        case AU1000_USB_HOST_INT:
> -#ifdef CONFIG_MIPS_PB1500
> +#if defined(CONFIG_MIPS_PB1500) || defined(CONFIG_MIPS_DB1500)
>  			case AU1000_PCI_INTA:
>  			case AU1000_PCI_INTB:
>  			case AU1000_PCI_INTC:
> @@ -488,9 +484,9 @@
>  			case AU1000_RTC_MATCH0_INT:
>  			case AU1000_RTC_MATCH1_INT:
>  			case AU1000_RTC_MATCH2_INT:
> -			        setup_local_irq(i, INTC_INT_RISE_EDGE, 0);
> -                                irq_desc[i].handler = &rise_edge_irq_type;
> -                                break;
> +				setup_local_irq(i, INTC_INT_RISE_EDGE, 0);
> +				irq_desc[i].handler = &rise_edge_irq_type;
> +				break;
>  
>  				 // Careful if you change match 2 request!
>  				 // The interrupt handler is called directly
> 
> ______________________________________________________________________
> 
> Index: reset.c
> ===================================================================
> RCS file: /home/cvs/linux/arch/mips/au1000/common/reset.c,v
> retrieving revision 1.2.2.8
> diff -u -r1.2.2.8 reset.c
> --- reset.c	11 Dec 2002 06:12:29 -0000	1.2.2.8
> +++ reset.c	13 Mar 2003 19:46:03 -0000
> @@ -111,15 +111,13 @@
>  	set_c0_config(CONF_CM_UNCACHED);
>  	flush_cache_all();
>  	write_c0_wired(0);
> - 
> -#ifdef CONFIG_MIPS_PB1500
> -	au_writel(0x00000000, 0xAE00001C);
> -#endif
>  
> -#ifdef CONFIG_MIPS_PB1100
> +#if defined(CONFIG_MIPS_PB1500) || defined(CONFIG_MIPS_PB1100) || defined(CONFIG_MIPS_DB1500)
> +	/* Do a HW reset if the board can do it */
> +
>  	au_writel(0x00000000, 0xAE00001C);
>  #endif
> - 
> +
>  	__asm__ __volatile__("jr\t%0"::"r"(0xbfc00000));
>  }
>  
> 
> ______________________________________________________________________
> 
> Index: au1000_eth.c
> ===================================================================
> RCS file: /home/cvs/linux/drivers/net/au1000_eth.c,v
> retrieving revision 1.5.2.15
> diff -u -r1.5.2.15 au1000_eth.c
> --- au1000_eth.c	3 Mar 2003 06:40:30 -0000	1.5.2.15
> +++ au1000_eth.c	13 Mar 2003 20:01:51 -0000
> @@ -1414,8 +1414,11 @@
>  		printk(KERN_ERR "%s: isr: null dev ptr\n", dev->name);
>  		return;
>  	}
> -	au1000_tx_ack(dev);
> +
> +	/* Handle RX interrupts first to minimize chance of overrun */
> +
>  	au1000_rx(dev);
> +	au1000_tx_ack(dev);
>  }
>  
> 
