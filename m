Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Sep 2009 21:46:54 +0200 (CEST)
Received: from mail-ew0-f207.google.com ([209.85.219.207]:53566 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493651AbZI2Tqt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 29 Sep 2009 21:46:49 +0200
Received: by ewy3 with SMTP id 3so5471837ewy.33
        for <linux-mips@linux-mips.org>; Tue, 29 Sep 2009 12:46:41 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:reply-to:to
         :subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:message-id;
        bh=fVPfCC3zOiAyYIUb+Tp8fjqU1A38fwFL3vjju3DVBlw=;
        b=Fk6RsNNurhBk5u3unLONteu00RYAwyEQh2zvWEwkPTssSJZkZVQdprkKhuY9UHUbf7
         jD7VZMn9mtnRI5i5xFC0Vttg2id+0RbNTdFHRMM5cFGiBeqFW/IgOEA/oBsskxVB39cZ
         /zgS2EYDMtnAPZ4Y0Si3NoVT/J7wivJ6U+ejs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:reply-to:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=wMrTYCTVOlg8Or+JmhK+RRi4zVQjlfgM52Odml8HFcMqGL1SZIPgqxVhXyTU9wYYY7
         zHpd8FQLd2/5Kx3m0w1DQiYxtHQ+fUTDNCalT8N5LyXebAK9nm1mrzyXt7VsI6+Y92pD
         wrYakUI3HQUmYtEx2aZNasSte149yltnQFc78=
Received: by 10.210.9.5 with SMTP id 5mr5012641ebi.78.1254253601138;
        Tue, 29 Sep 2009 12:46:41 -0700 (PDT)
Received: from lenovo.localnet (147.59.76-86.rev.gaoland.net [86.76.59.147])
        by mx.google.com with ESMTPS id 7sm17709eyb.12.2009.09.29.12.46.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 29 Sep 2009 12:46:40 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Reply-To: Florian Fainelli <florian@openwrt.org>
To:	Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: [PATCH] Alchemy: XXS1500 PCMCIA driver rewrite
Date:	Tue, 29 Sep 2009 21:46:37 +0200
User-Agent: KMail/1.12.1 (Linux/2.6.29-2-686; KDE/4.3.1; i686; ; )
Cc:	"linux-pcmcia" <linux-pcmcia@lists.infradead.org>,
	"Linux-MIPS" <linux-mips@linux-mips.org>,
	Manuel Lauss <manuel.lauss@gmail.com>
References: <1254250236-18130-1-git-send-email-manuel.lauss@gmail.com>
In-Reply-To: <1254250236-18130-1-git-send-email-manuel.lauss@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Message-Id: <200909292146.38542.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24120
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi Manuel,

Le mardi 29 septembre 2009 20:50:36, Manuel Lauss a écrit :
> Rewritten XXS1500 PCMCIA socket driver, standalone (doesn't
> depend on au1000_generic.c) and added carddetect IRQ support.

Thanks for CC'ing me, will make my best to test this driver, soon.

> 
> Cc: Florian Fainelli <florian@openwrt.org>
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
> ---
> Against latest linus-git, compile-tested only.
> CC'ing Florian, he might still have a testsystem.
> 
>  arch/mips/alchemy/xxs1500/Makefile      |    2 +-
>  arch/mips/alchemy/xxs1500/board_setup.c |   16 --
>  arch/mips/alchemy/xxs1500/platform.c    |   63 ++++++
>  drivers/pcmcia/Kconfig                  |   10 +
>  drivers/pcmcia/Makefile                 |    3 +-
>  drivers/pcmcia/au1000_xxs1500.c         |  188 ----------------
>  drivers/pcmcia/xxs1500_ss.c             |  357
>  +++++++++++++++++++++++++++++++ 7 files changed, 433 insertions(+), 206
>  deletions(-)
>  create mode 100644 arch/mips/alchemy/xxs1500/platform.c
>  delete mode 100644 drivers/pcmcia/au1000_xxs1500.c
>  create mode 100644 drivers/pcmcia/xxs1500_ss.c
> 
> diff --git a/arch/mips/alchemy/xxs1500/Makefile
>  b/arch/mips/alchemy/xxs1500/Makefile index db3c526..3a79a90 100644
> --- a/arch/mips/alchemy/xxs1500/Makefile
> +++ b/arch/mips/alchemy/xxs1500/Makefile
> @@ -5,4 +5,4 @@
>  # Makefile for MyCable XXS1500 board.
>  #
> 
> -lib-y := init.o board_setup.o irqmap.o
> +lib-y := init.o board_setup.o irqmap.o platform.o
> diff --git a/arch/mips/alchemy/xxs1500/board_setup.c
>  b/arch/mips/alchemy/xxs1500/board_setup.c index 4de2d48..6d6de53 100644
> --- a/arch/mips/alchemy/xxs1500/board_setup.c
> +++ b/arch/mips/alchemy/xxs1500/board_setup.c
> @@ -68,22 +68,6 @@ void __init board_setup(void)
>  	/* Enable DTR = USB power up */
>  	au_writel(0x01, UART3_ADDR + UART_MCR); /* UART_MCR_DTR is 0x01??? */
> 
> -#ifdef CONFIG_PCMCIA_XXS1500
> -	/* GPIO 0, 1, and 4 are inputs */
> -	alchemy_gpio_direction_input(0);
> -	alchemy_gpio_direction_input(1);
> -	alchemy_gpio_direction_input(4);
> -
> -	/* GPIO2 208/9/10/11 are inputs */
> -	alchemy_gpio_direction_input(208);
> -	alchemy_gpio_direction_input(209);
> -	alchemy_gpio_direction_input(210);
> -	alchemy_gpio_direction_input(211);
> -
> -	/* Turn off power */
> -	alchemy_gpio_direction_output(214, 0);
> -#endif
> -
>  #ifdef CONFIG_PCI
>  #if defined(__MIPSEB__)
>  	au_writel(0xf | (2 << 6) | (1 << 4), Au1500_PCI_CFG);
> diff --git a/arch/mips/alchemy/xxs1500/platform.c
>  b/arch/mips/alchemy/xxs1500/platform.c new file mode 100644
> index 0000000..9edbdfd
> --- /dev/null
> +++ b/arch/mips/alchemy/xxs1500/platform.c
> @@ -0,0 +1,63 @@
> +/*
> + * XXS1500 board platform device registration
> + *
> + * Copyright (C) 2009 Manuel Lauss
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 
>  USA + */
> +
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +
> +#include <asm/mach-au1x00/au1000.h>
> +
> +static struct resource xxs1500_pcmcia_res[] = {
> +	{
> +		.name	= "pseudo-io",
> +		.flags	= IORESOURCE_MEM,
> +		.start	= 0xF0000000,
> +		.end	= 0xF0040000 - 1,
> +	},
> +	{
> +		.name	= "pseudo-attr",
> +		.flags	= IORESOURCE_MEM,
> +		.start	= 0xF4000000,
> +		.end	= 0xF4040000 - 1,
> +	},
> +	{
> +		.name	= "pseudo-mem",
> +		.flags	= IORESOURCE_MEM,
> +		.start	= 0xF8000000,
> +		.end	= 0xF8040000 - 1,
> +	},
> +};
> +
> +static struct platform_device xxs1500_pcmcia_dev = {
> +	.name		= "xxs1500_pcmcia",
> +	.id		= -1,
> +	.num_resources	= ARRAY_SIZE(xxs1500_pcmcia_res),
> +	.resource	= xxs1500_pcmcia_res,
> +};
> +
> +static struct platform_device *xxs1500_devs[] __initdata = {
> +	&xxs1500_pcmcia_dev,
> +};
> +
> +static int __init xxs1500_dev_init(void)
> +{
> +	return platform_add_devices(xxs1500_devs,
> +				    ARRAY_SIZE(xxs1500_devs));
> +}
> +device_initcall(xxs1500_dev_init);
> diff --git a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
> index fbf965b..c094108 100644
> --- a/drivers/pcmcia/Kconfig
> +++ b/drivers/pcmcia/Kconfig
> @@ -192,6 +192,16 @@ config PCMCIA_AU1X00
>  	tristate "Au1x00 pcmcia support"
>  	depends on SOC_AU1X00 && PCMCIA
> 
> +config PCMCIA_XXS1500
> +	tristate "MyCable XXS1500 PCMCIA socket support"
> +	depends on PCMCIA && MIPS_XXS1500
> +	select 64BIT_PHYS_ADDR
> +	help
> +	  Support for the PCMCIA/CF socket interface on MyCable XXS1500
> +	  systems.
> +
> +	  This driver is also available as a module called xxs1500_ss.ko
> +
>  config PCMCIA_SA1100
>  	tristate "SA1100 support"
>  	depends on ARM && ARCH_SA1100 && PCMCIA
> diff --git a/drivers/pcmcia/Makefile b/drivers/pcmcia/Makefile
> index 3247828..95433f7 100644
> --- a/drivers/pcmcia/Makefile
> +++ b/drivers/pcmcia/Makefile
> @@ -47,7 +47,6 @@ au1x00_ss-$(CONFIG_MIPS_DB1100)			+= au1000_db1x00.o
>  au1x00_ss-$(CONFIG_MIPS_DB1200)			+= au1000_db1x00.o
>  au1x00_ss-$(CONFIG_MIPS_DB1500)			+= au1000_db1x00.o
>  au1x00_ss-$(CONFIG_MIPS_DB1550)			+= au1000_db1x00.o
> -au1x00_ss-$(CONFIG_MIPS_XXS1500)		+= au1000_xxs1500.o
> 
>  sa1111_cs-y					+= sa1111_generic.o
>  sa1111_cs-$(CONFIG_ASSABET_NEPONSET)		+= sa1100_neponset.o
> @@ -77,3 +76,5 @@ pxa2xx-obj-$(CONFIG_MACH_E740)			+= pxa2xx_e740.o
>  pxa2xx-obj-$(CONFIG_MACH_STARGATE2)		+= pxa2xx_stargate2.o
> 
>  obj-$(CONFIG_PCMCIA_PXA2XX)			+= pxa2xx_core.o $(pxa2xx-obj-y)
> +
> +obj-$(CONFIG_PCMCIA_XXS1500)			+= xxs1500_ss.o
> diff --git a/drivers/pcmcia/au1000_xxs1500.c
>  b/drivers/pcmcia/au1000_xxs1500.c deleted file mode 100644
> index b43d47b..0000000
> --- a/drivers/pcmcia/au1000_xxs1500.c
> +++ /dev/null
> @@ -1,188 +0,0 @@
> -/*
> - *
> - * MyCable board specific pcmcia routines.
> - *
> - * Copyright 2003 MontaVista Software Inc.
> - * Author: Pete Popov, MontaVista Software, Inc.
> - *         	ppopov@mvista.com or source@mvista.com
> - *
> - *
>  ######################################################################## -
>  *
> - *  This program is free software; you can distribute it and/or modify it
> - *  under the terms of the GNU General Public License (Version 2) as
> - *  published by the Free Software Foundation.
> - *
> - *  This program is distributed in the hope it will be useful, but WITHOUT
> - *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> - *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> - *  for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
>  along - *  with this program; if not, write to the Free Software
>  Foundation, Inc., - *  59 Temple Place - Suite 330, Boston MA 02111-1307,
>  USA.
> - *
> - *
>  ######################################################################## -
>  *
> - *
> - */
> -#include <linux/module.h>
> -#include <linux/init.h>
> -#include <linux/delay.h>
> -#include <linux/ioport.h>
> -#include <linux/kernel.h>
> -#include <linux/timer.h>
> -#include <linux/mm.h>
> -#include <linux/proc_fs.h>
> -#include <linux/types.h>
> -
> -#include <pcmcia/cs_types.h>
> -#include <pcmcia/cs.h>
> -#include <pcmcia/ss.h>
> -#include <pcmcia/cistpl.h>
> -#include <pcmcia/bus_ops.h>
> -
> -#include <asm/io.h>
> -#include <asm/irq.h>
> -#include <asm/system.h>
> -
> -#include <asm/au1000.h>
> -#include <asm/au1000_pcmcia.h>
> -
> -#define PCMCIA_MAX_SOCK		0
> -#define PCMCIA_NUM_SOCKS	(PCMCIA_MAX_SOCK + 1)
> -#define PCMCIA_IRQ		AU1000_GPIO_4
> -
> -#if 0
> -#define DEBUG(x, args...)	printk(__func__ ": " x, ##args)
> -#else
> -#define DEBUG(x,args...)
> -#endif
> -
> -static int xxs1500_pcmcia_init(struct pcmcia_init *init)
> -{
> -	return PCMCIA_NUM_SOCKS;
> -}
> -
> -static int xxs1500_pcmcia_shutdown(void)
> -{
> -	/* turn off power */
> -	au_writel(au_readl(GPIO2_PINSTATE) | (1<<14)|(1<<30),
> -			GPIO2_OUTPUT);
> -	au_sync_delay(100);
> -
> -	/* assert reset */
> -	au_writel(au_readl(GPIO2_PINSTATE) | (1<<4)|(1<<20),
> -			GPIO2_OUTPUT);
> -	au_sync_delay(100);
> -	return 0;
> -}
> -
> -
> -static int
> -xxs1500_pcmcia_socket_state(unsigned sock, struct pcmcia_state *state)
> -{
> -	u32 inserted; u32 vs;
> -	unsigned long gpio, gpio2;
> -
> -	if(sock > PCMCIA_MAX_SOCK) return -1;
> -
> -	gpio = au_readl(SYS_PINSTATERD);
> -	gpio2 = au_readl(GPIO2_PINSTATE);
> -
> -	vs = gpio2 & ((1<<8) | (1<<9));
> -	inserted = (!(gpio & 0x1) && !(gpio & 0x2));
> -
> -	state->ready = 0;
> -	state->vs_Xv = 0;
> -	state->vs_3v = 0;
> -	state->detect = 0;
> -
> -	if (inserted) {
> -		switch (vs) {
> -			case 0:
> -			case 1:
> -			case 2:
> -				state->vs_3v=1;
> -				break;
> -			case 3: /* 5V */
> -			default:
> -				/* return without setting 'detect' */
> -				printk(KERN_ERR "au1x00_cs: unsupported VS\n",
> -						vs);
> -				return;
> -		}
> -		state->detect = 1;
> -	}
> -
> -	if (state->detect) {
> -		state->ready = 1;
> -	}
> -
> -	state->bvd1= gpio2 & (1<<10);
> -	state->bvd2 = gpio2 & (1<<11);
> -	state->wrprot=0;
> -	return 1;
> -}
> -
> -
> -static int xxs1500_pcmcia_get_irq_info(struct pcmcia_irq_info *info)
> -{
> -
> -	if(info->sock > PCMCIA_MAX_SOCK) return -1;
> -	info->irq = PCMCIA_IRQ;
> -	return 0;
> -}
> -
> -
> -static int
> -xxs1500_pcmcia_configure_socket(const struct pcmcia_configure *configure)
> -{
> -
> -	if(configure->sock > PCMCIA_MAX_SOCK) return -1;
> -
> -	DEBUG("Vcc %dV Vpp %dV, reset %d\n",
> -			configure->vcc, configure->vpp, configure->reset);
> -
> -	switch(configure->vcc){
> -		case 33: /* Vcc 3.3V */
> -			/* turn on power */
> -			DEBUG("turn on power\n");
> -			au_writel((au_readl(GPIO2_PINSTATE) & ~(1<<14))|(1<<30),
> -					GPIO2_OUTPUT);
> -			au_sync_delay(100);
> -			break;
> -		case 50: /* Vcc 5V */
> -		default: /* what's this ? */
> -			printk(KERN_ERR "au1x00_cs: unsupported VCC\n");
> -		case 0:  /* Vcc 0 */
> -			/* turn off power */
> -			au_sync_delay(100);
> -			au_writel(au_readl(GPIO2_PINSTATE) | (1<<14)|(1<<30),
> -					GPIO2_OUTPUT);
> -			break;
> -	}
> -
> -	if (!configure->reset) {
> -		DEBUG("deassert reset\n");
> -		au_writel((au_readl(GPIO2_PINSTATE) & ~(1<<4))|(1<<20),
> -				GPIO2_OUTPUT);
> -		au_sync_delay(100);
> -		au_writel((au_readl(GPIO2_PINSTATE) & ~(1<<5))|(1<<21),
> -				GPIO2_OUTPUT);
> -	}
> -	else {
> -		DEBUG("assert reset\n");
> -		au_writel(au_readl(GPIO2_PINSTATE) | (1<<4)|(1<<20),
> -				GPIO2_OUTPUT);
> -	}
> -	au_sync_delay(100);
> -	return 0;
> -}
> -
> -struct pcmcia_low_level xxs1500_pcmcia_ops = {
> -	xxs1500_pcmcia_init,
> -	xxs1500_pcmcia_shutdown,
> -	xxs1500_pcmcia_socket_state,
> -	xxs1500_pcmcia_get_irq_info,
> -	xxs1500_pcmcia_configure_socket
> -};
> diff --git a/drivers/pcmcia/xxs1500_ss.c b/drivers/pcmcia/xxs1500_ss.c
> new file mode 100644
> index 0000000..4e36930
> --- /dev/null
> +++ b/drivers/pcmcia/xxs1500_ss.c
> @@ -0,0 +1,357 @@
> +/*
> + * PCMCIA socket code for the MyCable XXS1500 system.
> + *
> + * Copyright (c) 2009 Manuel Lauss <manuel.lauss@gmail.com>
> + *
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/gpio.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/ioport.h>
> +#include <linux/mm.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm.h>
> +#include <linux/resource.h>
> +#include <linux/spinlock.h>
> +
> +#include <pcmcia/cs_types.h>
> +#include <pcmcia/cs.h>
> +#include <pcmcia/ss.h>
> +#include <pcmcia/cistpl.h>
> +
> +#include <asm/irq.h>
> +#include <asm/system.h>
> +#include <asm/mach-au1x00/au1000.h>
> +
> +#define MEM_MAP_SIZE	0x400000
> +#define IO_MAP_SIZE	0x1000
> +
> +
> +/*
> + * 3.3V cards only; all interfacing is done via gpios:
> + *
> + * 0/1:  carddetect (00 = card present, xx = huh)
> + * 4:	 card irq
> + * 204:  reset (high-act)
> + * 205:  buffer enable (low-act)
> + * 208/209: card voltage key (00,01,10,11)
> + * 210:  battwarn
> + * 211:  batdead
> + * 214:  power (low-act)
> + */
> +#define GPIO_CDA	0
> +#define GPIO_CDB	1
> +#define GPIO_CARDIRQ	4
> +#define GPIO_RESET	204
> +#define GPIO_OUTEN	205
> +#define GPIO_VSL	208
> +#define GPIO_VSH	209
> +#define GPIO_BATTDEAD	210
> +#define GPIO_BATTWARN	211
> +#define GPIO_POWER	214
> +
> +struct xxs1500_pcmcia_sock {
> +	struct pcmcia_socket	socket;
> +	void		*virt_io;
> +
> +	/* the "pseudo" addresses of the PCMCIA space. */
> +	unsigned long	phys_io;
> +	unsigned long	phys_attr;
> +	unsigned long	phys_mem;
> +
> +	/* previous flags for set_socket() */
> +	unsigned int old_flags;
> +};
> +
> +#define to_xxs_socket(x) container_of(x, struct xxs1500_pcmcia_sock,
>  socket) +
> +static irqreturn_t cdirq(int irq, void *data)
> +{
> +	struct xxs1500_pcmcia_sock *sock = data;
> +
> +	pcmcia_parse_events(&sock->socket, SS_DETECT);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int xxs1500_pcmcia_configure(struct pcmcia_socket *skt,
> +				    struct socket_state_t *state)
> +{
> +	struct xxs1500_pcmcia_sock *sock = to_xxs_socket(skt);
> +	unsigned int changed;
> +
> +	/* power control */
> +	switch (state->Vcc) {
> +	case 0:
> +		gpio_set_value(GPIO_POWER, 1);	/* power off */
> +		break;
> +	case 33:
> +		gpio_set_value(GPIO_POWER, 0);	/* power on */
> +		break;
> +	case 50:
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	changed = state->flags ^ sock->old_flags;
> +
> +	if (changed & SS_RESET) {
> +		if (state->flags & SS_RESET) {
> +			gpio_set_value(GPIO_RESET, 1);	/* assert reset */
> +			gpio_set_value(GPIO_OUTEN, 1);	/* buffers off */
> +		} else {
> +			gpio_set_value(GPIO_RESET, 0);	/* deassert reset */
> +			gpio_set_value(GPIO_OUTEN, 0);	/* buffers on */
> +			msleep(500);
> +		}
> +	}
> +
> +	sock->old_flags = state->flags;
> +
> +	return 0;
> +}
> +
> +static int xxs1500_pcmcia_get_status(struct pcmcia_socket *skt,
> +				     unsigned int *value)
> +{
> +	unsigned int status;
> +	int i;
> +
> +	status = 0;
> +
> +	/* check carddetects: GPIO[0:1] must both be low */
> +	if (!gpio_get_value(GPIO_CDA) && !gpio_get_value(GPIO_CDB))
> +		status |= SS_DETECT;
> +
> +	/* determine card voltage: GPIO[208:209] binary value */
> +	i = (!!gpio_get_value(GPIO_VSL)) | ((!!gpio_get_value(GPIO_VSH)) << 1);
> +
> +	switch (i) {
> +	case 0:
> +	case 1:
> +	case 2:
> +		status |= SS_3VCARD;	/* 3V card */
> +		break;
> +	case 3:				/* 5V card, unsupported */
> +	default:
> +		status |= SS_XVCARD;	/* treated as unsupported in core */
> +	}
> +
> +	/* GPIO214: low active power switch */
> +	status |= gpio_get_value(GPIO_POWER) ? 0 : SS_POWERON;
> +
> +	/* GPIO204: high-active reset line */
> +	status |= gpio_get_value(GPIO_RESET) ? SS_RESET : SS_READY;
> +
> +	/* other stuff */
> +	status |= gpio_get_value(GPIO_BATTDEAD) ? 0 : SS_BATDEAD;
> +	status |= gpio_get_value(GPIO_BATTWARN) ? 0 : SS_BATWARN;
> +
> +	*value = status;
> +
> +	return 0;
> +}
> +
> +static int xxs1500_pcmcia_sock_init(struct pcmcia_socket *skt)
> +{
> +	gpio_direction_input(GPIO_CDA);
> +	gpio_direction_input(GPIO_CDB);
> +	gpio_direction_input(GPIO_VSL);
> +	gpio_direction_input(GPIO_VSH);
> +	gpio_direction_input(GPIO_BATTDEAD);
> +	gpio_direction_input(GPIO_BATTWARN);
> +	gpio_direction_output(GPIO_RESET, 1);	/* assert reset */
> +	gpio_direction_output(GPIO_OUTEN, 1);	/* disable buffers */
> +	gpio_direction_output(GPIO_POWER, 1);	/* power off */
> +
> +	return 0;
> +}
> +
> +static int xxs1500_pcmcia_sock_suspend(struct pcmcia_socket *skt)
> +{
> +	return 0;
> +}
> +
> +static int au1x00_pcmcia_set_io_map(struct pcmcia_socket *skt,
> +				    struct pccard_io_map *map)
> +{
> +	struct xxs1500_pcmcia_sock *sock = to_xxs_socket(skt);
> +
> +	map->start = (u32)sock->virt_io;
> +	map->stop = map->start + IO_MAP_SIZE;
> +
> +	return 0;
> +}
> +
> +static int au1x00_pcmcia_set_mem_map(struct pcmcia_socket *skt,
> +				     struct pccard_mem_map *map)
> +{
> +	struct xxs1500_pcmcia_sock *sock = to_xxs_socket(skt);
> +
> +	if (map->flags & MAP_ATTRIB)
> +		map->static_start = sock->phys_attr + map->card_start;
> +	else
> +		map->static_start = sock->phys_mem + map->card_start;
> +
> +	return 0;
> +}
> +
> +static struct pccard_operations xxs1500_pcmcia_operations = {
> +	.init			= xxs1500_pcmcia_sock_init,
> +	.suspend		= xxs1500_pcmcia_sock_suspend,
> +	.get_status		= xxs1500_pcmcia_get_status,
> +	.set_socket		= xxs1500_pcmcia_configure,
> +	.set_io_map		= au1x00_pcmcia_set_io_map,
> +	.set_mem_map		= au1x00_pcmcia_set_mem_map,
> +};
> +
> +static int __devinit xxs1500_pcmcia_probe(struct platform_device *pdev)
> +{
> +	struct xxs1500_pcmcia_sock *sock;
> +	struct resource *r;
> +	phys_t physio;
> +	int ret, irq;
> +
> +	sock = kzalloc(sizeof(struct xxs1500_pcmcia_sock), GFP_KERNEL);
> +	if (!sock)
> +		return -ENOMEM;
> +
> +	ret = -ENODEV;
> +
> +	/*
> +	 * pseudo-attr:  The 32bit address of the PCMCIA attribute space
> +	 * for this socket (usually the 36bit address shifted 4 to the
> +	 * right).
> +	 */
> +	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pseudo-attr");
> +	if (!r) {
> +		dev_err(&pdev->dev, "missing 'pseudo-attr' resource!\n");
> +		goto out0;
> +	}
> +	sock->phys_attr = r->start;
> +
> +	/*
> +	 * pseudo-mem:  The 32bit address of the PCMCIA memory space for
> +	 * this socket (usually the 36bit address shifted 4 to the right)
> +	 */
> +	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pseudo-mem");
> +	if (!r) {
> +		dev_err(&pdev->dev, "missing 'pseudo-mem' resource!\n");
> +		goto out0;
> +	}
> +	sock->phys_mem = r->start;
> +
> +	/*
> +	 * pseudo-io:  The 32bit address of the PCMCIA IO space for this
> +	 * socket (usually the 36bit address shifted 4 to the right).
> +	 */
> +	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pseudo-io");
> +	if (!r) {
> +		dev_err(&pdev->dev, "missing 'pseudo-io' resource!\n");
> +		goto out0;
> +	}
> +	sock->phys_io = r->start;
> +
> +
> +	/* for io must remap the full 36bit address (for reference see
> +	 * alchemy/common/setup.c::__fixup_bigphys_addr)
> +	 */
> +	physio = ((phys_t)sock->phys_io) << 4;
> +
> +	/*
> +	 * PCMCIA client drivers use the inb/outb macros to access
> +	 * the IO registers.  Since mips_io_port_base is added
> +	 * to the access address of the mips implementation of
> +	 * inb/outb, we need to subtract it here because we want
> +	 * to access the I/O or MEM address directly, without
> +	 * going through this "mips_io_port_base" mechanism.
> +	 */
> +	sock->virt_io = (void *)(ioremap(physio, IO_MAP_SIZE) -
> +				 mips_io_port_base);
> +
> +	if (!sock->virt_io) {
> +		dev_err(&pdev->dev, "cannot remap IO area\n");
> +		ret = -ENOMEM;
> +		goto out0;
> +	}
> +
> +	sock->socket.ops	= &xxs1500_pcmcia_operations;
> +	sock->socket.owner	= THIS_MODULE;
> +	sock->socket.pci_irq	= gpio_to_irq(GPIO_CARDIRQ);
> +	sock->socket.features	= SS_CAP_STATIC_MAP | SS_CAP_PCCARD;
> +	sock->socket.map_size	= MEM_MAP_SIZE;
> +	sock->socket.io_offset	= (unsigned long)sock->virt_io;
> +	sock->socket.dev.parent	= &pdev->dev;
> +	sock->socket.resource_ops = &pccard_static_ops;
> +
> +	platform_set_drvdata(pdev, sock);
> +
> +	/* setup carddetect irq: use one of the 2 GPIOs as an
> +	 * edge detector.
> +	 */
> +	irq = gpio_to_irq(GPIO_CDA);
> +	set_irq_type(irq, IRQ_TYPE_EDGE_BOTH);
> +	ret = request_irq(irq, cdirq, 0, "pcmcia_carddetect", sock);
> +	if (ret) {
> +		dev_err(&pdev->dev, "cannot setup cd irq\n");
> +		goto out1;
> +	}
> +
> +	ret = pcmcia_register_socket(&sock->socket);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to register\n");
> +		goto out2;
> +	}
> +
> +	printk(KERN_INFO "MyCable XXS1500 PCMCIA socket services\n");
> +
> +	return 0;
> +
> +out2:
> +	free_irq(gpio_to_irq(GPIO_CDA), sock);
> +out1:
> +	iounmap((void *)(sock->virt_io + (u32)mips_io_port_base));
> +out0:
> +	kfree(sock);
> +	return ret;
> +}
> +
> +static int __devexit xxs1500_pcmcia_remove(struct platform_device *pdev)
> +{
> +	struct xxs1500_pcmcia_sock *sock = platform_get_drvdata(pdev);
> +
> +	pcmcia_unregister_socket(&sock->socket);
> +	free_irq(gpio_to_irq(GPIO_CDA), sock);
> +	iounmap((void *)(sock->virt_io + (u32)mips_io_port_base));
> +	kfree(sock);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver xxs1500_pcmcia_socket_driver = {
> +	.driver	= {
> +		.name	= "xxs1500_pcmcia",
> +		.owner	= THIS_MODULE,
> +	},
> +	.probe		= xxs1500_pcmcia_probe,
> +	.remove		= __devexit_p(xxs1500_pcmcia_remove),
> +};
> +
> +int __init xxs1500_pcmcia_socket_load(void)
> +{
> +	return platform_driver_register(&xxs1500_pcmcia_socket_driver);
> +}
> +
> +void  __exit xxs1500_pcmcia_socket_unload(void)
> +{
> +	platform_driver_unregister(&xxs1500_pcmcia_socket_driver);
> +}
> +
> +module_init(xxs1500_pcmcia_socket_load);
> +module_exit(xxs1500_pcmcia_socket_unload);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("PCMCIA Socket Services for MyCable XXS1500 systems");
> +MODULE_AUTHOR("Manuel Lauss");
> 

-- 
Best regards, Florian Fainelli
Email: florian@openwrt.org
Web: http://openwrt.org
IRC: [florian] on irc.freenode.net
-------------------------------
