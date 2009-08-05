Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Aug 2009 21:24:47 +0200 (CEST)
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:54112
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493440AbZHETXn (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 5 Aug 2009 21:23:43 +0200
Received: from localhost (localhost [127.0.0.1])
	by sunset.davemloft.net (Postfix) with ESMTP id AFFF5C8C4B2;
	Wed,  5 Aug 2009 12:23:49 -0700 (PDT)
Date:	Wed, 05 Aug 2009 12:23:49 -0700 (PDT)
Message-Id: <20090805.122349.80542560.davem@davemloft.net>
To:	florian@openwrt.org
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 4/5] cpmac: wait longer after MDIO reset
From:	David Miller <davem@davemloft.net>
In-Reply-To: <200908042252.57848.florian@openwrt.org>
References: <200908042252.57848.florian@openwrt.org>
X-Mailer: Mew version 6.2.51 on Emacs 22.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23846
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips

From: Florian Fainelli <florian@openwrt.org>
Date: Tue, 4 Aug 2009 22:52:57 +0200

> This patch slows down the MDIO_ALIVE busy waiting to let
> switches and PHY come up after reset. Previous loop was
> too quick for IC+175C and ADM6996C/L switches to come up.
> 
> Signed-off-by: Florian Fainelli <florian@openwrt.org>

Applied to net-next-2.6
