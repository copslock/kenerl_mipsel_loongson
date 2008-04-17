Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Apr 2008 01:54:22 +0100 (BST)
Received: from srv5.dvmed.net ([207.36.208.214]:21684 "EHLO mail.dvmed.net")
	by ftp.linux-mips.org with ESMTP id S20030720AbYDQAyT (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 17 Apr 2008 01:54:19 +0100
Received: from cpe-069-134-071-233.nc.res.rr.com ([69.134.71.233] helo=core.yyz.us)
	by mail.dvmed.net with esmtpsa (Exim 4.68 #1 (Red Hat Linux))
	id 1JmIOB-00083H-SZ; Thu, 17 Apr 2008 00:54:12 +0000
Message-ID: <48069FB3.1070404@garzik.org>
Date:	Wed, 16 Apr 2008 20:54:11 -0400
From:	Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 2.0.0.12 (X11/20080226)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	Andy Fleming <afleming@freescale.com>, linux-mips@linux-mips.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 1/6] tc35815: Statistics cleanup
References: <20080411.002412.03977557.anemo@mba.ocn.ne.jp>	<48007A41.2000803@garzik.org> <20080413.001146.25909265.anemo@mba.ocn.ne.jp>
In-Reply-To: <20080413.001146.25909265.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jeff@garzik.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18944
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jeff@garzik.org
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Sat, 12 Apr 2008 05:00:49 -0400, Jeff Garzik <jeff@garzik.org> wrote:
>> applied 1-6
> 
> Thanks.
> 
> Could you apply this too, or hopufully fold into Andy Fleming's "phy:
> Change mii_bus id field to a string" patch (commit c69fedae) ?
> 
> ------------------------------------------------------
> Subject: [PATCH] tc35815: build fix
> 
> Fix build failure caused by Andy Fleming's "phy: Change mii_bus id
> field to a string" patch.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> ---
> diff --git a/drivers/net/tc35815.c b/drivers/net/tc35815.c
> index 744f11f..10e4e85 100644
> --- a/drivers/net/tc35815.c
> +++ b/drivers/net/tc35815.c
> @@ -766,7 +766,8 @@ static int tc_mii_init(struct net_device *dev)
>  	lp->mii_bus.name = "tc35815_mii_bus";
>  	lp->mii_bus.read = tc_mdio_read;
>  	lp->mii_bus.write = tc_mdio_write;
> -	lp->mii_bus.id = (lp->pci_dev->bus->number << 8) | lp->pci_dev->devfn;
> +	snprintf(lp->mii_bus.id, MII_BUS_ID_SIZE, "%x",
> +		 (lp->pci_dev->bus->number << 8) | lp->pci_dev->devfn);
>  	lp->mii_bus.priv = dev;
>  	lp->mii_bus.dev = &lp->pci_dev->dev;
>  	lp->mii_bus.irq = kmalloc(sizeof(int) * PHY_MAX_ADDR, GFP_KERNEL);

applied
