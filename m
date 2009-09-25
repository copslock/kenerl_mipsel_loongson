Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Sep 2009 18:35:58 +0200 (CEST)
Received: from h155.mvista.com ([63.81.120.155]:11177 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493121AbZIYQfu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 25 Sep 2009 18:35:50 +0200
Received: from [192.168.11.189] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 0374F3EC9; Fri, 25 Sep 2009 09:35:30 -0700 (PDT)
Message-ID: <4ABCF1E7.4010304@ru.mvista.com>
Date:	Fri, 25 Sep 2009 20:37:59 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	mbizon@freebox.fr
Cc:	Wolfram Sang <w.sang@pengutronix.de>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	linux-pcmcia@lists.infradead.org, linux-mips@linux-mips.org,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: BCM63xx: Add PCMCIA & Cardbus support.
References: <1253272891.1627.284.camel@sakura.staff.proxad.net>	 <20090923123143.GB3131@pengutronix.de>	 <1253709915.1627.397.camel@sakura.staff.proxad.net> <1253890476.1627.468.camel@sakura.staff.proxad.net>
In-Reply-To: <1253890476.1627.468.camel@sakura.staff.proxad.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24100
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Maxime Bizon wrote:

>>On Wed, 2009-09-23 at 14:31 +0200, Wolfram Sang wrote:

>>>Okay, here is a fast review. If you fix the mentioned points (or give me good
>>>reasons why not ;)), then you might add my

>>>Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>

>>>I am fine with Ralf picking this up.

>>Agreed on all your points and will fix them. Thanks.

>>Ralf, please give me a couple of days to fix this and I will send you an
>>updated patch.

> Here it is:

> Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>

[...]

> diff --git a/arch/mips/bcm63xx/dev-pcmcia.c b/arch/mips/bcm63xx/dev-pcmcia.c
> new file mode 100644
> index 0000000..4fb42ac
> --- /dev/null
> +++ b/arch/mips/bcm63xx/dev-pcmcia.c
> @@ -0,0 +1,135 @@
> +/*
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + * Copyright (C) 2008 Maxime Bizon <mbizon@freebox.fr>
> + */
> +
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <asm/bootinfo.h>
> +#include <linux/platform_device.h>
> +#include <bcm63xx_cs.h>
> +#include <bcm63xx_cpu.h>
> +#include <bcm63xx_dev_pcmcia.h>
> +#include <bcm63xx_io.h>
> +#include <bcm63xx_regs.h>
> +
> +static struct resource pcmcia_resources[] = {
> +	/* pcmcia registers */
> +	{
> +		.start		= -1, /* filled at runtime */
> +		.end		= -1, /* filled at runtime */

    Then why initialize it?

[...]

> +		.flags		= IORESOURCE_MEM,
> +	},
> +static const __initdata unsigned int pcmcia_cs[3][3] = {
> +	/* cs, base address, size */

    Shouln't this be array of structures instead?

> +	{ MPI_CS_PCMCIA_COMMON, BCM_PCMCIA_COMMON_BASE_PA,
> +	  BCM_PCMCIA_COMMON_SIZE },
> +
> +	{ MPI_CS_PCMCIA_ATTR, BCM_PCMCIA_ATTR_BASE_PA,
> +	  BCM_PCMCIA_ATTR_SIZE },
> +
> +	{ MPI_CS_PCMCIA_IO, BCM_PCMCIA_IO_BASE_PA,
> +	  BCM_PCMCIA_IO_SIZE },
> +};
> +
> +int __init bcm63xx_pcmcia_register(void)
> +{
> +	int ret, i;
> +
> +	if (!BCMCPU_IS_6348() && !BCMCPU_IS_6358())
> +		return 0;
> +
> +	/* use correct pcmcia ready gpio depending on processor */
> +	switch (bcm63xx_get_cpu_id()) {
> +	case BCM6348_CPU_ID:
> +		pd.ready_gpio = 22;
> +		break;
> +
> +	case BCM6358_CPU_ID:
> +		pd.ready_gpio = 18;
> +		break;

    Is this GPIO selection really chip- and not board-specific?

[...]

> diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_pcmcia.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_pcmcia.h
> new file mode 100644
> index 0000000..2beb396
> --- /dev/null
> +++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_pcmcia.h
> @@ -0,0 +1,13 @@
> +#ifndef BCM63XX_DEV_PCMCIA_H_
> +#define BCM63XX_DEV_PCMCIA_H_
> +
> +/*
> + * PCMCIA driver platform data
> + */
> +struct bcm63xx_pcmcia_platform_data {
> +	unsigned int ready_gpio;
> +};
> +
> +int bcm63xx_pcmcia_register(void);
> +
> +#endif /* BCM63XX_DEV_PCMCIA_H_ */
> diff --git a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
> index fbf965b..17f38a7 100644
> --- a/drivers/pcmcia/Kconfig
> +++ b/drivers/pcmcia/Kconfig
> @@ -192,6 +192,10 @@ config PCMCIA_AU1X00
>  	tristate "Au1x00 pcmcia support"
>  	depends on SOC_AU1X00 && PCMCIA
>  
> +config PCMCIA_BCM63XX
> +	tristate "bcm63xx pcmcia support"
> +	depends on BCM63XX && PCMCIA
> +
>  config PCMCIA_SA1100
>  	tristate "SA1100 support"
>  	depends on ARM && ARCH_SA1100 && PCMCIA

    I don't think having both board code and the driver in a single patch is 
a good idea. I'd put the driver in its own separate patch...

> diff --git a/drivers/pcmcia/bcm63xx_pcmcia.c b/drivers/pcmcia/bcm63xx_pcmcia.c
> new file mode 100644
> index 0000000..ef186c6
> --- /dev/null
> +++ b/drivers/pcmcia/bcm63xx_pcmcia.c

[...]

> +static struct pci_device_id bcm63xx_cb_table[] = {
> +	{
> +		.vendor		= PCI_VENDOR_ID_BROADCOM,
> +		.device		= PCI_ANY_ID,

    Are you sure you can drive any Broadcom's bridge?

> +		.subvendor	= PCI_VENDOR_ID_BROADCOM,
> +		.subdevice	= PCI_ANY_ID,
> +		.class		= PCI_CLASS_BRIDGE_CARDBUS << 8,
> +		.class_mask	= ~0,
> +	},
> +
> +	{ },
> +};
> +
> +MODULE_DEVICE_TABLE(pci, bcm63xx_cb_table);
> +
> +static struct pci_driver bcm63xx_cardbus_driver = {
> +	.name		= "yenta_cardbus",

    Why it's called the same as 'yenta_cardbus_driver' and not 
"bcm63xx_cardbus"?

> +	.id_table	= bcm63xx_cb_table,
> +	.probe		= bcm63xx_cb_probe,
> +	.remove		= __devexit_p(bcm63xx_cb_exit),
> +};
> +#endif

[...]

> diff --git a/drivers/pcmcia/bcm63xx_pcmcia.h b/drivers/pcmcia/bcm63xx_pcmcia.h
> new file mode 100644
> index 0000000..85de866
> --- /dev/null
> +++ b/drivers/pcmcia/bcm63xx_pcmcia.h
> @@ -0,0 +1,65 @@
> +#ifndef BCM63XX_PCMCIA_H_
> +#define BCM63XX_PCMCIA_H_
> +
> +#include <linux/types.h>
> +#include <linux/timer.h>
> +#include <pcmcia/ss.h>
> +#include <bcm63xx_dev_pcmcia.h>
> +
> +/* socket polling rate in ms */
> +#define BCM63XX_PCMCIA_POLL_RATE	500
> +
> +enum {
> +	CARD_CARDBUS = (1 << 0),
> +
> +	CARD_PCCARD = (1 << 1),
> +
> +	CARD_5V = (1 << 2),
> +
> +	CARD_3V = (1 << 3),
> +
> +	CARD_XV = (1 << 4),
> +
> +	CARD_YV = (1 << 5),

    Why so many empty lines in between?

> +};

WBR, Sergei
