Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Nov 2009 06:02:27 +0100 (CET)
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:59282
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1491973AbZKIFCU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 9 Nov 2009 06:02:20 +0100
Received: from localhost (localhost [127.0.0.1])
	by sunset.davemloft.net (Postfix) with ESMTP id E519FC8C50C;
	Sun,  8 Nov 2009 21:02:36 -0800 (PST)
Date:	Sun, 08 Nov 2009 21:02:36 -0800 (PST)
Message-Id: <20091108.210236.247950385.davem@davemloft.net>
To:	florian@openwrt.org
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 2/2 net-next-2.6] au1000-eth: convert to
 platform_driver model
From:	David Miller <davem@davemloft.net>
In-Reply-To: <200911081542.12219.florian@openwrt.org>
References: <200911081542.12219.florian@openwrt.org>
X-Mailer: Mew version 6.2.51 on Emacs 22.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24763
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips

From: Florian Fainelli <florian@openwrt.org>
Date: Sun, 8 Nov 2009 15:42:11 +0100

> This patch converts the au1000-eth driver to become a full
> platform-driver as it ought to be. We now pass PHY-speficic
> configurations through platform_data but for compatibility
> the driver still assumes the default settings (search for PHY1 on
> MAC0) when no platform_data is passed. Tested on my MTX-1 board.
> 
> Signed-off-by: Florian Fainelli <florian@openwrt.org>

Ralf, feel free to merge this yourself since it depends upon
the previous Alchemy platform patch:

Acked-by: David S. Miller <davem@davemloft.net>
