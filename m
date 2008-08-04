Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Aug 2008 22:27:00 +0100 (BST)
Received: from mail.gmx.net ([213.165.64.20]:9123 "HELO mail.gmx.net")
	by ftp.linux-mips.org with SMTP id S20045465AbYHDV0x (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 4 Aug 2008 22:26:53 +0100
Received: (qmail invoked by alias); 04 Aug 2008 21:26:45 -0000
Received: from p548B1C75.dip0.t-ipconnect.de (EHLO [192.168.120.22]) [84.139.28.117]
  by mail.gmx.net (mp053) with SMTP; 04 Aug 2008 23:26:45 +0200
X-Authenticated: #16080105
X-Provags-ID: V01U2FsdGVkX1+ZZZQxuKaZYa3U03AHcAYiDgBqaLbTksM7lVOL+M
	80vm3mkbAj3UHB
Message-ID: <4897741C.1090300@gmx.de>
Date:	Mon, 04 Aug 2008 23:26:52 +0200
From:	Johannes Dickgreber <tanzy@gmx.de>
User-Agent: Thunderbird 2.0.0.6 (X11/20070801)
MIME-Version: 1.0
To:	Kumba <kumba@gentoo.org>
CC:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH/RFC]: SGI Octane (IP30) Patches, Part two, Octane core
References: <48914C74.6090309@gentoo.org>
In-Reply-To: <48914C74.6090309@gentoo.org>
X-Enigmail-Version: 0.95.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.42
Return-Path: <tanzy@gmx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20095
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tanzy@gmx.de
Precedence: bulk
X-list: linux-mips

Kumba schrieb:
> 
> The second part is the actual IP30 Patch that makes these beasts boot. 
> Assuming you've already lit incense candles and sacrificed a PC to the
> MIPS Gods above.
> 

> Thanks!,
> 
> 
> --Kumba
> 



> diff -Naurp linux-2.6.26.orig/arch/mips/kernel/cevt-r4k.c linux-2.6.26/arch/mips/kernel/cevt-r4k.c
> --- linux-2.6.26.orig/arch/mips/kernel/cevt-r4k.c	2008-07-13 17:51:29.000000000 -0400
> +++ linux-2.6.26/arch/mips/kernel/cevt-r4k.c	2008-07-25 03:14:40.000000000 -0400
> @@ -251,7 +251,6 @@ int __cpuinit mips_clockevent_init(void)
>  	irq = MIPS_CPU_IRQ_BASE + cp0_compare_irq;
>  	if (get_c0_compare_int)
>  		irq = get_c0_compare_int();
> -
>  	cd = &per_cpu(mips_clockevent_device, cpu);
>  
>  	cd->name		= "MIPS";
I dont think this is needed

> diff -Naurp linux-2.6.26.orig/arch/mips/kernel/setup.c linux-2.6.26/arch/mips/kernel/setup.c
> --- linux-2.6.26.orig/arch/mips/kernel/setup.c	2008-07-13 17:51:29.000000000 -0400
> +++ linux-2.6.26/arch/mips/kernel/setup.c	2008-07-25 03:14:40.000000000 -0400
> @@ -481,6 +481,10 @@ static void __init arch_mem_init(char **
>  	printk("Determined physical RAM map:\n");
>  	print_memory_map();
>  
> +#ifdef CONFIG_CMDLINE
> +	if (strlen(CONFIG_CMDLINE))
> +		strlcpy(arcs_cmdline, CONFIG_CMDLINE, sizeof(command_line));
> +#endif
>  	strlcpy(command_line, arcs_cmdline, sizeof(command_line));
>  	strlcpy(boot_command_line, command_line, COMMAND_LINE_SIZE);
>  
> @@ -575,7 +579,6 @@ void __init setup_arch(char **cmdline_p)
>  #endif
>  
>  	arch_mem_init(cmdline_p);
> -
>  	resource_init();
>  	plat_smp_setup();
>  }
arcs_cmdline is initialisiert with CONFIG_CMDLINE earlier in this file,
so i think this is not needed.

> diff -Naurp linux-2.6.26.orig/arch/mips/mm/dma-default.c linux-2.6.26/arch/mips/mm/dma-default.c
> --- linux-2.6.26.orig/arch/mips/mm/dma-default.c	2008-07-13 17:51:29.000000000 -0400
> +++ linux-2.6.26/arch/mips/mm/dma-default.c	2008-07-25 03:14:40.000000000 -0400
> @@ -209,7 +209,7 @@ dma_addr_t dma_map_page(struct device *d
>  		dma_cache_wback_inv(addr, size);
>  	}
>  
> -	return plat_map_dma_mem_page(dev, page) + offset;
> +	return plat_map_dma_mem_page(dev, page, size) + offset;
>  }
>  
>  EXPORT_SYMBOL(dma_map_page);
see other mail


> diff -Naurp linux-2.6.26.orig/drivers/usb/host/pci-quirks.c linux-2.6.26/drivers/usb/host/pci-quirks.c
> --- linux-2.6.26.orig/drivers/usb/host/pci-quirks.c	2008-07-13 17:51:29.000000000 -0400
> +++ linux-2.6.26/drivers/usb/host/pci-quirks.c	2008-07-25 03:14:40.000000000 -0400
> @@ -147,6 +147,9 @@ static void __devinit quirk_usb_handoff_
>  	unsigned long base = 0;
>  	int i;
>  
> +	if (!pci_enable_device(pdev))
> +		return;
> +
>  	if (!pio_enabled(pdev))
>  		return;
>  
I am not using this, but i dont have any usb stuff at my Octane

> diff -Naurp linux-2.6.26.orig/include/asm-mips/addrspace.h linux-2.6.26/include/asm-mips/addrspace.h
> --- linux-2.6.26.orig/include/asm-mips/addrspace.h	2008-07-13 17:51:29.000000000 -0400
> +++ linux-2.6.26/include/asm-mips/addrspace.h	2008-07-25 03:14:40.000000000 -0400
> @@ -54,6 +54,14 @@
>  #define XPHYSADDR(a)            ((_ACAST64_(a)) &			\
>  				 _CONST64_(0x000000ffffffffff))
>  
> +#ifndef __ASSEMBLY__
> +#ifdef CONFIG_64BIT
> +unsigned long kernel_physaddr(unsigned long);
> +#else
> +#define kernel_physaddr CPHYSADDR
> +#endif
> +#endif
> +
>  #ifdef CONFIG_64BIT
>  
>  /*
is this used anyware, i dont have it in my kernel.

> diff -Naurp linux-2.6.26.orig/include/asm-mips/mach-ip30/dma-coherence.h linux-2.6.26/include/asm-mips/mach-ip30/dma-coherence.h
> --- linux-2.6.26.orig/include/asm-mips/mach-ip30/dma-coherence.h	1969-12-31 19:00:00.000000000 -0500
> +++ linux-2.6.26/include/asm-mips/mach-ip30/dma-coherence.h	2008-07-25 03:14:40.000000000 -0400
> @@ -0,0 +1,90 @@
> +/*
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + * Copyright (C) 2006  Ralf Baechle <ralf@linux-mips.org>
> + *               2007  Joshua Kinard <kumba@gentoo.org>
> + *
> + * derived from include/asm-mips/mach-ip27/dma-coherence.h
> + * and based on code found in the old dma-ip30.c, which is
> + * Copyright (C) 2004-2007 Stanislaw Skowronek <skylark@linux-mips.org>
> + */
> +#ifndef __ASM_MACH_IP30_DMA_COHERENCE_H
> +#define __ASM_MACH_IP30_DMA_COHERENCE_H
> +
> +#include <asm/mach-ip30/addrs.h>
> +#include <asm/pci/bridge.h>
> +
> +#include <linux/dma-mapping.h>
> +
> +static inline dma_addr_t pdev_to_baddr(struct pci_dev *dev, dma_addr_t addr,
> +					int virt, int size)
> +{
> +	if(dev->dma_mask == DMA_64BIT_MASK) {
> +		if(virt)
> +			return (BRIDGE_CONTROLLER(dev->bus)->baddr + addr) |
> +				PCI64_ATTR_VIRTUAL;
> +
> +		if(size >= 0x200)
> +			return (BRIDGE_CONTROLLER(dev->bus)->baddr + addr) |
> +				PCI64_ATTR_PREF;
> +
> +		if(addr >= 0x20000000 || addr < 0xA0000000)
> +			return (PCI32_DIRECT_BASE + addr - 0x20000000);
> +
> +		return (BRIDGE_CONTROLLER(dev->bus)->baddr + addr);
> +	}
> +
> +	if(addr < 0x20000000 || addr >= 0xA0000000) {
> +		printk(KERN_ERR
> +			"BRIDGE: Mapping can't be realized in direct DMA.\n");
> +		return -1;
> +	}
> +
> +	return (PCI32_DIRECT_BASE + addr - 0x20000000);
> +}
> +
> +static inline dma_addr_t dev_to_baddr(struct device *dev, dma_addr_t addr,
> +					int virt, int size)
> +{
> +	if(dev)
> +		return pdev_to_baddr(to_pci_dev(dev), addr, virt, size);
> +	return addr;
> +}
> +
> +struct device;
> +
> +static inline dma_addr_t plat_map_dma_mem(struct device *dev, void *addr,
> +					size_t size)
> +{
> +	dma_addr_t pa = dev_to_baddr(dev, virt_to_phys(addr), 1, size);
> +
> +	return pa;
> +}
> +
> +static dma_addr_t plat_map_dma_mem_page(struct device *dev, struct page *page,
> +					size_t size)
> +{
> +	dma_addr_t pa = dev_to_baddr(dev, page_to_phys(page), 0, size);
> +
> +	return pa;
> +}
> +
> +static unsigned long plat_dma_addr_to_phys(dma_addr_t dma_addr)
> +{
> +	return dma_addr & (0xffUL << 56);
> +}
> +
> +static inline void plat_unmap_dma_mem(dma_addr_t dma_addr)
> +{
> +	/* Empty */
> +}
> +
> +static inline int plat_device_is_coherent(struct device *dev)
> +{
> +	return 1;		/* IP30 non-cohernet mode is unsupported
> +				 * (does it even have one?) */
> +}
> +
> +#endif /* __ASM_MACH_IP30_DMA_COHERENCE_H */
see other mail for the size in plat_map_dma_mem_page wich IMHO schould be PAGE_SIZE



bye tanzy
