Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Nov 2004 08:24:07 +0000 (GMT)
Received: from web81005.mail.yahoo.com ([IPv6:::ffff:206.190.37.150]:25458
	"HELO web81005.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8224943AbUKEIYB>; Fri, 5 Nov 2004 08:24:01 +0000
Message-ID: <20041105082354.36787.qmail@web81005.mail.yahoo.com>
Received: from [63.194.214.47] by web81005.mail.yahoo.com via HTTP; Fri, 05 Nov 2004 00:23:54 PST
X-RocketYMMF: pvpopov@pacbell.net
Date: Fri, 5 Nov 2004 00:23:54 -0800 (PST)
From: Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
Subject: Re: ohci-au1xxx.c cleanups and fix for 2.6.10-rc1
To: Herbert Valerio Riedel <hvr@inso.tuwien.ac.at>,
	Pete Popov <ppopov@embeddedalley.com>
Cc: linux-mips@linux-mips.org
In-Reply-To: <1099642775.9984.16.camel@s052.inso.tuwien.ac.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6270
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips


Thanks. We were just working on that too.

Pete

--- Herbert Valerio Riedel <hvr@inso.tuwien.ac.at>
wrote:

> 
> below just a patch to have usb working again for
> 2.6.10-rc1 and some minor cleanups...
> (alas usb still doesn't work on big endian...)
> 
> Index: ohci-au1xxx.c
>
===================================================================
> RCS file:
> /home/cvs/linux/drivers/usb/host/ohci-au1xxx.c,v
> retrieving revision 1.1
> diff -u -r1.1 ohci-au1xxx.c
> --- ohci-au1xxx.c	10 Oct 2004 17:56:25 -0000	1.1
> +++ ohci-au1xxx.c	5 Nov 2004 08:15:05 -0000
> @@ -20,6 +20,21 @@
>  
>  #include <asm/mach-au1x00/au1000.h>
>  
> +#define USBH_ENABLE_BE (1<<0)
> +#define USBH_ENABLE_C  (1<<1)
> +#define USBH_ENABLE_E  (1<<2)
> +#define USBH_ENABLE_CE (1<<3)
> +#define USBH_ENABLE_RD (1<<4)
> +
> +// shall we set USBH_ENABLE_C depending on
> !CONFIG_NONCOHERENT?
> +#ifdef __LITTLE_ENDIAN
> +# define USBH_ENABLE_INIT (USBH_ENABLE_CE |
> USBH_ENABLE_E | USBH_ENABLE_C)
> +#elif __BIG_ENDIAN
> +# define USBH_ENABLE_INIT (USBH_ENABLE_CE |
> USBH_ENABLE_E | USBH_ENABLE_C | USBH_ENABLE_BE)
> +#else
> +# error not byte order defined
> +#endif
> +
>  extern int usb_disabled(void);
>  
> 
>
/*-------------------------------------------------------------------------*/
> @@ -30,18 +45,17 @@
>  	       ": starting Au1xxx OHCI USB Controller\n");
>  
>  	/* enable host controller */
> -	au_writel(0x00000008, USB_HOST_CONFIG);
> +	au_writel(USBH_ENABLE_CE, USB_HOST_CONFIG);
>  	udelay(1000);
> -	au_writel(0x0000000e, USB_HOST_CONFIG);
> +	au_writel(USBH_ENABLE_INIT, USB_HOST_CONFIG);
>  	udelay(1000);
>  
> -	/* wait for reset complete */
> -	au_readl(USB_HOST_CONFIG); /* throw away first
> read */
> -	while (!(au_readl(USB_HOST_CONFIG) & 0x10))
> -		au_readl(USB_HOST_CONFIG);
> +	/* wait for reset complete (read register twice;
> see to au1500 errata) */
> +	while (au_readl(USB_HOST_CONFIG),
> !(au_readl(USB_HOST_CONFIG) & USBH_ENABLE_RD)) 
> +	  udelay(1000);
>  
>  	printk(KERN_DEBUG __FILE__
> -		   ": Clock to USB host has been enabled \n");
> +	       ": Clock to USB host has been enabled \n");
>  }
>  
>  static void au1xxx_stop_hc(struct platform_device
> *dev)
> @@ -49,9 +63,8 @@
>  	printk(KERN_DEBUG __FILE__
>  	       ": stopping Au1xxx OHCI USB Controller\n");
>  
> -
>  	/* Disable clock */
> -	au_writel(readl(USB_HOST_CONFIG) & 0xffffff7,
> USB_HOST_CONFIG);
> +	au_writel(readl(USB_HOST_CONFIG) &
> ~(USBH_ENABLE_RD | USBH_ENABLE_CE),
> USB_HOST_CONFIG);
>  }
>  
>  
> @@ -234,37 +247,15 @@
>  
>  	ohci_dbg (ohci, "ohci_au1xxx_start, ohci:%p",
> ohci);
>  			
> -	ohci->hcca = dma_alloc_noncoherent
> (hcd->self.controller,
> -			sizeof *ohci->hcca, &ohci->hcca_dma, 0);
> -	if (!ohci->hcca)
> -		return -ENOMEM;
> -
> -	ohci_dbg (ohci, "ohci_au1xxx_start,
> ohci->hcca:%p",
> -			ohci->hcca);
> -
> -	memset (ohci->hcca, 0, sizeof (struct ohci_hcca));
> -
> -	if ((ret = ohci_mem_init (ohci)) < 0) {
> -		ohci_stop (hcd);
> +	if ((ret = ohci_init (ohci)) < 0)
>  		return ret;
> -	}
> -	ohci->regs = hcd->regs;
>  
> -	if (hc_reset (ohci) < 0) {
> -		ohci_stop (hcd);
> -		return -ENODEV;
> -	}
> -
> -	if (hc_start (ohci) < 0) {
> +	if ((ret = ohci_run (ohci)) < 0) {
>  		err ("can't start %s", ohci->hcd.self.bus_name);
>  		ohci_stop (hcd);
> -		return -EBUSY;
> +		return ret;
>  	}
> -	create_debug_files (ohci);
>  
> -#ifdef	DEBUG
> -	ohci_dump (ohci, 1);
> -#endif /*DEBUG*/
>  	return 0;
>  }
>  
> 
> 
> 
> -- 
> Herbert Valerio Riedel <hvr@inso.tuwien.ac.at>
> 
> 
> 
