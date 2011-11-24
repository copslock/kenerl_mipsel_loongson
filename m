Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Nov 2011 16:07:04 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:39187 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904610Ab1KXPG6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 24 Nov 2011 16:06:58 +0100
X-Virus-Scanned: at arrakis.dune.hu
Received: from [192.168.254.129] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 3387923C008B;
        Thu, 24 Nov 2011 16:06:55 +0100 (CET)
Message-ID: <4ECE5D8E.3030504@openwrt.org>
Date:   Thu, 24 Nov 2011 16:06:54 +0100
From:   Gabor Juhos <juhosg@openwrt.org>
MIME-Version: 1.0
To:     =?UTF-8?B?UmVuw6kgQm9sbGRvcmY=?= <xsecute@googlemail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Imre Kaloz <kaloz@openwrt.org>
Subject: Re: [PATCH 00/12] MIPS: ath79: AR724X PCI fixes and AR71XX PCI support
References: <1322003670-8797-1-git-send-email-juhosg@openwrt.org> <CAEWqx5-HNNy-9BhYi=nnp3Q=vGQnq1hfH50env5W73ux2UiZXw@mail.gmail.com> <4ECCFE72.6090300@openwrt.org> <CAEWqx5_hgSH0FoWJPL0JDrVXGTWFCV0-FH9hXPMTxbG3A1pScQ@mail.gmail.com> <CAEWqx5_emEPp1HzK=SwOUJnJp5uFhco1asEQjuucdEV4rTQCdg@mail.gmail.com> <4ECD5B06.10204@openwrt.org> <CAEWqx5-deTQLVu=1S9XjKTeq+=O3OE-EXJsXugZAeKYFFzjo-w@mail.gmail.com>
In-Reply-To: <CAEWqx5-deTQLVu=1S9XjKTeq+=O3OE-EXJsXugZAeKYFFzjo-w@mail.gmail.com>
X-Enigmail-Version: 1.3.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-archive-position: 31961
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 20879

Hi René,

> Sorry Gabor for the following patch, but it seems your patchset was
> against a other tree? 

Both of my patch sets was based on the 'mips-for-linux-next' branch of Ralf's
'upstream-sfr' tree:

git://git.linux-mips.org/pub/scm/ralf/upstream-sfr.git

> Because of the many failures I rebase'ed against 09521577ca7718b6c of the
> linus tree and written anything from scratch.

That was waste of time. The ath79 platform got a pile of changes recently, and
those changes are not yet available in Linus' tree. If you were unsure about the
tree, you should have asked earlier.

> - The ar724x pci build only then SOC_AR724X and AR724X_PCI is set.
> (new symbol AR724X_PCI)
> - We have a shared PCI header file for both controllers. (Only AR724x
> is included atm)
> - We have a default irq map if the board pass no other map with
> ar724x_pci_add_data.
> - I added the fix for the 7240 controller bug, hopefully right.

> Gabor, can you please test the patch?

I can tell without testing that this is not working, see below.

> 
> René
> 
> diff --git a/arch/mips/ath79/Kconfig b/arch/mips/ath79/Kconfig
> index 4770741..e763661 100644
> --- a/arch/mips/ath79/Kconfig
> +++ b/arch/mips/ath79/Kconfig
> @@ -23,6 +23,16 @@ config ATH79_MACH_PB44
>  	  Say 'Y' here if you want your kernel to support the
>  	  Atheros PB44 reference board.
> 
> +config ATH79_MACH_UBNT_XM
> +	bool "Ubiquiti Networks XM (rev 1.0) board"
> +	select SOC_AR724X
> +	select ATH79_DEV_GPIO_BUTTONS
> +	select ATH79_DEV_LEDS_GPIO
> +	select ATH79_DEV_SPI
> +	help
> +	  Say 'Y' here if you want your kernel to support the
> +	  Ubiquiti Networks XM (rev 1.0) board.
> +
>  endmenu
> 
>  config SOC_AR71XX
> @@ -33,6 +43,7 @@ config SOC_AR71XX
>  config SOC_AR724X
>  	select USB_ARCH_HAS_EHCI
>  	select USB_ARCH_HAS_OHCI
> +	select HW_HAS_PCI
>  	def_bool n
> 
>  config SOC_AR913X
> @@ -52,4 +63,8 @@ config ATH79_DEV_LEDS_GPIO
>  config ATH79_DEV_SPI
>  	def_bool n
> 
> +config AR724X_PCI
> +	depends on PCI
> +	def_bool y
> +
>  endif

Why would we have to add yet another Kconfig symbol? The AR724X specific code is
only build when both PCI and SOC_AR724X is selected (in Ralf's tree, and in
linux-next).

> diff --git a/arch/mips/ath79/Makefile b/arch/mips/ath79/Makefile
> index c33d465..ac9f375 100644
> --- a/arch/mips/ath79/Makefile
> +++ b/arch/mips/ath79/Makefile
> @@ -26,3 +26,4 @@ obj-$(CONFIG_ATH79_DEV_SPI)		+= dev-spi.o
>  #
>  obj-$(CONFIG_ATH79_MACH_AP81)		+= mach-ap81.o
>  obj-$(CONFIG_ATH79_MACH_PB44)		+= mach-pb44.o
> +obj-$(CONFIG_ATH79_MACH_UBNT_XM)	+= mach-ubnt-xm.o
> diff --git a/arch/mips/ath79/mach-ubnt-xm.c b/arch/mips/ath79/mach-ubnt-xm.c
> new file mode 100644
> index 0000000..6fadd0b
> --- /dev/null
> +++ b/arch/mips/ath79/mach-ubnt-xm.c
> @@ -0,0 +1,121 @@
> +/*
> + *  Ubiquiti Networks XM (rev 1.0) board support
> + *
> + *  Copyright (C) 2011 René Bolldorf <xsecute@googlemail.com>
> + *
> + *  Derived from: mach-pb44.c
> + *
> + *  This program is free software; you can redistribute it and/or modify it
> + *  under the terms of the GNU General Public License version 2 as published
> + *  by the Free Software Foundation.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/pci.h>
> +
> +#ifdef CONFIG_PCI
> +#include <linux/ath9k_platform.h>
> +#include <asm/mach-ath79/pci.h>
> +#include <asm/mach-ath79/irq.h>
> +#endif /* CONFIG_PCI */
> +
> +#include "machtypes.h"
> +#include "dev-gpio-buttons.h"
> +#include "dev-leds-gpio.h"
> +#include "dev-spi.h"
> +
> +#define UBNT_XM_GPIO_LED_L1		0
> +#define UBNT_XM_GPIO_LED_L2		1
> +#define UBNT_XM_GPIO_LED_L3		11
> +#define UBNT_XM_GPIO_LED_L4		7
> +
> +#define UBNT_XM_GPIO_BTN_RESET		12
> +
> +#define UBNT_XM_KEYS_POLL_INTERVAL	20
> +#define UBNT_XM_KEYS_DEBOUNCE_INTERVAL	(3 * UBNT_XM_KEYS_POLL_INTERVAL)
> +
> +#define UBNT_XM_EEPROM_ADDR		(u8 *) KSEG1ADDR(0x1fff1000)
> +
> +static struct gpio_led ubnt_xm_leds_gpio[] __initdata = {
> +	{
> +		.name		= "ubnt-xm:red:link1",
> +		.gpio		= UBNT_XM_GPIO_LED_L1,
> +		.active_low	= 0,
> +	}, {
> +		.name		= "ubnt-xm:orange:link2",
> +		.gpio		= UBNT_XM_GPIO_LED_L2,
> +		.active_low	= 0,
> +	}, {
> +		.name		= "ubnt-xm:green:link3",
> +		.gpio		= UBNT_XM_GPIO_LED_L3,
> +		.active_low	= 0,
> +	}, {
> +		.name		= "ubnt-xm:green:link4",
> +		.gpio		= UBNT_XM_GPIO_LED_L4,
> +		.active_low	= 0,
> +	},
> +};
> +
> +static struct gpio_keys_button ubnt_xm_gpio_keys[] __initdata = {
> +	{
> +		.desc			= "reset",
> +		.type			= EV_KEY,
> +		.code			= KEY_RESTART,
> +		.debounce_interval	= UBNT_XM_KEYS_DEBOUNCE_INTERVAL,
> +		.gpio			= UBNT_XM_GPIO_BTN_RESET,
> +		.active_low		= 1,
> +	}
> +};
> +
> +static struct spi_board_info ubnt_xm_spi_info[] = {
> +	{
> +		.bus_num	= 0,
> +		.chip_select	= 0,
> +		.max_speed_hz	= 25000000,
> +		.modalias	= "mx25l6405d",
> +	}
> +};
> +
> +static struct ath79_spi_platform_data ubnt_xm_spi_data = {
> +	.bus_num		= 0,
> +	.num_chipselect		= 1,
> +};
> +
> +#ifdef CONFIG_PCI
> +static struct ath9k_platform_data ubnt_xm_eeprom_data;
> +
> +static struct ath79_pci_data ubnt_xm_pci_data[] = {
> +	{
> +		.slot	= 0,
> +		.pin	= 1,
> +		.irq	= ATH79_PCI_IRQ(0),
> +		.pdata	= &ubnt_xm_eeprom_data,
> +	},
> +};
> +#endif /* CONFIG_PCI */
> +
> +static void __init ubnt_xm_init(void)
> +{
> +	ath79_register_leds_gpio(-1, ARRAY_SIZE(ubnt_xm_leds_gpio),
> +				 ubnt_xm_leds_gpio);
> +
> +	ath79_register_gpio_keys_polled(-1, UBNT_XM_KEYS_POLL_INTERVAL,
> +					ARRAY_SIZE(ubnt_xm_gpio_keys),
> +					ubnt_xm_gpio_keys);
> +
> +	ath79_register_spi(&ubnt_xm_spi_data, ubnt_xm_spi_info,
> +			   ARRAY_SIZE(ubnt_xm_spi_info));
> +
> +#ifdef CONFIG_PCI
> +	memcpy(ubnt_xm_eeprom_data.eeprom_data, UBNT_XM_EEPROM_ADDR,
> +	       sizeof(ubnt_xm_eeprom_data.eeprom_data));
> +
> +	ar724x_pci_add_data(ubnt_xm_pci_data, ARRAY_SIZE(ubnt_xm_pci_data));
> +#endif /* CONFIG_PCI */
> +
> +}
> +
> +MIPS_MACHINE(ATH79_MACH_UBNT_XM,
> +	     "UBNT-XM",
> +	     "Ubiquiti Networks XM (rev 1.0) board",
> +	     ubnt_xm_init);
> diff --git a/arch/mips/ath79/machtypes.h b/arch/mips/ath79/machtypes.h
> index 3940fe4..35d5d5c 100644
> --- a/arch/mips/ath79/machtypes.h
> +++ b/arch/mips/ath79/machtypes.h
> @@ -18,6 +18,7 @@ enum ath79_mach_type {
>  	ATH79_MACH_GENERIC = 0,
>  	ATH79_MACH_AP81,		/* Atheros AP81 reference board */
>  	ATH79_MACH_PB44,		/* Atheros PB44 reference board */
> +	ATH79_MACH_UBNT_XM,		/* Ubiquiti Networks XM board rev 1.0 */
>  };
> 
>  #endif /* _ATH79_MACHTYPE_H */
> diff --git a/arch/mips/include/asm/mach-ath79/irq.h
> b/arch/mips/include/asm/mach-ath79/irq.h
> index 189bc6e..eb68e79 100644
> --- a/arch/mips/include/asm/mach-ath79/irq.h
> +++ b/arch/mips/include/asm/mach-ath79/irq.h
> @@ -10,11 +10,15 @@
>  #define __ASM_MACH_ATH79_IRQ_H
> 
>  #define MIPS_CPU_IRQ_BASE	0
> -#define NR_IRQS			16
> +#define NR_IRQS			22
> 

This will conflict with other changes already in linux-next.

>  #define ATH79_MISC_IRQ_BASE	8
>  #define ATH79_MISC_IRQ_COUNT	8
> 
> +#define ATH79_PCI_IRQ_BASE	(ATH79_MISC_IRQ_BASE + ATH79_MISC_IRQ_COUNT)
> +#define ATH79_PCI_IRQ_COUNT	6
> +#define ATH79_PCI_IRQ(_x)	(ATH79_PCI_IRQ_BASE + (_x))
> +
>  #define ATH79_CPU_IRQ_IP2	(MIPS_CPU_IRQ_BASE + 2)
>  #define ATH79_CPU_IRQ_USB	(MIPS_CPU_IRQ_BASE + 3)
>  #define ATH79_CPU_IRQ_GE0	(MIPS_CPU_IRQ_BASE + 4)
> diff --git a/arch/mips/include/asm/mach-ath79/pci.h
> b/arch/mips/include/asm/mach-ath79/pci.h
> new file mode 100644
> index 0000000..f671174
> --- /dev/null
> +++ b/arch/mips/include/asm/mach-ath79/pci.h
> @@ -0,0 +1,24 @@
> +/*
> + *  Atheros 71xx/724x PCI support
> + *
> + *  Copyright (C) 2011 René Bolldorf <xsecute@googlemail.com>
> + *  Copyright (C) 2009-2011 Gabor Juhos <juhosg@openwrt.org>
> + *
> + *  This program is free software; you can redistribute it and/or modify it
> + *  under the terms of the GNU General Public License version 2 as published
> + *  by the Free Software Foundation.
> + */
> +
> +#ifndef __ASM_MACH_ATH79_PCI_H
> +#define __ASM_MACH_ATH79_PCI_H
> +
> +struct ath79_pci_data {
> +	uint8_t slot;
> +	uint8_t pin;
> +	int irq;
> +	void *pdata;
> +};
> +
> +void ar724x_pci_add_data(struct ath79_pci_data *data, int size);
> +
> +#endif /* __ASM_MACH_ATH79_PCI_H */
> diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
> index bb82cbd..6603594 100644
> --- a/arch/mips/pci/Makefile
> +++ b/arch/mips/pci/Makefile
> @@ -19,6 +19,7 @@ obj-$(CONFIG_BCM47XX)		+= pci-bcm47xx.o
>  obj-$(CONFIG_BCM63XX)		+= pci-bcm63xx.o fixup-bcm63xx.o \
>  					ops-bcm63xx.o
>  obj-$(CONFIG_MIPS_ALCHEMY)	+= pci-alchemy.o
> +obj-$(CONFIG_AR724X_PCI)	+= pci-ar724x.o
> 
>  #
>  # These are still pretty much in the old state, watch, go blind.
> diff --git a/arch/mips/pci/pci-ar724x.c b/arch/mips/pci/pci-ar724x.c
> new file mode 100644
> index 0000000..66974fa
> --- /dev/null
> +++ b/arch/mips/pci/pci-ar724x.c
> @@ -0,0 +1,284 @@
> +/*
> + *  Atheros 724x PCI support
> + *
> + *  Copyright (C) 2011 René Bolldorf <xsecute@googlemail.com>
> + *  Copyright (C) 2009-2011 Gabor Juhos <juhosg@openwrt.org>
> + *
> + *  This program is free software; you can redistribute it and/or modify it
> + *  under the terms of the GNU General Public License version 2 as published
> + *  by the Free Software Foundation.
> + */
> +
> +#include <linux/pci.h>
> +#include <linux/irq.h>
> +#include <asm/mach-ath79/ath79.h>
> +#include <asm/mach-ath79/pci.h>
> +#include <asm/mach-ath79/irq.h>
> +#include <asm/mach-ath79/ar71xx_regs.h>
> +
> +#define AR724X_PCI_CFG_BASE	0x14000000
> +#define AR724X_PCI_CFG_SIZE	0x1000
> +#define AR724X_PCI_CTRL_BASE	(AR71XX_APB_BASE + 0x000f0000)
> +#define AR724X_PCI_CTRL_SIZE	0x100
> +
> +#define AR724X_PCI_MEM_BASE	0x10000000
> +#define AR724X_PCI_MEM_SIZE	0x08000000
> +
> +#define AR724X_PCI_REG_INT_STATUS	0x4c
> +#define AR724X_PCI_REG_INT_MASK		0x50
> +#define AR724X_PCI_INT_DEV0		BIT(14)
> +
> +#define AR7240_BAR0_WAR_VALUE	0xffff
> +
> +static DEFINE_SPINLOCK(ar724x_pci_lock);
> +
> +static void __iomem *ar724x_pci_devcfg_base;
> +static void __iomem *ar724x_pci_ctrl_base;
> +
> +static struct ath79_pci_data *pci_data;
> +static int pci_data_size = -1;
> +
> +static u32 ar724x_pci_bar0_value;
> +static bool ar724x_pci_bar0_is_cached;
> +
> +static int ar724x_pci_read(struct pci_bus *bus, unsigned int devfn, int where,
> +			    int size, uint32_t *value)
> +{
> +	unsigned long flags;
> +	void __iomem *base;
> +
> +	if (devfn)
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +
> +	base = ar724x_pci_devcfg_base;
> +
> +	spin_lock_irqsave(&ar724x_pci_lock, flags);
> +
> +	switch (size) {
> +	case 1:
> +		*value = (__raw_readl(base + (where & ~3)) & 0xff);

This is wrong. This will always return the least significant byte, instead of
the right one. And the outermost parens are not needed.

> +		break;
> +	case 2:
> +		*value = (__raw_readl(base + (where & ~3)) & 0xffff);

This is wrong as well.

> +		break;
> +	case 4:
> +		if (soc_is_ar7240() && where == PCI_BASE_ADDRESS_0 &&
> +		    ar724x_pci_bar0_is_cached)
> +			/* use the cached value */
> +			*value = ar724x_pci_bar0_value;
> +		else
> +			*value = __raw_readl(base + where);
> +		break;
> +	default:
> +		spin_unlock_irqrestore(&ar724x_pci_lock, flags);
> +
> +		return PCIBIOS_BAD_REGISTER_NUMBER;
> +	}
> +
> +	spin_unlock_irqrestore(&ar724x_pci_lock, flags);
> +
> +	return PCIBIOS_SUCCESSFUL;
> +}
> +
> +static int ar724x_pci_write(struct pci_bus *bus, unsigned int devfn, int where,
> +			     int size, uint32_t value)
> +{
> +	unsigned long flags;
> +	void __iomem *base;
> +
> +	if (devfn)
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +
> +	if (soc_is_ar7240() && where == PCI_BASE_ADDRESS_0 && size == 4) {
> +		if (value != 0xffffffff) {
> +			/*
> +			 * WAR for a hw issue. If the BAR0 register of the
> +			 * device is set to the proper base address, the
> +			 * memory space of the device is not accessible.
> +			 *
> +			 * Cache the intended value so it can be read back,
> +			 * and write a SoC specific constant value to the
> +			 * BAR0 register in order to make the device memory
> +			 * accessible.
> +			 */
> +			ar724x_pci_bar0_is_cached = true;
> +			ar724x_pci_bar0_value = value;
> +			value = AR7240_BAR0_WAR_VALUE;
> +		} else {
> +			ar724x_pci_bar0_is_cached = false;
> +		}
> +	}
> +
> +	base = ar724x_pci_devcfg_base;
> +
> +	spin_lock_irqsave(&ar724x_pci_lock, flags);
> +
> +	switch (size) {
> +	case 1:
> +		value = (__raw_readl(base + (where & ~3)) & 0xff);
> +		__raw_writel(value, base + (where & ~3));

Wrong. This reads the register, and masks out everything but the least
significant byte, and writes the results back to the same register. It must
modify the right byte intead.

> +		break;
> +	case 2:
> +		value = (__raw_readl(base + (where & ~3)) & 0xffff);
> +		__raw_writel(value, base + (where & ~3));

Also wrong (with words instead of bytes).

> +		break;
> +	case 4:
> +		__raw_writel(value, (base + where));
> +		break;
> +	default:
> +		spin_unlock_irqrestore(&ar724x_pci_lock, flags);
> +
> +		return PCIBIOS_BAD_REGISTER_NUMBER;
> +	}
> +
> +	spin_unlock_irqrestore(&ar724x_pci_lock, flags);
> +
> +	return PCIBIOS_SUCCESSFUL;
> +}
> +
> +static struct pci_ops ar724x_pci_ops = {
> +	.read	= ar724x_pci_read,
> +	.write	= ar724x_pci_write,
> +};
> +
> +static struct resource ar724x_io_resource = {
> +	.name   = "PCI IO space",
> +	.start  = 0,
> +	.end    = 0,
> +	.flags  = IORESOURCE_IO,
> +};
> +
> +static struct resource ar724x_mem_resource = {
> +	.name   = "PCI memory space",
> +	.start  = AR724X_PCI_MEM_BASE,
> +	.end    = AR724X_PCI_MEM_BASE + AR724X_PCI_MEM_SIZE - 1,
> +	.flags  = IORESOURCE_MEM,
> +};
> +
> +static struct pci_controller ar724x_pci_controller = {
> +	.pci_ops        = &ar724x_pci_ops,
> +	.io_resource    = &ar724x_io_resource,
> +	.mem_resource	= &ar724x_mem_resource,
> +};
> +
> +static void ar724x_pci_irq_mask(struct irq_data *data)
> +{
> +	void __iomem *base;
> +	u32 t;
> +
> +	base = ar724x_pci_ctrl_base;
> +
> +	switch (data->irq) {
> +	case ATH79_PCI_IRQ(0):
> +		t = __raw_readl(base + AR724X_PCI_REG_INT_MASK);
> +		__raw_writel(t & ~AR724X_PCI_INT_DEV0,
> +			     base + AR724X_PCI_REG_INT_MASK);

A __raw_readl is missing.

> +
> +		t = __raw_readl(base + AR724X_PCI_REG_INT_STATUS);
> +		__raw_writel(t | AR724X_PCI_INT_DEV0,
> +			     base + AR724X_PCI_REG_INT_STATUS);

Here too.

> +	}
> +}
> +
> +static void ar724x_pci_irq_unmask(struct irq_data *data)
> +{
> +	void __iomem *base;
> +	u32 t;
> +
> +	base = ar724x_pci_ctrl_base;
> +
> +	switch (data->irq) {
> +	case ATH79_PCI_IRQ(0):
> +		t = __raw_readl(base + AR724X_PCI_REG_INT_MASK);
> +		__raw_writel(t | AR724X_PCI_INT_DEV0,
> +			     base + AR724X_PCI_REG_INT_MASK);

And here also.

> +	}
> +}
> +
> +static struct irq_chip ar724x_pci_irq_chip = {
> +	.name		= "AR724X PCI",
> +	.irq_mask	= ar724x_pci_irq_mask,
> +	.irq_unmask	= ar724x_pci_irq_unmask,
> +	.irq_mask_ack	= ar724x_pci_irq_mask,
> +};
> +
> +static __initconst struct ath79_pci_data ar724x_default_pci_data[] = {

__initconst must be placed after [].

> +	{
> +		.slot = 0,
> +		.pin  = 1,
> +		.irq  = ATH79_PCI_IRQ(0),
> +	},
> +};
> +
> +void ar724x_pci_add_data(struct ath79_pci_data *data, int size)
> +{
> +	pci_data	= data;
> +	pci_data_size	= size;
> +}
> +
> +int __init pcibios_map_irq(const struct pci_dev *dev, uint8_t slot,
> uint8_t pin)
> +{
> +	int irq = -1;
> +	int i;
> +
> +	if (pci_data_size == -1)
> +		return irq;
> +
> +	for (i = 0; i < pci_data_size; i++) {
> +		if ((pci_data[i].slot == slot) && (pci_data[i].pin == pin)) {
> +			if (pci_data[i].irq != 0)
> +				irq = pci_data[i].irq;
> +		break;

Wrong indentation for the break statement.

> +		}
> +	}
> +
> +	return irq;
> +}
> +
> +int pcibios_plat_dev_init(struct pci_dev *dev)
> +{
> +	int i;
> +
> +	if (pci_data_size == -1)
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +
> +	for (i = 0; i < pci_data_size; i++) {
> +		if (pci_data[i].slot == PCI_SLOT(dev->devfn)) {
> +			if (pci_data[i].pdata != NULL)
> +				dev->dev.platform_data = pci_data[i].pdata;
> +		break;

Ditto.

> +		}
> +	}
> +
> +	return PCIBIOS_SUCCESSFUL;
> +}
> +
> +static int __init ar724x_pcibios_init(void)
> +{
> +	int i;
> +
> +	ar724x_pci_devcfg_base = ioremap_nocache(AR724X_PCI_CFG_BASE,
> +						 AR724X_PCI_CFG_SIZE);

ioremap can be used instead of ioremap_nocache.

> +	if (ar724x_pci_devcfg_base == NULL)
> +		return -ENOMEM;
> +
> +	ar724x_pci_ctrl_base = ioremap_nocache(AR724X_PCI_CTRL_BASE,
> +						  AR724X_PCI_CTRL_SIZE);
> +	if (ar724x_pci_ctrl_base == NULL)
> +		return -ENOMEM;

ar724x_pci_devcfg_base must be unmapped if the second iomap call fails.

> +
> +	if (pci_data == NULL)
> +		pci_data = ar724x_default_pci_data;
> +		pci_data_size = ARRAY_SIZE(ar724x_default_pci_data);

Braces are missing from this if statement.

The AR724X_PCI_IRQ_REG_INT_{MASK,STATUS} registers must be cleared here.

> +
> +	for (i = ATH79_PCI_IRQ_BASE;
> +	     i < ATH79_PCI_IRQ_BASE + ATH79_PCI_IRQ_COUNT; i++)
> +		irq_set_chip_and_handler(i, &ar724x_pci_irq_chip,
> +					 handle_level_irq);

The 'irq_set_chained_handler' call is missing here. And the
ar724x_pci_irq_handler function is completely missing from the patch.

> +
> +	register_pci_controller(&ar724x_pci_controller);
> +
> +	return PCIBIOS_SUCCESSFUL;
> +}
> +
> +arch_initcall(ar724x_pcibios_init);

Regards,
Gabor
