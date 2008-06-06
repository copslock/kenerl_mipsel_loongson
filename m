Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jun 2008 09:32:20 +0100 (BST)
Received: from hs-out-0708.google.com ([64.233.178.243]:42563 "EHLO
	hs-out-0708.google.com") by ftp.linux-mips.org with ESMTP
	id S20026335AbYFFIcR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 6 Jun 2008 09:32:17 +0100
Received: by hs-out-0708.google.com with SMTP id x43so693058hsb.0
        for <linux-mips@linux-mips.org>; Fri, 06 Jun 2008 01:32:15 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition:x-google-sender-auth;
        bh=Go2P2G0qNEcYeyCEmD5pP95ZAtBbgwVUBSojMN2kOs0=;
        b=pX8lIwwF7pyc03lzAIchY5xlovNnb7PgRLTGd1/tMFS+QxnE3+eBDqIeppQXfCn2+W
         BaUGVN5lTZo3BEJuR/qcpP/jxeoeKjqPTdhWmCa0FHOk4owEaDCrKPmCdo/kEvl8dUnI
         S2Xo0wvKKh9zvNNPg1Os10hC3nykDWyiK28cc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=xw8JwuctoZrTkYYucCvGxSwVsUUW87k8f6YDg02k9Alvuv2sBiUJWzcsBSzI1+ERlm
         6OKapvgkzVS2xCp2Hkz1iapaJonKkQwiwu37lRrqHzPtZJVN0cdUugIAY2+/2JBqCHMn
         xc1iXRQqf2ydxTxcaXwDJ87KBxvuk+wUKfoa8=
Received: by 10.90.119.20 with SMTP id r20mr2952477agc.60.1212741135564;
        Fri, 06 Jun 2008 01:32:15 -0700 (PDT)
Received: by 10.90.70.11 with HTTP; Fri, 6 Jun 2008 01:32:15 -0700 (PDT)
Message-ID: <64660ef00806060132j1aab8d9fh968cbf3f2fc56bc2@mail.gmail.com>
Date:	Fri, 6 Jun 2008 09:32:15 +0100
From:	"Daniel Laird" <daniel.j.laird@nxp.com>
To:	"Florian Fainelli" <florian.fainelli@telecomint.eu>,
	"Daniel Laird" <daniel.j.laird@nxp.com>
Subject: RE: [PATCH] : Add support for NXP PNX833x (STB222/5) into linux kernel
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
X-Google-Sender-Auth: b1cc2a38c41178a4
Return-Path: <daniel.j.laird@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19423
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.j.laird@nxp.com
Precedence: bulk
X-list: linux-mips

> From: florian.fainelli@telecomint.eu
> To: daniel.j.laird@nxp.com
> Subject: Re: [PATCH] : Add support for NXP PNX833x (STB222/5) into linux kernel
> Date: Thu, 5 Jun 2008 22:43:18 +0200
> CC: linux-mips@linux-mips.org; ralf@linux-mips.org
>
> Hello Daniel,
>
> Le Thursday 05 June 2008 21:45:13 Daniel Laird, vous avez écrit :
> > The following patch add support for the NXP PNX833x SOC.  More
> > specifically it adds support for
> > the STB222/5 variant.  This has I2C support, NAND and onboard ethernet
> > support.
>
> You should send the i2c parts to Jean Delvare and Ben Dooks, the I2C
> maintainers. Ethernet part should be sent to the netdev mailing-list.
>
> You can send the other pending parts to their respective maintainers, since
> your drivers will be either platform drivers, and/or they depend on
> CONFIG_NXP_STB225, they can be merged now, and get active when MIPS code is
> merged as well.
>
> I have posted some comments below in the body of your email, code looks
> overall very good.
>
> > +/***********************************************
> > +* INCLUDE FILES                                *
> > +************************************************/
> > +
> > +#include <asm/mach-pnx833x/pnx833x.h>
> > +#include <linux/serial_pnx8xxx.h>
>
> You might want to get rid of such comments with lines of *, and probably
> reorder the inclusion to include first linux then asm headers.
Agreed.

>
> > +#if defined(CONFIG_SATA_PNX833X) || defined(CONFIG_SATA_PNX833X_MODULE)
> > +static struct resource pnx833x_sata_resources[] = {
> > +       [0] = {
> > +               .start = PNX8335_SATA_PORTS_START,
> > +               .end   = PNX8335_SATA_PORTS_END,
> > +               .flags = IORESOURCE_MEM,
> > +       },
> > +       [1] = {
> > +               .start = PNX8335_PIC_SATA_INT,
> > +               .end   = PNX8335_PIC_SATA_INT,
> > +               .flags = IORESOURCE_IRQ,
> > +       },
> > +};
> > +
> > +static struct platform_device pnx833x_sata_device = {
> > +       .name          = "pnx833x-sata",
> > +       .id            = -1,
> > +       .num_resources = ARRAY_SIZE(pnx833x_sata_resources),
> > +       .resource      = pnx833x_sata_resources,
> > +};
> > +#endif
>
> What about defining those resources anyway ?
> > +
> > +#if defined(CONFIG_MTD_NAND_PLATFORM) ||
> > defined(CONFIG_MTD_NAND_PLATFORM_MODULE)
>
> Same here and others below too.
>
Is there any harm in having them always defined even if not
implemented? I was playing safe.

> > +
> > +#define STB225_NAND_BASE           0x18000000  /* I/O location(gets
> > remapped)*/ +#define STB225_NAND_CLE_MASK   0x00100000      /* I/O location
> > with CLE high */ +#define STB225_NAND_ALE_MASK   0x00010000      /* I/O
> > location with ALE high */ +
>
> You might want to put this in an header file instead.

Agreed will do this.

>
> > +void pnx833x_machine_halt(void)
> > +{
> > +       printk(KERN_ALERT "\n\nSystem halted.\n\n");
> > +
> > +       while (1)
> > +               __asm__ __volatile__ ("wait");
> > +}
>
> You might want to use cpu_relax(); instead of the assembly wait instruction.
>
Sounds good.

> > +
> > +void pnx833x_machine_power_off(void)
> > +{
> > +       printk(KERN_ALERT "\n\nPower off not implemented.");
> > +       pnx833x_machine_halt();
> > +}
>
> And put some less alarming message here, like "*** You can safely turn off the
> board".
>

Agreed.

> > +int __init plat_mem_setup(void)
> > +{
> > +       /* fake pci bus to avoid bounce buffers */
> > +       PCI_DMA_BUS_IS_PHYS = 1;
> > +
> > +       /* set mips clock to 320MHz */
> > +#if defined(CONFIG_SOC_PNX8335)
> > +       PNX8335_WRITEFIELD(0x17, CLOCK_PLL_CPU_CTL, FREQ);
> > +#endif
> > +       gpio_init();    /* so it will be ready in board_setup() */
>
> You can move the GPIO code into its own C file, and use arch_initcall to
> initialise it. Prefixing gpio_init with pnx83xx is better to be consistent
> with other functions. See below for more comments about the GPIO code.
>

I will prefix all gpio functions for safety.  I will look into gpio
library and submit a later patch
for that.  I would quite like to get this in and then optimise or I
will take to long and miss the window
again :-(

> > +static inline unsigned long ip3902_read_reg(struct net_device *ndev, int
> > reg) +{
> > +       unsigned long value = readl((void * __iomem)(ndev->base_addr +
> > reg)); +       return value;
>
> Useless cast to void * __iomem in general, did your compiler produced a
> warning on this ?
>
> Netdev people will probably ask you to use NAPI unconditionnaly for new
> drivers.
>
Will do.

> > +#ifdef IP3902_NAPI
> > +static int ip3902_poll(struct napi_struct *napi, int budget)
> > +{
> > +       struct ip3902_private *ip3902_priv = container_of(napi, struct
> > ip3902_private, napi);
> > +       struct net_device *ndev = ip3902_priv->ndev;
> > +       int work_done;
> > +
> > +       work_done = ip3902_eth_receive_queue(ndev, ip3902_priv, budget);
> > +
> > +       if (work_done < budget) {
> > +               ip3902_write_reg(ndev, INT_CLEAR_REG, RX_DONE_INT);
> > +               ip3902_write_reg(ndev, INT_CLEAR_REG, 0);
> > +               netif_rx_complete(ndev, napi);
> > +               ip3902_write_reg(ndev, INT_ENABLE_REG, (TX_UNDERRUN_INT |
> > RX_DONE_INT | RX_OVERRUN_INT));
> > +       }
> > +
> > +       return work_done;
> > +}
> > +#endif
>
>
>
> > +/* BIG FAT WARNING: races danger!
> > +   No protections exist here. Current users are only early init code,
> > +   when locking is not needed because no cuncurency yet exists there,
> > +   and GPIO IRQ dispatcher, which does locking.
> > +   However, if many uses will ever happen, proper locking will be needed
> > +   - including locking between different uses
>
> You should consider using the GPIO library, or read what is done for BCM47xx,
> AU1000 and TX4938. This should be easy since you comply with most of your
> functions to this GPIO API. Providing your board specific gpio functions, the
> rest of the API will handle locking and interrupt context for you.
>
> Also, prefix your functions so that they will not collide with the other
> implementations naming scheme.
>
> Such functions might be provided by the C file instead, in the archicture
> code. Remapping GPIO registers or things like that can be done there as well
> at board boot time.
> --
> Cordialement, Florian Fainelli
> ------------------------------
>
Many thanks for all comments, will do gpio library in a later patch.
Will split i2c and ip3902 off into patches to the i2c and netdev mailing lists.
Hopefully update the linux-mips patch today.
Daniel
