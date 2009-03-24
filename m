Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Mar 2009 13:27:06 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:48341 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S21366954AbZCXN0w (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 24 Mar 2009 13:26:52 +0000
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n2ODQoju011880;
	Tue, 24 Mar 2009 14:26:50 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n2ODQoWi011878;
	Tue, 24 Mar 2009 14:26:50 +0100
Date:	Tue, 24 Mar 2009 14:26:50 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Kevin Hickey <khickey@rmicorp.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH v2 4/6] Alchemy: Au1300/DB1300 peripheral resource
	declarations
Message-ID: <20090324132650.GB6509@linux-mips.org>
References: <1237582306-10800-1-git-send-email-khickey@rmicorp.com> <1237582306-10800-2-git-send-email-khickey@rmicorp.com> <1237582306-10800-3-git-send-email-khickey@rmicorp.com> <1237582306-10800-4-git-send-email-khickey@rmicorp.com> <1237582306-10800-5-git-send-email-khickey@rmicorp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1237582306-10800-5-git-send-email-khickey@rmicorp.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22134
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Mar 20, 2009 at 03:51:44PM -0500, Kevin Hickey wrote:

> diff --git a/arch/mips/alchemy/common/Makefile b/arch/mips/alchemy/common/Makefile
> index faa6afd..4e533be 100644
> --- a/arch/mips/alchemy/common/Makefile
> +++ b/arch/mips/alchemy/common/Makefile
> @@ -9,6 +9,7 @@ obj-y += prom.o puts.o time.o reset.o \
>  	clocks.o platform.o power.o setup.o \
>  	sleeper.o dma.o dbdma.o gpio.o
>  
> +obj-$(CONFIG_SOC_AU13XX) 	+= au13xx_res.o
>  obj-$(CONFIG_PCI)		+= pci.o
>  
>  obj-$(CONFIG_AU_GPIO_INT_CNTLR) += gpio_int.o
> diff --git a/arch/mips/alchemy/common/au13xx_res.c b/arch/mips/alchemy/common/au13xx_res.c
> new file mode 100644
> index 0000000..7d86479
> --- /dev/null
> +++ b/arch/mips/alchemy/common/au13xx_res.c
> @@ -0,0 +1,74 @@
> +/*
> + * Copyright 2003-2008 RMI Corporation. All rights reserved.
> + * Author: Kevin Hickey <khickey@rmicorp.com>
> + *
> + *  This program is free software; you can redistribute  it and/or modify it
> + *  under  the terms of  the GNU General  Public License as published by the
> + *  Free Software Foundation;  either version 2 of the  License, or (at your
> + *  option) any later version.
> + *
> + * THIS SOFTWARE IS PROVIDED BY RMI Corporation 'AS IS' AND ANY EXPRESS OR
> + * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
> + * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
> + * NO EVENT SHALL RMI OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
> + * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
> + * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
> + * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
> + * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
> + * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + *
> + *  You should have received a copy of the  GNU General Public License along
> + *  with this program; if not, write  to the Free Software Foundation, Inc.,
> + *  675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +#include <linux/platform_device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/init.h>
> +
> +#include <asm/mach-au1x00/au1000.h>
> +
> +#ifdef CONFIG_SOC_AU13XX

But this entire file is only compiled if CONFIG_SOC_AU13XX is defined so
this #ifdef is redundant.

> +/*
> + * USB Resources for Au13xx
> + */
> +static struct resource au13xx_usb_ehci_resources[] = {
> +	[0] = {
> +		.start		= USB_EHCI_BASE,
> +		.end		= USB_EHCI_BASE + USB_EHCI_LEN - 1,
> +		.flags		= IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.start		= AU1300_IRQ_USB + GPINT_LINUX_IRQ_OFFSET,
> +		.end		= AU1300_IRQ_USB + GPINT_LINUX_IRQ_OFFSET,
> +		.flags		= IORESOURCE_IRQ,
> +	},
> +};
> +
> +static u64 ehci_dmamask = DMA_32BIT_MASK;
> +
> +static struct platform_device au13xx_usb_ehci_device = {
> +	.name		= "au13xx-ehci",
> +	.id		= 0,
> +	.dev = {
> +		.dma_mask		= &ehci_dmamask,
> +		.coherent_dma_mask	= DMA_32BIT_MASK,
> +	},
> +	.num_resources	= ARRAY_SIZE(au13xx_usb_ehci_resources),
> +	.resource	= au13xx_usb_ehci_resources,
> +};
> +
> +static struct platform_device *au13xx_platform_devices[] __initdata = {
> +	&au13xx_usb_ehci_device,
> +};
> +
> +static int __init au13xx_add_devices(void)
> +{
> +	return platform_add_devices(au13xx_platform_devices,
> +			     ARRAY_SIZE(au13xx_platform_devices));
> +}
> +
> +arch_initcall(au13xx_add_devices);
> +
> +#endif /* CONFIG_SOC_AU13XX */
> diff --git a/arch/mips/alchemy/common/dbdma.c b/arch/mips/alchemy/common/dbdma.c
> index 3ab6d80..7fda56b 100644
> --- a/arch/mips/alchemy/common/dbdma.c
> +++ b/arch/mips/alchemy/common/dbdma.c
> @@ -38,7 +38,8 @@
>  #include <asm/mach-au1x00/au1000.h>
>  #include <asm/mach-au1x00/au1xxx_dbdma.h>
>  
> -#if defined(CONFIG_SOC_AU1550) || defined(CONFIG_SOC_AU1200)
> +#if defined(CONFIG_SOC_AU1550) || defined(CONFIG_SOC_AU1200) || \
> +    defined(CONFIG_SOC_AU13XX)
>  
>  /*
>   * The Descriptor Based DMA supports up to 16 channels.
> @@ -150,6 +151,47 @@ static dbdev_tab_t dbdev_tab[] = {
>  
>  #endif /* CONFIG_SOC_AU1200 */
>  
> +#ifdef CONFIG_SOC_AU13XX
> +	{ DSCR_CMD0_UART0_TX, DEV_FLAGS_OUT, 0, 8,  0x10100004, 0, 0 },
> +	{ DSCR_CMD0_UART0_RX, DEV_FLAGS_IN,  0, 8,  0x10100000, 0, 0 },
> +	{ DSCR_CMD0_UART1_TX, DEV_FLAGS_OUT, 0, 8,  0x01011004, 0, 0 },
> +	{ DSCR_CMD0_UART1_RX, DEV_FLAGS_IN,  0, 8,  0x10101000, 0, 0 },
> +	{ DSCR_CMD0_UART2_TX, DEV_FLAGS_OUT, 0, 8,  0x01012004, 0, 0 },
> +	{ DSCR_CMD0_UART2_RX, DEV_FLAGS_IN,  0, 8,  0x10102000, 0, 0 },
> +	{ DSCR_CMD0_UART3_TX, DEV_FLAGS_OUT, 0, 8,  0x01013004, 0, 0 },
> +	{ DSCR_CMD0_UART3_RX, DEV_FLAGS_IN,  0, 8,  0x10103000, 0, 0 },
> +
> +	{ DSCR_CMD0_SDMS_TX0, DEV_FLAGS_OUT, 4, 8,  0x10600000, 0, 0 },
> +	{ DSCR_CMD0_SDMS_RX0, DEV_FLAGS_IN,  4, 8,  0x10600004, 0, 0 },
> +	{ DSCR_CMD0_SDMS_TX1, DEV_FLAGS_OUT, 8, 8,  0x10601000, 0, 0 },
> +	{ DSCR_CMD0_SDMS_RX1, DEV_FLAGS_IN,  8, 8,  0x10601004, 0, 0 },
> +
> +	{ DSCR_CMD0_AES_RX, DEV_FLAGS_IN ,   4, 32, 0x10300008, 0, 0 },
> +	{ DSCR_CMD0_AES_TX, DEV_FLAGS_OUT,   4, 32, 0x10300004, 0, 0 },
> +
> +	{ DSCR_CMD0_PSC0_TX, DEV_FLAGS_OUT,  0, 16, 0x10a0001c, 0, 0 },
> +	{ DSCR_CMD0_PSC0_RX, DEV_FLAGS_IN,   0, 16, 0x10a0001c, 0, 0 },
> +	{ DSCR_CMD0_PSC1_TX, DEV_FLAGS_OUT,  0, 16, 0x10a0101c, 0, 0 },
> +	{ DSCR_CMD0_PSC1_RX, DEV_FLAGS_IN,   0, 16, 0x10a0101c, 0, 0 },
> +	{ DSCR_CMD0_PSC2_TX, DEV_FLAGS_OUT,  0, 16, 0x10a0201c, 0, 0 },
> +	{ DSCR_CMD0_PSC2_RX, DEV_FLAGS_IN,   0, 16, 0x10a0201c, 0, 0 },
> +	{ DSCR_CMD0_PSC3_TX, DEV_FLAGS_OUT,  0, 16, 0x10a0301c, 0, 0 },
> +	{ DSCR_CMD0_PSC3_RX, DEV_FLAGS_IN,   0, 16, 0x10a0301c, 0, 0 },
> +
> +	{ DSCR_CMD0_LCD, DEV_FLAGS_ANYUSE,   0, 0,  0x00000000, 0, 0 },
> +	{ DSCR_CMD0_NAND_FLASH, DEV_FLAGS_IN, 0, 0, 0x00000000, 0, 0 },
> +
> +	{ DSCR_CMD0_SDMS_TX2, DEV_FLAGS_OUT, 4, 8,  0x10602000, 0, 0 },
> +	{ DSCR_CMD0_SDMS_RX2, DEV_FLAGS_IN,  4, 8,  0x10602004, 0, 0 },
> +
> +	{ DSCR_CMD0_CIM_SYNC, DEV_FLAGS_ANYUSE, 0, 0, 0x00000000, 0, 0 },
> +
> +	{ DSCR_CMD0_UDMA, DEV_FLAGS_ANYUSE,  0, 32, 0x14001810, 0, 0 },
> +
> +	{ DSCR_CMD0_DMA_REQ0, 0, 0, 0, 0x00000000, 0, 0 },
> +	{ DSCR_CMD0_DMA_REQ1, 0, 0, 0, 0x00000000, 0, 0 },
> +#endif /* CONFIG_SOC_AU13XX */
> +
>  	{ DSCR_CMD0_THROTTLE, DEV_FLAGS_ANYUSE, 0, 0, 0x00000000, 0, 0 },
>  	{ DSCR_CMD0_ALWAYS, DEV_FLAGS_ANYUSE, 0, 0, 0x00000000, 0, 0 },
>  
> @@ -881,6 +923,8 @@ static void au1xxx_dbdma_init(void)
>  	irq_nr = AU1550_DDMA_INT;
>  #elif defined(CONFIG_SOC_AU1200)
>  	irq_nr = AU1200_DDMA_INT;
> +#elif defined(CONFIG_SOC_AU13XX)
> +	irq_nr = AU1300_IRQ_DDMA + GPINT_LINUX_IRQ_OFFSET;
>  #else
>  	#error Unknown Au1x00 SOC
>  #endif
> diff --git a/arch/mips/alchemy/common/platform.c b/arch/mips/alchemy/common/platform.c
> index 78fd862..6d2acff 100644
> --- a/arch/mips/alchemy/common/platform.c
> +++ b/arch/mips/alchemy/common/platform.c
> @@ -336,14 +336,79 @@ static struct platform_device pbdb_smbus_device = {
>  };
>  #endif
>  
> +#ifdef CONFIG_SOC_AU13XX

arch/mips/alchemy/common/platform.c - common code thanks to #ifdef ;-)

> +static struct resource au1200_lcd_resources[] = {
> +	[0] = {
> +		.start          = LCD_PHYS_ADDR,
> +		.end            = LCD_PHYS_ADDR + 0x800 - 1,
> +		.flags          = IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.start          = AU1300_IRQ_LCD + 8,
> +		.end            = AU1300_IRQ_LCD + 8,
> +		.flags          = IORESOURCE_IRQ,
> +	}
> +};
> +
> +static u64 au1200_lcd_dmamask = DMA_32BIT_MASK;
> +
> +static struct platform_device au1200_lcd_device = {
> +	.name           = "au1200-lcd",
> +	.id             = 0,
> +	.dev = {
> +		.dma_mask               = &au1200_lcd_dmamask,
> +		.coherent_dma_mask      = DMA_32BIT_MASK,
> +	},
> +	.num_resources  = ARRAY_SIZE(au1200_lcd_resources),
> +	.resource       = au1200_lcd_resources,
> +};
> +
> +extern struct platform_device au13xx_mmc1_device;
> +
> +extern struct au1xmmc_platform_data au1xmmc_platdata[2];
> +static struct resource ide_resources[] = {
> +	[0] = {
> +		.start	= IDE_PHYS_ADDR,
> +		.end 	= IDE_PHYS_ADDR + IDE_PHYS_LEN - 1,
> +		.flags	= IORESOURCE_MEM
> +	},
> +	[1] = {
> +		.start	= IDE_INT,
> +		.end	= IDE_INT,
> +		.flags	= IORESOURCE_IRQ
> +	}
> +};
> +
> +static u64 ide_dmamask = DMA_32BIT_MASK;
> +
> +static struct platform_device ide_device = {
> +	.name		= "au1200-ide",
> +	.id		= 0,
> +	.dev = {
> +		.dma_mask 		= &ide_dmamask,
> +		.coherent_dma_mask	= DMA_32BIT_MASK,
> +	},
> +	.num_resources	= ARRAY_SIZE(ide_resources),
> +	.resource	= ide_resources
> +};
> +
> +#endif

It would seem this #ifdef'ed block should go to au13xx_res.c and
the name au1200 be changed to au13xx or so.

> +
> +
>  static struct platform_device *au1xxx_platform_devices[] __initdata = {
>  	&au1xx0_uart_device,
> +#ifdef CONFIG_SOC_AU13XX
> +	&au1200_lcd_device,
> +	&ide_device,
> +	&au13xx_mmc1_device,
>  	&au1xxx_usb_ohci_device,
> +#endif
>  	&au1x00_pcmcia_device,
>  #ifdef CONFIG_FB_AU1100
>  	&au1100_lcd_device,
>  #endif
>  #ifdef CONFIG_SOC_AU1200
> +	&au1xxx_usb_ohci_device,
>  	&au1xxx_usb_ehci_device,
>  	&au1xxx_usb_gdt_device,
>  	&au1xxx_usb_otg_device,
> diff --git a/arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h b/arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h
> index 06f68f4..1c36b9f 100644
> --- a/arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h
> +++ b/arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h
> @@ -195,6 +195,39 @@ typedef volatile struct au1xxx_ddma_desc {
>  #define DSCR_CMD0_CIM_SYNC	26
>  #endif /* CONFIG_SOC_AU1200 */
>  
> +#ifdef CONFIG_SOC_AU13XX
> +#define DSCR_CMD0_UART0_TX	0
> +#define DSCR_CMD0_UART0_RX	1
> +#define DSCR_CMD0_UART1_TX	2
> +#define DSCR_CMD0_UART1_RX	3
> +#define DSCR_CMD0_UART2_TX	4
> +#define DSCR_CMD0_UART2_RX	5
> +#define DSCR_CMD0_UART3_TX	6
> +#define DSCR_CMD0_UART3_RX	7
> +#define DSCR_CMD0_SDMS_TX0	8
> +#define DSCR_CMD0_SDMS_RX0	9
> +#define DSCR_CMD0_SDMS_TX1	10
> +#define DSCR_CMD0_SDMS_RX1	11
> +#define DSCR_CMD0_AES_TX	12
> +#define DSCR_CMD0_AES_RX	13
> +#define DSCR_CMD0_PSC0_TX	14
> +#define DSCR_CMD0_PSC0_RX	15
> +#define DSCR_CMD0_PSC1_TX	16
> +#define DSCR_CMD0_PSC1_RX	17
> +#define DSCR_CMD0_PSC2_TX	18
> +#define DSCR_CMD0_PSC2_RX	19
> +#define DSCR_CMD0_PSC3_TX	20
> +#define DSCR_CMD0_PSC3_RX	21
> +#define DSCR_CMD0_LCD		22
> +#define DSCR_CMD0_NAND_FLASH	23
> +#define DSCR_CMD0_SDMS_TX2	24
> +#define DSCR_CMD0_SDMS_RX2	25
> +#define DSCR_CMD0_CIM_SYNC	26
> +#define DSCR_CMD0_UDMA		27
> +#define DSCR_CMD0_DMA_REQ0	28
> +#define DSCR_CMD0_DMA_REQ1	29
> +#endif /* CONFIG_SOC_AU13XX */
> +
>  #define DSCR_CMD0_THROTTLE	30
>  #define DSCR_CMD0_ALWAYS	31
>  #define DSCR_NDEV_IDS		32
> -- 
> 1.5.4.3

  Ralf
