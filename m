Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Aug 2009 21:23:58 +0200 (CEST)
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:54103
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493434AbZHETX1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 5 Aug 2009 21:23:27 +0200
Received: from localhost (localhost [127.0.0.1])
	by sunset.davemloft.net (Postfix) with ESMTP id 1630CC8C4B2;
	Wed,  5 Aug 2009 12:23:34 -0700 (PDT)
Date:	Wed, 05 Aug 2009 12:23:33 -0700 (PDT)
Message-Id: <20090805.122333.197124214.davem@davemloft.net>
To:	florian@openwrt.org
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 2/5] ar7: add fixed PHY support for the two on-board
 cpmac
From:	David Miller <davem@davemloft.net>
In-Reply-To: <200908042252.47549.florian@openwrt.org>
References: <200908042252.47549.florian@openwrt.org>
X-Mailer: Mew version 6.2.51 on Emacs 22.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23844
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips

From: Florian Fainelli <florian@openwrt.org>
Date: Tue, 4 Aug 2009 22:52:47 +0200

> This patch adds fixed PHY support for the two on-chip
> cpmac Ethernet adapters.
> 
> Signed-off-by: Florian Fainelli <florian@openwrt.org>

Applied to net-next-2.6
