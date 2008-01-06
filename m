Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Jan 2008 08:23:16 +0000 (GMT)
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:32696
	"EHLO sunset.davemloft.net") by ftp.linux-mips.org with ESMTP
	id S20023555AbYAFIXI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 6 Jan 2008 08:23:08 +0000
Received: from localhost (localhost [127.0.0.1])
	by sunset.davemloft.net (Postfix) with ESMTP id 14DCFC8C183;
	Sun,  6 Jan 2008 00:23:06 -0800 (PST)
Date:	Sun, 06 Jan 2008 00:23:05 -0800 (PST)
Message-Id: <20080106.002305.99653155.davem@davemloft.net>
To:	tsbogend@alpha.franken.de
Cc:	netdev@vger.kernel.org, linux-mips@linux-mips.org,
	ralf@linux-mips.org, jgarzik@pobox.com
Subject: Re: [PATCH] METH: fix MAC address handling
From:	David Miller <davem@davemloft.net>
In-Reply-To: <20080105224842.78EDCC2EFB@solo.franken.de>
References: <20080105224842.78EDCC2EFB@solo.franken.de>
X-Mailer: Mew version 5.2 on Emacs 22.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17931
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips

From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Date: Sat,  5 Jan 2008 23:48:42 +0100 (CET)

> meth didn't set a valid mac address during probing, but later during
> open. Newer kernel refuse to open device with 00:00:00:00:00:00 as
> mac address -> dead ethernet. This patch sets the mac address in
> the probe function and uses only the mac address from the netdevice
> struct when setting up the hardware.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Applied, thanks.

> +	u64 macaddr;
>  
> -	for (i = 0; i < 6; i++)
> -		dev->dev_addr[i] = o2meth_eaddr[i];
>  	DPRINTK("Loading MAC Address: %s\n", print_mac(mac, dev->dev_addr));
> -	mace->eth.mac_addr = (*(unsigned long*)o2meth_eaddr) >> 16;
> +	macaddr = 0;
> +	for (i = 0; i < 6; i++)
> +		macaddr |= dev->dev_addr[i] << ((5 - i) * 8);
> +
> +	mace->eth.mac_addr = macaddr;
>  }
>  
>  /*

Can you double-check that this conversion is equivalent.

I know that this whole driver is full of assumptions about
the endianness of the system this chip is found on, so
I'm only interested in if the transformation is equivalent
and the driver will keep working properly.

Thanks.
