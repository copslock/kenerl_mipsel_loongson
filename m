Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 May 2009 14:33:34 +0100 (BST)
Received: from smtp.nokia.com ([192.100.122.230]:37860 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20022507AbZEONd0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 15 May 2009 14:33:26 +0100
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n4FDWuPZ026000;
	Fri, 15 May 2009 16:33:04 +0300
Received: from esebh102.NOE.Nokia.com ([172.21.138.183]) by vaebh105.NOE.Nokia.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 15 May 2009 16:32:51 +0300
Received: from mgw-int01.ntc.nokia.com ([172.21.143.96]) by esebh102.NOE.Nokia.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 15 May 2009 16:32:51 +0300
Received: from [172.21.42.232] (esdhcp042232.research.nokia.com [172.21.42.232])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id n4FDWkli011781;
	Fri, 15 May 2009 16:32:49 +0300
Subject: Re: [PATCH] MTD: Remove pmcmsp-ramroot.c
From:	Artem Bityutskiy <dedekind@infradead.org>
Reply-To: dedekind@infradead.org
To:	Marc St-Jean <stjeanma@pmc-sierra.com>
Cc:	linux-mtd@lists.infradead.org, linux-mips@linux-mips.org,
	dwmw2@infradead.org, hch@lst.de, ralf@linux-mips.org,
	linux-kernel@vger.kernel.org,
	Shane McDonald <mcdonald.shane@gmail.com>
In-Reply-To: <E1M0HJu-0007HN-7j@localhost>
References: <E1M0HJu-0007HN-7j@localhost>
Content-Type: text/plain; charset="UTF-8"
Date:	Fri, 15 May 2009 16:32:46 +0300
Message-Id: <1242394366.27996.245.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.5 (2.24.5-1.fc10) 
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 15 May 2009 13:32:51.0303 (UTC) FILETIME=[A4F7FF70:01C9D561]
X-Nokia-AV: Clean
Return-Path: <dedekind@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22730
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dedekind@infradead.org
Precedence: bulk
X-list: linux-mips

I guess it is nice to CC the original author?

On Sat, 2009-05-02 at 09:40 -0600, Shane McDonald wrote:
> The RAMROOT function was a successful but non-portable attempt to append
> the root filesystem to the end of the kernel image.  The preferred and
> portable solution is to use an initramfs instead.
> 
> The only user of this function was the msp71xx configuration
> in the MIPS architecture; as the use of the RAMROOT has been removed
> from that configuration, there are no more users, so this code
> can be removed.
> 
> Signed-off-by: Shane McDonald <mcdonald.shane@gmail.com>
> ---
>  drivers/mtd/maps/Kconfig          |    9 ---
>  drivers/mtd/maps/Makefile         |    1 -
>  drivers/mtd/maps/pmcmsp-ramroot.c |  104 -------------------------------------
>  3 files changed, 0 insertions(+), 114 deletions(-)
>  delete mode 100644 drivers/mtd/maps/pmcmsp-ramroot.c
> 
> diff --git a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
> index 82923bd..2807833 100644
> --- a/drivers/mtd/maps/Kconfig
> +++ b/drivers/mtd/maps/Kconfig
> @@ -105,15 +105,6 @@ config MSP_FLASH_MAP_LIMIT
>  	default "0x02000000"
>  	depends on MSP_FLASH_MAP_LIMIT_32M
>  
> -config MTD_PMC_MSP_RAMROOT
> -	tristate "Embedded RAM block device for root on PMC-Sierra MSP"
> -	depends on PMC_MSP_EMBEDDED_ROOTFS && \
> -			(MTD_BLOCK || MTD_BLOCK_RO) && \
> -			MTD_RAM
> -	help
> -	  This provides support for the embedded root file system
> -          on PMC MSP devices.  This memory is mapped as a MTD block device.
> -
>  config MTD_SUN_UFLASH
>  	tristate "Sun Microsystems userflash support"
>  	depends on SPARC && MTD_CFI && PCI
> diff --git a/drivers/mtd/maps/Makefile b/drivers/mtd/maps/Makefile
> index 2dbc1be..8bae7f9 100644
> --- a/drivers/mtd/maps/Makefile
> +++ b/drivers/mtd/maps/Makefile
> @@ -25,7 +25,6 @@ obj-$(CONFIG_MTD_OCTAGON)	+= octagon-5066.o
>  obj-$(CONFIG_MTD_PHYSMAP)	+= physmap.o
>  obj-$(CONFIG_MTD_PHYSMAP_OF)	+= physmap_of.o
>  obj-$(CONFIG_MTD_PMC_MSP_EVM)   += pmcmsp-flash.o
> -obj-$(CONFIG_MTD_PMC_MSP_RAMROOT)+= pmcmsp-ramroot.o
>  obj-$(CONFIG_MTD_PCMCIA)	+= pcmciamtd.o
>  obj-$(CONFIG_MTD_RPXLITE)	+= rpxlite.o
>  obj-$(CONFIG_MTD_TQM8XXL)	+= tqm8xxl.o
> diff --git a/drivers/mtd/maps/pmcmsp-ramroot.c b/drivers/mtd/maps/pmcmsp-ramroot.c
> deleted file mode 100644
> index 30de5c0..0000000
> --- a/drivers/mtd/maps/pmcmsp-ramroot.c
> +++ /dev/null
> @@ -1,104 +0,0 @@
> -/*
> - * Mapping of the rootfs in a physical region of memory
> - *
> - * Copyright (C) 2005-2007 PMC-Sierra Inc.
> - * Author: Andrew Hughes, Andrew_Hughes@pmc-sierra.com
> - *
> - *  This program is free software; you can redistribute  it and/or modify it
> - *  under  the terms of  the GNU General  Public License as published by the
> - *  Free Software Foundation;  either version 2 of the  License, or (at your
> - *  option) any later version.
> - *
> - *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
> - *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
> - *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
> - *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
> - *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
> - *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
> - *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
> - *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
> - *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
> - *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> - *
> - *  You should have received a copy of the  GNU General Public License along
> - *  with this program; if not, write  to the Free Software Foundation, Inc.,
> - *  675 Mass Ave, Cambridge, MA 02139, USA.
> - */
> -
> -#include <linux/module.h>
> -#include <linux/types.h>
> -#include <linux/kernel.h>
> -#include <linux/init.h>
> -#include <linux/slab.h>
> -#include <linux/fs.h>
> -#include <linux/root_dev.h>
> -#include <linux/mtd/mtd.h>
> -#include <linux/mtd/map.h>
> -
> -#include <asm/io.h>
> -
> -#include <msp_prom.h>
> -
> -static struct mtd_info *rr_mtd;
> -
> -struct map_info rr_map = {
> -	.name = "ramroot",
> -	.bankwidth = 4,
> -};
> -
> -static int __init init_rrmap(void)
> -{
> -	void *ramroot_start;
> -	unsigned long ramroot_size;
> -
> -	/* Check for supported rootfs types */
> -	if (get_ramroot(&ramroot_start, &ramroot_size)) {
> -		rr_map.phys = CPHYSADDR(ramroot_start);
> -		rr_map.size = ramroot_size;
> -
> -		printk(KERN_NOTICE
> -			"PMC embedded root device: 0x%08lx @ 0x%08lx\n",
> -			rr_map.size, (unsigned long)rr_map.phys);
> -	} else {
> -		printk(KERN_ERR
> -			"init_rrmap: no supported embedded rootfs detected!\n");
> -		return -ENXIO;
> -	}
> -
> -	/* Map rootfs to I/O space for block device driver */
> -	rr_map.virt = ioremap(rr_map.phys, rr_map.size);
> -	if (!rr_map.virt) {
> -		printk(KERN_ERR "Failed to ioremap\n");
> -		return -EIO;
> -	}
> -
> -	simple_map_init(&rr_map);
> -
> -	rr_mtd = do_map_probe("map_ram", &rr_map);
> -	if (rr_mtd) {
> -		rr_mtd->owner = THIS_MODULE;
> -
> -		add_mtd_device(rr_mtd);
> -
> -		return 0;
> -	}
> -
> -	iounmap(rr_map.virt);
> -	return -ENXIO;
> -}
> -
> -static void __exit cleanup_rrmap(void)
> -{
> -	del_mtd_device(rr_mtd);
> -	map_destroy(rr_mtd);
> -
> -	iounmap(rr_map.virt);
> -	rr_map.virt = NULL;
> -}
> -
> -MODULE_AUTHOR("PMC-Sierra, Inc");
> -MODULE_DESCRIPTION("MTD map driver for embedded PMC-Sierra MSP filesystem");
> -MODULE_LICENSE("GPL");
> -
> -module_init(init_rrmap);
> -module_exit(cleanup_rrmap);
-- 
Best regards,
Artem Bityutskiy (Битюцкий Артём)
