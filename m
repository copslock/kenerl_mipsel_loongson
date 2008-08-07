Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Aug 2008 07:12:35 +0100 (BST)
Received: from srv5.dvmed.net ([207.36.208.214]:12483 "EHLO mail.dvmed.net")
	by ftp.linux-mips.org with ESMTP id S20022127AbYHGGM3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 7 Aug 2008 07:12:29 +0100
Received: from cpe-069-134-153-115.nc.res.rr.com ([69.134.153.115] helo=core.yyz.us)
	by mail.dvmed.net with esmtpsa (Exim 4.69 #1 (Red Hat Linux))
	id 1KQyjW-0002Zq-6c; Thu, 07 Aug 2008 06:12:24 +0000
Message-ID: <489A9245.4070105@pobox.com>
Date:	Thu, 07 Aug 2008 02:12:21 -0400
From:	Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
MIME-Version: 1.0
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
CC:	netdev@vger.kernel.org, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [PATCH] METH: fix MAC address setup
References: <20080730231424.CD5E8DEBB8@solo.franken.de>
In-Reply-To: <20080730231424.CD5E8DEBB8@solo.franken.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jgarzik@pobox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20142
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jgarzik@pobox.com
Precedence: bulk
X-list: linux-mips

Thomas Bogendoerfer wrote:
> Setup of the mac filter lost the upper 16bit of the mac address. This
> bug got unconvered by a patch, which fixed the promiscous handling.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> ---
> 
>  drivers/net/meth.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/net/meth.c b/drivers/net/meth.c
> index 4cb364e..0a97c26 100644
> --- a/drivers/net/meth.c
> +++ b/drivers/net/meth.c
> @@ -100,7 +100,7 @@ static inline void load_eaddr(struct net_device *dev)
>  	DPRINTK("Loading MAC Address: %s\n", print_mac(mac, dev->dev_addr));
>  	macaddr = 0;
>  	for (i = 0; i < 6; i++)
> -		macaddr |= dev->dev_addr[i] << ((5 - i) * 8);
> +		macaddr |= (u64)dev->dev_addr[i] << ((5 - i) * 8);

applied
