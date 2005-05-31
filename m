Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 May 2005 14:46:35 +0100 (BST)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:55721 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225785AbVEaNqU>;
	Tue, 31 May 2005 14:46:20 +0100
Received: from numbat.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id j4VDkEEe010341;
	Tue, 31 May 2005 15:46:16 +0200 (MEST)
Date:	Tue, 31 May 2005 15:45:48 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Sergey Podstavin <spodstavin@ru.mvista.com>
cc:	adaplas@pol.net, linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] A video driver for Lynx3DM on NEC VR5701-SG2 Board.
In-Reply-To: <1117546071.5564.20.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0505311537560.15699@numbat.sonytel.be>
References: <1117546071.5564.20.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8028
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Tue, 31 May 2005, Sergey Podstavin wrote:
> Attached is a video driver for Lynx3DM SM722, Silicon Motion Inc. It was
> designed for NEC VR5701-SG2 Board, MIPS-CPU Vr5701. Please review it.

> --- linux_save/drivers/video/Kconfig	2005-05-19 16:08:32.000000000 +0400
> +++ linux_mips/drivers/video/Kconfig	2005-05-31 17:00:36.000000000 +0400
> @@ -1027,6 +1027,25 @@ config FB_ATY_GX
>  	  is at
>  	  <http://support.ati.com/products/pc/mach64/graphics_xpression.html>.
>  
> +config FB_SM
> +	tristate "Silicon Motion SM722 support"
> +	depends on FB && PCI
> +	help
> +	  SM722
> +
> +choice
> +	prompt "Display size"
> +	depends on FB_SM
> +	default DISPLAY_640x480
> +
> +config DISPLAY_640x480
> +	bool "640x480"
> +
> +config DISPLAY_1024x768
> +	bool "1024x768"

Why do you need DISPLAY_640x480 and DISPLAY_1024x768?

> --- linux_save/drivers/video/smi/smi_base.c	1970-01-01 03:00:00.000000000 +0300
> +++ linux_mips/drivers/video/smi/smi_base.c	2005-05-31 17:00:36.000000000 +0400
> @@ -0,0 +1,532 @@
> +/*
> + * drivers/video/smi/smi_base.c
> + *
> + * LynxEM+/EM4+(Silicon Motion Inc.) fb driver	for VR5701-SG2
> + *
> + * Author: Sergey Podstavin <spodstavin@ru.mvista.com>
> + *
> + * 2005 (c) MontaVista Software, Inc. This file is licensed under
> + * the terms of the GNU General Public License version 2. This program
> + * is licensed "as is" without any warranty of any kind, whether express
> + * or implied.
> + */
> +
> +#include <linux/config.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/string.h>
> +#include <linux/mm.h>
> +#include <linux/selection.h>
> +#include <linux/tty.h>
> +#include <linux/slab.h>
> +#include <linux/delay.h>
> +#include <linux/fb.h>
> +#include <linux/init.h>
> +#include <linux/pci.h>
> +#include <linux/console.h>
> +#include "../console/fbcon.h"
> +#include "smifb.h"
> +#include "smi_hw.h"
> +
> +/*
> + * Card Identification
> + *
> + */
> +static struct pci_device_id smifb_pci_tbl[] __devinitdata = {
> +	{PCI_VENDOR_ID_SMI, PCI_DEVICE_ID_SMI_LYNX_EM_PLUS,
> +	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},	/* Lynx EM+/EM4+ */
> +	{PCI_VENDOR_ID_SMI, PCI_DEVICE_ID_SMI_LYNX_3DM,
> +	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},	/* Lynx 3DM/3DM+/3DM4+ */
> +	{0,}			/* terminate list */
> +};
> +
> +MODULE_DEVICE_TABLE(pci, smifb_pci_tbl);
> +
> +/*
> + *
> + * global variables
> + *
> + */
> +
> +#ifdef CONFIG_DISPLAY_1024x768
> +/* 1024x768, 16bpp, 60Hz */
> +static struct fb_var_screeninfo smifb_default_var = {
> +      xres:1024,
> +      yres:768,

Please use C99-style struct initializers, e.g.

	.xres = 1024,

> +/*
> + * VGA registers
> + *
> + */
> +static void Unlock(struct smifb_info *sinfo)
> +{
> +	pr_debug("Unlock");
> +	regSR_write(sinfo->mmio, 0x33, regSR_read(sinfo->mmio, 0x33) & 0x20);
> +}
> +
> +static void Lock(struct smifb_info *sinfo)
> +{
> +	pr_debug("Lock");
> +}

Hmm, Lock() doesn't do anything, while Unlock() does?

> diff -Naurp --exclude=CVS linux_save/drivers/video/smi/smifb.h linux_mips/drivers/video/smi/smifb.h
> --- linux_save/drivers/video/smi/smifb.h	1970-01-01 03:00:00.000000000 +0300
> +++ linux_mips/drivers/video/smi/smifb.h	2005-05-31 17:00:36.000000000 +0400
> @@ -0,0 +1,89 @@
> +/*
> + * drivers/video/smi/smifb.h
> + *
> + * LynxEM+/EM4+(Silicon Motion Inc.) fb driver	for VR5701-SG2
> + *
> + * Author: Sergey Podstavin <spodstavin@ru.mvista.com>
> + *
> + * 2005 (c) MontaVista Software, Inc. This file is licensed under
> + * the terms of the GNU General Public License version 2. This program
> + * is licensed "as is" without any warranty of any kind, whether express
> + * or implied.
> + */
> +
> +#ifndef __SMIFB_H__
> +#define __SMIFB_H__
> +
> +#define FBCON_HAS_CFB16

Relic from 2.4?

> +struct smifb_info;
> +struct smifb_info {

You don't need a forward declaration just before the real declaration.

> +	/* PCI base physical addresses */
> +	unsigned long fb_base_phys;	/* physical Frame Buffer base address                  */
> +	unsigned long dpr_base_phys;	/* physical Drawing Processor base address             */
> +	unsigned long vpr_base_phys;	/* physical Video Processor base address               */
> +	unsigned long cpr_base_phys;	/* physical Capture Processor base address             */
> +	unsigned long mmio_base_phys;	/* physical MMIO spase (VGA + SMI regs ?) base address */
> +	unsigned long dpport_base_phys;	/* physical Drawing Processor Data Port base address   */
> +	int dpport_size;	/* size of Drawin Processor Data Port memory space     */
> +
> +	/* PCI base virtual addresses */
> +	caddr_t base;		/* address of base */
        unsigned long?

> +	caddr_t fb_base;	/* address of frame buffer base */
> +	caddr_t dpr;		/* Drawing Processor Registers  */
> +	caddr_t vpr;		/* Video Processor Registers    */
> +	caddr_t cpr;		/* Capture Processor Registers  */
> +	caddr_t mmio;		/* Memory Mapped I/O Port       */
> +	caddr_t dpport;		/* Drawing Processor Data       */

Etc.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
