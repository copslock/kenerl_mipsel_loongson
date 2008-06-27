Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jun 2008 06:34:08 +0100 (BST)
Received: from srv5.dvmed.net ([207.36.208.214]:36555 "EHLO mail.dvmed.net")
	by ftp.linux-mips.org with ESMTP id S20026850AbYF0FeB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 27 Jun 2008 06:34:01 +0100
Received: from cpe-069-134-153-115.nc.res.rr.com ([69.134.153.115] helo=core.yyz.us)
	by mail.dvmed.net with esmtpsa (Exim 4.69 #1 (Red Hat Linux))
	id 1KC6aq-0002Ge-Pc; Fri, 27 Jun 2008 05:33:58 +0000
Message-ID: <48647BC4.90402@garzik.org>
Date:	Fri, 27 Jun 2008 01:33:56 -0400
From:	Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	linux-mips@linux-mips.org, netdev@vger.kernel.org
Subject: Re: [PATCH] tc35815: Fix receiver hangup on Rx FIFO overflow
References: <20080626.171415.81099548.nemoto@toshiba-tops.co.jp>
In-Reply-To: <20080626.171415.81099548.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jeff@garzik.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19653
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jeff@garzik.org
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Rx FIFO overflow error, the controller consume a buffer descriptor
> but currently the driver does not give it back to the controller.
> This results unrecoverable 'Buffer List Exhausted' condition.  This
> patch fix this problem by moving a "fbl_count--" line to proper place.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> ---
> diff --git a/drivers/net/tc35815.c b/drivers/net/tc35815.c
> index dccea52..b07b8cb 100644
> --- a/drivers/net/tc35815.c
> +++ b/drivers/net/tc35815.c
> @@ -1736,7 +1736,6 @@ tc35815_rx(struct net_device *dev)
>  			skb = lp->rx_skbs[cur_bd].skb;
>  			prefetch(skb->data);
>  			lp->rx_skbs[cur_bd].skb = NULL;
> -			lp->fbl_count--;
>  			pci_unmap_single(lp->pci_dev,
>  					 lp->rx_skbs[cur_bd].skb_dma,
>  					 RX_BUF_SIZE, PCI_DMA_FROMDEVICE);
> @@ -1792,6 +1791,7 @@ tc35815_rx(struct net_device *dev)
>  #ifdef TC35815_USE_PACKEDBUFFER
>  			while (lp->fbl_curid != id)
>  #else
> +			lp->fbl_count--;
>  			while (lp->fbl_count < RX_BUF_NUM)
>  #endif
>  			{
> --
> To unsubscribe from this list: send the line "unsubscribe netdev" in

applied
