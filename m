Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Jan 2008 20:02:02 +0000 (GMT)
Received: from srv5.dvmed.net ([207.36.208.214]:8430 "EHLO mail.dvmed.net")
	by ftp.linux-mips.org with ESMTP id S20032350AbYARUBx (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 18 Jan 2008 20:01:53 +0000
Received: from cpe-069-134-071-233.nc.res.rr.com ([69.134.71.233] helo=core.yyz.us)
	by mail.dvmed.net with esmtpsa (Exim 4.66 #1 (Red Hat Linux))
	id 1JFxPS-0007UA-4y; Fri, 18 Jan 2008 20:01:50 +0000
Message-ID: <479105AD.6060201@garzik.org>
Date:	Fri, 18 Jan 2008 15:01:49 -0500
From:	Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
MIME-Version: 1.0
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
CC:	netdev@vger.kernel.org, linux-mips@linux-mips.org,
	ralf@linux-mips.org, jgarzik@pobox.com
Subject: Re: [PATCH] SGISEEQ: fix oops when doing ifconfig down; ifconfig
 up
References: <20080112230847.1EB3EC2F35@solo.franken.de>
In-Reply-To: <20080112230847.1EB3EC2F35@solo.franken.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jeff@garzik.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18096
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jeff@garzik.org
Precedence: bulk
X-list: linux-mips

Thomas Bogendoerfer wrote:
> When doing init_ring checking whether a new skb needs to be allocated
> was wrong.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> ---
> 
> This is a bug fix for the 2.6.25 driver.
> 
>  drivers/net/sgiseeq.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/net/sgiseeq.c b/drivers/net/sgiseeq.c
> index c69bb8b..78994ed 100644
> --- a/drivers/net/sgiseeq.c
> +++ b/drivers/net/sgiseeq.c
> @@ -193,7 +193,7 @@ static int seeq_init_ring(struct net_device *dev)
>  
>  	/* And now the rx ring. */
>  	for (i = 0; i < SEEQ_RX_BUFFERS; i++) {
> -		if (!sp->rx_desc[i].rdma.pbuf) {
> +		if (!sp->rx_desc[i].skb) {
>  			dma_addr_t dma_addr;
>  			struct sk_buff *skb = netdev_alloc_skb(dev, PKT_BUF_SZ);

applied
