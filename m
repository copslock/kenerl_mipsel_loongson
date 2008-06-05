Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jun 2008 21:43:35 +0100 (BST)
Received: from smtp4.int-evry.fr ([157.159.10.71]:26803 "HELO
	smtp4.int-evry.fr") by ftp.linux-mips.org with SMTP
	id S28574914AbYFEUnd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 5 Jun 2008 21:43:33 +0100
Received: from smtp2.int-evry.fr (smtp2.int-evry.fr [157.159.10.45])
	by smtp4.int-evry.fr (Postfix) with ESMTP id 65890FE4090;
	Thu,  5 Jun 2008 22:43:27 +0200 (CEST)
Received: from smtp-ext.int-evry.fr (smtp-ext.int-evry.fr [157.159.11.17])
	by smtp2.int-evry.fr (Postfix) with ESMTP id 32BD03EEC75;
	Thu,  5 Jun 2008 22:43:24 +0200 (CEST)
Received: from lenovo.local (60.130.195-77.rev.gaoland.net [77.195.130.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id BA0F59007E;
	Thu,  5 Jun 2008 22:43:23 +0200 (CEST)
From:	Florian Fainelli <florian.fainelli@telecomint.eu>
To:	"Daniel Laird" <daniel.j.laird@nxp.com>
Subject: Re: [PATCH] : Add support for NXP PNX833x (STB222/5) into linux kernel
Date:	Thu, 5 Jun 2008 22:43:18 +0200
User-Agent: KMail/1.9.9
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
References: <64660ef00806051245n5ba8ffc5hece63f743d2e2d01@mail.gmail.com>
In-Reply-To: <64660ef00806051245n5ba8ffc5hece63f743d2e2d01@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200806052243.18653.florian.fainelli@telecomint.eu>
X-INT-MailScanner-Information: Please contact the ISP for more information
X-MailScanner-ID: 32BD03EEC75.97174
X-INT-MailScanner: Found to be clean
X-INT-MailScanner-SpamCheck: 
X-INT-MailScanner-From:	florian.fainelli@telecomint.eu
Return-Path: <florian.fainelli@telecomint.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19410
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.fainelli@telecomint.eu
Precedence: bulk
X-list: linux-mips

Hello Daniel,

Le Thursday 05 June 2008 21:45:13 Daniel Laird, vous avez écrit :
> The following patch add support for the NXP PNX833x SOC.  More
> specifically it adds support for
> the STB222/5 variant.  This has I2C support, NAND and onboard ethernet
> support.

You should send the i2c parts to Jean Delvare and Ben Dooks, the I2C 
maintainers. Ethernet part should be sent to the netdev mailing-list.

You can send the other pending parts to their respective maintainers, since 
your drivers will be either platform drivers, and/or they depend on 
CONFIG_NXP_STB225, they can be merged now, and get active when MIPS code is 
merged as well.

I have posted some comments below in the body of your email, code looks 
overall very good.

> +/***********************************************
> +* INCLUDE FILES                                *
> +************************************************/
> +
> +#include <asm/mach-pnx833x/pnx833x.h>
> +#include <linux/serial_pnx8xxx.h>

You might want to get rid of such comments with lines of *, and probably 
reorder the inclusion to include first linux then asm headers.

> +#if defined(CONFIG_SATA_PNX833X) || defined(CONFIG_SATA_PNX833X_MODULE)
> +static struct resource pnx833x_sata_resources[] = {
> +       [0] = {
> +               .start = PNX8335_SATA_PORTS_START,
> +               .end   = PNX8335_SATA_PORTS_END,
> +               .flags = IORESOURCE_MEM,
> +       },
> +       [1] = {
> +               .start = PNX8335_PIC_SATA_INT,
> +               .end   = PNX8335_PIC_SATA_INT,
> +               .flags = IORESOURCE_IRQ,
> +       },
> +};
> +
> +static struct platform_device pnx833x_sata_device = {
> +       .name          = "pnx833x-sata",
> +       .id            = -1,
> +       .num_resources = ARRAY_SIZE(pnx833x_sata_resources),
> +       .resource      = pnx833x_sata_resources,
> +};
> +#endif

What about defining those resources anyway ?
> +
> +#if defined(CONFIG_MTD_NAND_PLATFORM) ||
> defined(CONFIG_MTD_NAND_PLATFORM_MODULE)

Same here and others below too.

> +
> +#define STB225_NAND_BASE           0x18000000  /* I/O location(gets
> remapped)*/ +#define STB225_NAND_CLE_MASK   0x00100000      /* I/O location
> with CLE high */ +#define STB225_NAND_ALE_MASK   0x00010000      /* I/O
> location with ALE high */ +

You might want to put this in an header file instead.

> +void pnx833x_machine_halt(void)
> +{
> +       printk(KERN_ALERT "\n\nSystem halted.\n\n");
> +
> +       while (1)
> +               __asm__ __volatile__ ("wait");
> +}

You might want to use cpu_relax(); instead of the assembly wait instruction.

> +
> +void pnx833x_machine_power_off(void)
> +{
> +       printk(KERN_ALERT "\n\nPower off not implemented.");
> +       pnx833x_machine_halt();
> +}

And put some less alarming message here, like "*** You can safely turn off the 
board".

> +int __init plat_mem_setup(void)
> +{
> +       /* fake pci bus to avoid bounce buffers */
> +       PCI_DMA_BUS_IS_PHYS = 1;
> +
> +       /* set mips clock to 320MHz */
> +#if defined(CONFIG_SOC_PNX8335)
> +       PNX8335_WRITEFIELD(0x17, CLOCK_PLL_CPU_CTL, FREQ);
> +#endif
> +       gpio_init();    /* so it will be ready in board_setup() */

You can move the GPIO code into its own C file, and use arch_initcall to 
initialise it. Prefixing gpio_init with pnx83xx is better to be consistent 
with other functions. See below for more comments about the GPIO code.

> +static inline unsigned long ip3902_read_reg(struct net_device *ndev, int
> reg) +{
> +       unsigned long value = readl((void * __iomem)(ndev->base_addr +
> reg)); +       return value;

Useless cast to void * __iomem in general, did your compiler produced a 
warning on this ?

Netdev people will probably ask you to use NAPI unconditionnaly for new 
drivers.

> +#ifdef IP3902_NAPI
> +static int ip3902_poll(struct napi_struct *napi, int budget)
> +{
> +       struct ip3902_private *ip3902_priv = container_of(napi, struct
> ip3902_private, napi);
> +       struct net_device *ndev = ip3902_priv->ndev;
> +       int work_done;
> +
> +       work_done = ip3902_eth_receive_queue(ndev, ip3902_priv, budget);
> +
> +       if (work_done < budget) {
> +               ip3902_write_reg(ndev, INT_CLEAR_REG, RX_DONE_INT);
> +               ip3902_write_reg(ndev, INT_CLEAR_REG, 0);
> +               netif_rx_complete(ndev, napi);
> +               ip3902_write_reg(ndev, INT_ENABLE_REG, (TX_UNDERRUN_INT |
> RX_DONE_INT | RX_OVERRUN_INT));
> +       }
> +
> +       return work_done;
> +}
> +#endif



> +/* BIG FAT WARNING: races danger!
> +   No protections exist here. Current users are only early init code,
> +   when locking is not needed because no cuncurency yet exists there,
> +   and GPIO IRQ dispatcher, which does locking.
> +   However, if many uses will ever happen, proper locking will be needed
> +   - including locking between different uses

You should consider using the GPIO library, or read what is done for BCM47xx, 
AU1000 and TX4938. This should be easy since you comply with most of your 
functions to this GPIO API. Providing your board specific gpio functions, the 
rest of the API will handle locking and interrupt context for you.

Also, prefix your functions so that they will not collide with the other 
implementations naming scheme.

Such functions might be provided by the C file instead, in the archicture 
code. Remapping GPIO registers or things like that can be done there as well 
at board boot time.
-- 
Cordialement, Florian Fainelli
------------------------------
