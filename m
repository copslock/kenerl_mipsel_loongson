Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Oct 2008 18:09:23 +0100 (BST)
Received: from az33egw02.freescale.net ([192.88.158.103]:43195 "EHLO
	az33egw02.freescale.net") by ftp.linux-mips.org with ESMTP
	id S22018698AbYJURJU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 21 Oct 2008 18:09:20 +0100
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id m9LH92gL007087;
	Tue, 21 Oct 2008 10:09:03 -0700 (MST)
Received: from [192.168.2.4] (mvp-10-214-73-95.am.freescale.net [10.214.73.95])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m9LH91PK007673;
	Tue, 21 Oct 2008 12:09:01 -0500 (CDT)
Cc:	linux-mips@linux-mips.org, netdev@vger.kernel.org
Message-Id: <B812781E-031F-4A1E-8FDB-E0482F495325@freescale.com>
From:	Andy Fleming <afleming@freescale.com>
To:	Maxime Bizon <mbizon@freebox.fr>
In-Reply-To: <1224382023-24412-1-git-send-email-mbizon@freebox.fr>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH/RFC v1 10/12] [MIPS] BCM63XX: Add integrated ethernet PHY support for phylib.
Date:	Tue, 21 Oct 2008 12:08:54 -0500
References: <1224382023-24412-1-git-send-email-mbizon@freebox.fr>
X-Mailer: Apple Mail (2.929.2)
Return-Path: <afleming@freescale.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20832
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: afleming@freescale.com
Precedence: bulk
X-list: linux-mips


On Oct 18, 2008, at 21:07, Maxime Bizon wrote:

> Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
> ---
> drivers/net/phy/Kconfig   |    6 ++
> drivers/net/phy/Makefile  |    1 +
> drivers/net/phy/bcm63xx.c |  132 ++++++++++++++++++++++++++++++++++++ 
> +++++++++
> 3 files changed, 139 insertions(+), 0 deletions(-)
> create mode 100644 drivers/net/phy/bcm63xx.c
>
> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
> index d55932a..a5d2c2d 100644
> --- a/drivers/net/phy/Kconfig
> +++ b/drivers/net/phy/Kconfig
> @@ -56,6 +56,12 @@ config BROADCOM_PHY
> 	  Currently supports the BCM5411, BCM5421, BCM5461, BCM5464, BCM5481
> 	  and BCM5482 PHYs.
>
> +config BCM63XX_PHY
> +	tristate "Drivers for Broadcom 63xx SOCs internal PHY"
> +	depends on BCM63XX


This is probably right, but just to check: These PHYs will never be  
used outside of the BCM63xx family?


>
> +	---help---
> +	  Currently supports the 6348 and 6358 PHYs.
> +
> config ICPLUS_PHY
> 	tristate "Drivers for ICPlus PHYs"
> 	---help---
> diff --git a/drivers/net/phy/bcm63xx.c b/drivers/net/phy/bcm63xx.c
> new file mode 100644
> index 0000000..4fed95e

> +static int bcm63xx_config_init(struct phy_device *phydev)
> +{
> +	int reg, err;
> +
> +	reg = phy_read(phydev, MII_BCM63XX_IR);
> +	if (reg < 0)
> +		return reg;
> +
> +	/* Mask interrupts globally.  */
> +	reg |= MII_BCM63XX_IR_GMASK;
> +	err = phy_write(phydev, MII_BCM63XX_IR, reg);
> +	if (err < 0)
> +		return err;
> +
> +	/* Unmask events we are interested in  */
> +	reg = ~(MII_BCM63XX_IR_DUPLEX |
> +		MII_BCM63XX_IR_SPEED |
> +		MII_BCM63XX_IR_LINK) |
> +		MII_BCM63XX_IR_EN;

You just cleared the global interrupt mask.  I have two problems with  
that:

1) If there's some reason you need to mask and then unmask interrupts,  
you should make that clear in the comments.  If there's not a reason,  
then it's a bit silly to do both.

2) Interrupts should not be enabled until the PHY's config_intr()  
function is called, and asks for them to be enabled.

Maybe you just wanted that to be:

  reg &= ~(MII_BCM63XX_IR_DUPLEX |
...


The other comment I have is that these probably should go in the  
broadcom.c file.  I'm not deeply tied to the notion of one file per  
company, but it has become the way it is done.

Andy
