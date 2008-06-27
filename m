Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jun 2008 06:34:35 +0100 (BST)
Received: from srv5.dvmed.net ([207.36.208.214]:38859 "EHLO mail.dvmed.net")
	by ftp.linux-mips.org with ESMTP id S20026854AbYF0FeH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 27 Jun 2008 06:34:07 +0100
Received: from cpe-069-134-153-115.nc.res.rr.com ([69.134.153.115] helo=core.yyz.us)
	by mail.dvmed.net with esmtpsa (Exim 4.69 #1 (Red Hat Linux))
	id 1KC6ay-0002Gz-09; Fri, 27 Jun 2008 05:34:05 +0000
Message-ID: <48647BCB.80700@garzik.org>
Date:	Fri, 27 Jun 2008 01:34:03 -0400
From:	Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	linux-mips@linux-mips.org, netdev@vger.kernel.org
Subject: Re: [PATCH] tc35815: Mark carrier-off before starting PHY
References: <20080625.114101.102912128.nemoto@toshiba-tops.co.jp>
In-Reply-To: <20080625.114101.102912128.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jeff@garzik.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19654
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jeff@garzik.org
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> Call netif_carrier_off() before starting PHY device.  This is a
> behavior before converting to generic PHY layer.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> ---
> diff --git a/drivers/net/tc35815.c b/drivers/net/tc35815.c
> index 10e4e85..dccea52 100644
> --- a/drivers/net/tc35815.c
> +++ b/drivers/net/tc35815.c
> @@ -1394,6 +1394,7 @@ tc35815_open(struct net_device *dev)
>  	tc35815_chip_init(dev);
>  	spin_unlock_irq(&lp->lock);
>  
> +	netif_carrier_off(dev);
>  	/* schedule a link state check */
>  	phy_start(lp->phy_dev);
>  
> @@ -2453,6 +2454,7 @@ static int tc35815_resume(struct pci_dev *pdev)
>  		return 0;
>  	pci_set_power_state(pdev, PCI_D0);
>  	tc35815_restart(dev);
> +	netif_carrier_off(dev);
>  	if (lp->phy_dev)

applied
